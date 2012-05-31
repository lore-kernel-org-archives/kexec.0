Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SZxXm-0000VM-7a
 for kexec@lists.infradead.org; Thu, 31 May 2012 05:03:32 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.160])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id q4V53Osj008991
 for <kexec@lists.infradead.org>; Thu, 31 May 2012 14:03:24 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id q4V53NY06522 for kexec@lists.infradead.org;
 Thu, 31 May 2012 14:03:23 +0900 (JST)
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
 by mailsv3.nec.co.jp (8.13.8/8.13.4) with ESMTP id q4V53Nsn015075
 for <kexec@lists.infradead.org>; Thu, 31 May 2012 14:03:23 +0900 (JST)
Date: Thu, 31 May 2012 13:56:09 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [RFC PATCH 3/4] makedumpfile: Change the function related to
 excluding.
Message-Id: <20120531135609.9d1da3af.kumagai-atsushi@mxc.nes.nec.co.jp>
Mime-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Extend the function related to excluding unnecessary pages.
The function creates partial bitmap corresponding to range of target region
when cyclic flag is on.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.c |  170 ++++++++++++++++++++++++++++++++++++++++++++++++--------
 makedumpfile.h |    1 +
 2 files changed, 149 insertions(+), 22 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index ff8f157..d6d4a43 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -43,6 +43,7 @@ unsigned long long pfn_cache;
 unsigned long long pfn_cache_private;
 unsigned long long pfn_user;
 unsigned long long pfn_free;
+unsigned long long num_dumped;
 
 int retcd = FAILED;	/* return code */
 
@@ -3264,9 +3265,9 @@ reset_bitmap_of_free_pages(unsigned long node_zones)
 				}
 				for (i = 0; i < (1<<order); i++) {
 					pfn = start_pfn + i;
-					clear_bit_on_2nd_bitmap_for_kernel(pfn);
+					if (clear_bit_on_2nd_bitmap_for_kernel(pfn))
+						found_free_pages++;						
 				}
-				found_free_pages += i;
 
 				previous = curr;
 				if (!readmem(VADDR, curr+OFFSET(list_head.next),
@@ -3300,7 +3301,7 @@ reset_bitmap_of_free_pages(unsigned long node_zones)
 		ERRMSG("Can't get free_pages.\n");
 		return FALSE;
 	}
-	if (free_pages != found_free_pages) {
+	if (free_pages != found_free_pages && !info->flag_cyclic) {
 		/*
 		 * On linux-2.6.21 or later, the number of free_pages is
 		 * sometimes different from the one of the list "free_area",
@@ -3640,6 +3641,32 @@ create_1st_bitmap(void)
 	return TRUE;
 }
 
+int
+create_1st_bitmap_cyclic()
+{
+	unsigned long long pfn, pfn_bitmap1;
+
+	/*
+	 * At first, clear all the bits on the 1st-bitmap.
+	 */
+	initialize_bitmap_cyclic(info->partial_bitmap1);
+
+	/*
+	 * If page is on memory hole, set bit on the 1st-bitmap.
+	 */
+	pfn_bitmap1 = 0;
+
+	for (pfn = info->split_start_pfn; pfn <	info->split_end_pfn; pfn++) {
+		if (is_in_segs(pfn_to_paddr(pfn))) {
+			set_bit_on_1st_bitmap(pfn);
+			pfn_bitmap1++;
+		}
+	}
+	pfn_memhole -= pfn_bitmap1;
+
+	return TRUE;
+}
+
 /*
  * Exclude the page filled with zero in case of creating an elf dumpfile.
  */
@@ -3680,8 +3707,8 @@ exclude_zero_pages(void)
 			}
 		}
 		if (is_zero_page(buf, info->page_size)) {
-			clear_bit_on_2nd_bitmap(pfn);
-			pfn_zero++;
+			if (clear_bit_on_2nd_bitmap(pfn))
+				pfn_zero++;
 		}
 	}
 
@@ -3758,8 +3785,8 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 		if ((info->dump_level & DL_EXCLUDE_CACHE)
 		    && (isLRU(flags) || isSwapCache(flags))
 		    && !isPrivate(flags) && !isAnon(mapping)) {
-			clear_bit_on_2nd_bitmap_for_kernel(pfn);
-			pfn_cache++;
+			if (clear_bit_on_2nd_bitmap_for_kernel(pfn))
+				pfn_cache++;
 		}
 		/*
 		 * Exclude the cache page with the private page.
@@ -3767,16 +3794,16 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 		else if ((info->dump_level & DL_EXCLUDE_CACHE_PRI)
 		    && (isLRU(flags) || isSwapCache(flags))
 		    && !isAnon(mapping)) {
-			clear_bit_on_2nd_bitmap_for_kernel(pfn);
-			pfn_cache_private++;
+			if (clear_bit_on_2nd_bitmap_for_kernel(pfn))
+				pfn_cache_private++;
 		}
 		/*
 		 * Exclude the data page of the user process.
 		 */
 		else if ((info->dump_level & DL_EXCLUDE_USER_DATA)
 		    && isAnon(mapping)) {
-			clear_bit_on_2nd_bitmap_for_kernel(pfn);
-			pfn_user++;
+			if (clear_bit_on_2nd_bitmap_for_kernel(pfn))
+				pfn_user++;
 		}
 	}
 	return TRUE;
@@ -3813,6 +3840,44 @@ exclude_unnecessary_pages(void)
 	return TRUE;
 }
 
+void
+copy_bitmap_cyclic(void)
+{
+	memcpy(info->partial_bitmap2, info->partial_bitmap1, BUFSIZE_CYCLIC);
+}
+
+int
+exclude_unnecessary_pages_cyclic(void)
+{
+	unsigned int mm;
+	struct mem_map_data *mmd;
+
+	/*
+	 * Copy 1st-bitmap to 2nd-bitmap.
+	 */
+	copy_bitmap_cyclic();
+
+	if (info->dump_level & DL_EXCLUDE_FREE)
+		if (!exclude_free_page())
+			return FALSE;
+
+	for (mm = 0; mm < info->num_mem_map; mm++) {
+
+		mmd = &info->mem_map_data[mm];
+
+		if (mmd->mem_map == NOT_MEMMAP_ADDR)
+			continue;
+
+		if (mmd->pfn_end >= info->split_start_pfn || mmd->pfn_start <= info->split_end_pfn) {
+			if (!__exclude_unnecessary_pages(mmd->mem_map,
+							 mmd->pfn_start, mmd->pfn_end))
+				return FALSE;
+		}
+	}
+
+	return TRUE;
+}
+
 int
 copy_bitmap(void)
 {
@@ -3954,6 +4019,39 @@ prepare_bitmap_buffer(void)
 	return TRUE;
 }
 
+int
+prepare_bitmap_buffer_cyclic(void)
+{
+	unsigned long tmp;
+
+	/*
+	 * Create 2 bitmaps (1st-bitmap & 2nd-bitmap) on block_size boundary.
+	 * The crash utility requires both of them to be aligned to block_size
+	 * boundary.
+	 */
+	tmp = divideup(divideup(info->max_mapnr, BITPERBYTE), info->page_size);
+	info->len_bitmap = tmp*info->page_size*2;
+
+
+	/*
+	 * Prepare bitmap buffers for creating dump bitmap.
+	 */
+	if ((info->partial_bitmap1 = (char *)malloc(BUFSIZE_CYCLIC)) == NULL) {
+		ERRMSG("Can't allocate memory for the 1st-bitmap. %s\n",
+		       strerror(errno));
+		return FALSE;
+	}
+	if ((info->partial_bitmap2 = (char *)malloc(BUFSIZE_CYCLIC)) == NULL) {
+		ERRMSG("Can't allocate memory for the 2nd-bitmap. %s\n",
+		       strerror(errno));
+		return FALSE;
+	}
+	initialize_bitmap_cyclic(info->partial_bitmap1);
+	initialize_bitmap_cyclic(info->partial_bitmap2);
+
+	return TRUE;
+}
+
 void
 free_bitmap_buffer(void)
 {
@@ -3974,14 +4072,17 @@ create_dump_bitmap(void)
 {
 	int ret = FALSE;
 
-	if (!prepare_bitmap_buffer())
-		goto out;
-
-	if (!create_1st_bitmap())
-		goto out;
-
-	if (!create_2nd_bitmap())
-		goto out;
+	if (info->flag_cyclic) {
+		if (!prepare_bitmap_buffer_cyclic())
+			goto out;
+	} else {
+		if (!prepare_bitmap_buffer())
+			goto out;
+		if (!create_1st_bitmap())
+			goto out;
+		if (!create_2nd_bitmap())
+			goto out;
+	}
 
 	ret = TRUE;
 out:
@@ -4433,6 +4534,27 @@ get_num_dumpable(void)
 	return num_dumpable;
 }
 
+unsigned long long
+get_num_dumpable_cyclic(void)
+{
+	unsigned long long pfn, num_dumpable;
+
+	if (!create_1st_bitmap_cyclic())
+		return FALSE;
+
+	/*
+	 * Create 2nd bitmap partially.
+	 */
+	if (!exclude_unnecessary_pages_cyclic())
+		return FALSE;
+
+	for (pfn = info->split_start_pfn, num_dumpable = 0; pfn < info->split_end_pfn; pfn++) {
+		if (is_dumpable_cyclic(info->partial_bitmap2, pfn)) {
+			num_dumpable++;
+		} 
+	}
+	return num_dumpable;
+}
 
 int
 write_elf_load_segment(struct cache_data *cd_page, unsigned long long paddr,
@@ -4481,7 +4603,7 @@ write_elf_pages(struct cache_data *cd_header, struct cache_data *cd_page)
 	int i, phnum;
 	long page_size = info->page_size;
 	unsigned long long pfn, pfn_start, pfn_end, paddr, num_excluded;
-	unsigned long long num_dumpable, num_dumped = 0, per;
+	unsigned long long num_dumpable, per;
 	unsigned long long memsz, filesz;
 	unsigned long frac_head, frac_tail;
 	off_t off_seg_load, off_memory;
@@ -4738,7 +4860,7 @@ read_pfn(unsigned long long pfn, unsigned char *buf)
 int
 write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
 {
- 	unsigned long long pfn, per, num_dumpable, num_dumped = 0;
+ 	unsigned long long pfn, per, num_dumpable;
 	unsigned long long start_pfn, end_pfn;
 	unsigned long size_out;
 	struct page_desc pd, pd_zero;
@@ -6557,7 +6679,7 @@ reassemble_kdump_pages(void)
 	off_t offset_first_ph, offset_ph_org, offset_eraseinfo;
 	off_t offset_data_new, offset_zero_page = 0;
 	unsigned long long pfn, start_pfn, end_pfn;
-	unsigned long long num_dumpable, num_dumped;
+	unsigned long long num_dumpable;
 	unsigned long size_eraseinfo;
 	struct dump_bitmap bitmap2;
 	struct disk_dump_header dh;
@@ -7242,6 +7364,10 @@ out:
 			free(info->splitting_info);
 		if (info->p2m_mfn_frame_list != NULL)
 			free(info->p2m_mfn_frame_list);
+		if (info->partial_bitmap1 != NULL)
+			free(info->partial_bitmap1);
+		if (info->partial_bitmap2 != NULL)
+			free(info->partial_bitmap2);
 		free(info);
 	}
 	free_elf_info();
diff --git a/makedumpfile.h b/makedumpfile.h
index c72021a..a8aab2a 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -937,6 +937,7 @@ struct DumpInfo {
 	 */
 	char            *partial_bitmap1;
 	char            *partial_bitmap2;
+	unsigned long long num_dumpable;
 
 	/*
 	 * sadump info:
-- 
1.7.9.2

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
