Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from relay2.sgi.com ([192.48.179.30] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VEnuh-0002Au-Ex
 for kexec@lists.infradead.org; Wed, 28 Aug 2013 22:08:36 +0000
Subject: [PATCH] makedumpfile: shorten cyclic exclude-unnecessary passes
Message-Id: <E1VEnuJ-0000K6-Lo@eag09.americas.sgi.com>
From: Cliff Wickman <cpw@sgi.com>
Date: Wed, 28 Aug 2013 17:08:07 -0500
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
To: d.hatayama@jp.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

From: Cliff Wickman <cpw@sgi.com>

- get_mm_sparsemem(): reduce the number of entries in the mem_map[] by
  recording only those sections which actually exist in memory
- shorten the executions of __exclude_unnecessary_pages() by passing it only
  the pfn's of the current cyclic area

- for testing: add option -a to use cyclic mode when plenty of memory is
  available for noncyclic mode
  (assumes patch  makedumpfile: use non-cyclic when possible)

- cosmetic: in cyclic mode count the number of cycles and report the cycle
  number as the scan-and-copy cycles progress
- cosmetic: let the prints of unnecessary page scans stop at their current
  position, i.e. at the end of the current cyclic region

makes a progress history like

Begin page counting phase.
Scan cycle 1
Excluding free pages               : [100 %] 
Excluding unnecessary pages        : [ 45 %] 
Scan cycle 2
Excluding free pages               : [ 87 %] 
Excluding unnecessary pages        : [ 87 %] 
Scan cycle 3
Excluding free pages               : [100 %] 
Excluding unnecessary pages        : [ 99 %] 
Scan cycle 4

Scan-and-copy cycle 1/3
Excluding free pages               : [ 45 %] 
Excluding unnecessary pages        : [ 45 %] 
Copying data                       : [ 44 %] 
Scan-and-copy cycle 2/3
Excluding free pages               : [ 87 %] 
Excluding unnecessary pages        : [ 87 %] 
Copying data                       : [ 86 %] 
Scan-and-copy cycle 3/3
Excluding free pages               : [100 %] 
Excluding unnecessary pages        : [ 99 %] 
Copying data                       : [100 %] 
Saving core complete


Diffed against makedumpfile-1.5.4
Signed-off-by: Cliff Wickman <cpw@sgi.com>
---
 makedumpfile.c |  127 +++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 98 insertions(+), 29 deletions(-)

Index: makedumpfile-1.5.4/makedumpfile.c
===================================================================
--- makedumpfile-1.5.4.orig/makedumpfile.c
+++ makedumpfile-1.5.4/makedumpfile.c
@@ -50,6 +50,8 @@ unsigned long long pfn_hwpoison;
 unsigned long long num_dumped;
 
 int retcd = FAILED;	/* return code */
+int aflag = 0;
+int total_cycles = 0;
 
 #define INITIALIZE_LONG_TABLE(table, value) \
 do { \
@@ -2651,7 +2653,7 @@ sparse_decode_mem_map(unsigned long code
 int
 get_mm_sparsemem(void)
 {
-	unsigned int section_nr, mem_section_size, num_section;
+	unsigned int section_nr, valid_section_nr, mem_section_size, num_section;
 	unsigned long long pfn_start, pfn_end;
 	unsigned long section, mem_map;
 	unsigned long *mem_sec = NULL;
@@ -2686,17 +2688,26 @@ get_mm_sparsemem(void)
 		    strerror(errno));
 		goto out;
 	}
+	valid_section_nr = 0;
 	for (section_nr = 0; section_nr < num_section; section_nr++) {
 		section = nr_to_section(section_nr, mem_sec);
 		mem_map = section_mem_map_addr(section);
 		mem_map = sparse_decode_mem_map(mem_map, section_nr);
-		if (!is_kvaddr(mem_map))
-			mem_map = NOT_MEMMAP_ADDR;
-		pfn_start = section_nr * PAGES_PER_SECTION();
-		pfn_end   = pfn_start + PAGES_PER_SECTION();
-		if (info->max_mapnr < pfn_end)
-			pfn_end = info->max_mapnr;
-		dump_mem_map(pfn_start, pfn_end, mem_map, section_nr);
+		if (is_kvaddr(mem_map)) {
+			pfn_start = section_nr * PAGES_PER_SECTION();
+			pfn_end   = pfn_start + PAGES_PER_SECTION();
+			if (info->max_mapnr < pfn_end)
+				pfn_end = info->max_mapnr;
+			dump_mem_map(pfn_start, pfn_end, mem_map, valid_section_nr);
+			valid_section_nr++;
+		}
+	}
+	info->num_mem_map = valid_section_nr;
+	if (valid_section_nr < num_section) {
+		if (realloc(mem_sec, mem_section_size) != mem_sec) {
+			ERRMSG("mem_sec realloc failed\n");
+			exit(1);
+		};
 	}
 	ret = TRUE;
 out:
@@ -3642,10 +3653,15 @@ reset_bitmap_of_free_pages(unsigned long
 					retcd = ANALYSIS_FAILED;
 					return FALSE;
 				}
-				for (i = 0; i < (1<<order); i++) {
-					pfn = start_pfn + i;
-					if (clear_bit_on_2nd_bitmap_for_kernel(pfn))
-						found_free_pages++;
+
+				if (!info->flag_cyclic ||
+				    ((start_pfn >= info->cyclic_start_pfn) &&
+				     (start_pfn < info->cyclic_end_pfn))) {
+					for (i = 0; i < (1<<order); i++) {
+						pfn = start_pfn + i;
+						if (clear_bit_on_2nd_bitmap_for_kernel(pfn))
+							found_free_pages++;
+					}
 				}
 
 				previous = curr;
@@ -4519,6 +4535,10 @@ int
 exclude_unnecessary_pages_cyclic(void)
 {
 	unsigned int mm;
+	unsigned long pfn_start;
+	unsigned long pfn_end;
+	unsigned long mem_map;
+	long offset;
 	struct mem_map_data *mmd;
 	struct timeval tv_start;
 
@@ -4527,9 +4547,12 @@ exclude_unnecessary_pages_cyclic(void)
 	 */
 	copy_bitmap_cyclic();
 
-	if ((info->dump_level & DL_EXCLUDE_FREE) && !info->page_is_buddy)
+	if ((info->dump_level & DL_EXCLUDE_FREE) && !info->page_is_buddy) {
 		if (!exclude_free_page())
 			return FALSE;
+		else
+			PROGRESS_MSG("\n");
+	}
 
 	/*
 	 * Exclude cache pages, cache private pages, user data pages,
@@ -4549,21 +4572,37 @@ exclude_unnecessary_pages_cyclic(void)
 
 			mmd = &info->mem_map_data[mm];
 
+			// NOT_MEMMAP_ADDR generally not used
 			if (mmd->mem_map == NOT_MEMMAP_ADDR)
 				continue;
 
 			if (mmd->pfn_end >= info->cyclic_start_pfn &&
 			    mmd->pfn_start <= info->cyclic_end_pfn) {
-				if (!__exclude_unnecessary_pages(mmd->mem_map,
-								 mmd->pfn_start, mmd->pfn_end))
+				offset = 0;
+				pfn_start = mmd->pfn_start;
+				pfn_end = mmd->pfn_end;
+				mem_map = mmd->mem_map;
+				if (info->cyclic_end_pfn < pfn_end) {
+					pfn_end = info->cyclic_end_pfn;
+				}
+				if (info->cyclic_start_pfn > pfn_start)	{
+					offset = info->cyclic_start_pfn -
+						pfn_start;
+					mem_map = mmd->mem_map +
+							(SIZE(page) * offset);
+					pfn_start = info->cyclic_start_pfn;
+				}
+
+				if (!__exclude_unnecessary_pages(mem_map,
+							pfn_start, pfn_end))
 					return FALSE;
 			}
 		}
 
 		/*
-		 * print [100 %]
+		 * let progress stop at the print ending position
 		 */
-		print_progress(PROGRESS_UNN_PAGES, info->num_mem_map, info->num_mem_map);
+		PROGRESS_MSG("\n");
 		print_execution_time(PROGRESS_UNN_PAGES, &tv_start);
 	}
 
@@ -4571,7 +4610,7 @@ exclude_unnecessary_pages_cyclic(void)
 }
 
 int
-update_cyclic_region(unsigned long long pfn)
+update_cyclic_region(unsigned long long pfn, int *didscan)
 {
 	if (is_cyclic_region(pfn))
 		return TRUE;
@@ -4588,6 +4627,8 @@ update_cyclic_region(unsigned long long 
 	if (!exclude_unnecessary_pages_cyclic())
 		return FALSE;
 
+	if (didscan)
+		(*didscan)++;
 	return TRUE;
 }
 
@@ -4651,14 +4692,17 @@ create_2nd_bitmap(void)
 			ERRMSG("Can't exclude unnecessary pages.\n");
 			return FALSE;
 		}
+		PROGRESS_MSG("\n");
 	}
 
 	/*
 	 * Exclude free pages.
 	 */
-	if ((info->dump_level & DL_EXCLUDE_FREE) && !info->page_is_buddy)
+	if ((info->dump_level & DL_EXCLUDE_FREE) && !info->page_is_buddy) {
 		if (!exclude_free_page())
 			return FALSE;
+		PROGRESS_MSG("\n");
+	}
 
 	/*
 	 * Exclude Xen user domain.
@@ -5262,15 +5306,26 @@ get_num_dumpable(void)
 unsigned long long
 get_num_dumpable_cyclic(void)
 {
+	int cycle = 0;
+	int lastcycle = 0;
+	int newcycle = 1;
 	unsigned long long pfn, num_dumpable=0;
 
+	PROGRESS_MSG("Begin page counting phase.\n");
 	for (pfn = 0; pfn < info->max_mapnr; pfn++) {
-		if (!update_cyclic_region(pfn))
+		if (newcycle)
+			PROGRESS_MSG("Scan cycle %d\n", cycle + 1);
+		newcycle = 0;
+		lastcycle = cycle;
+		if (!update_cyclic_region(pfn, &cycle))
 			return FALSE;
+		if (cycle > lastcycle)
+			newcycle++;
 
 		if (is_dumpable_cyclic(info->partial_bitmap2, pfn))
 			num_dumpable++;
 	}
+	total_cycles = cycle;
 
 	return num_dumpable;
 }
@@ -5566,7 +5621,7 @@ get_loads_dumpfile_cyclic(void)
 			 * Update target region and bitmap
 			 */
 			if (!is_cyclic_region(pfn)) {
-				if (!update_cyclic_region(pfn))
+				if (!update_cyclic_region(pfn, 0))
 					return FALSE;
 			}
 
@@ -5635,7 +5690,7 @@ write_elf_pages_cyclic(struct cache_data
 
 	info->cyclic_start_pfn = 0;
 	info->cyclic_end_pfn = 0;
-	if (!update_cyclic_region(0))
+	if (!update_cyclic_region(0, 0))
 		return FALSE;
 
 	if (!(phnum = get_phnum_memory()))
@@ -5673,7 +5728,7 @@ write_elf_pages_cyclic(struct cache_data
 			/*
 			 * Update target region and partial bitmap if necessary.
 			 */
-			if (!update_cyclic_region(pfn))
+			if (!update_cyclic_region(pfn, 0))
 				return FALSE;
 
 			if (!is_dumpable_cyclic(info->partial_bitmap2, pfn)) {
@@ -6499,6 +6554,7 @@ out:
 int
 write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 {
+	int cycle_number = 1;
 	struct page_desc pd_zero;
 	off_t offset_data=0;
 	struct disk_dump_header *dh = info->dump_header;
@@ -6544,7 +6600,10 @@ write_kdump_pages_and_bitmap_cyclic(stru
 		if (is_cyclic_region(pfn))
 			continue;
 
-		if (!update_cyclic_region(pfn))
+		PROGRESS_MSG("\nScan-and-copy cycle %d/%d\n",
+			cycle_number, total_cycles);
+		cycle_number++;
+		if (!update_cyclic_region(pfn, 0))
                         return FALSE;
 
 		if (!write_kdump_pages_cyclic(cd_header, cd_page, &pd_zero, &offset_data))
@@ -7673,12 +7732,19 @@ create_dumpfile(void)
 	print_vtop();
 
 	if (plenty_of_memory()) {
-		if (info->flag_cyclic == TRUE)
-			MSG("Plenty of memory; using non-cyclic mode.\n");
-		info->flag_cyclic = FALSE;
+		if (info->flag_cyclic == TRUE) {
+			if (aflag)
+				PROGRESS_MSG(
+			     "Plenty of memory; could use non-cyclic mode.\n");
+			else {
+				PROGRESS_MSG(
+				"Plenty of memory; using non-cyclic mode.\n");
+				info->flag_cyclic = FALSE;
+			}
+		}
 	} else {
 		if (info->flag_cyclic == TRUE)
-			MSG("Restricted memory; staying in cyclic mode.\n");
+			PROGRESS_MSG("Restricted memory; staying in cyclic mode.\n");
 	}
 
 	num_retry = 0;
@@ -8623,9 +8689,12 @@ main(int argc, char *argv[])
 	
 	info->block_order = DEFAULT_ORDER;
 	message_level = DEFAULT_MSG_LEVEL;
-	while ((opt = getopt_long(argc, argv, "b:cDd:EFfg:hi:lMpRrsvXx:", longopts,
+	while ((opt = getopt_long(argc, argv, "ab:cDd:EFfg:hi:lMpRrsvXx:", longopts,
 	    NULL)) != -1) {
 		switch (opt) {
+		case 'a':
+			aflag = 1; // force cyclic mode
+			break;
 		case 'b':
 			info->block_order = atoi(optarg);
 			break;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
