Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVTaf-0004yX-8k
 for kexec@lists.infradead.org; Thu, 22 Oct 2020 05:56:46 +0000
Received: by mail-pj1-x1043.google.com with SMTP id g16so417308pjv.3
 for <kexec@lists.infradead.org>; Wed, 21 Oct 2020 22:56:44 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
Subject: [PATCH 2/3] kernel/watchdog: suppress max irq when irq floods
Date: Thu, 22 Oct 2020 13:56:02 +0800
Message-Id: <1603346163-21645-3-git-send-email-kernelfans@gmail.com>
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

The capture kernel should try its best to save the crash info. Normally,
irq flood is caused by some trivial devices, which has no impact on saving
vmcore.

Introducing a parameter "irqflood_suppress" to enable suppress irq flood.

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
 include/linux/irq.h   |  2 ++
 kernel/irq/spurious.c | 32 ++++++++++++++++++++++++++++++++
 kernel/watchdog.c     |  9 ++++++++-
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 1b7f4df..140cb61 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -684,6 +684,8 @@ extern void note_interrupt(struct irq_desc *desc, irqreturn_t action_ret);
 /* Enable/disable irq debugging output: */
 extern int noirqdebug_setup(char *str);
 
+void suppress_max_irq(void);
+
 /* Checks whether the interrupt can be requested by request_irq(): */
 extern int can_request_irq(unsigned int irq, unsigned long irqflags);
 
diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
index f865e5f..d3d94d6 100644
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -464,3 +464,35 @@ static int __init irqpoll_setup(char *str)
 }
 
 __setup("irqpoll", irqpoll_setup);
+
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+
+static bool irqflood_suppress;
+
+static int __init irqflood_suppress_setup(char *str)
+{
+	irqflood_suppress = true;
+	pr_info("enable auto suppress irqflood\n");
+	return 1;
+}
+__setup("irqflood_suppress", irqflood_suppress_setup);
+
+void suppress_max_irq(void)
+{
+	unsigned int tmp, maxirq = 0, max = 0;
+	int irq;
+
+	if (!irqflood_suppress)
+		return;
+	for_each_active_irq(irq) {
+		tmp = kstat_irqs_cpu(irq, smp_processor_id());
+		if (max < tmp) {
+			maxirq = irq;
+			max = tmp;
+		}
+	}
+	pr_warn("Suppress irq:%u, which is triggered %u times\n",
+		maxirq, max);
+	disable_irq_nosync(maxirq);
+}
+#endif
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 230ac38..28a74e5 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -24,6 +24,7 @@
 #include <linux/sched/isolation.h>
 #include <linux/stop_machine.h>
 #include <linux/kernel_stat.h>
+#include <linux/irq.h>
 
 #include <asm/irq_regs.h>
 #include <linux/kvm_para.h>
@@ -364,9 +365,15 @@ static void check_irq_flood(void)
 		percent = irqts * 100 / totalts;
 		percent =  percent < 100 ? percent : 100;
 		__this_cpu_write(check_hint, -1);
-		if (percent >= 98)
+		if (percent >= 98) {
 			pr_info("Irq flood occupies more than %lu%% of the past %lu seconds\n",
 				percent, totalts >> 30);
+			/*
+			 * Suppress top irq when scheduler does not work for long time and irq
+			 * occupies too much time.
+			 */
+			suppress_max_irq();
+		}
 	} else if (cnt == 0) {
 		__this_cpu_write(last_total_ts, totalts);
 		__this_cpu_write(last_irq_ts, irqts);
-- 
2.7.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
