Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from m-relay2.rz.uni-saarland.de ([134.96.7.8]
	helo=eris.rz.uni-saarland.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KsadJ-0002mo-Rk
	for kexec@lists.infradead.org; Wed, 22 Oct 2008 10:08:06 +0000
From: Alexander van Heukelum <heukelum@fastmail.fm>
Subject: [PATCH 3/7] x86_64, dumpstack: move kexec_crash from __die to oops_end
Date: Wed, 22 Oct 2008 12:00:10 +0200
Message-Id: <1224669614-25863-4-git-send-email-heukelum@fastmail.fm>
In-Reply-To: <1224669614-25863-3-git-send-email-heukelum@fastmail.fm>
References: <1224669614-25863-1-git-send-email-heukelum@fastmail.fm>
	<1224669614-25863-2-git-send-email-heukelum@fastmail.fm>
	<1224669614-25863-3-git-send-email-heukelum@fastmail.fm>
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

oops_end is preceded by either a call to __die, or a conditional
call to crash_kexec. Move the conditional call to crash_kexec
from the end of __die to the start of oops_end and remove
the superfluous call to crash_kexec in die_nmi.

Signed-off-by: Alexander van Heukelum <heukelum@fastmail.fm>
---
 arch/x86/kernel/dumpstack_64.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index ffefea6..57ce11b 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -458,6 +458,9 @@ unsigned __kprobes long oops_begin(void)
 
 void __kprobes oops_end(unsigned long flags, struct pt_regs *regs, int signr)
 {
+	if (regs && kexec_should_crash(current))
+		crash_kexec(regs);
+
 	die_owner = -1;
 	bust_spinlocks(0);
 	die_nest_count--;
@@ -501,8 +504,6 @@ int __kprobes __die(const char *str, struct pt_regs *regs, long err)
 	printk(KERN_ALERT "RIP ");
 	printk_address(regs->ip, 1);
 	printk(" RSP <%016lx>\n", regs->sp);
-	if (kexec_should_crash(current))
-		crash_kexec(regs);
 	return 0;
 }
 
@@ -536,11 +537,9 @@ die_nmi(char *str, struct pt_regs *regs, int do_panic)
 	printk(" on CPU%d, ip %08lx, registers:\n",
 		smp_processor_id(), regs->ip);
 	show_registers(regs);
-	if (kexec_should_crash(current))
-		crash_kexec(regs);
+	oops_end(flags, regs, 0);
 	if (do_panic || panic_on_oops)
 		panic("Non maskable interrupt");
-	oops_end(flags, regs, 0);
 	nmi_exit();
 	local_irq_enable();
 	do_exit(SIGBUS);
-- 
1.5.4.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
