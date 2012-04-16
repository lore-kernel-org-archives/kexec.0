Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SJbZW-0002KS-6Q
 for kexec@lists.infradead.org; Mon, 16 Apr 2012 02:21:43 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id A12BF3EE0B6
 for <kexec@lists.infradead.org>; Mon, 16 Apr 2012 11:21:40 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 87B3A45DE52
 for <kexec@lists.infradead.org>; Mon, 16 Apr 2012 11:21:40 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 658DE45DE50
 for <kexec@lists.infradead.org>; Mon, 16 Apr 2012 11:21:40 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 570DA1DB803F
 for <kexec@lists.infradead.org>; Mon, 16 Apr 2012 11:21:40 +0900 (JST)
Received: from ml13.s.css.fujitsu.com (ml13.s.css.fujitsu.com [10.240.81.133])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id EDB1A1DB803C
 for <kexec@lists.infradead.org>; Mon, 16 Apr 2012 11:21:39 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH 2/2] Enter 2nd kernel with BSP
Date: Mon, 16 Apr 2012 11:21:39 +0900
Message-ID: <20120416022139.9303.56284.stgit@localhost6.localdomain6>
In-Reply-To: <20120416021951.9303.58568.stgit@localhost6.localdomain6>
References: <20120416021951.9303.58568.stgit@localhost6.localdomain6>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, vgoyal@redhat.com, kumagai-atsushi@mxc.nes.nec.co.jp

Split logic into BSP's and AP's: BSP waits for AP halting.

Don't remove variable crashing_cpu for debugging use; useful for
determining one what CPU crash happens.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 arch/x86/kernel/crash.c  |   15 ++++++++++++++-
 arch/x86/kernel/reboot.c |   16 ++++++----------
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 13ad899..c5c19fa 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -83,9 +83,14 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 	 * In practice this means shooting down the other cpus in
 	 * an SMP system.
 	 */
+
+	int cpu;
+
 	/* The kernel is broken so disable interrupts */
 	local_irq_disable();
 
+	crash_ipi_init();
+
 	kdump_nmi_shootdown_cpus();
 
 	/* Booting kdump kernel with VMX or SVM enabled won't work,
@@ -102,5 +107,13 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 #ifdef CONFIG_HPET_TIMER
 	hpet_disable();
 #endif
-	crash_save_cpu(regs, safe_smp_processor_id());
+	cpu = safe_smp_processor_id();
+	crash_save_cpu(regs, cpu);
+
+	if (cpu_physical_id(cpu) == boot_cpu_physical_apicid) {
+		crash_ipi_wait_for_APs();
+		return;
+	}
+
+	crash_ipi_dec_and_halt();
 }
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 6dd77a8..90354f9 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -7,6 +7,7 @@
 #include <linux/sched.h>
 #include <linux/tboot.h>
 #include <linux/delay.h>
+#include <linux/kexec.h>
 #include <acpi/reboot.h>
 #include <asm/io.h>
 #include <asm/apic.h>
@@ -800,16 +801,15 @@ static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
 
 	cpu = raw_smp_processor_id();
 
-	/* Don't do anything if this handler is invoked on crashing cpu.
-	 * Otherwise, system will completely hang. Crashing cpu can get
-	 * an NMI if system was initially booted with nmi_watchdog parameter.
-	 */
-	if (cpu == crashing_cpu)
-		return NMI_HANDLED;
 	local_irq_disable();
 
 	shootdown_callback(cpu, regs);
 
+	if (cpu_physical_id(cpu) == boot_cpu_physical_apicid) {
+		crash_ipi_wait_for_APs();
+		machine_kexec(kexec_crash_image);
+	}
+
 	crash_ipi_dec_and_halt();
 
 	return NMI_HANDLED;
@@ -835,8 +835,6 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 
 	shootdown_callback = callback;
 
-	crash_ipi_init();
-
 	/* Would it be better to replace the trap vector here? */
 	if (register_nmi_handler(NMI_LOCAL, crash_nmi_callback,
 				 NMI_FLAG_FIRST, "crash"))
@@ -848,8 +846,6 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 
 	smp_send_nmi_allbutself();
 
-	crash_ipi_wait_for_APs();
-
 	/* Leave the nmi callback set */
 }
 #else /* !CONFIG_SMP */


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
