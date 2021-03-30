Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRLuI-004vy6-5n
 for kexec@lists.infradead.org; Tue, 30 Mar 2021 21:28:17 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC v2 35/43] shmem: introduce shmem_insert_pages()
Date: Tue, 30 Mar 2021 14:36:10 -0700
Message-Id: <1617140178-8773-36-git-send-email-anthony.yznaga@oracle.com>
In-Reply-To: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
References: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: willy@infradead.org, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org, hughd@google.com, ebiederm@xmission.com, keescook@chromium.org, ardb@kernel.org, nivedita@alum.mit.edu, jroedel@suse.de, masahiroy@kernel.org, nathan@kernel.org, terrelln@fb.com, vincenzo.frascino@arm.com, martin.b.radev@gmail.com, andreyknvl@google.com, daniel.kiper@oracle.com, rafael.j.wysocki@intel.com, dan.j.williams@intel.com, Jonathan.Cameron@huawei.com, bhe@redhat.com, rminnich@gmail.com, ashish.kalra@amd.com, guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org, iamjoonsoo.kim@lge.com, vbabka@suse.cz, alex.shi@linux.alibaba.com, david@redhat.com, richard.weiyang@gmail.com, vdavydov.dev@gmail.com, graf@amazon.com, jason.zeng@intel.com, lei.l.li@intel.com, daniel.m.jordan@oracle.com, steven.sistare@oracle.com, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, kexec@lists.infradead.org

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
 include/linux/shmem_fs.h |  3 +-
 mm/shmem.c               | 93 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 78149d702a62..bc116c4fe145 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -112,7 +112,8 @@ extern int shmem_getpage(struct inode *inode, pgoff_t index,
 
 extern int shmem_insert_page(struct mm_struct *mm, struct inode *inode,
 		pgoff_t index, struct page *page);
-
+extern int shmem_insert_pages(struct mm_struct *mm, struct inode *inode,
+			      pgoff_t index, struct page *pages[], int npages);
 #ifdef CONFIG_PKRAM
 extern int shmem_parse_pkram(const char *str, struct shmem_pkram_info **pkram);
 extern void shmem_show_pkram(struct seq_file *seq, struct shmem_pkram_info *pkram,
diff --git a/mm/shmem.c b/mm/shmem.c
index 44cc158ab34d..c3fa72061d8a 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -838,6 +838,99 @@ int shmem_insert_page(struct mm_struct *mm, struct inode *inode, pgoff_t index,
 	return err;
 }
 
+int shmem_insert_pages(struct mm_struct *charge_mm, struct inode *inode,
+		       pgoff_t index, struct page *pages[], int npages)
+{
+	struct address_space *mapping = inode->i_mapping;
+	struct shmem_inode_info *info = SHMEM_I(inode);
+	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
+	gfp_t gfp = mapping_gfp_mask(mapping);
+	int i, err;
+	int nr = 0;
+
+	for (i = 0; i < npages; i++)
+		nr += thp_nr_pages(pages[i]);
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
+	}
+
+	for (i = 0; i < npages; i++) {
+		bool ischarged = page_memcg(pages[i]) ? true : false;
+
+		err = shmem_add_to_page_cache(pages[i], mapping, index,
+					NULL, gfp & GFP_RECLAIM_MASK,
+					charge_mm, ischarged);
+		if (err)
+			goto out_release;
+
+		index += thp_nr_pages(pages[i]);
+	}
+
+	spin_lock(&info->lock);
+	info->alloced += nr;
+	inode->i_blocks += BLOCKS_PER_PAGE * nr;
+	shmem_recalc_inode(inode);
+	spin_unlock(&info->lock);
+
+	for (i = 0; i < npages; i++) {
+		if (!PageLRU(pages[i]))
+			lru_cache_add(pages[i]);
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
+out_release:
+	while (--i >= 0)
+		delete_from_page_cache(pages[i]);
+
+	for (i = 0; i < npages; i++)
+		unlock_page(pages[i]);
+
+	shmem_inode_unacct_blocks(inode, nr);
+failed:
+	return err;
+}
+
 /*
  * Remove swap entry from page cache, free the swap and its page cache.
  */
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
