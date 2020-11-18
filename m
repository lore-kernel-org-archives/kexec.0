Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kfEHB-0008W8-4z
 for kexec@lists.infradead.org; Wed, 18 Nov 2020 03:36:58 +0000
Received: by mail-pj1-x1041.google.com with SMTP id mn12so1272187pjb.1
 for <kexec@lists.infradead.org>; Tue, 17 Nov 2020 19:36:56 -0800 (PST)
From: Pingfan Liu <kernelfans@gmail.com>
Subject: [PATCH 3/3] kernel/watchdog: use soft lockup to detect irq flood
Date: Wed, 18 Nov 2020 11:36:18 +0800
Message-Id: <1605670578-23681-4-git-send-email-kernelfans@gmail.com>
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

When irq flood happens, interrupt handler occupies all of the cpu time.
This results in a situation where soft lockup can be observed, although it
is different from the design purpose of soft lockup.

In order to distinguish this situation, it is helpful to print out the
statistics of irq frequency when warning soft lockup to evaluate the
potential irq flood.

Thomas and Guilherme suggested patches to suppress the odd irq in different
situation. [1].[2]. But it seems to be an open question in a near future. For now,
it had better print some hints for users than nothing.

[1]: https://lore.kernel.org/lkml/87tuueftou.fsf@nanos.tec.linutronix.de/
[2]: https://lore.kernel.org/linux-pci/20181018183721.27467-1-gpiccoli@canonical.com/

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
 kernel/watchdog.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 1cc619a..a0ab2a8 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -23,6 +23,7 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/isolation.h>
 #include <linux/stop_machine.h>
+#include <linux/kernel_stat.h>
 
 #include <asm/irq_regs.h>
 #include <linux/kvm_para.h>
@@ -175,6 +176,9 @@ static DEFINE_PER_CPU(bool, softlockup_touch_sync);
 static DEFINE_PER_CPU(bool, soft_watchdog_warn);
 static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts);
 static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts_saved);
+static DEFINE_PER_CPU(unsigned long, last_irq_sum);
+static DEFINE_PER_CPU(unsigned long, last_unused_irq_sum);
+
 static unsigned long soft_lockup_nmi_warn;
 
 static int __init nowatchdog_setup(char *str)
@@ -353,6 +357,8 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 
 	/* kick the softlockup detector */
 	if (completion_done(this_cpu_ptr(&softlockup_completion))) {
+		__this_cpu_write(last_irq_sum, kstat_this_cpu->irqs_sum);
+		__this_cpu_write(last_unused_irq_sum, kstat_this_cpu->unused_irqs_sum);
 		reinit_completion(this_cpu_ptr(&softlockup_completion));
 		stop_one_cpu_nowait(smp_processor_id(),
 				softlockup_fn, NULL,
@@ -386,6 +392,9 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	 */
 	duration = is_softlockup(touch_ts);
 	if (unlikely(duration)) {
+		unsigned long irq_sum, unused_irq_sum;
+		unsigned int seconds;
+
 		/*
 		 * If a virtual machine is stopped by the host it can look to
 		 * the watchdog like a soft lockup, check to see if the host
@@ -409,9 +418,15 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 			}
 		}
 
+		irq_sum = kstat_this_cpu->irqs_sum - __this_cpu_read(last_irq_sum);
+		unused_irq_sum = kstat_this_cpu->unused_irqs_sum -
+			__this_cpu_read(last_unused_irq_sum);
+		seconds = (unsigned int)convert_seconds(duration);
 		pr_emerg("BUG: soft lockup - CPU#%d stuck for %us! [%s:%d]\n",
-			smp_processor_id(), (unsigned int)convert_seconds(duration),
+			smp_processor_id(), seconds,
 			current->comm, task_pid_nr(current));
+		pr_emerg("%lu irqs at rate: %lu / s, %lu unused irq at rate: %lu / s\n",
+			irq_sum, irq_sum/seconds, unused_irq_sum, unused_irq_sum/seconds);
 		print_modules();
 		print_irqtrace_events(current);
 		if (regs)
-- 
2.7.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
