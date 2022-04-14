From: Zhen Lei <thunder.leizhen@huawei.com>
Date: Thu, 14 Apr 2022 19:57:15 +0800
Subject: [PATCH v22 4/9] arm64: kdump: Don't force page-level mappings for
 memory above 4G
In-Reply-To: <20220414115720.1887-1-thunder.leizhen@huawei.com>
References: <20220414115720.1887-1-thunder.leizhen@huawei.com>
Message-ID: <20220414115720.1887-5-thunder.leizhen@huawei.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

If the crashkernel reservation is deferred, such boundaries are not known
when the linear mapping is created. But its upper limit is fixed, cannot
above 4G. Therefore, unless otherwise required, block mapping should be
used for memory above 4G to improve performance.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/mm/mmu.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 7666b4955e45cb3..8c6666cbc7f2216 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -504,7 +504,7 @@ static void __init map_mem(pgd_t *pgdp)
 	phys_addr_t kernel_start = __pa_symbol(_stext);
 	phys_addr_t kernel_end = __pa_symbol(__init_begin);
 	phys_addr_t start, end;
-	int flags = NO_EXEC_MAPPINGS;
+	int flags = NO_EXEC_MAPPINGS, eflags = 0;
 	u64 i;
 
 	/*
@@ -530,7 +530,7 @@ static void __init map_mem(pgd_t *pgdp)
 #ifdef CONFIG_KEXEC_CORE
 	if (crash_mem_map &&
 	    (IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32)))
-		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
+		eflags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 	else if (crashk_res.end)
 		memblock_mark_nomap(crashk_res.start,
 				    resource_size(&crashk_res));
@@ -540,13 +540,31 @@ static void __init map_mem(pgd_t *pgdp)
 	for_each_mem_range(i, &start, &end) {
 		if (start >= end)
 			break;
+
+#ifdef CONFIG_KEXEC_CORE
+		if (eflags && (end >= SZ_4G)) {
+			/*
+			 * The memory block cross the 4G boundary.
+			 * Forcibly use page-level mappings for memory under 4G.
+			 */
+			if (start < SZ_4G) {
+				__map_memblock(pgdp, start, SZ_4G - 1,
+					       pgprot_tagged(PAGE_KERNEL), flags | eflags);
+				start  = SZ_4G;
+			}
+
+			/* Page-level mappings is not mandatory for memory above 4G */
+			eflags = 0;
+		}
+#endif
+
 		/*
 		 * The linear map must allow allocation tags reading/writing
 		 * if MTE is present. Otherwise, it has the same attributes as
 		 * PAGE_KERNEL.
 		 */
 		__map_memblock(pgdp, start, end, pgprot_tagged(PAGE_KERNEL),
-			       flags);
+			       flags | eflags);
 	}
 
 	/*
-- 
2.25.1


