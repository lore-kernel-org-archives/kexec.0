Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kX45J-0000sJ-Cf
 for kexec@lists.infradead.org; Mon, 26 Oct 2020 15:06:58 +0000
Received: from mail-ed1-f69.google.com ([209.85.208.69])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <guilherme.piccoli@canonical.com>) id 1kX45G-0004Pl-Mp
 for kexec@lists.infradead.org; Mon, 26 Oct 2020 15:06:54 +0000
Received: by mail-ed1-f69.google.com with SMTP id m1so2000852edr.8
 for <kexec@lists.infradead.org>; Mon, 26 Oct 2020 08:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <1603346163-21645-1-git-send-email-kernelfans@gmail.com>
 <871rhq7j1h.fsf@nanos.tec.linutronix.de>
 <CAFgQCTvFwvvtPE0Eow4cebCEe5OD5OhgAQarckpbFc38Bphaag@mail.gmail.com>
In-Reply-To: <CAFgQCTvFwvvtPE0Eow4cebCEe5OD5OhgAQarckpbFc38Bphaag@mail.gmail.com>
From: Guilherme Piccoli <gpiccoli@canonical.com>
Date: Mon, 26 Oct 2020 12:06:17 -0300
Message-ID: <CAHD1Q_x99XW1zDr5HpVR27F_ksHLkaxc2W83e-N6F_xLYKyGbQ@mail.gmail.com>
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
To: Pingfan Liu <kernelfans@gmail.com>
Cc: Maulik Shah <mkshah@codeaurora.org>, Petr Mladek <pmladek@suse.com>, Oliver Neukum <oneukum@suse.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Lina Iyer <ilina@codeaurora.org>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Al Viro <viro@zeniv.linux.org.uk>, Kexec Mailing List <kexec@lists.infradead.org>, Thomas Gleixner <tglx@linutronix.de>, afzal mohammed <afzal.mohd.ma@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Mike Kravetz <mike.kravetz@oracle.com>

On Sun, Oct 25, 2020 at 8:12 AM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> On Thu, Oct 22, 2020 at 4:37 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Thu, Oct 22 2020 at 13:56, Pingfan Liu wrote:
> > > I hit a irqflood bug on powerpc platform, and two years ago, on a x86 platform.
> > > When the bug happens, the kernel is totally occupies by irq.  Currently, there
> > > may be nothing or just soft lockup warning showed in console. It is better
> > > to warn users with irq flood info.
> > >
> > > In the kdump case, the kernel can move on by suppressing the irq flood.
> >
> > You're curing the symptom not the cause and the cure is just magic and
> > can't work reliably.
> Yeah, it is magic. But at least, it is better to printk something and
> alarm users about what happens. With current code, it may show nothing
> when system hangs.

Thanks Pingfan and Thomas for the points - I'd like to have a
mechanism in the kernel to warn users when an IRQ flood is potentially
happening.
Some time ago (2 years) we faced a similar issue in x86-64, a hard to
debug problem in kdump, that eventually was narrowed to a buggy NIC FW
flooding IRQs in kdump kernel, and no messages showed (although kernel
changed a lot since that time, today we might have better IRQ
handling/warning). We tried an early-boot fix, by disabling MSIs (as
per PCI spec) early in x86 boot, but it wasn't accepted - Bjorn asked
pertinent questions that I couldn't respond (I lost the reproducer)
[0].

Cheers,


Guilherme

[0] lore.kernel.org/linux-pci/20181018183721.27467-1-gpiccoli@canonical.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
