From: Zhen Lei <thunder.leizhen@huawei.com>
Date: Thu, 14 Apr 2022 19:57:18 +0800
Subject: [PATCH v22 7/9] arm64: kdump: Try not to use NO_BLOCK_MAPPINGS for
 memory under 4G
In-Reply-To: <20220414115720.1887-1-thunder.leizhen@huawei.com>
References: <20220414115720.1887-1-thunder.leizhen@huawei.com>
Message-ID: <20220414115720.1887-8-thunder.leizhen@huawei.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

For the case crashkernel=X at offset and crashkernel=X,high, we've explicitly
used 'crashk_res' to mark the scope of the page-level mapping required, so
NO_BLOCK_MAPPINGS should not be required for other areas. Otherwise,
system performance will be affected. In fact, only the case crashkernel=X
requires page-level mapping for all low memory under 4G because it
attempts high memory after it fails to request low memory first, and we
cannot predict its final location.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/include/asm/kexec.h |  2 ++
 arch/arm64/mm/init.c           |  3 +++
 arch/arm64/mm/mmu.c            | 18 +-----------------
 3 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 9839bfc163d7147..8caf64065383844 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -80,6 +80,8 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
 	}
 }
 
+extern bool crash_low_mem_page_map;
+
 #if defined(CONFIG_KEXEC_CORE) && defined(CONFIG_HIBERNATION)
 extern bool crash_is_nosave(unsigned long pfn);
 extern void crash_prepare_suspend(void);
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index b1b40b900fae170..d9676e30f9b657a 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -90,6 +90,7 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit;
 phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
 #endif
 
+bool crash_low_mem_page_map __initdata;
 static bool crash_high_mem_reserved __initdata;
 static struct resource crashk_res_high;
 
@@ -147,6 +148,8 @@ static void __init reserve_crashkernel_high(void)
 		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
 		if (ret || !crash_size)
 			return;
+	} else if (!crash_base) {
+		crash_low_mem_page_map = true;
 	}
 
 	crash_size = PAGE_ALIGN(crash_size);
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index f84eca55b103d0c..56a973cb4c9cae6 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -483,21 +483,6 @@ void __init mark_linear_text_alias_ro(void)
 			    PAGE_KERNEL_RO);
 }
 
-static bool crash_mem_map __initdata;
-
-static int __init enable_crash_mem_map(char *arg)
-{
-	/*
-	 * Proper parameter parsing is done by reserve_crashkernel(). We only
-	 * need to know if the linear map has to avoid block mappings so that
-	 * the crashkernel reservations can be unmapped later.
-	 */
-	crash_mem_map = true;
-
-	return 0;
-}
-early_param("crashkernel", enable_crash_mem_map);
-
 static void __init map_mem(pgd_t *pgdp)
 {
 	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
@@ -528,8 +513,7 @@ static void __init map_mem(pgd_t *pgdp)
 	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
 
 #ifdef CONFIG_KEXEC_CORE
-	if (crash_mem_map &&
-	    (IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32)))
+	if (crash_low_mem_page_map)
 		eflags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
 	if (crashk_res.end)
-- 
2.25.1


