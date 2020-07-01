Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqisB-00014a-Uz
 for kexec@lists.infradead.org; Wed, 01 Jul 2020 19:58:24 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: pending output optimization: was: [PATCH v3 3/3] printk: use the
 lockless ringbuffer
In-Reply-To: <20200625151741.GH8444@alley>
References: <20200618144919.9806-1-john.ogness@linutronix.de>
 <20200618144919.9806-4-john.ogness@linutronix.de>
 <20200625151741.GH8444@alley>
Date: Wed, 01 Jul 2020 22:04:19 +0206
Message-ID: <87o8oznh2c.fsf@jogness.linutronix.de>
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
Cc: Andrea Parri <parri.andrea@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Paul McKenney <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On 2020-06-25, Petr Mladek <pmladek@suse.com> wrote:
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -2009,9 +2056,9 @@ asmlinkage int vprintk_emit(int facility, int level,
>>  
>>  	/* This stops the holder of console_sem just where we want him */
>>  	logbuf_lock_irqsave(flags);
>> -	curr_log_seq = log_next_seq;
>> +	pending_output = !prb_read_valid(prb, console_seq, NULL);
>>  	printed_len = vprintk_store(facility, level, dict, dictlen, fmt, args);
>> -	pending_output = (curr_log_seq != log_next_seq);
>> +	pending_output &= prb_read_valid(prb, console_seq, NULL);
>
> This will stop working after we remove the locks. Consoles will be
> able to handle messages while the new one is being added. There will
> be no gurantee that someone is still hadling the previously pending
> output.
>
> Please, always handle consoles when printed_len is not zero!!!
>
> The pending output was just an optimization added recently. Nobody
> requested it. It was just an idea that made sense.

OK. I will insert a patch before this one that reverts commit
3ac37a93fa92 ("printk: lock/unlock console only for new logbuf
entries"). Then there is no @pending_output for me to implement and it
will be clear that this series is changing/reverting some printk
behavior.

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
