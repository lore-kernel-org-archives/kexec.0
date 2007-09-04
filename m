Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from xenotime.net ([66.160.160.81])
	by canuck.infradead.org with smtp (Exim 4.63 #1 (Red Hat Linux))
	id 1ISdE8-0007sf-KL
	for kexec@lists.infradead.org; Tue, 04 Sep 2007 14:34:20 -0400
Received: from midway.site ([96.225.192.201]) by xenotime.net for
	<kexec@lists.infradead.org>; Tue, 4 Sep 2007 11:34:12 -0700
Date: Tue, 4 Sep 2007 11:34:12 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
Subject: [patch] kexec-tools: fix typos
Message-Id: <20070904113412.0510f1c8.rdunlap@xenotime.net>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: horms@verge.net.au

From: Randy Dunlap <randy.dunlap@oracle.com>

Correct spelling/typos in baud_rate.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 kexec/arch/i386/kexec-x86.c      |    2 +-
 kexec/arch/x86_64/kexec-x86_64.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- kexec-tools-testing-20070330.orig/kexec/arch/i386/kexec-x86.c
+++ kexec-tools-testing-20070330/kexec/arch/i386/kexec-x86.c
@@ -131,7 +131,7 @@ void arch_usage(void)
 	printf(
 		"     --reset-vga               Attempt to reset a standard vga device\n"
 		"     --serial=<port>           Specify the serial port for debug output\n"
-		"     --serial-baud=<buad_rate> Specify the serial port baud rate\n"
+		"     --serial-baud=<baud_rate> Specify the serial port baud rate\n"
 		"     --console-vga             Enable the vga console\n"
 		"     --console-serial          Enable the serial console\n"
 		"     --elf32-core-headers      Prepare core headers in ELF32 format\n"
--- kexec-tools-testing-20070330.orig/kexec/arch/x86_64/kexec-x86_64.c
+++ kexec-tools-testing-20070330/kexec/arch/x86_64/kexec-x86_64.c
@@ -133,7 +133,7 @@ void arch_usage(void)
 	printf(
 		"     --reset-vga               Attempt to reset a standard vga device\n"
 		"     --serial=<port>           Specify the serial port for debug output\n"
-		"     --serial-baud=<buad_rate> Specify the serial port baud rate\n"
+		"     --serial-baud=<baud_rate> Specify the serial port baud rate\n"
 		"     --console-vga             Enable the vga console\n"
 		"     --console-serial          Enable the serial console\n"
 		);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
