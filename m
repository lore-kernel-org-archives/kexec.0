Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W0ZAJ-0003zY-PV
 for kexec@lists.infradead.org; Tue, 07 Jan 2014 16:06:05 +0000
From: Dave Anderson <anderson@redhat.com>
Subject: [PATCH] makedumpfile: add -p references where appropriate in "--help"
 output
Date: Tue,  7 Jan 2014 11:05:01 -0500
Message-Id: <1389110701-10870-1-git-send-email-anderson@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, Dave Anderson <anderson@redhat.com>

While the "makedumpfile --help" does have a couple references to 
snappy compression support, the output neglects to show the -p option 
in several examples.

---
 print_info.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/print_info.c b/print_info.c
index 90b6cee..a56a6a7 100644
--- a/print_info.c
+++ b/print_info.c
@@ -48,16 +48,16 @@ print_usage(void)
 	MSG("\n");
 	MSG("Usage:\n");
 	MSG("  Creating DUMPFILE:\n");
-	MSG("  # makedumpfile    [-c|-l|-E] [-d DL] [-x VMLINUX|-i VMCOREINFO] VMCORE\n");
+	MSG("  # makedumpfile    [-c|-l|-p|-E] [-d DL] [-x VMLINUX|-i VMCOREINFO] VMCORE\n");
 	MSG("    DUMPFILE\n");
 	MSG("\n");
 	MSG("  Creating DUMPFILE with filtered kernel data specified through filter config\n");
 	MSG("  file or eppic macro:\n");
-	MSG("  # makedumpfile    [-c|-l|-E] [-d DL] -x VMLINUX [--config FILTERCONFIGFILE]\n");
+	MSG("  # makedumpfile    [-c|-l|-p|-E] [-d DL] -x VMLINUX [--config FILTERCONFIGFILE]\n");
 	MSG("    [--eppic EPPICMACRO] VMCORE DUMPFILE\n");
 	MSG("\n");
 	MSG("  Outputting the dump data in the flattened format to the standard output:\n");
-	MSG("  # makedumpfile -F [-c|-l|-E] [-d DL] [-x VMLINUX|-i VMCOREINFO] VMCORE\n");
+	MSG("  # makedumpfile -F [-c|-l|-p|-E] [-d DL] [-x VMLINUX|-i VMCOREINFO] VMCORE\n");
 	MSG("\n");
 	MSG("  Rearranging the dump data in the flattened format to a readable DUMPFILE:\n");
 	MSG("  # makedumpfile -R DUMPFILE\n");
@@ -84,7 +84,7 @@ print_usage(void)
 	MSG("\n");
 	MSG("\n");
 	MSG("  Creating DUMPFILE from multiple VMCOREs generated on sadump diskset configuration:\n");
-	MSG("  # makedumpfile [-c|-l] [-d DL] -x VMLINUX --diskset=VMCORE1 --diskset=VMCORE2\n");
+	MSG("  # makedumpfile [-c|-l|-p] [-d DL] -x VMLINUX --diskset=VMCORE1 --diskset=VMCORE2\n");
 	MSG("    [--diskset=VMCORE3 ..] DUMPFILE\n");
 	MSG("\n");
 	MSG("\n");
@@ -117,7 +117,7 @@ print_usage(void)
 	MSG("\n");
 	MSG("  [-E]:\n");
 	MSG("      Create DUMPFILE in the ELF format.\n");
-	MSG("      This option cannot be specified with either of -c option or -l option,\n");
+	MSG("      This option cannot be specified with the -c, -l or -p options,\n");
 	MSG("      because the ELF format does not support compressed data.\n");
 	MSG("\n");
 	MSG("  [-x VMLINUX]:\n");
-- 
1.7.11.7


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
