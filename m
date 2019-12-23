Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Chen Zhou <chenzhou10@huawei.com>
Subject: [PATCH v7 3/4] arm64: kdump: add memory for devices by DT property,
 low-memory-range
Date: Mon, 23 Dec 2019 23:23:48 +0800
Message-ID: <20191223152349.180172-4-chenzhou10@huawei.com>
In-Reply-To: <20191223152349.180172-1-chenzhou10@huawei.com>
References: <20191223152349.180172-1-chenzhou10@huawei.com>
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
To: tglx@linutronix.de, mingo@redhat.com, catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com, dyoung@redhat.com, bhsharma@redhat.com
Cc: xiexiuqi@huawei.com, chenzhou10@huawei.com, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, horms@verge.net.au, linux-arm-kernel@lists.infradead.org

If we want to reserve crashkernel above 4G, we could use parameters
"crashkernel=X crashkernel=Y,low", in this case, specified size low
memory is reserved for crash dump kernel devices and never mapped by
the first kernel. This memory range is advertised to crash dump kernel
via DT property under /chosen,
	linux,low-memory-range=<BASE SIZE>

Crash dump kernel reads this property at boot time and call
memblock_add() after memblock_cap_memory_range() has been called.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 arch/arm64/mm/init.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 0d7afd5..1c4a6ad 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -322,6 +322,26 @@ static int __init early_mem(char *p)
 }
 early_param("mem", early_mem);
 
+static int __init early_init_dt_scan_lowmem(unsigned long node,
+		const char *uname, int depth, void *data)
+{
+	struct memblock_region *lowmem = data;
+	const __be32 *reg;
+	int len;
+
+	if (depth != 1 || strcmp(uname, "chosen") != 0)
+		return 0;
+
+	reg = of_get_flat_dt_prop(node, "linux,low-memory-range", &len);
+	if (!reg || (len < (dt_root_addr_cells + dt_root_size_cells)))
+		return 1;
+
+	lowmem->base = dt_mem_next_cell(dt_root_addr_cells, &reg);
+	lowmem->size = dt_mem_next_cell(dt_root_size_cells, &reg);
+
+	return 1;
+}
+
 static int __init early_init_dt_scan_usablemem(unsigned long node,
 		const char *uname, int depth, void *data)
 {
@@ -352,13 +372,21 @@ static void __init fdt_enforce_memory_region(void)
 
 	if (reg.size)
 		memblock_cap_memory_range(reg.base, reg.size);
+
+	of_scan_flat_dt(early_init_dt_scan_lowmem, &reg);
+
+	if (reg.size)
+		memblock_add(reg.base, reg.size);
 }
 
 void __init arm64_memblock_init(void)
 {
 	const s64 linear_region_size = BIT(vabits_actual - 1);
 
-	/* Handle linux,usable-memory-range property */
+	/*
+	 * Handle linux,usable-memory-range and linux,low-memory-range
+	 * properties.
+	 */
 	fdt_enforce_memory_region();
 
 	/* Remove memory above our supported physical address size */
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
