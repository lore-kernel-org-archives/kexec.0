Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VwWJ4-00078h-QL
 for kexec@lists.infradead.org; Fri, 27 Dec 2013 12:14:25 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH] makedumpfile: clean up draft patch
Date: Fri, 27 Dec 2013 20:12:58 +0800
Message-Id: <1388146378-25419-1-git-send-email-bhe@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: d.hatayama@jp.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp, Baoquan He <bhe@redhat.com>

Introduce the struct cycle as below just as Hatamaya expected.
struct cycle {
        uint64_t start_pfn;
        uint64_t end_pfn;
};

  for (first_cycle(start, max, C); !end_cycle(max, C); \
       update_cycle(max, C))

Hi Atsushi and HATAYAMA,

Please help review this draft patch and check if there's any potentia
risk. If you think this is in the right way, I can post a formal
patchset. I just test the normal operation on kdump and elf format,
it works well.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 makedumpfile.c | 499 ++++++++++++++++++++++++++++-----------------------------
 makedumpfile.h |  19 ++-
 sadump_info.c  |   4 +-
 3 files changed, 261 insertions(+), 261 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index ef08d91..89dac8b 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -37,6 +37,33 @@ struct DumpInfo		*info = NULL;
 
 char filename_stdout[] = FILENAME_STDOUT;
 
+static void first_cycle(unsigned long long start, unsigned long long max, struct cycle *cycle)
+{
+	cycle->start_pfn= start;
+	cycle->end_pfn= info->pfn_cyclic;
+
+	if (cycle->end_pfn > max)
+		cycle->end_pfn = max;
+}
+
+static void update_cycle(unsigned long long max, struct cycle *cycle)
+{
+	cycle->start_pfn= cycle->end_pfn + 1;
+	cycle->end_pfn=  cycle->start_pfn + info->pfn_cyclic;
+
+	if (cycle->end_pfn > max)
+		cycle->end_pfn = max;
+}
+
+static int end_cycle(unsigned long long max, struct cycle *cycle)
+{
+	return (cycle->start_pfn > max)?TRUE:FALSE;
+}
+
+#define for_each_cycle(start, max, C) \
+  for (first_cycle(start, max, C); !end_cycle(max, C); \
+       update_cycle(max, C))
+
 /*
  * The numbers of the excluded pages
  */
@@ -179,7 +206,7 @@ is_in_same_page(unsigned long vaddr1, unsigned long vaddr2)
 
 #define BITMAP_SECT_LEN 4096
 static inline int is_dumpable(struct dump_bitmap *, unsigned long long);
-static inline int is_dumpable_cyclic(char *bitmap, unsigned long long);
+static inline int is_dumpable_cyclic(char *bitmap, unsigned long long, struct cycle *cycle);
 unsigned long
 pfn_to_pos(unsigned long long pfn)
 {
@@ -3274,18 +3301,15 @@ set_bitmap(struct dump_bitmap *bitmap, unsigned long long pfn,
 }
 
 int
-set_bitmap_cyclic(char *bitmap, unsigned long long pfn, int val)
+set_bitmap_cyclic(char *bitmap, unsigned long long pfn, int val, struct cycle *cycle)
 {
 	int byte, bit;
 
-	if (pfn < info->cyclic_start_pfn || info->cyclic_end_pfn <= pfn)
-		return FALSE;
-
 	/*
 	 * If val is 0, clear bit on the bitmap.
 	 */
-	byte = (pfn - info->cyclic_start_pfn)>>3;
-	bit  = (pfn - info->cyclic_start_pfn) & 7;
+	byte = (pfn - cycle->start_pfn)>>3;
+	bit  = (pfn - cycle->start_pfn) & 7;
 	if (val)
 		bitmap[byte] |= 1<<bit;
 	else
@@ -3334,37 +3358,37 @@ sync_2nd_bitmap(void)
 }
 
 int
-set_bit_on_1st_bitmap(unsigned long long pfn)
+set_bit_on_1st_bitmap(unsigned long long pfn, struct cycle *cycle)
 {
 	if (info->flag_cyclic) {
-		return set_bitmap_cyclic(info->partial_bitmap1, pfn, 1);
+		return set_bitmap_cyclic(info->partial_bitmap1, pfn, 1, cycle);
 	} else {
 		return set_bitmap(info->bitmap1, pfn, 1);
 	}
 }
 
 int
-clear_bit_on_1st_bitmap(unsigned long long pfn)
+clear_bit_on_1st_bitmap(unsigned long long pfn, struct cycle *cycle)
 {
 	if (info->flag_cyclic) {
-		return set_bitmap_cyclic(info->partial_bitmap1, pfn, 0);
+		return set_bitmap_cyclic(info->partial_bitmap1, pfn, 0, cycle);
 	} else {
 		return set_bitmap(info->bitmap1, pfn, 0);
 	}
 }
 
 int
-clear_bit_on_2nd_bitmap(unsigned long long pfn)
+clear_bit_on_2nd_bitmap(unsigned long long pfn, struct cycle *cycle)
 {
 	if (info->flag_cyclic) {
-		return set_bitmap_cyclic(info->partial_bitmap2, pfn, 0);
+		return set_bitmap_cyclic(info->partial_bitmap2, pfn, 0, cycle);
 	} else {
 		return set_bitmap(info->bitmap2, pfn, 0);
 	}
 }
 
 int
-clear_bit_on_2nd_bitmap_for_kernel(unsigned long long pfn)
+clear_bit_on_2nd_bitmap_for_kernel(unsigned long long pfn, struct cycle *cycle)
 {
 	unsigned long long maddr;
 
@@ -3377,21 +3401,21 @@ clear_bit_on_2nd_bitmap_for_kernel(unsigned long long pfn)
 		}
 		pfn = paddr_to_pfn(maddr);
 	}
-	return clear_bit_on_2nd_bitmap(pfn);
+	return clear_bit_on_2nd_bitmap(pfn, cycle);
 }
 
 int
-set_bit_on_2nd_bitmap(unsigned long long pfn)
+set_bit_on_2nd_bitmap(unsigned long long pfn, struct cycle *cycle)
 {
 	if (info->flag_cyclic) {
-		return set_bitmap_cyclic(info->partial_bitmap2, pfn, 1);
+		return set_bitmap_cyclic(info->partial_bitmap2, pfn, 1, cycle);
 	} else {
 		return set_bitmap(info->bitmap2, pfn, 1);
 	}
 }
 
 int
-set_bit_on_2nd_bitmap_for_kernel(unsigned long long pfn)
+set_bit_on_2nd_bitmap_for_kernel(unsigned long long pfn, struct cycle *cycle)
 {
 	unsigned long long maddr;
 
@@ -3404,7 +3428,7 @@ set_bit_on_2nd_bitmap_for_kernel(unsigned long long pfn)
 		}
 		pfn = paddr_to_pfn(maddr);
 	}
-	return set_bit_on_2nd_bitmap(pfn);
+	return set_bit_on_2nd_bitmap(pfn, cycle);
 }
 
 static inline int
@@ -3730,7 +3754,7 @@ page_to_pfn(unsigned long page)
 }
 
 int
-reset_bitmap_of_free_pages(unsigned long node_zones)
+reset_bitmap_of_free_pages(unsigned long node_zones, struct cycle *cycle)
 {
 
 	int order, i, migrate_type, migrate_types;
@@ -3776,7 +3800,7 @@ reset_bitmap_of_free_pages(unsigned long node_zones)
 				}
 				for (i = 0; i < (1<<order); i++) {
 					pfn = start_pfn + i;
-					if (clear_bit_on_2nd_bitmap_for_kernel(pfn))
+					if (clear_bit_on_2nd_bitmap_for_kernel(pfn, cycle))
 						found_free_pages++;
 				}
 
@@ -4073,7 +4097,7 @@ out:
 
 
 int
-_exclude_free_page(void)
+_exclude_free_page(struct cycle *cycle)
 {
 	int i, nr_zones, num_nodes, node;
 	unsigned long node_zones, zone, spanned_pages, pgdat;
@@ -4114,7 +4138,7 @@ _exclude_free_page(void)
 			}
 			if (!spanned_pages)
 				continue;
-			if (!reset_bitmap_of_free_pages(zone))
+			if (!reset_bitmap_of_free_pages(zone, cycle))
 				return FALSE;
 		}
 		if (num_nodes < vt.numnodes) {
@@ -4139,7 +4163,7 @@ _exclude_free_page(void)
 }
 
 int
-exclude_free_page(void)
+exclude_free_page(struct cycle *cycle)
 {
 	/*
 	 * Check having necessary information.
@@ -4174,7 +4198,7 @@ exclude_free_page(void)
 	/*
 	 * Detect free pages and update 2nd-bitmap.
 	 */
-	if (!_exclude_free_page())
+	if (!_exclude_free_page(cycle))
 		return FALSE;
 
 	return TRUE;
@@ -4379,7 +4403,7 @@ create_1st_bitmap(void)
 		pfn_end   = paddr_to_pfn(phys_end);
 
 		for (pfn = pfn_start; pfn < pfn_end; pfn++) {
-			set_bit_on_1st_bitmap(pfn);
+			set_bit_on_1st_bitmap(pfn, NULL);
 			pfn_bitmap1++;
 		}
 	}
@@ -4397,8 +4421,9 @@ create_1st_bitmap(void)
 	return TRUE;
 }
 
+
 int
-create_1st_bitmap_cyclic()
+create_1st_bitmap_cyclic(struct cycle *cycle)
 {
 	int i;
 	unsigned long long pfn, pfn_bitmap1;
@@ -4418,8 +4443,8 @@ create_1st_bitmap_cyclic()
 	 */
 	pfn_bitmap1 = 0;
 	for (i = 0; get_pt_load(i, &phys_start, &phys_end, NULL, NULL); i++) {
-		pfn_start = MAX(paddr_to_pfn(phys_start), info->cyclic_start_pfn);
-		pfn_end   = MIN(paddr_to_pfn(phys_end), info->cyclic_end_pfn);
+		pfn_start = MAX(paddr_to_pfn(phys_start), cycle->start_pfn);
+		pfn_end   = MIN(paddr_to_pfn(phys_end), cycle->end_pfn);
 
 		if (pfn_start >= pfn_end)
 			continue;
@@ -4428,12 +4453,12 @@ create_1st_bitmap_cyclic()
 		pfn_end_round = round(pfn_end, BITPERBYTE);
 
 		for (pfn = pfn_start; pfn < pfn_start_roundup; pfn++) {
-			if (set_bit_on_1st_bitmap(pfn))
+			if (set_bit_on_1st_bitmap(pfn, cycle))
 				pfn_bitmap1++;
 		}
 
-		pfn_start_byte = (pfn_start_roundup - info->cyclic_start_pfn) >> 3;
-		pfn_end_byte = (pfn_end_round - info->cyclic_start_pfn) >> 3;
+		pfn_start_byte = (pfn_start_roundup - cycle->start_pfn) >> 3;
+		pfn_end_byte = (pfn_end_round - cycle->start_pfn) >> 3;
 
 		if (pfn_start_byte < pfn_end_byte) {
 			memset(info->partial_bitmap1 + pfn_start_byte,
@@ -4444,7 +4469,7 @@ create_1st_bitmap_cyclic()
 		}
 
 		for (pfn = pfn_end_round; pfn < pfn_end; pfn++) {
-			if (set_bit_on_1st_bitmap(pfn))
+			if (set_bit_on_1st_bitmap(pfn, cycle))
 				pfn_bitmap1++;
 		}
 	}
@@ -4453,6 +4478,8 @@ create_1st_bitmap_cyclic()
 	return TRUE;
 }
 
+
+
 /*
  * Exclude the page filled with zero in case of creating an elf dumpfile.
  */
@@ -4493,7 +4520,7 @@ exclude_zero_pages(void)
 			}
 		}
 		if (is_zero_page(buf, info->page_size)) {
-			if (clear_bit_on_2nd_bitmap(pfn))
+			if (clear_bit_on_2nd_bitmap(pfn, NULL))
 				pfn_zero++;
 		}
 	}
@@ -4508,7 +4535,7 @@ exclude_zero_pages(void)
 }
 
 static int
-initialize_2nd_bitmap_cyclic(void)
+initialize_2nd_bitmap_cyclic(struct cycle *cycle)
 {
 	int i;
 	unsigned long long pfn;
@@ -4526,8 +4553,8 @@ initialize_2nd_bitmap_cyclic(void)
 	 * If page is on memory hole, set bit on the 2nd-bitmap.
 	 */
 	for (i = 0; get_pt_load(i, &phys_start, &phys_end, NULL, NULL); i++) {
-		pfn_start = MAX(paddr_to_pfn(phys_start), info->cyclic_start_pfn);
-		pfn_end = MIN(paddr_to_pfn(phys_end), info->cyclic_end_pfn);
+		pfn_start = MAX(paddr_to_pfn(phys_start), cycle->start_pfn);
+		pfn_end = MIN(paddr_to_pfn(phys_end), cycle->end_pfn);
 
 		if (pfn_start >= pfn_end)
 			continue;
@@ -4536,11 +4563,11 @@ initialize_2nd_bitmap_cyclic(void)
 		pfn_end_round = round(pfn_end, BITPERBYTE);
 
 		for (pfn = pfn_start; pfn < pfn_start_roundup; ++pfn)
-			if (!set_bit_on_2nd_bitmap_for_kernel(pfn))
+			if (!set_bit_on_2nd_bitmap_for_kernel(pfn, cycle))
 				return FALSE;
 
-		pfn_start_byte = (pfn_start_roundup - info->cyclic_start_pfn) >> 3;
-		pfn_end_byte = (pfn_end_round - info->cyclic_start_pfn) >> 3;
+		pfn_start_byte = (pfn_start_roundup - cycle->start_pfn) >> 3;
+		pfn_end_byte = (pfn_end_round - cycle->start_pfn) >> 3;
 
 		if (pfn_start_byte < pfn_end_byte) {
 			memset(info->partial_bitmap2 + pfn_start_byte,
@@ -4549,7 +4576,7 @@ initialize_2nd_bitmap_cyclic(void)
 		}
 
 		for (pfn = pfn_end_round; pfn < pfn_end; ++pfn)
-			if (!set_bit_on_2nd_bitmap_for_kernel(pfn))
+			if (!set_bit_on_2nd_bitmap_for_kernel(pfn, cycle))
 				return FALSE;
 	}
 
@@ -4558,7 +4585,7 @@ initialize_2nd_bitmap_cyclic(void)
 
 int
 __exclude_unnecessary_pages(unsigned long mem_map,
-    unsigned long long pfn_start, unsigned long long pfn_end)
+    unsigned long long pfn_start, unsigned long long pfn_end, struct cycle *cycle)
 {
 	unsigned long long pfn, pfn_mm, maddr;
 	unsigned long long pfn_read_start, pfn_read_end, index_pg;
@@ -4578,7 +4605,7 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 		/*
 		 * If this pfn doesn't belong to target region, skip this pfn.
 		 */
-		if (info->flag_cyclic && !is_cyclic_region(pfn))
+		if (info->flag_cyclic && !is_cyclic_region(pfn, cycle))
 			continue;
 
 		/*
@@ -4643,7 +4670,7 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 				 * See check_cyclic_buffer_overrun()
 				 * for the detail.
 				 */
-				if (clear_bit_on_2nd_bitmap_for_kernel(pfn + i))
+				if (clear_bit_on_2nd_bitmap_for_kernel((pfn + i), cycle))
 					pfn_free++;
 			}
 			pfn += nr_pages - 1;
@@ -4655,7 +4682,7 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 		else if ((info->dump_level & DL_EXCLUDE_CACHE)
 		    && (isLRU(flags) || isSwapCache(flags))
 		    && !isPrivate(flags) && !isAnon(mapping)) {
-			if (clear_bit_on_2nd_bitmap_for_kernel(pfn))
+			if (clear_bit_on_2nd_bitmap_for_kernel(pfn, cycle))
 				pfn_cache++;
 		}
 		/*
@@ -4664,7 +4691,7 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 		else if ((info->dump_level & DL_EXCLUDE_CACHE_PRI)
 		    && (isLRU(flags) || isSwapCache(flags))
 		    && !isAnon(mapping)) {
-			if (clear_bit_on_2nd_bitmap_for_kernel(pfn))
+			if (clear_bit_on_2nd_bitmap_for_kernel(pfn, cycle))
 				pfn_cache_private++;
 		}
 		/*
@@ -4672,14 +4699,14 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 		 */
 		else if ((info->dump_level & DL_EXCLUDE_USER_DATA)
 		    && isAnon(mapping)) {
-			if (clear_bit_on_2nd_bitmap_for_kernel(pfn))
+			if (clear_bit_on_2nd_bitmap_for_kernel(pfn, cycle))
 				pfn_user++;
 		}
 		/*
 		 * Exclude the hwpoison page.
 		 */
 		else if (isHWPOISON(flags)) {
-			if (clear_bit_on_2nd_bitmap_for_kernel(pfn))
+			if (clear_bit_on_2nd_bitmap_for_kernel(pfn, cycle))
 				pfn_hwpoison++;
 		}
 	}
@@ -4709,7 +4736,7 @@ exclude_unnecessary_pages(void)
 			continue;
 
 		if (!__exclude_unnecessary_pages(mmd->mem_map,
-						 mmd->pfn_start, mmd->pfn_end))
+						 mmd->pfn_start, mmd->pfn_end, NULL))
 			return FALSE;
 	}
 
@@ -4723,17 +4750,17 @@ exclude_unnecessary_pages(void)
 }
 
 int
-exclude_unnecessary_pages_cyclic(void)
+exclude_unnecessary_pages_cyclic(struct cycle *cycle)
 {
 	unsigned int mm;
 	struct mem_map_data *mmd;
 	struct timeval tv_start;
 
-	if (!initialize_2nd_bitmap_cyclic())
+	if (!initialize_2nd_bitmap_cyclic(cycle))
 		return FALSE;
 
 	if ((info->dump_level & DL_EXCLUDE_FREE) && !info->page_is_buddy)
-		if (!exclude_free_page())
+		if (!exclude_free_page(cycle))
 			return FALSE;
 
 	/*
@@ -4757,10 +4784,10 @@ exclude_unnecessary_pages_cyclic(void)
 			if (mmd->mem_map == NOT_MEMMAP_ADDR)
 				continue;
 
-			if (mmd->pfn_end >= info->cyclic_start_pfn &&
-			    mmd->pfn_start <= info->cyclic_end_pfn) {
+			if (mmd->pfn_end >= cycle->start_pfn &&
+			    mmd->pfn_start <= cycle->end_pfn) {
 				if (!__exclude_unnecessary_pages(mmd->mem_map,
-								 mmd->pfn_start, mmd->pfn_end))
+								 mmd->pfn_start, mmd->pfn_end, cycle))
 					return FALSE;
 			}
 		}
@@ -4776,27 +4803,6 @@ exclude_unnecessary_pages_cyclic(void)
 }
 
 int
-update_cyclic_region(unsigned long long pfn)
-{
-	if (is_cyclic_region(pfn))
-		return TRUE;
-
-	info->cyclic_start_pfn = round(pfn, info->pfn_cyclic);
-	info->cyclic_end_pfn = info->cyclic_start_pfn + info->pfn_cyclic;
-
-	if (info->cyclic_end_pfn > info->max_mapnr)
-		info->cyclic_end_pfn = info->max_mapnr;
-
-	if (info->flag_elf_dumpfile && !create_1st_bitmap_cyclic())
-		return FALSE;
-
-	if (!exclude_unnecessary_pages_cyclic())
-		return FALSE;
-
-	return TRUE;
-}
-
-int
 copy_bitmap(void)
 {
 	off_t offset;
@@ -4862,7 +4868,7 @@ create_2nd_bitmap(void)
 	 * Exclude free pages.
 	 */
 	if ((info->dump_level & DL_EXCLUDE_FREE) && !info->page_is_buddy)
-		if (!exclude_free_page())
+		if (!exclude_free_page(NULL))
 			return FALSE;
 
 	/*
@@ -5551,13 +5557,16 @@ unsigned long long
 get_num_dumpable_cyclic(void)
 {
 	unsigned long long pfn, num_dumpable=0;
+	struct cycle cycle = {0};
 
-	for (pfn = 0; pfn < info->max_mapnr; pfn++) {
-		if (!update_cyclic_region(pfn))
+	for_each_cycle(0, info->max_mapnr, &cycle)
+	{
+		if (!exclude_unnecessary_pages_cyclic(&cycle))
 			return FALSE;
 
-		if (is_dumpable_cyclic(info->partial_bitmap2, pfn))
-			num_dumpable++;
+		for(pfn=cycle.start_pfn; pfn<cycle.end_pfn; pfn++)
+			if (is_dumpable_cyclic(info->partial_bitmap2, pfn, &cycle))
+				num_dumpable++;
 	}
 
 	return num_dumpable;
@@ -5816,16 +5825,7 @@ get_loads_dumpfile_cyclic(void)
 	unsigned long long pfn, pfn_start, pfn_end, num_excluded;
 	unsigned long frac_head, frac_tail;
 	Elf64_Phdr load;
-
-	/*
-	 * Initialize target region and bitmap.
-	 */
-	info->cyclic_start_pfn = 0;
-	info->cyclic_end_pfn = info->pfn_cyclic;
-	if (!create_1st_bitmap_cyclic())
-		return FALSE;
-	if (!exclude_unnecessary_pages_cyclic())
-		return FALSE;
+	struct cycle cycle = {0};
 
 	if (!(phnum = get_phnum_memory()))
 		return FALSE;
@@ -5849,44 +5849,41 @@ get_loads_dumpfile_cyclic(void)
 		if (frac_tail)
 			pfn_end++;
 
-		for (pfn = pfn_start; pfn < pfn_end; pfn++) {
-			/*
-			 * Update target region and bitmap
-			 */
-			if (!is_cyclic_region(pfn)) {
-				if (!update_cyclic_region(pfn))
-					return FALSE;
-			}
-
-			if (!is_dumpable_cyclic(info->partial_bitmap2, pfn)) {
-				num_excluded++;
-				continue;
-			}
-
-			/*
-			 * Exclude zero pages.
-			 */
-			if (info->dump_level & DL_EXCLUDE_ZERO) {
-				if (!read_pfn(pfn, buf))
-					return FALSE;
-				if (is_zero_page(buf, page_size)) {
+		for_each_cycle(pfn_start, pfn_end, &cycle) {
+			if (!exclude_unnecessary_pages_cyclic(&cycle))
+				return FALSE;
+			for (pfn = cycle.start_pfn; pfn < cycle.end_pfn; pfn++) {
+				if (!is_dumpable_cyclic(info->partial_bitmap2, pfn, &cycle)) {
 					num_excluded++;
 					continue;
 				}
-			}
 
-			info->num_dumpable++;
+				/*
+				 * Exclude zero pages.
+				 */
+				if (info->dump_level & DL_EXCLUDE_ZERO) {
+					if (!read_pfn(pfn, buf))
+						return FALSE;
+					if (is_zero_page(buf, page_size)) {
+						num_excluded++;
+						continue;
+					}
+				}
 
-			/*
-			 * If the number of the contiguous pages to be excluded
-			 * is 256 or more, those pages are excluded really.
-			 * And a new PT_LOAD segment is created.
-			 */
-			if (num_excluded >= PFN_EXCLUDED) {
-				num_new_load++;
+				info->num_dumpable++;
+
+				/*
+				 * If the number of the contiguous pages to be excluded
+				 * is 256 or more, those pages are excluded really.
+				 * And a new PT_LOAD segment is created.
+				 */
+				if (num_excluded >= PFN_EXCLUDED) {
+					num_new_load++;
+				}
+				num_excluded = 0;
 			}
-			num_excluded = 0;
 		}
+
 	}
 	return num_new_load;
 }
@@ -5904,6 +5901,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 	off_t off_seg_load, off_memory;
 	Elf64_Phdr load;
 	struct timeval tv_start;
+	struct cycle cycle = {0};
 
 	if (!info->flag_elf_dumpfile)
 		return FALSE;
@@ -5921,11 +5919,6 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 	pfn_user = pfn_free = pfn_hwpoison = 0;
 	pfn_memhole = info->max_mapnr;
 
-	info->cyclic_start_pfn = 0;
-	info->cyclic_end_pfn = 0;
-	if (!update_cyclic_region(0))
-		return FALSE;
-
 	if (!(phnum = get_phnum_memory()))
 		return FALSE;
 
@@ -5957,30 +5950,17 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 		if (frac_tail)
 			pfn_end++;
 
-		for (pfn = pfn_start; pfn < pfn_end; pfn++) {
+		for_each_cycle(pfn_start, pfn_end, &cycle) {
 			/*
 			 * Update target region and partial bitmap if necessary.
 			 */
-			if (!update_cyclic_region(pfn))
+			if (!create_1st_bitmap_cyclic(&cycle))
+				return FALSE;
+			if (!exclude_unnecessary_pages_cyclic(&cycle))
 				return FALSE;
 
-			if (!is_dumpable_cyclic(info->partial_bitmap2, pfn)) {
-				num_excluded++;
-				if ((pfn == pfn_end - 1) && frac_tail)
-					memsz += frac_tail;
-				else
-					memsz += page_size;
-				continue;
-			}
-
-			/*
-			 * Exclude zero pages.
-			 */
-			if (info->dump_level & DL_EXCLUDE_ZERO) {
-				if (!read_pfn(pfn, buf))
-					return FALSE;
-				if (is_zero_page(buf, page_size)) {
-					pfn_zero++;
+			for (pfn = cycle.start_pfn; pfn < cycle.end_pfn; pfn++) {
+				if (!is_dumpable_cyclic(info->partial_bitmap2, pfn, &cycle)) {
 					num_excluded++;
 					if ((pfn == pfn_end - 1) && frac_tail)
 						memsz += frac_tail;
@@ -5988,93 +5968,111 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 						memsz += page_size;
 					continue;
 				}
-			}
 
-			if ((num_dumped % per) == 0)
-				print_progress(PROGRESS_COPY, num_dumped, num_dumpable);
+				/*
+				 * Exclude zero pages.
+				 */
+				if (info->dump_level & DL_EXCLUDE_ZERO) {
+					if (!read_pfn(pfn, buf))
+						return FALSE;
+					if (is_zero_page(buf, page_size)) {
+						pfn_zero++;
+						num_excluded++;
+						if ((pfn == pfn_end - 1) && frac_tail)
+							memsz += frac_tail;
+						else
+							memsz += page_size;
+						continue;
+					}
+				}
 
-			num_dumped++;
+				if ((num_dumped % per) == 0)
+					print_progress(PROGRESS_COPY, num_dumped, num_dumpable);
+
+				num_dumped++;
 
-			/*
-			 * The dumpable pages are continuous.
-			 */
-			if (!num_excluded) {
-				if ((pfn == pfn_end - 1) && frac_tail) {
-					memsz  += frac_tail;
-					filesz += frac_tail;
-				} else {
-					memsz  += page_size;
-					filesz += page_size;
-				}
-				continue;
 				/*
-				 * If the number of the contiguous pages to be excluded
-				 * is 255 or less, those pages are not excluded.
+				 * The dumpable pages are continuous.
 				 */
-			} else if (num_excluded < PFN_EXCLUDED) {
-				if ((pfn == pfn_end - 1) && frac_tail) {
-					memsz  += frac_tail;
-					filesz += (page_size*num_excluded
-						   + frac_tail);
-				}else {
-					memsz  += page_size;
-					filesz += (page_size*num_excluded
-						   + page_size);
+				if (!num_excluded) {
+					if ((pfn == pfn_end - 1) && frac_tail) {
+						memsz  += frac_tail;
+						filesz += frac_tail;
+					} else {
+						memsz  += page_size;
+						filesz += page_size;
+					}
+					continue;
+					/*
+					 * If the number of the contiguous pages to be excluded
+					 * is 255 or less, those pages are not excluded.
+					 */
+				} else if (num_excluded < PFN_EXCLUDED) {
+					if ((pfn == pfn_end - 1) && frac_tail) {
+						memsz  += frac_tail;
+						filesz += (page_size*num_excluded
+							   + frac_tail);
+					}else {
+						memsz  += page_size;
+						filesz += (page_size*num_excluded
+							   + page_size);
+					}
+					num_excluded = 0;
+					continue;
 				}
-				num_excluded = 0;
-				continue;
-			}
 
-			/*
-			 * If the number of the contiguous pages to be excluded
-			 * is 256 or more, those pages are excluded really.
-			 * And a new PT_LOAD segment is created.
-			 */
-			load.p_memsz = memsz;
-			load.p_filesz = filesz;
-			if (load.p_filesz)
-				load.p_offset = off_seg_load;
-			else
 				/*
-				 * If PT_LOAD segment does not have real data
-				 * due to the all excluded pages, the file
-				 * offset is not effective and it should be 0.
+				 * If the number of the contiguous pages to be excluded
+				 * is 256 or more, those pages are excluded really.
+				 * And a new PT_LOAD segment is created.
 				 */
-				load.p_offset = 0;
-
-			/*
-			 * Write a PT_LOAD header.
-			 */
-			if (!write_elf_phdr(cd_header, &load))
-				return FALSE;
+				load.p_memsz = memsz;
+				load.p_filesz = filesz;
+				if (load.p_filesz)
+					load.p_offset = off_seg_load;
+				else
+					/*
+					 * If PT_LOAD segment does not have real data
+					 * due to the all excluded pages, the file
+					 * offset is not effective and it should be 0.
+					 */
+					load.p_offset = 0;
 
-			/*
-			 * Write a PT_LOAD segment.
-			 */
-			if (load.p_filesz)
-				if (!write_elf_load_segment(cd_page, paddr,
-							    off_memory, load.p_filesz))
+				/*
+				 * Write a PT_LOAD header.
+				 */
+				if (!write_elf_phdr(cd_header, &load))
 					return FALSE;
 
-			load.p_paddr += load.p_memsz;
+				/*
+				 * Write a PT_LOAD segment.
+				 */
+				if (load.p_filesz)
+					if (!write_elf_load_segment(cd_page, paddr,
+								    off_memory, load.p_filesz))
+						return FALSE;
+
+				load.p_paddr += load.p_memsz;
 #ifdef __x86__
-			/*
-			 * FIXME:
-			 *  (x86) Fill PT_LOAD headers with appropriate
-			 * virtual addresses.
-			 */
-			if (load.p_paddr < MAXMEM)
-				load.p_vaddr += load.p_memsz;
+				/*
+				 * FIXME:
+				 *  (x86) Fill PT_LOAD headers with appropriate
+				 * virtual addresses.
+				 */
+				if (load.p_paddr < MAXMEM)
+					load.p_vaddr += load.p_memsz;
 #else
-			load.p_vaddr += load.p_memsz;
+				load.p_vaddr += load.p_memsz;
 #endif /* x86 */
-			paddr  = load.p_paddr;
-			off_seg_load += load.p_filesz;
+				paddr  = load.p_paddr;
+				off_seg_load += load.p_filesz;
 
-			num_excluded = 0;
-			memsz  = page_size;
-			filesz = page_size;
+				num_excluded = 0;
+				memsz  = page_size;
+				filesz = page_size;
+			}
 		}
+
 		/*
 		 * Write the last PT_LOAD.
 		 */
@@ -6323,7 +6321,7 @@ out:
 
 int
 write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page,
-			 struct page_desc *pd_zero, off_t *offset_data)
+			 struct page_desc *pd_zero, off_t *offset_data, struct cycle *cycle)
 {
 	unsigned long long pfn, per;
 	unsigned long long start_pfn, end_pfn;
@@ -6380,8 +6378,8 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
 		goto out;
 	}
 
-	start_pfn = info->cyclic_start_pfn;
-	end_pfn   = info->cyclic_end_pfn;
+	start_pfn = cycle->start_pfn;
+	end_pfn   = cycle->end_pfn;
 
 	if (info->flag_split) {
 		if (start_pfn < info->split_start_pfn)
@@ -6398,7 +6396,7 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
 		/*
 		 * Check the excluded page.
 		 */
-		if (!is_dumpable_cyclic(info->partial_bitmap2, pfn))
+		if (!is_on(info->partial_bitmap2, pfn - cycle->start_pfn))
 			continue;
 
 		num_dumped++;
@@ -6757,20 +6755,20 @@ out:
 }
 
 int
-write_kdump_bitmap1_cyclic(void)
+write_kdump_bitmap1_cyclic(struct cycle *cycle)
 {
 	off_t offset;
         int increment;
 	int ret = FALSE;
 
-	increment = divideup(info->cyclic_end_pfn - info->cyclic_start_pfn, BITPERBYTE);
+	increment = divideup(cycle->end_pfn - cycle->start_pfn, BITPERBYTE);
 
 	if (info->flag_elf_dumpfile)
 		return FALSE;
 
 	offset = info->offset_bitmap1;
 	if (!write_buffer(info->fd_dumpfile, offset + info->bufsize_cyclic *
-			  (info->cyclic_start_pfn / info->pfn_cyclic),
+			  (cycle->start_pfn / info->pfn_cyclic),
 			  info->partial_bitmap1, increment, info->name_dumpfile))
 		goto out;
 
@@ -6780,13 +6778,13 @@ out:
 }
 
 int
-write_kdump_bitmap2_cyclic(void)
+write_kdump_bitmap2_cyclic(struct cycle *cycle)
 {
 	off_t offset;
 	int increment;
 	int ret = FALSE;
 
-	increment = divideup(info->cyclic_end_pfn - info->cyclic_start_pfn,
+	increment = divideup(cycle->end_pfn - cycle->start_pfn,
 			     BITPERBYTE);
 
 	if (info->flag_elf_dumpfile)
@@ -6813,7 +6811,6 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
 	off_t offset_data=0;
 	struct disk_dump_header *dh = info->dump_header;
 	unsigned char buf[info->page_size];
-	unsigned long long pfn;
 	struct timeval tv_start;
 
 	gettimeofday(&tv_start, NULL);
@@ -6851,19 +6848,16 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
 	if (!prepare_bitmap1_buffer_cyclic())
 		return FALSE;
 
-	info->cyclic_start_pfn = 0;
-	info->cyclic_end_pfn = 0;
-	for (pfn = 0; pfn < info->max_mapnr; pfn++) {
-		if (is_cyclic_region(pfn))
-			continue;
-		if (!update_cyclic_region(pfn))
-			return FALSE;
-		if (!create_1st_bitmap_cyclic())
+	struct cycle cycle = {0};
+	for_each_cycle(0, info->max_mapnr, &cycle)
+	{
+		if (!create_1st_bitmap_cyclic(&cycle))
 			return FALSE;
-		if (!write_kdump_bitmap1_cyclic())
+		if (!write_kdump_bitmap1_cyclic(&cycle))
 			return FALSE;
 	}
 
+
 	free_bitmap1_buffer();
 
 	if (!prepare_bitmap2_buffer_cyclic())
@@ -6872,21 +6866,22 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
 	/*
 	 * Write pages and bitmap cyclically.
 	 */
-	info->cyclic_start_pfn = 0;
-	info->cyclic_end_pfn = 0;
-	for (pfn = 0; pfn < info->max_mapnr; pfn++) {
-		if (is_cyclic_region(pfn))
-			continue;
-
-		if (!update_cyclic_region(pfn))
-                        return FALSE;
+	//cycle = {0, 0};
+	memset(&cycle, 0, sizeof(struct cycle));
+	for_each_cycle(0, info->max_mapnr, &cycle)
+	{
+		if (!exclude_unnecessary_pages_cyclic(&cycle))
+			return FALSE;
 
-		if (!write_kdump_pages_cyclic(cd_header, cd_page, &pd_zero, &offset_data))
+		if (!write_kdump_pages_cyclic(cd_header, cd_page, &pd_zero,
+					&offset_data, &cycle))
 			return FALSE;
 
-		if (!write_kdump_bitmap2_cyclic())
+		if (!write_kdump_bitmap2_cyclic(&cycle))
 			return FALSE;
-        }
+	}
+
+
 
 	/*
 	 * Write the remainder.
@@ -7496,7 +7491,7 @@ exclude_xen3_user_domain(void)
 					size * num_pt_loads);
 
 			if (!allocated_in_map(pfn)) {
-				clear_bit_on_2nd_bitmap(pfn);
+				clear_bit_on_2nd_bitmap(pfn, NULL);
 				continue;
 			}
 
@@ -7504,7 +7499,7 @@ exclude_xen3_user_domain(void)
 			if (!readmem(VADDR_XEN,
 			      page_info_addr + OFFSET(page_info.count_info),
 		 	      &count_info, sizeof(count_info))) {
-				clear_bit_on_2nd_bitmap(pfn);
+				clear_bit_on_2nd_bitmap(pfn, NULL);
 				continue;	/* page_info may not exist */
 			}
 			if (!readmem(VADDR_XEN,
@@ -7525,7 +7520,7 @@ exclude_xen3_user_domain(void)
 				continue;
 			if ((count_info & 0xffff) && is_select_domain(_domain))
 				continue;
-			clear_bit_on_2nd_bitmap(pfn);
+			clear_bit_on_2nd_bitmap(pfn, NULL);
 		}
 	}
 
@@ -7563,7 +7558,7 @@ exclude_xen4_user_domain(void)
 			if (!readmem(VADDR_XEN,
 			      page_info_addr + OFFSET(page_info.count_info),
 		 	      &count_info, sizeof(count_info))) {
-				clear_bit_on_2nd_bitmap(pfn);
+				clear_bit_on_2nd_bitmap(pfn, NULL);
 				continue;	/* page_info may not exist */
 			}
 
@@ -7575,7 +7570,7 @@ exclude_xen4_user_domain(void)
 			if (page_state_is(count_info, free) ||
 			    page_state_is(count_info, offlined) ||
 			    count_info & PGC_broken) {
-				clear_bit_on_2nd_bitmap(pfn);
+				clear_bit_on_2nd_bitmap(pfn, NULL);
 				continue;
 			}
 
@@ -7601,7 +7596,7 @@ exclude_xen4_user_domain(void)
 				continue;
 			if (is_select_domain(_domain))
 				continue;
-			clear_bit_on_2nd_bitmap(pfn);
+			clear_bit_on_2nd_bitmap(pfn, NULL);
 		}
 	}
 
diff --git a/makedumpfile.h b/makedumpfile.h
index 3d270c6..34815eb 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1590,6 +1590,11 @@ int get_xen_info_ia64(void);
 #define get_xen_info_arch(X) FALSE
 #endif	/* s390x */
 
+struct cycle {
+	uint64_t start_pfn;
+	uint64_t end_pfn;
+};
+
 static inline int
 is_on(char *bitmap, int i)
 {
@@ -1613,18 +1618,18 @@ is_dumpable(struct dump_bitmap *bitmap, unsigned long long pfn)
 }
 
 static inline int
-is_dumpable_cyclic(char *bitmap, unsigned long long pfn)
+is_dumpable_cyclic(char *bitmap, unsigned long long pfn, struct cycle *cycle)
 {
-	if (pfn < info->cyclic_start_pfn || info->cyclic_end_pfn <= pfn)
+	if (pfn < cycle->start_pfn || cycle->end_pfn <= pfn)
 		return FALSE;
 	else
-		return is_on(bitmap, pfn - info->cyclic_start_pfn);
+		return is_on(bitmap, pfn - cycle->start_pfn);
 }
 
 static inline int
-is_cyclic_region(unsigned long long pfn)
+is_cyclic_region(unsigned long long pfn, struct cycle *cycle)
 {
-	if (pfn < info->cyclic_start_pfn || info->cyclic_end_pfn <= pfn)
+	if (pfn < cycle->start_pfn || cycle->end_pfn <= pfn)
 		return FALSE;
 	else
 		return TRUE;
@@ -1642,8 +1647,8 @@ is_zero_page(unsigned char *buf, long page_size)
 }
 
 void write_vmcoreinfo_data(void);
-int set_bit_on_1st_bitmap(unsigned long long pfn);
-int clear_bit_on_1st_bitmap(unsigned long long pfn);
+int set_bit_on_1st_bitmap(unsigned long long pfn, struct cycle *cycle);
+int clear_bit_on_1st_bitmap(unsigned long long pfn, struct cycle *cycle);
 
 #ifdef __x86__
 
diff --git a/sadump_info.c b/sadump_info.c
index 7822e82..f14ffc9 100644
--- a/sadump_info.c
+++ b/sadump_info.c
@@ -214,9 +214,9 @@ sadump_copy_1st_bitmap_from_memory(void)
 						      si->backup_src_start);
 
 			if (is_dumpable(info->bitmap_memory, backup_src_pfn))
-				set_bit_on_1st_bitmap(pfn);
+				set_bit_on_1st_bitmap(pfn, NULL);
 			else
-				clear_bit_on_1st_bitmap(pfn);
+				clear_bit_on_1st_bitmap(pfn, NULL);
 		}
 	}
 
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
