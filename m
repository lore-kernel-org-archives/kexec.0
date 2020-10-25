Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kWf1h-0004yL-Vw
 for kexec@lists.infradead.org; Sun, 25 Oct 2020 12:21:35 +0000
Received: by mail-io1-xd42.google.com with SMTP id z5so7102176iob.1
 for <kexec@lists.infradead.org>; Sun, 25 Oct 2020 05:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <1603346163-21645-1-git-send-email-kernelfans@gmail.com>
 <871rhq7j1h.fsf@nanos.tec.linutronix.de>
 <CAFgQCTvFwvvtPE0Eow4cebCEe5OD5OhgAQarckpbFc38Bphaag@mail.gmail.com>
In-Reply-To: <CAFgQCTvFwvvtPE0Eow4cebCEe5OD5OhgAQarckpbFc38Bphaag@mail.gmail.com>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Sun, 25 Oct 2020 23:21:18 +1100
Message-ID: <CAOSf1CG=Pvr8Yw_+6J3c4VOD0QJwv58iRtSAqBFpeZM6S=7Viw@mail.gmail.com>
Subject: Re: [Skiboot] [PATCH 0/3] warn and suppress irqflood
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
Cc: Maulik Shah <mkshah@codeaurora.org>, Petr Mladek <pmladek@suse.com>, "Guilherme G. Piccoli" <gpiccoli@canonical.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Oliver Neukum <oneukum@suse.com>, linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Lina Iyer <ilina@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Al Viro <viro@zeniv.linux.org.uk>, Kexec Mailing List <kexec@lists.infradead.org>, Thomas Gleixner <tglx@linutronix.de>, afzal mohammed <afzal.mohd.ma@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Mike Kravetz <mike.kravetz@oracle.com>

On Sun, Oct 25, 2020 at 10:22 PM Pingfan Liu <kernelfans@gmail.com> wrote:
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
> >
> > Where is that irq flood originated from and why is none of the
> > mechanisms we have in place to shut it up working?
> The bug originates from a driver tpm_i2c_nuvoton, which calls i2c-bus
> driver (i2c-opal.c). After i2c_opal_send_request(), the bug is
> triggered.
>
> But things are complicated by introducing a firmware layer: Skiboot.
> This software layer hides the detail of manipulating the hardware from
> Linux.
>
> I guess the software logic can not enter a sane state when kernel crashes.
>
> Cc Skiboot and ppc64 community to see whether anyone has idea about it.

What system are you using?

There's an external interrupt pin which is supposed to be wired to the
TPM. I think we bounce that interrupt to FW by default since the
external interrupt is sometimes used for other system-specific
purposes. Odds are FW doesn't know what to do with it so you
effectively have an always-on LSI. I fixed a similar bug a while ago
by having skiboot mask any interrupts it doesn't have a handler for,
but I have no idea when that fix will land in a released FW build. Oh
well.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
