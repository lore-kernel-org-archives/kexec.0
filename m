Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T6zl1-0002CM-6K
 for kexec@lists.infradead.org; Thu, 30 Aug 2012 08:05:44 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.197])
 by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id q7U85f3D008831
 for <kexec@lists.infradead.org>; Thu, 30 Aug 2012 17:05:41 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id q7U85fH18184 for kexec@lists.infradead.org;
 Thu, 30 Aug 2012 17:05:41 +0900 (JST)
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
 by mailsv3.nec.co.jp (8.13.8/8.13.4) with ESMTP id q7U85e0F006638
 for <kexec@lists.infradead.org>; Thu, 30 Aug 2012 17:05:40 +0900 (JST)
Date: Thu, 30 Aug 2012 16:56:47 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [PATCH 12/16] [PATCH v3 12/12] Add --cyclic-buffer option to
 specify buffer size for cyclic mode.
Message-Id: <20120830165647.e9907e616b1d7b6386340ac7@mxc.nes.nec.co.jp>
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

From 885f063af4b3884be254506bb4b4d6c22eefe6d1 Mon Sep 17 00:00:00 2001
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Date: Fri, 24 Aug 2012 10:22:24 +0900
Subject: [PATCH 12/16] [PATCH v3 12/12] Add --cyclic-buffer option to specify buffer size for cyclic mode.

Introduce --cyclic-buffer option to specify buffer size for cyclic mode.
This option requires a integer as buffer size in kilo bytes.

  Usage:
      # makedumpfile --cyclic-buffer 1024 /proc/vmcore dumpfile

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.8 |   16 ++++++++++++++++
 makedumpfile.c |   41 ++++++++++++++++++++++++++++++++++-------
 makedumpfile.h |    5 +++--
 print_info.c   |   11 +++++++++++
 4 files changed, 64 insertions(+), 9 deletions(-)

diff --git a/makedumpfile.8 b/makedumpfile.8
index 7535a60..95bf3e8 100644
--- a/makedumpfile.8
+++ b/makedumpfile.8
@@ -347,6 +347,22 @@ on the following example.
 # makedumpfile \-\-reassemble dumpfile1 dumpfile2 dumpfile
 
 .TP
+\fB\-\-cyclic\-buffer\fR \fIbuffer_size\fR
+Specify the buffer size in kilo bytes for analysis in cyclic mode.
+Actually, the double of \fIbuffer_size\fR kilo bytes will be allocated in memory.
+In cyclic mode, the number of cycles is represented as:
+
+    num_of_cycles = system_memory / (\fIbuffer_size\fR * 1024 * bit_per_bytes * page_size )
+
+The lesser number of cycles, the faster working speed is expected.
+Default \fIbuffer_size\fR is 1024.
+
+.br
+.B Example:
+.br
+# makedumpfile \-\-cyclic\-buffer 1024 \-d 31 \-x vmlinux /proc/vmcore dumpfile
+
+.TP
 \fB\-\-non\-cyclic\fR
 Running in non-cyclic mode, this mode uses old filtering logic same as v1.4.4 or before.
 If you feel cyclic mode is too slow, please try this mode.
diff --git a/makedumpfile.c b/makedumpfile.c
index 879f73a..208087e 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2541,6 +2541,29 @@ initial(void)
 	}
 #endif
 
+	if (info->flag_cyclic) {
+		/*
+		 * buffer size is specified as Kbyte
+		 */
+		if (info->bufsize_cyclic == 0)
+			info->bufsize_cyclic = DEFAULT_BUFSIZE_CYCLIC;
+		else
+			info->bufsize_cyclic <<= 10;
+	
+		/*
+		 * Max buffer size is 100 MB
+		 */
+		if (info->bufsize_cyclic > (100 << 20)) {
+			MSG("Specified buffer size is too large, ");
+			MSG("The buffer size for cyclic mode will be truncated to 100 MB.\n");
+			info->bufsize_cyclic = (100 << 20);
+		}
+		info->pfn_cyclic = info->bufsize_cyclic * BITPERBYTE;
+
+		DEBUG_MSG("\n");
+		DEBUG_MSG("Buffer size for cyclic mode: %ld\n", info->bufsize_cyclic);
+	}
+
 	if (!is_xen_memory() && info->flag_exclude_xen_dom) {
 		MSG("'-X' option is disable,");
 		MSG("because %s is not Xen's memory core image.\n", info->name_memory);
@@ -2726,7 +2749,7 @@ initialize_bitmap(struct dump_bitmap *bitmap)
 void
 initialize_bitmap_cyclic(char *bitmap)
 {
-	memset(bitmap, 0, BUFSIZE_CYCLIC);
+	memset(bitmap, 0, info->bufsize_cyclic);
 }
 
 void
@@ -3859,7 +3882,7 @@ exclude_unnecessary_pages(void)
 void
 copy_bitmap_cyclic(void)
 {
-	memcpy(info->partial_bitmap2, info->partial_bitmap1, BUFSIZE_CYCLIC);
+	memcpy(info->partial_bitmap2, info->partial_bitmap1, info->bufsize_cyclic);
 }
 
 int
@@ -3907,8 +3930,8 @@ update_cyclic_region(unsigned long long pfn)
 	if (is_cyclic_region(pfn))
 		return TRUE;
 
-	info->cyclic_start_pfn = round(pfn, PFN_CYCLIC);
-	info->cyclic_end_pfn = info->cyclic_start_pfn + PFN_CYCLIC;
+	info->cyclic_start_pfn = round(pfn, info->pfn_cyclic);
+	info->cyclic_end_pfn = info->cyclic_start_pfn + info->pfn_cyclic;
 
 	if (info->cyclic_end_pfn > info->max_mapnr)
 		info->cyclic_end_pfn = info->max_mapnr;
@@ -4079,12 +4102,12 @@ prepare_bitmap_buffer_cyclic(void)
 	/*
 	 * Prepare partial bitmap buffers for cyclic processing.
 	 */
-	if ((info->partial_bitmap1 = (char *)malloc(BUFSIZE_CYCLIC)) == NULL) {
+	if ((info->partial_bitmap1 = (char *)malloc(info->bufsize_cyclic)) == NULL) {
 		ERRMSG("Can't allocate memory for the 1st-bitmap. %s\n",
 		       strerror(errno));
 		return FALSE;
 	}
-	if ((info->partial_bitmap2 = (char *)malloc(BUFSIZE_CYCLIC)) == NULL) {
+	if ((info->partial_bitmap2 = (char *)malloc(info->bufsize_cyclic)) == NULL) {
 		ERRMSG("Can't allocate memory for the 2nd-bitmap. %s\n",
 		       strerror(errno));
 		return FALSE;
@@ -4919,7 +4942,7 @@ get_loads_dumpfile_cyclic(void)
 	 * Initialize target reggion and bitmap.
 	 */
 	info->cyclic_start_pfn = 0;
-	info->cyclic_end_pfn = PFN_CYCLIC;
+	info->cyclic_end_pfn = info->pfn_cyclic;
 	if (!create_1st_bitmap_cyclic())
 		return FALSE;
 	if (!exclude_unnecessary_pages_cyclic())
@@ -7731,6 +7754,7 @@ static struct option longopts[] = {
 	{"help", no_argument, NULL, 'h'},
 	{"diskset", required_argument, NULL, 'k'},
 	{"non-cyclic", no_argument, NULL, 'Y'},
+	{"cyclic-buffer", required_argument, NULL, 'Z'},
 	{0, 0, 0, 0}
 };
 
@@ -7851,6 +7875,9 @@ main(int argc, char *argv[])
 			info->flag_read_vmcoreinfo = 1;
 			info->name_vmcoreinfo = optarg;
 			break;
+		case 'Z':
+			info->bufsize_cyclic = atoi(optarg);
+			break;
 		case '?':
 			MSG("Commandline parameter is invalid.\n");
 			MSG("Try `makedumpfile --help' for more information.\n");
diff --git a/makedumpfile.h b/makedumpfile.h
index 77b824e..4d6cbbb 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -175,8 +175,7 @@ isAnon(unsigned long mapping)
 /*
  * For cyclic processing
  */
-#define BUFSIZE_CYCLIC         (1024 * 1024)
-#define PFN_CYCLIC             (BUFSIZE_CYCLIC * BITPERBYTE)
+#define DEFAULT_BUFSIZE_CYCLIC         (1024 * 1024)
 
 /*
  * Minimam vmcore has 2 ProgramHeaderTables(PT_NOTE and PT_LOAD).
@@ -939,6 +938,8 @@ struct DumpInfo {
 	unsigned long long cyclic_start_pfn;
 	unsigned long long cyclic_end_pfn;  
 	unsigned long long num_dumpable;
+	unsigned long      bufsize_cyclic;
+	unsigned long      pfn_cyclic;
 
 	/*
 	 * sadump info:
diff --git a/print_info.c b/print_info.c
index 14eec8e..4da9a78 100644
--- a/print_info.c
+++ b/print_info.c
@@ -162,6 +162,17 @@ print_usage(void)
 	MSG("      Reassemble multiple DUMPFILEs, which are created by --split option,\n");
 	MSG("      into one DUMPFILE. dumpfile1 and dumpfile2 are reassembled into dumpfile.\n");
 	MSG("\n");
+	MSG("  [--cyclic-buffer BUFFER_SIZE]:\n");
+	MSG("      Specify the buffer size in kilo bytes for analysis in cyclic mode.\n");
+	MSG("      Actually, the double of BUFFER_SIZE kilo bytes will be allocated in memory.\n");
+	MSG("      In cyclic mode, the number of cycles is represented as:\n");
+	MSG("\n");
+	MSG("          num_of_cycles = system_memory / \n");
+	MSG("                          (BUFFER_SIZE * 1024 * bit_per_bytes * page_size)\n");
+	MSG("\n");
+	MSG("      The lesser number of cycles, the faster working speed is expected.\n");
+	MSG("      Default BUFFER_SIZE is 1024.\n");
+	MSG("\n");
 	MSG("  [--non-cyclic]:\n");
 	MSG("      Running in non-cyclic mode, this mode uses old filtering logic same as\n");
 	MSG("      v1.4.4 or before.\n");
-- 
1.7.9.2

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
