Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn1on0116.outbound.protection.outlook.com
 ([157.56.110.116] helo=na01-bn1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zjfin-00016f-1s
 for kexec@lists.infradead.org; Wed, 07 Oct 2015 03:48:53 +0000
From: Scott Wood <scottwood@freescale.com>
Subject: [PATCH v2 02/18] powerpc/fsl-corenet: Disable coreint if kexec is
 enabled
Date: Tue, 6 Oct 2015 22:48:06 -0500
Message-ID: <1444189702-17241-3-git-send-email-scottwood@freescale.com>
In-Reply-To: <1444189702-17241-1-git-send-email-scottwood@freescale.com>
References: <1444189702-17241-1-git-send-email-scottwood@freescale.com>
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
Cc: Scott Wood <scottwood@freescale.com>, Tiejun Chen <tiejun.chen@intel.com>, kexec@lists.infradead.org, Michael Ellerman <mpe@ellerman.id.au>

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
Previously I discussed the possibility of removing coreint entirely,
but I think we want to keep it for virtualized guests.
---
 arch/powerpc/platforms/85xx/corenet_generic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index b395571..04ffbcb 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -214,7 +214,11 @@ define_machine(corenet_generic) {
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
