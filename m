Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from michel.telenet-ops.be ([2a02:1800:110:4::f00:18])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDjxY-0067XH-RM
 for kexec@lists.infradead.org; Wed, 11 Aug 2021 08:51:44 +0000
From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v5 1/9] MIPS: Avoid future duplicate elf core header
 reservation
Date: Wed, 11 Aug 2021 10:50:59 +0200
Message-Id: <92b6718f5618d5469f67b48fbea189cca0c12f4b.1628670468.git.geert+renesas@glider.be>
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

Prepare for early_init_fdt_scan_reserved_mem() reserving the memory
occupied by an elf core header described in the device tree.
As arch_mem_init() calls early_init_fdt_scan_reserved_mem() before
mips_reserve_vmcore(), the latter needs to check if the memory has
already been reserved before.

Note that mips_reserve_vmcore() cannot just be removed, as not all MIPS
systems use DT.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v5:
  - New.
---
 arch/mips/kernel/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 23a140327a0bac1b..4693add05743d78b 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -429,7 +429,8 @@ static void __init mips_reserve_vmcore(void)
 	pr_info("Reserving %ldKB of memory at %ldKB for kdump\n",
 		(unsigned long)elfcorehdr_size >> 10, (unsigned long)elfcorehdr_addr >> 10);
 
-	memblock_reserve(elfcorehdr_addr, elfcorehdr_size);
+	if (!memblock_is_region_reserved(elfcorehdr_addr, elfcorehdr_size)
+		memblock_reserve(elfcorehdr_addr, elfcorehdr_size);
 #endif
 }
 
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
