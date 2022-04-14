From: Zhen Lei <thunder.leizhen@huawei.com>
Date: Thu, 14 Apr 2022 19:57:17 +0800
Subject: [PATCH v22 6/9] arm64: kdump: Use page-level mapping for the high
 memory of crashkernel
In-Reply-To: <20220414115720.1887-1-thunder.leizhen@huawei.com>
References: <20220414115720.1887-1-thunder.leizhen@huawei.com>
Message-ID: <20220414115720.1887-7-thunder.leizhen@huawei.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

If the crashkernel has both high memory above 4G and low memory under 4G,
kexec always loads the content such as Imge and dtb to the high memory
instead of the low memory. This means that only high memory requires write
protection based on page-level mapping. The allocation of high memory does
not depend on the DMA boundary. So we can reserve the high memory first
even if the crashkernel reservation is deferred.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/mm/init.c | 84 ++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/mm/mmu.c  |  3 +-
 2 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 99d5539c13de3b1..b1b40b900fae170 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -90,6 +90,9 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit;
 phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
 #endif
 
+static bool crash_high_mem_reserved __initdata;
+static struct resource crashk_res_high;
+
 /* Current arm64 boot protocol requires 2MB alignment */
 #define CRASH_ALIGN			SZ_2M
 
@@ -128,6 +131,66 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
 	return 0;
 }
 
+static void __init reserve_crashkernel_high(void)
+{
+	unsigned long long crash_base, crash_size;
+	char *cmdline = boot_command_line;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
+		return;
+
+	/* crashkernel=X[@offset] */
+	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
+				&crash_size, &crash_base);
+	if (ret || !crash_size) {
+		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
+		if (ret || !crash_size)
+			return;
+	}
+
+	crash_size = PAGE_ALIGN(crash_size);
+
+	/*
+	 * For the case crashkernel=X, may fall back to reserve memory above
+	 * 4G, make reservations here in advance. It will be released later if
+	 * the region is successfully reserved under 4G.
+	 */
+	if (!crash_base) {
+		crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
+						       crash_base, CRASH_ADDR_HIGH_MAX);
+		if (!crash_base)
+			return;
+
+		crash_high_mem_reserved = true;
+	}
+
+	/* Mark the memory range that requires page-level mappings */
+	crashk_res.start = crash_base;
+	crashk_res.end   = crash_base + crash_size - 1;
+}
+
+static void __init hand_over_reserved_high_mem(void)
+{
+	crashk_res_high.start = crashk_res.start;
+	crashk_res_high.end   = crashk_res.end;
+
+	crashk_res.start = 0;
+	crashk_res.end   = 0;
+}
+
+static void __init take_reserved_high_mem(unsigned long long *crash_base,
+					  unsigned long long *crash_size)
+{
+	*crash_base = crashk_res_high.start;
+	*crash_size = resource_size(&crashk_res_high);
+}
+
+static void __init free_reserved_high_mem(void)
+{
+	memblock_phys_free(crashk_res_high.start, resource_size(&crashk_res_high));
+}
+
 /*
  * reserve_crashkernel() - reserves memory for crash kernel
  *
@@ -159,6 +222,8 @@ static void __init reserve_crashkernel(void)
 	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
 		return;
 
+	hand_over_reserved_high_mem();
+
 	/* crashkernel=X[@offset] */
 	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
 				&crash_size, &crash_base);
@@ -177,6 +242,11 @@ static void __init reserve_crashkernel(void)
 
 		high = true;
 		crash_max = CRASH_ADDR_HIGH_MAX;
+
+		if (crash_high_mem_reserved) {
+			take_reserved_high_mem(&crash_base, &crash_size);
+			goto reserve_low;
+		}
 	}
 
 	fixed_base = !!crash_base;
@@ -195,6 +265,11 @@ static void __init reserve_crashkernel(void)
 		 * reserved later.
 		 */
 		if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
+			if (crash_high_mem_reserved) {
+				take_reserved_high_mem(&crash_base, &crash_size);
+				goto reserve_low;
+			}
+
 			crash_max = CRASH_ADDR_HIGH_MAX;
 			goto retry;
 		}
@@ -212,6 +287,7 @@ static void __init reserve_crashkernel(void)
 	 * condition to make sure the crash low memory will be reserved.
 	 */
 	if ((crash_base >= CRASH_ADDR_LOW_MAX) || high) {
+reserve_low:
 		/* case #3 of crashkernel,low reservation */
 		if (!high)
 			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
@@ -220,6 +296,12 @@ static void __init reserve_crashkernel(void)
 			memblock_phys_free(crash_base, crash_size);
 			return;
 		}
+	} else if (crash_high_mem_reserved) {
+		/*
+		 * The crash memory is successfully allocated under 4G, and the
+		 * previously reserved high memory is no longer required.
+		 */
+		free_reserved_high_mem();
 	}
 
 	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
@@ -437,6 +519,8 @@ void __init arm64_memblock_init(void)
 
 	if (!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32))
 		reserve_crashkernel();
+	else
+		reserve_crashkernel_high();
 
 	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
 }
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 8c6666cbc7f2216..f84eca55b103d0c 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -531,7 +531,8 @@ static void __init map_mem(pgd_t *pgdp)
 	if (crash_mem_map &&
 	    (IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32)))
 		eflags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
-	else if (crashk_res.end)
+
+	if (crashk_res.end)
 		memblock_mark_nomap(crashk_res.start,
 				    resource_size(&crashk_res));
 #endif
-- 
2.25.1


