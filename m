Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from wa-out-1112.google.com ([209.85.146.183])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Ljoyo-0008Vd-Ti
	for kexec@lists.infradead.org; Wed, 18 Mar 2009 06:10:25 +0000
Received: by wa-out-1112.google.com with SMTP id j5so212511wah.2
	for <kexec@lists.infradead.org>; Tue, 17 Mar 2009 23:10:17 -0700 (PDT)
From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 18 Mar 2009 15:07:46 +0900
Message-Id: <20090318060746.667.44875.sendpatchset@rx1.opensource.se>
Subject: [PATCH] kexec jump: SuperH vmlinux support
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: horms@verge.net.au, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm@igel.co.jp>

Create elf header and modify the kernel command line
when loading a crash kernel or a kexec jump kernel.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 kexec/arch/sh/kexec-elf-sh.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- 0001/kexec/arch/sh/kexec-elf-sh.c
+++ work/kexec/arch/sh/kexec-elf-sh.c	2009-03-18 13:44:29.000000000 +0900
@@ -104,7 +104,7 @@ int elf_sh_load(int argc, char **argv, c
 	/* Need to append some command line parameters internally in case of
 	 * taking crash dumps.
 	 */
-	if (info->kexec_flags & KEXEC_ON_CRASH) {
+	if (info->kexec_flags & (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT)) {
 		modified_cmdline = xmalloc(COMMAND_LINE_SIZE);
 		memset((void *)modified_cmdline, 0, COMMAND_LINE_SIZE);
 		if (command_line) {
@@ -120,7 +120,7 @@ int elf_sh_load(int argc, char **argv, c
 
 	/* If panic kernel is being loaded, additional segments need
 	 * to be created. */
-	if (info->kexec_flags & KEXEC_ON_CRASH) {
+	if (info->kexec_flags & (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT)) {
 		rc = load_crashdump_segments(info, modified_cmdline);
 		if (rc < 0)
 			return -1;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
