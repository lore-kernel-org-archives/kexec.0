Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn1on0116.outbound.protection.outlook.com
 ([157.56.110.116] helo=na01-bn1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zjfiu-00016f-R7
 for kexec@lists.infradead.org; Wed, 07 Oct 2015 03:49:01 +0000
From: Scott Wood <scottwood@freescale.com>
Subject: [PATCH v2 08/18] powerpc/e6500: kexec: Handle hardware threads
Date: Tue, 6 Oct 2015 22:48:12 -0500
Message-ID: <1444189702-17241-9-git-send-email-scottwood@freescale.com>
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

The new kernel will be expecting secondary threads to be disabled,
not spinning.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
v2: minor cleanup

 arch/powerpc/kernel/head_64.S     | 16 ++++++++++++++
 arch/powerpc/platforms/85xx/smp.c | 46 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index d48125d..8b2bf0d 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -182,6 +182,8 @@ exception_marker:
 
 #ifdef CONFIG_PPC_BOOK3E
 _GLOBAL(fsl_secondary_thread_init)
+	mfspr	r4,SPRN_BUCSR
+
 	/* Enable branch prediction */
 	lis     r3,BUCSR_INIT@h
 	ori     r3,r3,BUCSR_INIT@l
@@ -196,10 +198,24 @@ _GLOBAL(fsl_secondary_thread_init)
 	 * number.  There are two threads per core, so shift everything
 	 * but the low bit right by two bits so that the cpu numbering is
 	 * continuous.
+	 *
+	 * If the old value of BUCSR is non-zero, this thread has run
+	 * before.  Thus, we assume we are coming from kexec or a similar
+	 * scenario, and PIR is already set to the correct value.  This
+	 * is a bit of a hack, but there are limited opportunities for
+	 * getting information into the thread and the alternatives
+	 * seemed like they'd be overkill.  We can't tell just by looking
+	 * at the old PIR value which state it's in, since the same value
+	 * could be valid for one thread out of reset and for a different
+	 * thread in Linux.
 	 */
+
 	mfspr	r3, SPRN_PIR
+	cmpwi	r4,0
+	bne	1f
 	rlwimi	r3, r3, 30, 2, 30
 	mtspr	SPRN_PIR, r3
+1:
 #endif
 
 _GLOBAL(generic_secondary_thread_init)
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 2e46684..712764f 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -374,9 +374,55 @@ static void mpc85xx_smp_kexec_down(void *arg)
 #else
 void mpc85xx_smp_kexec_cpu_down(int crash_shutdown, int secondary)
 {
+	int cpu = smp_processor_id();
+	int sibling = cpu_last_thread_sibling(cpu);
+	bool notified = false;
+	int disable_cpu;
+	int disable_threadbit = 0;
+	long start = mftb();
+	long now;
+
 	local_irq_disable();
 	hard_irq_disable();
 	mpic_teardown_this_cpu(secondary);
+
+	if (cpu == crashing_cpu && cpu_thread_in_core(cpu) != 0) {
+		/*
+		 * We enter the crash kernel on whatever cpu crashed,
+		 * even if it's a secondary thread.  If that's the case,
+		 * disable the corresponding primary thread.
+		 */
+		disable_threadbit = 1;
+		disable_cpu = cpu_first_thread_sibling(cpu);
+	} else if (sibling != crashing_cpu &&
+		   cpu_thread_in_core(cpu) == 0 &&
+		   cpu_thread_in_core(sibling) != 0) {
+		disable_threadbit = 2;
+		disable_cpu = sibling;
+	}
+
+	if (disable_threadbit) {
+		while (paca[disable_cpu].kexec_state < KEXEC_STATE_REAL_MODE) {
+			barrier();
+			now = mftb();
+			if (!notified && now - start > 1000000) {
+				pr_info("%s/%d: waiting for cpu %d to enter KEXEC_STATE_REAL_MODE (%d)\n",
+					__func__, smp_processor_id(),
+					disable_cpu,
+					paca[disable_cpu].kexec_state);
+				notified = true;
+			}
+		}
+
+		if (notified) {
+			pr_info("%s: cpu %d done waiting\n",
+				__func__, disable_cpu);
+		}
+
+		mtspr(SPRN_TENC, disable_threadbit);
+		while (mfspr(SPRN_TENSR) & disable_threadbit)
+			cpu_relax();
+	}
 }
 #endif
 
-- 
2.1.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
