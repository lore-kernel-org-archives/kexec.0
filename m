Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tim.rpsys.net ([194.106.48.114])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JM8nX-0004LF-80
	for kexec@lists.infradead.org; Mon, 04 Feb 2008 21:24:23 +0000
Subject: [PATCH] Add ARM support to kexec
From: Richard Purdie <rpurdie@rpsys.net>
Date: Mon, 04 Feb 2008 21:24:03 +0000
Message-Id: <1202160243.4788.103.camel@localhost.localdomain>
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
To: kexec@lists.infradead.org, ebiederm@xmission.com
Cc: Uli Luckas <u.luckas@road.de>

Add ARM support to kexec including commandline support through ATAGs.
The kernel syscall support has already been merged and kernel ATAG
exporting is queued for 2.6.25 (its optional for kexec).

Based on work by various people, notably Uli Luckas <u.luckas@road.de>
for adding ATAG support.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

diff --git a/configure.ac b/configure.ac
index 6f0dbd6..5b0ca64 100644
--- a/configure.ac
+++ b/configure.ac
@@ -29,6 +29,9 @@ case $target_cpu in
 	powerpc64 )
 		ARCH="ppc64"
 		;;
+	arm* )
+		ARCH="arm"
+		;;
 	s390x|s390 )
 		ARCH="s390"
 		;;
diff --git a/kexec/arch/arm/Makefile b/kexec/arch/arm/Makefile
new file mode 100644
index 0000000..a58f791
--- /dev/null
+++ b/kexec/arch/arm/Makefile
@@ -0,0 +1,6 @@
+#
+# kexec arm (linux booting linux)
+#
+KEXEC_SRCS+= kexec/arch/arm/kexec-elf-rel-arm.c
+KEXEC_SRCS+= kexec/arch/arm/kexec-zImage-arm.c 
+KEXEC_SRCS+= kexec/arch/arm/kexec-arm.c 
diff --git a/kexec/arch/arm/include/arch/options.h b/kexec/arch/arm/include/arch/options.h
new file mode 100644
index 0000000..248230b
--- /dev/null
+++ b/kexec/arch/arm/include/arch/options.h
@@ -0,0 +1,11 @@
+#ifndef KEXEC_ARCH_ARM_OPTIONS_H
+#define KEXEC_ARCH_ARM_OPTIONS_H
+
+#define OPT_ARCH_MAX   (OPT_MAX+0)
+
+#define KEXEC_ARCH_OPTIONS \
+	KEXEC_OPTIONS \
+
+#define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR ""
+
+#endif /* KEXEC_ARCH_ARM_OPTIONS_H */
diff --git a/kexec/arch/arm/kexec-arm.c b/kexec/arch/arm/kexec-arm.c
new file mode 100644
index 0000000..16072b7
--- /dev/null
+++ b/kexec/arch/arm/kexec-arm.c
@@ -0,0 +1,142 @@
+/*
+ * kexec: Linux boots Linux
+ *
+ * modified from kexec-ppc.c
+ *
+ */
+
+#define _GNU_SOURCE
+#include <stddef.h>
+#include <stdio.h>
+#include <errno.h>
+#include <stdint.h>
+#include <string.h>
+#include <getopt.h>
+#include <sys/utsname.h>
+#include "../../kexec.h"
+#include "../../kexec-syscall.h"
+#include "kexec-arm.h"
+#include <arch/options.h>
+
+#define MAX_MEMORY_RANGES 64
+#define MAX_LINE 160
+static struct memory_range memory_range[MAX_MEMORY_RANGES];
+
+/* Return a sorted list of available memory ranges. */
+int get_memory_ranges(struct memory_range **range, int *ranges, 
+		unsigned long kexec_flags)
+{
+	const char iomem[]= "/proc/iomem";
+	int memory_ranges = 0;
+	char line[MAX_LINE];
+	FILE *fp;
+	fp = fopen(iomem, "r");
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
+		if (memory_ranges >= MAX_MEMORY_RANGES)
+			break;
+		count = sscanf(line, "%Lx-%Lx : %n",
+			&start, &end, &consumed);
+		if (count != 2) 
+			continue;
+		str = line + consumed;
+		end = end + 1;
+
+		if (memcmp(str, "System RAM\n", 11) == 0) {
+			type = RANGE_RAM;
+		} 
+		else if (memcmp(str, "reserved\n", 9) == 0) {
+			type = RANGE_RESERVED;
+		}
+		else {
+			continue;
+		}
+
+		memory_range[memory_ranges].start = start;
+		memory_range[memory_ranges].end = end;
+		memory_range[memory_ranges].type = type;
+		memory_ranges++;
+	}
+	fclose(fp);
+	*range = memory_range;
+	*ranges = memory_ranges;
+	return 0;
+}
+
+/* Supported file types and callbacks */
+struct file_type file_type[] = {
+	{"zImage", zImage_arm_probe, zImage_arm_load, zImage_arm_usage},
+};
+int file_types = sizeof(file_type) / sizeof(file_type[0]);
+
+
+void arch_usage(void)
+{
+}
+
+static struct {
+} arch_options = {
+};
+int arch_process_options(int argc, char **argv)
+{
+	static const struct option options[] = {
+		KEXEC_ARCH_OPTIONS
+		{ 0, 			0, NULL, 0 },
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
+int arch_compat_trampoline(struct kexec_info *info)
+{
+	int result;
+	struct utsname utsname;
+	result = uname(&utsname);
+	if (result < 0) {
+		fprintf(stderr, "uname failed: %s\n",
+			strerror(errno));
+		return -1;
+	}
+	if (strncmp(utsname.machine, "arm",3) == 0)
+	{
+		info->kexec_flags |= KEXEC_ARCH_ARM;
+	}
+	else {
+		fprintf(stderr, "Unsupported machine type: %s\n",
+			utsname.machine);
+		return -1;
+	}
+	return 0;
+}
+
+void arch_update_purgatory(struct kexec_info *info)
+{
+}
+
+int is_crashkernel_mem_reserved(void)
+{
+	return 0; /* kdump is not supported on this platform (yet) */
+}
+	
\ No newline at end of file
diff --git a/kexec/arch/arm/kexec-arm.h b/kexec/arch/arm/kexec-arm.h
new file mode 100644
index 0000000..bb41ce0
--- /dev/null
+++ b/kexec/arch/arm/kexec-arm.h
@@ -0,0 +1,9 @@
+#ifndef KEXEC_ARM_H
+#define KEXEC_ARM_H
+
+int zImage_arm_probe(const char *buf, off_t len);
+int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
+		        struct kexec_info *info);
+void zImage_arm_usage(void);
+
+#endif /* KEXEC_ARM_H */
diff --git a/kexec/arch/arm/kexec-elf-rel-arm.c b/kexec/arch/arm/kexec-elf-rel-arm.c
new file mode 100644
index 0000000..4e3ffd7
--- /dev/null
+++ b/kexec/arch/arm/kexec-elf-rel-arm.c
@@ -0,0 +1,35 @@
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
+	if (ehdr->e_machine != EM_ARM) 
+	{
+		return 0;
+	}
+	return 1;
+}
+
+void machine_apply_elf_rel(struct mem_ehdr *ehdr, unsigned long r_type,
+	void *location, unsigned long address, unsigned long value)
+{
+	switch(r_type) {
+	case R_ARM_ABS32:
+		*((uint32_t *)location) += value;
+		break;
+	case R_ARM_REL32:
+		*((uint32_t *)location) += value - address;
+		break;
+	default:
+		die("Unknown rel relocation: %lu\n", r_type);
+		break;
+	}
+}
diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
new file mode 100644
index 0000000..440ad73
--- /dev/null
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -0,0 +1,279 @@
+/*
+ * - 08/21/2007 ATAG support added by Uli Luckas <u.luckas@road.de>
+ *
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <limits.h>
+#include <stdint.h>
+#include <getopt.h>
+#include <arch/options.h>
+#include <asm/page.h>
+#include "../../kexec.h"
+
+#define COMMAND_LINE_SIZE 1024
+#define BOOT_PARAMS_SIZE 1536
+
+struct tag_header {
+	uint32_t size;
+	uint32_t tag;
+};
+
+/* The list must start with an ATAG_CORE node */
+#define ATAG_CORE       0x54410001
+
+struct tag_core {
+	uint32_t flags;	    /* bit 0 = read-only */
+	uint32_t pagesize;
+	uint32_t rootdev;
+};
+
+/* it is allowed to have multiple ATAG_MEM nodes */
+#define ATAG_MEM	0x54410002
+
+struct tag_mem32 {
+	uint32_t   size;
+	uint32_t   start;  /* physical start address */
+};
+
+/* describes where the compressed ramdisk image lives (virtual address) */
+/*
+ * this one accidentally used virtual addresses - as such,
+ * it's deprecated.
+ */
+#define ATAG_INITRD     0x54410005
+
+/* describes where the compressed ramdisk image lives (physical address) */
+#define ATAG_INITRD2    0x54420005
+
+struct tag_initrd {
+        uint32_t start;    /* physical start address */
+        uint32_t size;     /* size of compressed ramdisk image in bytes */
+};
+
+/* command line: \0 terminated string */
+#define ATAG_CMDLINE    0x54410009
+
+struct tag_cmdline {
+	char    cmdline[1];     /* this is the minimum size */
+};
+
+/* The list ends with an ATAG_NONE node. */
+#define ATAG_NONE       0x00000000
+
+struct tag {
+	struct tag_header hdr;
+	union {
+		struct tag_core	 core;
+		struct tag_mem32	mem;
+		struct tag_initrd       initrd;
+		struct tag_cmdline      cmdline;
+	} u;
+};
+
+#define tag_next(t)     ((struct tag *)((uint32_t *)(t) + (t)->hdr.size))
+#define byte_size(t)    ((t)->hdr.size << 2)
+#define tag_size(type)  ((sizeof(struct tag_header) + sizeof(struct type) + 3) >> 2)
+
+int zImage_arm_probe(const char *buf, off_t len)
+{
+	/* 
+	 * Only zImage loading is supported. Do not check if
+	 * the buffer is valid kernel image
+	 */	
+	return 0;
+}
+
+void zImage_arm_usage(void)
+{
+	printf(	"     --command-line=STRING Set the kernel command line to STRING.\n"
+		"     --append=STRING       Set the kernel command line to STRING.\n"
+		"     --initrd=FILE         Use FILE as the kernel's initial ramdisk.\n"
+		"     --ramdisk=FILE        Use FILE as the kernel's initial ramdisk.\n"
+		);
+}
+
+static
+struct tag * atag_read_tags(void)
+{
+	static unsigned long buf[BOOT_PARAMS_SIZE];
+	const char fn[]= "/proc/atags";
+	FILE *fp;
+	fp = fopen(fn, "r");
+	if (!fp) {
+		fprintf(stderr, "Cannot open %s: %s\n", 
+			fn, strerror(errno));
+		return NULL;
+	}
+
+	fread(buf, sizeof(buf[1]), BOOT_PARAMS_SIZE, fp);
+	if (ferror(fp)) {
+		fprintf(stderr, "Cannot read %s: %s\n",
+			fn, strerror(errno));
+		fclose(fp);
+		return NULL;
+	}
+
+	fclose(fp);
+	return (struct tag *) buf;
+}
+
+
+static
+int atag_arm_load(struct kexec_info *info, unsigned long base,
+	const char *command_line, off_t command_line_len,
+	const char *initrd, off_t initrd_len)
+{
+	struct tag *saved_tags = atag_read_tags();
+	char *buf;
+	off_t len;
+	struct tag *params;
+	uint32_t *initrd_start;
+	
+	buf = xmalloc(getpagesize());
+	if (!buf) {
+		fprintf(stderr, "Compiling ATAGs: out of memory\n");
+		return -1;
+	}
+
+	memset(buf, 0xff, getpagesize());
+	params = (struct tag *)buf;
+
+	if (saved_tags) {
+		// Copy tags
+		saved_tags = (struct tag *) saved_tags;
+		while(byte_size(saved_tags)) {
+			switch (saved_tags->hdr.tag) {
+			case ATAG_INITRD:
+			case ATAG_INITRD2:
+			case ATAG_CMDLINE:
+			case ATAG_NONE:
+				// skip these tags
+				break;
+			default:
+				// copy all other tags
+				memcpy(params, saved_tags, byte_size(saved_tags));
+				params = tag_next(params);
+			}
+			saved_tags = tag_next(saved_tags);
+		}
+	} else {
+		params->hdr.size = 2;
+		params->hdr.tag = ATAG_CORE;
+		params = tag_next(params);
+	}
+
+	if (initrd) {
+		params->hdr.size = tag_size(tag_initrd);
+		params->hdr.tag = ATAG_INITRD2;
+		initrd_start = &params->u.initrd.start;
+		params->u.initrd.size = initrd_len;
+		params = tag_next(params);
+	}
+
+	if (command_line) {
+		params->hdr.size = (sizeof(struct tag_header) + command_line_len + 3) >> 2;
+		params->hdr.tag = ATAG_CMDLINE;
+		memcpy(params->u.cmdline.cmdline, command_line,
+			command_line_len);
+		params->u.cmdline.cmdline[command_line_len - 1] = '\0';
+		params = tag_next(params);
+	}
+
+	params->hdr.size = 0;
+	params->hdr.tag = ATAG_NONE;
+
+	len = ((char *)params - buf) + sizeof(struct tag_header);
+
+	add_segment(info, buf, len, base, len);
+
+	if (initrd) {
+		struct memory_range *range;
+		int ranges;
+		get_memory_ranges(&range, &ranges, info->kexec_flags);
+		*initrd_start = locate_hole(info, initrd_len, getpagesize(), range[0].start + 0x800000, ULONG_MAX, INT_MAX);
+		if (*initrd_start == ULONG_MAX)
+			return -1;
+		add_segment(info, initrd, initrd_len, *initrd_start, initrd_len);
+	}
+
+	return 0;
+}
+
+int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
+	struct kexec_info *info)
+{
+	unsigned long base;
+	unsigned int atag_offset = 0x1000; /* 4k offset from memory start */
+	unsigned int offset = 0x8000;      /* 32k offset from memory start */
+	const char *command_line;
+	off_t command_line_len;
+	const char *ramdisk;
+	char *ramdisk_buf;
+	off_t ramdisk_length;
+	int opt;
+#define OPT_APPEND	'a'
+#define OPT_RAMDISK	'r'
+	static const struct option options[] = {
+		KEXEC_ARCH_OPTIONS
+		{ "command-line",	1, 0, OPT_APPEND },
+		{ "append",		1, 0, OPT_APPEND },
+		{ "initrd",		1, 0, OPT_RAMDISK },
+		{ "ramdisk",		1, 0, OPT_RAMDISK },
+		{ 0, 			0, 0, 0 },
+	};
+	static const char short_options[] = KEXEC_ARCH_OPT_STR "a:r:";
+
+	/*
+	 * Parse the command line arguments
+	 */
+	command_line = 0;
+	command_line_len = 0;
+	ramdisk = 0;
+	ramdisk_buf = 0;
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
+		case OPT_APPEND:
+			command_line = optarg;
+			break;
+		case OPT_RAMDISK:
+			ramdisk = optarg;
+			break;
+		}
+	}
+	if (command_line) {
+		command_line_len = strlen(command_line) + 1;
+		if (command_line_len > COMMAND_LINE_SIZE)
+			command_line_len = COMMAND_LINE_SIZE;
+	}
+	if (ramdisk) {
+		ramdisk_buf = slurp_file(ramdisk, &ramdisk_length);
+	}
+
+	base = locate_hole(info,len+offset,0,0,ULONG_MAX,INT_MAX);
+	if (base == ULONG_MAX)
+		return -1;
+
+	if (atag_arm_load(info, base + atag_offset,
+			 command_line, command_line_len,
+			 ramdisk_buf, ramdisk_length)    == -1)
+		return -1;
+
+	add_segment(info, buf, len, base + offset, len);
+
+	info->entry = (void*)base + offset;
+
+	return 0;
+}
diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
index 0ca3984..8d93047 100644
--- a/kexec/kexec-syscall.h
+++ b/kexec/kexec-syscall.h
@@ -46,6 +46,9 @@
 #ifdef __s390__
 #define __NR_kexec_load		277
 #endif
+#ifdef __arm__
+#define __NR_kexec_load		__NR_SYSCALL_BASE + 347  
+#endif
 #ifndef __NR_kexec_load
 #error Unknown processor architecture.  Needs a kexec_load syscall number.
 #endif
@@ -77,6 +80,7 @@ static inline long kexec_reboot(void)
 #define KEXEC_ARCH_PPC64   (21 << 16)
 #define KEXEC_ARCH_IA_64   (50 << 16)
 #define KEXEC_ARCH_S390    (22 << 16)
+#define KEXEC_ARCH_ARM     (40 << 16)
 
 #define KEXEC_MAX_SEGMENTS 16
 
diff --git a/purgatory/arch/arm/Makefile b/purgatory/arch/arm/Makefile
new file mode 100644
index 0000000..566ff42
--- /dev/null
+++ b/purgatory/arch/arm/Makefile
@@ -0,0 +1,6 @@
+#
+# Purgatory arm
+#
+
+PURGATORY_SRCS += 
+


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
