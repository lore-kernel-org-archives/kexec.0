Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWUeW-0000AB-IC
 for kexec@lists.infradead.org; Thu, 07 May 2020 00:44:42 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC 22/43] mm: shmem: introduce shmem_insert_page
Date: Wed,  6 May 2020 17:41:48 -0700
Message-Id: <1588812129-8596-23-git-send-email-anthony.yznaga@oracle.com>
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

The function inserts a page into a shmem file at a specified offset.
The page can be a regular PAGE_SIZE page or a transparent huge page.
If there is something at the offset (page or swap), the function fails.

The function will be used by the next patch.

Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/shmem_fs.h |  3 ++
 mm/shmem.c               | 95 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 7a35a6901221..688b92cd4ec7 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -96,6 +96,9 @@ enum sgp_type {
 extern int shmem_getpage(struct inode *inode, pgoff_t index,
 		struct page **pagep, enum sgp_type sgp);
 
+extern int shmem_insert_page(struct mm_struct *mm, struct inode *inode,
+		pgoff_t index, struct page *page);
+
 static inline struct page *shmem_read_mapping_page(
 				struct address_space *mapping, pgoff_t index)
 {
diff --git a/mm/shmem.c b/mm/shmem.c
index bd8840082c94..0a9a2166e51f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -677,6 +677,101 @@ static void shmem_delete_from_page_cache(struct page *page, void *radswap)
 	BUG_ON(error);
 }
 
+int shmem_insert_page(struct mm_struct *mm, struct inode *inode, pgoff_t index,
+		      struct page *page)
+{
+	struct address_space *mapping = inode->i_mapping;
+	struct shmem_inode_info *info = SHMEM_I(inode);
+	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
+	gfp_t gfp = mapping_gfp_mask(mapping);
+	int err;
+	int nr = 1;
+	struct mem_cgroup *memcg;
+	pgoff_t hindex = index;
+	bool on_lru = PageLRU(page);
+
+	if (index > (MAX_LFS_FILESIZE >> PAGE_SHIFT))
+		return -EFBIG;
+
+	if (PageTransHuge(page))
+		nr = HPAGE_PMD_NR;
+	else
+		nr = 1;
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
+	if (!on_lru) {
+		__SetPageLocked(page);
+		__SetPageSwapBacked(page);
+	} else {
+		lock_page(page);
+	}
+
+	if (PageTransHuge(page))
+		hindex = round_down(index, HPAGE_PMD_NR);
+	else
+		hindex = index;
+
+	__SetPageReferenced(page);
+
+	err = mem_cgroup_try_charge_delay(page, mm, gfp, &memcg,
+					PageTransHuge(page));
+	if (err)
+		goto out_unlock;
+
+	err = shmem_add_to_page_cache(page, mapping, hindex,
+					NULL, gfp & GFP_RECLAIM_MASK);
+	if (err) {
+		mem_cgroup_cancel_charge(page, memcg,
+			PageTransHuge(page));
+		goto out_unlock;
+	}
+	mem_cgroup_commit_charge(page, memcg, on_lru,
+			PageTransHuge(page));
+
+	if (!on_lru)
+		lru_cache_add_anon(page);
+
+	spin_lock(&info->lock);
+	info->alloced += compound_nr(page);
+	inode->i_blocks += BLOCKS_PER_PAGE << compound_order(page);
+	shmem_recalc_inode(inode);
+	spin_unlock(&info->lock);
+
+	flush_dcache_page(page);
+	SetPageUptodate(page);
+	set_page_dirty(page);
+
+	unlock_page(page);
+	return 0;
+
+out_unlock:
+	unlock_page(page);
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
