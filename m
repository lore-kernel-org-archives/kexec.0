Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([193.142.43.55])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kX8er-0005pu-Ih
 for kexec@lists.infradead.org; Mon, 26 Oct 2020 19:59:59 +0000
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/3] warn and suppress irqflood
In-Reply-To: <CAHD1Q_x99XW1zDr5HpVR27F_ksHLkaxc2W83e-N6F_xLYKyGbQ@mail.gmail.com>
References: <1603346163-21645-1-git-send-email-kernelfans@gmail.com>
 <871rhq7j1h.fsf@nanos.tec.linutronix.de>
 <CAFgQCTvFwvvtPE0Eow4cebCEe5OD5OhgAQarckpbFc38Bphaag@mail.gmail.com>
 <CAHD1Q_x99XW1zDr5HpVR27F_ksHLkaxc2W83e-N6F_xLYKyGbQ@mail.gmail.com>
Date: Mon, 26 Oct 2020 20:59:56 +0100
Message-ID: <87y2js3ghv.fsf@nanos.tec.linutronix.de>
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
To: Guilherme Piccoli <gpiccoli@canonical.com>, Pingfan Liu <kernelfans@gmail.com>
Cc: Maulik Shah <mkshah@codeaurora.org>, Petr Mladek <pmladek@suse.com>, Oliver Neukum <oneukum@suse.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Lina Iyer <ilina@codeaurora.org>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Al Viro <viro@zeniv.linux.org.uk>, Bjorn Helgaas <helgaas@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, afzal mohammed <afzal.mohd.ma@gmail.com>, Kexec Mailing List <kexec@lists.infradead.org>, Mike Kravetz <mike.kravetz@oracle.com>

On Mon, Oct 26 2020 at 12:06, Guilherme Piccoli wrote:
> On Sun, Oct 25, 2020 at 8:12 AM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> Some time ago (2 years) we faced a similar issue in x86-64, a hard to
> debug problem in kdump, that eventually was narrowed to a buggy NIC FW
> flooding IRQs in kdump kernel, and no messages showed (although kernel
> changed a lot since that time, today we might have better IRQ
> handling/warning). We tried an early-boot fix, by disabling MSIs (as
> per PCI spec) early in x86 boot, but it wasn't accepted - Bjorn asked
> pertinent questions that I couldn't respond (I lost the reproducer)
> [0].
...
> [0] lore.kernel.org/linux-pci/20181018183721.27467-1-gpiccoli@canonical.com

With that broken firmware the NIC continued to send MSI messages to the
vector/CPU which was assigned to it before the crash. But the crash
kernel has no interrupt descriptor for this vector installed. So Liu's
patches wont print anything simply because the interrupt core cannot
detect it.

To answer Bjorns still open question about when the point X is:

  https://lore.kernel.org/linux-pci/20181023170343.GA4587@bhelgaas-glaptop.roam.corp.google.com/

It gets flooded right at the point where the crash kernel enables
interrupts in start_kernel(). At that point there is no device driver
and no interupt requested. All you can see on the console for this is

 "common_interrupt: $VECTOR.$CPU No irq handler for vector"

And contrary to Liu's patches which try to disable a requested interrupt
if too many of them arrive, the kernel cannot do anything because there
is nothing to disable in your case. That's why you needed to do the MSI
disable magic in the early PCI quirks which run before interrupts get
enabled.

Also Liu's patch only works if:

  1) CONFIG_IRQ_TIME_ACCOUNTING is enabled

  2) the runaway interrupt has been requested by the relevant driver in
     the dump kernel.

Especially #1 is not a sensible restriction.

Thanks,

        tglx



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
