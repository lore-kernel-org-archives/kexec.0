Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TyTf1-00051h-TV
 for kexec@lists.infradead.org; Thu, 24 Jan 2013 20:44:41 +0000
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v7 6/7] kexec, x86_64: Load bzImage64 above 4G
Date: Thu, 24 Jan 2013 12:44:23 -0800
Message-Id: <1359060264-10671-7-git-send-email-yinghai@kernel.org>
In-Reply-To: <1359060264-10671-1-git-send-email-yinghai@kernel.org>
References: <1359060264-10671-1-git-send-email-yinghai@kernel.org>
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
To: Simon Horman <horms@verge.net.au>, "H. Peter Anvin" <hpa@zytor.com>, Vivek Goyal <vgoyal@redhat.com>, Haren Myneni <hbabu@us.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Yinghai Lu <yinghai@kernel.org>, kexec@lists.infradead.org

need to check xloadflags to see the bzImage is for 64bit relocatable.

-v2: add kexec-bzImage64.c according to Eric.
-v3: don't need to purgatory under 2g after Eric's change to purgatory code.
-v4: use locate_hole find position first then add_buffer... suggested by Eric
     add buffer for kernel image at last to make kexec-load faster.
     use xloadflags in setup_header to tell if is bzImage64.
     remove not cross GB boundary searching.
     add --entry-32bit and --real-mode for skipping bzImage64.
-v5: add buffer with runtime size instead, so kernel could use BRK
     early and safely.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 kexec/arch/i386/include/arch/options.h |    4 +-
 kexec/arch/x86_64/Makefile             |    1 +
 kexec/arch/x86_64/kexec-bzImage64.c    |  312 ++++++++++++++++++++++++++++++++
 kexec/arch/x86_64/kexec-x86_64.c       |    1 +
 kexec/arch/x86_64/kexec-x86_64.h       |    5 +
 5 files changed, 322 insertions(+), 1 deletion(-)
 create mode 100644 kexec/arch/x86_64/kexec-bzImage64.c

diff --git a/kexec/arch/i386/include/arch/options.h b/kexec/arch/i386/include/arch/options.h
index 89dbd26..aaac731 100644
--- a/kexec/arch/i386/include/arch/options.h
+++ b/kexec/arch/i386/include/arch/options.h
@@ -29,6 +29,7 @@
 #define OPT_MOD 		(OPT_ARCH_MAX+7)
 #define OPT_VGA 		(OPT_ARCH_MAX+8)
 #define OPT_REAL_MODE		(OPT_ARCH_MAX+9)
+#define OPT_ENTRY_32BIT		(OPT_ARCH_MAX+10)
 
 /* Options relevant to the architecture (excluding loader-specific ones): */
 #define KEXEC_ARCH_OPTIONS \
@@ -68,7 +69,8 @@
 	{ "args-linux",		0, NULL, OPT_ARGS_LINUX },	\
 	{ "args-none",		0, NULL, OPT_ARGS_NONE },	\
 	{ "module",		1, 0, OPT_MOD },		\
-	{ "real-mode",		0, NULL, OPT_REAL_MODE },
+	{ "real-mode",		0, NULL, OPT_REAL_MODE },	\
+	{ "entry-32bit",	0, NULL, OPT_ENTRY_32BIT },
 
 #define KEXEC_ALL_OPT_STR KEXEC_ARCH_OPT_STR
 
diff --git a/kexec/arch/x86_64/Makefile b/kexec/arch/x86_64/Makefile
index 405bdf5..1cf10f9 100644
--- a/kexec/arch/x86_64/Makefile
+++ b/kexec/arch/x86_64/Makefile
@@ -13,6 +13,7 @@ x86_64_KEXEC_SRCS += kexec/arch/i386/crashdump-x86.c
 x86_64_KEXEC_SRCS_native =  kexec/arch/x86_64/kexec-x86_64.c
 x86_64_KEXEC_SRCS_native += kexec/arch/x86_64/kexec-elf-x86_64.c
 x86_64_KEXEC_SRCS_native += kexec/arch/x86_64/kexec-elf-rel-x86_64.c
+x86_64_KEXEC_SRCS_native += kexec/arch/x86_64/kexec-bzImage64.c
 
 x86_64_KEXEC_SRCS += $(x86_64_KEXEC_SRCS_native)
 
diff --git a/kexec/arch/x86_64/kexec-bzImage64.c b/kexec/arch/x86_64/kexec-bzImage64.c
new file mode 100644
index 0000000..e2b2412
--- /dev/null
+++ b/kexec/arch/x86_64/kexec-bzImage64.c
@@ -0,0 +1,312 @@
+/*
+ * kexec: Linux boots Linux
+ *
+ * Copyright (C) 2003-2010  Eric Biederman (ebiederm@xmission.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation (version 2 of the License).
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#define _GNU_SOURCE
+#include <stddef.h>
+#include <stdio.h>
+#include <string.h>
+#include <limits.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <getopt.h>
+#include <elf.h>
+#include <boot/elf_boot.h>
+#include <ip_checksum.h>
+#include <x86/x86-linux.h>
+#include "../../kexec.h"
+#include "../../kexec-elf.h"
+#include "../../kexec-syscall.h"
+#include "kexec-x86_64.h"
+#include "../i386/x86-linux-setup.h"
+#include "../i386/crashdump-x86.h"
+#include <arch/options.h>
+
+static const int probe_debug = 0;
+
+int bzImage64_probe(const char *buf, off_t len)
+{
+	const struct x86_linux_header *header;
+
+	if ((uintmax_t)len < (uintmax_t)(2 * 512)) {
+		if (probe_debug)
+			fprintf(stderr, "File is too short to be a bzImage!\n");
+		return -1;
+	}
+	header = (const struct x86_linux_header *)buf;
+	if (memcmp(header->header_magic, "HdrS", 4) != 0) {
+		if (probe_debug)
+			fprintf(stderr, "Not a bzImage\n");
+		return -1;
+	}
+	if (header->boot_sector_magic != 0xAA55) {
+		if (probe_debug)
+			fprintf(stderr, "No x86 boot sector present\n");
+		/* No x86 boot sector present */
+		return -1;
+	}
+	if (header->protocol_version < 0x020C) {
+		if (probe_debug)
+			fprintf(stderr, "Must be at least protocol version 2.12\n");
+		/* Must be at least protocol version 2.12 */
+		return -1;
+	}
+	if ((header->loadflags & 1) == 0) {
+		if (probe_debug)
+			fprintf(stderr, "zImage not a bzImage\n");
+		/* Not a bzImage */
+		return -1;
+	}
+	if (!(header->xloadflags & 1)) {
+		if (probe_debug)
+			fprintf(stderr, "Not a bzImage64\n");
+		/* Must be CAN_BE_LOADED_ABOVE_4G */
+		return -1;
+	}
+	/* I've got a bzImage64 */
+	if (probe_debug)
+		fprintf(stderr, "It's a bzImage64\n");
+	return 0;
+}
+
+void bzImage64_usage(void)
+{
+	printf( "    --entry-32bit         Use the kernels 32bit entry point.\n"
+		"    --real-mode           Use the kernels real mode entry point.\n"
+		"    --command-line=STRING Set the kernel command line to STRING.\n"
+		"    --append=STRING       Set the kernel command line to STRING.\n"
+		"    --reuse-cmdline       Use kernel command line from running system.\n"
+		"    --initrd=FILE         Use FILE as the kernel's initial ramdisk.\n"
+		"    --ramdisk=FILE        Use FILE as the kernel's initial ramdisk.\n"
+		);
+}
+
+static void clean_boot_params(unsigned char *real_mode, unsigned long size)
+{
+	unsigned long end;
+
+	/* clear value before header */
+	memset(real_mode, 0, 0x1f1);
+	/* clear value after setup_header  */
+	end = *(real_mode + 0x201);
+	end += 0x202;
+	if (end < size)
+		memset(real_mode + end, 0, size - end);
+}
+
+static int do_bzImage64_load(struct kexec_info *info,
+			const char *kernel, off_t kernel_len,
+			const char *command_line, off_t command_line_len,
+			const char *initrd, off_t initrd_len)
+{
+	struct x86_linux_header setup_header;
+	struct x86_linux_param_header *real_mode;
+	int setup_sects;
+	size_t size;
+	int kern16_size;
+	unsigned long setup_base, setup_size;
+	struct entry64_regs regs64;
+	char *modified_cmdline;
+	unsigned long cmdline_end;
+	unsigned long align, addr, k_size;
+	unsigned kern16_size_needed;
+
+	/*
+	 * Find out about the file I am about to load.
+	 */
+	if ((uintmax_t)kernel_len < (uintmax_t)(2 * 512))
+		return -1;
+
+	memcpy(&setup_header, kernel, sizeof(setup_header));
+	setup_sects = setup_header.setup_sects;
+	if (setup_sects == 0)
+		setup_sects = 4;
+	kern16_size = (setup_sects + 1) * 512;
+	if (kernel_len < kern16_size) {
+		fprintf(stderr, "BzImage truncated?\n");
+		return -1;
+	}
+
+	if ((uintmax_t)command_line_len > (uintmax_t)setup_header.cmdline_size) {
+		dbgprintf("Kernel command line too long for kernel!\n");
+		return -1;
+	}
+
+	/* Need to append some command line parameters internally in case of
+	 * taking crash dumps.
+	 */
+	if (info->kexec_flags & (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT)) {
+		modified_cmdline = xmalloc(COMMAND_LINE_SIZE);
+		memset((void *)modified_cmdline, 0, COMMAND_LINE_SIZE);
+		if (command_line) {
+			strncpy(modified_cmdline, command_line,
+					COMMAND_LINE_SIZE);
+			modified_cmdline[COMMAND_LINE_SIZE - 1] = '\0';
+		}
+
+		/* If panic kernel is being loaded, additional segments need
+		 * to be created. load_crashdump_segments will take care of
+		 * loading the segments as high in memory as possible, hence
+		 * in turn as away as possible from kernel to avoid being
+		 * stomped by the kernel.
+		 */
+		if (load_crashdump_segments(info, modified_cmdline, -1, 0) < 0)
+			return -1;
+
+		/* Use new command line buffer */
+		command_line = modified_cmdline;
+		command_line_len = strlen(command_line) + 1;
+	}
+
+	/* x86_64 purgatory could be anywhere */
+	elf_rel_build_load(info, &info->rhdr, purgatory, purgatory_size,
+				0x3000, -1, -1, 0);
+	dbgprintf("Loaded purgatory at addr 0x%lx\n", info->rhdr.rel_addr);
+	/* The argument/parameter segment */
+	kern16_size_needed = kern16_size;
+	if (kern16_size_needed < 4096)
+		kern16_size_needed = 4096;
+	setup_size = kern16_size_needed + command_line_len +
+				PURGATORY_CMDLINE_SIZE;
+	real_mode = xmalloc(setup_size);
+	memset(real_mode, 0, setup_size);
+	memcpy(real_mode, kernel, kern16_size);
+	clean_boot_params((unsigned char *)real_mode, kern16_size);
+
+	/* No real mode code will be executing. setup segment can be loaded
+	 * anywhere as we will be just reading command line.
+	 */
+	setup_base = add_buffer(info, real_mode, setup_size, setup_size,
+				16, 0x3000, -1, -1);
+
+	dbgprintf("Loaded real_mode_data and command line at 0x%lx\n",
+			setup_base);
+
+	/* The main kernel segment */
+	k_size = kernel_len - kern16_size;
+	/* need to use run-time size for buffer searching */
+	dbgprintf("kernel init_size 0x%x\n", real_mode->init_size);
+	size = (real_mode->init_size + (4096 - 1)) & ~(4096 - 1);
+	align = real_mode->kernel_alignment;
+	addr = add_buffer(info, kernel + kern16_size, k_size,
+			  size, align, 0x100000, -1, -1);
+	if (addr == ULONG_MAX)
+		die("can not load bzImage64");
+	dbgprintf("Loaded 64bit kernel at 0x%lx\n", addr);
+
+	/* Tell the kernel what is going on */
+	setup_linux_bootloader_parameters(info, real_mode, setup_base,
+			kern16_size_needed, command_line, command_line_len,
+			initrd, initrd_len);
+
+	elf_rel_get_symbol(&info->rhdr, "entry64_regs", &regs64,
+				 sizeof(regs64));
+	regs64.rbx = 0;           /* Bootstrap processor */
+	regs64.rsi = setup_base;  /* Pointer to the parameters */
+	regs64.rip = addr + 0x200; /* the entry point for startup_64 */
+	regs64.rsp = elf_rel_get_addr(&info->rhdr, "stack_end"); /* Stack, unused */
+	elf_rel_set_symbol(&info->rhdr, "entry64_regs", &regs64,
+				 sizeof(regs64));
+
+	cmdline_end = setup_base + kern16_size_needed + command_line_len - 1;
+	elf_rel_set_symbol(&info->rhdr, "cmdline_end", &cmdline_end,
+			   sizeof(unsigned long));
+
+	/* Fill in the information BIOS calls would normally provide. */
+	setup_linux_system_parameters(real_mode, info->kexec_flags);
+
+	return 0;
+}
+
+int bzImage64_load(int argc, char **argv, const char *buf, off_t len,
+	struct kexec_info *info)
+{
+	char *command_line = NULL;
+	const char *ramdisk = NULL, *append = NULL;
+	char *ramdisk_buf;
+	off_t ramdisk_length = 0;
+	int command_line_len;
+	int entry_16bit = 0, entry_32bit = 0;
+	int opt;
+	int result;
+
+	/* See options.h -- add any more there, too. */
+	static const struct option options[] = {
+		KEXEC_ARCH_OPTIONS
+		{ "command-line",	1, 0, OPT_APPEND },
+		{ "append",		1, 0, OPT_APPEND },
+		{ "reuse-cmdline",	0, 0, OPT_REUSE_CMDLINE },
+		{ "initrd",		1, 0, OPT_RAMDISK },
+		{ "ramdisk",		1, 0, OPT_RAMDISK },
+		{ "real-mode",		0, 0, OPT_REAL_MODE },
+		{ "entry-32bit",	0, 0, OPT_ENTRY_32BIT },
+		{ 0,			0, 0, 0 },
+	};
+	static const char short_options[] = KEXEC_ARCH_OPT_STR "d";
+
+	while ((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
+		switch (opt) {
+		default:
+			/* Ignore core options */
+			if (opt < OPT_ARCH_MAX)
+				break;
+		case '?':
+			usage();
+			return -1;
+			break;
+		case OPT_APPEND:
+			append = optarg;
+			break;
+		case OPT_REUSE_CMDLINE:
+			command_line = get_command_line();
+			break;
+		case OPT_RAMDISK:
+			ramdisk = optarg;
+			break;
+		case OPT_REAL_MODE:
+			entry_16bit = 1;
+			break;
+		case OPT_ENTRY_32BIT:
+			entry_32bit = 1;
+			break;
+		}
+	}
+	command_line = concat_cmdline(command_line, append);
+	command_line_len = 0;
+	if (command_line)
+		command_line_len = strlen(command_line) + 1;
+	ramdisk_buf = 0;
+	if (ramdisk)
+		ramdisk_buf = slurp_file(ramdisk, &ramdisk_length);
+
+	if (entry_16bit || entry_32bit)
+		result = do_bzImage_load(info, buf, len, command_line,
+					command_line_len, ramdisk_buf,
+					ramdisk_length, entry_16bit);
+	else
+		result = do_bzImage64_load(info, buf, len, command_line,
+					command_line_len, ramdisk_buf,
+					ramdisk_length);
+
+	free(command_line);
+	return result;
+}
diff --git a/kexec/arch/x86_64/kexec-x86_64.c b/kexec/arch/x86_64/kexec-x86_64.c
index 6c42c32..5c23e01 100644
--- a/kexec/arch/x86_64/kexec-x86_64.c
+++ b/kexec/arch/x86_64/kexec-x86_64.c
@@ -37,6 +37,7 @@ struct file_type file_type[] = {
 	{ "multiboot-x86", multiboot_x86_probe, multiboot_x86_load,
 	  multiboot_x86_usage },
 	{ "elf-x86", elf_x86_probe, elf_x86_load, elf_x86_usage },
+	{ "bzImage64", bzImage64_probe, bzImage64_load, bzImage64_usage },
 	{ "bzImage", bzImage_probe, bzImage_load, bzImage_usage },
 	{ "beoboot-x86", beoboot_probe, beoboot_load, beoboot_usage },
 	{ "nbi-x86", nbi_probe, nbi_load, nbi_usage },
diff --git a/kexec/arch/x86_64/kexec-x86_64.h b/kexec/arch/x86_64/kexec-x86_64.h
index a97cd71..4cdeffb 100644
--- a/kexec/arch/x86_64/kexec-x86_64.h
+++ b/kexec/arch/x86_64/kexec-x86_64.h
@@ -28,4 +28,9 @@ int elf_x86_64_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info);
 void elf_x86_64_usage(void);
 
+int bzImage64_probe(const char *buf, off_t len);
+int bzImage64_load(int argc, char **argv, const char *buf, off_t len,
+			struct kexec_info *info);
+void bzImage64_usage(void);
+
 #endif /* KEXEC_X86_64_H */
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
