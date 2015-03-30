Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YcRCB-0000R9-N5
 for kexec@lists.infradead.org; Mon, 30 Mar 2015 04:21:06 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: [PATCH 4/6] WIP: Integrate the main logic of writing kdump file.
Date: Mon, 30 Mar 2015 04:09:39 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701D9CAC6@BPXM01GP.gisp.nec.co.jp>
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
Cc: "cpw@sgi.com" <cpw@sgi.com>

There are two main path of writing kdump file, write_kdump_pages()
and write_kdump_pages_cyclic(). They are almost the same logic, but
implemented as the separated code. It should be merged for
maintenancebility.

Signed-off-by: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
---
 makedumpfile.c |  489 +++++++++++++++++++++++++++-----------------------------
 makedumpfile.h |    2 -
 2 files changed, 239 insertions(+), 252 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index bab6ab3..605b6dc 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3289,6 +3289,11 @@ out:
 
 		DEBUG_MSG("\n");
 		DEBUG_MSG("Buffer size for the cyclic mode: %ld\n", info->bufsize_cyclic);
+
+		if (info->pfn_cyclic >= info->max_mapnr) {
+			DEBUG_MSG("Can run into one cycle.\n");
+			info->flag_cyclic = FALSE;
+		}
 	}
 
 	if (!is_xen_memory() && !cache_init())
@@ -3369,19 +3374,17 @@ out:
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
+	if (info->working_dir) {
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
@@ -3399,7 +3402,7 @@ initialize_2nd_bitmap(struct dump_bitmap *bitmap)
 }
 
 int
-set_bitmap(struct dump_bitmap *bitmap, mdf_pfn_t pfn, int val)
+set_bitmap_file(struct dump_bitmap *bitmap, mdf_pfn_t pfn, int val)
 {
 	int byte, bit;
 	off_t old_offset, new_offset;
@@ -3447,7 +3450,7 @@ set_bitmap(struct dump_bitmap *bitmap, mdf_pfn_t pfn, int val)
 }
 
 int
-set_bitmap_cyclic(struct dump_bitmap *bitmap, mdf_pfn_t pfn, int val, struct cycle *cycle)
+set_bitmap_buffer(struct dump_bitmap *bitmap, mdf_pfn_t pfn, int val, struct cycle *cycle)
 {
 	int byte, bit;
 	static int warning = 0;
@@ -3475,12 +3478,27 @@ set_bitmap_cyclic(struct dump_bitmap *bitmap, mdf_pfn_t pfn, int val, struct cyc
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
@@ -3516,31 +3534,20 @@ sync_2nd_bitmap(void)
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
@@ -3563,11 +3570,7 @@ clear_bit_on_2nd_bitmap_for_kernel(mdf_pfn_t pfn, struct cycle *cycle)
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
@@ -4621,7 +4624,7 @@ copy_1st_bitmap_from_memory(void)
 }
 
 int
-create_1st_bitmap(void)
+create_1st_bitmap_file(void)
 {
 	int i;
 	unsigned int num_pt_loads = get_num_pt_loads();
@@ -4695,7 +4698,7 @@ create_1st_bitmap(void)
 
 
 int
-create_1st_bitmap_cyclic(struct cycle *cycle)
+create_1st_bitmap_buffer(struct cycle *cycle)
 {
 	int i;
 	mdf_pfn_t pfn;
@@ -4707,7 +4710,7 @@ create_1st_bitmap_cyclic(struct cycle *cycle)
 	/*
 	 * At first, clear all the bits on the 1st-bitmap.
 	 */
-	initialize_bitmap_cyclic(info->partial_bitmap1);
+	initialize_bitmap(info->bitmap1);
 
 	/*
 	 * If page is on memory hole, set bit on the 1st-bitmap.
@@ -4732,7 +4735,7 @@ create_1st_bitmap_cyclic(struct cycle *cycle)
 		pfn_end_byte = (pfn_end_round - cycle->start_pfn) >> 3;
 
 		if (pfn_start_byte < pfn_end_byte) {
-			memset(info->partial_bitmap1->buf + pfn_start_byte,
+			memset(info->bitmap1->buf + pfn_start_byte,
 			       0xff,
 			       pfn_end_byte - pfn_start_byte);
 		}
@@ -4747,6 +4750,16 @@ create_1st_bitmap_cyclic(struct cycle *cycle)
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
@@ -4815,7 +4828,7 @@ exclude_zero_pages_cyclic(struct cycle *cycle)
 		if (!is_in_segs(paddr))
 			continue;
 
-		if (!is_dumpable(info->partial_bitmap2, pfn, cycle))
+		if (!is_dumpable(info->bitmap2, pfn, cycle))
 			continue;
 
 		if (is_xen_memory()) {
@@ -4840,7 +4853,6 @@ exclude_zero_pages_cyclic(struct cycle *cycle)
 	return TRUE;
 }
 
-
 static int
 initialize_2nd_bitmap_cyclic(struct cycle *cycle)
 {
@@ -4854,7 +4866,7 @@ initialize_2nd_bitmap_cyclic(struct cycle *cycle)
 	/*
 	 * At first, clear all the bits on the 2nd-bitmap.
 	 */
-	initialize_bitmap_cyclic(info->partial_bitmap2);
+	initialize_bitmap(info->bitmap2);
 
 	/*
 	 * If page is on memory hole, set bit on the 2nd-bitmap.
@@ -4880,7 +4892,7 @@ initialize_2nd_bitmap_cyclic(struct cycle *cycle)
 		pfn_end_byte = (pfn_end_round - cycle->start_pfn) >> 3;
 
 		if (pfn_start_byte < pfn_end_byte) {
-			memset(info->partial_bitmap2->buf + pfn_start_byte,
+			memset(info->bitmap2->buf + pfn_start_byte,
 			       0xff,
 			       pfn_end_byte - pfn_start_byte);
 			pfn_memhole -= (pfn_end_byte - pfn_start_byte) << 3;
@@ -5094,7 +5106,7 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 }
 
 int
-exclude_unnecessary_pages(void)
+exclude_unnecessary_pages(struct cycle *cycle)
 {
 	unsigned int mm;
 	struct mem_map_data *mmd;
@@ -5108,85 +5120,43 @@ exclude_unnecessary_pages(void)
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
@@ -5223,14 +5193,30 @@ copy_bitmap(void)
 }
 
 int
-create_2nd_bitmap(void)
+copy_bitmap(void)
+{
+	if (info->bitmap1->fd && info->bitmap2->fd) {
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
@@ -5240,8 +5226,9 @@ create_2nd_bitmap(void)
 	if (info->dump_level & DL_EXCLUDE_CACHE ||
 	    info->dump_level & DL_EXCLUDE_CACHE_PRI ||
 	    info->dump_level & DL_EXCLUDE_USER_DATA ||
-	    NUMBER(PG_hwpoison) != NOT_FOUND_NUMBER) {
-		if (!exclude_unnecessary_pages()) {
+	    NUMBER(PG_hwpoison) != NOT_FOUND_NUMBER ||
+	    ((info->dump_level & DL_EXCLUDE_FREE) && info->page_is_buddy)) {
+		if (!exclude_unnecessary_pages(cycle)) {
 			ERRMSG("Can't exclude unnecessary pages.\n");
 			return FALSE;
 		}
@@ -5297,60 +5284,37 @@ create_2nd_bitmap(void)
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
+	if (info->working_dir) {
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
 
@@ -5363,19 +5327,39 @@ prepare_bitmap2_buffer_cyclic(void)
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
+	if (info->working_dir) {
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
@@ -5413,39 +5397,13 @@ free_bitmap_buffer(void)
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
@@ -5457,22 +5415,29 @@ create_dump_bitmap(void)
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
@@ -6083,14 +6048,14 @@ get_num_dumpable_cyclic_withsplit(void)
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
@@ -6113,18 +6078,18 @@ get_num_dumpable_cyclic(void)
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
 
@@ -6411,10 +6376,10 @@ get_loads_dumpfile_cyclic(void)
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
@@ -6516,11 +6481,11 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
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
@@ -6661,7 +6626,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 	if (!write_cache_bufsz(cd_page))
 		return FALSE;
 
-	free_bitmap2_buffer_cyclic();
+	free_bitmap2_buffer();
 
 	/*
 	 * print [100 %]
@@ -6960,11 +6925,10 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
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
@@ -7270,7 +7234,7 @@ write_kdump_eraseinfo(struct cache_data *cd_page)
 }
 
 int
-write_kdump_bitmap(void)
+write_kdump_bitmap_file(struct dump_bitmap *bitmap)
 {
 	struct cache_data bm;
 	long long buf_size;
@@ -7283,7 +7247,7 @@ write_kdump_bitmap(void)
 
 	bm.fd        = info->fd_bitmap;
 	bm.file_name = info->name_bitmap;
-	bm.offset    = 0;
+	bm.offset    = bitmap->offset;
 	bm.buf       = NULL;
 
 	if ((bm.buf = calloc(1, BUFSIZE_BITMAP)) == NULL) {
@@ -7291,9 +7255,8 @@ write_kdump_bitmap(void)
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
@@ -7319,7 +7282,19 @@ out:
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
@@ -7333,7 +7308,7 @@ write_kdump_bitmap1_cyclic(struct cycle *cycle)
 	offset = info->offset_bitmap1;
 	if (!write_buffer(info->fd_dumpfile, offset + info->bufsize_cyclic *
 			  (cycle->start_pfn / info->pfn_cyclic),
-			  info->partial_bitmap1->buf, increment, info->name_dumpfile))
+			  info->bitmap1->buf, increment, info->name_dumpfile))
 		goto out;
 
 	ret = TRUE;
@@ -7342,7 +7317,7 @@ out:
 }
 
 int
-write_kdump_bitmap2_cyclic(struct cycle *cycle)
+write_kdump_bitmap2_buffer(struct cycle *cycle)
 {
 	off_t offset;
 	int increment;
@@ -7357,7 +7332,7 @@ write_kdump_bitmap2_cyclic(struct cycle *cycle)
 	offset = info->offset_bitmap1;
 	offset += info->len_bitmap / 2;
 	if (!write_buffer(info->fd_dumpfile, offset,
-			  info->partial_bitmap2->buf, increment, info->name_dumpfile))
+			  info->bitmap2->buf, increment, info->name_dumpfile))
 		goto out;
 
 	info->offset_bitmap1 += increment;
@@ -7369,6 +7344,24 @@ out:
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
@@ -7377,13 +7370,6 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
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
@@ -7404,26 +7390,37 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
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
@@ -7432,18 +7429,19 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
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
 
@@ -8435,19 +8433,10 @@ writeout_dumpfile(void)
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
@@ -8549,12 +8538,12 @@ setup_splitting(void)
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
@@ -9804,12 +9793,12 @@ int show_mem_usage(void)
 		return FALSE;
 
 
-	if (!prepare_bitmap2_buffer_cyclic())
+	if (!prepare_bitmap2_buffer())
 		return FALSE;
 
 	info->num_dumpable = get_num_dumpable_cyclic();
 
-	free_bitmap2_buffer_cyclic();
+	free_bitmap2_buffer();
 
 	print_mem_usage();
 
diff --git a/makedumpfile.h b/makedumpfile.h
index bbffbb5..decdbcd 100644
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
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
