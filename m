Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOeZ4-00Eeb8-7l
 for kexec@lists.infradead.org; Tue, 23 Mar 2021 10:47:12 +0000
Date: Tue, 23 Mar 2021 11:47:06 +0100
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH next v1 2/3] printk: remove safe buffers
Message-ID: <YFnHKlCvIA2nI41c@alley>
References: <20210316233326.10778-1-john.ogness@linutronix.de>
 <20210316233326.10778-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210316233326.10778-3-john.ogness@linutronix.de>
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

On Wed 2021-03-17 00:33:25, John Ogness wrote:
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

I have two more questions after actually checking the entire patch.
See below.

> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1084,7 +1069,6 @@ void __init setup_log_buf(int early)
>  	struct printk_record r;
>  	size_t new_descs_size;
>  	size_t new_infos_size;
> -	unsigned long flags;
>  	char *new_log_buf;
>  	unsigned int free;
>  	u64 seq;
> @@ -1142,8 +1126,6 @@ void __init setup_log_buf(int early)
>  		 new_descs, ilog2(new_descs_count),
>  		 new_infos);
>  
> -	printk_safe_enter_irqsave(flags);
> -
>  	log_buf_len = new_log_buf_len;
>  	log_buf = new_log_buf;
>  	new_log_buf_len = 0;
> @@ -1159,8 +1141,6 @@ void __init setup_log_buf(int early)
>  	 */
>  	prb = &printk_rb_dynamic;
>  
> -	printk_safe_exit_irqrestore(flags);

This will allow to add new messages from the IRQ context when we
are copying them to the new buffer. They might get lost in
the small race window.

Also the messages from NMI might get lost because they are not
longer stored in the per-CPU buffer.

A possible solution might be to do something like this:

	prb_for_each_record(0, &printk_rb_static, seq, &r)
		free -= add_to_rb(&printk_rb_dynamic, &r);

	prb = &printk_rb_dynamic;

	/*
	 * Copy the remaining messages that might have appeared
	 * from IRQ or NMI context after we ended copying and
	 * before we switched the buffers. They must be finalized
	 * because only one CPU is up at this stage.
	 */
	prb_for_each_record(seq, &printk_rb_static, seq, &r)
		free -= add_to_rb(&printk_rb_dynamic, &r);


> -
>  	if (seq != prb_next_seq(&printk_rb_static)) {
>  		pr_err("dropped %llu messages\n",
>  		       prb_next_seq(&printk_rb_static) - seq);
> @@ -2666,7 +2631,6 @@ void console_unlock(void)
>  		size_t ext_len = 0;
>  		size_t len;
>  
> -		printk_safe_enter_irqsave(flags);
>  skip:
>  		if (!prb_read_valid(prb, console_seq, &r))
>  			break;
> @@ -2711,6 +2675,8 @@ void console_unlock(void)
>  				printk_time);
>  		console_seq++;
>  
> +		printk_safe_enter_irqsave(flags);

What is the purpose of the printk_safe context here, please?

I guess that you wanted to prevent calling console drivers
recursively. But it is already serialized by console_lock().

IMHO, the only risk is when manipulating console_sem->lock
or console_owner_lock. But they are already guarded by
printk_safe context, for example, in console_lock() or
console_lock_spinning_enable().

Do I miss something, please?


> +
>  		/*
>  		 * While actively printing out messages, if another printk()
>  		 * were to occur on another CPU, it may wait for this one to
> @@ -2745,8 +2711,6 @@ void console_unlock(void)
>  	 * flush, no worries.
>  	 */
>  	retry = prb_read_valid(prb, console_seq, NULL);
> -	printk_safe_exit_irqrestore(flags);
> -
>  	if (retry && console_trylock())
>  		goto again;
>  }

Heh, all these patches feels like stripping printk of an armour. I hope
that we trained it enough to be flexible and avoid any damage.

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
