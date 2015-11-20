Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZziC2-0005Q6-B0
 for kexec@lists.infradead.org; Fri, 20 Nov 2015 09:41:26 +0000
Subject: [V5 PATCH 2/4] panic/x86: Allow cpus to save registers even if they
 are looping in NMI context
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Date: Fri, 20 Nov 2015 18:36:46 +0900
Message-ID: <20151120093646.4285.62259.stgit@softrs>
In-Reply-To: <20151120093641.4285.97253.stgit@softrs>
References: <20151120093641.4285.97253.stgit@softrs>
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
To: Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

nmi_shootdown_cpus(), a subroutine of crash_kexec(), sends NMI IPI
to non-panic cpus to stop them while saving their register
information and doing some cleanups for crash dumping.  So if a
non-panic cpus is infinitely looping in NMI context, we fail to
save its register information and lose the information from the
crash dump.

`Infinite loop in NMI context' can happen:

  a. when a cpu panics on NMI while another cpu is processing panic
  b. when a cpu received an external or unknown NMI while another
     cpu is processing panic on NMI

In the case of a, it loops in panic_smp_self_stop().  In the case
of b, it loops in raw_spin_lock() of nmi_reason_lock.  This can
happen on some servers which broadcasts NMIs to all CPUs when a dump
button is pushed.

To save registers in these case too, this patch does following things:

1. Move the timing of `infinite loop in NMI context' (actually
   done by panic_smp_self_stop()) outside of panic() to enable us to
   refer pt_regs
2. call a callback of nmi_shootdown_cpus() directly to save
   registers and do some cleanups after setting waiting_for_crash_ipi
   which is used for counting down the number of cpus which handled
   the callback

V5:
- Use WRITE_ONCE() when setting crash_ipi_done to 1 so that the
  compiler doesn't change the instruction order
- Support the case of b in the above description
- Add poll_crash_ipi_and_callback()

V4:
- Rewrite the patch description

V3:
- Newly introduced

Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
---
 arch/x86/include/asm/reboot.h |    1 +
 arch/x86/kernel/nmi.c         |   17 +++++++++++++----
 arch/x86/kernel/reboot.c      |   28 ++++++++++++++++++++++++++++
 include/linux/kernel.h        |   12 ++++++++++--
 kernel/panic.c                |   10 ++++++++++
 kernel/watchdog.c             |    2 +-
 6 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/reboot.h b/arch/x86/include/asm/reboot.h
index a82c4f1..964e82f 100644
--- a/arch/x86/include/asm/reboot.h
+++ b/arch/x86/include/asm/reboot.h
@@ -25,5 +25,6 @@ void __noreturn machine_real_restart(unsigned int type);
 
 typedef void (*nmi_shootdown_cb)(int, struct pt_regs*);
 void nmi_shootdown_cpus(nmi_shootdown_cb callback);
+void poll_crash_ipi_and_callback(struct pt_regs *regs);
 
 #endif /* _ASM_X86_REBOOT_H */
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 5131714..74a1434 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -29,6 +29,7 @@
 #include <asm/mach_traps.h>
 #include <asm/nmi.h>
 #include <asm/x86_init.h>
+#include <asm/reboot.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/nmi.h>
@@ -231,7 +232,7 @@ pci_serr_error(unsigned char reason, struct pt_regs *regs)
 #endif
 
 	if (panic_on_unrecovered_nmi)
-		nmi_panic("NMI: Not continuing");
+		nmi_panic(regs, "NMI: Not continuing");
 
 	pr_emerg("Dazed and confused, but trying to continue\n");
 
@@ -256,7 +257,7 @@ io_check_error(unsigned char reason, struct pt_regs *regs)
 	show_regs(regs);
 
 	if (panic_on_io_nmi) {
-		nmi_panic("NMI IOCK error: Not continuing");
+		nmi_panic(regs, "NMI IOCK error: Not continuing");
 
 		/*
 		 * If we return from nmi_panic(), it means we have received
@@ -305,7 +306,7 @@ unknown_nmi_error(unsigned char reason, struct pt_regs *regs)
 
 	pr_emerg("Do you have a strange power saving mode enabled?\n");
 	if (unknown_nmi_panic || panic_on_unrecovered_nmi)
-		nmi_panic("NMI: Not continuing");
+		nmi_panic(regs, "NMI: Not continuing");
 
 	pr_emerg("Dazed and confused, but trying to continue\n");
 }
@@ -357,7 +358,15 @@ static void default_do_nmi(struct pt_regs *regs)
 	}
 
 	/* Non-CPU-specific NMI: NMI sources can be processed on any CPU */
-	raw_spin_lock(&nmi_reason_lock);
+
+	/*
+	 * Another CPU may be processing panic routines with holding
+	 * nmi_reason_lock.  Check IPI issuance from the panicking CPU
+	 * and call the callback directly.
+	 */
+	while (!raw_spin_trylock(&nmi_reason_lock))
+		poll_crash_ipi_and_callback(regs);
+
 	reason = x86_platform.get_nmi_reason();
 
 	if (reason & NMI_REASON_MASK) {
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 02693dd..44c5f5b 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -718,6 +718,7 @@ static int crashing_cpu;
 static nmi_shootdown_cb shootdown_callback;
 
 static atomic_t waiting_for_crash_ipi;
+static int crash_ipi_done;
 
 static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
 {
@@ -780,6 +781,9 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 
 	smp_send_nmi_allbutself();
 
+	/* Kick cpus looping in nmi context. */
+	WRITE_ONCE(crash_ipi_done, 1);
+
 	msecs = 1000; /* Wait at most a second for the other cpus to stop */
 	while ((atomic_read(&waiting_for_crash_ipi) > 0) && msecs) {
 		mdelay(1);
@@ -788,9 +792,33 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 
 	/* Leave the nmi callback set */
 }
+
+/*
+ * Wait for the timing of IPI for crash dumping, and then call its callback
+ * directly.  This function is used when we have already been in NMI handler.
+ */
+void poll_crash_ipi_and_callback(struct pt_regs *regs)
+{
+	if (crash_ipi_done)
+		crash_nmi_callback(0, regs); /* Shouldn't return */
+}
+
+/* Override the weak function in kernel/panic.c */
+void nmi_panic_self_stop(struct pt_regs *regs)
+{
+	while (1) {
+		poll_crash_ipi_and_callback(regs);
+		cpu_relax();
+	}
+}
+
 #else /* !CONFIG_SMP */
 void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 {
 	/* No other CPUs to shoot down */
 }
+
+void poll_crash_ipi_and_callback(struct pt_regs *regs)
+{
+}
 #endif
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 480a4fd..728a31b 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -255,6 +255,7 @@ extern long (*panic_blink)(int state);
 __printf(1, 2)
 void panic(const char *fmt, ...)
 	__noreturn __cold;
+void nmi_panic_self_stop(struct pt_regs *);
 extern void oops_enter(void);
 extern void oops_exit(void);
 void print_oops_end_marker(void);
@@ -450,12 +451,19 @@ extern atomic_t panic_cpu;
 /*
  * A variant of panic() called from NMI context.
  * If we've already panicked on this cpu, return from here.
+ * If another cpu already panicked, loop in nmi_panic_self_stop() which
+ * can provide architecture dependent code such as saving register states
+ * for crash dump.
  */
-#define nmi_panic(fmt, ...)						\
+#define nmi_panic(regs, fmt, ...)					\
 	do {								\
+		int old_cpu;						\
 		int this_cpu = raw_smp_processor_id();			\
-		if (atomic_cmpxchg(&panic_cpu, -1, this_cpu) != this_cpu) \
+		old_cpu = atomic_cmpxchg(&panic_cpu, -1, this_cpu);	\
+		if (old_cpu == -1)					\
 			panic(fmt, ##__VA_ARGS__);			\
+		else if (old_cpu != this_cpu)				\
+			nmi_panic_self_stop(regs);			\
 	} while (0)
 
 /*
diff --git a/kernel/panic.c b/kernel/panic.c
index 24ee2ea..4fce2be 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -61,6 +61,16 @@ void __weak panic_smp_self_stop(void)
 		cpu_relax();
 }
 
+/*
+ * Stop ourself in NMI context if another cpu has already panicked.
+ * Architecture code may override this to prepare for crash dumping
+ * (e.g. save register information).
+ */
+void __weak nmi_panic_self_stop(struct pt_regs *regs)
+{
+	panic_smp_self_stop();
+}
+
 atomic_t panic_cpu = ATOMIC_INIT(-1);
 
 /**
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index b9be18f..84b5035 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -351,7 +351,7 @@ static void watchdog_overflow_callback(struct perf_event *event,
 			trigger_allbutself_cpu_backtrace();
 
 		if (hardlockup_panic)
-			nmi_panic("Hard LOCKUP");
+			nmi_panic(regs, "Hard LOCKUP");
 
 		__this_cpu_write(hard_watchdog_warn, true);
 		return;



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
