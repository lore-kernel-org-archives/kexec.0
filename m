Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWUfN-0003hg-JW
 for kexec@lists.infradead.org; Thu, 07 May 2020 00:45:36 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC 35/43] shmem: introduce shmem_insert_pages()
Date: Wed,  6 May 2020 17:42:01 -0700
Message-Id: <1588812129-8596-36-git-send-email-anthony.yznaga@oracle.com>
In-Reply-To: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, linux-doc@vger.kernel.org, gustavo@embeddedor.com, peterz@infradead.org, kexec@lists.infradead.org, paul.c.lai@intel.com, dave.hansen@linux.intel.com, mhocko@kernel.org, lei.l.li@intel.com, nivedita@alum.mit.edu, ziqian.lzq@antfin.com, hpa@zytor.com, ardb@kernel.org, ashok.raj@intel.com, bhe@redhat.com, corbet@lwn.net, masahiroy@kernel.org, rafael.j.wysocki@intel.com, hughd@google.com, willy@infradead.org, rppt@linux.ibm.com, mingo@redhat.com, vdavydov.dev@gmail.com, ying.huang@intel.com, Thomas.Lendacky@amd.com, kevin.tian@intel.com, jroedel@suse.de, keescook@chromium.org, dan.j.williams@intel.com, bp@alien8.de, zhiyuan.lv@intel.com, luto@kernel.org, tglx@linutronix.de, andriy.shevchenko@linux.intel.com, dima@golovin.in, yang.shi@linux.alibaba.com, ndesaulniers@google.com, zhenzhong.duan@oracle.com, guro@fb.com, minchan@kernel.org, ebiederm@xmission.com, jason.zeng@intel.com, hannes@cmpxchg.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, daniel.kiper@oracle.com

Calling shmem_insert_page() to insert one page at a time does
not scale well when multiple threads are inserting pages into
the same shmem segment.  This is primarily due to the locking needed
when adding to the pagecache and LRU but also due to contention
on the shmem_inode_info lock. To address the shmem_inode_info lock
and prepare for future optimizations, introduce shmem_insert_pages()
which allows a caller to pass an array of pages to be inserted into a
shmem segment.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/shmem_fs.h |   3 +-
 mm/shmem.c               | 114 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index f2ce9937a8f2..d308a6a154b6 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -105,7 +105,8 @@ extern int shmem_getpage(struct inode *inode, pgoff_t index,
 
 extern int shmem_insert_page(struct mm_struct *mm, struct inode *inode,
 		pgoff_t index, struct page *page);
-
+extern int shmem_insert_pages(struct mm_struct *mm, struct inode *inode,
+			      pgoff_t index, struct page *pages[], int npages);
 #ifdef CONFIG_PKRAM
 extern int shmem_parse_pkram(const char *str, struct shmem_pkram_info **pkram);
 extern void shmem_show_pkram(struct seq_file *seq, struct shmem_pkram_info *pkram,
diff --git a/mm/shmem.c b/mm/shmem.c
index 1f3b43b8fa34..ca5edf580f24 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -781,6 +781,120 @@ int shmem_insert_page(struct mm_struct *mm, struct inode *inode, pgoff_t index,
 	return err;
 }
 
+int shmem_insert_pages(struct mm_struct *mm, struct inode *inode, pgoff_t index,
+		       struct page *pages[], int npages)
+{
+	struct address_space *mapping = inode->i_mapping;
+	struct shmem_inode_info *info = SHMEM_I(inode);
+	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
+	gfp_t gfp = mapping_gfp_mask(mapping);
+	struct mem_cgroup *memcg;
+	int i, err;
+	int nr = 0;
+
+	for (i = 0; i < npages; i++)
+		nr += compound_nr(pages[i]);
+
+	if (index + nr - 1 > (MAX_LFS_FILESIZE >> PAGE_SHIFT))
+		return -EFBIG;
+
+retry:
+	err = 0;
+	if (!shmem_inode_acct_block(inode, nr))
+		err = -ENOSPC;
+	if (err) {
+		int retry = 5;
+
+		/*
+		 * Try to reclaim some space by splitting a huge page
+		 * beyond i_size on the filesystem.
+		 */
+		while (retry--) {
+			int ret;
+
+			ret = shmem_unused_huge_shrink(sbinfo, NULL, 1);
+			if (ret == SHRINK_STOP)
+				break;
+			if (ret)
+				goto retry;
+		}
+		goto failed;
+	}
+
+	for (i = 0; i < npages; i++) {
+		if (!PageLRU(pages[i])) {
+			__SetPageLocked(pages[i]);
+			__SetPageSwapBacked(pages[i]);
+		} else {
+			lock_page(pages[i]);
+		}
+
+		__SetPageReferenced(pages[i]);
+
+		if (pages[i]->mem_cgroup)
+			continue;
+
+		err = mem_cgroup_try_charge_delay(pages[i], mm, gfp,
+					&memcg, PageTransHuge(pages[i]));
+		if (err)
+			goto out_unlock;
+
+	}
+
+	for (i = 0; i < npages; i++) {
+		err = shmem_add_to_page_cache(pages[i], mapping, index,
+					NULL, gfp & GFP_RECLAIM_MASK);
+		if (err)
+			goto out_truncate;
+
+		if (PageTransHuge(pages[i]))
+			index += HPAGE_PMD_NR;
+		else
+			index++;
+	}
+
+	spin_lock(&info->lock);
+	info->alloced += nr;
+	inode->i_blocks += BLOCKS_PER_PAGE * nr;
+	shmem_recalc_inode(inode);
+	spin_unlock(&info->lock);
+
+	for (i = 0; i < npages; i++) {
+		if (!pages[i]->mem_cgroup) {
+			mem_cgroup_commit_charge(pages[i], memcg,
+				PageLRU(pages[i]), PageTransHuge(pages[i]));
+		}
+
+		if (!PageLRU(pages[i]))
+			lru_cache_add_anon(pages[i]);
+
+		flush_dcache_page(pages[i]);
+		SetPageUptodate(pages[i]);
+		set_page_dirty(pages[i]);
+
+		unlock_page(pages[i]);
+	}
+
+	return 0;
+
+out_truncate:
+	while (--i >= 0)
+		truncate_inode_page(mapping, pages[i]);
+	i = npages;
+out_unlock:
+	while (--i >= 0) {
+		if (!pages[i]->mem_cgroup) {
+			mem_cgroup_cancel_charge(pages[i], memcg,
+				PageTransHuge(pages[i]));
+		}
+
+		unlock_page(pages[i]);
+	}
+	shmem_inode_unacct_blocks(inode, nr);
+failed:
+	return err;
+}
+
 /*
  * Remove swap entry from page cache, free the swap and its page cache.
  */
-- 
2.13.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
