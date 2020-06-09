Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jifnF-0002o5-1c
 for kexec@lists.infradead.org; Tue, 09 Jun 2020 15:04:02 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: Full barrier in data_push_tail(): was [PATCH v2 2/3] printk: add
 lockless buffer
References: <20200501094010.17694-1-john.ogness@linutronix.de>
 <20200501094010.17694-3-john.ogness@linutronix.de>
 <20200609094820.GC23752@linux-b0ei>
Date: Tue, 09 Jun 2020 17:03:54 +0200
In-Reply-To: <20200609094820.GC23752@linux-b0ei> (Petr Mladek's message of
 "Tue, 9 Jun 2020 11:48:20 +0200")
Message-ID: <87h7vkuvqd.fsf@vostro.fn.ogness.net>
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

On 2020-06-09, Petr Mladek <pmladek@suse.com> wrote:
>> --- /dev/null
>> +++ b/kernel/printk/printk_ringbuffer.c
>> +static bool data_push_tail(struct printk_ringbuffer *rb,
>> +			   struct prb_data_ring *data_ring,
>> +			   unsigned long lpos)
>> +{
>> ...
>> +
>> +		/*
>> +		 * Guarantee any descriptor states that have transitioned to
>> +		 * reusable are stored before pushing the tail lpos. This
>> +		 * allows readers to identify if data has expired while
>> +		 * reading the descriptor. This pairs with desc_read:D.
>> +		 */
>> +		smp_mb(); /* LMM(data_push_tail:C) */
>
> The comment does not explain why we need a full barrier here.
>
> I would add something like:
>
> 		* Full barrier is necessary because the descriptors
> 		* might have been made reusable also by other CPUs.

Agreed. Somehow I missed that explanation for this comment.

> For people like me, it would be great to add also link to a more
> detailed explanation, for example, the litmus tests, or something
> even more human readable ;-) I think that it is a "rather" common
> problem. I wonder whether it is already documented somewhere.

I believe that memory barriers need to be formally documented. Perhaps
in such a way that litmus tests can be easily generated. Tools could
greatly assist with this. It is my hope that my memory barrier
documentation can spark some ideas about how we could do this. (Doing
all this manually really sucks!)

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
