Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WwjGA-0002DS-Cu
 for kexec@lists.infradead.org; Tue, 17 Jun 2014 02:36:31 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.197])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id s5H2a5aG003147
 for <kexec@lists.infradead.org>; Tue, 17 Jun 2014 11:36:05 +0900 (JST)
Received: from mailsv3.nec.co.jp (imss63.nec.co.jp [10.7.69.158]) by
 mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC) with ESMTP
 id s5H2a5E08584 for <kexec@lists.infradead.org>;
 Tue, 17 Jun 2014 11:36:05 +0900 (JST)
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
 by mailsv3.nec.co.jp (8.13.8/8.13.4) with ESMTP id s5H2a5fk021112
 for <kexec@lists.infradead.org>; Tue, 17 Jun 2014 11:36:05 +0900 (JST)
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [PATCH v2] makedumpfile: Exclude unnecessary hugepages.
Date: Tue, 17 Jun 2014 02:32:51 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9722301C@BPXM01GP.gisp.nec.co.jp>
Content-Language: ja-JP
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
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello,

This is the v2 patch for hugepage filtering rebased on Petr's
"Generic multi-page exclusion", thanks Petr.

The current kernel's VMCOREINFO doesn't include necessary values
for this patch, so we need "-x vmlinux" to enable hugepage filtering.
I tested this patch on kernel 3.13.

Regarding this, Petr made effort to add the values to VMCOREINFO,
but it looks suspended:

  https://lkml.org/lkml/2014/4/11/349

So, we should resume this discussion for this patch. Then,
I should modify this patch to use PG_head_mask if it's accepted.


Thanks
Atsushi Kumagai


From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Date: Tue, 17 Jun 2014 08:59:44 +0900
Subject: [PATCH v2] Exclude unnecessary hugepages.

There are 2 types of hugepages in the kernel, the both should be
excluded as user pages.

1. Transparent huge pages (THP)
All the pages are anonymous pages (at least for now), so we should
just get how many pages are in the corresponding hugepage.
It can be gotten from the page->lru.prev of the second page in the
hugepage.

2. Hugetlbfs pages
The pages aren't anonymous pages but kind of user pages, we should
exclude also these pages in any way.
Luckily, it's possible to detect these pages by looking the
page->lru.next of the second page in the hugepage. This idea came
from the kernel's PageHuge().
The number of pages can be gotten in the same way as THP.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.c | 117 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 makedumpfile.h |   8 ++++
 2 files changed, 120 insertions(+), 5 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 34db997..d170c54 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -92,6 +92,7 @@ do { \
 } while (0)
 
 static void setup_page_is_buddy(void);
+static void setup_page_is_hugepage(void);
 
 void
 initialize_tables(void)
@@ -328,6 +329,18 @@ update_mmap_range(off_t offset, int initial) {
 }
 
 static int
+page_is_hugepage(unsigned long flags) {
+	if (NUMBER(PG_head) != NOT_FOUND_NUMBER) {
+		return isHead(flags);
+	} else if (NUMBER(PG_tail) != NOT_FOUND_NUMBER) {
+		return isTail(flags);
+	}if (NUMBER(PG_compound) != NOT_FOUND_NUMBER) {
+		return isCompound(flags);
+	}
+	return 0;
+}
+
+static int
 is_mapped_with_mmap(off_t offset) {
 
 	if (info->flag_usemmap == MMAP_ENABLE
@@ -1180,6 +1193,7 @@ get_symbol_info(void)
 	SYMBOL_INIT(vmemmap_list, "vmemmap_list");
 	SYMBOL_INIT(mmu_psize_defs, "mmu_psize_defs");
 	SYMBOL_INIT(mmu_vmemmap_psize, "mmu_vmemmap_psize");
+	SYMBOL_INIT(free_huge_page, "free_huge_page");
 
 	return TRUE;
 }
@@ -1288,11 +1302,19 @@ get_structure_info(void)
 
 	ENUM_NUMBER_INIT(PG_lru, "PG_lru");
 	ENUM_NUMBER_INIT(PG_private, "PG_private");
+	ENUM_NUMBER_INIT(PG_head, "PG_head");
+	ENUM_NUMBER_INIT(PG_tail, "PG_tail");
+	ENUM_NUMBER_INIT(PG_compound, "PG_compound");
 	ENUM_NUMBER_INIT(PG_swapcache, "PG_swapcache");
 	ENUM_NUMBER_INIT(PG_buddy, "PG_buddy");
 	ENUM_NUMBER_INIT(PG_slab, "PG_slab");
 	ENUM_NUMBER_INIT(PG_hwpoison, "PG_hwpoison");
 
+	if (NUMBER(PG_head) == NOT_FOUND_NUMBER &&
+	    NUMBER(PG_compound) == NOT_FOUND_NUMBER)
+		/* Pre-2.6.26 kernels did not have pageflags */
+		NUMBER(PG_compound) = PG_compound_ORIGINAL;
+
 	ENUM_TYPE_SIZE_INIT(pageflags, "pageflags");
 
 	TYPEDEF_SIZE_INIT(nodemask_t, "nodemask_t");
@@ -1694,6 +1716,7 @@ write_vmcoreinfo_data(void)
 	WRITE_SYMBOL("vmemmap_list", vmemmap_list);
 	WRITE_SYMBOL("mmu_psize_defs", mmu_psize_defs);
 	WRITE_SYMBOL("mmu_vmemmap_psize", mmu_vmemmap_psize);
+	WRITE_SYMBOL("free_huge_page", free_huge_page);
 
 	/*
 	 * write the structure size of 1st kernel
@@ -1783,6 +1806,9 @@ write_vmcoreinfo_data(void)
 
 	WRITE_NUMBER("PG_lru", PG_lru);
 	WRITE_NUMBER("PG_private", PG_private);
+	WRITE_NUMBER("PG_head", PG_head);
+	WRITE_NUMBER("PG_tail", PG_tail);
+	WRITE_NUMBER("PG_compound", PG_compound);
 	WRITE_NUMBER("PG_swapcache", PG_swapcache);
 	WRITE_NUMBER("PG_buddy", PG_buddy);
 	WRITE_NUMBER("PG_slab", PG_slab);
@@ -2033,6 +2059,7 @@ read_vmcoreinfo(void)
 	READ_SYMBOL("vmemmap_list", vmemmap_list);
 	READ_SYMBOL("mmu_psize_defs", mmu_psize_defs);
 	READ_SYMBOL("mmu_vmemmap_psize", mmu_vmemmap_psize);
+	READ_SYMBOL("free_huge_page", free_huge_page);
 
 	READ_STRUCTURE_SIZE("page", page);
 	READ_STRUCTURE_SIZE("mem_section", mem_section);
@@ -2109,6 +2136,9 @@ read_vmcoreinfo(void)
 
 	READ_NUMBER("PG_lru", PG_lru);
 	READ_NUMBER("PG_private", PG_private);
+	READ_NUMBER("PG_head", PG_head);
+	READ_NUMBER("PG_tail", PG_tail);
+	READ_NUMBER("PG_compound", PG_compound);
 	READ_NUMBER("PG_swapcache", PG_swapcache);
 	READ_NUMBER("PG_slab", PG_slab);
 	READ_NUMBER("PG_buddy", PG_buddy);
@@ -3283,6 +3313,9 @@ out:
 	if (!get_value_for_old_linux())
 		return FALSE;
 
+	/* Get page flags for compound pages */
+	setup_page_is_hugepage();
+
 	/* use buddy identification of free pages whether cyclic or not */
 	/* (this can reduce pages scan of 1TB memory from 60sec to 30sec) */
 	if (info->dump_level & DL_EXCLUDE_FREE)
@@ -4346,6 +4379,24 @@ out:
 			  "follow free lists instead of mem_map array.\n");
 }
 
+static void
+setup_page_is_hugepage(void)
+{
+	if (NUMBER(PG_head) != NOT_FOUND_NUMBER) {
+		if (NUMBER(PG_tail) == NOT_FOUND_NUMBER) {
+			/*
+			 * If PG_tail is not explicitly saved, then assume
+			 * that it immediately follows PG_head.
+			 */
+			NUMBER(PG_tail) = NUMBER(PG_head) + 1;
+		}
+	} else if ((NUMBER(PG_compound) != NOT_FOUND_NUMBER)
+		   && (info->dump_level & DL_EXCLUDE_USER_DATA)) {
+		MSG("Compound page bit could not be determined: ");
+		MSG("huge pages will NOT be filtered.\n");
+	}
+}
+
 /*
  * If using a dumpfile in kdump-compressed format as a source file
  * instead of /proc/vmcore, 1st-bitmap of a new dumpfile must be
@@ -4660,8 +4711,9 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 	mdf_pfn_t pfn_read_start, pfn_read_end;
 	unsigned char page_cache[SIZE(page) * PGMM_CACHED];
 	unsigned char *pcache;
-	unsigned int _count, _mapcount = 0;
+	unsigned int _count, _mapcount = 0, compound_order = 0;
 	unsigned long flags, mapping, private = 0;
+	unsigned long hugetlb_dtor;
 
 	/*
 	 * If a multi-page exclusion is pending, do it first
@@ -4727,6 +4779,27 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 		flags   = ULONG(pcache + OFFSET(page.flags));
 		_count  = UINT(pcache + OFFSET(page._count));
 		mapping = ULONG(pcache + OFFSET(page.mapping));
+
+		if (index_pg < PGMM_CACHED - 1) {
+			compound_order = ULONG(pcache + SIZE(page) + OFFSET(page.lru)
+					       + OFFSET(list_head.prev));
+			hugetlb_dtor = ULONG(pcache + SIZE(page) + OFFSET(page.lru)
+					     + OFFSET(list_head.next));
+		} else if (pfn + 1 < pfn_end) {
+			unsigned char page_cache_next[SIZE(page)];
+			if (!readmem(VADDR, mem_map, page_cache_next, SIZE(page))) {
+				ERRMSG("Can't read the buffer of struct page.\n");
+				return FALSE;
+			}
+			compound_order = ULONG(page_cache_next + OFFSET(page.lru)
+					       + OFFSET(list_head.prev));
+			hugetlb_dtor = ULONG(page_cache_next + OFFSET(page.lru)
+					     + OFFSET(list_head.next));
+		} else {
+			compound_order = 0;
+			hugetlb_dtor = 0;
+		}
+
 		if (OFFSET(page._mapcount) != NOT_FOUND_STRUCTURE)
 			_mapcount = UINT(pcache + OFFSET(page._mapcount));
 		if (OFFSET(page.private) != NOT_FOUND_STRUCTURE)
@@ -4754,6 +4827,10 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 		    && !isPrivate(flags) && !isAnon(mapping)) {
 			if (clear_bit_on_2nd_bitmap_for_kernel(pfn, cycle))
 				pfn_cache++;
+			/*
+			 * NOTE: If THP for cache is introduced, the check for
+			 *       compound pages is needed here.
+			 */
 		}
 		/*
 		 * Exclude the cache page with the private page.
@@ -4763,14 +4840,44 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 		    && !isAnon(mapping)) {
 			if (clear_bit_on_2nd_bitmap_for_kernel(pfn, cycle))
 				pfn_cache_private++;
+			/*
+			 * NOTE: If THP for cache is introduced, the check for
+			 *       compound pages is needed here.
+			 */
 		}
 		/*
 		 * Exclude the data page of the user process.
 		 */
-		else if ((info->dump_level & DL_EXCLUDE_USER_DATA)
-		    && isAnon(mapping)) {
-			if (clear_bit_on_2nd_bitmap_for_kernel(pfn, cycle))
-				pfn_user++;
+		else if (info->dump_level & DL_EXCLUDE_USER_DATA) {
+			/*
+			 * Exclude the anonymous pages as user pages.
+			 */
+			if (isAnon(mapping)) {
+				int nr_pages;
+				/*
+				 * Check the compound page
+				 */
+				if (page_is_hugepage(flags) && compound_order > 0)
+					nr_pages = 1 << compound_order;
+				else
+					nr_pages = 1;
+
+				exclude_range(&pfn_user, pfn, pfn + nr_pages, cycle);
+
+				pfn += nr_pages - 1;
+				mem_map += (nr_pages - 1) * SIZE(page);
+			}
+			/*
+			 * Exclude the hugetlbfs pages as user pages.
+			 */
+			else if (hugetlb_dtor == SYMBOL(free_huge_page)) {
+				int nr_pages = 1 << compound_order;
+
+				exclude_range(&pfn_user, pfn, pfn + nr_pages, cycle);
+
+				pfn += nr_pages - 1;
+				mem_map += (nr_pages - 1) * SIZE(page);
+			}
 		}
 		/*
 		 * Exclude the hwpoison page.
diff --git a/makedumpfile.h b/makedumpfile.h
index 9402f05..d5ebf3c 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -74,6 +74,7 @@ int get_mem_type(void);
 #define PG_lru_ORIGINAL	 	(5)
 #define PG_slab_ORIGINAL	(7)
 #define PG_private_ORIGINAL	(11)	/* Has something at ->private */
+#define PG_compound_ORIGINAL	(14)	/* Is part of a compound page */
 #define PG_swapcache_ORIGINAL	(15)	/* Swap page: swp_entry_t in private */
 
 #define PAGE_BUDDY_MAPCOUNT_VALUE_v2_6_38	(-2)
@@ -148,6 +149,9 @@ test_bit(int nr, unsigned long addr)
 
 #define isLRU(flags)		test_bit(NUMBER(PG_lru), flags)
 #define isPrivate(flags)	test_bit(NUMBER(PG_private), flags)
+#define isHead(flags)		test_bit(NUMBER(PG_head), flags)
+#define isTail(flags)		test_bit(NUMBER(PG_tail), flags)
+#define isCompound(flags)	test_bit(NUMBER(PG_compound), flags)
 #define isSwapCache(flags)	test_bit(NUMBER(PG_swapcache), flags)
 #define isHWPOISON(flags)	(test_bit(NUMBER(PG_hwpoison), flags) \
 				&& (NUMBER(PG_hwpoison) != NOT_FOUND_NUMBER))
@@ -1143,6 +1147,7 @@ struct symbol_table {
 	unsigned long long	node_remap_start_vaddr;
 	unsigned long long	node_remap_end_vaddr;
 	unsigned long long	node_remap_start_pfn;
+	unsigned long long      free_huge_page;
 
 	/*
 	 * for Xen extraction
@@ -1428,6 +1433,9 @@ struct number_table {
 	 */
 	long	PG_lru;
 	long	PG_private;
+	long	PG_head;
+	long	PG_tail;
+	long	PG_compound;
 	long	PG_swapcache;
 	long	PG_buddy;
 	long	PG_slab;
-- 
1.9.0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
