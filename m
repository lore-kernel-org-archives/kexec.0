Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SkQmP-0001Pk-2Z
 for kexec@lists.infradead.org; Fri, 29 Jun 2012 02:17:54 +0000
Received: from mailgate4.nec.co.jp ([10.7.69.184])
 by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id q5T2Hlhg004245
 for <kexec@lists.infradead.org>; Fri, 29 Jun 2012 11:17:47 +0900 (JST)
Received: (from root@localhost) by mailgate4.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id q5T2HlY09064 for kexec@lists.infradead.org;
 Fri, 29 Jun 2012 11:17:47 +0900 (JST)
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
 by mailsv.nec.co.jp (8.13.8/8.13.4) with ESMTP id q5T2HkJj019865
 for <kexec@lists.infradead.org>; Fri, 29 Jun 2012 11:17:47 +0900 (JST)
Date: Fri, 29 Jun 2012 11:16:05 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [RFC PATCH v2 1/10] Add flag to enable cyclic processing.
Message-Id: <20120629111605.2dd0f2d6.kumagai-atsushi@mxc.nes.nec.co.jp>
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

Introduce --cyclic option to enable cyclic processing. If --cyclic option is
specified, then makedumpfile works cyclically and the memory usage will be constant.

Usage:
    # makedumpfile --cyclic /proc/vmcore dumpfile

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.8 |   12 ++++++++++++
 makedumpfile.c |    4 ++++
 makedumpfile.h |    1 +
 print_info.c   |    9 +++++++++
 4 files changed, 26 insertions(+)

diff --git a/makedumpfile.8 b/makedumpfile.8
index 1fb9756..6ab2599 100644
--- a/makedumpfile.8
+++ b/makedumpfile.8
@@ -346,6 +346,18 @@ on the following example.
 .br
 # makedumpfile \-\-reassemble dumpfile1 dumpfile2 dumpfile
 
+
+.TP
+\fB\-\-cyclic\fR
+Creating bitmaps and writing pages cyclically for constant target memory range.
+As a result, makedumpfile can works in constant memory space regardless of 
+system memory size.
+This feature is \fITESTING VERSION\fR now.
+.br
+.B Example:
+.br
+# makedumpfile \-\-cyclic \-d 31 \-x vmlinux /proc/vmcore dumpfile
+
 .TP
 \fB\-\-xen-syms\fR \fIXEN-SYMS\fR
 Specify the \fIXEN-SYMS\fR with debug information to analyze the xen's memory usage.
diff --git a/makedumpfile.c b/makedumpfile.c
index d024e95..87bd680 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -6945,6 +6945,7 @@ static struct option longopts[] = {
 	{"config", required_argument, NULL, 'C'},
 	{"help", no_argument, NULL, 'h'},
 	{"diskset", required_argument, NULL, 'k'},
+	{"cyclic", no_argument, NULL, 'Y'},
 	{0, 0, 0, 0}
 };
 
@@ -7053,6 +7054,9 @@ main(int argc, char *argv[])
 		case 'y':
 			info->name_xen_syms = optarg;
 			break;
+		case 'Y':
+			info->flag_cyclic = TRUE;
+			break;
 		case 'z':
 			info->flag_read_vmcoreinfo = 1;
 			info->name_vmcoreinfo = optarg;
diff --git a/makedumpfile.h b/makedumpfile.h
index 6f5489d..287e055 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -801,6 +801,7 @@ struct DumpInfo {
 	int		flag_rearrange;      /* flag of creating dumpfile from
 						flattened format */
 	int		flag_split;	     /* splitting vmcore */
+  	int		flag_cyclic;	     /* cyclic processing to keep memory consumption */
 	int		flag_reassemble;     /* reassemble multiple dumpfiles into one */
 	int		flag_refiltering;    /* refilter from kdump-compressed file */
 	int		flag_force;	     /* overwrite existing stuff */
diff --git a/print_info.c b/print_info.c
index 61cafed..0d8a7b3 100644
--- a/print_info.c
+++ b/print_info.c
@@ -62,6 +62,10 @@ print_usage(void)
 	MSG("\n");
 	MSG("  Reassemble multiple DUMPFILEs:\n");
 	MSG("  # makedumpfile --reassemble DUMPFILE1 DUMPFILE2 [DUMPFILE3 ..] DUMPFILE\n");
+	MSG("    DUMPFILE2 [DUMPFILE3 ..]\n");
+	MSG("\n");
+	MSG("  Creating DUMPFILE with cyclic processing:\n");
+	MSG("  # makedumpfile --cyclic [OPTION] [-x VMLINUX|-i VMCOREINFO] VMCORE DUMPFILE\n");
 	MSG("\n");
 	MSG("  Generating VMCOREINFO:\n");
 	MSG("  # makedumpfile -g VMCOREINFO -x VMLINUX\n");
@@ -162,6 +166,11 @@ print_usage(void)
 	MSG("      Reassemble multiple DUMPFILEs, which are created by --split option,\n");
 	MSG("      into one DUMPFILE. dumpfile1 and dumpfile2 are reassembled into dumpfile.\n");
 	MSG("\n");
+	MSG("  [--cyclic]:\n");
+	MSG("      Creating bitmaps and writing pages for certain target memory range.\n");
+	MSG("      As a result, makedumpfile can works in constant memory space regardless of \n");
+	MSG("      system memory size. This feature is TESTING VERSION now.\n");
+	MSG("\n");
 	MSG("  [--xen-syms XEN-SYMS]:\n");
 	MSG("      Specify the XEN-SYMS to analyze Xen's memory usage.\n");
 	MSG("\n");
-- 
1.7.9.2

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
