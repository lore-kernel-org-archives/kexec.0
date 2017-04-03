Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x229.google.com ([2607:f8b0:400e:c05::229])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1curcO-00049L-Le
 for kexec@lists.infradead.org; Mon, 03 Apr 2017 02:21:24 +0000
Received: by mail-pg0-x229.google.com with SMTP id x125so105465284pgb.0
 for <kexec@lists.infradead.org>; Sun, 02 Apr 2017 19:21:00 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v35 02/14] memblock: add memblock_cap_memory_range()
Date: Mon,  3 Apr 2017 11:23:55 +0900
Message-Id: <20170403022355.12463-2-takahiro.akashi@linaro.org>
In-Reply-To: <20170403022139.12383-1-takahiro.akashi@linaro.org>
References: <20170403022139.12383-1-takahiro.akashi@linaro.org>
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
To: catalin.marinas@arm.com, will.deacon@arm.com, akpm@linux-foundation.org
Cc: mark.rutland@arm.com, panand@redhat.com, ard.biesheuvel@linaro.org, geoff@infradead.org, dwmw2@infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, kexec@lists.infradead.org, linux-mm@kvack.org, james.morse@arm.com, bauerman@linux.vnet.ibm.com, sgoel@codeaurora.org, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org

Add memblock_cap_memory_range() which will remove all the memblock regions
except the memory range specified in the arguments. In addition, rework is
done on memblock_mem_limit_remove_map() to re-implement it using
memblock_cap_memory_range().

This function, like memblock_mem_limit_remove_map(), will not remove
memblocks with MEMMAP_NOMAP attribute as they may be mapped and accessed
later as "device memory."
See the commit a571d4eb55d8 ("mm/memblock.c: add new infrastructure to
address the mem limit issue").

This function is used, in a succeeding patch in the series of arm64 kdump
suuport, to limit the range of usable memory, or System RAM, on crash dump
kernel.
(Please note that "mem=" parameter is of little use for this purpose.)

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Will Deacon <will.deacon@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Dennis Chen <dennis.chen@arm.com>
Cc: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 include/linux/memblock.h |  1 +
 mm/memblock.c            | 44 +++++++++++++++++++++++++++++---------------
 2 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index e82daffcfc44..4ce24a376262 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -336,6 +336,7 @@ phys_addr_t memblock_mem_size(unsigned long limit_pfn);
 phys_addr_t memblock_start_of_DRAM(void);
 phys_addr_t memblock_end_of_DRAM(void);
 void memblock_enforce_memory_limit(phys_addr_t memory_limit);
+void memblock_cap_memory_range(phys_addr_t base, phys_addr_t size);
 void memblock_mem_limit_remove_map(phys_addr_t limit);
 bool memblock_is_memory(phys_addr_t addr);
 int memblock_is_map_memory(phys_addr_t addr);
diff --git a/mm/memblock.c b/mm/memblock.c
index 2f4ca8104ea4..b049c9b2dba8 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1543,11 +1543,37 @@ void __init memblock_enforce_memory_limit(phys_addr_t limit)
 			      (phys_addr_t)ULLONG_MAX);
 }
 
+void __init memblock_cap_memory_range(phys_addr_t base, phys_addr_t size)
+{
+	int start_rgn, end_rgn;
+	int i, ret;
+
+	if (!size)
+		return;
+
+	ret = memblock_isolate_range(&memblock.memory, base, size,
+						&start_rgn, &end_rgn);
+	if (ret)
+		return;
+
+	/* remove all the MAP regions */
+	for (i = memblock.memory.cnt - 1; i >= end_rgn; i--)
+		if (!memblock_is_nomap(&memblock.memory.regions[i]))
+			memblock_remove_region(&memblock.memory, i);
+
+	for (i = start_rgn - 1; i >= 0; i--)
+		if (!memblock_is_nomap(&memblock.memory.regions[i]))
+			memblock_remove_region(&memblock.memory, i);
+
+	/* truncate the reserved regions */
+	memblock_remove_range(&memblock.reserved, 0, base);
+	memblock_remove_range(&memblock.reserved,
+			base + size, (phys_addr_t)ULLONG_MAX);
+}
+
 void __init memblock_mem_limit_remove_map(phys_addr_t limit)
 {
-	struct memblock_type *type = &memblock.memory;
 	phys_addr_t max_addr;
-	int i, ret, start_rgn, end_rgn;
 
 	if (!limit)
 		return;
@@ -1558,19 +1584,7 @@ void __init memblock_mem_limit_remove_map(phys_addr_t limit)
 	if (max_addr == (phys_addr_t)ULLONG_MAX)
 		return;
 
-	ret = memblock_isolate_range(type, max_addr, (phys_addr_t)ULLONG_MAX,
-				&start_rgn, &end_rgn);
-	if (ret)
-		return;
-
-	/* remove all the MAP regions above the limit */
-	for (i = end_rgn - 1; i >= start_rgn; i--) {
-		if (!memblock_is_nomap(&type->regions[i]))
-			memblock_remove_region(type, i);
-	}
-	/* truncate the reserved regions */
-	memblock_remove_range(&memblock.reserved, max_addr,
-			      (phys_addr_t)ULLONG_MAX);
+	memblock_cap_memory_range(0, max_addr);
 }
 
 static int __init_memblock memblock_search(struct memblock_type *type, phys_addr_t addr)
-- 
2.11.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
