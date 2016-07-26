Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bRxAo-0000Xv-VE
 for kexec@lists.infradead.org; Tue, 26 Jul 2016 07:53:11 +0000
Received: by mail-pf0-x231.google.com with SMTP id p64so72942066pfb.1
 for <kexec@lists.infradead.org>; Tue, 26 Jul 2016 00:52:46 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v23 2/9] memblock: add memblock_cap_memory_range()
Date: Tue, 26 Jul 2016 16:56:53 +0900
Message-Id: <20160726075659.2290-3-takahiro.akashi@linaro.org>
In-Reply-To: <20160726075659.2290-1-takahiro.akashi@linaro.org>
References: <20160726075659.2290-1-takahiro.akashi@linaro.org>
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
To: catalin.marinas@arm.com, will.deacon@arm.com
Cc: mark.rutland@arm.com, geoff@infradead.org, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 include/linux/memblock.h |  1 +
 mm/memblock.c            | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 3106ac1..9ab17a9 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -333,6 +333,7 @@ phys_addr_t memblock_mem_size(unsigned long limit_pfn);
 phys_addr_t memblock_start_of_DRAM(void);
 phys_addr_t memblock_end_of_DRAM(void);
 void memblock_enforce_memory_limit(phys_addr_t memory_limit);
+void memblock_cap_memory_range(phys_addr_t base, phys_addr_t size);
 bool memblock_is_memory(phys_addr_t addr);
 int memblock_is_map_memory(phys_addr_t addr);
 int memblock_is_region_memory(phys_addr_t base, phys_addr_t size);
diff --git a/mm/memblock.c b/mm/memblock.c
index ac12489..30badf1 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1486,6 +1486,34 @@ void __init memblock_enforce_memory_limit(phys_addr_t limit)
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
 static int __init_memblock memblock_search(struct memblock_type *type, phys_addr_t addr)
 {
 	unsigned int left = 0, right = type->cnt;
-- 
2.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
