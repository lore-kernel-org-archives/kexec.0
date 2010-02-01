Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NbvAU-0005A7-Nh
	for kexec@lists.infradead.org; Mon, 01 Feb 2010 12:14:24 +0000
Received: from yukiko.kent.sydney.vergenet.net
	(203-206-13-190.dyn.iinet.net.au [203.206.13.190])
	by kirsty.vergenet.net (Postfix) with ESMTP id 29B522465E
	for <kexec@lists.infradead.org>; Mon,  1 Feb 2010 23:14:02 +1100 (EST)
Message-Id: <20100201121323.935508960@vergenet.net>
Date: Mon, 01 Feb 2010 23:12:15 +1100
From: Simon Horman <horms@verge.net.au>
Subject: [patch 19/27] Consistently use signed char buffers throughout
References: <20100201121156.252909695@vergenet.net>
Content-Disposition: inline; filename=char-buf.patch
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Kexec Mailing List <kexec@lists.infradead.org>

Signed-off-by: Simon Horman <horms@verge.net.au>


Index: kexec-tools/kexec/arch/x86_64/kexec-elf-x86_64.c
===================================================================
--- kexec-tools.orig/kexec/arch/x86_64/kexec-elf-x86_64.c	2010-02-01 23:07:15.000000000 +1100
+++ kexec-tools/kexec/arch/x86_64/kexec-elf-x86_64.c	2010-02-01 23:07:21.000000000 +1100
@@ -203,8 +203,7 @@ int elf_x86_64_load(int argc, char **arg
 		struct entry64_regs regs;
 
 		/* Setup the ELF boot notes */
-		note_base = elf_boot_notes(info, max_addr,
-			command_line, command_line_len);
+		note_base = elf_boot_notes(info, max_addr, command_line, command_line_len);
 
 		/* Initialize the registers */
 		elf_rel_get_symbol(&info->rhdr, "entry64_regs", &regs, sizeof(regs));
@@ -220,7 +219,7 @@ int elf_x86_64_load(int argc, char **arg
 	else if (arg_style == ARG_STYLE_LINUX) {
 		struct x86_linux_faked_param_header *hdr;
 		unsigned long param_base;
-		const unsigned char *ramdisk_buf;
+		char *ramdisk_buf;
 		off_t ramdisk_length;
 		struct entry64_regs regs;
 		int rc=0;
Index: kexec-tools/kexec/kexec-elf-boot.c
===================================================================
--- kexec-tools.orig/kexec/kexec-elf-boot.c	2010-02-01 23:06:39.000000000 +1100
+++ kexec-tools/kexec/kexec-elf-boot.c	2010-02-01 23:07:21.000000000 +1100
@@ -75,7 +75,7 @@ static inline unsigned long align(unsign
 
 unsigned long elf_boot_notes(
 	struct kexec_info *info, unsigned long max_addr,
-	const unsigned char *cmdline, int cmdline_len)
+	const char *cmdline, int cmdline_len)
 {
 	unsigned long note_bytes;
 	unsigned long note_base;
Index: kexec-tools/kexec/kexec-elf-boot.h
===================================================================
--- kexec-tools.orig/kexec/kexec-elf-boot.h	2010-02-01 23:06:39.000000000 +1100
+++ kexec-tools/kexec/kexec-elf-boot.h	2010-02-01 23:07:21.000000000 +1100
@@ -3,6 +3,6 @@
 
 unsigned long elf_boot_notes(
 	struct kexec_info *info, unsigned long max_addr, 
-	const unsigned char *cmdline, int cmdline_len);
+	const char *cmdline, int cmdline_len);
 
 #endif /* KEXEC_ELF_BOOT_H */
Index: kexec-tools/kexec/arch/i386/kexec-elf-x86.c
===================================================================
--- kexec-tools.orig/kexec/arch/i386/kexec-elf-x86.c	2010-02-01 23:07:21.000000000 +1100
+++ kexec-tools/kexec/arch/i386/kexec-elf-x86.c	2010-02-01 23:07:21.000000000 +1100
@@ -205,7 +205,7 @@ int elf_x86_load(int argc, char **argv, 
 
 		/* Setup the ELF boot notes */
 		note_base = elf_boot_notes(info, max_addr,
-			(unsigned char *) command_line, command_line_len);
+					   command_line, command_line_len);
 
 		/* Initialize the stack arguments */
 		arg2 = 0; /* No return address */
@@ -226,7 +226,7 @@ int elf_x86_load(int argc, char **argv, 
 	else if (arg_style == ARG_STYLE_LINUX) {
 		struct x86_linux_faked_param_header *hdr;
 		unsigned long param_base;
-		const unsigned char *ramdisk_buf;
+		const char *ramdisk_buf;
 		off_t ramdisk_length;
 		struct entry32_regs regs;
 		int rc = 0;
@@ -253,7 +253,7 @@ int elf_x86_load(int argc, char **argv, 
 		ramdisk_buf = NULL;
 		ramdisk_length = 0;
 		if (ramdisk) {
-			ramdisk_buf = (unsigned char *) slurp_file(ramdisk, &ramdisk_length);
+			ramdisk_buf = slurp_file(ramdisk, &ramdisk_length);
 		}
 
 		/* If panic kernel is being loaded, additional segments need
Index: kexec-tools/kexec/arch/i386/kexec-bzImage.c
===================================================================
--- kexec-tools.orig/kexec/arch/i386/kexec-bzImage.c	2010-02-01 23:07:21.000000000 +1100
+++ kexec-tools/kexec/arch/i386/kexec-bzImage.c	2010-02-01 23:07:21.000000000 +1100
@@ -264,7 +264,7 @@ int do_bzImage_load(struct kexec_info *i
 	/* Tell the kernel what is going on */
 	setup_linux_bootloader_parameters(info, real_mode, setup_base,
 		kern16_size, command_line, command_line_len,
-		(unsigned char *) initrd, initrd_len);
+		initrd, initrd_len);
 
 	/* Get the initial register values */
 	elf_rel_get_symbol(&info->rhdr, "entry16_regs", &regs16, sizeof(regs16));
Index: kexec-tools/kexec/arch/i386/x86-linux-setup.c
===================================================================
--- kexec-tools.orig/kexec/arch/i386/x86-linux-setup.c	2010-02-01 23:07:17.000000000 +1100
+++ kexec-tools/kexec/arch/i386/x86-linux-setup.c	2010-02-01 23:07:21.000000000 +1100
@@ -49,7 +49,7 @@ void setup_linux_bootloader_parameters(
 	struct kexec_info *info, struct x86_linux_param_header *real_mode,
 	unsigned long real_mode_base, unsigned long cmdline_offset,
 	const char *cmdline, off_t cmdline_len,
-	const unsigned char *initrd_buf, off_t initrd_size)
+	const char *initrd_buf, off_t initrd_size)
 {
 	char *cmdline_ptr;
 	unsigned long initrd_base, initrd_addr_max;
Index: kexec-tools/kexec/arch/i386/x86-linux-setup.h
===================================================================
--- kexec-tools.orig/kexec/arch/i386/x86-linux-setup.h	2010-02-01 23:06:39.000000000 +1100
+++ kexec-tools/kexec/arch/i386/x86-linux-setup.h	2010-02-01 23:07:21.000000000 +1100
@@ -6,7 +6,7 @@ void setup_linux_bootloader_parameters(
 	struct kexec_info *info, struct x86_linux_param_header *real_mode,
 	unsigned long real_mode_base, unsigned long cmdline_offset,
 	const char *cmdline, off_t cmdline_len,
-	const unsigned char *initrd_buf, off_t initrd_size);
+	const char *initrd_buf, off_t initrd_size);
 void setup_linux_system_parameters(struct x86_linux_param_header *real_mode,
 					unsigned long kexec_flags);
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
