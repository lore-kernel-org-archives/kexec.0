Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XmFbD-00059l-OF
 for kexec@lists.infradead.org; Thu, 06 Nov 2014 05:27:12 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id sA65QOde018731
 for <kexec@lists.infradead.org>; Thu, 6 Nov 2014 13:26:24 +0800
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH V4 5/5] Add support for --splitblock-size
Date: Thu, 6 Nov 2014 13:23:22 +0800
Message-ID: <1415251402-12698-6-git-send-email-zhouwj-fnst@cn.fujitsu.com>
In-Reply-To: <1415251402-12698-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
References: <1415251402-12698-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
To: kexec@lists.infradead.org

Use --splitblock-size to specify splitblock size (KB)
When --split is specified in cyclic mode,splitblock table will be
generated in create_dump_bitmap().

Signed-off-by: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>
Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
---
 makedumpfile.8 |   10 ++++++++++
 makedumpfile.c |    4 ++++
 makedumpfile.h |    1 +
 print_info.c   |    5 +++++
 4 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/makedumpfile.8 b/makedumpfile.8
index 9cb12c0..5e121fd 100644
--- a/makedumpfile.8
+++ b/makedumpfile.8
@@ -386,6 +386,16 @@ size, so ordinary users don't need to specify this option.
 # makedumpfile \-\-cyclic\-buffer 1024 \-d 31 \-x vmlinux /proc/vmcore dumpfile
 
 .TP
+\fB\-\-splitblock\-size\fR \fIsplitblock_size\fR
+Specify the splitblock size in kilo bytes for analysis in the cyclic mode with --split.
+If --splitblock N is specified, difference of each splitted dumpfile size is at most N
+kilo bytes.
+.br
+.B Example:
+.br
+# makedumpfile \-\-splitblock\-size 1024 \-d 31 \-x vmlinux \-\-split /proc/vmcore dumpfile1 dumpfile2
+
+.TP
 \fB\-\-non\-cyclic\fR
 Running in the non-cyclic mode, this mode uses the old filtering logic same as v1.4.4 or before.
 If you feel the cyclic mode is too slow, please try this mode.
diff --git a/makedumpfile.c b/makedumpfile.c
index 831e7de..103c008 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -9567,6 +9567,7 @@ static struct option longopts[] = {
 	{"eppic", required_argument, NULL, OPT_EPPIC},
 	{"non-mmap", no_argument, NULL, OPT_NON_MMAP},
 	{"mem-usage", no_argument, NULL, OPT_MEM_USAGE},
+	{"splitblock-size", required_argument, NULL, OPT_SPLITBLOCK_SIZE},
 	{0, 0, 0, 0}
 };
 
@@ -9707,6 +9708,9 @@ main(int argc, char *argv[])
 		case OPT_CYCLIC_BUFFER:
 			info->bufsize_cyclic = atoi(optarg);
 			break;
+		case OPT_SPLITBLOCK_SIZE:
+			info->splitblock_size = atoi(optarg);
+			break;
 		case '?':
 			MSG("Commandline parameter is invalid.\n");
 			MSG("Try `makedumpfile --help' for more information.\n");
diff --git a/makedumpfile.h b/makedumpfile.h
index 39c49b8..d195069 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1885,6 +1885,7 @@ struct elf_prstatus {
 #define OPT_EPPIC               OPT_START+12
 #define OPT_NON_MMAP            OPT_START+13
 #define OPT_MEM_USAGE            OPT_START+14
+#define OPT_SPLITBLOCK_SIZE		OPT_START+15
 
 /*
  * Function Prototype.
diff --git a/print_info.c b/print_info.c
index f6342d3..16830b2 100644
--- a/print_info.c
+++ b/print_info.c
@@ -203,6 +203,11 @@ print_usage(void)
 	MSG("      By default, BUFFER_SIZE will be calculated automatically depending on\n");
 	MSG("      system memory size, so ordinary users don't need to specify this option.\n");
 	MSG("\n");
+	MSG("  [--splitblock-size SPLITBLOCK_SIZE]:\n");
+	MSG("      Specify the splitblock size in kilo bytes for analysis in the cyclic mode\n");
+	MSG("      with --split.If --splitblock N is specified, difference of each splitted\n");
+	MSG("	   dumpfile size is at most N kilo bytes.\n");
+	MSG("\n");
 	MSG("  [--non-cyclic]:\n");
 	MSG("      Running in the non-cyclic mode, this mode uses the old filtering logic\n");
 	MSG("      same as v1.4.4 or before.\n");
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
