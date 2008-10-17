Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from charlotte.tuxdriver.com ([70.61.120.58] helo=smtp.tuxdriver.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KqwSr-0006I0-PL
	for kexec@lists.infradead.org; Fri, 17 Oct 2008 21:02:31 +0000
Date: Fri, 17 Oct 2008 17:00:13 -0400
From: Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH] kexec: fix hang on i386 when panic occurs while
	console_sem is held
Message-ID: <20081017210013.GD23591@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Disposition: inline
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
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: nhorman@tuxdriver.com, hbabu@us.ibm.com, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, akpm@linux-foundation.org, vgoyal@redhat.com

Hey all-
	Theres a corner case in 32 bit x86 kdump at the moment.  When the box
panics via nmi, we call bust_spinlocks(1) to disable sensitivity to the
console_sem (allowing us to print to the console in all cases), but we don't
call crash_kexec, until after we call bust_spinlocks(0), which re-enables
console_sem sensitivity.  The result is that, if we get an nmi while the
console_sem is held and kdump is configured, and we try to print something to
the console during kdump shutdown (which we often do) we deadlock the box.  The
fix is to simply do what 64 bit die_nmi does which is to not call
bust_spinlocks(0) until after we call crash_kexec.  Patch below tested
successfully by me:

Regards
Neil

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>


 dumpstack_32.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/arch/x86/kernel/dumpstack_32.c b/arch/x86/kernel/dumpstack_32.c
index 1a78180..b361475 100644
--- a/arch/x86/kernel/dumpstack_32.c
+++ b/arch/x86/kernel/dumpstack_32.c
@@ -405,7 +405,6 @@ die_nmi(char *str, struct pt_regs *regs, int do_panic)
 		panic("Non maskable interrupt");
 	console_silent();
 	spin_unlock(&nmi_print_lock);
-	bust_spinlocks(0);
 
 	/*
 	 * If we are in kernel we are probably nested up pretty bad
@@ -416,6 +415,7 @@ die_nmi(char *str, struct pt_regs *regs, int do_panic)
 		crash_kexec(regs);
 	}
 
+	bust_spinlocks(0);
 	do_exit(SIGSEGV);
 }
 
-- 
/****************************************************
 * Neil Horman <nhorman@tuxdriver.com>
 * Software Engineer, Red Hat
 ****************************************************/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
