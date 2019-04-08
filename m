Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH 2/3] arm64: kdump: support more than one crash kernel
 regions
References: <20190403030546.23718-1-chenzhou10@huawei.com>
 <20190403030546.23718-3-chenzhou10@huawei.com>
 <20190403112929.GA7715@rapoport-lnx>
 <f98a5559-3659-fb35-3765-15861e70a796@huawei.com>
 <20190404144408.GA6433@rapoport-lnx>
 <783b8712-ddb1-a52b-81ee-0c6a216e5b7d@huawei.com>
 <4b188535-c12d-e05b-9154-2c2d580f903b@huawei.com>
 <20190408065711.GA8403@rapoport-lnx>
 <3fc772a2-292b-9c2a-465f-eabe86961dfd@huawei.com>
From: Chen Zhou <chenzhou10@huawei.com>
Message-ID: <2aadfb89-4ac0-a9a9-e157-a23d686cb374@huawei.com>
Date: Mon, 8 Apr 2019 23:38:41 +0800
MIME-Version: 1.0
In-Reply-To: <3fc772a2-292b-9c2a-465f-eabe86961dfd@huawei.com>
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
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: wangkefeng.wang@huawei.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, takahiro.akashi@linaro.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi Mike,

On 2019/4/8 16:39, Chen Zhou wrote:

>>>
>>> Sorry, just ignore my previous reply, I got that wrong.
>>>
>>> I think it carefully, we can cap the memory range for [min(regs[*].start, max(regs[*].end)]
>>> firstly. But how to remove the middle ranges, we still can't use memblock_cap_memory_range()
>>> directly and the extra remove operation may be complex.
>>>
>>> For more than one regions, i think add a new memblock_cap_memory_ranges() may be better.
>>> Besides, memblock_cap_memory_ranges() is also applicable for one region.
>>>
>>> How about replace memblock_cap_memory_range() with memblock_cap_memory_ranges()?
>>
>> arm64 is the only user of both MEMBLOCK_NOMAP and memblock_cap_memory_range()
>> and I don't expect other architectures will use these interfaces.
>> It seems that capping the memory for arm64 crash kernel the way I've
>> suggested can be implemented in fdt_enforce_memory_region(). If we'd ever
>> need such functionality elsewhere or CRASH_MAX_USABLE_RANGES will need to
>> grow we'll rethink the solution.
> 
> Ok, i will implement that in fdt_enforce_memory_region() in next version.
> And we will support at most two crash kernel regions now.
> 
> Thanks,
> Chen Zhou
> 

I implement that in fdt_enforce_memory_region() simply as below.
You have a look at if it is the way you suggested.

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index f9fa5f8..52bd69db 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -65,6 +65,11 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;

 #ifdef CONFIG_KEXEC_CORE

+/* at most two crash kernel regions, low_region and high_region */
+#define CRASH_MAX_USABLE_RANGES        2
+#define LOW_REGION_IDX                 0
+#define HIGH_REGION_IDX                        1
+
 /*
  * reserve_crashkernel() - reserves memory for crash kernel
  *
@@ -296,8 +301,8 @@ static int __init early_init_dt_scan_usablemem(unsigned long node,
                const char *uname, int depth, void *data)
 {
        struct memblock_region *usablemem = data;
-       const __be32 *reg;
-       int len;
+       const __be32 *reg, *endp;
+       int len, nr = 0;

        if (depth != 1 || strcmp(uname, "chosen") != 0)
                return 0;
@@ -306,22 +311,62 @@ static int __init early_init_dt_scan_usablemem(unsigned long node,
        if (!reg || (len < (dt_root_addr_cells + dt_root_size_cells)))
                return 1;

-       usablemem->base = dt_mem_next_cell(dt_root_addr_cells, &reg);
-       usablemem->size = dt_mem_next_cell(dt_root_size_cells, &reg);
+       endp = reg + (len / sizeof(__be32));
+       while ((endp - reg) >= (dt_root_addr_cells + dt_root_size_cells)) {
+               usablemem[nr].base = dt_mem_next_cell(dt_root_addr_cells, &reg);
+               usablemem[nr].size = dt_mem_next_cell(dt_root_size_cells, &reg);
+
+               if (++nr >= CRASH_MAX_USABLE_RANGES)
+                       break;
+       }

        return 1;
 }

 static void __init fdt_enforce_memory_region(void)
 {
-       struct memblock_region reg = {
-               .size = 0,
-       };
+       int i, cnt = 0;
+       struct memblock_region regs[CRASH_MAX_USABLE_RANGES];
+
+       memset(regs, 0, sizeof(regs));
+       of_scan_flat_dt(early_init_dt_scan_usablemem, regs);
+
+       for (i = 0; i < CRASH_MAX_USABLE_RANGES; i++)
+               if (regs[i].size)
+                       cnt++;
+               else
+                       break;
+
+       if (cnt - 1 == LOW_REGION_IDX)
+               memblock_cap_memory_range(regs[LOW_REGION_IDX].base,
+                               regs[LOW_REGION_IDX].size);
+       else if (cnt - 1 == HIGH_REGION_IDX) {
+               /*
+                * Two crash kernel regions, cap the memory range
+                * [regs[LOW_REGION_IDX].base, regs[HIGH_REGION_IDX].end]
+                * and then remove the memory range in the middle.
+                */
+               int start_rgn, end_rgn, i, ret;
+               phys_addr_t mid_base, mid_size;
+
+               mid_base = regs[LOW_REGION_IDX].base + regs[LOW_REGION_IDX].size;
+               mid_size = regs[HIGH_REGION_IDX].base - mid_base;
+               ret = memblock_isolate_range(&memblock.memory, mid_base, mid_size,
+                               &start_rgn, &end_rgn);

-       of_scan_flat_dt(early_init_dt_scan_usablemem, &reg);
+               if (ret)
+                       return;

-       if (reg.size)
-               memblock_cap_memory_range(reg.base, reg.size);
+               memblock_cap_memory_range(regs[LOW_REGION_IDX].base,
+                               regs[HIGH_REGION_IDX].base - regs[LOW_REGION_IDX].base +
+                               regs[HIGH_REGION_IDX].size);
+               for (i = end_rgn - 1; i >= start_rgn; i--) {
+                       if (!memblock_is_nomap(&memblock.memory.regions[i]))
+                               memblock_remove_region(&memblock.memory, i);
+               }
+               memblock_remove_range(&memblock.reserved, mid_base,
+                               mid_base + mid_size);
+       }
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
+                                       phys_addr_t base, phys_addr_t size,
+                                       int *start_rgn, int *end_rgn);
+int memblock_remove_range(struct memblock_type *type,
+                                       phys_addr_t base, phys_addr_t size);
 int memblock_remove(phys_addr_t base, phys_addr_t size);
 int memblock_free(phys_addr_t base, phys_addr_t size);
 int memblock_reserve(phys_addr_t base, phys_addr_t size);
diff --git a/mm/memblock.c b/mm/memblock.c
index e7665cf..7130c3a 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -357,7 +357,7 @@ phys_addr_t __init_memblock memblock_find_in_range(phys_addr_t start,
        return ret;
 }

-static void __init_memblock memblock_remove_region(struct memblock_type *type, unsigned long r)
+void __init_memblock memblock_remove_region(struct memblock_type *type, unsigned long r)
 {
        type->total_size -= type->regions[r].size;
        memmove(&type->regions[r], &type->regions[r + 1],
@@ -724,7 +724,7 @@ int __init_memblock memblock_add(phys_addr_t base, phys_addr_t size)
  * Return:
  * 0 on success, -errno on failure.
  */
-static int __init_memblock memblock_isolate_range(struct memblock_type *type,
+int __init_memblock memblock_isolate_range(struct memblock_type *type,
                                        phys_addr_t base, phys_addr_t size,
                                        int *start_rgn, int *end_rgn)
 {
@@ -784,7 +784,7 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
        return 0;
 }

-static int __init_memblock memblock_remove_range(struct memblock_type *type,
+int __init_memblock memblock_remove_range(struct memblock_type *type,
                                          phys_addr_t base, phys_addr_t size)
 {
        int start_rgn, end_rgn;


Thanks,
Chen Zhou



> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> .
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
