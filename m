Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lTjiV-002Im4-8K
 for kexec@lists.infradead.org; Tue, 06 Apr 2021 11:17:57 +0000
Date: Tue, 6 Apr 2021 13:17:48 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH printk v2 2/5] printk: remove safe buffers
Message-ID: <YGxDXBJAolBCtojY@alley>
References: <20210330153512.1182-1-john.ogness@linutronix.de>
 <20210330153512.1182-3-john.ogness@linutronix.de>
 <YGW63/elFr/gYW1u@alley> <87a6qiqgzr.fsf@jogness.linutronix.de>
 <YGXV8LJarjUJDhvy@alley> <YGZ9+kfQKxASmVDR@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YGZ9+kfQKxASmVDR@google.com>
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
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Nicholas Piggin <npiggin@gmail.com>, Alistair Popple <alistair@popple.id.au>, Jordan Niethe <jniethe5@gmail.com>, Peter Zijlstra <peterz@infradead.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, Alexey Kardashevskiy <aik@ozlabs.ru>, Yue Hu <huyue2@yulong.com>, Rafael Aquini <aquini@redhat.com>, "Guilherme G. Piccoli" <gpiccoli@canonical.com>, "Paul E. McKenney" <paulmck@kernel.org>, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org

On Fri 2021-04-02 11:14:18, Sergey Senozhatsky wrote:
> On (21/04/01 16:17), Petr Mladek wrote:
> > > For the long term, we should introduce a printk-context API that allows
> > > callers to perfectly pack their multi-line output into a single
> > > entry. We discussed [0][1] this back in August 2020.
> > 
> > We need a "short" term solution. There are currently 3 solutions:
> > 
> > 1. Keep nmi_safe() and all the hacks around.
> > 
> > 2. Serialize nmi_cpu_backtrace() by a spin lock and later by
> >    the special lock used also by atomic consoles.
> > 
> > 3. Tell complaining people how to sort the messed logs.
> 
> Are we talking about nmi_cpu_backtrace()->dump_stack() or some
> other path?

It is about serializing

			if (regs)
				show_regs(regs);
			else
				dump_stack();

in nmi_cpu_backtrace() when it is triggered on many(all) CPUs
at the same time.


> dump_stack() seems to be already serialized by `dump_lock`. Hmm,
> show_regs() is not serialized, seems like it should be under the
> same `dump_lock` as dump_stack().

Ah, I think that you already mentioned it in the past and I forget it.

Yes, we would need to synchronize all these dump/show functions using
the same lock. It is already the lock that might be taken recursively
on the same CPU.

In each case, we must not introduce another lock in
nmi_cpu_backtrace() because it might cause deadlock with
@dump_lock.

Anyway, I would really like to keep the dumps serialized. So, we
either need to use the same lock everywhere or we need to keep
nmi_safe buffers for now.

I would like to remove the nmi_safe buffers in the long term
but I am fine with doing it later after the consoles rework.
I'll leave the prioritization for John who is doing the work
and might have some preferences.

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
