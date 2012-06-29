Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SkQnK-0001UZ-Jo
 for kexec@lists.infradead.org; Fri, 29 Jun 2012 02:18:52 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.193])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id q5T2Ifqb001726
 for <kexec@lists.infradead.org>; Fri, 29 Jun 2012 11:18:41 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id q5T2IfY06124 for kexec@lists.infradead.org;
 Fri, 29 Jun 2012 11:18:41 +0900 (JST)
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
 by mailsv3.nec.co.jp (8.13.8/8.13.4) with ESMTP id q5T2IeBX021841
 for <kexec@lists.infradead.org>; Fri, 29 Jun 2012 11:18:40 +0900 (JST)
Date: Fri, 29 Jun 2012 11:17:00 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [RFC PATCH v2 2/10] Prepare partial bitmap for cyclic processing.
Message-Id: <20120629111700.f1bb13e1.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120629111320.694ec85b.kumagai-atsushi@mxc.nes.nec.co.jp>
References: <20120629111320.694ec85b.kumagai-atsushi@mxc.nes.nec.co.jp>
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

cyclic processing uses partial bitmap instead of temporary bitmap file.
partial bitmap is saved in memory only for each cycle.

This patch introduce partial bitmap and extend some accessor functions
to manage partial bitmap.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.c |   99 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 makedumpfile.h |   23 +++++++++++++
 2 files changed, 113 insertions(+), 9 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 87bd680..9e77913 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -165,6 +165,7 @@ is_in_same_page(unsigned long vaddr1, unsigned long vaddr2)
 
 #define BITMAP_SECT_LEN 4096
 static inline int is_dumpable(struct dump_bitmap *, unsigned long long);
+static inline int is_dumpable_cyclic(char *bitmap, unsigned long long);
 unsigned long
 pfn_to_pos(unsigned long long pfn)
 {
@@ -2719,6 +2720,12 @@ initialize_bitmap(struct dump_bitmap *bitmap)
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
@@ -2782,6 +2789,27 @@ set_bitmap(struct dump_bitmap *bitmap, unsigned long long pfn,
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
@@ -2823,19 +2851,31 @@ sync_2nd_bitmap(void)
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
@@ -3914,6 +3954,38 @@ prepare_bitmap_buffer(void)
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
@@ -3934,14 +4006,19 @@ create_dump_bitmap(void)
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
@@ -7203,6 +7280,10 @@ out:
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
