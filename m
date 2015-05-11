Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YrhP3-00070s-KP
 for kexec@lists.infradead.org; Mon, 11 May 2015 06:41:27 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.197])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id t4B6f48e007673
 for <kexec@lists.infradead.org>; Mon, 11 May 2015 15:41:04 +0900 (JST)
Received: from mailsv4.nec.co.jp (imss61.nec.co.jp [10.7.69.156]) by
 mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC) with ESMTP
 id t4B6f4c12528 for <kexec@lists.infradead.org>;
 Mon, 11 May 2015 15:41:04 +0900 (JST)
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
 by mailsv4.nec.co.jp (8.13.8/8.13.4) with ESMTP id t4B6f3nj012745
 for <kexec@lists.infradead.org>; Mon, 11 May 2015 15:41:03 +0900 (JST)
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: [PATCH 04/13] Integrate the main logic of writing kdump file.
Date: Mon, 11 May 2015 06:25:19 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701DAA350@BPXM01GP.gisp.nec.co.jp>
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

There are two main path of writing kdump file, write_kdump_pages()
and write_kdump_pages_cyclic(). They are almost the same logic, but
implemented as the separated code. It should be merged for
maintainability.

Signed-off-by: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
---
 makedumpfile.c | 492 ++++++++++++++++++++++++++++-----------------------------
 makedumpfile.h |   2 -
 2 files changed, 241 insertions(+), 253 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 41da4bf..4c26d05 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3264,6 +3264,12 @@ out:
 		if (info->bufsize_cyclic == 0) {
 			if (!calculate_cyclic_buffer_size())
 				return FALSE;
+
+			if (info->bufsize_cyclic * BITPERBYTE >= info->max_mapnr * 2) {
+				DEBUG_MSG("There is enough free memory to be done");
+				DEBUG_MSG(" in one cycle.\n");
+				info->flag_cyclic = FALSE;
+			}
 		} else {
 			unsigned long long free_memory;
 
@@ -3371,19 +3377,17 @@ out:
 void
 initialize_bitmap(struct dump_bitmap *bitmap)
 {
-	bitmap->fd        = info->fd_bitmap;
-	bitmap->file_name = info->name_bitmap;
-	bitmap->no_block  = -1;
-	memset(bitmap->buf, 0, BUFSIZE_BITMAP);
-}
-
-void
-initialize_bitmap_cyclic(struct dump_bitmap *bitmap)
-{
-	bitmap->fd        = 0;
-	bitmap->file_name = NULL;
-	bitmap->no_block  = -1;
-	memset(bitmap->buf, 0, info->bufsize_cyclic);
+	if (info->fd_bitmap) {
+		bitmap->fd        = info->fd_bitmap;
+		bitmap->file_name = info->name_bitmap;
+		bitmap->no_block  = -1;
+		memset(bitmap->buf, 0, BUFSIZE_BITMAP);
+	} else {
+		bitmap->fd        = 0;
+		bitmap->file_name = NULL;
+		bitmap->no_block  = -1;
+		memset(bitmap->buf, 0, info->bufsize_cyclic);
+	}
 }
 
 void
@@ -3401,7 +3405,7 @@ initialize_2nd_bitmap(struct dump_bitmap *bitmap)
 }
 
 int
-set_bitmap(struct dump_bitmap *bitmap, mdf_pfn_t pfn, int val)
+set_bitmap_file(struct dump_bitmap *bitmap, mdf_pfn_t pfn, int val)
 {
 	int byte, bit;
 	off_t old_offset, new_offset;
@@ -3449,7 +3453,7 @@ set_bitmap(struct dump_bitmap *bitmap, mdf_pfn_t pfn, int val)
 }
 
 int
-set_bitmap_cyclic(struct dump_bitmap *bitmap, mdf_pfn_t pfn, int val, struct cycle *cycle)
+set_bitmap_buffer(struct dump_bitmap *bitmap, mdf_pfn_t pfn, int val, struct cycle *cycle)
 {
 	int byte, bit;
 	static int warning = 0;
@@ -3477,12 +3481,27 @@ set_bitmap_cyclic(struct dump_bitmap *bitmap, mdf_pfn_t pfn, int val, struct cyc
 }
 
 int
+set_bitmap(struct dump_bitmap *bitmap, mdf_pfn_t pfn, int val, struct cycle *cycle)
+{
+	if (bitmap->fd) {
+		return set_bitmap_file(bitmap, pfn, val);
+	} else {
+		return set_bitmap_buffer(bitmap, pfn, val, cycle);
+	}
+}
+
+int
 sync_bitmap(struct dump_bitmap *bitmap)
 {
 	off_t offset;
 	offset = bitmap->offset + BUFSIZE_BITMAP * bitmap->no_block;
 
 	/*
+	 * The bitmap doesn't have the fd, it's a on-memory bitmap.
+	 */
+	if (bitmap->fd == 0)
+		return TRUE;
+	/*
 	 * The bitmap buffer is not dirty, and it is not necessary
 	 * to write out it.
 	 */
@@ -3518,31 +3537,20 @@ sync_2nd_bitmap(void)
 int
 set_bit_on_1st_bitmap(mdf_pfn_t pfn, struct cycle *cycle)
 {
-	if (info->flag_cyclic) {
-		return set_bitmap_cyclic(info->partial_bitmap1, pfn, 1, cycle);
-	} else {
-		return set_bitmap(info->bitmap1, pfn, 1);
-	}
+	return set_bitmap(info->bitmap1, pfn, 1, cycle);
 }
 
 int
 clear_bit_on_1st_bitmap(mdf_pfn_t pfn, struct cycle *cycle)
 {
-	if (info->flag_cyclic) {
-		return set_bitmap_cyclic(info->partial_bitmap1, pfn, 0, cycle);
-	} else {
-		return set_bitmap(info->bitmap1, pfn, 0);
-	}
+	return set_bitmap(info->bitmap1, pfn, 0, cycle);
+
 }
 
 int
 clear_bit_on_2nd_bitmap(mdf_pfn_t pfn, struct cycle *cycle)
 {
-	if (info->flag_cyclic) {
-		return set_bitmap_cyclic(info->partial_bitmap2, pfn, 0, cycle);
-	} else {
-		return set_bitmap(info->bitmap2, pfn, 0);
-	}
+	return set_bitmap(info->bitmap2, pfn, 0, cycle);
 }
 
 int
@@ -3565,11 +3573,7 @@ clear_bit_on_2nd_bitmap_for_kernel(mdf_pfn_t pfn, struct cycle *cycle)
 int
 set_bit_on_2nd_bitmap(mdf_pfn_t pfn, struct cycle *cycle)
 {
-	if (info->flag_cyclic) {
-		return set_bitmap_cyclic(info->partial_bitmap2, pfn, 1, cycle);
-	} else {
-		return set_bitmap(info->bitmap2, pfn, 1);
-	}
+	return set_bitmap(info->bitmap2, pfn, 1, cycle);
 }
 
 int
@@ -4623,7 +4627,7 @@ copy_1st_bitmap_from_memory(void)
 }
 
 int
-create_1st_bitmap(void)
+create_1st_bitmap_file(void)
 {
 	int i;
 	unsigned int num_pt_loads = get_num_pt_loads();
@@ -4697,7 +4701,7 @@ create_1st_bitmap(void)
 
 
 int
-create_1st_bitmap_cyclic(struct cycle *cycle)
+create_1st_bitmap_buffer(struct cycle *cycle)
 {
 	int i;
 	mdf_pfn_t pfn;
@@ -4709,7 +4713,7 @@ create_1st_bitmap_cyclic(struct cycle *cycle)
 	/*
 	 * At first, clear all the bits on the 1st-bitmap.
 	 */
-	initialize_bitmap_cyclic(info->partial_bitmap1);
+	initialize_bitmap(info->bitmap1);
 
 	/*
 	 * If page is on memory hole, set bit on the 1st-bitmap.
@@ -4734,7 +4738,7 @@ create_1st_bitmap_cyclic(struct cycle *cycle)
 		pfn_end_byte = (pfn_end_round - cycle->start_pfn) >> 3;
 
 		if (pfn_start_byte < pfn_end_byte) {
-			memset(info->partial_bitmap1->buf + pfn_start_byte,
+			memset(info->bitmap1->buf + pfn_start_byte,
 			       0xff,
 			       pfn_end_byte - pfn_start_byte);
 		}
@@ -4749,6 +4753,16 @@ create_1st_bitmap_cyclic(struct cycle *cycle)
 	return TRUE;
 }
 
+int
+create_1st_bitmap(struct cycle *cycle)
+{
+	if (info->bitmap1->fd) {
+		return create_1st_bitmap_file();
+	} else {
+		return create_1st_bitmap_buffer(cycle);
+	}
+}
+
 /*
  * Exclude the page filled with zero in case of creating an elf dumpfile.
  */
@@ -4817,7 +4831,7 @@ exclude_zero_pages_cyclic(struct cycle *cycle)
 		if (!is_in_segs(paddr))
 			continue;
 
-		if (!is_dumpable(info->partial_bitmap2, pfn, cycle))
+		if (!is_dumpable(info->bitmap2, pfn, cycle))
 			continue;
 
 		if (is_xen_memory()) {
@@ -4842,7 +4856,6 @@ exclude_zero_pages_cyclic(struct cycle *cycle)
 	return TRUE;
 }
 
-
 static int
 initialize_2nd_bitmap_cyclic(struct cycle *cycle)
 {
@@ -4856,7 +4869,7 @@ initialize_2nd_bitmap_cyclic(struct cycle *cycle)
 	/*
 	 * At first, clear all the bits on the 2nd-bitmap.
 	 */
-	initialize_bitmap_cyclic(info->partial_bitmap2);
+	initialize_bitmap(info->bitmap2);
 
 	/*
 	 * If page is on memory hole, set bit on the 2nd-bitmap.
@@ -4882,7 +4895,7 @@ initialize_2nd_bitmap_cyclic(struct cycle *cycle)
 		pfn_end_byte = (pfn_end_round - cycle->start_pfn) >> 3;
 
 		if (pfn_start_byte < pfn_end_byte) {
-			memset(info->partial_bitmap2->buf + pfn_start_byte,
+			memset(info->bitmap2->buf + pfn_start_byte,
 			       0xff,
 			       pfn_end_byte - pfn_start_byte);
 			pfn_memhole -= (pfn_end_byte - pfn_start_byte) << 3;
@@ -5096,7 +5109,7 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 }
 
 int
-exclude_unnecessary_pages(void)
+exclude_unnecessary_pages(struct cycle *cycle)
 {
 	unsigned int mm;
 	struct mem_map_data *mmd;
@@ -5110,85 +5123,43 @@ exclude_unnecessary_pages(void)
 	gettimeofday(&tv_start, NULL);
 
 	for (mm = 0; mm < info->num_mem_map; mm++) {
-		print_progress(PROGRESS_UNN_PAGES, mm, info->num_mem_map);
+
+		if (!info->flag_mem_usage)
+			print_progress(PROGRESS_UNN_PAGES, mm, info->num_mem_map);
 
 		mmd = &info->mem_map_data[mm];
 
 		if (mmd->mem_map == NOT_MEMMAP_ADDR)
 			continue;
 
-		if (!__exclude_unnecessary_pages(mmd->mem_map,
-						 mmd->pfn_start, mmd->pfn_end, NULL))
-			return FALSE;
+		if (mmd->pfn_end >= cycle->start_pfn &&
+		    mmd->pfn_start <= cycle->end_pfn) {
+			if (!__exclude_unnecessary_pages(mmd->mem_map,
+							 mmd->pfn_start, mmd->pfn_end, cycle))
+				return FALSE;
+		}
 	}
-
 	/*
 	 * print [100 %]
 	 */
-	print_progress(PROGRESS_UNN_PAGES, info->num_mem_map, info->num_mem_map);
-	print_execution_time(PROGRESS_UNN_PAGES, &tv_start);
+	if (!info->flag_mem_usage) {
+		print_progress(PROGRESS_UNN_PAGES, info->num_mem_map, info->num_mem_map);
+		print_execution_time(PROGRESS_UNN_PAGES, &tv_start);
+	}
 
 	return TRUE;
 }
 
 int
-exclude_unnecessary_pages_cyclic(struct cycle *cycle)
+copy_bitmap_buffer(void)
 {
-	unsigned int mm;
-	struct mem_map_data *mmd;
-	struct timeval tv_start;
-
-	if (!initialize_2nd_bitmap_cyclic(cycle))
-		return FALSE;
-
-	if ((info->dump_level & DL_EXCLUDE_FREE) && !info->page_is_buddy)
-		if (!exclude_free_page(cycle))
-			return FALSE;
-
-	/*
-	 * Exclude cache pages, cache private pages, user data pages,
-	 * free pages and hwpoison pages.
-	 */
-	if (info->dump_level & DL_EXCLUDE_CACHE ||
-	    info->dump_level & DL_EXCLUDE_CACHE_PRI ||
-	    info->dump_level & DL_EXCLUDE_USER_DATA ||
-	    NUMBER(PG_hwpoison) != NOT_FOUND_NUMBER ||
-	    ((info->dump_level & DL_EXCLUDE_FREE) && info->page_is_buddy)) {
-
-		gettimeofday(&tv_start, NULL);
-
-		for (mm = 0; mm < info->num_mem_map; mm++) {
-
-			if (!info->flag_mem_usage)
-				print_progress(PROGRESS_UNN_PAGES, mm, info->num_mem_map);
-
-			mmd = &info->mem_map_data[mm];
-
-			if (mmd->mem_map == NOT_MEMMAP_ADDR)
-				continue;
-
-			if (mmd->pfn_end >= cycle->start_pfn &&
-			    mmd->pfn_start <= cycle->end_pfn) {
-				if (!__exclude_unnecessary_pages(mmd->mem_map,
-								 mmd->pfn_start, mmd->pfn_end, cycle))
-					return FALSE;
-			}
-		}
-
-		/*
-		 * print [100 %]
-		 */
-		if (!info->flag_mem_usage) {
-			print_progress(PROGRESS_UNN_PAGES, info->num_mem_map, info->num_mem_map);
-			print_execution_time(PROGRESS_UNN_PAGES, &tv_start);
-		}
-	}
-
+	memcpy(info->bitmap2->buf, info->bitmap1->buf,
+	       info->bufsize_cyclic);
 	return TRUE;
 }
 
 int
-copy_bitmap(void)
+copy_bitmap_file(void)
 {
 	off_t offset;
 	unsigned char buf[info->page_size];
@@ -5225,14 +5196,30 @@ copy_bitmap(void)
 }
 
 int
-create_2nd_bitmap(void)
+copy_bitmap(void)
+{
+	if (info->fd_bitmap) {
+		return copy_bitmap_file();
+	} else {
+		return copy_bitmap_buffer();
+	}
+}
+
+int
+create_2nd_bitmap(struct cycle *cycle)
 {
 	/*
-	 * Copy 1st-bitmap to 2nd-bitmap.
+	 * At first, clear all the bits on memory hole.
 	 */
-	if (!copy_bitmap()) {
-		ERRMSG("Can't copy 1st-bitmap to 2nd-bitmap.\n");
-		return FALSE;
+	if (info->flag_cyclic) {
+		/* Have to do it from scratch. */
+		initialize_2nd_bitmap_cyclic(cycle);
+	} else {
+		/* Can copy 1st-bitmap to 2nd-bitmap. */
+		if (!copy_bitmap()) {
+			ERRMSG("Can't copy 1st-bitmap to 2nd-bitmap.\n");
+			return FALSE;
+		}
 	}
 
 	/*
@@ -5244,7 +5231,7 @@ create_2nd_bitmap(void)
 	    info->dump_level & DL_EXCLUDE_USER_DATA ||
 	    NUMBER(PG_hwpoison) != NOT_FOUND_NUMBER ||
 	    ((info->dump_level & DL_EXCLUDE_FREE) && info->page_is_buddy)) {
-		if (!exclude_unnecessary_pages()) {
+		if (!exclude_unnecessary_pages(cycle)) {
 			ERRMSG("Can't exclude unnecessary pages.\n");
 			return FALSE;
 		}
@@ -5254,7 +5241,7 @@ create_2nd_bitmap(void)
 	 * Exclude free pages.
 	 */
 	if ((info->dump_level & DL_EXCLUDE_FREE) && !info->page_is_buddy)
-		if (!exclude_free_page(NULL))
+		if (!exclude_free_page(cycle))
 			return FALSE;
 
 	/*
@@ -5300,60 +5287,37 @@ create_2nd_bitmap(void)
 }
 
 int
-prepare_bitmap_buffer(void)
+prepare_bitmap1_buffer(void)
 {
-	unsigned long long tmp;
-
 	/*
-	 * Create 2 bitmaps (1st-bitmap & 2nd-bitmap) on block_size boundary.
-	 * The crash utility requires both of them to be aligned to block_size
-	 * boundary.
-	 */
-	tmp = divideup(divideup(info->max_mapnr, BITPERBYTE), info->page_size);
-	info->len_bitmap = tmp*info->page_size*2;
-
-	/*
-	 * Prepare bitmap buffers for creating dump bitmap.
+	 * Prepare bitmap buffers for cyclic processing.
 	 */
 	if ((info->bitmap1 = malloc(sizeof(struct dump_bitmap))) == NULL) {
-		ERRMSG("Can't allocate memory for the 1st-bitmap. %s\n",
-		    strerror(errno));
-		return FALSE;
-	}
-	if ((info->bitmap2 = malloc(sizeof(struct dump_bitmap))) == NULL) {
-		ERRMSG("Can't allocate memory for the 2nd-bitmap. %s\n",
-		    strerror(errno));
-		return FALSE;
-	}
-	initialize_1st_bitmap(info->bitmap1);
-	initialize_2nd_bitmap(info->bitmap2);
-
-	return TRUE;
-}
-
-int
-prepare_bitmap1_buffer_cyclic(void)
-{
-	/*
-	 * Prepare partial bitmap buffers for cyclic processing.
-	 */
-	if ((info->partial_bitmap1 = malloc(sizeof(struct dump_bitmap))) == NULL) {
 		ERRMSG("Can't allocate memory for the 1st bitmaps. %s\n",
 		       strerror(errno));
 		return FALSE;
 	}
-	if ((info->partial_bitmap1->buf = (char *)malloc(info->bufsize_cyclic)) == NULL) {
-		ERRMSG("Can't allocate memory for the 1st bitmaps's buffer. %s\n",
-		       strerror(errno));
-		return FALSE;
+
+	if (info->fd_bitmap) {
+		if ((info->bitmap1->buf = (char *)malloc(BUFSIZE_BITMAP)) == NULL) {
+			ERRMSG("Can't allocate memory for the 1st bitmaps's buffer. %s\n",
+			       strerror(errno));
+			return FALSE;
+		}
+	} else {
+		if ((info->bitmap1->buf = (char *)malloc(info->bufsize_cyclic)) == NULL) {
+			ERRMSG("Can't allocate memory for the 1st bitmaps's buffer. %s\n",
+			       strerror(errno));
+			return FALSE;
+		}
 	}
-	initialize_bitmap_cyclic(info->partial_bitmap1);
+	initialize_1st_bitmap(info->bitmap1);
 
 	return TRUE;
 }
 
 int
-prepare_bitmap2_buffer_cyclic(void)
+prepare_bitmap2_buffer(void)
 {
 	unsigned long tmp;
 
@@ -5366,19 +5330,39 @@ prepare_bitmap2_buffer_cyclic(void)
 	info->len_bitmap = tmp * info->page_size * 2;
 
 	/*
-	 * Prepare partial bitmap buffers for cyclic processing.
+	 * Prepare bitmap buffers for cyclic processing.
 	 */
-	if ((info->partial_bitmap2 = malloc(sizeof(struct dump_bitmap))) == NULL) {
+	if ((info->bitmap2 = malloc(sizeof(struct dump_bitmap))) == NULL) {
 		ERRMSG("Can't allocate memory for the 2nd bitmaps. %s\n",
 		       strerror(errno));
 		return FALSE;
 	}
-	if ((info->partial_bitmap2->buf = (char *)malloc(info->bufsize_cyclic)) == NULL) {
-		ERRMSG("Can't allocate memory for the 2nd bitmaps's buffer. %s\n",
-		       strerror(errno));
-		return FALSE;
+	if (info->fd_bitmap) {
+		if ((info->bitmap2->buf = (char *)malloc(BUFSIZE_BITMAP)) == NULL) {
+			ERRMSG("Can't allocate memory for the 2nd bitmaps's buffer. %s\n",
+			       strerror(errno));
+			return FALSE;
+		}
+	} else {
+		if ((info->bitmap2->buf = (char *)malloc(info->bufsize_cyclic)) == NULL) {
+			ERRMSG("Can't allocate memory for the 2nd bitmaps's buffer. %s\n",
+			       strerror(errno));
+			return FALSE;
+		}
 	}
-	initialize_bitmap_cyclic(info->partial_bitmap2);
+	initialize_2nd_bitmap(info->bitmap2);
+
+	return TRUE;
+}
+
+int
+prepare_bitmap_buffer(void)
+{
+	/*
+	 * Prepare bitmap buffers for creating dump bitmap.
+	 */
+	prepare_bitmap1_buffer();
+	prepare_bitmap2_buffer();
 
 	return TRUE;
 }
@@ -5416,39 +5400,13 @@ free_bitmap_buffer(void)
 	free_bitmap2_buffer();
 }
 
-void
-free_bitmap1_buffer_cyclic()
-{
-	if (info->partial_bitmap1 != NULL){
-		if (info->partial_bitmap1->buf != NULL) {
-			free(info->partial_bitmap1->buf);
-			info->partial_bitmap1->buf = NULL;
-		}
-		free(info->partial_bitmap1);
-		info->partial_bitmap1 = NULL;
-	}
-}
-
-void
-free_bitmap2_buffer_cyclic()
-{
-	if (info->partial_bitmap2 != NULL){
-		if (info->partial_bitmap2->buf != NULL) {
-			free(info->partial_bitmap2->buf);
-			info->partial_bitmap2->buf = NULL;
-		}
-		free(info->partial_bitmap2);
-		info->partial_bitmap2 = NULL;
-	}
-}
-
 int
 create_dump_bitmap(void)
 {
 	int ret = FALSE;
 
 	if (info->flag_cyclic) {
-		if (!prepare_bitmap2_buffer_cyclic())
+		if (!prepare_bitmap2_buffer())
 			goto out;
 		if (info->flag_split) {
 			if (!prepare_splitblock_table())
@@ -5460,22 +5418,29 @@ create_dump_bitmap(void)
 		}
 
 		if (!info->flag_elf_dumpfile)
-			free_bitmap2_buffer_cyclic();
+			free_bitmap2_buffer();
 
 	} else {
+		struct cycle cycle = {0};
+		first_cycle(0, info->max_mapnr, &cycle);
 		if (!prepare_bitmap_buffer())
 			goto out;
 
-		if (!create_1st_bitmap())
+		pfn_memhole = info->max_mapnr;
+		if (!create_1st_bitmap(&cycle))
 			goto out;
 
-		if (!create_2nd_bitmap())
+		if (!create_2nd_bitmap(&cycle))
 			goto out;
+
+		info->num_dumpable = get_num_dumpable_cyclic();
 	}
 
 	ret = TRUE;
 out:
-	free_bitmap_buffer();
+	/* Should keep the buffer in the 1-cycle case. */
+	if (info->flag_cyclic)
+		free_bitmap_buffer();
 
 	return ret;
 }
@@ -6086,14 +6051,14 @@ get_num_dumpable_cyclic_withsplit(void)
 	pfn_memhole = info->max_mapnr;
 
 	for_each_cycle(0, info->max_mapnr, &cycle) {
-		if (!exclude_unnecessary_pages_cyclic(&cycle))
+		if (!create_2nd_bitmap(&cycle))
 			return FALSE;
 
 		if (info->flag_mem_usage)
 			exclude_zero_pages_cyclic(&cycle);
 
 		for (pfn = cycle.start_pfn; pfn < cycle.end_pfn; pfn++) {
-			if (is_dumpable(info->partial_bitmap2, pfn, &cycle)) {
+			if (is_dumpable(info->bitmap2, pfn, &cycle)) {
 				num_dumpable++;
 				dumpable_pfn_num++;
 			}
@@ -6116,18 +6081,18 @@ get_num_dumpable_cyclic(void)
 	mdf_pfn_t pfn, num_dumpable=0;
 	struct cycle cycle = {0};
 
-	pfn_memhole = info->max_mapnr;
-
 	for_each_cycle(0, info->max_mapnr, &cycle)
 	{
-		if (!exclude_unnecessary_pages_cyclic(&cycle))
-			return FALSE;
+		if (info->flag_cyclic) {
+			if (!create_2nd_bitmap(&cycle))
+				return FALSE;
+		}
 
 		if (info->flag_mem_usage)
 			exclude_zero_pages_cyclic(&cycle);
 
 		for(pfn=cycle.start_pfn; pfn<cycle.end_pfn; pfn++)
-			if (is_dumpable(info->partial_bitmap2, pfn, &cycle))
+			if (is_dumpable(info->bitmap2, pfn, &cycle))
 				num_dumpable++;
 	}
 
@@ -6414,10 +6379,10 @@ get_loads_dumpfile_cyclic(void)
 			pfn_end++;
 
 		for_each_cycle(pfn_start, pfn_end, &cycle) {
-			if (!exclude_unnecessary_pages_cyclic(&cycle))
+			if (!create_2nd_bitmap(&cycle))
 				return FALSE;
 			for (pfn = MAX(pfn_start, cycle.start_pfn); pfn < cycle.end_pfn; pfn++) {
-				if (!is_dumpable(info->partial_bitmap2, pfn, &cycle)) {
+				if (!is_dumpable(info->bitmap2, pfn, &cycle)) {
 					num_excluded++;
 					continue;
 				}
@@ -6519,11 +6484,11 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 			/*
 			 * Update target region and partial bitmap if necessary.
 			 */
-			if (!exclude_unnecessary_pages_cyclic(&cycle))
+			if (!create_2nd_bitmap(&cycle))
 				return FALSE;
 
 			for (pfn = MAX(pfn_start, cycle.start_pfn); pfn < cycle.end_pfn; pfn++) {
-				if (!is_dumpable(info->partial_bitmap2, pfn, &cycle)) {
+				if (!is_dumpable(info->bitmap2, pfn, &cycle)) {
 					num_excluded++;
 					if ((pfn == pfn_end - 1) && frac_tail)
 						memsz += frac_tail;
@@ -6664,7 +6629,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 	if (!write_cache_bufsz(cd_page))
 		return FALSE;
 
-	free_bitmap2_buffer_cyclic();
+	free_bitmap2_buffer();
 
 	/*
 	 * print [100 %]
@@ -6963,11 +6928,10 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
 		/*
 		 * Check the excluded page.
 		 */
-		if (!is_on(info->partial_bitmap2->buf, pfn - cycle->start_pfn))
+		if (!is_dumpable(info->bitmap2, pfn, cycle))
 			continue;
 
 		num_dumped++;
-
 		if (!read_pfn(pfn, buf))
 			goto out;
 		filter_data_buffer(buf, pfn_to_paddr(pfn), info->page_size);
@@ -7273,7 +7237,7 @@ write_kdump_eraseinfo(struct cache_data *cd_page)
 }
 
 int
-write_kdump_bitmap(void)
+write_kdump_bitmap_file(struct dump_bitmap *bitmap)
 {
 	struct cache_data bm;
 	long long buf_size;
@@ -7286,7 +7250,7 @@ write_kdump_bitmap(void)
 
 	bm.fd        = info->fd_bitmap;
 	bm.file_name = info->name_bitmap;
-	bm.offset    = 0;
+	bm.offset    = bitmap->offset;
 	bm.buf       = NULL;
 
 	if ((bm.buf = calloc(1, BUFSIZE_BITMAP)) == NULL) {
@@ -7294,9 +7258,8 @@ write_kdump_bitmap(void)
 		    strerror(errno));
 		goto out;
 	}
-	offset = info->offset_bitmap1;
-	buf_size = info->len_bitmap;
-
+	buf_size = info->len_bitmap / 2;
+	offset = info->offset_bitmap1 + bitmap->offset;
 	while (buf_size > 0) {
 		if (buf_size >= BUFSIZE_BITMAP)
 			bm.cache_size = BUFSIZE_BITMAP;
@@ -7322,7 +7285,19 @@ out:
 }
 
 int
-write_kdump_bitmap1_cyclic(struct cycle *cycle)
+write_kdump_bitmap1_file(void)
+{
+	return write_kdump_bitmap_file(info->bitmap1);
+}
+
+int
+write_kdump_bitmap2_file(void)
+{
+	return write_kdump_bitmap_file(info->bitmap2);
+}
+
+int
+write_kdump_bitmap1_buffer(struct cycle *cycle)
 {
 	off_t offset;
         int increment;
@@ -7336,7 +7311,7 @@ write_kdump_bitmap1_cyclic(struct cycle *cycle)
 	offset = info->offset_bitmap1;
 	if (!write_buffer(info->fd_dumpfile, offset + info->bufsize_cyclic *
 			  (cycle->start_pfn / info->pfn_cyclic),
-			  info->partial_bitmap1->buf, increment, info->name_dumpfile))
+			  info->bitmap1->buf, increment, info->name_dumpfile))
 		goto out;
 
 	ret = TRUE;
@@ -7345,7 +7320,7 @@ out:
 }
 
 int
-write_kdump_bitmap2_cyclic(struct cycle *cycle)
+write_kdump_bitmap2_buffer(struct cycle *cycle)
 {
 	off_t offset;
 	int increment;
@@ -7360,7 +7335,7 @@ write_kdump_bitmap2_cyclic(struct cycle *cycle)
 	offset = info->offset_bitmap1;
 	offset += info->len_bitmap / 2;
 	if (!write_buffer(info->fd_dumpfile, offset,
-			  info->partial_bitmap2->buf, increment, info->name_dumpfile))
+			  info->bitmap2->buf, increment, info->name_dumpfile))
 		goto out;
 
 	info->offset_bitmap1 += increment;
@@ -7372,6 +7347,24 @@ out:
 }
 
 int
+write_kdump_bitmap1(struct cycle *cycle) {
+	if (info->bitmap1->fd) {
+		return write_kdump_bitmap1_file();
+	} else {
+		return write_kdump_bitmap1_buffer(cycle);
+	}
+}
+
+int
+write_kdump_bitmap2(struct cycle *cycle) {
+	if (info->bitmap2->fd) {
+		return write_kdump_bitmap2_file();
+	} else {
+		return write_kdump_bitmap2_buffer(cycle);
+	}
+}
+
+int
 write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 {
 	struct page_desc pd_zero;
@@ -7380,13 +7373,6 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
 	unsigned char buf[info->page_size];
 	struct timeval tv_start;
 
-	/*
-	 * Reset counter for debug message.
-	 */
-	pfn_zero = pfn_cache = pfn_cache_private = 0;
-	pfn_user = pfn_free = pfn_hwpoison = 0;
-	pfn_memhole = info->max_mapnr;
-
 	cd_header->offset
 		= (DISKDUMP_HEADER_BLOCKS + dh->sub_hdr_size + dh->bitmap_blocks)
 		* dh->block_size;
@@ -7407,26 +7393,37 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
 		offset_data += pd_zero.size;
 	}
 
-	/*
-	 * Write the 1st bitmap
-	 */
-	if (!prepare_bitmap1_buffer_cyclic())
-		return FALSE;
+	if (info->flag_cyclic) {
+		/*
+		 * Reset counter for debug message.
+		 */
+		pfn_zero = pfn_cache = pfn_cache_private = 0;
+		pfn_user = pfn_free = pfn_hwpoison = 0;
+		pfn_memhole = info->max_mapnr;
+
+		/*
+		 * Write the 1st bitmap
+		 */
+		if (!prepare_bitmap1_buffer())
+			return FALSE;
+	}
 
 	struct cycle cycle = {0};
 	for_each_cycle(0, info->max_mapnr, &cycle)
 	{
-		if (!create_1st_bitmap_cyclic(&cycle))
-			return FALSE;
-		if (!write_kdump_bitmap1_cyclic(&cycle))
+		if (info->flag_cyclic) {
+			if (!create_1st_bitmap(&cycle))
+				return FALSE;
+		}
+		if (!write_kdump_bitmap1(&cycle))
 			return FALSE;
 	}
 
-
-	free_bitmap1_buffer_cyclic();
-
-	if (!prepare_bitmap2_buffer_cyclic())
-		return FALSE;
+	free_bitmap1_buffer();
+	if (info->flag_cyclic) {
+		if (!prepare_bitmap2_buffer())
+			return FALSE;
+	}
 
 	/*
 	 * Write pages and bitmap cyclically.
@@ -7435,18 +7432,19 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
 	memset(&cycle, 0, sizeof(struct cycle));
 	for_each_cycle(0, info->max_mapnr, &cycle)
 	{
-		if (!exclude_unnecessary_pages_cyclic(&cycle))
-			return FALSE;
+		if (info->flag_cyclic) {
+			if (!create_2nd_bitmap(&cycle))
+				return FALSE;
+		}
 
-		if (!write_kdump_bitmap2_cyclic(&cycle))
+		if (!write_kdump_bitmap2(&cycle))
 			return FALSE;
 
 		if (!write_kdump_pages_cyclic(cd_header, cd_page, &pd_zero,
 					&offset_data, &cycle))
 			return FALSE;
 	}
-
-	free_bitmap2_buffer_cyclic();
+	free_bitmap2_buffer();
 
 	gettimeofday(&tv_start, NULL);
 
@@ -8441,19 +8439,10 @@ writeout_dumpfile(void)
 		}
 		if (!write_elf_eraseinfo(&cd_header))
 			goto out;
-	} else if (info->flag_cyclic) {
-		if (!write_kdump_header())
-			goto out;
-		if (!write_kdump_pages_and_bitmap_cyclic(&cd_header, &cd_page))
-			goto out;
-		if (!write_kdump_eraseinfo(&cd_page))
-			goto out;
 	} else {
 		if (!write_kdump_header())
 			goto out;
-		if (!write_kdump_bitmap())
-			goto out;
-		if (!write_kdump_pages(&cd_header, &cd_page))
+		if (!write_kdump_pages_and_bitmap_cyclic(&cd_header, &cd_page))
 			goto out;
 		if (!write_kdump_eraseinfo(&cd_page))
 			goto out;
@@ -8555,12 +8544,12 @@ setup_splitting(void)
 	if (info->flag_cyclic) {
 		int ret = FALSE;
 
-		if (!prepare_bitmap2_buffer_cyclic()) {
+		if (!prepare_bitmap2_buffer()) {
 			free_bitmap_buffer();
 			return ret;
 		}
 		ret = setup_splitting_cyclic();
-		free_bitmap2_buffer_cyclic();
+		free_bitmap2_buffer();
 
 		return ret;
         } else {
@@ -9633,7 +9622,8 @@ calculate_cyclic_buffer_size(void) {
 	 *  free memory for safety.
 	 */
 	limit_size = get_free_memory_size() * 0.6;
-	bitmap_size = info->max_mapnr / BITPERBYTE;
+	/* Try to keep both 1st and 2nd bitmap at the same time. */
+	bitmap_size = info->max_mapnr * 2 / BITPERBYTE;
 
 	/* if --split was specified cyclic buffer allocated per dump file */
 	if (info->num_dumpfile > 1)
@@ -9810,12 +9800,12 @@ int show_mem_usage(void)
 		return FALSE;
 
 
-	if (!prepare_bitmap2_buffer_cyclic())
+	if (!prepare_bitmap2_buffer())
 		return FALSE;
 
 	info->num_dumpable = get_num_dumpable_cyclic();
 
-	free_bitmap2_buffer_cyclic();
+	free_bitmap2_buffer();
 
 	print_mem_usage();
 
diff --git a/makedumpfile.h b/makedumpfile.h
index 303113d..824e8ef 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1149,8 +1149,6 @@ struct DumpInfo {
 	/*
 	 * for cyclic processing
 	 */
-	struct dump_bitmap *partial_bitmap1;
-	struct dump_bitmap *partial_bitmap2;
 	char	           *working_dir;	     /* working directory for bitmap */
 	mdf_pfn_t          num_dumpable;
 	unsigned long      bufsize_cyclic;
-- 
1.9.0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
