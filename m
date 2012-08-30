Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T6zWx-0001be-S6
 for kexec@lists.infradead.org; Thu, 30 Aug 2012 07:51:13 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.193])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id q7U7p77B003240
 for <kexec@lists.infradead.org>; Thu, 30 Aug 2012 16:51:07 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id q7U7p7B09738 for kexec@lists.infradead.org;
 Thu, 30 Aug 2012 16:51:07 +0900 (JST)
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
 by mailsv4.nec.co.jp (8.13.8/8.13.4) with ESMTP id q7U7p6tu011093
 for <kexec@lists.infradead.org>; Thu, 30 Aug 2012 16:51:06 +0900 (JST)
Date: Thu, 30 Aug 2012 16:45:21 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [PATCH 01/16] [PATCH v3 1/12] Introduce cyclic mode to keep memory
 usage constant.
Message-Id: <20120830164521.0b07c16fe2993dd8afafc79b@mxc.nes.nec.co.jp>
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

From 4882ae0b4b3ff3e129aa8d8062b50d2298148e8e Mon Sep 17 00:00:00 2001
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Date: Thu, 23 Aug 2012 17:48:51 +0900
Subject: [PATCH 01/16] [PATCH v3 1/12] Introduce cyclic mode to keep memory usage constant.

This patchset introduces new filtering logic called "cyclic mode" as a default.
In cyclic mode, makedumpfile reads a constant region of memory, analyzes it,
and writes pages to dumpfile repeatedly from start of memory to the end.
As a result, memory usage will be kept constant regardless of system memory size.

However, cyclic mode has performance issue in the logic to exclude free pages.
(I'm going to improve this issue in feature release.)
If you feel cyclic mode is too slow, you can specify --non-cyclic option.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 README         |   15 +++++++++++++++
 makedumpfile.8 |   21 +++++++++++++++------
 makedumpfile.c |   11 +++++++++++
 makedumpfile.h |    1 +
 print_info.c   |    5 +++++
 5 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/README b/README
index ae986d1..7ae3872 100644
--- a/README
+++ b/README
@@ -122,6 +122,21 @@
      does not exclude Xen user domain pages. So user should specify '-X'
      option for excluding Xen user domain pages.
 
+  4. There are two running mode in makedumpfile-1.5.0 or later.
+    cyclic mode:
+      In this mode, makedumpfile reads a constant region of memory, analyzes
+      it, and writes pages to dumpfile cyclically from start of memory to the
+      end. Each cycle consume constant memory for analysis of constant region,
+      so the memory usage of makedumpfile will be kept constant regardless of
+      system memory size. This mode is default mode. 
+
+    non-cyclic mode:
+      In this mode, makedumpfile creates temporary bitmap file in TMPDIR for
+      analysis. The size of bitmap increases linearly based on physical memory
+      size. Therefore, if your machine has a lots of memory and you use tmpfs
+      on TMPDIR in 2nd kernel, makedumpfile can fail due to lack of memory.
+      makedumpfile-1.4.4 or before has only this mode.
+
 * FAQ
   001: If installing elfutils-0.137 into older elfutils by the above way, the
        following problem happens sometimes. If seeing, try to enable LDFLAGS
diff --git a/makedumpfile.8 b/makedumpfile.8
index 1fb9756..7535a60 100644
--- a/makedumpfile.8
+++ b/makedumpfile.8
@@ -347,6 +347,15 @@ on the following example.
 # makedumpfile \-\-reassemble dumpfile1 dumpfile2 dumpfile
 
 .TP
+\fB\-\-non\-cyclic\fR
+Running in non-cyclic mode, this mode uses old filtering logic same as v1.4.4 or before.
+If you feel cyclic mode is too slow, please try this mode.
+.br
+.B Example:
+.br
+# makedumpfile \-\-non\-cyclic \-d 31 \-x vmlinux /proc/vmcore dumpfile
+
+.TP
 \fB\-\-xen-syms\fR \fIXEN-SYMS\fR
 Specify the \fIXEN-SYMS\fR with debug information to analyze the xen's memory usage.
 This option extracts the part of xen and domain-0.
@@ -502,12 +511,12 @@ Show the version of makedumpfile.
 
 .TP 8
 .B TMPDIR
-This environment variable is for a temporary memory bitmap file.
-If your machine has a lots of memory and you use tmpfs on /tmp, makedumpfile 
-can fail for a little memory in the 2nd kernel because makedumpfile makes a 
-very large temporary memory bitmap file in this case. To avoid this failure, 
-you can set a TMPDIR environment variable. If you do not set a TMPDIR 
-environment variable, makedumpfile uses /tmp directory for a temporary 
+This environment variable is for a temporary memory bitmap file only in non-cyclic mode.
+If your machine has a lots of memory and you use tmpfs on /tmp, makedumpfile
+can fail for a little memory in the 2nd kernel because makedumpfile makes a
+very large temporary memory bitmap file in this case. To avoid this failure,
+you can set a TMPDIR environment variable. If you do not set a TMPDIR
+environment variable, makedumpfile uses /tmp directory for a temporary
 bitmap file as a default.
 
 .SH DIAGNOSTICS
diff --git a/makedumpfile.c b/makedumpfile.c
index d024e95..21bb55a 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2553,6 +2553,8 @@ initial(void)
 							info->name_memory);
 			return FALSE;
 		}
+		info->flag_cyclic = FALSE;
+
 		info->phys_base = info->kh_memory->phys_base;
 		info->max_dump_level |= info->kh_memory->dump_level;
 
@@ -6945,6 +6947,7 @@ static struct option longopts[] = {
 	{"config", required_argument, NULL, 'C'},
 	{"help", no_argument, NULL, 'h'},
 	{"diskset", required_argument, NULL, 'k'},
+	{"non-cyclic", no_argument, NULL, 'Y'},
 	{0, 0, 0, 0}
 };
 
@@ -6966,6 +6969,11 @@ main(int argc, char *argv[])
 	}
 	initialize_tables();
 
+	/*
+	 * In default, makedumpfile works in constant memory space.
+	 */
+	info->flag_cyclic = TRUE;
+	
 	info->block_order = DEFAULT_ORDER;
 	message_level = DEFAULT_MSG_LEVEL;
 	while ((opt = getopt_long(argc, argv, "b:cDd:EFfg:hi:lMRrsvXx:", longopts,
@@ -7053,6 +7061,9 @@ main(int argc, char *argv[])
 		case 'y':
 			info->name_xen_syms = optarg;
 			break;
+		case 'Y':
+			info->flag_cyclic = FALSE;
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
index 61cafed..14eec8e 100644
--- a/print_info.c
+++ b/print_info.c
@@ -162,6 +162,11 @@ print_usage(void)
 	MSG("      Reassemble multiple DUMPFILEs, which are created by --split option,\n");
 	MSG("      into one DUMPFILE. dumpfile1 and dumpfile2 are reassembled into dumpfile.\n");
 	MSG("\n");
+	MSG("  [--non-cyclic]:\n");
+	MSG("      Running in non-cyclic mode, this mode uses old filtering logic same as\n");
+	MSG("      v1.4.4 or before.\n");
+	MSG("      If you feel cyclic mode is too slow, please try this mode.\n");
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
