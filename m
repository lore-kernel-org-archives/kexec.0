Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from bart.se.axis.com ([195.60.68.10])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KbFW3-0000Vd-Bk
	for kexec@lists.infradead.org; Thu, 04 Sep 2008 14:08:56 +0000
Received: from bart.se.axis.com (bart.se.axis.com [127.0.0.1])
	by bart.se.axis.com (Postfix) with ESMTP id D5CC6640BA
	for <kexec@lists.infradead.org>; Thu,  4 Sep 2008 16:08:50 +0200 (CEST)
Received: from axis.com (edgar.se.axis.com [10.93.151.1])
	by bart.se.axis.com (Postfix) with ESMTP id C825E64045
	for <kexec@lists.infradead.org>; Thu,  4 Sep 2008 16:08:50 +0200 (CEST)
Date: Thu, 4 Sep 2008 16:08:50 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@axis.com>
Subject: [PATCH] cris: Add CRISv32 support
Message-ID: <20080904140850.GC14660@edgar.se.axis.com>
MIME-Version: 1.0
Content-Disposition: inline
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: jespern@axis.com

Hello,

I hope this is the correct list to which to send these patches.
Comments are very welcome.

Thanks,
Edgar

From: Edgar E. Iglesias <edgar.iglesias@axis.com>

Add a CRISv32 port. Initially only the elf filetype is supported.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@axis.com>

diff --git a/config/config.sub b/config/config.sub
index ac6de98..4812c82 100755
--- a/config/config.sub
+++ b/config/config.sub
@@ -457,7 +457,7 @@ case $basic_machine in
 	crds | unos)
 		basic_machine=m68k-crds
 		;;
-	cris | cris-* | etrax*)
+	cris | cris-* | etrax* | crisv32 | crisv32-* | etraxfs*)
 		basic_machine=cris-axis
 		;;
 	crx)
diff --git a/configure.ac b/configure.ac
index c677334..4221630 100644
--- a/configure.ac
+++ b/configure.ac
@@ -41,6 +41,9 @@ case $target_cpu in
 	mips|mipsel )
 		ARCH="mips"
 		;;
+	crisv32 )
+		ARCH="cris"
+		;;
 	ia64|x86_64|alpha )
 		ARCH="$target_cpu"
 		;;
diff --git a/kexec/Makefile b/kexec/Makefile
index 99949c4..45787ac 100644
--- a/kexec/Makefile
+++ b/kexec/Makefile
@@ -48,6 +48,7 @@ include $(srcdir)/kexec/arch/arm/Makefile
 include $(srcdir)/kexec/arch/i386/Makefile
 include $(srcdir)/kexec/arch/ia64/Makefile
 include $(srcdir)/kexec/arch/mips/Makefile
+include $(srcdir)/kexec/arch/cris/Makefile
 include $(srcdir)/kexec/arch/ppc/Makefile
 include $(srcdir)/kexec/arch/ppc64/Makefile
 include $(srcdir)/kexec/arch/s390/Makefile
diff --git a/kexec/arch/cris/Makefile b/kexec/arch/cris/Makefile
new file mode 100644
index 0000000..6e60ed1
--- /dev/null
+++ b/kexec/arch/cris/Makefile
@@ -0,0 +1,13 @@
+cris_KEXEC_SRCS =  kexec/arch/cris/kexec-cris.c
+cris_KEXEC_SRCS += kexec/arch/cris/kexec-elf-cris.c
+cris_KEXEC_SRCS += kexec/arch/cris/cris-setup-simple.S
+cris_KEXEC_SRCS += kexec/arch/cris/kexec-elf-rel-cris.c
+
+cris_ADD_BUFFER =
+cris_ADD_SEGMENT =
+cris_VIRT_TO_PHYS =
+
+dist += kexec/arch/cris/Makefile $(cris_KEXEC_SRCS)			\
+	kexec/arch/cris/kexec-criss.h					\
+	kexec/arch/cris/include/arch/options.h
+
diff --git a/kexec/arch/cris/cris-setup-simple.S b/kexec/arch/cris/cris-setup-simple.S
new file mode 100644
index 0000000..764f188
--- /dev/null
+++ b/kexec/arch/cris/cris-setup-simple.S
@@ -0,0 +1,31 @@
+/*
+ * cris-setup-simple.S - code to execute before stepping into the new kernel.
+ * Copyright (C) 2008 AXIS Communications AB
+ * Written by Edgar E. Iglesias
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+ */
+
+	.data
+	.globl cris_trampoline
+cris_trampoline:
+	.balign 4
+	lapc	cris_regframe, $sp
+	moveq	0, $r0
+	move	$r0, $pid
+
+	movem	[$sp+], $r14
+	jump	$r0
+	nop
+
+	.globl cris_regframe
+cris_regframe:
+	.balign	4
+	.fill	16, 4, 0
+cris_trampoline_end:
+
+	.globl cris_trampoline_size
+cris_trampoline_size:
+	.long cris_trampoline_end - cris_trampoline
+
diff --git a/kexec/arch/cris/include/arch/options.h b/kexec/arch/cris/include/arch/options.h
new file mode 100644
index 0000000..bc5f706
--- /dev/null
+++ b/kexec/arch/cris/include/arch/options.h
@@ -0,0 +1,11 @@
+#ifndef KEXEC_ARCH_MIPS_OPTIONS_H
+#define KEXEC_ARCH_MIPS_OPTIONS_H
+
+#define OPT_ARCH_MAX   (OPT_MAX+0)
+
+#define KEXEC_ARCH_OPTIONS \
+	KEXEC_OPTIONS \
+
+#define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR ""
+
+#endif /* KEXEC_ARCH_MIPS_OPTIONS_H */
diff --git a/kexec/arch/cris/kexec-cris.c b/kexec/arch/cris/kexec-cris.c
new file mode 100644
index 0000000..540ec6f
--- /dev/null
+++ b/kexec/arch/cris/kexec-cris.c
@@ -0,0 +1,121 @@
+/*
+ * kexec-cris.c 
+ * Copyright (C) 2008 AXIS Communications AB
+ * Written by Edgar E. Iglesias
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+ */
+
+#include <stddef.h>
+#include <stdio.h>
+#include <errno.h>
+#include <stdint.h>
+#include <string.h>
+#include <getopt.h>
+#include "../../kexec.h"
+#include "../../kexec-syscall.h"
+#include "kexec-cris.h"
+#include <arch/options.h>
+
+#define MAX_MEMORY_RANGES  64
+#define MAX_LINE          160
+static struct memory_range memory_range[MAX_MEMORY_RANGES];
+
+/* Return a sorted list of memory ranges. */
+int get_memory_ranges(struct memory_range **range, int *ranges, unsigned long kexec_flags)
+{
+	int memory_ranges = 0;
+
+	memory_range[memory_ranges].start = 0x40000000;
+	memory_range[memory_ranges].end   = 0x41000000;
+	memory_range[memory_ranges].type = RANGE_RAM;
+	memory_ranges++;
+
+	memory_range[memory_ranges].start = 0xc0000000;
+	memory_range[memory_ranges].end   = 0xc1000000;
+	memory_range[memory_ranges].type = RANGE_RAM;
+	memory_ranges++;
+
+	*range = memory_range;
+	*ranges = memory_ranges;
+	return 0;
+}
+
+struct file_type file_type[] = {
+	{"elf-cris", elf_cris_probe, elf_cris_load, elf_cris_usage},
+};
+int file_types = sizeof(file_type) / sizeof(file_type[0]);
+
+void arch_usage(void)
+{
+}
+
+int arch_process_options(int argc, char **argv)
+{
+	static const struct option options[] = {
+		KEXEC_ARCH_OPTIONS
+		{ 0,                    0, NULL, 0 },
+	};
+	static const char short_options[] = KEXEC_ARCH_OPT_STR;
+	int opt;
+
+	opterr = 0; /* Don't complain about unrecognized options here */
+	while((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
+		switch(opt) {
+		default:
+			break;
+		}
+	}
+	/* Reset getopt for the next pass; called in other source modules */
+	opterr = 1;
+	optind = 1;
+	return 0;
+}
+
+const struct arch_map_entry arches[] = {
+	{ "cris", KEXEC_ARCH_CRIS },
+	{ "crisv32", KEXEC_ARCH_CRIS },
+	{ 0 },
+};
+
+int arch_compat_trampoline(struct kexec_info *info)
+{
+	return 0;
+}
+
+void arch_update_purgatory(struct kexec_info *info)
+{
+}
+
+int is_crashkernel_mem_reserved(void)
+{
+	return 1;
+}
+
+unsigned long virt_to_phys(unsigned long addr)
+{
+	return (addr) & 0x7fffffff;
+}
+
+/*
+ * add_segment() should convert base to a physical address on superh,
+ * while the default is just to work with base as is */
+void add_segment(struct kexec_info *info, const void *buf, size_t bufsz,
+                 unsigned long base, size_t memsz)
+{
+        add_segment_phys_virt(info, buf, bufsz, base, memsz, 1);
+}
+
+/*
+ * add_buffer() should convert base to a physical address on superh,
+ * while the default is just to work with base as is */
+unsigned long add_buffer(struct kexec_info *info, const void *buf,
+                         unsigned long bufsz, unsigned long memsz,
+                         unsigned long buf_align, unsigned long buf_min,
+                         unsigned long buf_max, int buf_end)
+{
+        return add_buffer_phys_virt(info, buf, bufsz, memsz, buf_align,
+                                    buf_min, buf_max, buf_end, 1);
+}
+
diff --git a/kexec/arch/cris/kexec-cris.h b/kexec/arch/cris/kexec-cris.h
new file mode 100644
index 0000000..6af49ef
--- /dev/null
+++ b/kexec/arch/cris/kexec-cris.h
@@ -0,0 +1,17 @@
+#ifndef KEXEC_CRIS_H
+#define KEXEC_CRIS_H
+
+extern unsigned char setup_simple_start[];
+extern uint32_t setup_simple_size;
+
+extern struct {
+	uint32_t spr8;
+	uint32_t spr9;
+} setup_simple_regs;
+
+int elf_cris_probe(const char *buf, off_t len);
+int elf_cris_load(int argc, char **argv, const char *buf, off_t len,
+	struct kexec_info *info);
+void elf_cris_usage(void);
+
+#endif /* KEXEC_CRIS_H */
diff --git a/kexec/arch/cris/kexec-elf-cris.c b/kexec/arch/cris/kexec-elf-cris.c
new file mode 100644
index 0000000..bb40398
--- /dev/null
+++ b/kexec/arch/cris/kexec-elf-cris.c
@@ -0,0 +1,136 @@
+/*
+ * kexec: Linux boots Linux
+ *
+ * Copyright (C) 2008  AXIS Communications AB
+ * Written by Edgar E. Iglesias
+ *
+ * Based on x86 implementation,
+ * Copyright (C) 2003-2005  Eric Biederman (ebiederm@xmission.com)
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
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <limits.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <getopt.h>
+#include <elf.h>
+#include "../../kexec.h"
+#include "../../kexec-syscall.h"
+#include "../../kexec-elf.h"
+#include "../../kexec-elf-boot.h"
+#include <arch/options.h>
+#include "kexec-cris.h"
+
+#define OPT_APPEND      (OPT_ARCH_MAX+0)
+
+int elf_cris_probe(const char *buf, off_t len)
+{
+	struct mem_ehdr ehdr;
+	int result;
+	result = build_elf_exec_info(buf, len, &ehdr, 0);
+	if (result < 0)
+		goto out;
+
+	/* Verify the architecuture specific bits */
+	if (ehdr.e_machine != EM_CRIS) {
+		result = -1;
+		goto out;
+	}
+
+	result = 0;
+ out:
+	free_elf_info(&ehdr);
+	return result;
+}
+
+void elf_cris_usage(void)
+{
+	printf("  --append=STRING       Set the kernel command line to STRING\n"
+		);
+}
+
+#define CRAMFS_MAGIC 0x28cd3d45
+#define JHEAD_MAGIC 0x1FF528A6
+#define JHEAD_SIZE 8
+#define RAM_INIT_MAGIC 0x56902387
+#define COMMAND_LINE_MAGIC 0x87109563
+#define NAND_BOOT_MAGIC 0x9a9db001
+
+int elf_cris_load(int argc, char **argv, const char *buf, off_t len,
+		struct kexec_info *info)
+{
+	struct mem_ehdr ehdr;
+	char *command_line;
+	unsigned int *trampoline_buf;
+	unsigned long trampoline_base;
+	int opt;
+	extern void cris_trampoline(void);
+	extern unsigned long cris_trampoline_size;
+	extern struct regframe_t {
+		unsigned int regs[16];
+	} cris_regframe;
+
+	static const struct option options[] = {
+		KEXEC_ARCH_OPTIONS
+		{ 0, 0, 0, 0 },
+	};
+
+	static const char short_options[] = KEXEC_OPT_STR "";
+
+	/*
+	 * Parse the command line arguments
+	 */
+	command_line = 0;
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
+		case OPT_APPEND:
+			command_line = optarg;
+			break;
+		}
+	}
+
+	/* Load the ELF executable */
+	elf_exec_build_load(info, &ehdr, buf, len, 0);
+
+	cris_regframe.regs[0] = virt_to_phys(ehdr.e_entry);
+	cris_regframe.regs[8] = RAM_INIT_MAGIC;
+	cris_regframe.regs[12] = NAND_BOOT_MAGIC;
+
+	trampoline_buf = xmalloc(cris_trampoline_size);
+	trampoline_base = add_buffer_virt(info,
+					  trampoline_buf,
+					  cris_trampoline_size,
+					  cris_trampoline_size,
+					  4, 0, elf_max_addr(&ehdr), 1);
+	memcpy(trampoline_buf,
+	       cris_trampoline, cris_trampoline_size);
+	info->entry = trampoline_base;
+	return 0;
+}
diff --git a/kexec/arch/cris/kexec-elf-rel-cris.c b/kexec/arch/cris/kexec-elf-rel-cris.c
new file mode 100644
index 0000000..c4427cc
--- /dev/null
+++ b/kexec/arch/cris/kexec-elf-rel-cris.c
@@ -0,0 +1,42 @@
+/*
+ * kexec-elf-rel-cris.c - kexec Elf relocation routines
+ * Copyright (C) 2008 AXIS Communications AB
+ * Written by Edgar E. Iglesias
+ *
+ * derived from ../ppc/kexec-elf-rel-ppc.c
+ * Copyright (C) 2004 Albert Herranz
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+*/
+
+#include <stdio.h>
+#include <elf.h>
+#include "../../kexec.h"
+#include "../../kexec-elf.h"
+
+int machine_verify_elf_rel(struct mem_ehdr *ehdr)
+{
+	if (ehdr->ei_data != ELFDATA2MSB) {
+		return 0;
+	}
+	if (ehdr->ei_class != ELFCLASS32) {
+		return 0;
+	}
+	if (ehdr->e_machine != EM_CRIS) {
+		return 0;
+	}
+	return 1;
+}
+
+void machine_apply_elf_rel(struct mem_ehdr *ehdr, unsigned long r_type,
+	void *location, unsigned long address, unsigned long value)
+{
+	switch(r_type) {
+
+	default:
+		die("Unknown rela relocation: %lu\n", r_type);
+		break;
+	}
+	return;
+}
diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
index 2b9345f..1ca1c23 100644
--- a/kexec/kexec-syscall.h
+++ b/kexec/kexec-syscall.h
@@ -87,6 +87,7 @@ static inline long kexec_reboot(void)
 #define KEXEC_ARCH_SH      (42 << 16)
 #define KEXEC_ARCH_MIPS_LE (10 << 16)
 #define KEXEC_ARCH_MIPS    ( 8 << 16)
+#define KEXEC_ARCH_CRIS    (76 << 16)
 
 #define KEXEC_MAX_SEGMENTS 16
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
