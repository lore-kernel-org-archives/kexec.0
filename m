Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtWWp-0004Mp-9d
 for kexec@lists.infradead.org; Thu, 09 Jul 2020 13:23:57 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH v5 3/4] Revert "printk: lock/unlock console only for new
 logbuf entries"
Date: Thu,  9 Jul 2020 15:29:43 +0206
Message-Id: <20200709132344.760-4-john.ogness@linutronix.de>
In-Reply-To: <20200709132344.760-1-john.ogness@linutronix.de>
References: <20200709132344.760-1-john.ogness@linutronix.de>
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
To: Petr Mladek <pmladek@suse.com>
Cc: Andrea Parri <parri.andrea@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Paul McKenney <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

This reverts commit 3ac37a93fa9217e576bebfd4ba3e80edaaeb2289.

This optimization will not apply once the transition to a lockless
printk is complete. Rather than porting this optimization through
the transition only to remove it anyway, just revert it now to
simplify the transition.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b71eaf5f5a86..1b41e1b98221 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1981,9 +1981,8 @@ asmlinkage int vprintk_emit(int facility, int level,
 			    const char *fmt, va_list args)
 {
 	int printed_len;
-	bool in_sched = false, pending_output;
+	bool in_sched = false;
 	unsigned long flags;
-	u64 curr_log_seq;
 
 	/* Suppress unimportant messages after panic happens */
 	if (unlikely(suppress_printk))
@@ -1999,13 +1998,11 @@ asmlinkage int vprintk_emit(int facility, int level,
 
 	/* This stops the holder of console_sem just where we want him */
 	logbuf_lock_irqsave(flags);
-	curr_log_seq = log_next_seq;
 	printed_len = vprintk_store(facility, level, dict, dictlen, fmt, args);
-	pending_output = (curr_log_seq != log_next_seq);
 	logbuf_unlock_irqrestore(flags);
 
 	/* If called from the scheduler, we can not call up(). */
-	if (!in_sched && pending_output) {
+	if (!in_sched) {
 		/*
 		 * Disable preemption to avoid being preempted while holding
 		 * console_sem which would prevent anyone from printing to
@@ -2022,8 +2019,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 		preempt_enable();
 	}
 
-	if (pending_output)
-		wake_up_klogd();
+	wake_up_klogd();
 	return printed_len;
 }
 EXPORT_SYMBOL(vprintk_emit);
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
