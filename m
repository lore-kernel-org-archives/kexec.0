Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from m-relay2.rz.uni-saarland.de ([134.96.7.8]
	helo=eris.rz.uni-saarland.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KsbEQ-0000EH-Kr
	for kexec@lists.infradead.org; Wed, 22 Oct 2008 10:46:27 +0000
From: Alexander van Heukelum <heukelum@fastmail.fm>
Subject: [PATCH 2/7] x86, dumpstack: let signr=0 signal no do_exit
Date: Wed, 22 Oct 2008 12:00:09 +0200
Message-Id: <1224669614-25863-3-git-send-email-heukelum@fastmail.fm>
In-Reply-To: <1224669614-25863-2-git-send-email-heukelum@fastmail.fm>
References: <1224669614-25863-1-git-send-email-heukelum@fastmail.fm>
	<1224669614-25863-2-git-send-email-heukelum@fastmail.fm>
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
To: Neil Horman <nhorman@tuxdriver.com>, Ingo Molnar <mingo@elte.hu>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com, hbabu@us.ibm.com, hpa@zytor.com, akpm@linux-foundation.org, Alexander van Heukelum <heukelum@fastmail.fm>, ebiederm@xmission.com, tglx@linutronix.de
Cc: Alexander van Heukelum <heukelum@fastmail.fm>

Change oops_end such that signr=0 signals that do_exit
is not to be called.

Currently, each use of __die is soon followed by a call
to oops_end and 'regs' is set to NULL if oops_end is expected
not to call do_exit. Change all such pairs to set signr=0
instead. On x86_64 oops_end is used 'bare' in die_nmi; use
signr=0 instead of regs=NULL there, too.

Signed-off-by: Alexander van Heukelum <heukelum@fastmail.fm>
---
 arch/x86/kernel/dumpstack_32.c |    7 ++++---
 arch/x86/kernel/dumpstack_64.c |    9 +++++----
 arch/x86/mm/fault.c            |   11 +++++++----
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/dumpstack_32.c b/arch/x86/kernel/dumpstack_32.c
index 5493d31..7c22f99 100644
--- a/arch/x86/kernel/dumpstack_32.c
+++ b/arch/x86/kernel/dumpstack_32.c
@@ -318,7 +318,7 @@ void __kprobes oops_end(unsigned long flags, struct pt_regs *regs, int signr)
 	__raw_spin_unlock(&die_lock);
 	raw_local_irq_restore(flags);
 
-	if (!regs)
+	if (!signr)
 		return;
 
 	if (in_interrupt())
@@ -371,17 +371,18 @@ int __kprobes __die(const char *str, struct pt_regs *regs, long err)
 void die(const char *str, struct pt_regs *regs, long err)
 {
 	unsigned long flags = oops_begin();
+	int sig = SIGSEGV;
 
 	if (die_nest_count < 3) {
 		report_bug(regs->ip, regs);
 
 		if (__die(str, regs, err))
-			regs = NULL;
+			sig = 0;
 	} else {
 		printk(KERN_EMERG "Recursive die() failure, output suppressed\n");
 	}
 
-	oops_end(flags, regs, SIGSEGV);
+	oops_end(flags, regs, sig);
 }
 
 static DEFINE_SPINLOCK(nmi_print_lock);
diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index 96a5db7..ffefea6 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -465,7 +465,7 @@ void __kprobes oops_end(unsigned long flags, struct pt_regs *regs, int signr)
 		/* Nest count reaches zero, release the lock. */
 		__raw_spin_unlock(&die_lock);
 	raw_local_irq_restore(flags);
-	if (!regs) {
+	if (!signr) {
 		oops_exit();
 		return;
 	}
@@ -509,13 +509,14 @@ int __kprobes __die(const char *str, struct pt_regs *regs, long err)
 void die(const char *str, struct pt_regs *regs, long err)
 {
 	unsigned long flags = oops_begin();
+	int sig = SIGSEGV;
 
 	if (!user_mode(regs))
 		report_bug(regs->ip, regs);
 
 	if (__die(str, regs, err))
-		regs = NULL;
-	oops_end(flags, regs, SIGSEGV);
+		sig = 0;
+	oops_end(flags, regs, sig);
 }
 
 notrace __kprobes void
@@ -539,7 +540,7 @@ die_nmi(char *str, struct pt_regs *regs, int do_panic)
 		crash_kexec(regs);
 	if (do_panic || panic_on_oops)
 		panic("Non maskable interrupt");
-	oops_end(flags, NULL, SIGBUS);
+	oops_end(flags, regs, 0);
 	nmi_exit();
 	local_irq_enable();
 	do_exit(SIGBUS);
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 8e52e68..ed9ee30 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -415,6 +415,7 @@ static noinline void pgtable_bad(unsigned long address, struct pt_regs *regs,
 				 unsigned long error_code)
 {
 	unsigned long flags = oops_begin();
+	int sig = SIGKILL;
 	struct task_struct *tsk;
 
 	printk(KERN_ALERT "%s: Corrupted page table at address %lx\n",
@@ -425,8 +426,8 @@ static noinline void pgtable_bad(unsigned long address, struct pt_regs *regs,
 	tsk->thread.trap_no = 14;
 	tsk->thread.error_code = error_code;
 	if (__die("Bad pagetable", regs, error_code))
-		regs = NULL;
-	oops_end(flags, regs, SIGKILL);
+		sig = 0;
+	oops_end(flags, regs, sig);
 }
 #endif
 
@@ -594,6 +595,7 @@ void __kprobes do_page_fault(struct pt_regs *regs, unsigned long error_code)
 
 #ifdef CONFIG_X86_64
 	unsigned long flags;
+	int sig;
 #endif
 
 	tsk = current;
@@ -868,11 +870,12 @@ no_context:
 	bust_spinlocks(0);
 	do_exit(SIGKILL);
 #else
+	sig = SIGKILL;
 	if (__die("Oops", regs, error_code))
-		regs = NULL;
+		sig = 0;
 	/* Executive summary in case the body of the oops scrolled away */
 	printk(KERN_EMERG "CR2: %016lx\n", address);
-	oops_end(flags, regs, SIGKILL);
+	oops_end(flags, regs, sig);
 #endif
 
 /*
-- 
1.5.4.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
