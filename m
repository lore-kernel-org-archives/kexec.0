Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVTaX-0004wb-DX
 for kexec@lists.infradead.org; Thu, 22 Oct 2020 05:56:38 +0000
Received: by mail-pf1-x441.google.com with SMTP id w21so459510pfc.7
 for <kexec@lists.infradead.org>; Wed, 21 Oct 2020 22:56:36 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
Subject: [PATCH 1/3] kernel/watchdog: show irq percentage if irq floods
Date: Thu, 22 Oct 2020 13:56:01 +0800
Message-Id: <1603346163-21645-2-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1603346163-21645-1-git-send-email-kernelfans@gmail.com>
References: <1603346163-21645-1-git-send-email-kernelfans@gmail.com>
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
Cc: Maulik Shah <mkshah@codeaurora.org>, Petr Mladek <pmladek@suse.com>, Oliver Neukum <oneukum@suse.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, "Guilherme G. Piccoli" <gpiccoli@canonical.com>, linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Pingfan Liu <kernelfans@gmail.com>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Lina Iyer <ilina@codeaurora.org>, kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, Mike Kravetz <mike.kravetz@oracle.com>, afzal mohammed <afzal.mohd.ma@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>

In kdump case, the capture kernel has no chance to shutdown devices, and
leave the devices in unstable state. Irq flood is one of the consequence.

When irq floods, the kernel is totally occupies by irq.  Currently, there
may be nothing or just soft lockup warning showed in console. It is better
to warn users with irq flood info.

Soft lockup watchdog is a good foundation to implement the detector. A irq
flood is reported if the following two conditions are met:
  -1. the irq occupies too much (98%) of the past interval.
  -2. no tasks has been scheduled in the past interval. This is implemented
      by check_hint.
      A note: is_softlockup() implies the 2nd condition, but unfortunately, irq
      flood can come from anywhere. If irq_enter_rcu()->tick_irq_enter(), then
      touch_softlockup_watchdog_sched() will reset watchdog, and softlockup is
      never detected.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: afzal mohammed <afzal.mohd.ma@gmail.com>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Maulik Shah <mkshah@codeaurora.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Oliver Neukum <oneukum@suse.com>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: kexec@lists.infradead.org
---
 kernel/watchdog.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 5abb5b2..230ac38 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -23,6 +23,7 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/isolation.h>
 #include <linux/stop_machine.h>
+#include <linux/kernel_stat.h>
 
 #include <asm/irq_regs.h>
 #include <linux/kvm_para.h>
@@ -175,6 +176,13 @@ static DEFINE_PER_CPU(bool, softlockup_touch_sync);
 static DEFINE_PER_CPU(bool, soft_watchdog_warn);
 static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts);
 static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts_saved);
+
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+static DEFINE_PER_CPU(long, check_hint) = {-1};
+static DEFINE_PER_CPU(unsigned long, last_irq_ts);
+static DEFINE_PER_CPU(unsigned long, last_total_ts);
+#endif
+
 static unsigned long soft_lockup_nmi_warn;
 
 static int __init nowatchdog_setup(char *str)
@@ -331,12 +339,43 @@ static DEFINE_PER_CPU(struct cpu_stop_work, softlockup_stop_work);
  */
 static int softlockup_fn(void *data)
 {
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+	__this_cpu_write(check_hint, -1);
+#endif
 	__touch_watchdog();
 	complete(this_cpu_ptr(&softlockup_completion));
 
 	return 0;
 }
 
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+static void check_irq_flood(void)
+{
+	unsigned long irqts, totalts, percent, cnt;
+	u64 *cpustat = kcpustat_this_cpu->cpustat;
+
+	totalts = running_clock();
+	irqts = cpustat[CPUTIME_IRQ] + cpustat[CPUTIME_SOFTIRQ];
+	cnt = __this_cpu_inc_return(check_hint);
+
+	if (cnt >= 5) {
+		totalts = totalts - __this_cpu_read(last_total_ts);
+		irqts = irqts - __this_cpu_read(last_irq_ts);
+		percent = irqts * 100 / totalts;
+		percent =  percent < 100 ? percent : 100;
+		__this_cpu_write(check_hint, -1);
+		if (percent >= 98)
+			pr_info("Irq flood occupies more than %lu%% of the past %lu seconds\n",
+				percent, totalts >> 30);
+	} else if (cnt == 0) {
+		__this_cpu_write(last_total_ts, totalts);
+		__this_cpu_write(last_irq_ts, irqts);
+	}
+}
+#else
+static void check_irq_flood(void){}
+#endif
+
 /* watchdog kicker functions */
 static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 {
@@ -348,6 +387,8 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	if (!watchdog_enabled)
 		return HRTIMER_NORESTART;
 
+	/* When irq floods, watchdog may be still touched. Hence it can not be done inside lockup */
+	check_irq_flood();
 	/* kick the hardlockup detector */
 	watchdog_interrupt_count();
 
-- 
2.7.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
