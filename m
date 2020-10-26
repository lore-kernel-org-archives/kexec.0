Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kX9vx-0000oC-6q
 for kexec@lists.infradead.org; Mon, 26 Oct 2020 21:21:42 +0000
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/3] warn and suppress irqflood
In-Reply-To: <CAHD1Q_yvb43P+b6PUzK4a1jU+RH3Shv2=4bO69nh5VDWXgv-ww@mail.gmail.com>
References: <1603346163-21645-1-git-send-email-kernelfans@gmail.com>
 <871rhq7j1h.fsf@nanos.tec.linutronix.de>
 <CAFgQCTvFwvvtPE0Eow4cebCEe5OD5OhgAQarckpbFc38Bphaag@mail.gmail.com>
 <CAHD1Q_x99XW1zDr5HpVR27F_ksHLkaxc2W83e-N6F_xLYKyGbQ@mail.gmail.com>
 <87y2js3ghv.fsf@nanos.tec.linutronix.de>
 <CAHD1Q_yvb43P+b6PUzK4a1jU+RH3Shv2=4bO69nh5VDWXgv-ww@mail.gmail.com>
Date: Mon, 26 Oct 2020 22:21:36 +0100
Message-ID: <87o8ko3cpr.fsf@nanos.tec.linutronix.de>
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
To: Guilherme Piccoli <gpiccoli@canonical.com>
Cc: Maulik Shah <mkshah@codeaurora.org>, Petr Mladek <pmladek@suse.com>, Oliver Neukum <oneukum@suse.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Pingfan Liu <kernelfans@gmail.com>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Lina Iyer <ilina@codeaurora.org>, Bjorn Helgaas <helgaas@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Kravetz <mike.kravetz@oracle.com>, afzal mohammed <afzal.mohd.ma@gmail.com>, Kexec Mailing List <kexec@lists.infradead.org>, Al Viro <viro@zeniv.linux.org.uk>

On Mon, Oct 26 2020 at 17:28, Guilherme Piccoli wrote:
> On Mon, Oct 26, 2020 at 4:59 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> It gets flooded right at the point where the crash kernel enables
>> interrupts in start_kernel(). At that point there is no device driver
>> and no interupt requested. All you can see on the console for this is
>>
>>  "common_interrupt: $VECTOR.$CPU No irq handler for vector"
>>
>> And contrary to Liu's patches which try to disable a requested interrupt
>> if too many of them arrive, the kernel cannot do anything because there
>> is nothing to disable in your case. That's why you needed to do the MSI
>> disable magic in the early PCI quirks which run before interrupts get
>> enabled.
>
> Wow, thank you very much for this great explanation (without a
> reproducer) - it's nice to hear somebody that deeply understands the
> code! And double thanks for CCing Bjorn.

Understanding the code is only half of the picture. You need to
understand how the hardware works or not :)

> So, I don't want to hijack Liu's thread, but do you think it makes
> sense to have my approach as a (debug) parameter to prevent such a
> degenerate case?

At least it makes sense to some extent even if it's incomplete. What
bothers me is that it'd be x86 specific while the issue is pretty much
architecture independent. I don't think that the APIC is special in that
regard. Rogue MSIs should be able to bring down pretty much all
architectures.

> Or could we have something in core IRQ code to prevent irq flooding in
> such scenarios, something "stronger" than disabling MSIs (APIC-level,
> likely)?

For your case? No. The APIC cannot be protected against rogue MSIs. The
only cure is to disable interrupts or disable MSIs on all PCI[E] devices
early on. Disabling interrupts is not so much of an option obviously :)

Thanks,

        tglx





_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
