Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn1on0135.outbound.protection.outlook.com
 ([157.56.110.135] helo=na01-bn1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZGYQh-0007mM-Sw
 for kexec@lists.infradead.org; Sat, 18 Jul 2015 20:09:52 +0000
From: Scott Wood <scottwood@freescale.com>
Subject: [RFC PATCH 15/17] powerpc/booke: Only use VIRT_PHYS_OFFSET on booke32
Date: Sat, 18 Jul 2015 15:08:52 -0500
Message-ID: <1437250134-307-16-git-send-email-scottwood@freescale.com>
In-Reply-To: <1437250134-307-1-git-send-email-scottwood@freescale.com>
References: <1437250134-307-1-git-send-email-scottwood@freescale.com>
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
To: linuxppc-dev@lists.ozlabs.org
Cc: Scott Wood <scottwood@freescale.com>, Tiejun Chen <tiejun.chen@intel.com>, kexec@lists.infradead.org

The way VIRT_PHYS_OFFSET is not correct on book3e-64, because
it does not account for CONFIG_RELOCATABLE other than via the
32-bit-only virt_phys_offset.

book3e-64 can (and if the comment about a GCC miscompilation is still
relevant, should) use the normal ppc64 __va/__pa.

At this point, only booke-32 will use VIRT_PHYS_OFFSET, so given the
issues with its calculation, restrict its definition to booke-32.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/include/asm/page.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 71294a6..11889d8 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -107,12 +107,13 @@ extern long long virt_phys_offset;
 #endif
 
 /* See Description below for VIRT_PHYS_OFFSET */
-#ifdef CONFIG_RELOCATABLE_PPC32
+#if defined(CONFIG_PPC32) && defined(CONFIG_BOOKE)
+#ifdef CONFIG_RELOCATABLE
 #define VIRT_PHYS_OFFSET virt_phys_offset
 #else
 #define VIRT_PHYS_OFFSET (KERNELBASE - PHYSICAL_START)
 #endif
-
+#endif
 
 #ifdef CONFIG_PPC64
 #define MEMORY_START	0UL
@@ -204,7 +205,7 @@ extern long long virt_phys_offset;
  * On non-Book-E PPC64 PAGE_OFFSET and MEMORY_START are constants so use
  * the other definitions for __va & __pa.
  */
-#ifdef CONFIG_BOOKE
+#if defined(CONFIG_PPC32) && defined(CONFIG_BOOKE)
 #define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) + VIRT_PHYS_OFFSET))
 #define __pa(x) ((unsigned long)(x) - VIRT_PHYS_OFFSET)
 #else
-- 
2.1.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
