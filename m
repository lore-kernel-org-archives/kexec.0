Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from m-relay2.rz.uni-saarland.de ([134.96.7.8]
	helo=eris.rz.uni-saarland.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KsamA-000292-QQ
	for kexec@lists.infradead.org; Wed, 22 Oct 2008 10:17:15 +0000
From: Alexander van Heukelum <heukelum@fastmail.fm>
Subject: [PATCH 6/7] i386, dumpstack: use oops_begin/oops_end in die_nmi
Date: Wed, 22 Oct 2008 12:00:13 +0200
Message-Id: <1224669614-25863-7-git-send-email-heukelum@fastmail.fm>
In-Reply-To: <1224669614-25863-6-git-send-email-heukelum@fastmail.fm>
References: <1224669614-25863-1-git-send-email-heukelum@fastmail.fm>
	<1224669614-25863-2-git-send-email-heukelum@fastmail.fm>
	<1224669614-25863-3-git-send-email-heukelum@fastmail.fm>
	<1224669614-25863-4-git-send-email-heukelum@fastmail.fm>
	<1224669614-25863-5-git-send-email-heukelum@fastmail.fm>
	<1224669614-25863-6-git-send-email-heukelum@fastmail.fm>
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

Use oops_begin and oops_end in die_nmi.

Whitespace-only changes on x86_64, to make it equal to i386's
version.

Signed-off-by: Alexander van Heukelum <heukelum@fastmail.fm>
---
 arch/x86/kernel/dumpstack_32.c |   33 +++++++++++----------------------
 arch/x86/kernel/dumpstack_64.c |    4 ++--
 2 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/dumpstack_32.c b/arch/x86/kernel/dumpstack_32.c
index 7c7d691..e91ae34 100644
--- a/arch/x86/kernel/dumpstack_32.c
+++ b/arch/x86/kernel/dumpstack_32.c
@@ -390,40 +390,29 @@ void die(const char *str, struct pt_regs *regs, long err)
 	oops_end(flags, regs, sig);
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
 	/*
-	* We are in trouble anyway, lets at least try
-	* to get a message out:
-	*/
-	bust_spinlocks(1);
+	 * We are in trouble anyway, lets at least try
+	 * to get a message out.
+	 */
+	flags = oops_begin();
 	printk(KERN_EMERG "%s", str);
 	printk(" on CPU%d, ip %08lx, registers:\n",
 		smp_processor_id(), regs->ip);
 	show_registers(regs);
-	if (do_panic)
+	oops_end(flags, regs, 0);
+	if (do_panic || panic_on_oops)
 		panic("Non maskable interrupt");
-	console_silent();
-	spin_unlock(&nmi_print_lock);
-
-	/*
-	 * If we are in kernel we are probably nested up pretty bad
-	 * and might aswell get out now while we still can:
-	 */
-	if (!user_mode_vm(regs)) {
-		current->thread.trap_no = 2;
-		crash_kexec(regs);
-	}
-
-	bust_spinlocks(0);
-	do_exit(SIGSEGV);
+	nmi_exit();
+	local_irq_enable();
+	do_exit(SIGBUS);
 }
 
 static int __init oops_setup(char *s)
diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index dc6162b..831e1e1 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -519,7 +519,7 @@ void die(const char *str, struct pt_regs *regs, long err)
 	oops_end(flags, regs, sig);
 }
 
-notrace __kprobes void
+void notrace __kprobes
 die_nmi(char *str, struct pt_regs *regs, int do_panic)
 {
 	unsigned long flags;
@@ -527,11 +527,11 @@ die_nmi(char *str, struct pt_regs *regs, int do_panic)
 	if (notify_die(DIE_NMIWATCHDOG, str, regs, 0, 2, SIGINT) == NOTIFY_STOP)
 		return;
 
-	flags = oops_begin();
 	/*
 	 * We are in trouble anyway, lets at least try
 	 * to get a message out.
 	 */
+	flags = oops_begin();
 	printk(KERN_EMERG "%s", str);
 	printk(" on CPU%d, ip %08lx, registers:\n",
 		smp_processor_id(), regs->ip);
-- 
1.5.4.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
