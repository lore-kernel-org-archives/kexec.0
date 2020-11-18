Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kfEH5-0008UM-Pd
 for kexec@lists.infradead.org; Wed, 18 Nov 2020 03:36:52 +0000
Received: by mail-pl1-x641.google.com with SMTP id t18so262895plo.0
 for <kexec@lists.infradead.org>; Tue, 17 Nov 2020 19:36:51 -0800 (PST)
From: Pingfan Liu <kernelfans@gmail.com>
Subject: [PATCH 2/3] kernel/watchdog: make watchdog_touch_ts more accurate by
 using nanosecond
Date: Wed, 18 Nov 2020 11:36:17 +0800
Message-Id: <1605670578-23681-3-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1605670578-23681-1-git-send-email-kernelfans@gmail.com>
References: <87tuueftou.fsf@nanos.tec.linutronix.de>
 <1605670578-23681-1-git-send-email-kernelfans@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Petr Mladek <pmladek@suse.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, "Guilherme G. Piccoli" <gpiccoli@canonical.com>, kexec@lists.infradead.org, Pingfan Liu <kernelfans@gmail.com>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>

The incoming statistics of irq average number will base on the delta of
watchdog_touch_ts. Improving the accuracy of watchdog_touch_ts from second
to nanosecond can help improve the accuracy of the statistics.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: kexec@lists.infradead.org
To: linux-kernel@vger.kernel.org
---
 kernel/watchdog.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 5abb5b2..1cc619a 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -207,7 +207,7 @@ static void __lockup_detector_cleanup(void);
  * the thresholds with a factor: we make the soft threshold twice the amount of
  * time the hard threshold is.
  */
-static int get_softlockup_thresh(void)
+static unsigned int get_softlockup_thresh(void)
 {
 	return watchdog_thresh * 2;
 }
@@ -217,9 +217,9 @@ static int get_softlockup_thresh(void)
  * resolution, and we don't need to waste time with a big divide when
  * 2^30ns == 1.074s.
  */
-static unsigned long get_timestamp(void)
+static unsigned long convert_seconds(unsigned long ns)
 {
-	return running_clock() >> 30LL;  /* 2^30 ~= 10^9 */
+	return ns >> 30LL;  /* 2^30 ~= 10^9 */
 }
 
 static void set_sample_period(void)
@@ -238,7 +238,7 @@ static void set_sample_period(void)
 /* Commands for resetting the watchdog */
 static void __touch_watchdog(void)
 {
-	__this_cpu_write(watchdog_touch_ts, get_timestamp());
+	__this_cpu_write(watchdog_touch_ts, running_clock());
 }
 
 /**
@@ -289,14 +289,15 @@ void touch_softlockup_watchdog_sync(void)
 	__this_cpu_write(watchdog_touch_ts, SOFTLOCKUP_RESET);
 }
 
-static int is_softlockup(unsigned long touch_ts)
+static unsigned long is_softlockup(unsigned long touch_ts)
 {
-	unsigned long now = get_timestamp();
+	unsigned long span, now = running_clock();
 
+	span = now - touch_ts;
 	if ((watchdog_enabled & SOFT_WATCHDOG_ENABLED) && watchdog_thresh){
 		/* Warn about unreasonable delays. */
-		if (time_after(now, touch_ts + get_softlockup_thresh()))
-			return now - touch_ts;
+		if (time_after(convert_seconds(span), (unsigned long)get_softlockup_thresh()))
+			return span;
 	}
 	return 0;
 }
@@ -340,9 +341,8 @@ static int softlockup_fn(void *data)
 /* watchdog kicker functions */
 static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 {
-	unsigned long touch_ts = __this_cpu_read(watchdog_touch_ts);
+	unsigned long duration, touch_ts = __this_cpu_read(watchdog_touch_ts);
 	struct pt_regs *regs = get_irq_regs();
-	int duration;
 	int softlockup_all_cpu_backtrace = sysctl_softlockup_all_cpu_backtrace;
 
 	if (!watchdog_enabled)
@@ -410,7 +410,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		}
 
 		pr_emerg("BUG: soft lockup - CPU#%d stuck for %us! [%s:%d]\n",
-			smp_processor_id(), duration,
+			smp_processor_id(), (unsigned int)convert_seconds(duration),
 			current->comm, task_pid_nr(current));
 		print_modules();
 		print_irqtrace_events(current);
-- 
2.7.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
