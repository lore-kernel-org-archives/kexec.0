Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from baptiste.telenet-ops.be ([2a02:1800:120:4::f00:13])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m3eLl-00DbGR-2S
 for kexec@lists.infradead.org; Wed, 14 Jul 2021 12:50:57 +0000
From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 08/10] arm64: kdump: Remove custom linux,
 usable-memory-range parsing
Date: Wed, 14 Jul 2021 14:50:18 +0200
Message-Id: <8ee4eacc4ce00b95fdb4b28daf3eb597212c5941.1626266516.git.geert+renesas@glider.be>
In-Reply-To: <cover.1626266516.git.geert+renesas@glider.be>
References: <cover.1626266516.git.geert+renesas@glider.be>
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
To: Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Ard Biesheuvel <ardb@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Nick Kossifidis <mick@ics.forth.gr>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Frank Rowand <frowand.list@gmail.com>, Dave Young <dyoung@redhat.com>, Mike Rapoport <rppt@kernel.org>
Cc: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, kexec@lists.infradead.org, linux-mm@kvack.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Remove the architecture-specific code for parsing the
"linux,usable-memory-range" property under the "/chosen" node in DT, as
the platform-agnostic handling in the FDT core code already takes care
of this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - New.
---
 arch/arm64/mm/init.c | 34 +---------------------------------
 1 file changed, 1 insertion(+), 33 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 946e246660f2b180..f90ba99437c0f3c9 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -227,44 +227,12 @@ static int __init early_mem(char *p)
 }
 early_param("mem", early_mem);
 
-static int __init early_init_dt_scan_usablemem(unsigned long node,
-		const char *uname, int depth, void *data)
-{
-	struct memblock_region *usablemem = data;
-	const __be32 *reg;
-	int len;
-
-	if (depth != 1 || strcmp(uname, "chosen") != 0)
-		return 0;
-
-	reg = of_get_flat_dt_prop(node, "linux,usable-memory-range", &len);
-	if (!reg || (len < (dt_root_addr_cells + dt_root_size_cells)))
-		return 1;
-
-	usablemem->base = dt_mem_next_cell(dt_root_addr_cells, &reg);
-	usablemem->size = dt_mem_next_cell(dt_root_size_cells, &reg);
-
-	return 1;
-}
-
-static void __init fdt_enforce_memory_region(void)
-{
-	struct memblock_region reg = {
-		.size = 0,
-	};
-
-	of_scan_flat_dt(early_init_dt_scan_usablemem, &reg);
-
-	if (reg.size)
-		memblock_cap_memory_range(reg.base, reg.size);
-}
-
 void __init arm64_memblock_init(void)
 {
 	const s64 linear_region_size = PAGE_END - _PAGE_OFFSET(vabits_actual);
 
 	/* Handle linux,usable-memory-range property */
-	fdt_enforce_memory_region();
+	memblock_cap_memory_range(cap_mem_addr, cap_mem_size);
 
 	/* Remove memory above our supported physical address size */
 	memblock_remove(1ULL << PHYS_MASK_SHIFT, ULLONG_MAX);
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
