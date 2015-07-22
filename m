Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZHobE-0006Y3-Da
 for kexec@lists.infradead.org; Wed, 22 Jul 2015 07:38:01 +0000
Subject: [PATCH 1/3] x86/panic: Fix re-entrance problem due to panic on NMI
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Date: Wed, 22 Jul 2015 11:14:21 +0900
Message-ID: <20150722021421.5155.9710.stgit@softrs>
In-Reply-To: <20150722021421.5155.74460.stgit@softrs>
References: <20150722021421.5155.74460.stgit@softrs>
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
Cc: linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

If panic on NMI happens just after panic() on the same CPU, panic()
is recursively called.  As the result, it stalls on panic_lock.

To avoid this problem, don't call panic() in NMI context if
we've already entered panic() (i.e. we hold panic_lock).

Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/kernel/nmi.c  |   18 ++++++++++++------
 include/linux/kernel.h |    4 ++++
 kernel/panic.c         |   33 +++++++++++++++++++++++++--------
 3 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index d05bd2e..c14b23f 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -230,8 +230,8 @@ void unregister_nmi_handler(unsigned int type, const char *name)
 	}
 #endif
 
-	if (panic_on_unrecovered_nmi)
-		panic("NMI: Not continuing");
+	if (panic_on_unrecovered_nmi && spin_trylock(&panic_lock))
+		__panic("NMI: Not continuing");
 
 	pr_emerg("Dazed and confused, but trying to continue\n");
 
@@ -255,8 +255,12 @@ void unregister_nmi_handler(unsigned int type, const char *name)
 		 reason, smp_processor_id());
 	show_regs(regs);
 
-	if (panic_on_io_nmi)
-		panic("NMI IOCK error: Not continuing");
+	if (panic_on_io_nmi) {
+		if (spin_trylock(&panic_lock))
+			__panic("NMI IOCK error: Not continuing");
+		else
+			return; /* We don't want to wait and re-enable NMI */
+	}
 
 	/* Re-enable the IOCK line, wait for a few seconds */
 	reason = (reason & NMI_REASON_CLEAR_MASK) | NMI_REASON_CLEAR_IOCHK;
@@ -296,8 +300,10 @@ void unregister_nmi_handler(unsigned int type, const char *name)
 		 reason, smp_processor_id());
 
 	pr_emerg("Do you have a strange power saving mode enabled?\n");
-	if (unknown_nmi_panic || panic_on_unrecovered_nmi)
-		panic("NMI: Not continuing");
+	if (unknown_nmi_panic || panic_on_unrecovered_nmi) {
+		if (spin_trylock(&panic_lock))
+			__panic("NMI: Not continuing");
+	}
 
 	pr_emerg("Dazed and confused, but trying to continue\n");
 }
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 5582410..be430dc 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -250,11 +250,15 @@ static inline u32 reciprocal_scale(u32 val, u32 ep_ro)
 static inline void might_fault(void) { }
 #endif
 
+typedef struct spinlock spinlock_t;
+extern spinlock_t panic_lock;
 extern struct atomic_notifier_head panic_notifier_list;
 extern long (*panic_blink)(int state);
 __printf(1, 2)
 void panic(const char *fmt, ...)
 	__noreturn __cold;
+void __panic(char *msg)
+	__noreturn __cold;
 extern void oops_enter(void);
 extern void oops_exit(void);
 void print_oops_end_marker(void);
diff --git a/kernel/panic.c b/kernel/panic.c
index 04e91ff..3c8338b 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -60,6 +60,8 @@ void __weak panic_smp_self_stop(void)
 		cpu_relax();
 }
 
+DEFINE_SPINLOCK(panic_lock);
+
 /**
  *	panic - halt the system
  *	@fmt: The text string to print
@@ -70,11 +72,8 @@ void __weak panic_smp_self_stop(void)
  */
 void panic(const char *fmt, ...)
 {
-	static DEFINE_SPINLOCK(panic_lock);
 	static char buf[1024];
 	va_list args;
-	long i, i_next = 0;
-	int state = 0;
 
 	/*
 	 * Disable local interrupts. This will prevent panic_smp_self_stop
@@ -97,12 +96,30 @@ void panic(const char *fmt, ...)
 	if (!spin_trylock(&panic_lock))
 		panic_smp_self_stop();
 
-	console_verbose();
-	bust_spinlocks(1);
 	va_start(args, fmt);
 	vsnprintf(buf, sizeof(buf), fmt, args);
 	va_end(args);
-	pr_emerg("Kernel panic - not syncing: %s\n", buf);
+
+	__panic(buf);
+}
+
+/**
+ *	__panic - no lock version of panic
+ *	@msg: The text string to print
+ *
+ *	Normally, please use panic().  This function can be used
+ *	only if panic_lock has already been held.
+ *
+ *	This function never returns.
+ */
+void __panic(char *msg)
+{
+	long i, i_next = 0;
+	int state = 0;
+
+	console_verbose();
+	bust_spinlocks(1);
+	pr_emerg("Kernel panic - not syncing: %s\n", msg);
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 	/*
 	 * Avoid nested stack-dumping if a panic occurs during oops processing
@@ -131,7 +148,7 @@ void panic(const char *fmt, ...)
 	 * Run any panic handlers, including those that might need to
 	 * add information to the kmsg dump output.
 	 */
-	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
+	atomic_notifier_call_chain(&panic_notifier_list, 0, msg);
 
 	kmsg_dump(KMSG_DUMP_PANIC);
 
@@ -190,7 +207,7 @@ void panic(const char *fmt, ...)
 		disabled_wait(caller);
 	}
 #endif
-	pr_emerg("---[ end Kernel panic - not syncing: %s\n", buf);
+	pr_emerg("---[ end Kernel panic - not syncing: %s\n", msg);
 	local_irq_enable();
 	for (i = 0; ; i += PANIC_TIMER_STEP) {
 		touch_softlockup_watchdog();



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
