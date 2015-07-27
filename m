Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42])
 by merlin.infradead.org with esmtp (Exim 4.85 #2 (Red Hat Linux))
 id 1ZJahP-0003DW-69
 for kexec@lists.infradead.org; Mon, 27 Jul 2015 05:11:40 +0000
Subject: [V2 PATCH 1/3] x86/panic: Fix re-entrance problem due to panic on NMI
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Date: Mon, 27 Jul 2015 10:58:50 +0900
Message-ID: <20150727015850.4928.50289.stgit@softrs>
In-Reply-To: <20150727015850.4928.87717.stgit@softrs>
References: <20150727015850.4928.87717.stgit@softrs>
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
Cc: linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Ingo Molnar <mingo@redhat.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

If panic on NMI happens just after panic() on the same CPU, panic()
is recursively called.  As the result, it stalls after failing to
acquire panic_lock.

To avoid this problem, don't call panic() in NMI context if
we've already entered panic().

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
---
 arch/x86/kernel/nmi.c  |   15 +++++++++++----
 include/linux/kernel.h |    1 +
 kernel/panic.c         |   13 ++++++++++---
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index d05bd2e..5b32d81 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -230,7 +230,8 @@ void unregister_nmi_handler(unsigned int type, const char *name)
 	}
 #endif
 
-	if (panic_on_unrecovered_nmi)
+	if (panic_on_unrecovered_nmi &&
+	    atomic_cmpxchg(&panicking_cpu, -1, raw_smp_processor_id()) == -1)
 		panic("NMI: Not continuing");
 
 	pr_emerg("Dazed and confused, but trying to continue\n");
@@ -255,8 +256,13 @@ void unregister_nmi_handler(unsigned int type, const char *name)
 		 reason, smp_processor_id());
 	show_regs(regs);
 
-	if (panic_on_io_nmi)
-		panic("NMI IOCK error: Not continuing");
+	if (panic_on_io_nmi) {
+		if (atomic_cmpxchg(&panicking_cpu, -1, raw_smp_processor_id())
+		    == -1)
+			panic("NMI IOCK error: Not continuing");
+		else
+			return; /* We don't want to wait and re-enable NMI */
+	}
 
 	/* Re-enable the IOCK line, wait for a few seconds */
 	reason = (reason & NMI_REASON_CLEAR_MASK) | NMI_REASON_CLEAR_IOCHK;
@@ -296,7 +302,8 @@ void unregister_nmi_handler(unsigned int type, const char *name)
 		 reason, smp_processor_id());
 
 	pr_emerg("Do you have a strange power saving mode enabled?\n");
-	if (unknown_nmi_panic || panic_on_unrecovered_nmi)
+	if ((unknown_nmi_panic || panic_on_unrecovered_nmi) &&
+	    atomic_cmpxchg(&panicking_cpu, -1, raw_smp_processor_id()) == -1)
 		panic("NMI: Not continuing");
 
 	pr_emerg("Dazed and confused, but trying to continue\n");
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 5582410..8ca199b 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -442,6 +442,7 @@ extern __scanf(2, 0)
 extern int sysctl_panic_on_stackoverflow;
 
 extern bool crash_kexec_post_notifiers;
+extern atomic_t panicking_cpu;
 
 /*
  * Only to be used by arch init code. If the user over-wrote the default
diff --git a/kernel/panic.c b/kernel/panic.c
index 04e91ff..7e6b568 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -60,6 +60,8 @@ void __weak panic_smp_self_stop(void)
 		cpu_relax();
 }
 
+atomic_t panicking_cpu = ATOMIC_INIT(-1);
+
 /**
  *	panic - halt the system
  *	@fmt: The text string to print
@@ -70,17 +72,17 @@ void __weak panic_smp_self_stop(void)
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
+	 * after setting panicking_cpu) from invoking panic again.
 	 */
 	local_irq_disable();
 
@@ -93,8 +95,13 @@ void panic(const char *fmt, ...)
 	 * multiple parallel invocations of panic, all other CPUs either
 	 * stop themself or will wait until they are stopped by the 1st CPU
 	 * with smp_send_stop().
+	 *
+	 * `old_cpu == -1' means we are the first comer.
+	 * `old_cpu == this_cpu' means we came here due to panic on NMI.
 	 */
-	if (!spin_trylock(&panic_lock))
+	this_cpu = raw_smp_processor_id();
+	old_cpu = atomic_cmpxchg(&panicking_cpu, -1, this_cpu);
+	if (old_cpu != -1 && old_cpu != this_cpu)
 		panic_smp_self_stop();
 
 	console_verbose();



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
