Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail4.hitachi.co.jp ([133.145.228.5])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZNE1y-0001DG-Ot
 for kexec@lists.infradead.org; Thu, 06 Aug 2015 05:47:59 +0000
Subject: [V3 PATCH 2/4] panic/x86: Allow cpus to save registers even if they
 are looping in NMI context
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Date: Thu, 06 Aug 2015 14:45:43 +0900
Message-ID: <20150806054543.25766.5526.stgit@softrs>
In-Reply-To: <20150806054543.25766.29590.stgit@softrs>
References: <20150806054543.25766.29590.stgit@softrs>
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

When cpu-A panics on NMI just after cpu-B has panicked, cpu-A loops
infinitely in NMI context.  Especially for x86, cpu-B issues NMI IPI
to other cpus to save their register states and do some cleanups if
kdump is enabled, but cpu-A can't handle the NMI and fails to save
register states.

To solve thie issue, we wait for the timing of the NMI IPI, then
call the NMI handler which saves register states.

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
 arch/x86/kernel/reboot.c |   11 +++++++++++
 include/linux/kernel.h   |   12 ++++++++++--
 kernel/panic.c           |   10 ++++++++++
 kernel/watchdog.c        |    5 +++--
 5 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index dcd4038..fbb1877 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -231,7 +231,7 @@ void unregister_nmi_handler(unsigned int type, const char *name)
 #endif
 
 	if (panic_on_unrecovered_nmi)
-		nmi_panic("NMI: Not continuing");
+		nmi_panic(regs, "NMI: Not continuing");
 
 	pr_emerg("Dazed and confused, but trying to continue\n");
 
@@ -256,7 +256,7 @@ void unregister_nmi_handler(unsigned int type, const char *name)
 	show_regs(regs);
 
 	if (panic_on_io_nmi) {
-		nmi_panic("NMI IOCK error: Not continuing");
+		nmi_panic(regs, "NMI IOCK error: Not continuing");
 
 		/*
 		 * If we return from here, we've already being in panic.
@@ -304,7 +304,7 @@ void unregister_nmi_handler(unsigned int type, const char *name)
 
 	pr_emerg("Do you have a strange power saving mode enabled?\n");
 	if (unknown_nmi_panic || panic_on_unrecovered_nmi)
-		nmi_panic("NMI: Not continuing");
+		nmi_panic(regs, "NMI: Not continuing");
 
 	pr_emerg("Dazed and confused, but trying to continue\n");
 }
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 86db4bc..299b4b7 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -718,6 +718,7 @@ void machine_crash_shutdown(struct pt_regs *regs)
 static nmi_shootdown_cb shootdown_callback;
 
 static atomic_t waiting_for_crash_ipi;
+static int crash_ipi_done;
 
 static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
 {
@@ -779,6 +780,7 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 	wmb();
 
 	smp_send_nmi_allbutself();
+	crash_ipi_done = 1; /* Kick cpus looping in nmi context */
 
 	msecs = 1000; /* Wait at most a second for the other cpus to stop */
 	while ((atomic_read(&waiting_for_crash_ipi) > 0) && msecs) {
@@ -788,6 +790,15 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 
 	/* Leave the nmi callback set */
 }
+
+void nmi_panic_self_stop(struct pt_regs *regs)
+{
+	while (crash_ipi_done == 0)
+		cpu_relax();
+
+	crash_nmi_callback(0, regs); /* Shouldn't return */
+}
+
 #else /* !CONFIG_SMP */
 void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 {
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 57c33da..9fe9961 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -255,6 +255,7 @@ static inline void might_fault(void) { }
 __printf(1, 2)
 void panic(const char *fmt, ...)
 	__noreturn __cold;
+void nmi_panic_self_stop(struct pt_regs *);
 extern void oops_enter(void);
 extern void oops_exit(void);
 void print_oops_end_marker(void);
@@ -448,12 +449,19 @@ extern __scanf(2, 0)
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
index 3d4bc73..415c4e7 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -60,6 +60,16 @@ void __weak panic_smp_self_stop(void)
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
index 9a3d738..8e3a31c 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -304,8 +304,9 @@ static void watchdog_overflow_callback(struct perf_event *event,
 			return;
 
 		if (hardlockup_panic)
-			nmi_panic("Watchdog detected hard LOCKUP on cpu %d",
-			      this_cpu);
+			nmi_panic(regs,
+				  "Watchdog detected hard LOCKUP on cpu %d",
+				  this_cpu);
 		else
 			WARN(1, "Watchdog detected hard LOCKUP on cpu %d",
 			     this_cpu);



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
