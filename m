Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v18 09/17] x86/setup: Move reserve_crashkernel[_low]() into
 crash_core.c
Date: Wed, 22 Dec 2021 21:08:12 +0800
Message-ID: <20211222130820.1754-10-thunder.leizhen@huawei.com>
In-Reply-To: <20211222130820.1754-1-thunder.leizhen@huawei.com>
References: <20211222130820.1754-1-thunder.leizhen@huawei.com>
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
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc: Zhen Lei <thunder.leizhen@huawei.com>, Randy Dunlap <rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Chen Zhou <dingguo.cz@antgroup.com>, John
 Donnelly <John.p.donnelly@oracle.com>

From: Chen Zhou <chenzhou10@huawei.com>

Make the functions reserve_crashkernel[_low]() as generic. Since
reserve_crashkernel[_low]() implementations are quite similar on other
architectures as well, we can have more users of this later.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
Co-developed-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/x86/include/asm/kexec.h |   4 +
 arch/x86/kernel/setup.c      | 172 ----------------------------------
 kernel/crash_core.c          | 176 ++++++++++++++++++++++++++++++++++-
 3 files changed, 179 insertions(+), 173 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index a0223a6c0238a15..21fd1f2796e1057 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -216,6 +216,10 @@ typedef void crash_vmclear_fn(void);
 extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
 extern void kdump_nmi_shootdown_cpus(void);
 
+#ifdef CONFIG_KEXEC_CORE
+extern void __init reserve_crashkernel(void);
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_KEXEC_H */
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index beb73cce4b8b826..ba56e410f01811d 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -386,178 +386,6 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 	}
 }
 
-/*
- * --------- Crashkernel reservation ------------------------------
- */
-
-#ifdef CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL
-
-#ifdef CONFIG_64BIT
-static int __init reserve_crashkernel_low(unsigned long long low_size)
-{
-	unsigned long long low_base = 0;
-	unsigned long low_mem_limit;
-
-	low_mem_limit = min(memblock_phys_mem_size(), CRASH_ADDR_LOW_MAX);
-
-	/* passed with crashkernel=0,low ? */
-	if (!low_size)
-		return 0;
-
-	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
-	if (!low_base) {
-		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
-		       (unsigned long)(low_size >> 20));
-		return -ENOMEM;
-	}
-
-	pr_info("Reserving %ldMB of low memory at %ldMB for crashkernel (low RAM limit: %ldMB)\n",
-		(unsigned long)(low_size >> 20),
-		(unsigned long)(low_base >> 20),
-		(unsigned long)(low_mem_limit >> 20));
-
-	crashk_low_res.start = low_base;
-	crashk_low_res.end   = low_base + low_size - 1;
-
-	return 0;
-}
-#endif
-
-#define CRASHKERNEL_MEM_NONE		0x0	/* crashkernel= is not exist or invalid */
-#define CRASHKERNEL_MEM_CLASSIC		0x1	/* crashkernel=X[@offset] is valid */
-#define CRASHKERNEL_MEM_HIGH		0x2	/* crashkernel=X,high is valid */
-#define CRASHKERNEL_MEM_LOW		0x4	/* crashkernel=X,low is valid */
-
-/**
- * parse_crashkernel_in_order - Parse all "crashkernel=" configurations in
- *				priority order until a valid combination is found.
- * @cmdline:	The bootup command line.
- * @system_ram: Total system memory size.
- * @crash_size: Save the memory size specified by "crashkernel=X[@offset]" or
- *		"crashkernel=X,high".
- * @crash_base: Save the base address specified by "crashkernel=X@offset"
- * @low_size:	Save the memory size specified by "crashkernel=X,low"
- *
- * Returns the status flag of the parsing result of "crashkernel=", such as
- * CRASHKERNEL_MEM_NONE, CRASHKERNEL_MEM_HIGH.
- */
-static int __init parse_crashkernel_in_order(char *cmdline,
-					     unsigned long long system_ram,
-					     unsigned long long *crash_size,
-					     unsigned long long *crash_base,
-					     unsigned long long *low_size)
-{
-	int ret, flag = CRASHKERNEL_MEM_NONE;
-
-	BUG_ON(!crash_size || !crash_base || !low_size);
-
-	/* crashkernel=X[@offset] */
-	ret = parse_crashkernel(cmdline, system_ram, crash_size, crash_base);
-	if (!ret && crash_size > 0)
-		return CRASHKERNEL_MEM_CLASSIC;
-
-#ifdef CONFIG_64BIT
-	/* crashkernel=X,high */
-	ret = parse_crashkernel_high(cmdline, system_ram, crash_size, crash_base);
-	if (ret || crash_size <= 0)
-		return CRASHKERNEL_MEM_NONE;
-
-	flag = CRASHKERNEL_MEM_HIGH;
-
-	/* crashkernel=Y,low */
-	ret = parse_crashkernel_low(cmdline, system_ram, low_size, crash_base);
-	if (!ret)
-		flag |= CRASHKERNEL_MEM_LOW;
-#endif
-
-	return flag;
-}
-
-static void __init reserve_crashkernel(void)
-{
-	unsigned long long crash_size, crash_base, total_mem, low_size;
-	int flag;
-
-	total_mem = memblock_phys_mem_size();
-
-	flag = parse_crashkernel_in_order(boot_command_line, total_mem,
-					  &crash_size, &crash_base, &low_size);
-	if (flag == CRASHKERNEL_MEM_NONE)
-		return;
-
-	if (!crash_base) {
-		/*
-		 * For the case of crashkernel=X[@offset] and offset is omitted,
-		 * try the low memory first.
-		 */
-		if (!(flag & CRASHKERNEL_MEM_HIGH))
-			crash_base = memblock_phys_alloc_range(crash_size,
-						CRASH_ALIGN, CRASH_ALIGN,
-						CRASH_ADDR_LOW_MAX);
-
-		/*
-		 * If low memory allocation failed above, or for the case of
-		 * crashkernel=X,high, try the high memory.
-		 */
-		if (!crash_base)
-			crash_base = memblock_phys_alloc_range(crash_size,
-						CRASH_ALIGN, CRASH_ALIGN,
-						CRASH_ADDR_HIGH_MAX);
-		if (!crash_base) {
-			pr_info("crashkernel reservation failed - No suitable area found.\n");
-			return;
-		}
-	} else {
-		unsigned long long start;
-
-		/*
-		 * The case of crashkernel=X@offset and offset is specified.
-		 * Only user-specified space can be reserved.
-		 */
-		start = memblock_phys_alloc_range(crash_size, SZ_1M, crash_base,
-						  crash_base + crash_size);
-		if (start != crash_base) {
-			pr_info("crashkernel reservation failed - memory is in use.\n");
-			return;
-		}
-	}
-
-#ifdef CONFIG_64BIT
-	if (crash_base >= CRASH_ADDR_LOW_MAX) {
-		/*
-		 * Ensure that at least 256M extra low memory is allocated for
-		 * DMA buffers and swiotlb, if low memory size is not specified.
-		 */
-		if (!(flag & CRASHKERNEL_MEM_LOW)) {
-			/*
-			 * two parts from kernel/dma/swiotlb.c:
-			 * -swiotlb size: user-specified with swiotlb= or default.
-			 *
-			 * -swiotlb overflow buffer: now hardcoded to 32k. We round it
-			 * to 8M for other buffers that may need to stay low too. Also
-			 * make sure we allocate enough extra low memory so that we
-			 * don't run out of DMA buffers for 32-bit devices.
-			 */
-			low_size = max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);
-		}
-
-		if (reserve_crashkernel_low(low_size)) {
-			memblock_phys_free(crash_base, crash_size);
-			return;
-		}
-	}
-#endif
-
-	pr_info("Reserving %ldMB of memory at %ldMB for crashkernel (System RAM: %ldMB)\n",
-		(unsigned long)(crash_size >> 20),
-		(unsigned long)(crash_base >> 20),
-		(unsigned long)(total_mem >> 20));
-
-	crashk_res.start = crash_base;
-	crashk_res.end   = crash_base + crash_size - 1;
-}
-#endif	/* CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL */
-
 static struct resource standard_io_resources[] = {
 	{ .name = "dma1", .start = 0x00, .end = 0x1f,
 		.flags = IORESOURCE_BUSY | IORESOURCE_IO },
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index eb53f5ec62c900f..64ed082382f3f18 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -5,9 +5,11 @@
  */
 
 #include <linux/buildid.h>
-#include <linux/crash_core.h>
+#include <linux/kexec.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
+#include <linux/memblock.h>
+#include <linux/swiotlb.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -295,6 +297,178 @@ int __init parse_crashkernel_low(char *cmdline,
 				"crashkernel=", suffix_tbl[SUFFIX_LOW]);
 }
 
+/*
+ * --------- Crashkernel reservation ------------------------------
+ */
+
+#ifdef CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL
+
+#ifdef CONFIG_64BIT
+static int __init reserve_crashkernel_low(unsigned long long low_size)
+{
+	unsigned long long low_base = 0;
+	unsigned long low_mem_limit;
+
+	low_mem_limit = min(memblock_phys_mem_size(), CRASH_ADDR_LOW_MAX);
+
+	/* passed with crashkernel=0,low ? */
+	if (!low_size)
+		return 0;
+
+	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
+	if (!low_base) {
+		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
+		       (unsigned long)(low_size >> 20));
+		return -ENOMEM;
+	}
+
+	pr_info("Reserving %ldMB of low memory at %ldMB for crashkernel (low RAM limit: %ldMB)\n",
+		(unsigned long)(low_size >> 20),
+		(unsigned long)(low_base >> 20),
+		(unsigned long)(low_mem_limit >> 20));
+
+	crashk_low_res.start = low_base;
+	crashk_low_res.end   = low_base + low_size - 1;
+
+	return 0;
+}
+#endif
+
+#define CRASHKERNEL_MEM_NONE		0x0	/* crashkernel= is not exist or invalid */
+#define CRASHKERNEL_MEM_CLASSIC		0x1	/* crashkernel=X[@offset] is valid */
+#define CRASHKERNEL_MEM_HIGH		0x2	/* crashkernel=X,high is valid */
+#define CRASHKERNEL_MEM_LOW		0x4	/* crashkernel=X,low is valid */
+
+/**
+ * parse_crashkernel_in_order - Parse all "crashkernel=" configurations in
+ *				priority order until a valid combination is found.
+ * @cmdline:	The bootup command line.
+ * @system_ram: Total system memory size.
+ * @crash_size: Save the memory size specified by "crashkernel=X[@offset]" or
+ *		"crashkernel=X,high".
+ * @crash_base: Save the base address specified by "crashkernel=X@offset"
+ * @low_size:	Save the memory size specified by "crashkernel=X,low"
+ *
+ * Returns the status flag of the parsing result of "crashkernel=", such as
+ * CRASHKERNEL_MEM_NONE, CRASHKERNEL_MEM_HIGH.
+ */
+static int __init parse_crashkernel_in_order(char *cmdline,
+					     unsigned long long system_ram,
+					     unsigned long long *crash_size,
+					     unsigned long long *crash_base,
+					     unsigned long long *low_size)
+{
+	int ret, flag = CRASHKERNEL_MEM_NONE;
+
+	BUG_ON(!crash_size || !crash_base || !low_size);
+
+	/* crashkernel=X[@offset] */
+	ret = parse_crashkernel(cmdline, system_ram, crash_size, crash_base);
+	if (!ret && crash_size > 0)
+		return CRASHKERNEL_MEM_CLASSIC;
+
+#ifdef CONFIG_64BIT
+	/* crashkernel=X,high */
+	ret = parse_crashkernel_high(cmdline, system_ram, crash_size, crash_base);
+	if (ret || crash_size <= 0)
+		return CRASHKERNEL_MEM_NONE;
+
+	flag = CRASHKERNEL_MEM_HIGH;
+
+	/* crashkernel=Y,low */
+	ret = parse_crashkernel_low(cmdline, system_ram, low_size, crash_base);
+	if (!ret)
+		flag |= CRASHKERNEL_MEM_LOW;
+#endif
+
+	return flag;
+}
+
+void __init reserve_crashkernel(void)
+{
+	unsigned long long crash_size, crash_base, total_mem, low_size;
+	int flag;
+
+	total_mem = memblock_phys_mem_size();
+
+	flag = parse_crashkernel_in_order(boot_command_line, total_mem,
+					  &crash_size, &crash_base, &low_size);
+	if (flag == CRASHKERNEL_MEM_NONE)
+		return;
+
+	if (!crash_base) {
+		/*
+		 * For the case of crashkernel=X[@offset] and offset is omitted,
+		 * try the low memory first.
+		 */
+		if (!(flag & CRASHKERNEL_MEM_HIGH))
+			crash_base = memblock_phys_alloc_range(crash_size,
+						CRASH_ALIGN, CRASH_ALIGN,
+						CRASH_ADDR_LOW_MAX);
+
+		/*
+		 * If low memory allocation failed above, or for the case of
+		 * crashkernel=X,high, try the high memory.
+		 */
+		if (!crash_base)
+			crash_base = memblock_phys_alloc_range(crash_size,
+						CRASH_ALIGN, CRASH_ALIGN,
+						CRASH_ADDR_HIGH_MAX);
+		if (!crash_base) {
+			pr_info("crashkernel reservation failed - No suitable area found.\n");
+			return;
+		}
+	} else {
+		unsigned long long start;
+
+		/*
+		 * The case of crashkernel=X@offset and offset is specified.
+		 * Only user-specified space can be reserved.
+		 */
+		start = memblock_phys_alloc_range(crash_size, SZ_1M, crash_base,
+						  crash_base + crash_size);
+		if (start != crash_base) {
+			pr_info("crashkernel reservation failed - memory is in use.\n");
+			return;
+		}
+	}
+
+#ifdef CONFIG_64BIT
+	if (crash_base >= CRASH_ADDR_LOW_MAX) {
+		/*
+		 * Ensure that at least 256M extra low memory is allocated for
+		 * DMA buffers and swiotlb, if low memory size is not specified.
+		 */
+		if (!(flag & CRASHKERNEL_MEM_LOW)) {
+			/*
+			 * two parts from kernel/dma/swiotlb.c:
+			 * -swiotlb size: user-specified with swiotlb= or default.
+			 *
+			 * -swiotlb overflow buffer: now hardcoded to 32k. We round it
+			 * to 8M for other buffers that may need to stay low too. Also
+			 * make sure we allocate enough extra low memory so that we
+			 * don't run out of DMA buffers for 32-bit devices.
+			 */
+			low_size = max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);
+		}
+
+		if (reserve_crashkernel_low(low_size)) {
+			memblock_phys_free(crash_base, crash_size);
+			return;
+		}
+	}
+#endif
+
+	pr_info("Reserving %ldMB of memory at %ldMB for crashkernel (System RAM: %ldMB)\n",
+		(unsigned long)(crash_size >> 20),
+		(unsigned long)(crash_base >> 20),
+		(unsigned long)(total_mem >> 20));
+
+	crashk_res.start = crash_base;
+	crashk_res.end   = crash_base + crash_size - 1;
+}
+#endif	/* CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL */
+
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len)
 {
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
