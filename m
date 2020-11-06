Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kauhS-00086g-Rz
 for kexec@lists.infradead.org; Fri, 06 Nov 2020 05:54:15 +0000
Received: by mail-il1-x143.google.com with SMTP id a20so77394ilk.13
 for <kexec@lists.infradead.org>; Thu, 05 Nov 2020 21:54:12 -0800 (PST)
MIME-Version: 1.0
References: <1603346163-21645-1-git-send-email-kernelfans@gmail.com>
 <871rhq7j1h.fsf@nanos.tec.linutronix.de>
 <CAFgQCTvFwvvtPE0Eow4cebCEe5OD5OhgAQarckpbFc38Bphaag@mail.gmail.com>
 <CAHD1Q_x99XW1zDr5HpVR27F_ksHLkaxc2W83e-N6F_xLYKyGbQ@mail.gmail.com>
 <87y2js3ghv.fsf@nanos.tec.linutronix.de>
 <CAFgQCTtnKB+p5uhRu3JpmBvHbQ8Vhv0TrKek9_3CWbtbcyM1Kw@mail.gmail.com>
 <87tuueftou.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87tuueftou.fsf@nanos.tec.linutronix.de>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Fri, 6 Nov 2020 13:53:59 +0800
Message-ID: <CAFgQCTsbW3sBGgUj+8LJagpf_AMNPrB+PDvcZ+pLgeoFtNWv=w@mail.gmail.com>
Subject: Re: [PATCH 0/3] warn and suppress irqflood
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

On Wed, Oct 28, 2020 at 7:58 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
[...]
> ---
>  include/linux/irqdesc.h |    4 ++
>  kernel/irq/manage.c     |    3 +
>  kernel/irq/spurious.c   |   74 +++++++++++++++++++++++++++++++++++-------------
>  3 files changed, 61 insertions(+), 20 deletions(-)
>
> --- a/include/linux/irqdesc.h
> +++ b/include/linux/irqdesc.h
> @@ -30,6 +30,8 @@ struct pt_regs;
>   * @tot_count:         stats field for non-percpu irqs
>   * @irq_count:         stats field to detect stalled irqs
>   * @last_unhandled:    aging timer for unhandled count
> + * @storm_count:       Counter for irq storm detection
> + * @storm_checked:     Timestamp for irq storm detection
>   * @irqs_unhandled:    stats field for spurious unhandled interrupts
>   * @threads_handled:   stats field for deferred spurious detection of threaded handlers
>   * @threads_handled_last: comparator field for deferred spurious detection of theraded handlers
> @@ -65,6 +67,8 @@ struct irq_desc {
>         unsigned int            tot_count;
>         unsigned int            irq_count;      /* For detecting broken IRQs */
>         unsigned long           last_unhandled; /* Aging timer for unhandled count */
> +       unsigned long           storm_count;
> +       unsigned long           storm_checked;
>         unsigned int            irqs_unhandled;
>         atomic_t                threads_handled;
>         int                     threads_handled_last;
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -1581,6 +1581,9 @@ static int
>         if (!shared) {
>                 init_waitqueue_head(&desc->wait_for_threads);
>
> +               /* Take a timestamp for interrupt storm detection */
> +               desc->storm_checked = jiffies;
> +
>                 /* Setup the type (level, edge polarity) if configured: */
>                 if (new->flags & IRQF_TRIGGER_MASK) {
>                         ret = __irq_set_trigger(desc,
> --- a/kernel/irq/spurious.c
> +++ b/kernel/irq/spurious.c
> @@ -21,6 +21,7 @@ static void poll_spurious_irqs(struct ti
>  static DEFINE_TIMER(poll_spurious_irq_timer, poll_spurious_irqs);
>  static int irq_poll_cpu;
>  static atomic_t irq_poll_active;
> +static unsigned long irqstorm_limit __ro_after_init;
>
>  /*
>   * We wait here for a poller to finish.
> @@ -189,18 +190,21 @@ static inline int bad_action_ret(irqretu
>   * (The other 100-of-100,000 interrupts may have been a correctly
>   *  functioning device sharing an IRQ with the failing one)
>   */
> -static void __report_bad_irq(struct irq_desc *desc, irqreturn_t action_ret)
> +static void __report_bad_irq(struct irq_desc *desc, irqreturn_t action_ret,
> +                            bool storm)
>  {
>         unsigned int irq = irq_desc_get_irq(desc);
>         struct irqaction *action;
>         unsigned long flags;
>
> -       if (bad_action_ret(action_ret)) {
> -               printk(KERN_ERR "irq event %d: bogus return value %x\n",
> -                               irq, action_ret);
> -       } else {
> -               printk(KERN_ERR "irq %d: nobody cared (try booting with "
> +       if (!storm) {
> +               if (bad_action_ret(action_ret)) {
> +                       pr_err("irq event %d: bogus return value %x\n",
> +                              irq, action_ret);
> +               } else {
> +                       pr_err("irq %d: nobody cared (try booting with "
>                                 "the \"irqpoll\" option)\n", irq);
> +               }
>         }
>         dump_stack();
>         printk(KERN_ERR "handlers:\n");
> @@ -228,7 +232,7 @@ static void report_bad_irq(struct irq_de
>
>         if (count > 0) {
>                 count--;
> -               __report_bad_irq(desc, action_ret);
> +               __report_bad_irq(desc, action_ret, false);
>         }
>  }
>
> @@ -267,6 +271,33 @@ try_misrouted_irq(unsigned int irq, stru
>         return action && (action->flags & IRQF_IRQPOLL);
>  }
>
> +static void disable_stuck_irq(struct irq_desc *desc, irqreturn_t action_ret,
> +                             const char *reason, bool storm)
> +{
> +       __report_bad_irq(desc, action_ret, storm);
> +       pr_emerg("Disabling %s IRQ #%d\n", reason, irq_desc_get_irq(desc));
> +       desc->istate |= IRQS_SPURIOUS_DISABLED;
> +       desc->depth++;
> +       irq_disable(desc);
> +}
> +
> +/* Interrupt storm detector for runaway interrupts (handled or not). */
> +static bool irqstorm_detected(struct irq_desc *desc)
> +{
> +       unsigned long now = jiffies;
> +
> +       if (++desc->storm_count < irqstorm_limit) {
> +               if (time_after(now, desc->storm_checked + HZ)) {
> +                       desc->storm_count = 0;
> +                       desc->storm_checked = now;
> +               }
> +               return false;
> +       }
> +
> +       disable_stuck_irq(desc, IRQ_NONE, "runaway", true);
> +       return true;
> +}
> +
>  #define SPURIOUS_DEFERRED      0x80000000
>
>  void note_interrupt(struct irq_desc *desc, irqreturn_t action_ret)
> @@ -403,24 +434,16 @@ void note_interrupt(struct irq_desc *des
>                         desc->irqs_unhandled -= ok;
>         }
>
> +       if (unlikely(irqstorm_limit && irqstorm_detected(desc)))
> +               return;
> +
>         desc->irq_count++;
>         if (likely(desc->irq_count < 100000))
>                 return;
>
>         desc->irq_count = 0;
>         if (unlikely(desc->irqs_unhandled > 99900)) {
> -               /*
> -                * The interrupt is stuck
> -                */
> -               __report_bad_irq(desc, action_ret);
> -               /*
> -                * Now kill the IRQ
> -                */
> -               printk(KERN_EMERG "Disabling IRQ #%d\n", irq);
> -               desc->istate |= IRQS_SPURIOUS_DISABLED;
> -               desc->depth++;
> -               irq_disable(desc);
> -
> +               disable_stuck_irq(desc, action_ret, "unhandled", false);
>                 mod_timer(&poll_spurious_irq_timer,
>                           jiffies + POLL_SPURIOUS_IRQ_INTERVAL);
>         }
> @@ -462,5 +485,16 @@ static int __init irqpoll_setup(char *st
>                                 "performance\n");
>         return 1;
>  }
> -
>  __setup("irqpoll", irqpoll_setup);
> +
> +static int __init irqstorm_setup(char *arg)
> +{
> +       int res = kstrtoul(arg, 0, &irqstorm_limit);
> +
> +       if (!res) {
> +               pr_info("Interrupt storm detector enabled. Limit=%lu / s\n",
> +                       irqstorm_limit);
> +       }
> +       return !!res;
> +}
> +__setup("irqstorm_limit", irqstorm_setup);
It should be
__setup("irqstorm_limit=", irqstorm_setup);

And I have tested this patch on the P9 machine, where I set the limit
to 70000. It works for kdump kernel.

Thanks,
Pingfan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
