Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UDbNN-0000qF-91
 for kexec@lists.infradead.org; Thu, 07 Mar 2013 14:00:54 +0000
Received: from g1t0038.austin.hp.com (g1t0038.austin.hp.com [16.236.32.44])
 by g1t0026.austin.hp.com (Postfix) with ESMTP id 8B2A0C300
 for <kexec@lists.infradead.org>; Thu,  7 Mar 2013 14:00:52 +0000 (UTC)
Subject: [RFC PATCH 2/5] crash dump bitmap: init crash dump bitmap in kernel
 booting process
From: Jingbai Ma <jingbai.ma@hp.com>
Date: Thu, 07 Mar 2013 22:00:48 +0800
Message-ID: <20130307140047.28372.13730.stgit@k.asiapacific.hpqcorp.net>
In-Reply-To: <20130307140020.28372.34457.stgit@k.asiapacific.hpqcorp.net>
References: <20130307140020.28372.34457.stgit@k.asiapacific.hpqcorp.net>
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
To: kexec@lists.infradead.org
Cc: lisa.mitchell@hp.com

Reserve a memory block for crash_dump_bitmap in kernel booting process.

Signed-off-by: Jingbai Ma <jingbai.ma@hp.com>
---
 arch/x86/kernel/setup.c           |   59 +++++++++++++++++++++++++++++++++++++
 include/linux/crash_dump_bitmap.h |   59 +++++++++++++++++++++++++++++++++++++
 kernel/Makefile                   |    1 +
 kernel/crash_dump_bitmap.c        |   45 ++++++++++++++++++++++++++++
 4 files changed, 164 insertions(+), 0 deletions(-)
 create mode 100644 include/linux/crash_dump_bitmap.h
 create mode 100644 kernel/crash_dump_bitmap.c

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 84d3285..165c831 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -67,6 +67,7 @@
 
 #include <linux/percpu.h>
 #include <linux/crash_dump.h>
+#include <linux/crash_dump_bitmap.h>
 #include <linux/tboot.h>
 #include <linux/jiffies.h>
 
@@ -601,6 +602,62 @@ static void __init reserve_crashkernel(void)
 }
 #endif
 
+#ifdef CONFIG_CRASH_DUMP_BITMAP
+static void __init crash_dump_bitmap_init(void)
+{
+	static unsigned long BITSPERBYTE = 8;
+
+	unsigned long long mem_start;
+	unsigned long long mem_size;
+
+	if (is_kdump_kernel())
+		return;
+
+	mem_start = (1ULL << 24); /* 16MB */
+	mem_size = roundup((roundup(max_pfn, BITSPERBYTE) / BITSPERBYTE),
+		PAGE_SIZE);
+
+	crash_dump_bitmap_mem = memblock_find_in_range(mem_start,
+		MEMBLOCK_ALLOC_ACCESSIBLE, mem_size, PAGE_SIZE);
+
+	if (!crash_dump_bitmap_mem) {
+		pr_err(
+		"crash_dump_bitmap: allocate error! size=%lldkB, from=%lldMB\n",
+			mem_size >> 10, mem_start >> 20);
+
+		return;
+	}
+
+	crash_dump_bitmap_mem_size = mem_size;
+	memblock_reserve(crash_dump_bitmap_mem, crash_dump_bitmap_mem_size);
+	pr_info("crash_dump_bitmap: bitmap_mem=%lldMB. size=%lldkB\n",
+		(unsigned long long)crash_dump_bitmap_mem >> 20,
+		mem_size >> 10);
+
+	crash_dump_bitmap_res.start = crash_dump_bitmap_mem;
+	crash_dump_bitmap_res.end   = crash_dump_bitmap_mem + mem_size - 1;
+	insert_resource(&iomem_resource, &crash_dump_bitmap_res);
+
+	crash_dump_bitmap_info.version = CRASH_DUMP_BITMAP_VERSION;
+
+	crash_dump_bitmap_info.bitmap = crash_dump_bitmap_mem;
+	crash_dump_bitmap_info.bitmap_size = crash_dump_bitmap_mem_size;
+
+	crash_dump_bitmap_ctrl.exclude_crash_dump_bitmap_pages = 1;
+	crash_dump_bitmap_ctrl.exclude_zero_pages = 1;
+	crash_dump_bitmap_ctrl.exclude_cache_pages = 1;
+	crash_dump_bitmap_ctrl.exclude_cache_private_pages = 1;
+	crash_dump_bitmap_ctrl.exclude_user_pages = 1;
+	crash_dump_bitmap_ctrl.exclude_free_pages = 1;
+
+	pr_info("crash_dump_bitmap: Initialized!\n");
+}
+#else
+static void __init crash_dump_bitmap_init(void)
+{
+}
+#endif
+
 static struct resource standard_io_resources[] = {
 	{ .name = "dma1", .start = 0x00, .end = 0x1f,
 		.flags = IORESOURCE_BUSY | IORESOURCE_IO },
@@ -1094,6 +1151,8 @@ void __init setup_arch(char **cmdline_p)
 
 	reserve_crashkernel();
 
+	crash_dump_bitmap_init();
+
 	vsmp_init();
 
 	io_delay_init();
diff --git a/include/linux/crash_dump_bitmap.h b/include/linux/crash_dump_bitmap.h
new file mode 100644
index 0000000..63b1264
--- /dev/null
+++ b/include/linux/crash_dump_bitmap.h
@@ -0,0 +1,59 @@
+/*
+ *    include/linux/crash_dump_bitmap.h
+ *    Declaration of crash dump bitmap functions and data structures.
+ *
+ *    (C) Copyright 2013 Hewlett-Packard Development Company, L.P.
+ *    Author: Jingbai Ma <jingbai.ma@hp.com>
+ *
+ *    This program is free software; you can redistribute it and/or modify
+ *    it under the terms of version 2 of the GNU General Public License as
+ *    published by the Free Software Foundation.
+ *
+ *    This program is distributed in the hope that it will be useful,
+ *    but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *    MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ *    General Public License for more details.
+ */
+
+#ifndef _LINUX_CRASH_DUMP_BITMAP_H
+#define _LINUX_CRASH_DUMP_BITMAP_H
+
+#define CRASH_DUMP_BITMAP_VERSION 1;
+
+enum {
+	CRASH_DUMP_LEVEL_EXCLUDE_ZERO_PAGES = 1,
+	CRASH_DUMP_LEVEL_EXCLUDE_CACHE_PAGES = 2,
+	CRASH_DUMP_LEVEL_EXCLUDE_CACHE_PRIVATE_PAGES = 4,
+	CRASH_DUMP_LEVEL_EXCLUDE_USER_PAGES = 8,
+	CRASH_DUMP_LEVEL_EXCLUDE_FREE_PAGES = 16
+};
+
+struct crash_dump_bitmap_ctrl {
+	char exclude_crash_dump_bitmap_pages;
+	char exclude_zero_pages;	/* only for tracking dump level */
+	char exclude_cache_pages;
+	char exclude_cache_private_pages;
+	char exclude_user_pages;
+	char exclude_free_pages;
+};
+
+struct crash_dump_bitmap_info {
+	unsigned int version;
+	phys_addr_t bitmap;
+	phys_addr_t bitmap_size;
+	unsigned long cache_pages;
+	unsigned long cache_private_pages;
+	unsigned long user_pages;
+	unsigned long free_pages;
+	unsigned long hwpoison_pages;
+};
+
+void generate_crash_dump_bitmap(void);
+
+extern phys_addr_t crash_dump_bitmap_mem;
+extern phys_addr_t crash_dump_bitmap_mem_size;
+extern struct crash_dump_bitmap_ctrl crash_dump_bitmap_ctrl;
+extern struct crash_dump_bitmap_info crash_dump_bitmap_info;
+extern struct resource crash_dump_bitmap_res;
+
+#endif /* _LINUX_CRASH_DUMP_BITMAP_H */
diff --git a/kernel/Makefile b/kernel/Makefile
index bbde5f1..3e85003 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -107,6 +107,7 @@ obj-$(CONFIG_PERF_EVENTS) += events/
 obj-$(CONFIG_USER_RETURN_NOTIFIER) += user-return-notifier.o
 obj-$(CONFIG_PADATA) += padata.o
 obj-$(CONFIG_CRASH_DUMP) += crash_dump.o
+obj-$(CONFIG_KEXEC) += crash_dump_bitmap.o
 obj-$(CONFIG_JUMP_LABEL) += jump_label.o
 obj-$(CONFIG_CONTEXT_TRACKING) += context_tracking.o
 
diff --git a/kernel/crash_dump_bitmap.c b/kernel/crash_dump_bitmap.c
new file mode 100644
index 0000000..e743cdd
--- /dev/null
+++ b/kernel/crash_dump_bitmap.c
@@ -0,0 +1,45 @@
+/*
+ *    kernel/crash_dump_bitmap.c
+ *    Crash dump bitmap implementation.
+ *
+ *    (C) Copyright 2013 Hewlett-Packard Development Company, L.P.
+ *    Author: Jingbai Ma <jingbai.ma@hp.com>
+ *
+ *    This program is free software; you can redistribute it and/or modify
+ *    it under the terms of version 2 of the GNU General Public License as
+ *    published by the Free Software Foundation.
+ *
+ *    This program is distributed in the hope that it will be useful,
+ *    but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *    MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ *    General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/memblock.h>
+#include <linux/crash_dump.h>
+#include <linux/crash_dump_bitmap.h>
+
+#ifdef CONFIG_CRASH_DUMP_BITMAP
+
+phys_addr_t crash_dump_bitmap_mem;
+EXPORT_SYMBOL(crash_dump_bitmap_mem);
+
+phys_addr_t crash_dump_bitmap_mem_size;
+EXPORT_SYMBOL(crash_dump_bitmap_mem_size);
+
+struct crash_dump_bitmap_ctrl crash_dump_bitmap_ctrl;
+EXPORT_SYMBOL(crash_dump_bitmap_ctrl);
+
+struct crash_dump_bitmap_info crash_dump_bitmap_info;
+EXPORT_SYMBOL(crash_dump_bitmap_info);
+
+/* Location of the reserved area for the crash_dump_bitmap */
+struct resource crash_dump_bitmap_res = {
+	.name  = "Crash dump bitmap",
+	.start = 0,
+	.end   = 0,
+	.flags = IORESOURCE_BUSY | IORESOURCE_MEM
+};
+#endif /* CONFIG_CRASH_DUMP_BITMAP */


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
