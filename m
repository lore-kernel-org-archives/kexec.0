Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
 by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lZP1n-00DKJQ-I8
 for kexec@lists.infradead.org; Thu, 22 Apr 2021 02:25:17 +0000
From: Youling Tang <tangyouling@loongson.cn>
Subject: [PATCH v2 3/4] mips: kdump: Reserve extra memory for crash dump
Date: Thu, 22 Apr 2021 10:24:33 +0800
Message-Id: <1619058274-6996-4-git-send-email-tangyouling@loongson.cn>
In-Reply-To: <1619058274-6996-1-git-send-email-tangyouling@loongson.cn>
References: <1619058274-6996-1-git-send-email-tangyouling@loongson.cn>
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
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Baoquan He <bhe@redhat.com>, Huacai Chen <chenhuacai@kernel.org>, Jinyang He <hejinyang@loongson.cn>, kexec@lists.infradead.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org

From: Huacai Chen <chenhc@lemote.com>

Traditionally, MIPS's contiguous low memory can be as less as 256M, so
crashkernel=X@Y may be unable to large enough in some cases. Moreover,
for the "multi numa node + sparse memory model" case, it is attempt to
allocate section_mem_maps on every node. Thus, if the total memory of a
node is more than 1GB, we reserve the top 128MB for the capture kernel.

This 128M will be reserved only if the following conditions are met:
1. The configuration option CONFIG_KEXEC is y.
2. A valid "crashkernel=" parameter has been added to the command line.
3. The total memory of a node is greater than 1G.

Signed-off-by: Huacai Chen <chenhuacai@kernel.org>
Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
v2:
- New patch.

 arch/mips/kernel/setup.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 1bc8a9cc..af2c860 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -492,6 +492,25 @@ static void __init request_crashkernel(struct resource *res)
 			(unsigned long)(resource_size(&crashk_res) >> 20),
 			(unsigned long)(crashk_res.start  >> 20));
 }
+
+/*
+ * Traditionally, MIPS's contiguous low memory is 256M, so crashkernel=X@Y is
+ * unable to be large enough in some cases. Thus, if the total memory of a node
+ * is more than 1GB, we reserve the top 128MB for the capture kernel.
+ */
+static void reserve_crashm_region(int node, unsigned long s0, unsigned long e0)
+{
+	if (crashk_res.start == crashk_res.end)
+		return;
+
+	if ((e0 - s0) <= (SZ_1G >> PAGE_SHIFT))
+		return;
+
+	s0 = e0 - (SZ_128M >> PAGE_SHIFT);
+
+	memblock_reserve(PFN_PHYS(s0), (e0 - s0) << PAGE_SHIFT);
+}
+
 #else /* !defined(CONFIG_KEXEC)		*/
 static void __init mips_parse_crashkernel(void)
 {
@@ -500,6 +519,10 @@ static void __init mips_parse_crashkernel(void)
 static void __init request_crashkernel(struct resource *res)
 {
 }
+
+static void reserve_crashm_region(int node, unsigned long s0, unsigned long e0)
+{
+}
 #endif /* !defined(CONFIG_KEXEC)  */
 
 static void __init check_kernel_sections_mem(void)
@@ -627,6 +650,9 @@ static void __init bootcmdline_init(void)
  */
 static void __init arch_mem_init(char **cmdline_p)
 {
+	unsigned int node;
+	unsigned long start_pfn, end_pfn;
+
 	/* call board setup routine */
 	plat_mem_setup();
 	memblock_set_bottom_up(true);
@@ -666,6 +692,12 @@ static void __init arch_mem_init(char **cmdline_p)
 	if (crashk_res.start != crashk_res.end)
 		memblock_reserve(crashk_res.start, resource_size(&crashk_res));
 #endif
+
+	for_each_online_node(node) {
+		get_pfn_range_for_nid(node, &start_pfn, &end_pfn);
+		reserve_crashm_region(node, start_pfn, end_pfn);
+	}
+
 	device_tree_init();
 
 	/*
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
