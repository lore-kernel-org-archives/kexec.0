Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SZxX9-0000Sh-Tu
 for kexec@lists.infradead.org; Thu, 31 May 2012 05:02:53 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.193])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id q4V52gEI008196
 for <kexec@lists.infradead.org>; Thu, 31 May 2012 14:02:42 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id q4V52gR21815 for kexec@lists.infradead.org;
 Thu, 31 May 2012 14:02:42 +0900 (JST)
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
 by mailsv4.nec.co.jp (8.13.8/8.13.4) with ESMTP id q4V52gwd014726
 for <kexec@lists.infradead.org>; Thu, 31 May 2012 14:02:42 +0900 (JST)
Date: Thu, 31 May 2012 14:01:03 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [RFC PATCH 2/4] makedumpfile: Add partial bitmap for cyclic.
Message-Id: <20120531140103.264cc0c4.kumagai-atsushi@mxc.nes.nec.co.jp>
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
 makedumpfile.c |   46 +++++++++++++++++++++++++++++++++++++++++++---
 makedumpfile.h |   26 ++++++++++++++++++++++++--
 2 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 3e5f906..ff8f157 100644
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
+	if (pfn < info->split_start_pfn || info->split_end_pfn < pfn)
+		return FALSE;
+
+	/*
+	 * If val is 0, clear bit on the bitmap.
+	 */
+	byte = (pfn - info->split_start_pfn)>>3;
+	bit  = (pfn - info->split_start_pfn) & 7;
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
diff --git a/makedumpfile.h b/makedumpfile.h
index c588e43..c72021a 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -173,6 +173,13 @@ isAnon(unsigned long mapping)
 #define FILENAME_STDOUT		"STDOUT"
 
 /*
+ * For cyclic
+ */
+#define BUFSIZE_CYCLIC	        (8192)
+#define PFN_CYCLIC		(BUFSIZE_CYCLIC * BITPERBYTE)
+
+
+/*
  * Minimam vmcore has 2 ProgramHeaderTables(PT_NOTE and PT_LOAD).
  */
 #define MIN_ELF32_HEADER_SIZE \
@@ -922,8 +929,14 @@ struct DumpInfo {
 	/*
 	 * for splitting
 	 */
-	unsigned long long split_start_pfn;  
-	unsigned long long split_end_pfn;  
+	unsigned long long split_start_pfn;
+	unsigned long long split_end_pfn;
+
+	/*
+	 * for cyclic
+	 */
+	char            *partial_bitmap1;
+	char            *partial_bitmap2;
 
 	/*
 	 * sadump info:
@@ -1395,6 +1408,15 @@ is_dumpable(struct dump_bitmap *bitmap, unsigned long long pfn)
 }
 
 static inline int
+is_dumpable_cyclic(char *bitmap, unsigned long long pfn)
+{
+	if (pfn < info->split_start_pfn || info->split_end_pfn < pfn)
+		return FALSE;
+	else
+		return is_on(bitmap, pfn - info->split_start_pfn);
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
