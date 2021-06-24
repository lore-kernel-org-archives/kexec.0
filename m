Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lwROZ-00FGxq-S4
 for kexec@lists.infradead.org; Thu, 24 Jun 2021 15:36:01 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH printk v3 3/6] printk: remove safe buffers
In-Reply-To: <YNSbd68YJ+0wxayx@alley>
References: <20210624111148.5190-1-john.ogness@linutronix.de>
 <20210624111148.5190-4-john.ogness@linutronix.de> <YNSbd68YJ+0wxayx@alley>
Date: Thu, 24 Jun 2021 17:41:56 +0206
Message-ID: <8735t7mg0z.fsf@jogness.linutronix.de>
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
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, Yue Hu <huyue2@yulong.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, "Paul E.
 McKenney" <paulmck@kernel.org>, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org

On 2021-06-24, Petr Mladek <pmladek@suse.com> wrote:
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -1852,7 +1839,7 @@ static int console_trylock_spinning(void)
>>  	if (console_trylock())
>>  		return 1;
>>  
>> -	printk_safe_enter_irqsave(flags);
>> +	local_irq_save(flags);
>>  
>>  	raw_spin_lock(&console_owner_lock);
>
> This spin_lock is in the printk() path. We must make sure that
> it does not cause deadlock.
>
> printk_safe_enter_irqsave(flags) prevented the recursion because
> it deferred the console handling.
>
> One danger might be a lockdep report triggered by
> raw_spin_lock(&console_owner_lock) itself. But it should be safe.
> lockdep is checked before the lock is actually taken
> and lockdep should disable itself before printing anything.
>
> Another danger might be any printk() called under the lock.
> The code just compares and assigns values to some variables
> (static, on stack) so we should be on the safe side.
>
> Well, I would feel more comfortable if we add printk_safe_enter_irqsave()
> back around the sections guarded by this lock. It can be done
> in a separate patch. The code looks safe at the moment.

You are correct. printk_safe should also be wrapping @console_owner_lock
locking.

>> @@ -2716,19 +2700,22 @@ void console_unlock(void)
>>  		 * were to occur on another CPU, it may wait for this one to
>>  		 * finish. This task can not be preempted if there is a
>>  		 * waiter waiting to take over.
>> +		 *
>> +		 * Interrupts are disabled because the hand over to a waiter
>> +		 * must not be interrupted until the hand over is completed
>> +		 * (@console_waiter is cleared).
>>  		 */
>> +		local_irq_save(flags);
>>  		console_lock_spinning_enable();
>
> Same here. console_lock_spinning_enable() takes console_owner_lock.
> I would feel more comfortable if we added printk_safe_enter_irqsave(flags)
> inside console_lock_spinning_enable() around the locked code. The code
> is safe at the moment but...

Agreed.

>>  		stop_critical_timings();	/* don't trace print latency */
>>  		call_console_drivers(ext_text, ext_len, text, len);
>>  		start_critical_timings();
>>  
>> -		if (console_lock_spinning_disable_and_check()) {
>> -			printk_safe_exit_irqrestore(flags);
>> +		handover = console_lock_spinning_disable_and_check();
>
> Same here. Also console_lock_spinning_disable_and_check() takes
> console_owner_lock. It looks safe at the moment but...

Agreed.

>> --- a/kernel/printk/printk_safe.c
>> +++ b/kernel/printk/printk_safe.c
>> @@ -369,7 +70,10 @@ asmlinkage int vprintk(const char *fmt, va_list args)
>>  	 * Use the main logbuf even in NMI. But avoid calling console
>>  	 * drivers that might have their own locks.
>>  	 */
>> -	if ((this_cpu_read(printk_context) & PRINTK_NMI_DIRECT_CONTEXT_MASK)) {
>> +	if (this_cpu_read(printk_context) &
>> +	    (PRINTK_NMI_DIRECT_CONTEXT_MASK |
>> +	     PRINTK_NMI_CONTEXT_MASK |
>> +	     PRINTK_SAFE_CONTEXT_MASK)) {
>>  		unsigned long flags;
>>  		int len;
>>  
>
> There is the following code right below:
>
> 		printk_safe_enter_irqsave(flags);
> 		len = vprintk_store(0, LOGLEVEL_DEFAULT, NULL, fmt, args);
> 		printk_safe_exit_irqrestore(flags);
> 		defer_console_output();
> 		return len;
>
> printk_safe_enter_irqsave(flags) is not needed here. Any nested
> printk() ends here as well.

Ah, I missed that one. Good eye!

> Against this can be done in a separate patch. Well, the commit message
> mentions that the printk_safe context is removed everywhere except
> for the code manipulating console lock. But is it just a detail.

I would prefer a v4 with these fixes:

- wrap @console_owner_lock with printk_safe usage

- remove unnecessary printk_safe usage from printk_safe.c

- update commit message to say that safe context tracking is left in
  place for both the console and console_owner locks

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
