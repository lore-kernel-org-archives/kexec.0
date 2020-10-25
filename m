Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kWdxI-0001bk-LE
 for kexec@lists.infradead.org; Sun, 25 Oct 2020 11:12:57 +0000
Received: by mail-io1-xd41.google.com with SMTP id p7so6981461ioo.6
 for <kexec@lists.infradead.org>; Sun, 25 Oct 2020 04:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <1603346163-21645-1-git-send-email-kernelfans@gmail.com>
 <871rhq7j1h.fsf@nanos.tec.linutronix.de>
In-Reply-To: <871rhq7j1h.fsf@nanos.tec.linutronix.de>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Sun, 25 Oct 2020 19:12:41 +0800
Message-ID: <CAFgQCTvFwvvtPE0Eow4cebCEe5OD5OhgAQarckpbFc38Bphaag@mail.gmail.com>
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
Cc: Maulik Shah <mkshah@codeaurora.org>, Petr Mladek <pmladek@suse.com>, Oliver Neukum <oneukum@suse.com>, Jonathan Corbet <corbet@lwn.net>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, "Guilherme G. Piccoli" <gpiccoli@canonical.com>, linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Lina Iyer <ilina@codeaurora.org>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, afzal mohammed <afzal.mohd.ma@gmail.com>, Kexec Mailing List <kexec@lists.infradead.org>, Mike Kravetz <mike.kravetz@oracle.com>

On Thu, Oct 22, 2020 at 4:37 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Thu, Oct 22 2020 at 13:56, Pingfan Liu wrote:
> > I hit a irqflood bug on powerpc platform, and two years ago, on a x86 platform.
> > When the bug happens, the kernel is totally occupies by irq.  Currently, there
> > may be nothing or just soft lockup warning showed in console. It is better
> > to warn users with irq flood info.
> >
> > In the kdump case, the kernel can move on by suppressing the irq flood.
>
> You're curing the symptom not the cause and the cure is just magic and
> can't work reliably.
Yeah, it is magic. But at least, it is better to printk something and
alarm users about what happens. With current code, it may show nothing
when system hangs.
>
> Where is that irq flood originated from and why is none of the
> mechanisms we have in place to shut it up working?
The bug originates from a driver tpm_i2c_nuvoton, which calls i2c-bus
driver (i2c-opal.c). After i2c_opal_send_request(), the bug is
triggered.

But things are complicated by introducing a firmware layer: Skiboot.
This software layer hides the detail of manipulating the hardware from
Linux.

I guess the software logic can not enter a sane state when kernel crashes.

Cc Skiboot and ppc64 community to see whether anyone has idea about it.

Thanks,
Pingfan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
