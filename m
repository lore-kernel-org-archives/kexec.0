Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from theia.rz.uni-saarland.de ([134.96.7.31])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Krx6G-00087c-Fx
	for kexec@lists.infradead.org; Mon, 20 Oct 2008 15:55:21 +0000
Date: Mon, 20 Oct 2008 17:08:34 +0200
From: Alexander van Heukelum <heukelum@mailshack.com>
Subject: [PATCH] x86: make oops_begin and oops_end equal
Message-ID: <20081020150834.GA26018@mailshack.com>
References: <20081017210013.GD23591@hmsreliant.think-freely.org>
	<20081020121339.GE10594@elte.hu>
	<20081020134211.GA15574@hmsreliant.think-freely.org>
	<20081020150731.GA25999@mailshack.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20081020150731.GA25999@mailshack.com>
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

Mostly use the x86_64 version of oops_begin() and oops_end() on
i386 too. Changes to the original x86_64 version:

 - move add_taint(TAINT_DIE) into oops_end()
 - add a conditional crash_kexec() into oops_end()

Signed-off-by: Alexander van Heukelum <heukelum@fastmail.fm>
---
 arch/x86/kernel/dumpstack_32.c |   36 +++++++++++++++++++++---------------
 arch/x86/kernel/dumpstack_64.c |    4 +++-
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/dumpstack_32.c b/arch/x86/kernel/dumpstack_32.c
index b361475..e45952b 100644
--- a/arch/x86/kernel/dumpstack_32.c
+++ b/arch/x86/kernel/dumpstack_32.c
@@ -289,35 +289,41 @@ static unsigned int die_nest_count;
 
 unsigned __kprobes long oops_begin(void)
 {
+	int cpu;
 	unsigned long flags;
 
 	oops_enter();
 
-	if (die_owner != raw_smp_processor_id()) {
-		console_verbose();
-		raw_local_irq_save(flags);
-		__raw_spin_lock(&die_lock);
-		die_owner = smp_processor_id();
-		die_nest_count = 0;
-		bust_spinlocks(1);
-	} else {
-		raw_local_irq_save(flags);
+	/* racy, but better than risking deadlock. */
+	raw_local_irq_save(flags);
+	cpu = smp_processor_id();
+	if (!__raw_spin_trylock(&die_lock)) {
+		if (cpu == die_owner)
+			/* nested oops. should stop eventually */;
+		else
+			__raw_spin_lock(&die_lock);
 	}
 	die_nest_count++;
+	die_owner = cpu;
+	console_verbose();
+	bust_spinlocks(1);
 	return flags;
 }
 
 void __kprobes oops_end(unsigned long flags, struct pt_regs *regs, int signr)
 {
-	bust_spinlocks(0);
 	die_owner = -1;
+	bust_spinlocks(0);
+	die_nest_count--;
 	add_taint(TAINT_DIE);
-	__raw_spin_unlock(&die_lock);
+	if (!die_nest_count)
+		/* Nest count reaches zero, release the lock. */
+		__raw_spin_unlock(&die_lock);
 	raw_local_irq_restore(flags);
-
-	if (!regs)
+	if (!regs) {
+		oops_exit();
 		return;
-
+	}
 	if (kexec_should_crash(current))
 		crash_kexec(regs);
 	if (in_interrupt())
@@ -405,6 +411,7 @@ die_nmi(char *str, struct pt_regs *regs, int do_panic)
 		panic("Non maskable interrupt");
 	console_silent();
 	spin_unlock(&nmi_print_lock);
+	bust_spinlocks(0);
 
 	/*
 	 * If we are in kernel we are probably nested up pretty bad
@@ -415,7 +422,6 @@ die_nmi(char *str, struct pt_regs *regs, int do_panic)
 		crash_kexec(regs);
 	}
 
-	bust_spinlocks(0);
 	do_exit(SIGSEGV);
 }
 
diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index 96a5db7..cd7b46b 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -461,6 +461,7 @@ void __kprobes oops_end(unsigned long flags, struct pt_regs *regs, int signr)
 	die_owner = -1;
 	bust_spinlocks(0);
 	die_nest_count--;
+	add_taint(TAINT_DIE);
 	if (!die_nest_count)
 		/* Nest count reaches zero, release the lock. */
 		__raw_spin_unlock(&die_lock);
@@ -469,6 +470,8 @@ void __kprobes oops_end(unsigned long flags, struct pt_regs *regs, int signr)
 		oops_exit();
 		return;
 	}
+	if (kexec_should_crash(current))
+		crash_kexec(regs);
 	if (in_interrupt())
 		panic("Fatal exception in interrupt");
 	if (panic_on_oops)
@@ -496,7 +499,6 @@ int __kprobes __die(const char *str, struct pt_regs *regs, long err)
 		return 1;
 
 	show_registers(regs);
-	add_taint(TAINT_DIE);
 	/* Executive summary in case the oops scrolled away */
 	printk(KERN_ALERT "RIP ");
 	printk_address(regs->ip, 1);
-- 
1.5.4.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
