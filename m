Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T6zZ1-0001h2-L9
 for kexec@lists.infradead.org; Thu, 30 Aug 2012 07:53:20 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.160])
 by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id q7U7rHYm028409
 for <kexec@lists.infradead.org>; Thu, 30 Aug 2012 16:53:17 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id q7U7rHw13988 for kexec@lists.infradead.org;
 Thu, 30 Aug 2012 16:53:17 +0900 (JST)
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
 by mailsv4.nec.co.jp (8.13.8/8.13.4) with ESMTP id q7U7rGrL012837
 for <kexec@lists.infradead.org>; Thu, 30 Aug 2012 16:53:16 +0900 (JST)
Date: Thu, 30 Aug 2012 16:46:03 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [PATCH 02/16] [PATCH v3 2/12] Prepare partial bitmap for cyclic mode.
Message-Id: <20120830164603.96c853a197ced386bf4e5266@mxc.nes.nec.co.jp>
In-Reply-To: <20120830164422.8d05cbcdd650398d5d5cbad9@mxc.nes.nec.co.jp>
References: <20120830164422.8d05cbcdd650398d5d5cbad9@mxc.nes.nec.co.jp>
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

From 4a753a20f3dc69493413cfb1eca0471dbea8a721 Mon Sep 17 00:00:00 2001
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Date: Thu, 23 Aug 2012 17:48:59 +0900
Subject: [PATCH 02/16] [PATCH v3 2/12] Prepare partial bitmap for cyclic mode.

cyclic mode uses partial bitmap instead of temporary bitmap file.
partial bitmap is saved in memory only for each cycle.

This patch introduce partial bitmap and extend some accessor functions
to manage partial bitmap.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.c |   99 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 makedumpfile.h |   23 +++++++++++++
 2 files changed, 113 insertions(+), 9 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 21bb55a..30851c2 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -165,6 +165,7 @@ is_in_same_page(unsigned long vaddr1, unsigned long vaddr2)
 
 #define BITMAP_SECT_LEN 4096
 static inline int is_dumpable(struct dump_bitmap *, unsigned long long);
+static inline int is_dumpable_cyclic(char *bitmap, unsigned long long);
 unsigned long
 pfn_to_pos(unsigned long long pfn)
 {
@@ -2721,6 +2722,12 @@ initialize_bitmap(struct dump_bitmap *bitmap)
 }
 
 void
+initialize_bitmap_cyclic(char *bitmap)
+{
+	memset(bitmap, 0, BUFSIZE_CYCLIC);
+}
+
+void
 initialize_1st_bitmap(struct dump_bitmap *bitmap)
 {
 	initialize_bitmap(bitmap);
@@ -2784,6 +2791,27 @@ set_bitmap(struct dump_bitmap *bitmap, unsigned long long pfn,
 }
 
 int
+set_bitmap_cyclic(char *bitmap, unsigned long long pfn, int val)
+{
+	int byte, bit;
+
+	if (pfn < info->cyclic_start_pfn || info->cyclic_end_pfn <= pfn)
+		return FALSE;
+
+	/*
+	 * If val is 0, clear bit on the bitmap.
+	 */
+	byte = (pfn - info->cyclic_start_pfn)>>3;
+	bit  = (pfn - info->cyclic_start_pfn) & 7;
+	if (val)
+		bitmap[byte] |= 1<<bit;
+	else
+		bitmap[byte] &= ~(1<<bit);
+
+	return TRUE;
+}
+
+int
 sync_bitmap(struct dump_bitmap *bitmap)
 {
 	off_t offset;
@@ -2825,19 +2853,31 @@ sync_2nd_bitmap(void)
 int
 set_bit_on_1st_bitmap(unsigned long long pfn)
 {
-	return set_bitmap(info->bitmap1, pfn, 1);
+	if (info->flag_cyclic) {
+		return set_bitmap_cyclic(info->partial_bitmap1, pfn, 1);
+	} else {
+		return set_bitmap(info->bitmap1, pfn, 1);
+	}
 }
 
 int
 clear_bit_on_1st_bitmap(unsigned long long pfn)
 {
-	return set_bitmap(info->bitmap1, pfn, 0);
+	if (info->flag_cyclic) {
+		return set_bitmap_cyclic(info->partial_bitmap1, pfn, 0);
+	} else {
+		return set_bitmap(info->bitmap1, pfn, 0);
+	}
 }
 
 int
 clear_bit_on_2nd_bitmap(unsigned long long pfn)
 {
-	return set_bitmap(info->bitmap2, pfn, 0);
+	if (info->flag_cyclic) {
+		return set_bitmap_cyclic(info->partial_bitmap2, pfn, 0);
+	} else {
+		return set_bitmap(info->bitmap2, pfn, 0);
+	}
 }
 
 int
@@ -3916,6 +3956,38 @@ prepare_bitmap_buffer(void)
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
+	/*
+	 * Prepare partial bitmap buffers for cyclic processing.
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
@@ -3936,14 +4008,19 @@ create_dump_bitmap(void)
 {
 	int ret = FALSE;
 
-	if (!prepare_bitmap_buffer())
-		goto out;
+	if (info->flag_cyclic) {
+		if (!prepare_bitmap_buffer_cyclic())
+			goto out;
+	} else {
+		if (!prepare_bitmap_buffer())
+			goto out;
 
-	if (!create_1st_bitmap())
-		goto out;
+		if (!create_1st_bitmap())
+			goto out;
 
-	if (!create_2nd_bitmap())
-		goto out;
+		if (!create_2nd_bitmap())
+			goto out;
+	}
 
 	ret = TRUE;
 out:
@@ -7210,6 +7287,10 @@ out:
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
index 287e055..bf5dd43 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -173,6 +173,12 @@ isAnon(unsigned long mapping)
 #define FILENAME_STDOUT		"STDOUT"
 
 /*
+ * For cyclic processing
+ */
+#define BUFSIZE_CYCLIC         (1024 * 1024)
+#define PFN_CYCLIC             (BUFSIZE_CYCLIC * BITPERBYTE)
+
+/*
  * Minimam vmcore has 2 ProgramHeaderTables(PT_NOTE and PT_LOAD).
  */
 #define MIN_ELF32_HEADER_SIZE \
@@ -926,6 +932,14 @@ struct DumpInfo {
 	unsigned long long split_end_pfn;  
 
 	/*
+	 * for cyclic processing
+	 */
+	char               *partial_bitmap1;
+	char               *partial_bitmap2;
+	unsigned long long cyclic_start_pfn;
+	unsigned long long cyclic_end_pfn;  
+
+	/*
 	 * sadump info:
 	 */
 	int flag_sadump_diskset;
@@ -1395,6 +1409,15 @@ is_dumpable(struct dump_bitmap *bitmap, unsigned long long pfn)
 }
 
 static inline int
+is_dumpable_cyclic(char *bitmap, unsigned long long pfn)
+{
+	if (pfn < info->cyclic_start_pfn || info->cyclic_end_pfn <= pfn)
+		return FALSE;
+	else
+		return is_on(bitmap, pfn - info->cyclic_start_pfn);
+}
+
+static inline int
 is_zero_page(unsigned char *buf, long page_size)
 {
 	size_t i;
-- 
1.7.9.2

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
