Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KvXgC-0000LZ-Vb
	for kexec@lists.infradead.org; Thu, 30 Oct 2008 13:35:17 +0000
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 1/6] kdump: crash-time virt disable function
Date: Thu, 30 Oct 2008 11:34:41 -0200
Message-Id: <1225373687-6960-2-git-send-email-ehabkost@redhat.com>
In-Reply-To: <1225373687-6960-1-git-send-email-ehabkost@redhat.com>
References: <1225373687-6960-1-git-send-email-ehabkost@redhat.com>
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
To: Avi Kivity <avi@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

This patch adds an interface to set a function to be called on crash time,
on each CPU. The function will be set by code that enables virtualization
extensions on the CPUs (i.e. KVM).  It will be called once on each CPU
by machine_crash_shutdown(), and should do the very least to disable
virt extensions on the CPU where it is being called.

The function will be used by KVM to disable virtualization before halting
the CPUs, otherwise the booting of the kdump kernel may hang. It does
hang, when vmx is enabled, and I wouldn't be surprised if having svm
enabled also causes problems.

The functions that set the function pointer uses RCU synchronization,
just in case the crash NMI is triggered while KVM is unloading.

We can't just use the same notifiers used at reboot time (that are used
by non-crash-dump kexec), because at crash time some CPUs may have IRQs
disabled, so we can't use IPIs. The crash shutdown code use NMIs to
tell the other CPUs to be halted, so the notifier call is hooked into
the CPU halting code that is on the crash shutdown NMI handler.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 arch/x86/include/asm/virtext.h |   24 +++++++++++++
 arch/x86/kernel/crash.c        |   71 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+), 0 deletions(-)
 create mode 100644 arch/x86/include/asm/virtext.h

diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
new file mode 100644
index 0000000..773037c
--- /dev/null
+++ b/arch/x86/include/asm/virtext.h
@@ -0,0 +1,24 @@
+/* virtualization extensions handling code
+ */
+#ifndef _ASM_X86_VIRTEX_H
+#define _ASM_X86_VIRTEX_H
+
+#ifdef CONFIG_KEXEC
+
+int set_virt_disable_func(void (*fn)(unsigned int cpu));
+void clear_virt_disable_func(void);
+
+#else /* !CONFIG_KEXEC */
+
+inline int set_virt_disable_func(void (*fn)(unsigned int cpu))
+{
+	return 0;
+}
+
+inline void clear_virt_disable_func(void)
+{
+}
+
+#endif /* CONFIG_KEXEC */
+
+#endif /* _ASM_X86_VIRTEX_H */
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 2685538..6ed28e9 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/elf.h>
 #include <linux/elfcore.h>
+#include <linux/module.h>
 
 #include <asm/processor.h>
 #include <asm/hardirq.h>
@@ -32,6 +33,72 @@
 /* This keeps a track of which one is crashing cpu. */
 static int crashing_cpu;
 
+static DEFINE_SPINLOCK(virt_disable_lock);
+static void (*virt_disable_fn)(unsigned int cpu);
+
+/**	set function to be called to disable virtualization on crash
+ *
+ *	Registers a function to be called when CPUs are being halted at
+ *	machine_crash_shutdown().
+ *
+ *	There is only one function pointer, so the function
+ *	is reserved to be set by the KVM module at load time, before
+ *	enabling virtualization.
+ *
+ *	The function is called once on each online CPU, possibly
+ *	from a NMI handler. It should do the very least to allow the CPU
+ *	to be halted before booting the kdump kernel, as the kernel has
+ *	just crashed.
+ */
+int set_virt_disable_func(void (*fn)(unsigned int cpu))
+{
+	int r = 0;
+
+	spin_lock(&virt_disable_lock);
+	if (!virt_disable_fn)
+		rcu_assign_pointer(virt_disable_fn, fn);
+	else
+		r = -EEXIST;
+	spin_unlock(&virt_disable_lock);
+
+	return r;
+}
+EXPORT_SYMBOL(set_virt_disable_func);
+
+/** clear the virt_disable function set by set_virt_disable_func()
+ *
+ * You must call this function only if you sucessfully set
+ * the virt_disable function on a previous set_virt_disable_func()
+ * call.
+ *
+ * This function will use synchronize_sched() to wait until it's safe
+ * to free any data or code related to the previous existing virt_disable
+ * func, before returning.
+ */
+void clear_virt_disable_func(void)
+{
+	spin_lock(&virt_disable_lock);
+	rcu_assign_pointer(virt_disable_fn, NULL);
+	spin_unlock(&virt_disable_lock);
+
+	synchronize_sched();
+}
+EXPORT_SYMBOL(clear_virt_disable_func);
+
+/* Disable virtualization extensions if needed
+ *
+ * Runs thefunction set by set_virt_disable_func()
+ *
+ * Must be called on the CPU that is being halted.
+ */
+void virt_disable(unsigned int cpu)
+{
+	void (*fn)(unsigned int);
+	fn = rcu_dereference(virt_disable_fn);
+	if (fn)
+		fn(cpu);
+}
+
 #if defined(CONFIG_SMP) && defined(CONFIG_X86_LOCAL_APIC)
 static atomic_t waiting_for_crash_ipi;
 
@@ -65,6 +132,8 @@ static int crash_nmi_callback(struct notifier_block *self,
 	}
 #endif
 	crash_save_cpu(regs, cpu);
+
+	virt_disable(cpu);
 	disable_local_APIC();
 	atomic_dec(&waiting_for_crash_ipi);
 	/* Assume hlt works */
@@ -134,6 +203,8 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 	/* Make a note of crashing cpu. Will be used in NMI callback.*/
 	crashing_cpu = safe_smp_processor_id();
 	nmi_shootdown_cpus();
+	virt_disable(crashing_cpu);
+
 	lapic_shutdown();
 #if defined(CONFIG_X86_IO_APIC)
 	disable_IO_APIC();
-- 
1.5.5.GIT


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
