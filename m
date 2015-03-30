Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YcR8q-00073W-2g
 for kexec@lists.infradead.org; Mon, 30 Mar 2015 04:17:37 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: [PATCH 1/6] WIP: Organize bitmap structure for cyclic logic.
Date: Mon, 30 Mar 2015 04:08:48 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701D9CAB7@BPXM01GP.gisp.nec.co.jp>
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

For merging the routine corresponding to the bitmap, it's better
if the partial bitmap is also managed with struct dump_bitmap.

Signed-off-by: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
---
 makedumpfile.c |   62 ++++++++++++++++++++++++++++++++++++++++++++-----------
 makedumpfile.h |   10 ++++----
 2 files changed, 54 insertions(+), 18 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 32f5459..b8e1c1b 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -237,7 +237,7 @@ is_in_same_page(unsigned long vaddr1, unsigned long vaddr2)
 
 #define BITMAP_SECT_LEN 4096
 static inline int is_dumpable(struct dump_bitmap *, mdf_pfn_t);
-static inline int is_dumpable_cyclic(char *bitmap, mdf_pfn_t, struct cycle *cycle);
+static inline int is_dumpable_cyclic(struct dump_bitmap *, mdf_pfn_t, struct cycle *cycle);
 unsigned long
 pfn_to_pos(mdf_pfn_t pfn)
 {
@@ -3038,6 +3038,12 @@ initialize_bitmap_memory(void)
 		    strerror(errno));
 		return FALSE;
 	}
+	bmp->buf = malloc(BUFSIZE_BITMAP);
+	if (bmp->buf == NULL) {
+		ERRMSG("Can't allocate memory for the bitmap buffer. %s\n",
+		    strerror(errno));
+		return FALSE;
+	}
 	bmp->fd        = info->fd_memory;
 	bmp->file_name = info->name_memory;
 	bmp->no_block  = -1;
@@ -3053,6 +3059,7 @@ initialize_bitmap_memory(void)
 	if (info->valid_pages == NULL) {
 		ERRMSG("Can't allocate memory for the valid_pages. %s\n",
 		    strerror(errno));
+		free(bmp->buf);
 		free(bmp);
 		return FALSE;
 	}
@@ -3362,9 +3369,12 @@ initialize_bitmap(struct dump_bitmap *bitmap)
 }
 
 void
-initialize_bitmap_cyclic(char *bitmap)
+initialize_bitmap_cyclic(struct dump_bitmap *bitmap)
 {
-	memset(bitmap, 0, info->bufsize_cyclic);
+	bitmap->fd        = 0;
+	bitmap->file_name = NULL;
+	bitmap->no_block  = -1;
+	memset(bitmap->buf, 0, info->bufsize_cyclic);
 }
 
 void
@@ -3430,7 +3440,7 @@ set_bitmap(struct dump_bitmap *bitmap, mdf_pfn_t pfn, int val)
 }
 
 int
-set_bitmap_cyclic(char *bitmap, mdf_pfn_t pfn, int val, struct cycle *cycle)
+set_bitmap_cyclic(struct dump_bitmap *bitmap, mdf_pfn_t pfn, int val, struct cycle *cycle)
 {
 	int byte, bit;
 	static int warning = 0;
@@ -3450,9 +3460,9 @@ set_bitmap_cyclic(char *bitmap, mdf_pfn_t pfn, int val, struct cycle *cycle)
 	byte = (pfn - cycle->start_pfn)>>3;
 	bit  = (pfn - cycle->start_pfn) & 7;
 	if (val)
-		bitmap[byte] |= 1<<bit;
+		bitmap->buf[byte] |= 1<<bit;
 	else
-		bitmap[byte] &= ~(1<<bit);
+		bitmap->buf[byte] &= ~(1<<bit);
 
 	return TRUE;
 }
@@ -4715,7 +4725,7 @@ create_1st_bitmap_cyclic(struct cycle *cycle)
 		pfn_end_byte = (pfn_end_round - cycle->start_pfn) >> 3;
 
 		if (pfn_start_byte < pfn_end_byte) {
-			memset(info->partial_bitmap1 + pfn_start_byte,
+			memset(info->partial_bitmap1->buf + pfn_start_byte,
 			       0xff,
 			       pfn_end_byte - pfn_start_byte);
 		}
@@ -4863,7 +4873,7 @@ initialize_2nd_bitmap_cyclic(struct cycle *cycle)
 		pfn_end_byte = (pfn_end_round - cycle->start_pfn) >> 3;
 
 		if (pfn_start_byte < pfn_end_byte) {
-			memset(info->partial_bitmap2 + pfn_start_byte,
+			memset(info->partial_bitmap2->buf + pfn_start_byte,
 			       0xff,
 			       pfn_end_byte - pfn_start_byte);
 			pfn_memhole -= (pfn_end_byte - pfn_start_byte) << 3;
@@ -5317,11 +5327,16 @@ prepare_bitmap1_buffer_cyclic(void)
 	/*
 	 * Prepare partial bitmap buffers for cyclic processing.
 	 */
-	if ((info->partial_bitmap1 = (char *)malloc(info->bufsize_cyclic)) == NULL) {
+	if ((info->partial_bitmap1 = malloc(sizeof(struct dump_bitmap))) == NULL) {
 		ERRMSG("Can't allocate memory for the 1st bitmaps. %s\n",
 		       strerror(errno));
 		return FALSE;
 	}
+	if ((info->partial_bitmap1->buf = (char *)malloc(info->bufsize_cyclic)) == NULL) {
+		ERRMSG("Can't allocate memory for the 1st bitmaps's buffer. %s\n",
+		       strerror(errno));
+		return FALSE;
+	}
 	initialize_bitmap_cyclic(info->partial_bitmap1);
 
 	return TRUE;
@@ -5343,11 +5358,16 @@ prepare_bitmap2_buffer_cyclic(void)
 	/*
 	 * Prepare partial bitmap buffers for cyclic processing.
 	 */
-	if ((info->partial_bitmap2 = (char *)malloc(info->bufsize_cyclic)) == NULL) {
+	if ((info->partial_bitmap2 = malloc(sizeof(struct dump_bitmap))) == NULL) {
 		ERRMSG("Can't allocate memory for the 2nd bitmaps. %s\n",
 		       strerror(errno));
 		return FALSE;
 	}
+	if ((info->partial_bitmap2->buf = (char *)malloc(info->bufsize_cyclic)) == NULL) {
+		ERRMSG("Can't allocate memory for the 2nd bitmaps's buffer. %s\n",
+		       strerror(errno));
+		return FALSE;
+	}
 	initialize_bitmap_cyclic(info->partial_bitmap2);
 
 	return TRUE;
@@ -5357,6 +5377,10 @@ void
 free_bitmap1_buffer(void)
 {
 	if (info->bitmap1) {
+		if (info->bitmap1->buf) {
+			free(info->bitmap1->buf);
+			info->bitmap1->buf = NULL;
+		}
 		free(info->bitmap1);
 		info->bitmap1 = NULL;
 	}
@@ -5366,6 +5390,10 @@ void
 free_bitmap2_buffer(void)
 {
 	if (info->bitmap2) {
+		if (info->bitmap2->buf) {
+			free(info->bitmap2->buf);
+			info->bitmap2->buf = NULL;
+		}
 		free(info->bitmap2);
 		info->bitmap2 = NULL;
 	}
@@ -5382,6 +5410,10 @@ void
 free_bitmap1_buffer_cyclic()
 {
 	if (info->partial_bitmap1 != NULL){
+		if (info->partial_bitmap1->buf != NULL) {
+			free(info->partial_bitmap1->buf);
+			info->partial_bitmap1->buf = NULL;
+		}
 		free(info->partial_bitmap1);
 		info->partial_bitmap1 = NULL;
 	}
@@ -5391,6 +5423,10 @@ void
 free_bitmap2_buffer_cyclic()
 {
 	if (info->partial_bitmap2 != NULL){
+		if (info->partial_bitmap2->buf != NULL) {
+			free(info->partial_bitmap2->buf);
+			info->partial_bitmap2->buf = NULL;
+		}
 		free(info->partial_bitmap2);
 		info->partial_bitmap2 = NULL;
 	}
@@ -6917,7 +6953,7 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
 		/*
 		 * Check the excluded page.
 		 */
-		if (!is_on(info->partial_bitmap2, pfn - cycle->start_pfn))
+		if (!is_on(info->partial_bitmap2->buf, pfn - cycle->start_pfn))
 			continue;
 
 		num_dumped++;
@@ -7290,7 +7326,7 @@ write_kdump_bitmap1_cyclic(struct cycle *cycle)
 	offset = info->offset_bitmap1;
 	if (!write_buffer(info->fd_dumpfile, offset + info->bufsize_cyclic *
 			  (cycle->start_pfn / info->pfn_cyclic),
-			  info->partial_bitmap1, increment, info->name_dumpfile))
+			  info->partial_bitmap1->buf, increment, info->name_dumpfile))
 		goto out;
 
 	ret = TRUE;
@@ -7314,7 +7350,7 @@ write_kdump_bitmap2_cyclic(struct cycle *cycle)
 	offset = info->offset_bitmap1;
 	offset += info->len_bitmap / 2;
 	if (!write_buffer(info->fd_dumpfile, offset,
-			  info->partial_bitmap2, increment, info->name_dumpfile))
+			  info->partial_bitmap2->buf, increment, info->name_dumpfile))
 		goto out;
 
 	info->offset_bitmap1 += increment;
diff --git a/makedumpfile.h b/makedumpfile.h
index d2fadbd..4beac65 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -897,7 +897,7 @@ struct dump_bitmap {
 	int		fd;
 	int		no_block;
 	char		*file_name;
-	char		buf[BUFSIZE_BITMAP];
+	char		*buf;
 	off_t		offset;
 };
 
@@ -1149,8 +1149,8 @@ struct DumpInfo {
 	/*
 	 * for cyclic processing
 	 */
-	char               *partial_bitmap1;
-	char               *partial_bitmap2;
+	struct dump_bitmap *partial_bitmap1;
+	struct dump_bitmap *partial_bitmap2;
 	mdf_pfn_t          num_dumpable;
 	unsigned long      bufsize_cyclic;
 	unsigned long      pfn_cyclic;
@@ -1756,12 +1756,12 @@ is_dumpable(struct dump_bitmap *bitmap, mdf_pfn_t pfn)
 }
 
 static inline int
-is_dumpable_cyclic(char *bitmap, mdf_pfn_t pfn, struct cycle *cycle)
+is_dumpable_cyclic(struct dump_bitmap *bitmap, mdf_pfn_t pfn, struct cycle *cycle)
 {
 	if (pfn < cycle->start_pfn || cycle->end_pfn <= pfn)
 		return FALSE;
 	else
-		return is_on(bitmap, pfn - cycle->start_pfn);
+		return is_on(bitmap->buf, pfn - cycle->start_pfn);
 }
 
 static inline int
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
