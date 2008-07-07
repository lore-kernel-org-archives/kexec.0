Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns1.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KFrvl-0000UG-N0
	for kexec@lists.infradead.org; Mon, 07 Jul 2008 14:43:06 +0000
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH 1/3] Parse /sys/firmware/memmap.
Date: Mon,  7 Jul 2008 16:43:40 +0200
Message-Id: <1215441822-13820-2-git-send-email-bwalle@suse.de>
In-Reply-To: <20080707070621.GD788@verge.net.au>
References: <20080707070621.GD788@verge.net.au>
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
Cc: Bernhard Walle <bwalle@suse.de>, Bernhard Walle <bernhard.walle@gmx.de>

From: Bernhard Walle <bernhard.walle@gmx.de>

After the patch that provides /sys/firmware/memmap has been merged in the 'tip'
tree by Ingo Molnar, kexec should use that interface.

This patch implements architecture-independent parsing in a new file called
firmware_memmap.c. The x86 part is ported to use that memory map for
kexec. We don't use that memory map for building the ELF core headers,
that was the intention for that new interface.


Signed-off-by: Bernhard Walle <bwalle@suse.de>
---
 kexec/Makefile              |    1 +
 kexec/arch/i386/kexec-x86.c |  124 ++++++++++++++++++++-
 kexec/firmware_memmap.c     |  266 +++++++++++++++++++++++++++++++++++++++++++
 kexec/firmware_memmap.h     |   63 ++++++++++
 4 files changed, 451 insertions(+), 3 deletions(-)
 create mode 100644 kexec/firmware_memmap.c
 create mode 100644 kexec/firmware_memmap.h

diff --git a/kexec/Makefile b/kexec/Makefile
index a80b940..3a00114 100644
--- a/kexec/Makefile
+++ b/kexec/Makefile
@@ -18,6 +18,7 @@ KEXEC_SRCS += kexec/kexec-elf-core.c
 KEXEC_SRCS += kexec/kexec-elf-rel.c
 KEXEC_SRCS += kexec/kexec-elf-boot.c
 KEXEC_SRCS += kexec/kexec-iomem.c
+KEXEC_SRCS += kexec/firmware_memmap.c
 KEXEC_SRCS += kexec/crashdump.c
 KEXEC_SRCS += kexec/crashdump-xen.c
 KEXEC_SRCS += kexec/phys_arch.c
diff --git a/kexec/arch/i386/kexec-x86.c b/kexec/arch/i386/kexec-x86.c
index 8c8ba7f..554c154 100644
--- a/kexec/arch/i386/kexec-x86.c
+++ b/kexec/arch/i386/kexec-x86.c
@@ -28,15 +28,26 @@
 #include "../../kexec.h"
 #include "../../kexec-elf.h"
 #include "../../kexec-syscall.h"
+#include "../../firmware_memmap.h"
 #include "kexec-x86.h"
 #include "crashdump-x86.h"
 #include <arch/options.h>
 
 static struct memory_range memory_range[MAX_MEMORY_RANGES];
 
-/* Return a sorted list of memory ranges. */
-int get_memory_ranges(struct memory_range **range, int *ranges,
-				unsigned long kexec_flags)
+/**
+ * The old /proc/iomem parsing code.
+ *
+ * @param[out] range pointer that will be set to an array that holds the
+ *             memory ranges
+ * @param[out] ranges number of ranges valid in @p range
+ * @param[in]  kexec_flags the kexec_flags to determine if we load a normal
+ *             or a crashdump kernel
+ *
+ * @return 0 on success, any other value on failure.
+ */
+static int get_memory_ranges_proc_iomem(struct memory_range **range, int *ranges,
+					unsigned long kexec_flags)
 {
 	const char *iomem= proc_iomem();
 	int memory_ranges = 0;
@@ -114,6 +125,113 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 	return 0;
 }
 
+/**
+ * Calls the architecture independent get_firmware_memmap_ranges() to parse
+ * /sys/firmware/memmap and then do some x86 only modifications.
+ *
+ * @param[out] range pointer that will be set to an array that holds the
+ *             memory ranges
+ * @param[out] ranges number of ranges valid in @p range
+ * @param[in]  kexec_flags the kexec_flags to determine if we load a normal
+ *             or a crashdump kernel
+ *
+ * @return 0 on success, any other value on failure.
+ */
+static int get_memory_ranges_sysfs(struct memory_range **range, int *ranges,
+				   unsigned long kexec_flags)
+{
+	int ret;
+	size_t i;
+	size_t range_number = MAX_MEMORY_RANGES;
+	unsigned long long start, end;
+
+	ret = get_firmware_memmap_ranges(memory_range, &range_number);
+	if (ret != 0) {
+		fprintf(stderr, "Parsing the /sys/firmware memory map failed. "
+			"Falling back to /proc/iomem.\n");
+		return get_memory_ranges_proc_iomem(range, ranges, kexec_flags);
+	}
+
+	/* Don't report the interrupt table as ram */
+	for (i = 0; i < range_number; i++) {
+		if (memory_range[i].type == RANGE_RAM &&
+				(memory_range[i].start < 0x100)) {
+			memory_range[i].start = 0x100;
+			break;
+		}
+	}
+
+	/*
+	 * Redefine the memory region boundaries if kernel
+	 * exports the limits and if it is panic kernel.
+	 * Override user values only if kernel exported values are
+	 * subset of user defined values.
+	 */
+	if (kexec_flags & KEXEC_ON_CRASH) {
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
+	*range = memory_range;
+	*ranges = range_number;
+
+	return 0;
+}
+
+/**
+ * Return a sorted list of memory ranges.
+ *
+ * If we have the /sys/firmware/memmap interface, then use that. If not,
+ * or if parsing of that fails, use /proc/iomem as fallback.
+ *
+ * @param[out] range pointer that will be set to an array that holds the
+ *             memory ranges
+ * @param[out] ranges number of ranges valid in @p range
+ * @param[in]  kexec_flags the kexec_flags to determine if we load a normal
+ *             or a crashdump kernel
+ *
+ * @return 0 on success, any other value on failure.
+ */
+int get_memory_ranges(struct memory_range **range, int *ranges,
+		      unsigned long kexec_flags)
+{
+	int ret;
+
+	if (have_sys_firmware_memmap())
+		ret = get_memory_ranges_sysfs(range, ranges,kexec_flags);
+	else
+		ret = get_memory_ranges_proc_iomem(range, ranges, kexec_flags);
+
+	/*
+	 * both get_memory_ranges_sysfs() and get_memory_ranges_proc_iomem()
+	 * have already printed an error message, so fail silently here
+	 */
+	if (ret != 0)
+		return ret;
+
+	/* just set 0 to 1 to enable printing for debugging */
+#if 0
+	{
+		int i;
+		printf("MEMORY RANGES\n");
+		for (i = 0; i < *ranges; i++) {
+			printf("%016Lx-%016Lx (%d)\n", (*range)[i].start,
+				(*range)[i].end, (*range)[i].type);
+		}
+	}
+#endif
+
+	return ret;
+}
+
 struct file_type file_type[] = {
 	{ "multiboot-x86", multiboot_x86_probe, multiboot_x86_load,
 	  multiboot_x86_usage },
diff --git a/kexec/firmware_memmap.c b/kexec/firmware_memmap.c
new file mode 100644
index 0000000..cdac6f3
--- /dev/null
+++ b/kexec/firmware_memmap.c
@@ -0,0 +1,266 @@
+/*
+ * firmware_memmap.c: Read /sys/firmware/memmap
+ *
+ * Created by: Bernhard Walle (bwalle@suse.de)
+ * Copyright (C) SUSE LINUX Products GmbH, 2008. All rights reserved
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
+#define _GNU_SOURCE /* for ULLONG_MAX without C99 */
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <dirent.h>
+#include <unistd.h>
+#include <limits.h>
+#include <errno.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+
+#include "firmware_memmap.h"
+#include "kexec.h"
+
+/**
+ * The full path to the sysfs interface that provides the memory map.
+ */
+#define FIRMWARE_MEMMAP_DIR  "/sys/firmware/memmap"
+
+/**
+ * Parses a file that only contains one number. Typical for sysfs files.
+ *
+ * @param[in] filename the name of the file that should be parsed
+ * @return the value that has been read or ULLONG_MAX on error.
+ */
+static unsigned long long parse_numeric_sysfs(const char *filename)
+{
+	FILE *fp;
+	char linebuffer[BUFSIZ];
+	unsigned long long retval;
+
+	fp = fopen(filename, "r");
+	if (!fp) {
+		fprintf(stderr, "Opening \"%s\" failed: %s\n",
+			filename, strerror(errno));
+		return ULLONG_MAX;
+	}
+
+	fgets(linebuffer, BUFSIZ, fp);
+	linebuffer[BUFSIZ-1] = 0;
+
+	/* let strtoll() detect the base */
+	retval = strtoll(linebuffer, NULL, 0);
+
+	fclose(fp);
+
+	return retval;
+}
+
+/**
+ * Reads the contents of a one-line sysfs file to buffer. (This function is
+ * not threadsafe.)
+ *
+ * @param[in] filename the name of the file that should be read
+ *
+ * @return NULL on failure, a pointer to a static buffer (that should be copied
+ *         with strdup() if the caller plans to use it after next function call)
+ */
+static char *parse_string_sysfs(const char *filename)
+{
+	FILE *fp;
+	static char linebuffer[BUFSIZ];
+	char *end;
+
+	fp = fopen(filename, "r");
+	if (!fp) {
+		fprintf(stderr, "Opening \"%s\" failed: %s\n",
+			filename, strerror(errno));
+		return NULL;
+	}
+
+	fgets(linebuffer, BUFSIZ, fp);
+	linebuffer[BUFSIZ-1] = 0;
+
+	/* truncate trailing newline(s) */
+	end = linebuffer + strlen(linebuffer) - 1;
+	while (*end == '\n')
+		*end-- = 0;
+
+	fclose(fp);
+
+	return linebuffer;
+
+}
+
+static int parse_memmap_entry(const char *entry, struct memory_range *range)
+{
+	char filename[PATH_MAX];
+	char *type;
+
+	/*
+	 * entry/start
+	 */
+	snprintf(filename, PATH_MAX, "%s/%s", entry, "start");
+	filename[PATH_MAX-1] = 0;
+
+	range->start = parse_numeric_sysfs(filename);
+	if (range->start == ULLONG_MAX)
+		return -1;
+
+	/*
+	 * entry/end
+	 */
+	snprintf(filename, PATH_MAX, "%s/%s", entry, "end");
+	filename[PATH_MAX-1] = 0;
+
+	range->end = parse_numeric_sysfs(filename);
+	if (range->end == ULLONG_MAX)
+		return -1;
+	range->end++; /* inclusive vs. exclusive ranges */
+
+	/*
+	 * entry/type
+	 */
+	snprintf(filename, PATH_MAX, "%s/%s", entry, "type");
+	filename[PATH_MAX-1] = 0;
+
+	type = parse_string_sysfs(filename);
+	if (!type)
+		return -1;
+
+	if (strcmp(type, "System RAM") == 0)
+		range->type = RANGE_RAM;
+	else if (strcmp(type, "ACPI Tables") == 0)
+		range->type = RANGE_ACPI;
+	else if (strcmp(type, "reserved") == 0)
+		range->type = RANGE_RESERVED;
+	else if (strcmp(type, "ACPI Non-volatile Storage") == 0)
+		range->type = RANGE_ACPI_NVS;
+	else {
+		fprintf(stderr, "Unknown type (%s) while parsing %s. Please "
+			"report this as bug. Using RANGE_RESERVED now.\n",
+			type, filename);
+		range->type = RANGE_RESERVED;
+	}
+
+	return 0;
+}
+
+/**
+ * Compares two memory ranges according to their start address. This function
+ * can be used with qsort() as @c compar function.
+ *
+ * @param[in] first a pointer to the first memory range
+ * @param[in] second a pointer to the second memory range
+ * @return 0 if @p first and @p second have the same start address,
+ *         a value less then 0 if the start address of @p first is less than
+ *         the start address of @p second, and a value greater than 0 if
+ *         the opposite is in case.
+ */
+static int compare_ranges(const void *first, const void *second)
+{
+	const struct memory_range *first_range = first;
+	const struct memory_range *second_range = second;
+
+	/*
+	 * don't use the "first_range->start - second_range->start"
+	 * notation because unsigned long long might overflow
+	 */
+	if (first_range->start > second_range->start)
+		return 1;
+	else if (first_range->start < second_range->start)
+		return -1;
+	else /* first_range->start == second_range->start */
+		return 0;
+}
+
+/* documentation: firmware_memmap.h */
+int have_sys_firmware_memmap(void)
+{
+	int ret;
+	struct stat mystat;
+
+	ret = stat(FIRMWARE_MEMMAP_DIR, &mystat);
+	if (ret != 0)
+		return 0;
+
+	return S_ISDIR(mystat.st_mode);
+}
+
+/* documentation: firmware_memmap.h */
+int get_firmware_memmap_ranges(struct memory_range *range, size_t *ranges)
+{
+	DIR *firmware_memmap_dir = NULL;
+	struct dirent *dirent;
+	int i = 0;
+
+	/* argument checking */
+	if (!range || !ranges) {
+		fprintf(stderr, "%s: Invalid arguments.\n", __FUNCTION__);
+		return -1;
+	}
+
+	/* open the directory */
+	firmware_memmap_dir = opendir(FIRMWARE_MEMMAP_DIR);
+	if (!firmware_memmap_dir) {
+		perror("Could not open \"" FIRMWARE_MEMMAP_DIR "\"");
+		goto error;
+	}
+
+	/* parse the entries */
+	while ((dirent = readdir(firmware_memmap_dir)) != NULL) {
+		int ret;
+		char full_path[PATH_MAX];
+
+		/* array overflow check */
+		if ((size_t)i >= *ranges) {
+			fprintf(stderr, "The firmware provides more entries "
+				"allowed (%d). Please report that as bug.\n",
+				*ranges);
+			goto error;
+		}
+
+		/* exclude '.' and '..' */
+		if (dirent->d_name[0] && dirent->d_name[0] == '.') {
+			continue;
+		}
+
+		snprintf(full_path, PATH_MAX, "%s/%s", FIRMWARE_MEMMAP_DIR,
+			dirent->d_name);
+		full_path[PATH_MAX-1] = 0;
+		ret = parse_memmap_entry(full_path, &range[i]);
+		if (ret < 0) {
+			goto error;
+		}
+
+		i++;
+	}
+
+	/* close the dir as we don't need it any more */
+	closedir(firmware_memmap_dir);
+
+	/* update the number of ranges for the caller */
+	*ranges = i;
+
+	/* and finally sort the entries with qsort */
+	qsort(range, *ranges, sizeof(struct memory_range), compare_ranges);
+
+	return 0;
+
+error:
+	if (firmware_memmap_dir) {
+		closedir(firmware_memmap_dir);
+	}
+	return -1;
+}
+
diff --git a/kexec/firmware_memmap.h b/kexec/firmware_memmap.h
new file mode 100644
index 0000000..41c3b3f
--- /dev/null
+++ b/kexec/firmware_memmap.h
@@ -0,0 +1,63 @@
+/*
+ * firmware_memmap.c: Read /sys/firmware/memmap
+ *
+ * Created by: Bernhard Walle (bwalle@suse.de)
+ * Copyright (C) SUSE LINUX Products GmbH, 2008. All rights reserved
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
+#ifndef FIRMWARE_MEMMAP_H
+#define FIRMWARE_MEMMAP_H
+
+#include "kexec.h"
+
+/**
+ * Reads the /sys/firmware/memmap interface, documented in
+ * Documentation/ABI/testing/sysfs-firmware-memmap (kernel tree).
+ *
+ * The difference between /proc/iomem and /sys/firmware/memmap is that
+ * /sys/firmware/memmap provides the raw memory map, provided by the
+ * firmware of the system. That memory map should be passed to a kexec'd
+ * kernel because the behaviour should be the same as a normal booted kernel,
+ * so any limitation (e.g. by the user providing the mem command line option)
+ * should not be passed to the kexec'd kernel.
+ *
+ * The parsing of the code is independent of the architecture. However, the
+ * actual architecture-specific code might postprocess the code a bit, like
+ * x86 does.
+ */
+
+/**
+ * Checks if the kernel provides the /sys/firmware/memmap interface.
+ * It makes sense to use that function in advance before calling
+ * get_firmware_memmap_ranges() because the latter function prints an error
+ * if it cannot open the directory. If have_sys_firmware_memmap() returns
+ * false, then one can use the old /proc/iomem interface (for older kernels).
+ */
+int have_sys_firmware_memmap(void);
+
+/**
+ * Parses the /sys/firmware/memmap memory map.
+ *
+ * @param[out] range a pointer to an array of type struct memory_range with
+ *             at least *range entries
+ * @param[in,out] ranges a pointer to an integer that holds the number of
+ *        	  entries which range contains (at least). After successful
+ *        	  return, the number of actual entries will be written.
+ * @return 0 on success, -1 on failure.
+ */
+int get_firmware_memmap_ranges(struct memory_range *range, size_t *ranges);
+
+
+#endif /* FIRMWARE_MEMMAP_H */
-- 
1.5.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
