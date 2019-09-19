Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iB18k-0004Hc-9L
 for kexec@lists.infradead.org; Thu, 19 Sep 2019 18:26:55 +0000
From: Sven Schnelle <svens@stackframe.org>
Subject: [PATCH] kexec: add support for PARISC architecture
Date: Thu, 19 Sep 2019 20:26:24 +0200
Message-Id: <20190919182624.8543-1-svens@stackframe.org>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Sven Schnelle <svens@stackframe.org>, Helge Deller <deller@gmx.de>, kexec@lists.infradead.org, linux-parisc@vger.kernel.org

This patch adds support for the parisc Architecture. kexec support
for parisc is included with linux-5.4.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 configure.ac                           |   3 +
 kexec/Makefile                         |   1 +
 kexec/arch/hppa/Makefile               |  13 ++
 kexec/arch/hppa/include/arch/options.h |  32 +++++
 kexec/arch/hppa/kexec-elf-hppa.c       | 159 +++++++++++++++++++++++++
 kexec/arch/hppa/kexec-elf-rel-hppa.c   |  37 ++++++
 kexec/arch/hppa/kexec-hppa.c           | 148 +++++++++++++++++++++++
 kexec/arch/hppa/kexec-hppa.h           |   9 ++
 kexec/kexec-syscall.h                  |   4 +
 9 files changed, 406 insertions(+)
 create mode 100644 kexec/arch/hppa/Makefile
 create mode 100644 kexec/arch/hppa/include/arch/options.h
 create mode 100644 kexec/arch/hppa/kexec-elf-hppa.c
 create mode 100644 kexec/arch/hppa/kexec-elf-rel-hppa.c
 create mode 100644 kexec/arch/hppa/kexec-hppa.c
 create mode 100644 kexec/arch/hppa/kexec-hppa.h

diff --git a/configure.ac b/configure.ac
index 8474f7d..f025823 100644
--- a/configure.ac
+++ b/configure.ac
@@ -55,6 +55,9 @@ case $target_cpu in
 	ia64|x86_64|alpha|m68k )
 		ARCH="$target_cpu"
 		;;
+	hppa*)
+		ARCH="hppa"
+		;;
 	* )
 		AC_MSG_ERROR([unsupported architecture $target_cpu])
 		;;
diff --git a/kexec/Makefile b/kexec/Makefile
index 4db84d8..8e3e9ea 100644
--- a/kexec/Makefile
+++ b/kexec/Makefile
@@ -92,6 +92,7 @@ include $(srcdir)/kexec/arch/ppc64/Makefile
 include $(srcdir)/kexec/arch/s390/Makefile
 include $(srcdir)/kexec/arch/sh/Makefile
 include $(srcdir)/kexec/arch/x86_64/Makefile
+include $(srcdir)/kexec/arch/hppa/Makefile
 
 KEXEC_SRCS += $($(ARCH)_KEXEC_SRCS)
 
diff --git a/kexec/arch/hppa/Makefile b/kexec/arch/hppa/Makefile
new file mode 100644
index 0000000..e98f6da
--- /dev/null
+++ b/kexec/arch/hppa/Makefile
@@ -0,0 +1,13 @@
+#
+# kexec hppa (linux booting linux)
+#
+hppa_KEXEC_SRCS =  kexec/arch/hppa/kexec-hppa.c
+hppa_KEXEC_SRCS += kexec/arch/hppa/kexec-elf-hppa.c
+hppa_KEXEC_SRCS += kexec/arch/hppa/kexec-elf-rel-hppa.c
+
+hppa_ADD_SEGMENT =
+hppa_VIRT_TO_PHYS =
+
+dist += kexec/arch/hppa/Makefile $(hppa_KEXEC_SRCS)			\
+	kexec/arch/hppa/kexec-hppa.h					\
+	kexec/arch/hppa/include/arch/options.h
diff --git a/kexec/arch/hppa/include/arch/options.h b/kexec/arch/hppa/include/arch/options.h
new file mode 100644
index 0000000..a936140
--- /dev/null
+++ b/kexec/arch/hppa/include/arch/options.h
@@ -0,0 +1,32 @@
+#ifndef KEXEC_ARCH_HPPA_OPTIONS_H
+#define KEXEC_ARCH_HPPA_OPTIONS_H
+
+#define OPT_ARCH_MAX   (OPT_MAX+0)
+
+#define KEXEC_ARCH_OPTIONS \
+	KEXEC_OPTIONS
+
+#define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR ""
+
+#define KEXEC_ALL_OPTIONS \
+	KEXEC_ARCH_OPTIONS \
+	{ "command-line",	1, 0, OPT_APPEND },		\
+	{ "reuse-cmdline",	0, 0, OPT_REUSE_CMDLINE },	\
+	{ "append",		1, 0, OPT_APPEND },		\
+	{ "initrd",		1, 0, OPT_RAMDISK },		\
+	{ "ramdisk",		1, 0, OPT_RAMDISK },
+
+
+#define KEXEC_ALL_OPT_STR KEXEC_ARCH_OPT_STR "a:r:s:"
+
+/* See the other architectures for details of these; HPPA has no
+ * loader-specific options yet.
+ */
+#define OPT_ARCH_MAX       (OPT_MAX+0)
+
+#define OPT_APPEND		(OPT_ARCH_MAX+0)
+#define OPT_REUSE_CMDLINE	(OPT_ARCH_MAX+1)
+#define OPT_RAMDISK		(OPT_ARCH_MAX+2)
+
+#define MAX_MEMORY_RANGES 16
+#endif /* KEXEC_ARCH_HPPA_OPTIONS_H */
diff --git a/kexec/arch/hppa/kexec-elf-hppa.c b/kexec/arch/hppa/kexec-elf-hppa.c
new file mode 100644
index 0000000..d3ef0e9
--- /dev/null
+++ b/kexec/arch/hppa/kexec-elf-hppa.c
@@ -0,0 +1,159 @@
+/*
+ * kexec-elf-hppa.c - kexec Elf loader for hppa
+ *
+ * Copyright (c) 2019 Sven Schnelle <svens@stackframe.org>
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+*/
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <string.h>
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
+#include "../../kexec.h"
+#include "../../kexec-elf.h"
+#include "../../kexec-syscall.h"
+#include "kexec-hppa.h"
+#include <arch/options.h>
+
+#define PAGE_SIZE	4096
+
+extern unsigned long phys_offset;
+
+int elf_hppa_probe(const char *buf, off_t len)
+{
+	struct mem_ehdr ehdr;
+	int result;
+	result = build_elf_exec_info(buf, len, &ehdr, 0);
+	if (result < 0)
+		goto out;
+
+	phys_offset = ehdr.e_entry & 0xf0000000;
+	/* Verify the architecuture specific bits */
+	if (ehdr.e_machine != EM_PARISC) {
+		/* for a different architecture */
+		fprintf(stderr, "Not for this architecture.\n");
+		result = -1;
+		goto out;
+	}
+	result = 0;
+ out:
+	free_elf_info(&ehdr);
+	return result;
+}
+
+void elf_hppa_usage(void)
+{
+	printf("    --command-line=STRING Set the kernel command line to STRING\n"
+	       "    --append=STRING       Set the kernel command line to STRING\n"
+	       "    --reuse-cmdline       Use kernel command line from running system.\n"
+	       "    --ramdisk=FILE        Use FILE as the kernel's initial ramdisk.\n"
+	       "    --initrd=FILE         Use FILE as the kernel's initial ramdisk.\n"
+	       );
+}
+
+int elf_hppa_load(int argc, char **argv, const char *buf, off_t len,
+	struct kexec_info *info)
+{
+	struct mem_ehdr ehdr;
+	char *cmdline = NULL, *ramdisk = NULL;
+	int opt, result, i;
+	unsigned long ramdisk_addr = 0;
+	off_t ramdisk_size = 0;
+
+	static const struct option options[] = {
+		KEXEC_ALL_OPTIONS
+		{ 0,                    0, NULL, 0 },
+	};
+
+	static const char short_options[] = KEXEC_ALL_OPT_STR "d";
+
+	while ((opt = getopt_long(argc, argv, short_options, options, 0)) !=
+		-1) {
+		switch (opt) {
+		default:
+			/* Ignore core options */
+			if (opt < OPT_ARCH_MAX)
+				break;
+		case OPT_APPEND:
+			cmdline = strdup(optarg);
+			break;
+		case OPT_REUSE_CMDLINE:
+			cmdline = get_command_line();
+			break;
+		case OPT_RAMDISK:
+			ramdisk = optarg;
+			break;
+		}
+	}
+
+	if (info->file_mode) {
+		if (cmdline) {
+			info->command_line = cmdline;
+			info->command_line_len = strlen(cmdline) + 1;
+		}
+
+		if (ramdisk) {
+			info->initrd_fd = open(ramdisk, O_RDONLY);
+			if (info->initrd_fd == -1) {
+				fprintf(stderr, "Could not open initrd file "
+					"%s:%s\n", ramdisk, strerror(errno));
+				return -1;
+			}
+		}
+		return 0;
+	}
+
+	result = build_elf_exec_info(buf, len, &ehdr, 0);
+	if (result < 0)
+		die("ELF exec parse failed\n");
+
+	/* Fixup PT_LOAD segments that include the ELF header (offset zero) */
+	for (i = 0; i < ehdr.e_phnum; i++) {
+		struct mem_phdr *phdr;
+		phdr = &ehdr.e_phdr[i];
+		if (phdr->p_type != PT_LOAD || phdr->p_offset)
+			continue;
+
+		dbgprintf("Removing ELF header from segment %d\n", i);
+		phdr->p_paddr += PAGE_SIZE;
+		phdr->p_vaddr += PAGE_SIZE;
+		phdr->p_filesz -= PAGE_SIZE;
+		phdr->p_memsz -= PAGE_SIZE;
+		phdr->p_offset += PAGE_SIZE;
+		phdr->p_data += PAGE_SIZE;
+	}
+
+	/* Load the ELF data */
+	result = elf_exec_load(&ehdr, info);
+	if (result < 0)
+		die("ELF exec load failed\n");
+
+	info->entry = (void *)virt_to_phys(ehdr.e_entry);
+
+
+	/* Load ramdisk */
+	if (ramdisk) {
+		void *initrd = slurp_decompress_file(ramdisk, &ramdisk_size);
+		/* Store ramdisk at top of first memory chunk */
+		ramdisk_addr = _ALIGN_DOWN(info->memory_range[0].end -
+					   ramdisk_size + 1, PAGE_SIZE);
+		if (!buf)
+			die("Ramdisk load failed\n");
+		add_buffer(info, initrd, ramdisk_size, ramdisk_size,
+			   PAGE_SIZE, ramdisk_addr, info->memory_range[0].end,
+			   1);
+	}
+
+	return 0;
+}
diff --git a/kexec/arch/hppa/kexec-elf-rel-hppa.c b/kexec/arch/hppa/kexec-elf-rel-hppa.c
new file mode 100644
index 0000000..661b67b
--- /dev/null
+++ b/kexec/arch/hppa/kexec-elf-rel-hppa.c
@@ -0,0 +1,37 @@
+/*
+ * kexec-elf-rel-hppa.c - kexec Elf relocation routines
+ *
+ * Copyright (C) 2019 Sven Schnelle <svens@stackframe.org>
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
+	if (ehdr->ei_data != ELFDATA2MSB)
+		return 0;
+	if (ehdr->e_machine != EM_PARISC)
+		return 0;
+	return 1;
+}
+
+void machine_apply_elf_rel(struct mem_ehdr *UNUSED(ehdr),
+			   struct mem_sym *UNUSED(sym),
+			   unsigned long r_type,
+			   void *UNUSED(location),
+			   unsigned long UNUSED(address),
+			   unsigned long UNUSED(value))
+{
+	switch (r_type) {
+	default:
+		die("Unknown rela relocation: %lu\n", r_type);
+		break;
+	}
+	return;
+}
diff --git a/kexec/arch/hppa/kexec-hppa.c b/kexec/arch/hppa/kexec-hppa.c
new file mode 100644
index 0000000..77c9739
--- /dev/null
+++ b/kexec/arch/hppa/kexec-hppa.c
@@ -0,0 +1,148 @@
+/*
+ * kexec-hppa.c - kexec for hppa
+ *
+ * Copyright (C) 2019 Sven Schnelle <svens@stackframe.org>
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
+#include "kexec-hppa.h"
+#include <arch/options.h>
+
+#define SYSTEM_RAM "System RAM\n"
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
+static struct memory_range memory_range[MAX_MEMORY_RANGES];
+unsigned long phys_offset;
+
+/* Return a sorted list of available memory ranges. */
+int get_memory_ranges(struct memory_range **range, int *ranges,
+		unsigned long UNUSED(kexec_flags))
+{
+	const char *iomem = proc_iomem();
+	int memory_ranges = 0;
+	char line[512];
+	FILE *fp;
+
+	fp = fopen(iomem, "r");
+
+	if (!fp) {
+		fprintf(stderr, "Cannot open %s: %s\n",
+			iomem, strerror(errno));
+		return -1;
+	}
+
+	while(fgets(line, sizeof(line), fp) != 0) {
+		unsigned long long start, end;
+		char *str;
+		int type;
+		int consumed;
+		int count;
+
+
+		count = sscanf(line, "%llx-%llx : %n", &start, &end, &consumed);
+
+		if (count != 2)
+			continue;
+
+		str = line + consumed;
+
+		if (memcmp(str, SYSTEM_RAM, strlen(SYSTEM_RAM)) == 0) {
+			type = RANGE_RAM;
+		} else if (memcmp(str, "reserved\n", 9) == 0) {
+			type = RANGE_RESERVED;
+		} else {
+			continue;
+		}
+
+		memory_range[memory_ranges].start = start;
+		memory_range[memory_ranges].end = end;
+		memory_range[memory_ranges].type = type;
+		if (++memory_ranges >= MAX_MEMORY_RANGES)
+			break;
+	}
+	fclose(fp);
+	*range = memory_range;
+	*ranges = memory_ranges;
+
+	dbgprint_mem_range("MEMORY RANGES", *range, *ranges);
+	return 0;
+}
+
+struct file_type file_type[] = {
+	{"elf-hppa", elf_hppa_probe, elf_hppa_load, elf_hppa_usage},
+};
+int file_types = ARRAY_SIZE(file_type);
+
+void arch_usage(void)
+{
+}
+
+int arch_process_options(int argc, char **argv)
+{
+	static const struct option options[] = {
+		KEXEC_ALL_OPTIONS
+		{ 0,			0, NULL, 0 },
+	};
+	static const char short_options[] = KEXEC_ALL_OPT_STR;
+	int opt;
+
+	opterr = 0; /* Don't complain about unrecognized options here */
+	while ((opt = getopt_long(argc, argv, short_options, options, 0)) !=
+		-1) {
+		switch (opt) {
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
+	{ "parisc64", KEXEC_ARCH_HPPA },
+	{ "parisc", KEXEC_ARCH_HPPA },
+	{ NULL, 0 },
+};
+
+int arch_compat_trampoline(struct kexec_info *UNUSED(info))
+{
+	return 0;
+}
+
+void arch_update_purgatory(struct kexec_info *UNUSED(info))
+{
+}
+
+int is_crashkernel_mem_reserved(void)
+{
+	return 0;
+}
+
+int get_crash_kernel_load_range(uint64_t *start, uint64_t *end)
+{
+	/* Crash kernel region size is not exposed by the system */
+	return -1;
+}
+
+void add_segment(struct kexec_info *info, const void *buf, size_t bufsz,
+	unsigned long base, size_t memsz)
+{
+	add_segment_phys_virt(info, buf, bufsz, base, memsz, 1);
+}
+
+unsigned long virt_to_phys(unsigned long addr)
+{
+	return addr - phys_offset;
+}
diff --git a/kexec/arch/hppa/kexec-hppa.h b/kexec/arch/hppa/kexec-hppa.h
new file mode 100644
index 0000000..485e5b6
--- /dev/null
+++ b/kexec/arch/hppa/kexec-hppa.h
@@ -0,0 +1,9 @@
+#ifndef KEXEC_HPPA_H
+#define KEXEC_HPPA_H
+
+int elf_hppa_probe(const char *buf, off_t len);
+int elf_hppa_load(int argc, char **argv, const char *buf, off_t len,
+		  struct kexec_info *info);
+void elf_hppa_usage(void);
+
+#endif /* KEXEC_HPPA_H */
diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
index 92d51d3..bea29d4 100644
--- a/kexec/kexec-syscall.h
+++ b/kexec/kexec-syscall.h
@@ -74,6 +74,9 @@
 #ifdef __aarch64__
 #define __NR_kexec_file_load	294
 #endif
+#ifdef __hppa__
+#define __NR_kexec_file_load	355
+#endif
 
 #ifndef __NR_kexec_file_load
 /* system call not available for the arch */
@@ -119,6 +122,7 @@ static inline long kexec_file_load(int kernel_fd, int initrd_fd,
 #define KEXEC_ARCH_DEFAULT ( 0 << 16)
 #define KEXEC_ARCH_386     ( 3 << 16)
 #define KEXEC_ARCH_68K     ( 4 << 16)
+#define KEXEC_ARCH_HPPA    (15 << 16)
 #define KEXEC_ARCH_X86_64  (62 << 16)
 #define KEXEC_ARCH_PPC     (20 << 16)
 #define KEXEC_ARCH_PPC64   (21 << 16)
-- 
2.23.0.rc1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
