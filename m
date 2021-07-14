Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from newton.telenet-ops.be ([2a02:1800:120:4::f00:d])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m3eLm-00HUAX-Dm
 for kexec@lists.infradead.org; Wed, 14 Jul 2021 12:50:57 +0000
Received: from andre.telenet-ops.be (andre.telenet-ops.be
 [IPv6:2a02:1800:120:4::f00:15])
 by newton.telenet-ops.be (Postfix) with ESMTPS id 4GPy6M5RN7zMrBZc
 for <kexec@lists.infradead.org>; Wed, 14 Jul 2021 14:50:51 +0200 (CEST)
From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 07/10] arm64: kdump: Remove custom linux, elfcorehdr parsing
Date: Wed, 14 Jul 2021 14:50:17 +0200
Message-Id: <65b6e3294cb84d50a6aab8503a9ebcf41445166d.1626266516.git.geert+renesas@glider.be>
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

Remove the architecture-specific code for parsing the "linux,elfcorehdr"
property under the "/chosen" node in DT, as the platform-agnostic
handling in the FDT core code already takes care of this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - s/handlng/parsing/ in patch description.
---
 arch/arm64/mm/init.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 8490ed2917ff2430..946e246660f2b180 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -125,25 +125,6 @@ static void __init reserve_crashkernel(void)
 #endif /* CONFIG_KEXEC_CORE */
 
 #ifdef CONFIG_CRASH_DUMP
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
 /*
  * reserve_elfcorehdr() - reserves memory for elf core header
  *
@@ -154,8 +135,6 @@ static int __init early_init_dt_scan_elfcorehdr(unsigned long node,
  */
 static void __init reserve_elfcorehdr(void)
 {
-	of_scan_flat_dt(early_init_dt_scan_elfcorehdr, NULL);
-
 	if (!elfcorehdr_size)
 		return;
 
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
