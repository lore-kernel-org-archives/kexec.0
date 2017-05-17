Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x22e.google.com ([2607:f8b0:400e:c05::22e])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dArpL-0000ii-IA
 for kexec@lists.infradead.org; Wed, 17 May 2017 05:48:53 +0000
Received: by mail-pg0-x22e.google.com with SMTP id x64so1712385pgd.3
 for <kexec@lists.infradead.org>; Tue, 16 May 2017 22:48:31 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v7 05/10] arm64: kdump: identify memory regions
Date: Wed, 17 May 2017 14:51:45 +0900
Message-Id: <20170517055150.12601-6-takahiro.akashi@linaro.org>
In-Reply-To: <20170517055150.12601-1-takahiro.akashi@linaro.org>
References: <20170517055150.12601-1-takahiro.akashi@linaro.org>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: horms@verge.net.au
Cc: geoff@infradead.org, panand@redhat.com, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>

The following regions need to be identified for later use:
 a) memory regions which belong to the 1st kernel
 b) usable memory reserved for crash dump kernel

We go through /proc/iomem to find out a) and b) which are marked
as "System RAM" and "Crash kernel", respectively.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 kexec/arch/arm64/Makefile          |   2 +
 kexec/arch/arm64/crashdump-arm64.c | 109 +++++++++++++++++++++++++++++++++++--
 kexec/arch/arm64/crashdump-arm64.h |  14 ++++-
 kexec/arch/arm64/iomem.h           |   1 +
 4 files changed, 120 insertions(+), 6 deletions(-)

diff --git a/kexec/arch/arm64/Makefile b/kexec/arch/arm64/Makefile
index 91f6388..9d9111c 100644
--- a/kexec/arch/arm64/Makefile
+++ b/kexec/arch/arm64/Makefile
@@ -6,6 +6,8 @@ arm64_FS2DT_INCLUDE += \
 
 arm64_DT_OPS += kexec/dt-ops.c
 
+arm64_MEM_REGIONS = kexec/mem_regions.c
+
 arm64_CPPFLAGS += -I $(srcdir)/kexec/
 
 arm64_KEXEC_SRCS += \
diff --git a/kexec/arch/arm64/crashdump-arm64.c b/kexec/arch/arm64/crashdump-arm64.c
index b0e4713..9267c9a 100644
--- a/kexec/arch/arm64/crashdump-arm64.c
+++ b/kexec/arch/arm64/crashdump-arm64.c
@@ -1,5 +1,13 @@
 /*
  * ARM64 crashdump.
+ *     partly derived from arm implementation
+ *
+ * Copyright (c) 2014-2017 Linaro Limited
+ * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
 
 #define _GNU_SOURCE
@@ -10,18 +18,111 @@
 #include "kexec.h"
 #include "crashdump.h"
 #include "crashdump-arm64.h"
+#include "iomem.h"
 #include "kexec-arm64.h"
 #include "kexec-elf.h"
+#include "mem_regions.h"
 
-struct memory_ranges usablemem_rgns = {};
+/* memory ranges on crashed kernel */
+static struct memory_range system_memory_ranges[CRASH_MAX_MEMORY_RANGES];
+static struct memory_ranges system_memory_rgns = {
+	.size = 0,
+	.max_size = CRASH_MAX_MEMORY_RANGES,
+	.ranges = system_memory_ranges,
+};
 
-int is_crashkernel_mem_reserved(void)
+/* memory range reserved for crashkernel */
+struct memory_range crash_reserved_mem;
+struct memory_ranges usablemem_rgns = {
+	.size = 0,
+	.max_size = 1,
+	.ranges = &crash_reserved_mem,
+};
+
+/*
+ * iomem_range_callback() - callback called for each iomem region
+ * @data: not used
+ * @nr: not used
+ * @str: name of the memory region
+ * @base: start address of the memory region
+ * @length: size of the memory region
+ *
+ * This function is called once for each memory region found in /proc/iomem.
+ * It locates system RAM and crashkernel reserved memory and places these to
+ * variables, respectively, system_memory_ranges and crash_reserved_mem.
+ */
+
+static int iomem_range_callback(void *UNUSED(data), int UNUSED(nr),
+				char *str, unsigned long long base,
+				unsigned long long length)
 {
+	if (strncmp(str, CRASH_KERNEL, strlen(CRASH_KERNEL)) == 0)
+		return mem_regions_add(&usablemem_rgns,
+				       base, length, RANGE_RAM);
+	else if (strncmp(str, SYSTEM_RAM, strlen(SYSTEM_RAM)) == 0)
+		return mem_regions_add(&system_memory_rgns,
+				       base, length, RANGE_RAM);
+
 	return 0;
 }
 
+int is_crashkernel_mem_reserved(void)
+{
+	if (!usablemem_rgns.size)
+		kexec_iomem_for_each_line(NULL, iomem_range_callback, NULL);
+
+	return crash_reserved_mem.start != crash_reserved_mem.end;
+}
+
+/*
+ * crash_get_memory_ranges() - read system physical memory
+ *
+ * Function reads through system physical memory and stores found memory
+ * regions in system_memory_ranges.
+ * Regions are sorted in ascending order.
+ *
+ * Returns 0 in case of success and a negative value otherwise.
+ */
+static int crash_get_memory_ranges(void)
+{
+	/*
+	 * First read all memory regions that can be considered as
+	 * system memory including the crash area.
+	 */
+	if (!usablemem_rgns.size)
+		kexec_iomem_for_each_line(NULL, iomem_range_callback, NULL);
+
+	/* allow only a single region for crash dump kernel */
+	if (usablemem_rgns.size != 1)
+		return -EINVAL;
+
+	dbgprint_mem_range("Reserved memory range", &crash_reserved_mem, 1);
+
+	if (mem_regions_exclude(&system_memory_rgns, &crash_reserved_mem)) {
+		fprintf(stderr,
+			"Error: Number of crash memory ranges excedeed the max limit\n");
+		return -ENOMEM;
+	}
+
+	/*
+	 * Make sure that the memory regions are sorted.
+	 */
+	mem_regions_sort(&system_memory_rgns);
+
+	dbgprint_mem_range("Coredump memory ranges",
+			   system_memory_rgns.ranges, system_memory_rgns.size);
+}
+
 int get_crash_kernel_load_range(uint64_t *start, uint64_t *end)
 {
-	/* Crash kernel region size is not exposed by the system */
-	return -1;
+	if (!usablemem_rgns.size)
+		kexec_iomem_for_each_line(NULL, iomem_range_callback, NULL);
+
+	if (!crash_reserved_mem.end)
+		return -1;
+
+	*start = crash_reserved_mem.start;
+	*end = crash_reserved_mem.end;
+
+	return 0;
 }
diff --git a/kexec/arch/arm64/crashdump-arm64.h b/kexec/arch/arm64/crashdump-arm64.h
index f33c7a2..ce9881e 100644
--- a/kexec/arch/arm64/crashdump-arm64.h
+++ b/kexec/arch/arm64/crashdump-arm64.h
@@ -1,12 +1,22 @@
 /*
  * ARM64 crashdump.
+ *
+ * Copyright (c) 2014-2017 Linaro Limited
+ * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
 
-#if !defined(CRASHDUMP_ARM64_H)
+#ifndef CRASHDUMP_ARM64_H
 #define CRASHDUMP_ARM64_H
 
 #include "kexec.h"
 
+#define CRASH_MAX_MEMORY_RANGES	32
+
 extern struct memory_ranges usablemem_rgns;
+extern struct memory_range crash_reserved_mem;
 
-#endif
+#endif /* CRASHDUMP_ARM64_H */
diff --git a/kexec/arch/arm64/iomem.h b/kexec/arch/arm64/iomem.h
index 7fd66eb..20cda87 100644
--- a/kexec/arch/arm64/iomem.h
+++ b/kexec/arch/arm64/iomem.h
@@ -2,6 +2,7 @@
 #define IOMEM_H
 
 #define SYSTEM_RAM		"System RAM\n"
+#define CRASH_KERNEL		"Crash kernel\n"
 #define IOMEM_RESERVED		"reserved\n"
 
 #endif
-- 
2.11.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
