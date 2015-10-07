Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn1on0118.outbound.protection.outlook.com
 ([157.56.110.118] helo=na01-bn1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zjfiw-00018p-Mc
 for kexec@lists.infradead.org; Wed, 07 Oct 2015 03:49:04 +0000
From: Scott Wood <scottwood@freescale.com>
Subject: [PATCH v2 01/18] powerpc/fsl-booke-64: Allow booting from the
 secondary thread
Date: Tue, 6 Oct 2015 22:48:05 -0500
Message-ID: <1444189702-17241-2-git-send-email-scottwood@freescale.com>
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

This allows SMP kernels to work as kdump crash kernels.  While crash
kernels don't really need to be SMP, this prevents things from breaking
if a user does it anyway (which is not something you want to only find
out once the main kernel has crashed in the field, especially if
whether it works or not depends on which cpu crashed).

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/platforms/85xx/smp.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index b8b8216..c2ded03 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -173,15 +173,22 @@ static inline u32 read_spin_table_addr_l(void *spin_table)
 static void wake_hw_thread(void *info)
 {
 	void fsl_secondary_thread_init(void);
-	unsigned long imsr1, inia1;
+	unsigned long imsr, inia;
 	int nr = *(const int *)info;
 
-	imsr1 = MSR_KERNEL;
-	inia1 = *(unsigned long *)fsl_secondary_thread_init;
-
-	mttmr(TMRN_IMSR1, imsr1);
-	mttmr(TMRN_INIA1, inia1);
-	mtspr(SPRN_TENS, TEN_THREAD(1));
+	imsr = MSR_KERNEL;
+	inia = *(unsigned long *)fsl_secondary_thread_init;
+
+	if (cpu_thread_in_core(nr) == 0) {
+		/* For when we boot on a secondary thread with kdump */
+		mttmr(TMRN_IMSR0, imsr);
+		mttmr(TMRN_INIA0, inia);
+		mtspr(SPRN_TENS, TEN_THREAD(0));
+	} else {
+		mttmr(TMRN_IMSR1, imsr);
+		mttmr(TMRN_INIA1, inia);
+		mtspr(SPRN_TENS, TEN_THREAD(1));
+	}
 
 	smp_generic_kick_cpu(nr);
 }
@@ -224,6 +231,12 @@ static int smp_85xx_kick_cpu(int nr)
 
 		smp_call_function_single(primary, wake_hw_thread, &nr, 0);
 		return 0;
+	} else if (cpu_thread_in_core(boot_cpuid) != 0 &&
+		   cpu_first_thread_sibling(boot_cpuid) == nr) {
+		if (WARN_ON_ONCE(!cpu_has_feature(CPU_FTR_SMT)))
+			return -ENOENT;
+
+		smp_call_function_single(boot_cpuid, wake_hw_thread, &nr, 0);
 	}
 #endif
 
-- 
2.1.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
