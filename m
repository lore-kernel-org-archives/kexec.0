Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail4.hitachi.co.jp ([133.145.228.5])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a6qMW-0007iV-Tf
 for kexec@lists.infradead.org; Thu, 10 Dec 2015 01:49:46 +0000
Subject: [V6 PATCH 2/6] panic/x86: Allow CPUs to save registers even if they
 are looping in NMI context
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Date: Thu, 10 Dec 2015 10:46:28 +0900
Message-ID: <20151210014628.25437.75256.stgit@softrs>
In-Reply-To: <20151210014624.25437.50028.stgit@softrs>
References: <20151210014624.25437.50028.stgit@softrs>
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
Cc: Baoquan He <bhe@redhat.com>, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Michal Hocko <mhocko@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

Currently, kdump_nmi_shootdown_cpus(), a subroutine of crash_kexec(),
sends NMI IPI to non-panic CPUs to stop them and save their register
information and doing some cleanups for crash dumping.  However, if
a non-panic CPU is infinitely looping in NMI context, we fail to
save its register information into the crash dump.

For example, this can happen when unknown NMIs are broadcast to all
CPUs as follows (before applying this patch series):

  CPU 0                             CPU 1
  ===========================       ==========================
  receive an unknown NMI
  unknown_nmi_error()
    panic()                         receive an unknown NMI
      spin_trylock(&panic_lock)     unknown_nmi_error()
      crash_kexec()                   panic()
                                        spin_trylock(&panic_lock)
                                        panic_smp_self_stop()
                                          infinite loop
        kdump_nmi_shootdown_cpus()
          issue NMI IPI -----------> blocked until IRET
                                          infinite loop...

  Here, since CPU 1 is in NMI context, additional NMI from CPU 0
  is blocked until CPU 1 executes IRET.  However, CPU 1 never
  executes IRET, so the NMI is not handled and the callback function
  to save registers is never called.

  Actually, this can happen on some servers which broadcast NMIs to
  all CPUs when the dump button is pushed.

To save registers in this case, we need to:

  a) Return from NMI handler instead of looping infinitely
  or
  b) Call the callback function directly from the infinite loop

Inherently, a) is risky because NMI is also used to prevent corrupted
data from being propagated to devices.  So, we chose b).

This patch does following things:

1. Move the timing of `infinite loop in NMI context' (actually
   done by panic_smp_self_stop()) outside of panic() to enable us to
   refer pt_regs.  Please note that panic_smp_self_stop() is still
   used for normal context
2. Call a callback of kdump_nmi_shootdown_cpus() directly to save
   registers and do some cleanups after setting waiting_for_crash_ipi
   which is used for counting down the number of CPUs which handled
   the callback

V6:
- Revise the commit description and many comments
- Move changes involved with nmi_reason_lock to a later patch because
  it turned out there is no problem at this point
- Rename crash_ipi_done to crash_ipi_issued to clarify its meaning

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
 arch/x86/kernel/nmi.c    |    6 +++---
 arch/x86/kernel/reboot.c |   20 ++++++++++++++++++++
 include/linux/kernel.h   |   14 +++++++++++---
 kernel/panic.c           |   10 ++++++++++
 kernel/watchdog.c        |    2 +-
 5 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 5131714..5e00de7 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -231,7 +231,7 @@ pci_serr_error(unsigned char reason, struct pt_regs *regs)
 #endif
 
 	if (panic_on_unrecovered_nmi)
-		nmi_panic("NMI: Not continuing");
+		nmi_panic(regs, "NMI: Not continuing");
 
 	pr_emerg("Dazed and confused, but trying to continue\n");
 
@@ -256,7 +256,7 @@ io_check_error(unsigned char reason, struct pt_regs *regs)
 	show_regs(regs);
 
 	if (panic_on_io_nmi) {
-		nmi_panic("NMI IOCK error: Not continuing");
+		nmi_panic(regs, "NMI IOCK error: Not continuing");
 
 		/*
 		 * If we return from nmi_panic(), it means we have received
@@ -305,7 +305,7 @@ unknown_nmi_error(unsigned char reason, struct pt_regs *regs)
 
 	pr_emerg("Do you have a strange power saving mode enabled?\n");
 	if (unknown_nmi_panic || panic_on_unrecovered_nmi)
-		nmi_panic("NMI: Not continuing");
+		nmi_panic(regs, "NMI: Not continuing");
 
 	pr_emerg("Dazed and confused, but trying to continue\n");
 }
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 02693dd..1da1302 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -718,6 +718,7 @@ static int crashing_cpu;
 static nmi_shootdown_cb shootdown_callback;
 
 static atomic_t waiting_for_crash_ipi;
+static int crash_ipi_issued;
 
 static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
 {
@@ -780,6 +781,9 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 
 	smp_send_nmi_allbutself();
 
+	/* Kick CPUs looping in NMI context. */
+	WRITE_ONCE(crash_ipi_issued, 1);
+
 	msecs = 1000; /* Wait at most a second for the other cpus to stop */
 	while ((atomic_read(&waiting_for_crash_ipi) > 0) && msecs) {
 		mdelay(1);
@@ -788,6 +792,22 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 
 	/* Leave the nmi callback set */
 }
+
+/* Override the weak function in kernel/panic.c */
+void nmi_panic_self_stop(struct pt_regs *regs)
+{
+	while (1) {
+		/*
+		 * Wait for the crash dumping IPI to be issued, and then
+		 * call its callback directly.
+		 */
+		if (READ_ONCE(crash_ipi_issued))
+			crash_nmi_callback(0, regs); /* Don't return */
+
+		cpu_relax();
+	}
+}
+
 #else /* !CONFIG_SMP */
 void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 {
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index db66867..f28eebb 100644
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
@@ -457,13 +458,20 @@ extern atomic_t panic_cpu;
 /*
  * A variant of panic() called from NMI context.
  * If we've already panicked on this CPU, return from here.
+ * If another CPU already panicked, loop in nmi_panic_self_stop() which
+ * can provide architecture dependent code such as saving register states
+ * for crash dump.
  */
-#define nmi_panic(fmt, ...)						\
+#define nmi_panic(regs, fmt, ...)					\
 	do {								\
+		int old_cpu;						\
 		int this_cpu = raw_smp_processor_id();			\
-		if (atomic_cmpxchg(&panic_cpu, PANIC_CPU_INVALID, this_cpu) \
-		    != this_cpu)					\
+		old_cpu = atomic_cmpxchg(&panic_cpu, PANIC_CPU_INVALID,	\
+					 this_cpu);			\
+		if (old_cpu == PANIC_CPU_INVALID)			\
 			panic(fmt, ##__VA_ARGS__);			\
+		else if (old_cpu != this_cpu)				\
+			nmi_panic_self_stop(regs);			\
 	} while (0)
 
 /*
diff --git a/kernel/panic.c b/kernel/panic.c
index 3261e2d..3d6c3f1 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -61,6 +61,16 @@ void __weak panic_smp_self_stop(void)
 		cpu_relax();
 }
 
+/*
+ * Stop ourselves in NMI context if another cpu has already panicked.
+ * Architecture code may override this to prepare for crash dumping
+ * (e.g. save register information).
+ */
+void __weak nmi_panic_self_stop(struct pt_regs *regs)
+{
+	panic_smp_self_stop();
+}
+
 atomic_t panic_cpu = ATOMIC_INIT(PANIC_CPU_INVALID);
 
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
