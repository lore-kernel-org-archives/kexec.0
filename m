Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kXeY5-00032P-OK
 for kexec@lists.infradead.org; Wed, 28 Oct 2020 06:03:06 +0000
Received: by mail-il1-x142.google.com with SMTP id p10so3679702ile.3
 for <kexec@lists.infradead.org>; Tue, 27 Oct 2020 23:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <1603346163-21645-1-git-send-email-kernelfans@gmail.com>
 <871rhq7j1h.fsf@nanos.tec.linutronix.de>
 <CAFgQCTvFwvvtPE0Eow4cebCEe5OD5OhgAQarckpbFc38Bphaag@mail.gmail.com>
 <CAHD1Q_x99XW1zDr5HpVR27F_ksHLkaxc2W83e-N6F_xLYKyGbQ@mail.gmail.com>
 <87y2js3ghv.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87y2js3ghv.fsf@nanos.tec.linutronix.de>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Wed, 28 Oct 2020 14:02:45 +0800
Message-ID: <CAFgQCTtnKB+p5uhRu3JpmBvHbQ8Vhv0TrKek9_3CWbtbcyM1Kw@mail.gmail.com>
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

On Tue, Oct 27, 2020 at 3:59 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
[...]
>
> And contrary to Liu's patches which try to disable a requested interrupt
> if too many of them arrive, the kernel cannot do anything because there
> is nothing to disable in your case. That's why you needed to do the MSI
> disable magic in the early PCI quirks which run before interrupts get
> enabled.
>
> Also Liu's patch only works if:
>
>   1) CONFIG_IRQ_TIME_ACCOUNTING is enabled

I wonder whether it can not be a default option or not by the following method:
  DEFINE_STATIC_KEY_FALSE(irqtime_account), and enable it according to
a boot param.

This will have no impact on performance with the disabled branch.
Meanwhile users can easily turn on the option to detect an irq flood
without  recompiling the kernel.

If it is doable, I will rework only on [1/2].
>
>   2) the runaway interrupt has been requested by the relevant driver in
>      the dump kernel.

Yes, it raises a big challenge to my method. Kdump kernel miss the
whole picture of the first kernel's irq routing.

Thanks,
Pingfan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
