Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail4.hitachi.co.jp ([133.145.228.5])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bXOex-0008KA-5O
 for kexec@lists.infradead.org; Wed, 10 Aug 2016 08:14:46 +0000
Subject: [V4 PATCH 1/2] x86/panic: Replace smp_send_stop() with kdump
 friendly version in panic path
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Date: Wed, 10 Aug 2016 17:09:48 +0900
Message-ID: <20160810080948.11028.15344.stgit@sysi4-13.yrl.intra.hitachi.co.jp>
In-Reply-To: <20160810080946.11028.97686.stgit@sysi4-13.yrl.intra.hitachi.co.jp>
References: <20160810080946.11028.97686.stgit@sysi4-13.yrl.intra.hitachi.co.jp>
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
To: Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, Ralf Baechle <ralf@linux-mips.org>
Cc: Daniel Walker <dwalker@fifo99.com>, linux-mips@linux-mips.org, Toshi Kani <toshi.kani@hpe.com>, Xunlei Pang <xpang@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Ingo Molnar <mingo@redhat.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>, Vivek Goyal <vgoyal@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>

Daniel Walker reported problems which happens when
crash_kexec_post_notifiers kernel option is enabled
(https://lkml.org/lkml/2015/6/24/44).

In that case, smp_send_stop() is called before entering kdump routines
which assume other CPUs are still online.  As the result, for x86,
kdump routines fail to save other CPUs' registers  and disable
virtualization extensions.

To fix this problem, call a new kdump friendly function,
crash_smp_send_stop(), instead of the smp_send_stop() when
crash_kexec_post_notifiers is enabled.  crash_smp_send_stop() is a
weak function, and it just call smp_send_stop().  Architecture
codes should override it so that kdump can work appropriately.
This patch only provides x86-specific version.

For Xen's PV kernel, just keep the current behavior.

Changes in V4:
- Keep to use smp_send_stop if crash_kexec_post_notifiers is not set
- Rename panic_smp_send_stop to crash_smp_send_stop
- Don't change the behavior for Xen's PV kernel

Changes in V3:
- Revise comments, description, and symbol names

Changes in V2:
- Replace smp_send_stop() call with crash_kexec version which
  saves cpu states and cleans up VMX/SVM
- Drop a fix for Problem 1 at this moment

Reported-by: Daniel Walker <dwalker@fifo99.com>
Fixes: f06e5153f4ae (kernel/panic.c: add "crash_kexec_post_notifiers" option)
Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Daniel Walker <dwalker@fifo99.com>
Cc: Xunlei Pang <xpang@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: David Vrabel <david.vrabel@citrix.com>
Cc: Toshi Kani <toshi.kani@hpe.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 arch/x86/include/asm/kexec.h |    1 +
 arch/x86/include/asm/smp.h   |    1 +
 arch/x86/kernel/crash.c      |   22 +++++++++++++++++---
 arch/x86/kernel/smp.c        |    5 ++++
 kernel/panic.c               |   47 ++++++++++++++++++++++++++++++++++++------
 5 files changed, 66 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index d2434c1..282630e 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -210,6 +210,7 @@ struct kexec_entry64_regs {
 
 typedef void crash_vmclear_fn(void);
 extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
+extern void kdump_nmi_shootdown_cpus(void);
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index ebd0c16..f70989c 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -50,6 +50,7 @@ struct smp_ops {
 	void (*smp_cpus_done)(unsigned max_cpus);
 
 	void (*stop_other_cpus)(int wait);
+	void (*crash_stop_other_cpus)(void);
 	void (*smp_send_reschedule)(int cpu);
 
 	int (*cpu_up)(unsigned cpu, struct task_struct *tidle);
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 9616cf7..650830e 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -133,15 +133,31 @@ static void kdump_nmi_callback(int cpu, struct pt_regs *regs)
 	disable_local_APIC();
 }
 
-static void kdump_nmi_shootdown_cpus(void)
+void kdump_nmi_shootdown_cpus(void)
 {
 	nmi_shootdown_cpus(kdump_nmi_callback);
 
 	disable_local_APIC();
 }
 
+/* Override the weak function in kernel/panic.c */
+void crash_smp_send_stop(void)
+{
+	static int cpus_stopped;
+
+	if (cpus_stopped)
+		return;
+
+	if (smp_ops.crash_stop_other_cpus)
+		smp_ops.crash_stop_other_cpus();
+	else
+		smp_send_stop();
+
+	cpus_stopped = 1;
+}
+
 #else
-static void kdump_nmi_shootdown_cpus(void)
+void crash_smp_send_stop(void)
 {
 	/* There are no cpus to shootdown */
 }
@@ -160,7 +176,7 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 	/* The kernel is broken so disable interrupts */
 	local_irq_disable();
 
-	kdump_nmi_shootdown_cpus();
+	crash_smp_send_stop();
 
 	/*
 	 * VMCLEAR VMCSs loaded on this cpu if needed.
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 658777c..68f8cc2 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -32,6 +32,8 @@
 #include <asm/nmi.h>
 #include <asm/mce.h>
 #include <asm/trace/irq_vectors.h>
+#include <asm/kexec.h>
+
 /*
  *	Some notes on x86 processor bugs affecting SMP operation:
  *
@@ -342,6 +344,9 @@ struct smp_ops smp_ops = {
 	.smp_cpus_done		= native_smp_cpus_done,
 
 	.stop_other_cpus	= native_stop_other_cpus,
+#if defined(CONFIG_KEXEC_CORE)
+	.crash_stop_other_cpus	= kdump_nmi_shootdown_cpus,
+#endif
 	.smp_send_reschedule	= native_smp_send_reschedule,
 
 	.cpu_up			= native_cpu_up,
diff --git a/kernel/panic.c b/kernel/panic.c
index ca8cea1..e6480e2 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -71,6 +71,32 @@ void __weak nmi_panic_self_stop(struct pt_regs *regs)
 	panic_smp_self_stop();
 }
 
+/*
+ * Stop other CPUs in panic.  Architecture dependent code may override this
+ * with more suitable version.  For example, if the architecture supports
+ * crash dump, it should save registers of each stopped CPU and disable
+ * per-CPU features such as virtualization extensions.
+ */
+void __weak crash_smp_send_stop(void)
+{
+	static int cpus_stopped;
+
+	/*
+	 * This function can be called twice in panic path, but obviously
+	 * we execute this only once.
+	 */
+	if (cpus_stopped)
+		return;
+
+	/*
+	 * Note smp_send_stop is the usual smp shutdown function, which
+	 * unfortunately means it may not be hardened to work in a panic
+	 * situation.
+	 */
+	smp_send_stop();
+	cpus_stopped = 1;
+}
+
 atomic_t panic_cpu = ATOMIC_INIT(PANIC_CPU_INVALID);
 
 /*
@@ -164,14 +190,21 @@ void panic(const char *fmt, ...)
 	if (!_crash_kexec_post_notifiers) {
 		printk_nmi_flush_on_panic();
 		__crash_kexec(NULL);
-	}
 
-	/*
-	 * Note smp_send_stop is the usual smp shutdown function, which
-	 * unfortunately means it may not be hardened to work in a panic
-	 * situation.
-	 */
-	smp_send_stop();
+		/*
+		 * Note smp_send_stop is the usual smp shutdown function, which
+		 * unfortunately means it may not be hardened to work in a
+		 * panic situation.
+		 */
+		smp_send_stop();
+	} else {
+		/*
+		 * If we want to do crash dump after notifier calls and
+		 * kmsg_dump, we will need architecture dependent extra
+		 * works in addition to stopping other CPUs.
+		 */
+		crash_smp_send_stop();
+	}
 
 	/*
 	 * Run any panic handlers, including those that might need to



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
