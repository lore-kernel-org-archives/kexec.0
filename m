Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KFdPW-0002bn-5P
	for kexec@lists.infradead.org; Sun, 06 Jul 2008 23:12:51 +0000
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH 5/5] Use get_memory_ranges() on x86-64.
Date: Mon,  7 Jul 2008 01:13:28 +0200
Message-Id: <1215386008-16271-6-git-send-email-bwalle@suse.de>
In-Reply-To: <1215386008-16271-1-git-send-email-bwalle@suse.de>
References: <1215386008-16271-1-git-send-email-bwalle@suse.de>
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
Cc: Bernhard Walle <bwalle@suse.de>, Bernhard Walle <bernhard.walle@gmx.de>, vgoyal@redhat.com

From: Bernhard Walle <bernhard.walle@gmx.de>

Because the get_memory_ranges() function was the same on i386 and x86_64, and
because that /sys/firmware/memmap interface should also be used for x86_64
without *new* code duplication, that part was moved out in a new file called
kexec-x86-common.c. That file only contains the memory map parsing for both the
"old" /proc/iomem interface and the new /sys/firmware/memmap interface.

That file is now built for i386 and x86_64.


Signed-off-by: Bernhard Walle <bwalle@suse.de>
---
 kexec/arch/i386/Makefile           |    1 +
 kexec/arch/i386/kexec-x86-common.c |  207 ++++++++++++++++++++++++++++++++++++
 kexec/arch/i386/kexec-x86.c        |  175 ------------------------------
 kexec/arch/x86_64/Makefile         |    1 +
 kexec/arch/x86_64/kexec-x86_64.c   |   83 --------------
 5 files changed, 209 insertions(+), 258 deletions(-)
 create mode 100644 kexec/arch/i386/kexec-x86-common.c

diff --git a/kexec/arch/i386/Makefile b/kexec/arch/i386/Makefile
index f2d9636..d52a2f5 100644
--- a/kexec/arch/i386/Makefile
+++ b/kexec/arch/i386/Makefile
@@ -2,6 +2,7 @@
 # kexec i386 (linux booting linux)
 #
 i386_KEXEC_SRCS =  kexec/arch/i386/kexec-x86.c
+i386_KEXEC_SRCS += kexec/arch/i386/kexec-x86-common.c
 i386_KEXEC_SRCS += kexec/arch/i386/kexec-elf-x86.c
 i386_KEXEC_SRCS += kexec/arch/i386/kexec-elf-rel-x86.c
 i386_KEXEC_SRCS += kexec/arch/i386/kexec-bzImage.c
diff --git a/kexec/arch/i386/kexec-x86-common.c b/kexec/arch/i386/kexec-x86-common.c
new file mode 100644
index 0000000..4533425
--- /dev/null
+++ b/kexec/arch/i386/kexec-x86-common.c
@@ -0,0 +1,207 @@
+/*
+ * kexec: Linux boots Linux
+ *
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
+#include <stddef.h>
+#include <stdio.h>
+#include <errno.h>
+#include <stdint.h>
+#include <string.h>
+#include <limits.h>
+#include <stdlib.h>
+#include "../../kexec.h"
+#include "../../kexec-syscall.h"
+#include "../../firmware_memmap.h"
+#include "kexec-x86.h"
+
+static struct memory_range memory_range[MAX_MEMORY_RANGES];
+
+/**
+ * The old /proc/iomem parsing code.
+ *
+ * @param[out] range pointer that will be set to an array that holds the
+ *             memory ranges
+ * @param[out] ranges number of ranges valid in @p range
+ *
+ * @return 0 on success, any other value on failure.
+ */
+static int get_memory_ranges_proc_iomem(struct memory_range **range, int *ranges)
+{
+	const char *iomem= proc_iomem();
+	int memory_ranges = 0;
+	char line[MAX_LINE];
+	FILE *fp;
+	fp = fopen(iomem, "r");
+	if (!fp) {
+		fprintf(stderr, "Cannot open %s: %s\n",
+			iomem, strerror(errno));
+		return -1;
+	}
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
+#if 0
+		printf("%016Lx-%016Lx : %s",
+			start, end, str);
+#endif
+		if (memcmp(str, "System RAM\n", 11) == 0) {
+			type = RANGE_RAM;
+		}
+		else if (memcmp(str, "reserved\n", 9) == 0) {
+			type = RANGE_RESERVED;
+		}
+		else if (memcmp(str, "ACPI Tables\n", 12) == 0) {
+			type = RANGE_ACPI;
+		}
+		else if (memcmp(str, "ACPI Non-volatile Storage\n", 26) == 0) {
+			type = RANGE_ACPI_NVS;
+		}
+		else {
+			continue;
+		}
+		memory_range[memory_ranges].start = start;
+		memory_range[memory_ranges].end = end;
+		memory_range[memory_ranges].type = type;
+#if 0
+		printf("%016Lx-%016Lx : %x\n",
+			start, end, type);
+#endif
+		memory_ranges++;
+	}
+	fclose(fp);
+	*range = memory_range;
+	*ranges = memory_ranges;
+	return 0;
+}
+
+/**
+ * Calls the architecture independent get_firmware_memmap_ranges() to parse
+ * /sys/firmware/memmap and then do some x86 only modifications.
+ *
+ * @param[out] range pointer that will be set to an array that holds the
+ *             memory ranges
+ * @param[out] ranges number of ranges valid in @p range
+ *
+ * @return 0 on success, any other value on failure.
+ */
+static int get_memory_ranges_sysfs(struct memory_range **range, int *ranges)
+{
+	int ret;
+	size_t range_number = MAX_MEMORY_RANGES;
+
+	ret = get_firmware_memmap_ranges(memory_range, &range_number);
+	if (ret != 0) {
+		fprintf(stderr, "Parsing the /sys/firmware memory map failed. "
+			"Falling back to /proc/iomem.\n");
+		return get_memory_ranges_proc_iomem(range, ranges);
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
+	int ret, i;
+
+	if (have_sys_firmware_memmap())
+		ret = get_memory_ranges_sysfs(range, ranges);
+	else
+		ret = get_memory_ranges_proc_iomem(range, ranges);
+
+	/*
+	 * both get_memory_ranges_sysfs() and get_memory_ranges_proc_iomem()
+	 * have already printed an error message, so fail silently here
+	 */
+	if (ret != 0)
+		return ret;
+
+	/* Don't report the interrupt table as ram */
+	for (i = 0; i < *ranges; i++) {
+		if ((*range)[i].type == RANGE_RAM &&
+				((*range)[i].start < 0x100)) {
+			(*range)[i].start = 0x100;
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
+
diff --git a/kexec/arch/i386/kexec-x86.c b/kexec/arch/i386/kexec-x86.c
index d5b6737..d33a14b 100644
--- a/kexec/arch/i386/kexec-x86.c
+++ b/kexec/arch/i386/kexec-x86.c
@@ -33,181 +33,6 @@
 #include "crashdump-x86.h"
 #include <arch/options.h>
 
-static struct memory_range memory_range[MAX_MEMORY_RANGES];
-
-/**
- * The old /proc/iomem parsing code.
- *
- * @param[out] range pointer that will be set to an array that holds the
- *             memory ranges
- * @param[out] ranges number of ranges valid in @p range
- *
- * @return 0 on success, any other value on failure.
- */
-static int get_memory_ranges_proc_iomem(struct memory_range **range, int *ranges)
-{
-	const char *iomem= proc_iomem();
-	int memory_ranges = 0;
-	char line[MAX_LINE];
-	FILE *fp;
-	fp = fopen(iomem, "r");
-	if (!fp) {
-		fprintf(stderr, "Cannot open %s: %s\n",
-			iomem, strerror(errno));
-		return -1;
-	}
-	while(fgets(line, sizeof(line), fp) != 0) {
-		unsigned long long start, end;
-		char *str;
-		int type;
-		int consumed;
-		int count;
-		if (memory_ranges >= MAX_MEMORY_RANGES)
-			break;
-		count = sscanf(line, "%Lx-%Lx : %n",
-			&start, &end, &consumed);
-		if (count != 2)
-			continue;
-		str = line + consumed;
-		end = end + 1;
-#if 0
-		printf("%016Lx-%016Lx : %s",
-			start, end, str);
-#endif
-		if (memcmp(str, "System RAM\n", 11) == 0) {
-			type = RANGE_RAM;
-		}
-		else if (memcmp(str, "reserved\n", 9) == 0) {
-			type = RANGE_RESERVED;
-		}
-		else if (memcmp(str, "ACPI Tables\n", 12) == 0) {
-			type = RANGE_ACPI;
-		}
-		else if (memcmp(str, "ACPI Non-volatile Storage\n", 26) == 0) {
-			type = RANGE_ACPI_NVS;
-		}
-		else {
-			continue;
-		}
-		memory_range[memory_ranges].start = start;
-		memory_range[memory_ranges].end = end;
-		memory_range[memory_ranges].type = type;
-#if 0
-		printf("%016Lx-%016Lx : %x\n",
-			start, end, type);
-#endif
-		memory_ranges++;
-	}
-	fclose(fp);
-	*range = memory_range;
-	*ranges = memory_ranges;
-	return 0;
-}
-
-/**
- * Calls the architecture independent get_firmware_memmap_ranges() to parse
- * /sys/firmware/memmap and then do some x86 only modifications.
- *
- * @param[out] range pointer that will be set to an array that holds the
- *             memory ranges
- * @param[out] ranges number of ranges valid in @p range
- *
- * @return 0 on success, any other value on failure.
- */
-static int get_memory_ranges_sysfs(struct memory_range **range, int *ranges)
-{
-	int ret;
-	size_t range_number = MAX_MEMORY_RANGES;
-
-	ret = get_firmware_memmap_ranges(memory_range, &range_number);
-	if (ret != 0) {
-		fprintf(stderr, "Parsing the /sys/firmware memory map failed. "
-			"Falling back to /proc/iomem.\n");
-		return get_memory_ranges_proc_iomem(range, ranges);
-	}
-
-	*range = memory_range;
-	*ranges = range_number;
-
-	return 0;
-}
-
-/**
- * Return a sorted list of memory ranges.
- *
- * If we have the /sys/firmware/memmap interface, then use that. If not,
- * or if parsing of that fails, use /proc/iomem as fallback.
- *
- * @param[out] range pointer that will be set to an array that holds the
- *             memory ranges
- * @param[out] ranges number of ranges valid in @p range
- * @param[in]  kexec_flags the kexec_flags to determine if we load a normal
- *             or a crashdump kernel
- *
- * @return 0 on success, any other value on failure.
- */
-int get_memory_ranges(struct memory_range **range, int *ranges,
-		      unsigned long kexec_flags)
-{
-	int ret, i;
-
-	if (have_sys_firmware_memmap())
-		ret = get_memory_ranges_sysfs(range, ranges);
-	else
-		ret = get_memory_ranges_proc_iomem(range, ranges);
-
-	/*
-	 * both get_memory_ranges_sysfs() and get_memory_ranges_proc_iomem()
-	 * have already printed an error message, so fail silently here
-	 */
-	if (ret != 0)
-		return ret;
-
-	/* Don't report the interrupt table as ram */
-	for (i = 0; i < *ranges; i++) {
-		if ((*range)[i].type == RANGE_RAM &&
-				((*range)[i].start < 0x100)) {
-			(*range)[i].start = 0x100;
-			break;
-		}
-	}
-
-	/*
-	 * Redefine the memory region boundaries if kernel
-	 * exports the limits and if it is panic kernel.
-	 * Override user values only if kernel exported values are
-	 * subset of user defined values.
-	 */
-	if (kexec_flags & KEXEC_ON_CRASH) {
-		unsigned long long start, end;
-
-		ret = parse_iomem_single("Crash kernel\n", &start, &end);
-		if (ret != 0) {
-			fprintf(stderr, "parse_iomem_single failed.\n");
-			return -1;
-		}
-
-		if (start > mem_min)
-			mem_min = start;
-		if (end < mem_max)
-			mem_max = end;
-	}
-
-	/* just set 0 to 1 to enable printing for debugging */
-#if 0
-	{
-		int i;
-		printf("MEMORY RANGES\n");
-		for (i = 0; i < *ranges; i++) {
-			printf("%016Lx-%016Lx (%d)\n", (*range)[i].start,
-				(*range)[i].end, (*range)[i].type);
-		}
-	}
-#endif
-
-	return ret;
-}
-
 struct file_type file_type[] = {
 	{ "multiboot-x86", multiboot_x86_probe, multiboot_x86_load,
 	  multiboot_x86_usage },
diff --git a/kexec/arch/x86_64/Makefile b/kexec/arch/x86_64/Makefile
index c59c41f..7ca3e7e 100644
--- a/kexec/arch/x86_64/Makefile
+++ b/kexec/arch/x86_64/Makefile
@@ -7,6 +7,7 @@ x86_64_KEXEC_SRCS += kexec/arch/i386/kexec-multiboot-x86.c
 x86_64_KEXEC_SRCS += kexec/arch/i386/kexec-beoboot-x86.c
 x86_64_KEXEC_SRCS += kexec/arch/i386/kexec-nbi.c
 x86_64_KEXEC_SRCS += kexec/arch/i386/x86-linux-setup.c
+x86_64_KEXEC_SRCS += kexec/arch/i386/kexec-x86-common.c
 x86_64_KEXEC_SRCS += kexec/arch/x86_64/crashdump-x86_64.c
 x86_64_KEXEC_SRCS += kexec/arch/x86_64/kexec-x86_64.c
 x86_64_KEXEC_SRCS += kexec/arch/x86_64/kexec-elf-x86_64.c
diff --git a/kexec/arch/x86_64/kexec-x86_64.c b/kexec/arch/x86_64/kexec-x86_64.c
index d0b3e90..9973815 100644
--- a/kexec/arch/x86_64/kexec-x86_64.c
+++ b/kexec/arch/x86_64/kexec-x86_64.c
@@ -32,89 +32,6 @@
 #include "crashdump-x86_64.h"
 #include <arch/options.h>
 
-#define MAX_MEMORY_RANGES 64
-static struct memory_range memory_range[MAX_MEMORY_RANGES];
-
-/* Return a sorted list of memory ranges. */
-int get_memory_ranges(struct memory_range **range, int *ranges,
-					unsigned long kexec_flags)
-{
-	const char *iomem= proc_iomem();
-	int memory_ranges = 0;
-	char line[MAX_LINE];
-	FILE *fp;
-	fp = fopen(iomem, "r");
-	if (!fp) {
-		fprintf(stderr, "Cannot open %s: %s\n",
-			iomem, strerror(errno));
-		return -1;
-	}
-	while(fgets(line, sizeof(line), fp) != 0) {
-		unsigned long long start, end;
-		char *str;
-		int type;
-		int consumed;
-		int count;
-		if (memory_ranges >= MAX_MEMORY_RANGES)
-			break;
-		count = sscanf(line, "%Lx-%Lx : %n",
-			&start, &end, &consumed);
-		if (count != 2)
-			continue;
-		str = line + consumed;
-		end = end + 1;
-#ifdef DEBUG
-		printf("%016Lx-%016Lx : %s",
-			start, end, str);
-#endif
-		if (memcmp(str, "System RAM\n", 11) == 0) {
-			type = RANGE_RAM;
-		}
-		else if (memcmp(str, "reserved\n", 9) == 0) {
-			type = RANGE_RESERVED;
-		}
-		else if (memcmp(str, "ACPI Tables\n", 12) == 0) {
-			type = RANGE_ACPI;
-		}
-		else if (memcmp(str, "ACPI Non-volatile Storage\n", 26) == 0) {
-			type = RANGE_ACPI_NVS;
-		}
-		else if (memcmp(str, "Crash kernel\n", 13) == 0) {
-			/* Redefine the memory region boundaries if kernel
-			 * exports the limits and if it is panic kernel.
-			 * Override user values only if kernel exported
-			 * values are subset of user defined values.
-			 */
-			if (kexec_flags & KEXEC_ON_CRASH) {
-				if (start > mem_min)
-					mem_min = start;
-				if (end < mem_max)
-					mem_max = end;
-			}
-			continue;
-		}
-		else {
-			continue;
-		}
-		/* Don't report the interrupt table as ram */
-		if (type == RANGE_RAM && (start < 0x100)) {
-			start = 0x100;
-		}
-		memory_range[memory_ranges].start = start;
-		memory_range[memory_ranges].end = end;
-		memory_range[memory_ranges].type = type;
-#ifdef DEBUG
-		printf("%016Lx-%016Lx : %x\n",
-			start, end, type);
-#endif
-		memory_ranges++;
-	}
-	fclose(fp);
-	*range = memory_range;
-	*ranges = memory_ranges;
-	return 0;
-}
-
 struct file_type file_type[] = {
 	{ "elf-x86_64", elf_x86_64_probe, elf_x86_64_load, elf_x86_64_usage },
 	{ "multiboot-x86", multiboot_x86_probe, multiboot_x86_load,
-- 
1.5.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
