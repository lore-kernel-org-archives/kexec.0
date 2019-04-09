Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Chen Zhou <chenzhou10@huawei.com>
Subject: [PATCH v3 3/4] arm64: kdump: support more than one crash kernel
 regions
Date: Tue, 9 Apr 2019 18:28:18 +0800
Message-ID: <20190409102819.121335-4-chenzhou10@huawei.com>
In-Reply-To: <20190409102819.121335-1-chenzhou10@huawei.com>
References: <20190409102819.121335-1-chenzhou10@huawei.com>
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
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, ebiederm@xmission.com, rppt@linux.ibm.com, catalin.marinas@arm.com, will.deacon@arm.com, akpm@linux-foundation.org, ard.biesheuvel@linaro.org
Cc: wangkefeng.wang@huawei.com, linux-mm@kvack.org, Chen Zhou <chenzhou10@huawei.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, takahiro.akashi@linaro.org, horms@verge.net.au, linux-arm-kernel@lists.infradead.org

After commit (arm64: kdump: support reserving crashkernel above 4G),
there may be two crash kernel regions, one is below 4G, the other is
above 4G.

Crash dump kernel reads more than one crash kernel regions via a dtb
property under node /chosen,
linux,usable-memory-range = <BASE1 SIZE1 [BASE2 SIZE2]>

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 arch/arm64/mm/init.c     | 66 ++++++++++++++++++++++++++++++++++++++++--------
 include/linux/memblock.h |  6 +++++
 mm/memblock.c            |  7 ++---
 3 files changed, 66 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 3bebddf..0f18665 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -65,6 +65,11 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
 
 #ifdef CONFIG_KEXEC_CORE
 
+/* at most two crash kernel regions, low_region and high_region */
+#define CRASH_MAX_USABLE_RANGES	2
+#define LOW_REGION_IDX			0
+#define HIGH_REGION_IDX			1
+
 /*
  * reserve_crashkernel() - reserves memory for crash kernel
  *
@@ -297,8 +302,8 @@ static int __init early_init_dt_scan_usablemem(unsigned long node,
 		const char *uname, int depth, void *data)
 {
 	struct memblock_region *usablemem = data;
-	const __be32 *reg;
-	int len;
+	const __be32 *reg, *endp;
+	int len, nr = 0;
 
 	if (depth != 1 || strcmp(uname, "chosen") != 0)
 		return 0;
@@ -307,22 +312,63 @@ static int __init early_init_dt_scan_usablemem(unsigned long node,
 	if (!reg || (len < (dt_root_addr_cells + dt_root_size_cells)))
 		return 1;
 
-	usablemem->base = dt_mem_next_cell(dt_root_addr_cells, &reg);
-	usablemem->size = dt_mem_next_cell(dt_root_size_cells, &reg);
+	endp = reg + (len / sizeof(__be32));
+	while ((endp - reg) >= (dt_root_addr_cells + dt_root_size_cells)) {
+		usablemem[nr].base = dt_mem_next_cell(dt_root_addr_cells, &reg);
+		usablemem[nr].size = dt_mem_next_cell(dt_root_size_cells, &reg);
+
+		if (++nr >= CRASH_MAX_USABLE_RANGES)
+			break;
+	}
 
 	return 1;
 }
 
 static void __init fdt_enforce_memory_region(void)
 {
-	struct memblock_region reg = {
-		.size = 0,
-	};
+	int i, cnt = 0;
+	struct memblock_region regs[CRASH_MAX_USABLE_RANGES];
+
+	memset(regs, 0, sizeof(regs));
+	of_scan_flat_dt(early_init_dt_scan_usablemem, regs);
+
+	for (i = 0; i < CRASH_MAX_USABLE_RANGES; i++)
+		if (regs[i].size)
+			cnt++;
+		else
+			break;
+
+	if (cnt - 1 == LOW_REGION_IDX)
+		memblock_cap_memory_range(regs[LOW_REGION_IDX].base,
+				regs[LOW_REGION_IDX].size);
+	else if (cnt - 1 == HIGH_REGION_IDX) {
+		/*
+		 * Two crash kernel regions, cap the memory range
+		 * [regs[LOW_REGION_IDX].base, regs[HIGH_REGION_IDX].end]
+		 * and then remove the memory range in the middle.
+		 */
+		int start_rgn, end_rgn, i, ret;
+		phys_addr_t mid_base, mid_size;
+
+		mid_base = regs[LOW_REGION_IDX].base + regs[LOW_REGION_IDX].size;
+		mid_size = regs[HIGH_REGION_IDX].base - mid_base;
+		ret = memblock_isolate_range(&memblock.memory, mid_base,
+				mid_size, &start_rgn, &end_rgn);
 
-	of_scan_flat_dt(early_init_dt_scan_usablemem, &reg);
+		if (ret)
+			return;
 
-	if (reg.size)
-		memblock_cap_memory_range(reg.base, reg.size);
+		memblock_cap_memory_range(regs[LOW_REGION_IDX].base,
+				regs[HIGH_REGION_IDX].base -
+				regs[LOW_REGION_IDX].base +
+				regs[HIGH_REGION_IDX].size);
+		for (i = end_rgn - 1; i >= start_rgn; i--) {
+			if (!memblock_is_nomap(&memblock.memory.regions[i]))
+				memblock_remove_region(&memblock.memory, i);
+		}
+		memblock_remove_range(&memblock.reserved, mid_base,
+				mid_base + mid_size);
+	}
 }
 
 void __init arm64_memblock_init(void)
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 294d5d8..787d252 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -110,9 +110,15 @@ void memblock_discard(void);
 
 phys_addr_t memblock_find_in_range(phys_addr_t start, phys_addr_t end,
 				   phys_addr_t size, phys_addr_t align);
+void memblock_remove_region(struct memblock_type *type, unsigned long r);
 void memblock_allow_resize(void);
 int memblock_add_node(phys_addr_t base, phys_addr_t size, int nid);
 int memblock_add(phys_addr_t base, phys_addr_t size);
+int memblock_isolate_range(struct memblock_type *type,
+					phys_addr_t base, phys_addr_t size,
+					int *start_rgn, int *end_rgn);
+int memblock_remove_range(struct memblock_type *type,
+					phys_addr_t base, phys_addr_t size);
 int memblock_remove(phys_addr_t base, phys_addr_t size);
 int memblock_free(phys_addr_t base, phys_addr_t size);
 int memblock_reserve(phys_addr_t base, phys_addr_t size);
diff --git a/mm/memblock.c b/mm/memblock.c
index e7665cf..1846e2d 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -357,7 +357,8 @@ phys_addr_t __init_memblock memblock_find_in_range(phys_addr_t start,
 	return ret;
 }
 
-static void __init_memblock memblock_remove_region(struct memblock_type *type, unsigned long r)
+void __init_memblock memblock_remove_region(struct memblock_type *type,
+					unsigned long r)
 {
 	type->total_size -= type->regions[r].size;
 	memmove(&type->regions[r], &type->regions[r + 1],
@@ -724,7 +725,7 @@ int __init_memblock memblock_add(phys_addr_t base, phys_addr_t size)
  * Return:
  * 0 on success, -errno on failure.
  */
-static int __init_memblock memblock_isolate_range(struct memblock_type *type,
+int __init_memblock memblock_isolate_range(struct memblock_type *type,
 					phys_addr_t base, phys_addr_t size,
 					int *start_rgn, int *end_rgn)
 {
@@ -784,7 +785,7 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
 	return 0;
 }
 
-static int __init_memblock memblock_remove_range(struct memblock_type *type,
+int __init_memblock memblock_remove_range(struct memblock_type *type,
 					  phys_addr_t base, phys_addr_t size)
 {
 	int start_rgn, end_rgn;
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
