Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from m-relay2.rz.uni-saarland.de ([134.96.7.8]
	helo=eris.rz.uni-saarland.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KsbEL-0000EH-Hj
	for kexec@lists.infradead.org; Wed, 22 Oct 2008 10:46:21 +0000
From: Alexander van Heukelum <heukelum@fastmail.fm>
Subject: [PATCH 1/7] i386,
	dumpstack: Move crash_kexec before bust_spinlocks(0) in oops_end
Date: Wed, 22 Oct 2008 12:00:08 +0200
Message-Id: <1224669614-25863-2-git-send-email-heukelum@fastmail.fm>
In-Reply-To: <1224669614-25863-1-git-send-email-heukelum@fastmail.fm>
References: <1224669614-25863-1-git-send-email-heukelum@fastmail.fm>
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
Cc: Alexander van Heukelum <heukelum@fastmail.fm>, Neil Horman <nhorman@tuxdriver.com>

crash_kexec should not be called with console_sem held. Move
the call before bust_spinlocks(0) in oops_end to avoid the
problem.

Signed-off-by: Alexander van Heukelum <heukelum@fastmail.fm>
Cc: "Neil Horman" <nhorman@tuxdriver.com>
---
 arch/x86/kernel/dumpstack_32.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/dumpstack_32.c b/arch/x86/kernel/dumpstack_32.c
index b361475..5493d31 100644
--- a/arch/x86/kernel/dumpstack_32.c
+++ b/arch/x86/kernel/dumpstack_32.c
@@ -309,6 +309,9 @@ unsigned __kprobes long oops_begin(void)
 
 void __kprobes oops_end(unsigned long flags, struct pt_regs *regs, int signr)
 {
+	if (regs && kexec_should_crash(current))
+		crash_kexec(regs);
+
 	bust_spinlocks(0);
 	die_owner = -1;
 	add_taint(TAINT_DIE);
@@ -318,8 +321,6 @@ void __kprobes oops_end(unsigned long flags, struct pt_regs *regs, int signr)
 	if (!regs)
 		return;
 
-	if (kexec_should_crash(current))
-		crash_kexec(regs);
 	if (in_interrupt())
 		panic("Fatal exception in interrupt");
 	if (panic_on_oops)
-- 
1.5.4.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
