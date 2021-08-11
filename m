Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from xavier.telenet-ops.be ([2a02:1800:120:4::f00:14])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDjxX-0067WJ-TF
 for kexec@lists.infradead.org; Wed, 11 Aug 2021 08:51:40 +0000
From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v5 7/9] arm64: kdump: Remove custom linux,elfcorehdr handling
Date: Wed, 11 Aug 2021 10:51:05 +0200
Message-Id: <3b8f801f9b92066855e87f3079fafc153ab20f69.1628670468.git.geert+renesas@glider.be>
In-Reply-To: <cover.1628670468.git.geert+renesas@glider.be>
References: <cover.1628670468.git.geert+renesas@glider.be>
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
To: Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Ard Biesheuvel <ardb@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nick Kossifidis <mick@ics.forth.gr>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Frank Rowand <frowand.list@gmail.com>, Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Mike Rapoport <rppt@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, kexec@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Remove the architecture-specific code for handling the
"linux,elfcorehdr" property under the "/chosen" node in DT, as the
platform-agnostic handling in the FDT core code already takes care of
this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v5:
  - Remove all handling, not just parsing,

v4:
  - s/handlng/parsing/ in patch description.
---
 arch/arm64/mm/init.c | 53 --------------------------------------------
 1 file changed, 53 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 8490ed2917ff2430..bac4f06bb7d900a2 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -124,57 +124,6 @@ static void __init reserve_crashkernel(void)
 }
 #endif /* CONFIG_KEXEC_CORE */
 
-#ifdef CONFIG_CRASH_DUMP
-static int __init early_init_dt_scan_elfcorehdr(unsigned long node,
-		const char *uname, int depth, void *data)
-{
-	const __be32 *reg;
-	int len;
-
-	if (depth != 1 || strcmp(uname, "chosen") != 0)
-		return 0;
-
-	reg = of_get_flat_dt_prop(node, "linux,elfcorehdr", &len);
-	if (!reg || (len < (dt_root_addr_cells + dt_root_size_cells)))
-		return 1;
-
-	elfcorehdr_addr = dt_mem_next_cell(dt_root_addr_cells, &reg);
-	elfcorehdr_size = dt_mem_next_cell(dt_root_size_cells, &reg);
-
-	return 1;
-}
-
-/*
- * reserve_elfcorehdr() - reserves memory for elf core header
- *
- * This function reserves the memory occupied by an elf core header
- * described in the device tree. This region contains all the
- * information about primary kernel's core image and is used by a dump
- * capture kernel to access the system memory on primary kernel.
- */
-static void __init reserve_elfcorehdr(void)
-{
-	of_scan_flat_dt(early_init_dt_scan_elfcorehdr, NULL);
-
-	if (!elfcorehdr_size)
-		return;
-
-	if (memblock_is_region_reserved(elfcorehdr_addr, elfcorehdr_size)) {
-		pr_warn("elfcorehdr is overlapped\n");
-		return;
-	}
-
-	memblock_reserve(elfcorehdr_addr, elfcorehdr_size);
-
-	pr_info("Reserving %lldKB of memory at 0x%llx for elfcorehdr\n",
-		elfcorehdr_size >> 10, elfcorehdr_addr);
-}
-#else
-static void __init reserve_elfcorehdr(void)
-{
-}
-#endif /* CONFIG_CRASH_DUMP */
-
 /*
  * Return the maximum physical address for a zone accessible by the given bits
  * limit. If DRAM starts above 32-bit, expand the zone to the maximum
@@ -395,8 +344,6 @@ void __init arm64_memblock_init(void)
 
 	early_init_fdt_scan_reserved_mem();
 
-	reserve_elfcorehdr();
-
 	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
 }
 
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
