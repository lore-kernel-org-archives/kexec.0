Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kY1OA-0001An-Ox
 for kexec@lists.infradead.org; Thu, 29 Oct 2020 06:26:23 +0000
Received: by mail-pg1-x541.google.com with SMTP id o7so1514036pgv.6
 for <kexec@lists.infradead.org>; Wed, 28 Oct 2020 23:26:21 -0700 (PDT)
Date: Thu, 29 Oct 2020 14:26:00 +0800
From: Pingfan Liu <kernelfans@gmail.com>
Subject: Re: [PATCH 0/3] warn and suppress irqflood
Message-ID: <20201029062600.GA71783@x1pad>
References: <1603346163-21645-1-git-send-email-kernelfans@gmail.com>
 <871rhq7j1h.fsf@nanos.tec.linutronix.de>
 <CAFgQCTvFwvvtPE0Eow4cebCEe5OD5OhgAQarckpbFc38Bphaag@mail.gmail.com>
 <CAHD1Q_x99XW1zDr5HpVR27F_ksHLkaxc2W83e-N6F_xLYKyGbQ@mail.gmail.com>
 <87y2js3ghv.fsf@nanos.tec.linutronix.de>
 <CAFgQCTtnKB+p5uhRu3JpmBvHbQ8Vhv0TrKek9_3CWbtbcyM1Kw@mail.gmail.com>
 <87tuueftou.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87tuueftou.fsf@nanos.tec.linutronix.de>
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
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Maulik Shah <mkshah@codeaurora.org>, Petr Mladek <pmladek@suse.com>, Oliver Neukum <oneukum@suse.com>, Jonathan Corbet <corbet@lwn.net>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Guilherme Piccoli <gpiccoli@canonical.com>, linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Lina Iyer <ilina@codeaurora.org>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Al Viro <viro@zeniv.linux.org.uk>, Bjorn Helgaas <helgaas@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, afzal mohammed <afzal.mohd.ma@gmail.com>, Kexec Mailing List <kexec@lists.infradead.org>, Mike Kravetz <mike.kravetz@oracle.com>

On Wed, Oct 28, 2020 at 12:58:41PM +0100, Thomas Gleixner wrote:
> On Wed, Oct 28 2020 at 14:02, Pingfan Liu wrote:
> > On Tue, Oct 27, 2020 at 3:59 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> Also Liu's patch only works if:
> >>
> >>   1) CONFIG_IRQ_TIME_ACCOUNTING is enabled
> >
> > I wonder whether it can not be a default option or not by the following method:
> >   DEFINE_STATIC_KEY_FALSE(irqtime_account), and enable it according to
> > a boot param.
> 
> How so?
> 
> 	config IRQ_TIME_ACCOUNTING
> 		depends on HAVE_IRQ_TIME_ACCOUNTING && !VIRT_CPU_ACCOUNTING_NATIVE
> 
Look closely at the two config value:
-1. HAVE_IRQ_TIME_ACCOUNTING, it is selected by most of the popular arches, and
can be further relaxed.
   It implies sched_clock() is fast enough for sampling. With current code, the
variable sched_clock_irqtime=0 can be used to turn off irqtime accounting on
some arches with slow sched_clock(). And it can be even better by using
DEFINE_STATIC_KEY_FALSE(sched_clock_irqtime)
   So the pre-requirement can be relaxed as "depends on !VIRT_CPU_ACCOUNTING_NATIVE"
In case that I can not express clearly, could you have a look at the demo patch?

   That patch _assumes_ that irqtime accounting costs much and is not turned on by
default. If turned on, it will cost an extra jmp than current implement.
And I think it is critical to my [1/3] whether this assumption is reasonable.

-2. For VIRT_CPU_ACCOUNTING_NATIVE, it can only be selected by powerpc and ia64

In fact, I have a seperate patch for powerpc with
CONFIG_VIRT_CPU_ACCOUNTING_NATIVE to utilize my [1/3].

---
diff --git a/init/Kconfig b/init/Kconfig
index c944691..16d168b 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -490,7 +490,7 @@ endchoice
 
 config IRQ_TIME_ACCOUNTING
 	bool "Fine granularity task level IRQ time accounting"
-	depends on HAVE_IRQ_TIME_ACCOUNTING && !VIRT_CPU_ACCOUNTING_NATIVE
+	depends on !VIRT_CPU_ACCOUNTING_NATIVE
 	help
 	  Select this option to enable fine granularity task irq time
 	  accounting. This is done by reading a timestamp on each
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 5a55d23..3ab7e1d 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -19,7 +19,7 @@
  */
 DEFINE_PER_CPU(struct irqtime, cpu_irqtime);
 
-static int sched_clock_irqtime;
+DEFINE_STATIC_KEY_FALSE(sched_clock_irqtime);
 
 void enable_sched_clock_irqtime(void)
 {
@@ -49,13 +49,14 @@ static void irqtime_account_delta(struct irqtime *irqtime, u64 delta,
  */
 void irqtime_account_irq(struct task_struct *curr)
 {
-	struct irqtime *irqtime = this_cpu_ptr(&cpu_irqtime);
+	struct irqtime *irqtime;
 	s64 delta;
 	int cpu;
 
-	if (!sched_clock_irqtime)
+	if (static_branch_unlikely(&sched_clock_irqtime))
 		return;
 
+	irqtime = this_cpu_ptr(&cpu_irqtime);
 	cpu = smp_processor_id();
 	delta = sched_clock_cpu(cpu) - irqtime->irq_start_time;
 	irqtime->irq_start_time += delta;
@@ -84,16 +85,7 @@ static u64 irqtime_tick_accounted(u64 maxtime)
 	return delta;
 }
 
-#else /* CONFIG_IRQ_TIME_ACCOUNTING */
-
-#define sched_clock_irqtime	(0)
-
-static u64 irqtime_tick_accounted(u64 dummy)
-{
-	return 0;
-}
-
-#endif /* !CONFIG_IRQ_TIME_ACCOUNTING */
+#endif
 
 static inline void task_group_account_field(struct task_struct *p, int index,
 					    u64 tmp)
@@ -475,7 +467,7 @@ void account_process_tick(struct task_struct *p, int user_tick)
 	if (vtime_accounting_enabled_this_cpu())
 		return;
 
-	if (sched_clock_irqtime) {
+	if (static_branch_unlikely(&sched_clock_irqtime))
 		irqtime_account_process_tick(p, user_tick, 1);
 		return;
 	}
@@ -504,7 +496,7 @@ void account_idle_ticks(unsigned long ticks)
 {
 	u64 cputime, steal;
 
-	if (sched_clock_irqtime) {
+	if (static_branch_unlikely(&sched_clock_irqtime))
 		irqtime_account_idle_ticks(ticks);
 		return;
 	}
-- 
2.7.5

[...]
> +
> +static int __init irqstorm_setup(char *arg)
> +{
> +	int res = kstrtoul(arg, 0, &irqstorm_limit);
> +
> +	if (!res) {
> +		pr_info("Interrupt storm detector enabled. Limit=%lu / s\n",
> +			irqstorm_limit);
> +	}
> +	return !!res;
> +}
> +__setup("irqstorm_limit", irqstorm_setup);

This configuration independent method looks appealing. And I am glad to have a try.

But irqstorm_limit may be a hard choice. Maybe by formula:
instruction-percpu-per-second / insn num of irq failed path ?  It is hard to
estimate "instruction-percpu-per-second".

Thanks,
Pingfan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
