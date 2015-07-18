Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn1on0135.outbound.protection.outlook.com
 ([157.56.110.135] helo=na01-bn1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZGYQU-0007mM-LH
 for kexec@lists.infradead.org; Sat, 18 Jul 2015 20:09:39 +0000
From: Scott Wood <scottwood@freescale.com>
Subject: [RFC PATCH 04/17] powerpc/fsl-corenet: Disable coreint if kexec is
 enabled
Date: Sat, 18 Jul 2015 15:08:41 -0500
Message-ID: <1437250134-307-5-git-send-email-scottwood@freescale.com>
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

Problems have been observed in coreint (EPR) mode if interrupts are
left pending (due to the lack of device quiescence with kdump) after
having tried to deliver to a CPU but unable to deliver due to MSR[EE]
-- interrupts no longer get reliably delivered in the new kernel.  I
tried various ways of fixing it up inside the crash kernel itself, and
none worked (including resetting the entire mpic).  Masking all
interrupts and issuing EOIs in the crashing kernel did help a lot of
the time, but the behavior was not consistent.

Thus, stick to standard IACK mode when kdump is a possibility.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
Supposedly there are similar problems with certain low power states --
the SDK disables coreint when CPU hotplug is enabled -- so disabling it
for kexec as well doesn't seem like a big deal.
---
 arch/powerpc/platforms/85xx/corenet_generic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index bd839dc..cddc9a2 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -212,7 +212,11 @@ define_machine(corenet_generic) {
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
+#ifdef CONFIG_KEXEC
+	.get_irq		= mpic_get_irq,
+#else
 	.get_irq		= mpic_get_coreint_irq,
+#endif
 	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
-- 
2.1.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
