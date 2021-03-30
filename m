Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2120.oracle.com ([156.151.31.85])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRLte-004vko-PP
 for kexec@lists.infradead.org; Tue, 30 Mar 2021 21:27:39 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC v2 27/43] mm: shmem: when inserting,
 handle pages already charged to a memcg
Date: Tue, 30 Mar 2021 14:36:02 -0700
Message-Id: <1617140178-8773-28-git-send-email-anthony.yznaga@oracle.com>
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

If shmem_insert_page() is called to insert a page that was preserved
using PKRAM on the current boot (i.e. preserved page is restored without
an intervening kexec boot), the page will still be charged to a memory
cgroup because it is never freed. Don't try to charge it again.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/shmem.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 8dfe80aeee97..44cc158ab34d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -671,7 +671,7 @@ static inline bool is_huge_enabled(struct shmem_sb_info *sbinfo)
 static int shmem_add_to_page_cache(struct page *page,
 				   struct address_space *mapping,
 				   pgoff_t index, void *expected, gfp_t gfp,
-				   struct mm_struct *charge_mm)
+				   struct mm_struct *charge_mm, bool skipcharge)
 {
 	XA_STATE_ORDER(xas, &mapping->i_pages, index, compound_order(page));
 	unsigned long i = 0;
@@ -688,7 +688,7 @@ static int shmem_add_to_page_cache(struct page *page,
 	page->mapping = mapping;
 	page->index = index;
 
-	if (!PageSwapCache(page)) {
+	if (!skipcharge && !PageSwapCache(page)) {
 		error = mem_cgroup_charge(page, charge_mm, gfp);
 		if (error) {
 			if (PageTransHuge(page)) {
@@ -770,6 +770,7 @@ int shmem_insert_page(struct mm_struct *mm, struct inode *inode, pgoff_t index,
 	int nr;
 	pgoff_t hindex = index;
 	bool on_lru = PageLRU(page);
+	bool ischarged = page_memcg(page) ? true : false;
 
 	if (index > (MAX_LFS_FILESIZE >> PAGE_SHIFT))
 		return -EFBIG;
@@ -809,7 +810,8 @@ int shmem_insert_page(struct mm_struct *mm, struct inode *inode, pgoff_t index,
 	__SetPageReferenced(page);
 
 	err = shmem_add_to_page_cache(page, mapping, hindex,
-				      NULL, gfp & GFP_RECLAIM_MASK, mm);
+				      NULL, gfp & GFP_RECLAIM_MASK,
+				      mm, ischarged);
 	if (err)
 		goto out_unlock;
 
@@ -1829,7 +1831,7 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
 
 	error = shmem_add_to_page_cache(page, mapping, index,
 					swp_to_radix_entry(swap), gfp,
-					charge_mm);
+					charge_mm, false);
 	if (error)
 		goto failed;
 
@@ -2009,7 +2011,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 
 	error = shmem_add_to_page_cache(page, mapping, hindex,
 					NULL, gfp & GFP_RECLAIM_MASK,
-					charge_mm);
+					charge_mm, false);
 	if (error)
 		goto unacct;
 	lru_cache_add(page);
@@ -2500,7 +2502,7 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 		goto out_release;
 
 	ret = shmem_add_to_page_cache(page, mapping, pgoff, NULL,
-				      gfp & GFP_RECLAIM_MASK, dst_mm);
+				      gfp & GFP_RECLAIM_MASK, dst_mm, false);
 	if (ret)
 		goto out_release;
 
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
