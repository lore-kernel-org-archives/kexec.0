Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KrwGU-0001K7-9y
	for kexec@lists.infradead.org; Mon, 20 Oct 2008 15:01:51 +0000
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 1/2] kdump: crash-time CPU halt notifier interface
Date: Mon, 20 Oct 2008 13:01:33 -0200
Message-Id: <1224514894-30171-2-git-send-email-ehabkost@redhat.com>
In-Reply-To: <1224514894-30171-1-git-send-email-ehabkost@redhat.com>
References: <1224514894-30171-1-git-send-email-ehabkost@redhat.com>
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
To: kexec@lists.infradead.org, kvm@vger.kernel.org
Cc: Eduardo Habkost <ehabkost@redhat.com>

This patch adds an interface for notification of CPUs being
halted on a crash. The notifier will be called once on each CPU by
machine_crash_shutdown().

The notifiers will be used by KVM to disable virtualization before
halting the CPUs, otherwise the booting of the kdump kernel may hang
(it does, on my machine, when kvm-intel module is loaded).

We can't just use the same notifiers used at reboot time (that are used
by non-crash-dump kexec), because at crash time some CPUs may have IRQs
disabled, so we can't use IPIs. The crash shutdown code use NMIs to tell
the other CPUs to be halted, and the new notifier call is hooked into
the CPU halting code that is on the crash shutdown NMI handler.

I am not sure if a non x86-specific interface is more recommended. Some
arches don't have code to halt the CPUs on machine_crash_shutdown(),
so the interface wouldn't make sense on those arches.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 arch/x86/kernel/crash.c  |    5 ++++
 arch/x86/kernel/reboot.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++
 include/asm-x86/reboot.h |    4 +++
 3 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 2685538..3303e3c 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/elf.h>
 #include <linux/elfcore.h>
+#include <linux/module.h>
 
 #include <asm/processor.h>
 #include <asm/hardirq.h>
@@ -65,6 +66,8 @@ static int crash_nmi_callback(struct notifier_block *self,
 	}
 #endif
 	crash_save_cpu(regs, cpu);
+
+	emergency_halt_notify(cpu);
 	disable_local_APIC();
 	atomic_dec(&waiting_for_crash_ipi);
 	/* Assume hlt works */
@@ -134,6 +137,8 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 	/* Make a note of crashing cpu. Will be used in NMI callback.*/
 	crashing_cpu = safe_smp_processor_id();
 	nmi_shootdown_cpus();
+	emergency_halt_notify(crashing_cpu);
+
 	lapic_shutdown();
 #if defined(CONFIG_X86_IO_APIC)
 	disable_IO_APIC();
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index f4c93f1..976d0bf 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -518,3 +518,57 @@ void machine_crash_shutdown(struct pt_regs *regs)
 	machine_ops.crash_shutdown(regs);
 }
 #endif
+
+
+static RAW_NOTIFIER_HEAD(emergency_halt_chain);
+static DEFINE_SPINLOCK(emergency_halt_chain_lock);
+
+/**
+ *	register_emergency_halt_notifier - Register crash-time CPU halt notifier
+ *	@nb: Info about notifier function to be called
+ *
+ *	Registers a function to be called when CPUs are being halted at
+ *	machine_crash_shutdown().
+ *
+ *	The function is called once on each online CPU, possibly
+ *	from a NMI handler. Do the very least to allow the CPU
+ *	to be halted, as the kernel has just crashed.
+ */
+int register_emergency_halt_notifier(struct notifier_block *nb)
+{
+	int r;
+	spin_lock(&emergency_halt_chain_lock);
+	r = raw_notifier_chain_register(&emergency_halt_chain, nb);
+	spin_unlock(&emergency_halt_chain_lock);
+	return r;
+}
+EXPORT_SYMBOL(register_emergency_halt_notifier);
+
+/**
+ *	unregister_emergency_halt_notifier - Unregister a emergency_halt notifier
+ *	@nb: Notifier info previously registered
+ *
+ *	Unregister a CPU crash-time emergency halt notifier previously
+ *	registered.
+ *
+ *	Returns zero on success, or %-ENOENT on failure.
+ */
+int unregister_emergency_halt_notifier(struct notifier_block *nb)
+{
+	return raw_notifier_chain_unregister(&emergency_halt_chain, nb);
+}
+EXPORT_SYMBOL(unregister_emergency_halt_notifier);
+
+/* Notify that the CPU will be halted on crash
+ *
+ * Runs the notifiers registered by register_emergency_halt_notifier().
+ * Must be called on the CPU that is being halted.
+ */
+void emergency_halt_notify(unsigned int cpu)
+{
+	void *hcpu = (void *)(long)cpu;
+
+	/* Don't use any locking. We are crashing.
+	 */
+	raw_notifier_call_chain(&emergency_halt_chain, 0, hcpu);
+}
diff --git a/include/asm-x86/reboot.h b/include/asm-x86/reboot.h
index 1c2f0ce..49c9d7f 100644
--- a/include/asm-x86/reboot.h
+++ b/include/asm-x86/reboot.h
@@ -18,4 +18,8 @@ void native_machine_crash_shutdown(struct pt_regs *regs);
 void native_machine_shutdown(void);
 void machine_real_restart(const unsigned char *code, int length);
 
+int register_emergency_halt_notifier(struct notifier_block *nb);
+int unregister_emergency_halt_notifier(struct notifier_block *nb);
+void emergency_halt_notify(unsigned int cpu);
+
 #endif /* ASM_X86__REBOOT_H */
-- 
1.5.5.GIT


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
