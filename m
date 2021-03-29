Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lQolH-000Z1g-Go
 for kexec@lists.infradead.org; Mon, 29 Mar 2021 10:04:47 +0000
Date: Mon, 29 Mar 2021 12:04:38 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH next v1 2/3] printk: remove safe buffers
Message-ID: <YGGmNu5ilDnSKH3g@alley>
References: <20210316233326.10778-1-john.ogness@linutronix.de>
 <20210316233326.10778-3-john.ogness@linutronix.de>
 <YFnHKlCvIA2nI41c@alley> <87pmzmi2xm.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87pmzmi2xm.fsf@jogness.linutronix.de>
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
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Alistair Popple <alistair@popple.id.au>, Jordan Niethe <jniethe5@gmail.com>, Peter Zijlstra <peterz@infradead.org>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Yue Hu <huyue2@yulong.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Rafael Aquini <aquini@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, "Guilherme G. Piccoli" <gpiccoli@canonical.com>, "Paul E. McKenney" <paulmck@kernel.org>, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org

On Fri 2021-03-26 12:12:37, John Ogness wrote:
> On 2021-03-23, Petr Mladek <pmladek@suse.com> wrote:
> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> >> -
> >>  	if (seq != prb_next_seq(&printk_rb_static)) {
> >>  		pr_err("dropped %llu messages\n",
> >>  		       prb_next_seq(&printk_rb_static) - seq);
> >> @@ -2666,7 +2631,6 @@ void console_unlock(void)
> >>  		size_t ext_len = 0;
> >>  		size_t len;
> >>  
> >> -		printk_safe_enter_irqsave(flags);
> >>  skip:
> >>  		if (!prb_read_valid(prb, console_seq, &r))
> >>  			break;
> >> @@ -2711,6 +2675,8 @@ void console_unlock(void)
> >>  				printk_time);
> >>  		console_seq++;
> >>  
> >> +		printk_safe_enter_irqsave(flags);
> >
> > What is the purpose of the printk_safe context here, please?
> 
> console_lock_spinning_enable() needs to be called with interrupts
> disabled. I should have just used local_irq_save().
> 
> I could add local_irq_save() to console_lock_spinning_enable() and
> restore them at the end of console_lock_spinning_disable_and_check(),
> but then I would need to add a @flags argument to both functions. I
> think it is simpler to just do the disable/enable from the caller,
> console_unlock().

I see. I have missed it that all this code have to be called with
interrupts disabled.

OK, it is a must-to-have because of the spinning. But I wonder if some
console drivers rely on the fact that the write() callback is
called with interrupts disabled.

IMHO, it would be a bug when any write() callback expects that
callers disabled the interrupts.

Do you plan to remove the console-spinning stuff after offloading
consoles to the kthreads?

Will you call console write() callback with irq enabled from
the kthread?

Anyway, we should at least add a comment why the interrupts are
disabled.


> BTW, I could not find any sane way of disabling interrupts via a
> raw_spin_lock_irqsave() of @console_owner_lock because of the how it is
> used with lockdep. In particular for
> console_lock_spinning_disable_and_check().

I see. IMHO, we would need to explicitly call local_irq_save()/restore()
if we moved them to console_lock_spinning_enable()/disable_and_check().
I mean to do:


static void console_lock_spinning_enable(unsigned long *flags)
{
	local_irq_save(*flags);

	raw_spin_lock(&console_owner_lock);
	console_owner = current;
	raw_spin_unlock(&console_owner_lock);

	/* The waiter may spin on us after setting console_owner */
	spin_acquire(&console_owner_dep_map, 0, 0, _THIS_IP_);
}

...

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
