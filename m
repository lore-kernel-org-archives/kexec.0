Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from chamillionaire.breakpoint.cc ([85.10.199.196])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Kl97T-0003wQ-8U
	for kexec@lists.infradead.org; Wed, 01 Oct 2008 21:20:27 +0000
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [RFC] powerpc: enable kexec support on mpc8544ds
Date: Wed,  1 Oct 2008 23:20:23 +0200
Message-Id: <1222896024-22172-3-git-send-email-sebastian@breakpoint.cc>
In-Reply-To: <1222896024-22172-1-git-send-email-sebastian@breakpoint.cc>
References: <1222896024-22172-1-git-send-email-sebastian@breakpoint.cc>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linuxppc-dev@ozlabs.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, kexec@lists.infradead.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/powerpc/Kconfig                     |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_ds.c |    6 ++++++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 587da5e..c2c6a20 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -304,7 +304,7 @@ config ARCH_ENABLE_MEMORY_HOTREMOVE
 
 config KEXEC
 	bool "kexec system call (EXPERIMENTAL)"
-	depends on (PPC_PRPMC2800 || PPC_MULTIPLATFORM) && EXPERIMENTAL
+	depends on (PPC_PRPMC2800 || PPC_MULTIPLATFORM || MPC85xx_DS) && EXPERIMENTAL
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 3d5f21b..d50d383 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -30,6 +30,7 @@
 #include <asm/udbg.h>
 #include <asm/mpic.h>
 #include <asm/i8259.h>
+#include <linux/kexec.h>
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
@@ -227,6 +228,11 @@ define_machine(mpc8544_ds) {
 	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
+#ifdef CONFIG_KEXEC
+	.machine_kexec          = default_machine_kexec,
+	.machine_kexec_prepare  = booke_machine_kexec_prepare,
+	.machine_crash_shutdown = default_machine_crash_shutdown,
+#endif
 };
 
 define_machine(mpc8572_ds) {
-- 
1.5.6.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
