Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-by2on0124.outbound.protection.outlook.com
 ([207.46.100.124] helo=na01-by2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZGYQl-0007mt-Do
 for kexec@lists.infradead.org; Sat, 18 Jul 2015 20:09:56 +0000
From: Scott Wood <scottwood@freescale.com>
Subject: [RFC PATCH 16/17] powerpc/book3e-64/kexec: Set "r4 = 0" when entering
 spinloop
Date: Sat, 18 Jul 2015 15:08:53 -0500
Message-ID: <1437250134-307-17-git-send-email-scottwood@freescale.com>
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

book3e_secondary_core_init will only create a TLB entry if r4 = 0,
so do so.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/misc_64.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index c5915f0..fb955d9 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -476,6 +476,10 @@ _GLOBAL(kexec_wait)
 #ifdef CONFIG_KEXEC		/* use no memory without kexec */
 	lwz	r4,0(r5)
 	cmpwi	0,r4,0
+#ifdef CONFIG_PPC_BOOK3E
+	/* Don't create TLB entry in book3e_secondary_core_init */
+	li	r4,0
+#endif
 	bnea	0x60
 #endif
 	b	99b
-- 
2.1.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
