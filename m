Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1S0NZY-0000uc-Vm
 for kexec@lists.infradead.org; Thu, 23 Feb 2012 01:34:18 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 63E2D3EE0AE
 for <kexec@lists.infradead.org>; Thu, 23 Feb 2012 10:34:12 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 3E4C645DEB4
 for <kexec@lists.infradead.org>; Thu, 23 Feb 2012 10:34:12 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 15EFD45DE9E
 for <kexec@lists.infradead.org>; Thu, 23 Feb 2012 10:34:12 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 091871DB8041
 for <kexec@lists.infradead.org>; Thu, 23 Feb 2012 10:34:12 +0900 (JST)
Received: from m105.s.css.fujitsu.com (m105.s.css.fujitsu.com [10.240.81.145])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id A518B1DB803E
 for <kexec@lists.infradead.org>; Thu, 23 Feb 2012 10:34:11 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH makedumpfile v2 3/4] Add help and manual messages about LZO
 compression support
Date: Thu, 23 Feb 2012 10:34:10 +0900
Message-ID: <20120223013410.5041.83681.stgit@localhost6.localdomain6>
In-Reply-To: <20120223012940.5041.61104.stgit@localhost6.localdomain6>
References: <20120223012940.5041.61104.stgit@localhost6.localdomain6>
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
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org, crash-utility@redhat.com

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 makedumpfile.8 |    6 +++---
 print_info.c   |   16 ++++++++--------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/makedumpfile.8 b/makedumpfile.8
index 4733420..f607bf5 100644
--- a/makedumpfile.8
+++ b/makedumpfile.8
@@ -121,8 +121,8 @@ configuration, you need to use --diskset option.
 .SH OPTIONS
 
 .TP
-\fB\-c\fR
-Compress dump data by each page.
+\fB\-c,\-l\fR
+Compress dump data by each page using zlib for -c option or lzo for -l option.
 .br
 A user cannot specify this option with \-E option, because the ELF format does
 not support compressed data.
@@ -196,7 +196,7 @@ by dump_level 11, makedumpfile retries it by dump_level 31.
 \fB\-E\fR
 Create \fIDUMPFILE\fR in the ELF format.
 .br
-This option cannot be specified with \-c option, because the ELF format does not
+This option cannot be specified with either of \-c option or \-l option, because the ELF format does not
 support compressed data.
 .br
 .B Example:
diff --git a/print_info.c b/print_info.c
index 31460b7..237892e 100644
--- a/print_info.c
+++ b/print_info.c
@@ -35,15 +35,15 @@ print_usage(void)
 	MSG("\n");
 	MSG("Usage:\n");
 	MSG("  Creating DUMPFILE:\n");
-	MSG("  # makedumpfile    [-c|-E] [-d DL] [-x VMLINUX|-i VMCOREINFO] VMCORE DUMPFILE\n");
+	MSG("  # makedumpfile    [-c|-l|-E] [-d DL] [-x VMLINUX|-i VMCOREINFO] VMCORE DUMPFILE\n");
 	MSG("\n");
 	MSG("  Creating DUMPFILE with filtered kernel data specified through filter config\n");
 	MSG("  file:\n");
-	MSG("  # makedumpfile    [-c|-E] [-d DL] -x VMLINUX --config FILTERCONFIGFILE VMCORE\n");
+	MSG("  # makedumpfile    [-c|-l|-E] [-d DL] -x VMLINUX --config FILTERCONFIGFILE VMCORE\n");
 	MSG("    DUMPFILE\n");
 	MSG("\n");
 	MSG("  Outputting the dump data in the flattened format to the standard output:\n");
-	MSG("  # makedumpfile -F [-c|-E] [-d DL] [-x VMLINUX|-i VMCOREINFO] VMCORE\n");
+	MSG("  # makedumpfile -F [-c|-l|-E] [-d DL] [-x VMLINUX|-i VMCOREINFO] VMCORE\n");
 	MSG("\n");
 	MSG("  Rearranging the dump data in the flattened format to a readable DUMPFILE:\n");
 	MSG("  # makedumpfile -R DUMPFILE\n");
@@ -70,14 +70,14 @@ print_usage(void)
 	MSG("\n");
 	MSG("\n");
 	MSG("  Creating DUMPFILE from multiple VMCOREs generated on sadump diskset configuration:\n");
-	MSG("  # makedumpfile [-c] [-d DL] -x VMLINUX --diskset=VMCORE1 --diskset=VMCORE2\n");
+	MSG("  # makedumpfile [-c|-l] [-d DL] -x VMLINUX --diskset=VMCORE1 --diskset=VMCORE2\n");
 	MSG("    [--diskset=VMCORE3 ..] DUMPFILE\n");
 	MSG("\n");
 	MSG("\n");
 	MSG("Available options:\n");
-	MSG("  [-c]:\n");
-	MSG("      Compress dump data by each page.\n");
-	MSG("      A user cannot specify this option with -E option, because the ELF format\n");
+	MSG("  [-c|-l]:\n");
+	MSG("      Compress dump data by each page using zlib for -c option and lzo for -l option.\n");
+	MSG("      A user cannot specify either of these options with -E option, because the ELF format\n");
 	MSG("      does not support compressed data.\n");
 	MSG("      THIS IS ONLY FOR THE CRASH UTILITY.\n");
 	MSG("\n");
@@ -103,7 +103,7 @@ print_usage(void)
 	MSG("\n");
 	MSG("  [-E]:\n");
 	MSG("      Create DUMPFILE in the ELF format.\n");
-	MSG("      This option cannot be specified with -c option, because the ELF\n");
+	MSG("      This option cannot be specified with either of -c option or -l option, because the ELF\n");
 	MSG("      format does not support compressed data.\n");
 	MSG("\n");
 	MSG("  [-x VMLINUX]:\n");


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
