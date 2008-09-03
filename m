Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ti-out-0910.google.com ([209.85.142.188])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KaqgS-0006cb-7S
	for kexec@lists.infradead.org; Wed, 03 Sep 2008 11:38:01 +0000
Received: by ti-out-0910.google.com with SMTP id a21so1794362tia.2
	for <kexec@lists.infradead.org>; Wed, 03 Sep 2008 04:37:58 -0700 (PDT)
From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 03 Sep 2008 20:38:11 +0900
Message-Id: <20080903113811.31135.32678.sendpatchset@rx1.opensource.se>
Subject: [PATCH] sh: Add vmlinux crash dump support
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
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

This patch adds SuperH crash dump support. The vmlinux loader is modified
with crash dump hooks as on other architectures. SuperH does not need any
backup region, so only the elf header is allocated from the top of the
reserved memory window. The actual size of the memory window is passed
to the secondary kernel on the command line using "mem=".

The secondary kernel must be configured to match the reserved memory
window, change kernel parameters CONFIG_MEMORY_START and CONFIG_MEMORY_SIZE.

Linux-2.6.27 should be usable as primary kernel on SuperH, later kernel
versions are needed to fully support secondary kernel /proc/vmcore.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 kexec/arch/sh/Makefile       |    1 
 kexec/arch/sh/crashdump-sh.c |  186 ++++++++++++++++++++++++++++++++++++++++++
 kexec/arch/sh/crashdump-sh.h |    9 ++
 kexec/arch/sh/kexec-elf-sh.c |   31 ++++++-
 kexec/arch/sh/kexec-sh.c     |   30 +++++-
 kexec/arch/sh/kexec-sh.h     |    2 
 6 files changed, 249 insertions(+), 10 deletions(-)

--- 0001/kexec/arch/sh/Makefile
+++ work/kexec/arch/sh/Makefile	2008-09-02 19:06:08.000000000 +0900
@@ -7,6 +7,7 @@ sh_KEXEC_SRCS += kexec/arch/sh/kexec-net
 sh_KEXEC_SRCS += kexec/arch/sh/kexec-elf-sh.c
 sh_KEXEC_SRCS += kexec/arch/sh/kexec-elf-rel-sh.c
 sh_KEXEC_SRCS += kexec/arch/sh/netbsd_booter.S
+sh_KEXEC_SRCS += kexec/arch/sh/crashdump-sh.c
 
 sh_ADD_BUFFER =
 sh_ADD_SEGMENT =
--- /dev/null
+++ work/kexec/arch/sh/crashdump-sh.c	2008-09-02 21:20:29.000000000 +0900
@@ -0,0 +1,186 @@
+/*
+ * crashdump-sh.c - crashdump for SuperH
+ * Copyright (C) 2008 Magnus Damm
+ *
+ * Based on x86 and ppc64 implementation, written by
+ * Vivek Goyal (vgoyal@in.ibm.com), R Sharada (sharada@in.ibm.com)
+ * Copyright (C) IBM Corporation, 2005. All rights reserved
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+ */
+
+#define _GNU_SOURCE
+#include <stddef.h>
+#include <stdio.h>
+#include <errno.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <getopt.h>
+#include <elf.h>
+#include "../../kexec.h"
+#include "../../kexec-elf.h"
+#include "../../kexec-elf-boot.h"
+#include "../../kexec-syscall.h"
+#include "../../crashdump.h"
+#include "kexec-sh.h"
+#include "crashdump-sh.h"
+#include <arch/options.h>
+
+#define CRASH_MAX_MEMORY_RANGES 64
+static struct memory_range crash_memory_range[CRASH_MAX_MEMORY_RANGES];
+
+uint64_t saved_max_mem;
+
+static int crash_sh_range_nr;
+static int crash_sh_memory_range_callback(void *data, int nr,
+					  char *str,
+					  unsigned long base,
+					  unsigned long length)
+{
+
+	struct memory_range *range = crash_memory_range;
+	struct memory_range *range2 = crash_memory_range;
+
+	range += crash_sh_range_nr;
+
+	if (crash_sh_range_nr >= CRASH_MAX_MEMORY_RANGES) {
+		return 1;
+	}
+
+	if (strncmp(str, "System RAM\n", 11) == 0) {
+		range->start = base;
+		range->end = base + length - 1;
+		range->type = RANGE_RAM;
+		crash_sh_range_nr++;
+
+		if (saved_max_mem < range->end)
+			saved_max_mem = range->end;
+	}
+
+	if (strncmp(str, "Crash kernel\n", 13) == 0) {
+		if (!crash_sh_range_nr)
+			die("Unsupported /proc/iomem format\n");
+
+		range2 = range - 1;
+		if ((base + length - 1) < range2->end) {
+			range->start = base + length;
+			range->end = range2->end;
+			range->type = RANGE_RAM;
+			crash_sh_range_nr++;
+		}
+		range2->end = base - 1;
+	}
+
+	return 0;
+}
+
+/* Return a sorted list of available memory ranges. */
+static int crash_get_memory_ranges(struct memory_range **range, int *ranges)
+{
+	crash_sh_range_nr = 0;
+	saved_max_mem = 0;
+	
+	kexec_iomem_for_each_line(NULL, crash_sh_memory_range_callback, NULL);
+	*range = crash_memory_range;
+	*ranges = crash_sh_range_nr;
+	return 0;
+}
+
+static struct crash_elf_info elf_info32 =
+{
+	class: ELFCLASS32,
+	data: ELFDATA2LSB,
+	machine: EM_SH,
+	page_offset: PAGE_OFFSET,
+};
+
+/* Converts unsigned long to ascii string. */
+static void ultoa(unsigned long i, char *str)
+{
+	int j = 0, k;
+	char tmp;
+
+	do {
+		str[j++] = i % 10 + '0';
+	} while ((i /=10) > 0);
+	str[j] = '\0';
+
+	/* Reverse the string. */
+	for (j = 0, k = strlen(str) - 1; j < k; j++, k--) {
+		tmp = str[k];
+		str[k] = str[j];
+		str[j] = tmp;
+	}
+}
+
+static int add_cmdline_param(char *cmdline, uint64_t addr, char *cmdstr,
+				char *byte)
+{
+	int cmdlen, len, align = 1024;
+	char str[COMMAND_LINE_SIZE], *ptr;
+
+	/* Passing in =xxxK / =xxxM format. Saves space required in cmdline.*/
+	switch (byte[0]) {
+		case 'K':
+			if (addr%align)
+				return -1;
+			addr = addr/align;
+			break;
+		case 'M':
+			addr = addr/(align *align);
+			break;
+	}
+	ptr = str;
+	strcpy(str, cmdstr);
+	ptr += strlen(str);
+	ultoa(addr, ptr);
+	strcat(str, byte);
+	len = strlen(str);
+	cmdlen = strlen(cmdline) + len;
+	if (cmdlen > (COMMAND_LINE_SIZE - 1))
+		die("Command line overflow\n");
+	strcat(cmdline, str);
+#if DEBUG
+	fprintf(stderr, "Command line after adding elfcorehdr: %s\n", cmdline);
+#endif
+	return 0;
+}
+
+/* Loads additional segments in case of a panic kernel is being loaded.
+ * One segment for storing elf headers for crash memory image.
+ */
+int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline)
+{
+	void *tmp;
+	unsigned long sz, elfcorehdr;
+	int nr_ranges;
+	struct memory_range *mem_range;
+
+	if (crash_get_memory_ranges(&mem_range, &nr_ranges) < 0)
+		return -1;
+
+	if (crash_create_elf32_headers(info, &elf_info32,
+				       mem_range, nr_ranges,
+				       &tmp, &sz,
+				       ELF_CORE_HEADER_ALIGN) < 0)
+		return -1;
+
+	elfcorehdr = add_buffer_phys_virt(info, tmp, sz, sz, 1024,
+					  0, 0xffffffff, -1, 0);
+
+	dbgprintf("Created elf header segment at 0x%lx\n", elfcorehdr);
+	add_cmdline_param(mod_cmdline, elfcorehdr, " elfcorehdr=", "K");
+	add_cmdline_param(mod_cmdline, elfcorehdr - mem_min, " mem=", "K");
+
+	return 0;
+}
+
+int is_crashkernel_mem_reserved(void)
+{
+	uint64_t start, end;
+
+	return parse_iomem_single("Crash kernel\n", &start, &end) == 0 ?
+	  (start != end) : 0;
+}
--- /dev/null
+++ work/kexec/arch/sh/crashdump-sh.h	2008-09-02 19:06:08.000000000 +0900
@@ -0,0 +1,9 @@
+#ifndef CRASHDUMP_SH_H
+#define CRASHDUMP_SH_H
+
+struct kexec_info;
+int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline);
+
+#define PAGE_OFFSET	0x80000000
+
+#endif /* CRASHDUMP_SH_H */
--- 0001/kexec/arch/sh/kexec-elf-sh.c
+++ work/kexec/arch/sh/kexec-elf-sh.c	2008-09-02 19:06:08.000000000 +0900
@@ -37,6 +37,7 @@
 #include "../../kexec-elf.h"
 #include "../../kexec-elf-boot.h"
 #include <arch/options.h>
+#include "crashdump-sh.h"
 #include "kexec-sh.h"
 
 int elf_sh_probe(const char *buf, off_t len)
@@ -70,8 +71,9 @@ int elf_sh_load(int argc, char **argv, c
 {
 	struct mem_ehdr ehdr;
 	char *command_line;
+	char *modified_cmdline;
 	struct mem_sym sym;
-	int opt;
+	int opt, rc;
 	static const struct option options[] = {
 		KEXEC_ARCH_OPTIONS
 		{ 0, 0, 0, 0 },
@@ -82,7 +84,7 @@ int elf_sh_load(int argc, char **argv, c
 	/*
 	 * Parse the command line arguments
 	 */
-	command_line = 0;
+	command_line = modified_cmdline = 0;
 	while((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
 		switch(opt) {
 		default:
@@ -99,9 +101,32 @@ int elf_sh_load(int argc, char **argv, c
 		}
 	}
 
+	/* Need to append some command line parameters internally in case of
+	 * taking crash dumps.
+	 */
+	if (info->kexec_flags & KEXEC_ON_CRASH) {
+		modified_cmdline = xmalloc(COMMAND_LINE_SIZE);
+		memset((void *)modified_cmdline, 0, COMMAND_LINE_SIZE);
+		if (command_line) {
+			strncpy(modified_cmdline, command_line,
+						COMMAND_LINE_SIZE);
+			modified_cmdline[COMMAND_LINE_SIZE - 1] = '\0';
+		}
+	}
+
 	/* Load the ELF executable */
 	elf_exec_build_load(info, &ehdr, buf, len, 0);
-	info->entry = (void *)ehdr.e_entry;
+	info->entry = (void *)virt_to_phys(ehdr.e_entry);
+
+	/* If panic kernel is being loaded, additional segments need
+	 * to be created. */
+	if (info->kexec_flags & KEXEC_ON_CRASH) {
+		rc = load_crashdump_segments(info, modified_cmdline);
+		if (rc < 0)
+			return -1;
+		/* Use new command line. */
+		command_line = modified_cmdline;
+	}
 
 	/* If we're booting a vmlinux then fill in empty_zero_page */
 	if (elf_rel_find_symbol(&ehdr, "empty_zero_page", &sym) == 0) {
--- 0002/kexec/arch/sh/kexec-sh.c
+++ work/kexec/arch/sh/kexec-sh.c	2008-09-02 19:17:37.000000000 +0900
@@ -41,12 +41,33 @@ static int kexec_sh_memory_range_callbac
 int get_memory_ranges(struct memory_range **range, int *ranges,
 		      unsigned long kexec_flags)
 {
-	int nr;
-
+	int nr, ret;
 	nr = kexec_iomem_for_each_line("System RAM\n",
 				       kexec_sh_memory_range_callback, NULL);
 	*range = memory_range;
 	*ranges = nr;
+
+	/*
+	 * Redefine the memory region boundaries if kernel
+	 * exports the limits and if it is panic kernel.
+	 * Override user values only if kernel exported values are
+	 * subset of user defined values.
+	 */
+	if (kexec_flags & KEXEC_ON_CRASH) {
+		unsigned long long start, end;
+
+		ret = parse_iomem_single("Crash kernel\n", &start, &end);
+		if (ret != 0) {
+			fprintf(stderr, "parse_iomem_single failed.\n");
+			return -1;
+		}
+
+		if (start > mem_min)
+			mem_min = start;
+		if (end < mem_max)
+			mem_max = end;
+	}
+
 	return 0;
 }
 
@@ -156,11 +177,6 @@ void kexec_sh_setup_zero_page(char *zero
 	}
 }
 
-int is_crashkernel_mem_reserved(void)
-{
-	return 0; /* kdump is not supported on this platform (yet) */
-}
-
 unsigned long virt_to_phys(unsigned long addr)
 {
 	unsigned long seg = addr & 0xe0000000;
--- 0001/kexec/arch/sh/kexec-sh.h
+++ work/kexec/arch/sh/kexec-sh.h	2008-09-02 19:06:08.000000000 +0900
@@ -1,6 +1,8 @@
 #ifndef KEXEC_SH_H
 #define KEXEC_SH_H
 
+#define COMMAND_LINE_SIZE 2048
+
 int zImage_sh_probe(const char *buf, off_t len);
 int zImage_sh_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
