Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e31.co.us.ibm.com ([32.97.110.149])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U2GCm-00039z-1C
 for kexec@lists.infradead.org; Mon, 04 Feb 2013 07:11:04 +0000
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aravinda@linux.vnet.ibm.com>;
 Mon, 4 Feb 2013 00:11:03 -0700
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id E911C3E40039
 for <kexec@lists.infradead.org>; Mon,  4 Feb 2013 00:10:53 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r147B1K7267822
 for <kexec@lists.infradead.org>; Mon, 4 Feb 2013 00:11:01 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r147B0Lv010535
 for <kexec@lists.infradead.org>; Mon, 4 Feb 2013 00:11:00 -0700
Subject: [PATCH v4 9/9] Update Documentation
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Mon, 04 Feb 2013 12:40:56 +0530
Message-ID: <20130204071056.9292.41195.stgit@aravinda>
In-Reply-To: <20130204070724.9292.6640.stgit@aravinda>
References: <20130204070724.9292.6640.stgit@aravinda>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org
Cc: LChouinard@s2sys.com, tachibana@mxm.nes.nec.co.jp, ananth@in.ibm.com, buendgen@de.ibm.com

This patch updates usage message and man page.

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
---
 makedumpfile.8 |   18 +++++++++++++++++-
 print_info.c   |   13 ++++++++++---
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/makedumpfile.8 b/makedumpfile.8
index f955259..e9a7ce2 100644
--- a/makedumpfile.8
+++ b/makedumpfile.8
@@ -6,7 +6,7 @@ makedumpfile \- make a small dumpfile of kdump
 .br
 \fBmakedumpfile\fR \-F [\fIOPTION\fR] [\-x \fIVMLINUX\fR|\-i \fIVMCOREINFO\fR] \fIVMCORE\fR
 .br
-\fBmakedumpfile\fR   [\fIOPTION\fR] \-x \fIVMLINUX\fR \-\-config \fIFILTERCONFIGFILE\fR \fIVMCORE\fR \fIDUMPFILE\fR
+\fBmakedumpfile\fR   [\fIOPTION\fR] \-x \fIVMLINUX\fR [\-\-config \fIFILTERCONFIGFILE\fR] [\-\-eppic \fIEPPICMACRO\fR] \fIVMCORE\fR \fIDUMPFILE\fR
 .br
 \fBmakedumpfile\fR \-R \fIDUMPFILE\fR
 .br
@@ -70,6 +70,15 @@ filter commands. The memory locations that require to be filtered out are
 then poisoned with character 'X' (58 in Hex). Refer to
 \fBmakedumpfile.conf(5)\fR for file format.
 .PP
+Eppic macros can also be used to specify kernel symbols and its members that
+need to be filtered. Eppic provides C semantics including language constructs
+such as conditional statements, logical and arithmetic operators, functions,
+nested loops to traverse and erase kernel data. --eppic requires
+\fBeppic_makedumpfile.so\fR and eppic library. \fBeppic_makedumpfile.so\fR
+can be built from makedumpfile source. Refer to
+\fBhttp://code.google.com/p/eppic/\fR to build eppic library \fBlibeppic.a\fR
+and for more information on writing eppic macros.
+.PP
 To analyze the first kernel's memory usage, makedumpfile can refer to
 \fIVMCOREINFO\fR instead of \fIVMLINUX\fR. \fIVMCOREINFO\fR contains the first
 kernel's information (structure size, field offset, etc.), and \fIVMCOREINFO\fR
@@ -265,6 +274,13 @@ desired kernel data from vmcore while creating \fIDUMPFILE\fR. For filter
 command syntax please refer to \fBmakedumpfile.conf(5)\fR.
 
 .TP
+\fB\-\-eppic\fR \fIEPPICMACRO\fR
+Used in conjunction with \-x \fIVMLINUX\fR option, to specify the eppic macro
+file that contains filter rules or directory that contains eppic macro
+files to filter out desired kernel data from vmcore while creating \fIDUMPFILE\fR.
+When directory is specified, all the eppic macros in the directory are processed.
+
+.TP
 \fB\-F\fR
 Output the dump data in the flattened format to the standard output for
 transporting the dump data by SSH.
diff --git a/print_info.c b/print_info.c
index 2fc19f7..acc17f2 100644
--- a/print_info.c
+++ b/print_info.c
@@ -52,9 +52,9 @@ print_usage(void)
 	MSG("    DUMPFILE\n");
 	MSG("\n");
 	MSG("  Creating DUMPFILE with filtered kernel data specified through filter config\n");
-	MSG("  file:\n");
-	MSG("  # makedumpfile    [-c|-l|-E] [-d DL] -x VMLINUX --config FILTERCONFIGFILE\n");
-	MSG("    VMCORE DUMPFILE\n");
+	MSG("  file or eppic macro:\n");
+	MSG("  # makedumpfile    [-c|-l|-E] [-d DL] -x VMLINUX [--config FILTERCONFIGFILE]\n");
+	MSG("    [--eppic EPPICMACRO] VMCORE DUMPFILE\n");
 	MSG("\n");
 	MSG("  Outputting the dump data in the flattened format to the standard output:\n");
 	MSG("  # makedumpfile -F [-c|-l|-E] [-d DL] [-x VMLINUX|-i VMCOREINFO] VMCORE\n");
@@ -145,6 +145,13 @@ print_usage(void)
 	MSG("      file that contains filter commands to filter out desired kernel data\n");
 	MSG("      from vmcore while creating DUMPFILE.\n");
 	MSG("\n");
+	MSG("  [--eppic EPPICMACRO]:\n");
+	MSG("      Used in conjunction with -x VMLINUX option, to specify the eppic macro\n");
+	MSG("      file that contains filter rules or directory that contains eppic macro\n");
+	MSG("      files to filter out desired kernel data from vmcore while creating DUMPFILE.\n");
+	MSG("      When directory is specified, all the eppic macros in the directory are\n");
+	MSG("      processed\n");
+	MSG("\n");
 	MSG("  [-F]:\n");
 	MSG("      Output the dump data in the flattened format to the standard output\n");
 	MSG("      for transporting the dump data by SSH.\n");


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
