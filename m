Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from xavier.telenet-ops.be ([2a02:1800:120:4::f00:14])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m3eLl-00DbFk-4Q
 for kexec@lists.infradead.org; Wed, 14 Jul 2021 12:50:55 +0000
From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 09/10] arm64: kdump: Use IS_ENABLED(CONFIG_CRASH_DUMP)
 instead of #ifdef
Date: Wed, 14 Jul 2021 14:50:19 +0200
Message-Id: <767e34a7ec29c417fdd5ff6e0fc76bc93d4f3c6f.1626266516.git.geert+renesas@glider.be>
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

Replace the conditional compilation using "#ifdef CONFIG_CRASH_DUMP" by
a check for "IS_ENABLED(CONFIG_CRASH_DUMP)", to increase compile
coverage and to simplify the code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - New.
---
 arch/arm64/mm/init.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index f90ba99437c0f3c9..dc2a5b73232843e4 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -124,7 +124,6 @@ static void __init reserve_crashkernel(void)
 }
 #endif /* CONFIG_KEXEC_CORE */
 
-#ifdef CONFIG_CRASH_DUMP
 /*
  * reserve_elfcorehdr() - reserves memory for elf core header
  *
@@ -135,7 +134,7 @@ static void __init reserve_crashkernel(void)
  */
 static void __init reserve_elfcorehdr(void)
 {
-	if (!elfcorehdr_size)
+	if (!IS_ENABLED(CONFIG_CRASH_DUMP) || !elfcorehdr_size)
 		return;
 
 	if (memblock_is_region_reserved(elfcorehdr_addr, elfcorehdr_size)) {
@@ -148,11 +147,6 @@ static void __init reserve_elfcorehdr(void)
 	pr_info("Reserving %lldKB of memory at 0x%llx for elfcorehdr\n",
 		elfcorehdr_size >> 10, elfcorehdr_addr);
 }
-#else
-static void __init reserve_elfcorehdr(void)
-{
-}
-#endif /* CONFIG_CRASH_DUMP */
 
 /*
  * Return the maximum physical address for a zone accessible by the given bits
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
