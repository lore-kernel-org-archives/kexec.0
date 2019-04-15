Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Chen Zhou <chenzhou10@huawei.com>
Subject: [PATCH v4 3/5] memblock: add memblock_cap_memory_ranges for multiple
 ranges
Date: Mon, 15 Apr 2019 18:57:23 +0800
Message-ID: <20190415105725.22088-4-chenzhou10@huawei.com>
In-Reply-To: <20190415105725.22088-1-chenzhou10@huawei.com>
References: <20190415105725.22088-1-chenzhou10@huawei.com>
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

The memblock_cap_memory_range() removes all the memory except the
range passed to it. Extend this function to receive memblock_type
with the regions that should be kept.

Enable this function in arm64 for reservation of multiple regions
for the crash kernel.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 include/linux/memblock.h |  1 +
 mm/memblock.c            | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 47e3c06..180877c 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -446,6 +446,7 @@ phys_addr_t memblock_start_of_DRAM(void);
 phys_addr_t memblock_end_of_DRAM(void);
 void memblock_enforce_memory_limit(phys_addr_t memory_limit);
 void memblock_cap_memory_range(phys_addr_t base, phys_addr_t size);
+void memblock_cap_memory_ranges(struct memblock_type *regions_to_keep);
 void memblock_mem_limit_remove_map(phys_addr_t limit);
 bool memblock_is_memory(phys_addr_t addr);
 bool memblock_is_map_memory(phys_addr_t addr);
diff --git a/mm/memblock.c b/mm/memblock.c
index f315eca..9661807 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1697,6 +1697,51 @@ void __init memblock_cap_memory_range(phys_addr_t base, phys_addr_t size)
 			base + size, PHYS_ADDR_MAX);
 }
 
+void __init memblock_cap_memory_ranges(struct memblock_type *regions_to_keep)
+{
+	int start_rgn[INIT_MEMBLOCK_REGIONS], end_rgn[INIT_MEMBLOCK_REGIONS];
+	int i, j, ret, nr = 0;
+	struct memblock_region *regs = regions_to_keep->regions;
+
+	for (i = 0; i < regions_to_keep->cnt; i++) {
+		ret = memblock_isolate_range(&memblock.memory, regs[i].base,
+				regs[i].size, &start_rgn[i], &end_rgn[i]);
+		if (ret)
+			break;
+		nr++;
+	}
+	if (!nr)
+		return;
+
+	/* remove all the MAP regions */
+	for (i = memblock.memory.cnt - 1; i >= end_rgn[nr - 1]; i--)
+		if (!memblock_is_nomap(&memblock.memory.regions[i]))
+			memblock_remove_region(&memblock.memory, i);
+
+	for (i = nr - 1; i > 0; i--)
+		for (j = start_rgn[i] - 1; j >= end_rgn[i - 1]; j--)
+			if (!memblock_is_nomap(&memblock.memory.regions[j]))
+				memblock_remove_region(&memblock.memory, j);
+
+	for (i = start_rgn[0] - 1; i >= 0; i--)
+		if (!memblock_is_nomap(&memblock.memory.regions[i]))
+			memblock_remove_region(&memblock.memory, i);
+
+	/* truncate the reserved regions */
+	memblock_remove_range(&memblock.reserved, 0, regs[0].base);
+
+	for (i = nr - 1; i > 0; i--) {
+		phys_addr_t remove_base = regs[i - 1].base + regs[i - 1].size;
+		phys_addr_t remove_size = regs[i].base - remove_base;
+
+		memblock_remove_range(&memblock.reserved, remove_base,
+				remove_size);
+	}
+
+	memblock_remove_range(&memblock.reserved,
+			regs[nr - 1].base + regs[nr - 1].size, PHYS_ADDR_MAX);
+}
+
 void __init memblock_mem_limit_remove_map(phys_addr_t limit)
 {
 	phys_addr_t max_addr;
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
