Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKuYz-0004i2-L3
 for kexec@lists.infradead.org; Wed, 23 Sep 2020 02:31:22 +0000
Received: by mail-pj1-x1042.google.com with SMTP id s14so2013733pju.1
 for <kexec@lists.infradead.org>; Tue, 22 Sep 2020 19:31:20 -0700 (PDT)
From: Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 2/3] MIPS: Reserve extra memory for crash dump
Date: Wed, 23 Sep 2020 10:30:56 +0800
Message-Id: <1600828257-31316-2-git-send-email-chenhc@lemote.com>
In-Reply-To: <1600828257-31316-1-git-send-email-chenhc@lemote.com>
References: <1600828257-31316-1-git-send-email-chenhc@lemote.com>
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
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Eric Biederman <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
Cc: Huacai Chen <chenhuacai@gmail.com>, kexec@lists.infradead.org, linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, Fuxin Zhang <zhangfx@lemote.com>, Huacai Chen <chenhc@lemote.com>

Traditionally, MIPS's contiguous low memory can be as less as 256M, so
crashkernel=X@Y may be unable to large enough in some cases. Moreover,
for the "multi numa node + sparse memory model" case, it is attempt to
allocate section_mem_maps on every node. Thus, if the total memory of a
node is more than 1GB, we reserve the top 128MB for the crash kernel.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/kernel/setup.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index e2804a2..90d4a2e 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -29,6 +29,7 @@
 #include <linux/of_fdt.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/dmi.h>
+#include <linux/crash_dump.h>
 
 #include <asm/addrspace.h>
 #include <asm/bootinfo.h>
@@ -55,6 +56,10 @@ EXPORT_SYMBOL(cpu_data);
 struct screen_info screen_info;
 #endif
 
+#ifdef CONFIG_CRASH_DUMP
+static phys_addr_t crashmem_start, crashmem_size;
+#endif
+
 /*
  * Setup information
  *
@@ -404,6 +409,13 @@ static int __init early_parse_mem(char *p)
 
 	add_memory_region(start, size, BOOT_MEM_RAM);
 
+#ifdef CONFIG_CRASH_DUMP
+	if (start && size) {
+		crashmem_start = start;
+		crashmem_size = size;
+	}
+#endif
+
 	return 0;
 }
 early_param("mem", early_parse_mem);
@@ -642,6 +654,48 @@ static void __init bootcmdline_init(void)
 		bootcmdline_append(builtin_cmdline, COMMAND_LINE_SIZE);
 }
 
+/* Traditionally, MIPS's contiguous low memory is 256M, so crashkernel=X@Y is
+ * unable to be large enough in some cases. Thus, if the total memory of a node
+ * is more than 1GB, we reserve the top 128MB for the crash kernel */
+static void reserve_crashm_region(int node, unsigned long s0, unsigned long e0)
+{
+#ifdef CONFIG_KEXEC
+	if (crashk_res.start == crashk_res.end)
+		return;
+
+	if ((e0 - s0) <= (SZ_1G >> PAGE_SHIFT))
+		return;
+
+	s0 = e0 - (SZ_128M >> PAGE_SHIFT);
+
+	memblock_reserve(PFN_PHYS(s0), (e0 - s0) << PAGE_SHIFT);
+#endif
+}
+
+static void reserve_oldmem_region(int node, unsigned long s0, unsigned long e0)
+{
+#ifdef CONFIG_CRASH_DUMP
+	unsigned long s1, e1;
+
+	if (!is_kdump_kernel())
+		return;
+
+	if ((e0 - s0) > (SZ_1G >> PAGE_SHIFT))
+		e0 = e0 - (SZ_128M >> PAGE_SHIFT);
+
+	/* crashmem_start is crashk_res reserved by primary kernel */
+	s1 = PFN_UP(crashmem_start);
+	e1 = PFN_DOWN(crashmem_start + crashmem_size);
+
+	if (node == 0) {
+		memblock_reserve(PFN_PHYS(s0), (s1 - s0) << PAGE_SHIFT);
+		memblock_reserve(PFN_PHYS(e1), (e0 - e1) << PAGE_SHIFT);
+	} else {
+		memblock_reserve(PFN_PHYS(s0), (e0 - s0) << PAGE_SHIFT);
+	}
+#endif
+}
+
 /*
  * arch_mem_init - initialize memory management subsystem
  *
@@ -666,6 +720,9 @@ static void __init bootcmdline_init(void)
  */
 static void __init arch_mem_init(char **cmdline_p)
 {
+	unsigned int node;
+	unsigned long start_pfn, end_pfn;
+
 	/* call board setup routine */
 	plat_mem_setup();
 	memblock_set_bottom_up(true);
@@ -711,6 +768,12 @@ static void __init arch_mem_init(char **cmdline_p)
 	if (crashk_res.start != crashk_res.end)
 		memblock_reserve(crashk_res.start, resource_size(&crashk_res));
 #endif
+	for_each_online_node(node) {
+		get_pfn_range_for_nid(node, &start_pfn, &end_pfn);
+		reserve_crashm_region(node, start_pfn, end_pfn);
+		reserve_oldmem_region(node, start_pfn, end_pfn);
+	}
+
 	device_tree_init();
 
 	/*
-- 
2.7.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
