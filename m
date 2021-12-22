Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v18 16/17] of: fdt: Add memory for devices by DT property
 "linux, usable-memory-range"
Date: Wed, 22 Dec 2021 21:08:19 +0800
Message-ID: <20211222130820.1754-17-thunder.leizhen@huawei.com>
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

When reserving crashkernel in high memory, some low memory is reserved
for crash dump kernel devices and never mapped by the first kernel.
This memory range is advertised to crash dump kernel via DT property
under /chosen,
        linux,usable-memory-range = <BASE1 SIZE1 [BASE2 SIZE2]>

We reused the DT property linux,usable-memory-range and made the low
memory region as the second range "BASE2 SIZE2", which keeps compatibility
with existing user-space and older kdump kernels.

Crash dump kernel reads this property at boot time and call memblock_add()
to add the low memory region after memblock_cap_memory_range() has been
called.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
Co-developed-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>
---
 drivers/of/fdt.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 37b477a51175359..f7b72fa773250ad 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -967,6 +967,15 @@ static void __init early_init_dt_check_for_elfcorehdr(unsigned long node)
 
 static unsigned long chosen_node_offset = -FDT_ERR_NOTFOUND;
 
+/*
+ * The main usage of linux,usable-memory-range is for crash dump kernel.
+ * Originally, the number of usable-memory regions is one. Now there may
+ * be two regions, low region and high region.
+ * To make compatibility with existing user-space and older kdump, the low
+ * region is always the last range of linux,usable-memory-range if exist.
+ */
+#define MAX_USABLE_RANGES		2
+
 /**
  * early_init_dt_check_for_usable_mem_range - Decode usable memory range
  * location from flat tree
@@ -974,10 +983,9 @@ static unsigned long chosen_node_offset = -FDT_ERR_NOTFOUND;
  */
 static void __init early_init_dt_check_for_usable_mem_range(unsigned long node)
 {
-	const __be32 *prop;
-	int len;
-	phys_addr_t cap_mem_addr;
-	phys_addr_t cap_mem_size;
+	struct memblock_region rgn[MAX_USABLE_RANGES] = {0};
+	const __be32 *prop, *endp;
+	int len, i;
 
 	if ((long)node < 0)
 		return;
@@ -985,16 +993,21 @@ static void __init early_init_dt_check_for_usable_mem_range(unsigned long node)
 	pr_debug("Looking for usable-memory-range property... ");
 
 	prop = of_get_flat_dt_prop(node, "linux,usable-memory-range", &len);
-	if (!prop || (len < (dt_root_addr_cells + dt_root_size_cells)))
+	if (!prop || (len % (dt_root_addr_cells + dt_root_size_cells)))
 		return;
 
-	cap_mem_addr = dt_mem_next_cell(dt_root_addr_cells, &prop);
-	cap_mem_size = dt_mem_next_cell(dt_root_size_cells, &prop);
+	endp = prop + (len / sizeof(__be32));
+	for (i = 0; i < MAX_USABLE_RANGES && prop < endp; i++) {
+		rgn[i].base = dt_mem_next_cell(dt_root_addr_cells, &prop);
+		rgn[i].size = dt_mem_next_cell(dt_root_size_cells, &prop);
 
-	pr_debug("cap_mem_start=%pa cap_mem_size=%pa\n", &cap_mem_addr,
-		 &cap_mem_size);
+		pr_debug("cap_mem_regions[%d]: base=%pa, size=%pa\n",
+			 i, &rgn[i].base, &rgn[i].size);
+	}
 
-	memblock_cap_memory_range(cap_mem_addr, cap_mem_size);
+	memblock_cap_memory_range(rgn[0].base, rgn[0].size);
+	for (i = 1; i < MAX_USABLE_RANGES && rgn[i].size; i++)
+		memblock_add(rgn[i].base, rgn[i].size);
 }
 
 #ifdef CONFIG_SERIAL_EARLYCON
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
