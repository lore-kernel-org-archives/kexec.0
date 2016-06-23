Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <908152e5c56105db03c28f701922e7174d611a69.1466702804.git.geoff@infradead.org>
In-Reply-To: <cover.1466702804.git.geoff@infradead.org>
References: <cover.1466702804.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH v20 08/14] arm64: limit memory regions based on DT property,
 usable-memory
Date: Thu, 23 Jun 2016 17:54:48 +0000
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
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, marc.zyngier@arm.com, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, linux-arm-kernel@lists.infradead.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

Crash dump kernel will be run with a limited range of memory as System
RAM.

On arm64, we will use a device-tree property under /chosen,
   linux,usable-memory = <BASE SIZE>
in order for primary kernel either on uefi or non-uefi (device tree only)
system to hand over the information about usable memory region to crash
dump kernel. This property will supercede entries in uefi memory map table
and "memory" nodes in a device tree.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/mm/init.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index c948292..22e7bcf 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -249,10 +249,48 @@ static int __init early_mem(char *p)
 }
 early_param("mem", early_mem);
 
+static int __init early_init_dt_scan_usablemem(unsigned long node,
+		const char *uname, int depth, void *data)
+{
+	struct memblock_region *usablemem = (struct memblock_region *)data;
+	const __be32 *reg;
+	int len;
+
+	usablemem->size = 0;
+
+	if (depth != 1 || strcmp(uname, "chosen") != 0)
+		return 0;
+
+	reg = of_get_flat_dt_prop(node, "linux,usable-memory", &len);
+	if (!reg || (len < (dt_root_addr_cells + dt_root_size_cells)))
+		return 1;
+
+	usablemem->base = dt_mem_next_cell(dt_root_addr_cells, &reg);
+	usablemem->size = dt_mem_next_cell(dt_root_size_cells, &reg);
+
+	return 1;
+}
+
+static void __init fdt_enforce_memory_region(void)
+{
+	struct memblock_region reg;
+
+	of_scan_flat_dt(early_init_dt_scan_usablemem, &reg);
+
+	if (reg.size) {
+		memblock_remove(0, PAGE_ALIGN(reg.base));
+		memblock_remove(round_down(reg.base + reg.size, PAGE_SIZE),
+				ULLONG_MAX);
+	}
+}
+
 void __init arm64_memblock_init(void)
 {
 	const s64 linear_region_size = -(s64)PAGE_OFFSET;
 
+	/* Handle linux,usable-memory property */
+	fdt_enforce_memory_region();
+
 	/*
 	 * Ensure that the linear region takes up exactly half of the kernel
 	 * virtual address space. This way, we can distinguish a linear address
-- 
2.5.0



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
