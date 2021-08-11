Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from baptiste.telenet-ops.be ([2a02:1800:120:4::f00:13])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDjxY-0067XJ-RR
 for kexec@lists.infradead.org; Wed, 11 Aug 2021 08:51:45 +0000
From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v5 5/9] of: fdt: Use IS_ENABLED(CONFIG_BLK_DEV_INITRD) instead
 of #ifdef
Date: Wed, 11 Aug 2021 10:51:03 +0200
Message-Id: <604c13747f09d800da6a7c12f661e1ec146f1dfd.1628670468.git.geert+renesas@glider.be>
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

Replace the conditional compilation using "#ifdef CONFIG_BLK_DEV_INITRD"
by a check for "IS_ENABLED(CONFIG_BLK_DEV_INITRD)", to increase compile
coverage and to simplify the code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v5:
  - No changes,

v4:
  - New.
---
 drivers/of/fdt.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index bc041d8141e86e62..0142b9334559baec 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -880,7 +880,6 @@ const void * __init of_flat_dt_match_machine(const void *default_match,
 	return best_data;
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
 static void __early_init_dt_declare_initrd(unsigned long start,
 					   unsigned long end)
 {
@@ -906,6 +905,9 @@ static void __init early_init_dt_check_for_initrd(unsigned long node)
 	int len;
 	const __be32 *prop;
 
+	if (!IS_ENABLED(CONFIG_BLK_DEV_INITRD))
+		return;
+
 	pr_debug("Looking for initrd properties... ");
 
 	prop = of_get_flat_dt_prop(node, "linux,initrd-start", &len);
@@ -924,11 +926,6 @@ static void __init early_init_dt_check_for_initrd(unsigned long node)
 
 	pr_debug("initrd_start=0x%llx  initrd_end=0x%llx\n", start, end);
 }
-#else
-static inline void early_init_dt_check_for_initrd(unsigned long node)
-{
-}
-#endif /* CONFIG_BLK_DEV_INITRD */
 
 /**
  * early_init_dt_check_for_elfcorehdr - Decode elfcorehdr location from flat
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
