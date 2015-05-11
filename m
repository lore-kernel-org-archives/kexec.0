Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YrhRv-0007xv-3B
 for kexec@lists.infradead.org; Mon, 11 May 2015 06:44:24 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.193])
 by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id t4B6i0a5010788
 for <kexec@lists.infradead.org>; Mon, 11 May 2015 15:44:00 +0900 (JST)
Received: from mailsv.nec.co.jp (imss63.nec.co.jp [10.7.69.158]) by
 mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC) with ESMTP
 id t4B6i0X23067 for <kexec@lists.infradead.org>;
 Mon, 11 May 2015 15:44:00 +0900 (JST)
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
 by mailsv.nec.co.jp (8.13.8/8.13.4) with ESMTP id t4B6i0gh017061
 for <kexec@lists.infradead.org>; Mon, 11 May 2015 15:44:00 +0900 (JST)
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: [PATCH 13/13] Remove --non-cyclic option.
Date: Mon, 11 May 2015 06:36:10 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701DAA39F@BPXM01GP.gisp.nec.co.jp>
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

--non-cyclic option is no longer useful, should be removed.

Additionally, since cyclic mode and non-cyclic mode are merged
into the same code, info->flag_cyclic means whether multi-cycle
processing is necessary or not, the related descriptions
should be fixed.

Signed-off-by: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
---
 README         | 16 ----------------
 makedumpfile.8 | 27 +++++++++------------------
 makedumpfile.c | 11 +++--------
 makedumpfile.h | 15 +++++++--------
 print_info.c   | 16 ++++++----------
 5 files changed, 25 insertions(+), 60 deletions(-)

diff --git a/README b/README
index ae5fe5e..bedd1f8 100644
--- a/README
+++ b/README
@@ -147,22 +147,6 @@
      does not exclude Xen user domain pages. So user should specify '-X'
      option for excluding Xen user domain pages.
 
-  4. There are two running mode in makedumpfile-1.5.0 or later.
-    cyclic mode:
-      In this mode, makedumpfile reads regions of a fixed size from
-      /proc/vmcore, analyzes it, and writes pages to dumpfile cyclically from
-      start of memory to the end. Each cycle consume constant memory for
-      analysis of constant region, so the memory usage of makedumpfile will
-      be kept constant regardless of system memory size.
-      This mode is default mode. 
-
-    non-cyclic mode:
-      In this mode, makedumpfile creates temporary bitmap file in TMPDIR for
-      analysis. The size of bitmap increases linearly based on physical memory
-      size. Therefore, if your machine has a lots of memory and you use tmpfs
-      on TMPDIR in 2nd kernel, makedumpfile can fail due to lack of memory.
-      makedumpfile-1.4.4 or before has only this mode.
-
 * FAQ
   001: If installing elfutils-0.137 into older elfutils by the above way, the
        following problem happens sometimes. If seeing, try to enable LDFLAGS
diff --git a/makedumpfile.8 b/makedumpfile.8
index b6055d8..2d38cd0 100644
--- a/makedumpfile.8
+++ b/makedumpfile.8
@@ -387,8 +387,9 @@ The default value is 4.
 
 .TP
 \fB\-\-cyclic\-buffer\fR \fIbuffer_size\fR
-Specify the buffer size in kilo bytes for analysis in the cyclic mode.
-In the cyclic mode, the number of cycles is represented as:
+Specify the buffer size in kilo bytes for bitmap data.
+Filtering processing will be divided into multi cycles to fix the memory consumption,
+the number of cycles is represented as:
 
     num_of_cycles = system_memory / (\fIbuffer_size\fR * 1024 * bit_per_bytes * page_size )
 
@@ -403,7 +404,7 @@ size, so ordinary users don't need to specify this option.
 
 .TP
 \fB\-\-splitblock\-size\fR \fIsplitblock_size\fR
-Specify the splitblock size in kilo bytes for analysis in the cyclic mode with --split.
+Specify the splitblock size in kilo bytes for analysis with --split.
 If --splitblock N is specified, difference of each splitted dumpfile size is at most N
 kilo bytes.
 .br
@@ -412,15 +413,7 @@ kilo bytes.
 # makedumpfile \-\-splitblock\-size 1024 \-d 31 \-x vmlinux \-\-split /proc/vmcore dumpfile1 dumpfile2
 
 .TP
-\fB\-\-non\-cyclic\fR
-Running in the non-cyclic mode, this mode uses the old filtering logic same as v1.4.4 or before.
-If you feel the cyclic mode is too slow, please try this mode.
-.br
-.B Example:
-.br
-# makedumpfile \-\-non\-cyclic \-d 31 \-x vmlinux /proc/vmcore dumpfile
 
-.TP
 \fB\-\-work\-dir\fR
 Specify the working directory for the temporary bitmap file.
 If this option isn't specified, the bitmap will be saved on memory.
@@ -618,13 +611,11 @@ Show the version of makedumpfile.
 
 .TP 8
 .B TMPDIR
-This environment variable is for a temporary memory bitmap file only in the non-cyclic mode.
-If your machine has a lots of memory and you use tmpfs on /tmp, makedumpfile
-can fail for a little memory in the 2nd kernel because makedumpfile makes a
-very large temporary memory bitmap file in this case. To avoid this failure,
-you can set a TMPDIR environment variable. If you do not set a TMPDIR
-environment variable, makedumpfile uses /tmp directory for a temporary
-bitmap file as a default.
+This environment variable is used in 1st kernel environment for a temporary memory bitmap file.
+If your machine has a lots of memory and you use small tmpfs on /tmp, makedumpfile
+can fail for a little memory because makedumpfile makes a very large temporary
+memory bitmap file in this case. To avoid this failure, you should specify
+--work-dir option to use file system on storage for the bitmap file.
 
 .SH DIAGNOSTICS
 makedumpfile exits with the following value.
diff --git a/makedumpfile.c b/makedumpfile.c
index e64a7b4..cc71f20 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3246,7 +3246,7 @@ out:
 
 	if (info->working_dir || info->flag_reassemble || info->flag_refiltering
 	    || info->flag_sadump || info->flag_mem_usage) {
-		/* Implemented as non-cyclic mode based on the file */
+		/* Can be done in 1-cycle by using backing file. */
 		info->flag_cyclic = FALSE;
 		info->pfn_cyclic = info->max_mapnr;
 	} else {
@@ -7662,8 +7662,6 @@ initial_xen(void)
 	if (is_xen_memory()) {
 		if(info->flag_cyclic) {
 			info->flag_cyclic = FALSE;
-			MSG("Switched running mode from cyclic to non-cyclic,\n");
-			MSG("because the cyclic mode doesn't support Xen.\n");
 		}
 	}
 
@@ -9223,7 +9221,6 @@ static struct option longopts[] = {
 	{"config", required_argument, NULL, OPT_CONFIG},
 	{"help", no_argument, NULL, OPT_HELP},
 	{"diskset", required_argument, NULL, OPT_DISKSET},
-	{"non-cyclic", no_argument, NULL, OPT_NON_CYCLIC},
 	{"cyclic-buffer", required_argument, NULL, OPT_CYCLIC_BUFFER},
 	{"eppic", required_argument, NULL, OPT_EPPIC},
 	{"non-mmap", no_argument, NULL, OPT_NON_MMAP},
@@ -9252,7 +9249,8 @@ main(int argc, char *argv[])
 	initialize_tables();
 
 	/*
-	 * By default, makedumpfile works in constant memory space.
+	 * By default, makedumpfile assumes that multi-cycle processing is
+	 * necessary to work in constant memory space.
 	 */
 	info->flag_cyclic = TRUE;
 
@@ -9357,9 +9355,6 @@ main(int argc, char *argv[])
 		case OPT_XEN_SYMS:
 			info->name_xen_syms = optarg;
 			break;
-		case OPT_NON_CYCLIC:
-			info->flag_cyclic = FALSE;
-			break;
 		case OPT_NON_MMAP:
 			info->flag_usemmap = MMAP_DISABLE;
 			break;
diff --git a/makedumpfile.h b/makedumpfile.h
index 824e8ef..f2a9be3 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -976,7 +976,7 @@ struct DumpInfo {
 	int		flag_rearrange;      /* flag of creating dumpfile from
 						flattened format */
 	int		flag_split;	     /* splitting vmcore */
-  	int		flag_cyclic;	     /* cyclic processing to keep memory consumption */
+	int		flag_cyclic;	     /* multi-cycle processing is necessary */
 	int		flag_usemmap;	     /* /proc/vmcore supports mmap(2) */
 	int		flag_reassemble;     /* reassemble multiple dumpfiles into one */
 	int		flag_refiltering;    /* refilter from kdump-compressed file */
@@ -1900,13 +1900,12 @@ struct elf_prstatus {
 #define OPT_DUMP_DMESG          OPT_START+7
 #define OPT_CONFIG              OPT_START+8
 #define OPT_DISKSET             OPT_START+9
-#define OPT_NON_CYCLIC          OPT_START+10
-#define OPT_CYCLIC_BUFFER       OPT_START+11
-#define OPT_EPPIC               OPT_START+12
-#define OPT_NON_MMAP            OPT_START+13
-#define OPT_MEM_USAGE            OPT_START+14
-#define OPT_SPLITBLOCK_SIZE	OPT_START+15
-#define OPT_WORKING_DIR         OPT_START+16
+#define OPT_CYCLIC_BUFFER       OPT_START+10
+#define OPT_EPPIC               OPT_START+11
+#define OPT_NON_MMAP            OPT_START+12
+#define OPT_MEM_USAGE           OPT_START+13
+#define OPT_SPLITBLOCK_SIZE	OPT_START+14
+#define OPT_WORKING_DIR         OPT_START+15
 
 /*
  * Function Prototype.
diff --git a/print_info.c b/print_info.c
index 6610e76..9c36bec 100644
--- a/print_info.c
+++ b/print_info.c
@@ -193,8 +193,9 @@ print_usage(void)
 	MSG("      writing to output. The default value is 4.\n");
 	MSG("\n");
 	MSG("  [--cyclic-buffer BUFFER_SIZE]:\n");
-	MSG("      Specify the buffer size in kilo bytes for analysis in the cyclic mode.\n");
-	MSG("      In the cyclic mode, the number of cycles is represented as:\n");
+	MSG("      Specify the buffer size in kilo bytes for bitmap data.\n");
+	MSG("      Filtering processing will be divided into multi cycles to fix the memory\n");
+	MSG("      consumption, the number of cycles is represented as:\n");
 	MSG("\n");
 	MSG("          num_of_cycles = system_memory / \n");
 	MSG("                          (BUFFER_SIZE * 1024 * bit_per_bytes * page_size)\n");
@@ -204,14 +205,9 @@ print_usage(void)
 	MSG("      system memory size, so ordinary users don't need to specify this option.\n");
 	MSG("\n");
 	MSG("  [--splitblock-size SPLITBLOCK_SIZE]:\n");
-	MSG("      Specify the splitblock size in kilo bytes for analysis in the cyclic mode\n");
-	MSG("      with --split. If --splitblock N is specified, difference of each splitted\n");
-	MSG("      dumpfile size is at most N kilo bytes.\n");
-	MSG("\n");
-	MSG("  [--non-cyclic]:\n");
-	MSG("      Running in the non-cyclic mode, this mode uses the old filtering logic\n");
-	MSG("      same as v1.4.4 or before.\n");
-	MSG("      If you feel the cyclic mode is too slow, please try this mode.\n");
+	MSG("      Specify the splitblock size in kilo bytes for analysis with --split.\n");
+	MSG("      If --splitblock N is specified, difference of each splitted dumpfile\n");
+	MSG("      size is at most N kilo bytes.\n");
 	MSG("\n");
 	MSG("  [--work-dir]:\n");
 	MSG("      Specify the working directory for the temporary bitmap file.\n");
-- 
1.9.0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
