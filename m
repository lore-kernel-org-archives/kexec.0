Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from moutng.kundenserver.de ([212.227.126.188])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1L2nSk-0006aM-7j
	for kexec@lists.infradead.org; Wed, 19 Nov 2008 13:51:23 +0000
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] powerpc/mpic: don't reset affinity for secondary MPIC on boot
Date: Wed, 19 Nov 2008 14:50:58 +0100
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200811191450.59361.arnd@arndb.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org, kexec@lists.infradead.org, Max Krasnyansky <maxk@qualcomm.com>, paulus@samba.org, benh@kernel.crashing.org

Kexec/kdump currently fails on the IBM QS2x blades when the kexec happens
on a CPU other than the initial boot CPU.  It turns out that this is the
result of mpic_init trying to set affinity of each interrupt vector to the
current boot CPU.

As far as I can tell,  the same problem is likely to exist on any
secondary MPIC, because they have to deliver interrupts to the first
output all the time. There are two potential solutions for this: either
not set up affinity at all for secondary MPICs, or assume that CPU
output 0 is connected to the upstream interrupt controller and hardcode
affinity to that.

This patch implements the first approach, because it can work on
machines that have a secondary controller that needs to deliver
interrupts to a destination other than CPU 0. The disadvantage
is that it requires the system to set up the affinity register
correctly on bootup.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

---
Index: linux-2.6/arch/powerpc/sysdev/mpic.c
===================================================================
--- linux-2.6.orig/arch/powerpc/sysdev/mpic.c
+++ linux-2.6/arch/powerpc/sysdev/mpic.c
@@ -1323,8 +1323,9 @@ void __init mpic_init(struct mpic *mpic)
 			continue;
 		/* init hw */
 		mpic_irq_write(i, MPIC_INFO(IRQ_VECTOR_PRI), vecpri);
-		mpic_irq_write(i, MPIC_INFO(IRQ_DESTINATION),
-			       1 << hard_smp_processor_id());
+		if (mpic->flags & MPIC_PRIMARY)
+			mpic_irq_write(i, MPIC_INFO(IRQ_DESTINATION),
+				       1 << hard_smp_processor_id());
 	}
 	
 	/* Init spurious vector */

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
