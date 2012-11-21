Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tb4mg-00068e-IF
 for kexec@lists.infradead.org; Wed, 21 Nov 2012 07:31:50 +0000
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v3 4/4] kexec, x86_64: Load bzImage64 above 4G
Date: Tue, 20 Nov 2012 23:31:38 -0800
Message-Id: <1353483098-14883-5-git-send-email-yinghai@kernel.org>
In-Reply-To: <1353483098-14883-1-git-send-email-yinghai@kernel.org>
References: <1353483098-14883-1-git-send-email-yinghai@kernel.org>
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

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 kexec/arch/x86_64/Makefile          |    1 +
 kexec/arch/x86_64/kexec-bzImage64.c |  327 +++++++++++++++++++++++++++++++++++
 kexec/arch/x86_64/kexec-x86_64.c    |    1 +
 kexec/arch/x86_64/kexec-x86_64.h    |    5 +
 4 files changed, 334 insertions(+), 0 deletions(-)
 create mode 100644 kexec/arch/x86_64/kexec-bzImage64.c

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
index 0000000..28f1ace
--- /dev/null
+++ b/kexec/arch/x86_64/kexec-bzImage64.c
@@ -0,0 +1,327 @@
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
+	if ((uintmax_t)len < (uintmax_t)(2 * 512)) {
+		if (probe_debug) {
+			fprintf(stderr, "File is too short to be a bzImage!\n");
+		}
+		return -1;
+	}
+	header = (const struct x86_linux_header *)buf;
+	if (memcmp(header->header_magic, "HdrS", 4) != 0) {
+		if (probe_debug) {
+			fprintf(stderr, "Not a bzImage\n");
+		}
+		return -1;
+	}
+	if (header->boot_sector_magic != 0xAA55) {
+		if (probe_debug) {
+			fprintf(stderr, "No x86 boot sector present\n");
+		}
+		/* No x86 boot sector present */
+		return -1;
+	}
+	if (header->protocol_version < 0x020C) {
+		if (probe_debug) {
+			fprintf(stderr, "Must be at least protocol version 2.12\n");
+		}
+		/* Must be at least protocol version 2.12 */
+		return -1;
+	}
+	if ((header->loadflags & 1) == 0) {
+		if (probe_debug) {
+			fprintf(stderr, "zImage not a bzImage\n");
+		}
+		/* Not a bzImage */
+		return -1;
+	}
+	if (!(header->xloadflags & 1)) {
+		if (probe_debug) {
+			fprintf(stderr, "Not a bzImage64\n");
+		}
+		/* Must be LOADED_ABOVE_4G */
+		return -1;
+	}
+	/* I've got a bzImage64 */
+	if (probe_debug) {
+		fprintf(stderr, "It's a bzImage64\n");
+	}
+	return 0;
+}
+
+void bzImage64_usage(void)
+{
+	printf(	"    --command-line=STRING Set the kernel command line to STRING.\n"
+		"    --append=STRING       Set the kernel command line to STRING.\n"
+		"    --reuse-cmdline       Use kernel command line from running system.\n"
+		"    --initrd=FILE         Use FILE as the kernel's initial ramdisk.\n"
+		"    --ramdisk=FILE        Use FILE as the kernel's initial ramdisk.\n"
+		);
+}
+
+/* round_up() is from Linux kernel include/linux/kernel.h */
+/*
+ * This looks more complex than it should be. But we need to
+ * get the type for the ~ right in round_down (it needs to be
+ * as wide as the result!), and we want to evaluate the macro
+ * arguments just once each.
+ */
+#define __round_mask(x, y) ((__typeof__(x))((y)-1))
+#define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
+#define round_down(x, y) ((x) & ~__round_mask(x, y))
+
+static int do_bzImage64_load(struct kexec_info *info,
+	const char *kernel, off_t kernel_len,
+	const char *command_line, off_t command_line_len,
+	const char *initrd, off_t initrd_len)
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
+
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
+		command_line_len = strlen(command_line) +1;
+	}
+
+	/* x86_64 purgatory could be anywhere */
+	elf_rel_build_load(info, &info->rhdr, purgatory, purgatory_size,
+				0x3000, -1, -1, 0);
+	dbgprintf("Loaded purgatory at addr 0x%lx\n", info->rhdr.rel_addr);
+	/* The argument/parameter segment */
+	setup_size = kern16_size + command_line_len + PURGATORY_CMDLINE_SIZE;
+	real_mode = xmalloc(setup_size);
+	memcpy(real_mode, kernel, kern16_size);
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
+	/* Tell the kernel what is going on */
+	setup_linux_bootloader_parameters(info, real_mode, setup_base,
+			kern16_size, command_line, command_line_len,
+			initrd, initrd_len);
+
+	/*
+	 * add kernel at last, to make kexec load big kernel faster.
+	 * we are finding buffer with run-time size, and only add buffer
+	 * with image size that is smaller than run-time size.
+	 * later kexec_load will take less time with small range.
+	 * otherwise kexec_load will allocate big range but only
+	 * copy small buffer and waste time to allocate need needed
+	 * range.
+	 */
+
+	/* The main kernel segment */
+	k_size = kernel_len - kern16_size;
+
+	/* need to use run-time size for buffer searching */
+	dbgprintf("kernel init_size 0x%x\n", real_mode->init_size);
+	size = round_up(real_mode->init_size, 4096);
+
+	/* need to sort segments before locate_hole */
+        if (sort_segments(info) < 0)
+                die("sort_segments failed\n");
+
+	/* avoid cross GB boundary */
+	align = real_mode->kernel_alignment;
+	addr = locate_hole(info, size, align, 0x100000, -1, -1);
+	if (addr == ULONG_MAX)
+		die("can not load bzImage64");
+	/* same GB ? */
+	while ((addr >> 30) != ((addr + size - 1) >> 30)) {
+		addr = locate_hole(info, size, align, 0x100000,
+				 round_down(addr + size - 1, (1UL<<30)), -1);
+		if (addr == ULONG_MAX)
+			die("can not load bzImage64");
+	}
+	dbgprintf("Found kernel buffer at %lx size %lx\n", addr, size);
+
+	/* put compressed image at start of buffer */
+	addr = add_buffer(info, kernel + kern16_size, k_size, k_size, align,
+				addr, addr + size, 1);
+	if (addr == ULONG_MAX)
+		die("can not load bzImage64");
+	dbgprintf("Loaded 64bit kernel at 0x%lx\n", addr);
+
+	elf_rel_get_symbol(&info->rhdr, "entry64_regs", &regs64, sizeof(regs64));
+	regs64.rbx = 0;           /* Bootstrap processor */
+	regs64.rsi = setup_base;  /* Pointer to the parameters */
+	regs64.rip = addr + 0x200; /* the entry point for startup_64 */
+	regs64.rsp = elf_rel_get_addr(&info->rhdr, "stack_end"); /* Stack, unused */
+	elf_rel_set_symbol(&info->rhdr, "entry64_regs", &regs64, sizeof(regs64));
+
+	cmdline_end = setup_base + kern16_size + command_line_len - 1;
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
+	const char *ramdisk, *append = NULL;
+	char *ramdisk_buf;
+	off_t ramdisk_length;
+	int command_line_len;
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
+		{ 0,			0, 0, 0 },
+	};
+	static const char short_options[] = KEXEC_ARCH_OPT_STR "d";
+
+	ramdisk = 0;
+	ramdisk_length = 0;
+	while((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
+		switch(opt) {
+		default:
+			/* Ignore core options */
+			if (opt < OPT_ARCH_MAX) {
+				break;
+			}
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
+		}
+	}
+	command_line = concat_cmdline(command_line, append);
+	command_line_len = 0;
+	if (command_line) {
+		command_line_len = strlen(command_line) +1;
+	}
+	ramdisk_buf = 0;
+	if (ramdisk) {
+		ramdisk_buf = slurp_file(ramdisk, &ramdisk_length);
+	}
+	result = do_bzImage64_load(info,
+		buf, len,
+		command_line, command_line_len,
+		ramdisk_buf, ramdisk_length);
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
index a97cd71..b820ae8 100644
--- a/kexec/arch/x86_64/kexec-x86_64.h
+++ b/kexec/arch/x86_64/kexec-x86_64.h
@@ -28,4 +28,9 @@ int elf_x86_64_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info);
 void elf_x86_64_usage(void);
 
+int bzImage64_probe(const char *buf, off_t len);
+int bzImage64_load(int argc, char **argv, const char *buf, off_t len,
+        struct kexec_info *info);
+void bzImage64_usage(void);
+
 #endif /* KEXEC_X86_64_H */
-- 
1.7.7


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
