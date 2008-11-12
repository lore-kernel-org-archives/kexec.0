Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1L0FsT-000714-0m
	for kexec@lists.infradead.org; Wed, 12 Nov 2008 13:35:25 +0000
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 6/8] x86: Move nmi_shootdown_cpus() to reboot.c
Date: Wed, 12 Nov 2008 11:34:42 -0200
Message-Id: <1226496884-24628-7-git-send-email-ehabkost@redhat.com>
In-Reply-To: <1226496884-24628-1-git-send-email-ehabkost@redhat.com>
References: <1226496884-24628-1-git-send-email-ehabkost@redhat.com>
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
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, Avi Kivity <avi@redhat.com>, Andrey Borzenkov <arvidjaar@mail.ru>, Vivek Goyal <vgoyal@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>

Now nmi_shootdown_cpus() is ready to be used by non-kdump code also.
Move it to reboot.c.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 arch/x86/kernel/crash.c  |   76 ------------------------------------------
 arch/x86/kernel/reboot.c |   83 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+), 76 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index fb298d1..d84a852 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -32,12 +32,6 @@
 
 #if defined(CONFIG_SMP) && defined(CONFIG_X86_LOCAL_APIC)
 
-/* This keeps a track of which one is crashing cpu. */
-static int crashing_cpu;
-static nmi_shootdown_cb shootdown_callback;
-
-static atomic_t waiting_for_crash_ipi;
-
 static void kdump_nmi_callback(int cpu, struct die_args *args)
 {
 	struct pt_regs *regs;
@@ -58,76 +52,6 @@ static void kdump_nmi_callback(int cpu, struct die_args *args)
 	disable_local_APIC();
 }
 
-static int crash_nmi_callback(struct notifier_block *self,
-			unsigned long val, void *data)
-{
-	int cpu;
-
-	if (val != DIE_NMI_IPI)
-		return NOTIFY_OK;
-
-	cpu = raw_smp_processor_id();
-
-	/* Don't do anything if this handler is invoked on crashing cpu.
-	 * Otherwise, system will completely hang. Crashing cpu can get
-	 * an NMI if system was initially booted with nmi_watchdog parameter.
-	 */
-	if (cpu == crashing_cpu)
-		return NOTIFY_STOP;
-	local_irq_disable();
-
-	shootdown_callback(cpu, (struct die_args *)data);
-
-	atomic_dec(&waiting_for_crash_ipi);
-	/* Assume hlt works */
-	halt();
-	for (;;)
-		cpu_relax();
-
-	return 1;
-}
-
-static void smp_send_nmi_allbutself(void)
-{
-	cpumask_t mask = cpu_online_map;
-	cpu_clear(safe_smp_processor_id(), mask);
-	if (!cpus_empty(mask))
-		send_IPI_mask(mask, NMI_VECTOR);
-}
-
-static struct notifier_block crash_nmi_nb = {
-	.notifier_call = crash_nmi_callback,
-};
-
-void nmi_shootdown_cpus(nmi_shootdown_cb callback)
-{
-	unsigned long msecs;
-
-	/* Make a note of crashing cpu. Will be used in NMI callback.*/
-	crashing_cpu = safe_smp_processor_id();
-
-	shootdown_callback = callback;
-
-	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
-	/* Would it be better to replace the trap vector here? */
-	if (register_die_notifier(&crash_nmi_nb))
-		return;		/* return what? */
-	/* Ensure the new callback function is set before sending
-	 * out the NMI
-	 */
-	wmb();
-
-	smp_send_nmi_allbutself();
-
-	msecs = 1000; /* Wait at most a second for the other cpus to stop */
-	while ((atomic_read(&waiting_for_crash_ipi) > 0) && msecs) {
-		mdelay(1);
-		msecs--;
-	}
-
-	/* Leave the nmi callback set */
-}
-
 static void kdump_nmi_shootdown_cpus(void)
 {
 	nmi_shootdown_cpus(kdump_nmi_callback);
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 34f8d37..82fa28f 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -21,6 +21,9 @@
 # include <asm/iommu.h>
 #endif
 
+#include <mach_ipi.h>
+
+
 /*
  * Power off function, if any
  */
@@ -519,3 +522,83 @@ void machine_crash_shutdown(struct pt_regs *regs)
 	machine_ops.crash_shutdown(regs);
 }
 #endif
+
+
+#if defined(CONFIG_SMP) && defined(CONFIG_X86_LOCAL_APIC)
+
+/* This keeps a track of which one is crashing cpu. */
+static int crashing_cpu;
+static nmi_shootdown_cb shootdown_callback;
+
+static atomic_t waiting_for_crash_ipi;
+
+static int crash_nmi_callback(struct notifier_block *self,
+			unsigned long val, void *data)
+{
+	int cpu;
+
+	if (val != DIE_NMI_IPI)
+		return NOTIFY_OK;
+
+	cpu = raw_smp_processor_id();
+
+	/* Don't do anything if this handler is invoked on crashing cpu.
+	 * Otherwise, system will completely hang. Crashing cpu can get
+	 * an NMI if system was initially booted with nmi_watchdog parameter.
+	 */
+	if (cpu == crashing_cpu)
+		return NOTIFY_STOP;
+	local_irq_disable();
+
+	shootdown_callback(cpu, (struct die_args *)data);
+
+	atomic_dec(&waiting_for_crash_ipi);
+	/* Assume hlt works */
+	halt();
+	for (;;)
+		cpu_relax();
+
+	return 1;
+}
+
+static void smp_send_nmi_allbutself(void)
+{
+	cpumask_t mask = cpu_online_map;
+	cpu_clear(safe_smp_processor_id(), mask);
+	if (!cpus_empty(mask))
+		send_IPI_mask(mask, NMI_VECTOR);
+}
+
+static struct notifier_block crash_nmi_nb = {
+	.notifier_call = crash_nmi_callback,
+};
+
+void nmi_shootdown_cpus(nmi_shootdown_cb callback)
+{
+	unsigned long msecs;
+
+	/* Make a note of crashing cpu. Will be used in NMI callback.*/
+	crashing_cpu = safe_smp_processor_id();
+
+	shootdown_callback = callback;
+
+	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
+	/* Would it be better to replace the trap vector here? */
+	if (register_die_notifier(&crash_nmi_nb))
+		return;		/* return what? */
+	/* Ensure the new callback function is set before sending
+	 * out the NMI
+	 */
+	wmb();
+
+	smp_send_nmi_allbutself();
+
+	msecs = 1000; /* Wait at most a second for the other cpus to stop */
+	while ((atomic_read(&waiting_for_crash_ipi) > 0) && msecs) {
+		mdelay(1);
+		msecs--;
+	}
+
+	/* Leave the nmi callback set */
+}
+#endif
-- 
1.5.5.GIT


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
