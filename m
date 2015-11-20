Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail4.hitachi.co.jp ([133.145.228.5])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZziC2-0005Q9-Ii
 for kexec@lists.infradead.org; Fri, 20 Nov 2015 09:41:27 +0000
Subject: [V5 PATCH 1/4] panic/x86: Fix re-entrance problem due to panic on NMI
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Date: Fri, 20 Nov 2015 18:36:44 +0900
Message-ID: <20151120093644.4285.9349.stgit@softrs>
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

If panic on NMI happens just after panic() on the same CPU, panic()
is recursively called.  As the result, it stalls after failing to
acquire panic_lock.

To avoid this problem, don't call panic() in NMI context if
we've already entered panic().

V4:
- Improve comments in io_check_error() and panic()

V3:
- Introduce nmi_panic() macro to reduce code duplication
- In the case of panic on NMI, don't return from NMI handlers
  if another cpu already panicked

V2:
- Use atomic_cmpxchg() instead of current spin_trylock() to
  exclude concurrent accesses to the panic routines
- Don't introduce no-lock version of panic()

Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Michal Hocko <mhocko@kernel.org>
---
 arch/x86/kernel/nmi.c  |   16 ++++++++++++----
 include/linux/kernel.h |   13 +++++++++++++
 kernel/panic.c         |   15 ++++++++++++---
 kernel/watchdog.c      |    2 +-
 4 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 697f90d..5131714 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -231,7 +231,7 @@ pci_serr_error(unsigned char reason, struct pt_regs *regs)
 #endif
 
 	if (panic_on_unrecovered_nmi)
-		panic("NMI: Not continuing");
+		nmi_panic("NMI: Not continuing");
 
 	pr_emerg("Dazed and confused, but trying to continue\n");
 
@@ -255,8 +255,16 @@ io_check_error(unsigned char reason, struct pt_regs *regs)
 		 reason, smp_processor_id());
 	show_regs(regs);
 
-	if (panic_on_io_nmi)
-		panic("NMI IOCK error: Not continuing");
+	if (panic_on_io_nmi) {
+		nmi_panic("NMI IOCK error: Not continuing");
+
+		/*
+		 * If we return from nmi_panic(), it means we have received
+		 * NMI while processing panic().  So, simply return without
+		 * a delay and re-enabling NMI.
+		 */
+		return;
+	}
 
 	/* Re-enable the IOCK line, wait for a few seconds */
 	reason = (reason & NMI_REASON_CLEAR_MASK) | NMI_REASON_CLEAR_IOCHK;
@@ -297,7 +305,7 @@ unknown_nmi_error(unsigned char reason, struct pt_regs *regs)
 
 	pr_emerg("Do you have a strange power saving mode enabled?\n");
 	if (unknown_nmi_panic || panic_on_unrecovered_nmi)
-		panic("NMI: Not continuing");
+		nmi_panic("NMI: Not continuing");
 
 	pr_emerg("Dazed and confused, but trying to continue\n");
 }
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 350dfb0..480a4fd 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -445,6 +445,19 @@ extern int sysctl_panic_on_stackoverflow;
 
 extern bool crash_kexec_post_notifiers;
 
+extern atomic_t panic_cpu;
+
+/*
+ * A variant of panic() called from NMI context.
+ * If we've already panicked on this cpu, return from here.
+ */
+#define nmi_panic(fmt, ...)						\
+	do {								\
+		int this_cpu = raw_smp_processor_id();			\
+		if (atomic_cmpxchg(&panic_cpu, -1, this_cpu) != this_cpu) \
+			panic(fmt, ##__VA_ARGS__);			\
+	} while (0)
+
 /*
  * Only to be used by arch init code. If the user over-wrote the default
  * CONFIG_PANIC_TIMEOUT, honor it.
diff --git a/kernel/panic.c b/kernel/panic.c
index 4579dbb..24ee2ea 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -61,6 +61,8 @@ void __weak panic_smp_self_stop(void)
 		cpu_relax();
 }
 
+atomic_t panic_cpu = ATOMIC_INIT(-1);
+
 /**
  *	panic - halt the system
  *	@fmt: The text string to print
@@ -71,17 +73,17 @@ void __weak panic_smp_self_stop(void)
  */
 void panic(const char *fmt, ...)
 {
-	static DEFINE_SPINLOCK(panic_lock);
 	static char buf[1024];
 	va_list args;
 	long i, i_next = 0;
 	int state = 0;
+	int old_cpu, this_cpu;
 
 	/*
 	 * Disable local interrupts. This will prevent panic_smp_self_stop
 	 * from deadlocking the first cpu that invokes the panic, since
 	 * there is nothing to prevent an interrupt handler (that runs
-	 * after the panic_lock is acquired) from invoking panic again.
+	 * after setting panic_cpu) from invoking panic again.
 	 */
 	local_irq_disable();
 
@@ -94,8 +96,15 @@ void panic(const char *fmt, ...)
 	 * multiple parallel invocations of panic, all other CPUs either
 	 * stop themself or will wait until they are stopped by the 1st CPU
 	 * with smp_send_stop().
+	 *
+	 * `old_cpu == -1' means this is the 1st CPU which comes here, so
+	 * go ahead.
+	 * `old_cpu == this_cpu' means we came from nmi_panic() which sets
+	 * panic_cpu to this cpu.  In this case, this is also the 1st CPU.
 	 */
-	if (!spin_trylock(&panic_lock))
+	this_cpu = raw_smp_processor_id();
+	old_cpu = atomic_cmpxchg(&panic_cpu, -1, this_cpu);
+	if (old_cpu != -1 && old_cpu != this_cpu)
 		panic_smp_self_stop();
 
 	console_verbose();
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 18f34cf..b9be18f 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -351,7 +351,7 @@ static void watchdog_overflow_callback(struct perf_event *event,
 			trigger_allbutself_cpu_backtrace();
 
 		if (hardlockup_panic)
-			panic("Hard LOCKUP");
+			nmi_panic("Hard LOCKUP");
 
 		__this_cpu_write(hard_watchdog_warn, true);
 		return;



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
