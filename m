Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVW6V-0004La-NO
 for kexec@lists.infradead.org; Thu, 22 Oct 2020 08:37:48 +0000
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/3] warn and suppress irqflood
In-Reply-To: <1603346163-21645-1-git-send-email-kernelfans@gmail.com>
References: <1603346163-21645-1-git-send-email-kernelfans@gmail.com>
Date: Thu, 22 Oct 2020 10:37:46 +0200
Message-ID: <871rhq7j1h.fsf@nanos.tec.linutronix.de>
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
To: Pingfan Liu <kernelfans@gmail.com>, linux-kernel@vger.kernel.org
Cc: Maulik Shah <mkshah@codeaurora.org>, Petr Mladek <pmladek@suse.com>, Oliver Neukum <oneukum@suse.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, "Guilherme G. Piccoli" <gpiccoli@canonical.com>, linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Pingfan Liu <kernelfans@gmail.com>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Lina Iyer <ilina@codeaurora.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Kravetz <mike.kravetz@oracle.com>, afzal mohammed <afzal.mohd.ma@gmail.com>, kexec@lists.infradead.org, Al Viro <viro@zeniv.linux.org.uk>

On Thu, Oct 22 2020 at 13:56, Pingfan Liu wrote:
> I hit a irqflood bug on powerpc platform, and two years ago, on a x86 platform.
> When the bug happens, the kernel is totally occupies by irq.  Currently, there
> may be nothing or just soft lockup warning showed in console. It is better
> to warn users with irq flood info.
>
> In the kdump case, the kernel can move on by suppressing the irq flood.

You're curing the symptom not the cause and the cure is just magic and
can't work reliably.

Where is that irq flood originated from and why is none of the
mechanisms we have in place to shut it up working?

Thanks,

        tglx





_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
