Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from theia.rz.uni-saarland.de ([134.96.7.31])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Krx6A-00087c-BW
	for kexec@lists.infradead.org; Mon, 20 Oct 2008 15:55:14 +0000
Date: Mon, 20 Oct 2008 17:11:06 +0200
From: Alexander van Heukelum <heukelum@mailshack.com>
Subject: [PATCH] x86, dumpstack: make die and die_nmi equal
Message-ID: <20081020151106.GA26034@mailshack.com>
References: <20081017210013.GD23591@hmsreliant.think-freely.org>
	<20081020121339.GE10594@elte.hu>
	<20081020134211.GA15574@hmsreliant.think-freely.org>
	<20081020150731.GA25999@mailshack.com>
	<20081020150834.GA26018@mailshack.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20081020150834.GA26018@mailshack.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Neil Horman <nhorman@tuxdriver.com>
Cc: Alexander van Heukelum <heukelum@fastmail.fm>, akpm@linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de, vgoyal@redhat.com

Use the x86_64 version of die() and die_nmi() on i386 too.
Changes to the original x86_64-version have no influence
on the generated code:

 - whitespace, comments
 - use user_mode_vm() instead of user_mode()

Signed-off-by: Alexander van Heukelum <heukelum@fastmail.fm>
---
 arch/x86/kernel/dumpstack_32.c |   40 ++++++++++++++--------------------------
 arch/x86/kernel/dumpstack_64.c |    9 +++++++--
 2 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kernel/dumpstack_32.c b/arch/x86/kernel/dumpstack_32.c
index e45952b..6f00938 100644
--- a/arch/x86/kernel/dumpstack_32.c
+++ b/arch/x86/kernel/dumpstack_32.c
@@ -377,52 +377,40 @@ void die(const char *str, struct pt_regs *regs, long err)
 {
 	unsigned long flags = oops_begin();
 
-	if (die_nest_count < 3) {
+	if (!user_mode_vm(regs))
 		report_bug(regs->ip, regs);
 
-		if (__die(str, regs, err))
-			regs = NULL;
-	} else {
-		printk(KERN_EMERG "Recursive die() failure, output suppressed\n");
-	}
+	if (__die(str, regs, err))
+		regs = NULL;
 
 	oops_end(flags, regs, SIGSEGV);
 }
 
-static DEFINE_SPINLOCK(nmi_print_lock);
-
 void notrace __kprobes
 die_nmi(char *str, struct pt_regs *regs, int do_panic)
 {
+	unsigned long flags;
+
 	if (notify_die(DIE_NMIWATCHDOG, str, regs, 0, 2, SIGINT) == NOTIFY_STOP)
 		return;
 
-	spin_lock(&nmi_print_lock);
+	flags = oops_begin();
 	/*
 	* We are in trouble anyway, lets at least try
-	* to get a message out:
+	* to get a message out.
 	*/
-	bust_spinlocks(1);
 	printk(KERN_EMERG "%s", str);
 	printk(" on CPU%d, ip %08lx, registers:\n",
 		smp_processor_id(), regs->ip);
 	show_registers(regs);
-	if (do_panic)
-		panic("Non maskable interrupt");
-	console_silent();
-	spin_unlock(&nmi_print_lock);
-	bust_spinlocks(0);
-
-	/*
-	 * If we are in kernel we are probably nested up pretty bad
-	 * and might aswell get out now while we still can:
-	 */
-	if (!user_mode_vm(regs)) {
-		current->thread.trap_no = 2;
+	if (kexec_should_crash(current))
 		crash_kexec(regs);
-	}
-
-	do_exit(SIGSEGV);
+	if (do_panic || panic_on_oops)
+		panic("Non maskable interrupt");
+	oops_end(flags, NULL, SIGBUS);
+	nmi_exit();
+	local_irq_enable();
+	do_exit(SIGBUS);
 }
 
 static int __init oops_setup(char *s)
diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index cd7b46b..dbcca05 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -508,19 +508,24 @@ int __kprobes __die(const char *str, struct pt_regs *regs, long err)
 	return 0;
 }
 
+/*
+ * This is gone through when something in the kernel has done something bad
+ * and is about to be terminated:
+ */
 void die(const char *str, struct pt_regs *regs, long err)
 {
 	unsigned long flags = oops_begin();
 
-	if (!user_mode(regs))
+	if (!user_mode_vm(regs))
 		report_bug(regs->ip, regs);
 
 	if (__die(str, regs, err))
 		regs = NULL;
+
 	oops_end(flags, regs, SIGSEGV);
 }
 
-notrace __kprobes void
+void notrace __kprobes
 die_nmi(char *str, struct pt_regs *regs, int do_panic)
 {
 	unsigned long flags;
-- 
1.5.4.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
