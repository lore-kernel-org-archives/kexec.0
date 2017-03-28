Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cskw7-0002cv-Ef
 for kexec@lists.infradead.org; Tue, 28 Mar 2017 06:49:02 +0000
Received: by mail-pg0-x230.google.com with SMTP id g2so63087756pge.3
 for <kexec@lists.infradead.org>; Mon, 27 Mar 2017 23:48:39 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v34 03/14] arm64: limit memory regions based on DT property,
 usable-memory-range
Date: Tue, 28 Mar 2017 15:51:21 +0900
Message-Id: <20170328065130.16019-1-takahiro.akashi@linaro.org>
In-Reply-To: <20170328064831.15894-1-takahiro.akashi@linaro.org>
References: <20170328064831.15894-1-takahiro.akashi@linaro.org>
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
Cc: mark.rutland@arm.com, panand@redhat.com, ard.biesheuvel@linaro.org, geoff@infradead.org, dwmw2@infradead.org, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com, bauerman@linux.vnet.ibm.com, sgoel@codeaurora.org, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org

Crash dump kernel uses only a limited range of available memory as System
RAM. On arm64 kdump, This memory range is advertised to crash dump kernel
via a device-tree property under /chosen,
   linux,usable-memory-range = <BASE SIZE>

Crash dump kernel reads this property at boot time and calls
memblock_cap_memory_range() to limit usable memory which are listed either
in UEFI memory map table or "memory" nodes of a device tree blob.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Geoff Levand <geoff@infradead.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/mm/init.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index e19e06593e37..290794b1a0f1 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -188,10 +188,45 @@ static int __init early_mem(char *p)
 }
 early_param("mem", early_mem);
 
+static int __init early_init_dt_scan_usablemem(unsigned long node,
+		const char *uname, int depth, void *data)
+{
+	struct memblock_region *usablemem = data;
+	const __be32 *reg;
+	int len;
+
+	if (depth != 1 || strcmp(uname, "chosen") != 0)
+		return 0;
+
+	reg = of_get_flat_dt_prop(node, "linux,usable-memory-range", &len);
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
+	struct memblock_region reg = {
+		.size = 0,
+	};
+
+	of_scan_flat_dt(early_init_dt_scan_usablemem, &reg);
+
+	if (reg.size)
+		memblock_cap_memory_range(reg.base, reg.size);
+}
+
 void __init arm64_memblock_init(void)
 {
 	const s64 linear_region_size = -(s64)PAGE_OFFSET;
 
+	/* Handle linux,usable-memory-range property */
+	fdt_enforce_memory_region();
+
 	/*
 	 * Ensure that the linear region takes up exactly half of the kernel
 	 * virtual address space. This way, we can distinguish a linear address
-- 
2.11.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
