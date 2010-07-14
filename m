Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]
	helo=VA3EHSOBE006.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OZ3x7-0007Rq-Db
	for kexec@lists.infradead.org; Wed, 14 Jul 2010 15:32:54 +0000
Received: from mail67-va3 (localhost.localdomain [127.0.0.1])	by
	mail67-va3-R.bigfish.com (Postfix) with ESMTP id 3C563678394	for
	<kexec@lists.infradead.org>; Wed, 14 Jul 2010 15:32:51 +0000 (UTC)
Received: from VA3EHSMHS030.bigfish.com (unknown [10.7.14.251])	by
	mail67-va3.bigfish.com (Postfix) with ESMTP id B6C8FD98078	for
	<kexec@lists.infradead.org>; Wed, 14 Jul 2010 15:32:41 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o6EFWcTK012989	for <kexec@lists.infradead.org>;
	Wed, 14 Jul 2010 08:32:38 -0700 (MST)
From: Matthew McClintock <msm@freescale.com>
Subject: [PATCH] Update Elf-ppc to support crash kernel and misc fixes
Date: Wed, 14 Jul 2010 10:32:34 -0500
Message-ID: <1279121556-8069-3-git-send-email-msm@freescale.com>
In-Reply-To: <1279121556-8069-2-git-send-email-msm@freescale.com>
References: <1279121556-8069-1-git-send-email-msm@freescale.com>
	<1279121556-8069-2-git-send-email-msm@freescale.com>
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
To: kexec@lists.infradead.org
Cc: Matthew McClintock <msm@freescale.com>

Use current command line if none given, specifically useful for
when arguments are added causing the use of the current cmdline
to not occur

We also try to load the dtb above the kernel, this is useful for
relocatable kernels where they device tree needs to reside just
above the kernel base address

Set the kernel entry address in the relocatable purgatory code
so we jump to the correct start address if not the default. Useful
for relocatable kernels

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
 kexec/arch/ppc/kexec-elf-ppc.c |   26 ++++++++++++++------------
 kexec/arch/ppc/kexec-ppc.c     |    7 ++++---
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/kexec/arch/ppc/kexec-elf-ppc.c b/kexec/arch/ppc/kexec-elf-ppc.c
index ab2d343..87e6507 100644
--- a/kexec/arch/ppc/kexec-elf-ppc.c
+++ b/kexec/arch/ppc/kexec-elf-ppc.c
@@ -182,6 +182,7 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 	int target_is_gamecube = 0;
 	unsigned int addr;
 	unsigned long dtb_addr;
+	unsigned long kernel_addr;
 #endif
 #define FIXUP_ENTRYS	(20)
 	char *fixup_nodes[FIXUP_ENTRYS + 1];
@@ -228,6 +229,9 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 	command_line_len = 0;
 	if (command_line) {
 		command_line_len = strlen(command_line) + 1;
+	} else {
+		command_line = get_command_line();
+		command_line_len = strlen(command_line) + 1;
 	}
 
 	fixup_nodes[cur_fixup] = NULL;
@@ -264,11 +268,11 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 	if (size > phdr->p_memsz)
 		size = phdr->p_memsz;
 
-	hole_addr = locate_hole(info, size, 0, 0, max_addr, 1);
+	kernel_addr = locate_hole(info, size, 0, 0, max_addr, 1);
 #ifdef CONFIG_PPC64
-	ehdr.e_phdr[0].p_paddr = (Elf64_Addr)hole_addr;
+	ehdr.e_phdr[0].p_paddr = (Elf64_Addr)kernel_addr;
 #else
-	ehdr.e_phdr[0].p_paddr = hole_addr;
+	ehdr.e_phdr[0].p_paddr = kernel_addr;
 #endif
 
 	/* Load the Elf data */
@@ -343,10 +347,11 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 		blob_buf = slurp_file(dtb, &blob_size);
 		if (!blob_buf || !blob_size)
 			die("Device tree seems to be an empty file.\n");
+
 		blob_buf = fixup_dtb_nodes(blob_buf, &blob_size, fixup_nodes,
 				cmdline_buf);
-		dtb_addr = add_buffer(info, blob_buf, blob_size, blob_size, 0, 0,
-				KERNEL_ACCESS_TOP, -1);
+		dtb_addr = add_buffer(info, blob_buf, blob_size, blob_size, 0, kernel_addr,
+				kernel_addr + KERNEL_ACCESS_TOP, -1);
 	} else {
 		/* create from fs2dt */
 		seg_buf = NULL;
@@ -364,19 +369,16 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 
 
 	if (dtb) {
-		/* set various variables for the purgatory */
-		addr = ehdr.e_entry;
+		/* set various variables for the purgatory  ehdr.e_entry is a
+		 * virtual address, we can use kernel_addr which
+		 * should be the physical start address of the kernel */
+		addr = kernel_addr;
 		elf_rel_set_symbol(&info->rhdr, "kernel", &addr, sizeof(addr));
 
 		addr = dtb_addr;
 		elf_rel_set_symbol(&info->rhdr, "dt_offset",
 						&addr, sizeof(addr));
 
-		addr = rmo_top;
-
-		elf_rel_set_symbol(&info->rhdr, "mem_size",
-						&addr, sizeof(addr));
-
 #define PUL_STACK_SIZE	(16 * 1024)
 		addr = locate_hole(info, PUL_STACK_SIZE, 0, 0,
 				elf_max_addr(&ehdr), 1);
diff --git a/kexec/arch/ppc/kexec-ppc.c b/kexec/arch/ppc/kexec-ppc.c
index d7afad6..d9f1d05 100644
--- a/kexec/arch/ppc/kexec-ppc.c
+++ b/kexec/arch/ppc/kexec-ppc.c
@@ -27,9 +27,10 @@
 #include "config.h"
 
 uint64_t rmo_top;
-unsigned long long crash_base, crash_size;
-unsigned long long initrd_base, initrd_size;
-unsigned long long devicetree_base, devicetree_size;
+unsigned long long crash_base = 0, crash_size = 0;
+unsigned long long initrd_base = 0, initrd_size = 0;
+unsigned long long ramdisk_base = 0, ramdisk_size = 0;
+unsigned long long devicetree_base = 0, devicetree_size = 0;
 unsigned int rtas_base, rtas_size;
 int max_memory_ranges;
 
-- 
1.6.0.6



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
