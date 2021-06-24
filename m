Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lwQfb-00F7Ni-UG
 for kexec@lists.infradead.org; Thu, 24 Jun 2021 14:49:33 +0000
Date: Thu, 24 Jun 2021 16:49:27 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH printk v3 3/6] printk: remove safe buffers
Message-ID: <YNSbd68YJ+0wxayx@alley>
References: <20210624111148.5190-1-john.ogness@linutronix.de>
 <20210624111148.5190-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210624111148.5190-4-john.ogness@linutronix.de>
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
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, Yue Hu <huyue2@yulong.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, "Paul E. McKenney" <paulmck@kernel.org>, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org

On Thu 2021-06-24 13:17:45, John Ogness wrote:
> With @logbuf_lock removed, the high level printk functions for
> storing messages are lockless. Messages can be stored from any
> context, so there is no need for the NMI and safe buffers anymore.
> Remove the NMI and safe buffers.
> 
> Although the safe buffers are removed, the NMI and safe context
> tracking is still in place. In these contexts, store the message
> immediately but still use irq_work to defer the console printing.
> 
> Since printk recursion tracking is in place, safe context tracking
> for most of printk is not needed. Remove it. Only safe context
> tracking relating to the console lock is left in place. This is
> because the console lock is needed for the actual printing.

Feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

There are some comments below.

> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1852,7 +1839,7 @@ static int console_trylock_spinning(void)
>  	if (console_trylock())
>  		return 1;
>  
> -	printk_safe_enter_irqsave(flags);
> +	local_irq_save(flags);
>  
>  	raw_spin_lock(&console_owner_lock);

This spin_lock is in the printk() path. We must make sure that
it does not cause deadlock.

printk_safe_enter_irqsave(flags) prevented the recursion because
it deferred the console handling.

One danger might be a lockdep report triggered by
raw_spin_lock(&console_owner_lock) itself. But it should be safe.
lockdep is checked before the lock is actually taken
and lockdep should disable itself before printing anything.

Another danger might be any printk() called under the lock.
The code just compares and assigns values to some variables
(static, on stack) so we should be on the safe side.

Well, I would feel more comfortable if we add printk_safe_enter_irqsave()
back around the sections guarded by this lock. It can be done
in a separate patch. The code looks safe at the moment.


> @@ -2664,9 +2648,9 @@ void console_unlock(void)
>  
>  	for (;;) {
>  		size_t ext_len = 0;
> +		int handover;
>  		size_t len;
>  
> -		printk_safe_enter_irqsave(flags);
>  skip:
>  		if (!prb_read_valid(prb, console_seq, &r))
>  			break;
> @@ -2716,19 +2700,22 @@ void console_unlock(void)
>  		 * were to occur on another CPU, it may wait for this one to
>  		 * finish. This task can not be preempted if there is a
>  		 * waiter waiting to take over.
> +		 *
> +		 * Interrupts are disabled because the hand over to a waiter
> +		 * must not be interrupted until the hand over is completed
> +		 * (@console_waiter is cleared).
>  		 */
> +		local_irq_save(flags);
>  		console_lock_spinning_enable();

Same here. console_lock_spinning_enable() takes console_owner_lock.
I would feel more comfortable if we added printk_safe_enter_irqsave(flags)
inside console_lock_spinning_enable() around the locked code. The code
is safe at the moment but...

>  
>  		stop_critical_timings();	/* don't trace print latency */
>  		call_console_drivers(ext_text, ext_len, text, len);
>  		start_critical_timings();
>  
> -		if (console_lock_spinning_disable_and_check()) {
> -			printk_safe_exit_irqrestore(flags);
> +		handover = console_lock_spinning_disable_and_check();

Same here. Also console_lock_spinning_disable_and_check() takes
console_owner_lock. It looks safe at the moment but...


> +		local_irq_restore(flags);
> +		if (handover)
>  			return;
> -		}
> -
> -		printk_safe_exit_irqrestore(flags);
>  
>  		if (do_cond_resched)
>  			cond_resched();

> --- a/kernel/printk/printk_safe.c
> +++ b/kernel/printk/printk_safe.c
> @@ -369,7 +70,10 @@ asmlinkage int vprintk(const char *fmt, va_list args)
>  	 * Use the main logbuf even in NMI. But avoid calling console
>  	 * drivers that might have their own locks.
>  	 */
> -	if ((this_cpu_read(printk_context) & PRINTK_NMI_DIRECT_CONTEXT_MASK)) {
> +	if (this_cpu_read(printk_context) &
> +	    (PRINTK_NMI_DIRECT_CONTEXT_MASK |
> +	     PRINTK_NMI_CONTEXT_MASK |
> +	     PRINTK_SAFE_CONTEXT_MASK)) {
>  		unsigned long flags;
>  		int len;
>  

There is the following code right below:

		printk_safe_enter_irqsave(flags);
		len = vprintk_store(0, LOGLEVEL_DEFAULT, NULL, fmt, args);
		printk_safe_exit_irqrestore(flags);
		defer_console_output();
		return len;

printk_safe_enter_irqsave(flags) is not needed here. Any nested
printk() ends here as well.

Against this can be done in a separate patch. Well, the commit message
mentions that the printk_safe context is removed everywhere except
for the code manipulating console lock. But is it just a detail.

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
