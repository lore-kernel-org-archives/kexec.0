Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([193.142.43.55])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lPkOO-003PEx-4C
 for kexec@lists.infradead.org; Fri, 26 Mar 2021 11:12:41 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH next v1 2/3] printk: remove safe buffers
In-Reply-To: <YFnHKlCvIA2nI41c@alley>
References: <20210316233326.10778-1-john.ogness@linutronix.de>
 <20210316233326.10778-3-john.ogness@linutronix.de> <YFnHKlCvIA2nI41c@alley>
Date: Fri, 26 Mar 2021 12:12:37 +0100
Message-ID: <87pmzmi2xm.fsf@jogness.linutronix.de>
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
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Alistair Popple <alistair@popple.id.au>, Jordan Niethe <jniethe5@gmail.com>, Peter Zijlstra <peterz@infradead.org>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Yue Hu <huyue2@yulong.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Rafael Aquini <aquini@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, "Guilherme G.
 Piccoli" <gpiccoli@canonical.com>, "Paul E. McKenney" <paulmck@kernel.org>, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org

On 2021-03-23, Petr Mladek <pmladek@suse.com> wrote:
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -1142,8 +1126,6 @@ void __init setup_log_buf(int early)
>>  		 new_descs, ilog2(new_descs_count),
>>  		 new_infos);
>>  
>> -	printk_safe_enter_irqsave(flags);
>> -
>>  	log_buf_len = new_log_buf_len;
>>  	log_buf = new_log_buf;
>>  	new_log_buf_len = 0;
>> @@ -1159,8 +1141,6 @@ void __init setup_log_buf(int early)
>>  	 */
>>  	prb = &printk_rb_dynamic;
>>  
>> -	printk_safe_exit_irqrestore(flags);
>
> This will allow to add new messages from the IRQ context when we
> are copying them to the new buffer. They might get lost in
> the small race window.
>
> Also the messages from NMI might get lost because they are not
> longer stored in the per-CPU buffer.
>
> A possible solution might be to do something like this:
>
> 	prb_for_each_record(0, &printk_rb_static, seq, &r)
> 		free -= add_to_rb(&printk_rb_dynamic, &r);
>
> 	prb = &printk_rb_dynamic;
>
> 	/*
> 	 * Copy the remaining messages that might have appeared
> 	 * from IRQ or NMI context after we ended copying and
> 	 * before we switched the buffers. They must be finalized
> 	 * because only one CPU is up at this stage.
> 	 */
> 	prb_for_each_record(seq, &printk_rb_static, seq, &r)
> 		free -= add_to_rb(&printk_rb_dynamic, &r);

OK. I'll probably rework it some and combine it with the "dropped" test
so that we can identify if messages were dropped during the transition
(because of static ringbuffer overrun).

>> -
>>  	if (seq != prb_next_seq(&printk_rb_static)) {
>>  		pr_err("dropped %llu messages\n",
>>  		       prb_next_seq(&printk_rb_static) - seq);
>> @@ -2666,7 +2631,6 @@ void console_unlock(void)
>>  		size_t ext_len = 0;
>>  		size_t len;
>>  
>> -		printk_safe_enter_irqsave(flags);
>>  skip:
>>  		if (!prb_read_valid(prb, console_seq, &r))
>>  			break;
>> @@ -2711,6 +2675,8 @@ void console_unlock(void)
>>  				printk_time);
>>  		console_seq++;
>>  
>> +		printk_safe_enter_irqsave(flags);
>
> What is the purpose of the printk_safe context here, please?

console_lock_spinning_enable() needs to be called with interrupts
disabled. I should have just used local_irq_save().

I could add local_irq_save() to console_lock_spinning_enable() and
restore them at the end of console_lock_spinning_disable_and_check(),
but then I would need to add a @flags argument to both functions. I
think it is simpler to just do the disable/enable from the caller,
console_unlock().

BTW, I could not find any sane way of disabling interrupts via a
raw_spin_lock_irqsave() of @console_owner_lock because of the how it is
used with lockdep. In particular for
console_lock_spinning_disable_and_check().

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
