Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn1on0116.outbound.protection.outlook.com
 ([157.56.110.116] helo=na01-bn1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zjfit-00016f-HY
 for kexec@lists.infradead.org; Wed, 07 Oct 2015 03:49:00 +0000
From: Scott Wood <scottwood@freescale.com>
Subject: [PATCH v2 07/18] powerpc/85xx: Implement 64-bit kexec support
Date: Tue, 6 Oct 2015 22:48:11 -0500
Message-ID: <1444189702-17241-8-git-send-email-scottwood@freescale.com>
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
Cc: Tiejun Chen <tiejun.chen@windriver.com>, Tiejun Chen <tiejun.chen@intel.com>, kexec@lists.infradead.org, Scott Wood <scottwood@freescale.com>, Michael Ellerman <mpe@ellerman.id.au>

From: Tiejun Chen <tiejun.chen@windriver.com>

Unlike 32-bit 85xx kexec, we don't do a core reset.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
[scottwood: edit changelog, and cleanup]
Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/platforms/85xx/smp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index a0763be..2e46684 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -351,6 +351,7 @@ struct smp_ops_t smp_85xx_ops = {
 };
 
 #ifdef CONFIG_KEXEC
+#ifdef CONFIG_PPC32
 atomic_t kexec_down_cpus = ATOMIC_INIT(0);
 
 void mpc85xx_smp_kexec_cpu_down(int crash_shutdown, int secondary)
@@ -370,9 +371,18 @@ static void mpc85xx_smp_kexec_down(void *arg)
 	if (ppc_md.kexec_cpu_down)
 		ppc_md.kexec_cpu_down(0,1);
 }
+#else
+void mpc85xx_smp_kexec_cpu_down(int crash_shutdown, int secondary)
+{
+	local_irq_disable();
+	hard_irq_disable();
+	mpic_teardown_this_cpu(secondary);
+}
+#endif
 
 static void mpc85xx_smp_machine_kexec(struct kimage *image)
 {
+#ifdef CONFIG_PPC32
 	int timeout = INT_MAX;
 	int i, num_cpus = num_present_cpus();
 
@@ -393,6 +403,7 @@ static void mpc85xx_smp_machine_kexec(struct kimage *image)
 		if ( i == smp_processor_id() ) continue;
 		mpic_reset_core(i);
 	}
+#endif
 
 	default_machine_kexec(image);
 }
-- 
2.1.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
