Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kXO7C-00027i-8V
 for kexec@lists.infradead.org; Tue, 27 Oct 2020 12:30:15 +0000
Received: from mail-ed1-f71.google.com ([209.85.208.71])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <guilherme.piccoli@canonical.com>) id 1kXO6B-00009m-TO
 for kexec@lists.infradead.org; Tue, 27 Oct 2020 12:29:12 +0000
Received: by mail-ed1-f71.google.com with SMTP id r14so586259edw.21
 for <kexec@lists.infradead.org>; Tue, 27 Oct 2020 05:29:11 -0700 (PDT)
MIME-Version: 1.0
References: <1603346163-21645-1-git-send-email-kernelfans@gmail.com>
 <871rhq7j1h.fsf@nanos.tec.linutronix.de>
 <CAFgQCTvFwvvtPE0Eow4cebCEe5OD5OhgAQarckpbFc38Bphaag@mail.gmail.com>
 <CAHD1Q_x99XW1zDr5HpVR27F_ksHLkaxc2W83e-N6F_xLYKyGbQ@mail.gmail.com>
 <87y2js3ghv.fsf@nanos.tec.linutronix.de>
 <CAHD1Q_yvb43P+b6PUzK4a1jU+RH3Shv2=4bO69nh5VDWXgv-ww@mail.gmail.com>
 <87o8ko3cpr.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87o8ko3cpr.fsf@nanos.tec.linutronix.de>
From: Guilherme Piccoli <gpiccoli@canonical.com>
Date: Tue, 27 Oct 2020 09:28:35 -0300
Message-ID: <CAHD1Q_z1UZR-iAN=FWY3wsc2nKFWN1yxQ15U0jE0_2cGuGGSRQ@mail.gmail.com>
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

On Mon, Oct 26, 2020 at 6:21 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> [...]
> > So, I don't want to hijack Liu's thread, but do you think it makes
> > sense to have my approach as a (debug) parameter to prevent such a
> > degenerate case?
>
> At least it makes sense to some extent even if it's incomplete. What
> bothers me is that it'd be x86 specific while the issue is pretty much
> architecture independent. I don't think that the APIC is special in that
> regard. Rogue MSIs should be able to bring down pretty much all
> architectures.
>

Thanks Thomas! I partially agree with you, I can speak only for x86
and powerpc. In x86 we know that happens, OK. But in powerpc, we had a
special PCI reset, we called it IIRC "fundamental"/PHB reset - that
procedure would put the PCI devices in good shape, it was something
that the kernel could request from FW - see [0] for an example. It was
present in all incarnations of powerpc (bare-metal, powerVM/PHyp - a
virtual thing) except maybe in qemu (although it'd be possible to do
that, since the PCI devices are attached on host and passthrough'ed
via vfio).

Anyway, in powerpc the PCI devices are really reset across
"soft-reboots" be it kexec or what was called a fast reboot (that
skipped some FW initializations), effectively disabling MSIs - x86 has
no such default/vendor-agnostic reset infrastructure, BIOSes usually
do some kind of PCI reset but with no interface for the kernel to
request that in kexec, for example. That said, the option was to use
the arch code to early-clear the MSI state in all devices, that being
a kind of reset. And it's "supported" by the spec, that claims MSIs
should be clear before devices' initialization =)

Anyway, I'm glad to discuss more, and I'm even more glad that you
consider the approach useful. We could revive that if Bjorn agrees, I
could respin an updated version. ARM64/RISC-V or whatever other
architectures I can't say about, but I think if they have early-PCI
handlers (and !FW reset, like powerpc) it would be possible to
implement that in a more complete way.


> > Or could we have something in core IRQ code to prevent irq flooding in
> > such scenarios, something "stronger" than disabling MSIs (APIC-level,
> > likely)?
>
> For your case? No. The APIC cannot be protected against rogue MSIs. The
> only cure is to disable interrupts or disable MSIs on all PCI[E] devices
> early on. Disabling interrupts is not so much of an option obviously :)

Great to know that, we imagined if it would be possible to have a more
"soft" option, but it seems clearing MSIs is the way to go.
Cheers,


Guilherme

[0] kernel portion:
git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/platforms/powernv/pci-ioda.c#n3161
FW portion: github.com/open-power/skiboot/blob/master/core/pci-opal.c#L545

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
