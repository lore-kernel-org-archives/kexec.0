Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from m-relay2.rz.uni-saarland.de ([134.96.7.8]
	helo=eris.rz.uni-saarland.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KsamC-0002a9-3l
	for kexec@lists.infradead.org; Wed, 22 Oct 2008 10:17:16 +0000
From: Alexander van Heukelum <heukelum@fastmail.fm>
Subject: [PATCH 7/7] i386, dumpstack: unify die()
Date: Wed, 22 Oct 2008 12:00:14 +0200
Message-Id: <1224669614-25863-8-git-send-email-heukelum@fastmail.fm>
In-Reply-To: <1224669614-25863-7-git-send-email-heukelum@fastmail.fm>
References: <1224669614-25863-1-git-send-email-heukelum@fastmail.fm>
	<1224669614-25863-2-git-send-email-heukelum@fastmail.fm>
	<1224669614-25863-3-git-send-email-heukelum@fastmail.fm>
	<1224669614-25863-4-git-send-email-heukelum@fastmail.fm>
	<1224669614-25863-5-git-send-email-heukelum@fastmail.fm>
	<1224669614-25863-6-git-send-email-heukelum@fastmail.fm>
	<1224669614-25863-7-git-send-email-heukelum@fastmail.fm>
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

Make i386's die() equal to x86_64's version.

Whitespace-only changes on x86_64, to make it equal to i386's
version. (user_mode and user_mode_vm are equal on x86_64.)

Signed-off-by: Alexander van Heukelum <heukelum@fastmail.fm>
---
 arch/x86/kernel/dumpstack_32.c |   10 +++-------
 arch/x86/kernel/dumpstack_64.c |    6 +++++-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/dumpstack_32.c b/arch/x86/kernel/dumpstack_32.c
index e91ae34..f2046c5 100644
--- a/arch/x86/kernel/dumpstack_32.c
+++ b/arch/x86/kernel/dumpstack_32.c
@@ -378,15 +378,11 @@ void die(const char *str, struct pt_regs *regs, long err)
 	unsigned long flags = oops_begin();
 	int sig = SIGSEGV;
 
-	if (die_nest_count < 3) {
+	if (!user_mode_vm(regs))
 		report_bug(regs->ip, regs);
 
-		if (__die(str, regs, err))
-			sig = 0;
-	} else {
-		printk(KERN_EMERG "Recursive die() failure, output suppressed\n");
-	}
-
+	if (__die(str, regs, err))
+		sig = 0;
 	oops_end(flags, regs, sig);
 }
 
diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index 831e1e1..28c67aa 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -506,12 +506,16 @@ int __kprobes __die(const char *str, struct pt_regs *regs, long err)
 	return 0;
 }
 
+/*
+ * This is gone through when something in the kernel has done something bad
+ * and is about to be terminated:
+ */
 void die(const char *str, struct pt_regs *regs, long err)
 {
 	unsigned long flags = oops_begin();
 	int sig = SIGSEGV;
 
-	if (!user_mode(regs))
+	if (!user_mode_vm(regs))
 		report_bug(regs->ip, regs);
 
 	if (__die(str, regs, err))
-- 
1.5.4.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
