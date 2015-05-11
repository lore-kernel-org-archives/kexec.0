Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YrhO7-0006Mm-Aq
 for kexec@lists.infradead.org; Mon, 11 May 2015 06:40:28 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.160])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id t4B6e6Pp007270
 for <kexec@lists.infradead.org>; Mon, 11 May 2015 15:40:06 +0900 (JST)
Received: from mailsv.nec.co.jp (imss61.nec.co.jp [10.7.69.156]) by
 mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC) with ESMTP
 id t4B6e5713537 for <kexec@lists.infradead.org>;
 Mon, 11 May 2015 15:40:05 +0900 (JST)
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
 by mailsv.nec.co.jp (8.13.8/8.13.4) with ESMTP id t4B6e5fQ014964
 for <kexec@lists.infradead.org>; Mon, 11 May 2015 15:40:05 +0900 (JST)
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: [PATCH 02/13] Add option to specify working directory for the bitmap.
Date: Mon, 11 May 2015 06:22:45 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701DAA344@BPXM01GP.gisp.nec.co.jp>
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

Introduce the new option "--work-dir" to specify the directory
used to store the bitmap. This is the alternative to the combination
of --non-cyclic and TMPDIR.

Signed-off-by: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
---
 makedumpfile.8 | 13 +++++++++++++
 makedumpfile.c | 21 +++++++++++++++++++--
 makedumpfile.h |  2 ++
 print_info.c   |  7 +++++++
 4 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/makedumpfile.8 b/makedumpfile.8
index 9752671..b6055d8 100644
--- a/makedumpfile.8
+++ b/makedumpfile.8
@@ -421,6 +421,19 @@ If you feel the cyclic mode is too slow, please try this mode.
 # makedumpfile \-\-non\-cyclic \-d 31 \-x vmlinux /proc/vmcore dumpfile
 
 .TP
+\fB\-\-work\-dir\fR
+Specify the working directory for the temporary bitmap file.
+If this option isn't specified, the bitmap will be saved on memory.
+Filtering processing has to do 2 pass scanning to fix the memory consumption,
+but it can be avoided by using working directory on file system.
+So if you specify this option, the filtering speed may be bit faster.
+
+.br
+.B Example:
+.br
+# makedumpfile \-\-work\-dir /tmp \-d 31 \-x vmlinux /proc/vmcore dumpfile
+
+.TP
 \fB\-\-non\-mmap\fR
 Never use \fBmmap(2)\fR to read \fIVMCORE\fR even if it supports \fBmmap(2)\fR.
 Generally, reading \fIVMCORE\fR with \fBmmap(2)\fR is faster than without it,
diff --git a/makedumpfile.c b/makedumpfile.c
index 1192cfe..f0ec741 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1033,8 +1033,14 @@ open_dump_bitmap(void)
 	int i, fd;
 	char *tmpname;
 
+	/* Unnecessary to open */
+	if (!info->working_dir)
+		return TRUE;
+
 	tmpname = getenv("TMPDIR");
-	if (!tmpname)
+	if (info->working_dir)
+		tmpname = info->working_dir;
+	else if (!tmpname)
 		tmpname = "/tmp";
 
 	if ((info->name_bitmap = (char *)malloc(sizeof(FILENAME_BITMAP) +
@@ -3251,7 +3257,11 @@ out:
 	if (!get_max_mapnr())
 		return FALSE;
 
-	if (info->flag_cyclic) {
+	if (info->working_dir) {
+		/* Implemented as non-cyclic mode based on the file */
+		info->flag_cyclic = FALSE;
+		info->pfn_cyclic = info->max_mapnr;
+	} else {
 		if (info->bufsize_cyclic == 0) {
 			if (!calculate_cyclic_buffer_size())
 				return FALSE;
@@ -7489,6 +7499,9 @@ close_dump_file(void)
 void
 close_dump_bitmap(void)
 {
+	if (!info->working_dir)
+		return;
+
 	if ((info->fd_bitmap = close(info->fd_bitmap)) < 0)
 		ERRMSG("Can't close the bitmap file(%s). %s\n",
 		    info->name_bitmap, strerror(errno));
@@ -9832,6 +9845,7 @@ static struct option longopts[] = {
 	{"non-mmap", no_argument, NULL, OPT_NON_MMAP},
 	{"mem-usage", no_argument, NULL, OPT_MEM_USAGE},
 	{"splitblock-size", required_argument, NULL, OPT_SPLITBLOCK_SIZE},
+	{"work-dir", required_argument, NULL, OPT_WORKING_DIR},
 	{0, 0, 0, 0}
 };
 
@@ -9975,6 +9989,9 @@ main(int argc, char *argv[])
 		case OPT_SPLITBLOCK_SIZE:
 			info->splitblock_size = atoi(optarg);
 			break;
+		case OPT_WORKING_DIR:
+			info->working_dir = optarg;
+			break;
 		case '?':
 			MSG("Commandline parameter is invalid.\n");
 			MSG("Try `makedumpfile --help' for more information.\n");
diff --git a/makedumpfile.h b/makedumpfile.h
index 4beac65..990c76f 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1151,6 +1151,7 @@ struct DumpInfo {
 	 */
 	struct dump_bitmap *partial_bitmap1;
 	struct dump_bitmap *partial_bitmap2;
+	char	           *working_dir;	     /* working directory for bitmap */
 	mdf_pfn_t          num_dumpable;
 	unsigned long      bufsize_cyclic;
 	unsigned long      pfn_cyclic;
@@ -1897,6 +1898,7 @@ struct elf_prstatus {
 #define OPT_NON_MMAP            OPT_START+13
 #define OPT_MEM_USAGE            OPT_START+14
 #define OPT_SPLITBLOCK_SIZE	OPT_START+15
+#define OPT_WORKING_DIR         OPT_START+16
 
 /*
  * Function Prototype.
diff --git a/print_info.c b/print_info.c
index 9215e0f..6610e76 100644
--- a/print_info.c
+++ b/print_info.c
@@ -213,6 +213,13 @@ print_usage(void)
 	MSG("      same as v1.4.4 or before.\n");
 	MSG("      If you feel the cyclic mode is too slow, please try this mode.\n");
 	MSG("\n");
+	MSG("  [--work-dir]:\n");
+	MSG("      Specify the working directory for the temporary bitmap file.\n");
+	MSG("      If this option isn't specified, the bitmap will be saved on memory.\n");
+	MSG("      Filtering processing has to do 2 pass scanning to fix the memory consumption,\n");
+	MSG("      but it can be avoided by using working directory on file system.\n");
+	MSG("      So if you specify this option, the filtering speed may be bit faster.\n");
+	MSG("\n");
 	MSG("  [--non-mmap]:\n");
 	MSG("      Never use mmap(2) to read VMCORE even if it supports mmap(2).\n");
 	MSG("      Generally, reading VMCORE with mmap(2) is faster than without it,\n");
-- 
1.9.0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
