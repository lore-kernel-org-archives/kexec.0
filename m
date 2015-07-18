Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-by2on0124.outbound.protection.outlook.com
 ([207.46.100.124] helo=na01-by2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZGYQj-0007mt-Su
 for kexec@lists.infradead.org; Sat, 18 Jul 2015 20:09:55 +0000
From: Scott Wood <scottwood@freescale.com>
Subject: [RFC PATCH 02/17] powerpc/85xx: Don't use generic timebase sync on
 64-bit
Date: Sat, 18 Jul 2015 15:08:39 -0500
Message-ID: <1437250134-307-3-git-send-email-scottwood@freescale.com>
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

85xx currently uses the generic timebase sync mechanism when
CONFIG_KEXEC is enabled, because 32-bit 85xx kexec support does a hard
reset of each core.  64-bit 85xx kexec does not do this, so we neither
need nor want this (nor is the generic timebase sync code built on
ppc64).

FWIW, I don't like the fact that the hard reset is done on 32-bit
kexec, and I especially don't like the timebase sync being triggered
only on the presence of CONFIG_KEXEC rather than actually booting in
that environment, but that's beyond the scope of this patch...

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/platforms/85xx/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index c2ded03..a0763be 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -344,7 +344,7 @@ struct smp_ops_t smp_85xx_ops = {
 	.cpu_disable	= generic_cpu_disable,
 	.cpu_die	= generic_cpu_die,
 #endif
-#ifdef CONFIG_KEXEC
+#if defined(CONFIG_KEXEC) && !defined(CONFIG_PPC64)
 	.give_timebase	= smp_generic_give_timebase,
 	.take_timebase	= smp_generic_take_timebase,
 #endif
-- 
2.1.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
