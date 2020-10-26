Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kX97E-00019f-0W
 for kexec@lists.infradead.org; Mon, 26 Oct 2020 20:29:17 +0000
Received: from mail-ed1-f69.google.com ([209.85.208.69])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <guilherme.piccoli@canonical.com>) id 1kX97C-0003sf-Ie
 for kexec@lists.infradead.org; Mon, 26 Oct 2020 20:29:14 +0000
Received: by mail-ed1-f69.google.com with SMTP id i9so5486674edx.10
 for <kexec@lists.infradead.org>; Mon, 26 Oct 2020 13:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <1603346163-21645-1-git-send-email-kernelfans@gmail.com>
 <871rhq7j1h.fsf@nanos.tec.linutronix.de>
 <CAFgQCTvFwvvtPE0Eow4cebCEe5OD5OhgAQarckpbFc38Bphaag@mail.gmail.com>
 <CAHD1Q_x99XW1zDr5HpVR27F_ksHLkaxc2W83e-N6F_xLYKyGbQ@mail.gmail.com>
 <87y2js3ghv.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87y2js3ghv.fsf@nanos.tec.linutronix.de>
From: Guilherme Piccoli <gpiccoli@canonical.com>
Date: Mon, 26 Oct 2020 17:28:33 -0300
Message-ID: <CAHD1Q_yvb43P+b6PUzK4a1jU+RH3Shv2=4bO69nh5VDWXgv-ww@mail.gmail.com>
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
Cc: Maulik Shah <mkshah@codeaurora.org>, Petr Mladek <pmladek@suse.com>, Oliver Neukum <oneukum@suse.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Pingfan Liu <kernelfans@gmail.com>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Lina Iyer <ilina@codeaurora.org>, Bjorn Helgaas <helgaas@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Kravetz <mike.kravetz@oracle.com>, afzal mohammed <afzal.mohd.ma@gmail.com>, Kexec Mailing List <kexec@lists.infradead.org>, Al Viro <viro@zeniv.linux.org.uk>

On Mon, Oct 26, 2020 at 4:59 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, Oct 26 2020 at 12:06, Guilherme Piccoli wrote:
> > On Sun, Oct 25, 2020 at 8:12 AM Pingfan Liu <kernelfans@gmail.com> wrote:
> >
> > Some time ago (2 years) we faced a similar issue in x86-64, a hard to
> > debug problem in kdump, that eventually was narrowed to a buggy NIC FW
> > flooding IRQs in kdump kernel, and no messages showed (although kernel
> > changed a lot since that time, today we might have better IRQ
> > handling/warning). We tried an early-boot fix, by disabling MSIs (as
> > per PCI spec) early in x86 boot, but it wasn't accepted - Bjorn asked
> > pertinent questions that I couldn't respond (I lost the reproducer)
> > [0].
> ...
> > [0] lore.kernel.org/linux-pci/20181018183721.27467-1-gpiccoli@canonical.com
>
> With that broken firmware the NIC continued to send MSI messages to the
> vector/CPU which was assigned to it before the crash. But the crash
> kernel has no interrupt descriptor for this vector installed. So Liu's
> patches wont print anything simply because the interrupt core cannot
> detect it.
>
> To answer Bjorns still open question about when the point X is:
>
>   https://lore.kernel.org/linux-pci/20181023170343.GA4587@bhelgaas-glaptop.roam.corp.google.com/
>
> It gets flooded right at the point where the crash kernel enables
> interrupts in start_kernel(). At that point there is no device driver
> and no interupt requested. All you can see on the console for this is
>
>  "common_interrupt: $VECTOR.$CPU No irq handler for vector"
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
>
>   2) the runaway interrupt has been requested by the relevant driver in
>      the dump kernel.
>
> Especially #1 is not a sensible restriction.
>
> Thanks,
>
>         tglx

Wow, thank you very much for this great explanation (without a
reproducer) - it's nice to hear somebody that deeply understands the
code! And double thanks for CCing Bjorn.

So, I don't want to hijack Liu's thread, but do you think it makes
sense to have my approach as a (debug) parameter to prevent such a
degenerate case? Or could we have something in core IRQ code to
prevent irq flooding in such scenarios, something "stronger" than
disabling MSIs (APIC-level, likely)?

Cheers,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
