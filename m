Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bRxIJ-0008OM-GD
 for kexec@lists.infradead.org; Tue, 26 Jul 2016 08:01:03 +0000
Received: by mail-pf0-x22f.google.com with SMTP id y134so72964563pfg.0
 for <kexec@lists.infradead.org>; Tue, 26 Jul 2016 01:00:31 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH 1/6] arm64: kdump: identify memory regions
Date: Tue, 26 Jul 2016 17:05:20 +0900
Message-Id: <20160726080525.2539-2-takahiro.akashi@linaro.org>
In-Reply-To: <20160726080525.2539-1-takahiro.akashi@linaro.org>
References: <20160726080525.2539-1-takahiro.akashi@linaro.org>
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
 kexec/arch/arm64/crashdump-arm64.c | 104 ++++++++++++++++++++++++++++++++++++-
 kexec/arch/arm64/crashdump-arm64.h |  14 ++++-
 3 files changed, 117 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/arm64/Makefile b/kexec/arch/arm64/Makefile
index 37414dc..c2535c6 100644
--- a/kexec/arch/arm64/Makefile
+++ b/kexec/arch/arm64/Makefile
@@ -5,6 +5,8 @@ arm64_FS2DT_INCLUDE += -include $(srcdir)/kexec/arch/arm64/kexec-arm64.h \
 
 arm64_DT_OPS += kexec/dt-ops.c
 
+arm64_MEM_REGIONS = kexec/mem_regions.c
+
 arm64_CPPFLAGS += -I $(srcdir)/kexec/
 
 arm64_KEXEC_SRCS += \
diff --git a/kexec/arch/arm64/crashdump-arm64.c b/kexec/arch/arm64/crashdump-arm64.c
index d2272c8..5ab017c 100644
--- a/kexec/arch/arm64/crashdump-arm64.c
+++ b/kexec/arch/arm64/crashdump-arm64.c
@@ -1,5 +1,13 @@
 /*
  * ARM64 crashdump.
+ *     partly derived from arm implementation
+ *
+ * Copyright (c) 2014-2016 Linaro Limited
+ * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
 
 #define _GNU_SOURCE
@@ -12,10 +20,104 @@
 #include "crashdump-arm64.h"
 #include "kexec-arm64.h"
 #include "kexec-elf.h"
+#include "mem_regions.h"
 
-struct memory_ranges usablemem_rgns = {};
+#define CRASH_KERNEL "Crash kernel"
+#define SYSTEM_RAM "System RAM"
+
+/* memory ranges on crashed kernel */
+static struct memory_range crash_memory_ranges[CRASH_MAX_MEMORY_RANGES];
+static struct memory_ranges crash_memory_rgns = {
+	.size = 0,
+	.max_size = CRASH_MAX_MEMORY_RANGES,
+	.ranges = crash_memory_ranges,
+};
+
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
+ * variables, respectively, crash_memory_ranges and crash_reserved_mem.
+ */
+
+static int iomem_range_callback(void *UNUSED(data), int UNUSED(nr),
+				char *str, unsigned long long base,
+				unsigned long long length)
+{
+	if (strncmp(str, CRASH_KERNEL, strlen(CRASH_KERNEL)) == 0) {
+		return mem_regions_add(&usablemem_rgns,
+				       base, length, RANGE_RAM);
+	}
+	else if (strncmp(str, SYSTEM_RAM, strlen(SYSTEM_RAM)) == 0) {
+		return mem_regions_add(&crash_memory_rgns,
+				       base, length, RANGE_RAM);
+	}
+
+	return 0;
+}
 
 int is_crashkernel_mem_reserved(void)
 {
+	if (!crash_reserved_mem.end)
+		kexec_iomem_for_each_line(NULL, iomem_range_callback, NULL);
+
+	return crash_reserved_mem.start != crash_reserved_mem.end;
+}
+
+/*
+ * crash_get_memory_ranges() - read system physical memory
+ *
+ * Function reads through system physical memory and stores found memory
+ * regions in crash_memory_ranges.
+ * Regions are sorted in ascending order.
+ *
+ * Returns 0 in case of success and -1 otherwise (errno is set).
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
+	if (usablemem_rgns.size != 1) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	dbgprint_mem_range("Reserved memory range", &crash_reserved_mem, 1);
+
+	if (mem_regions_exclude(&crash_memory_rgns, &crash_reserved_mem)) {
+		fprintf(stderr,
+			"Error: Number of crash memory ranges excedeed the max limit\n");
+		errno = ENOMEM;
+		return -1;
+	}
+
+	/*
+	 * Make sure that the memory regions are sorted.
+	 */
+	mem_regions_sort(&crash_memory_rgns);
+
+	dbgprint_mem_range("Coredump memory ranges",
+			   crash_memory_rgns.ranges, crash_memory_rgns.size);
+
 	return 0;
 }
diff --git a/kexec/arch/arm64/crashdump-arm64.h b/kexec/arch/arm64/crashdump-arm64.h
index f33c7a2..07a0ed0 100644
--- a/kexec/arch/arm64/crashdump-arm64.h
+++ b/kexec/arch/arm64/crashdump-arm64.h
@@ -1,12 +1,22 @@
 /*
  * ARM64 crashdump.
+ *
+ * Copyright (c) 2014-2016 Linaro Limited
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
-- 
2.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
