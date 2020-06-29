Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jq1mt-0005CB-FF
 for kexec@lists.infradead.org; Mon, 29 Jun 2020 21:58:04 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: buffer allocation: was: [PATCH v3 3/3] printk: use the lockless
 ringbuffer
References: <20200618144919.9806-1-john.ogness@linutronix.de>
 <20200618144919.9806-4-john.ogness@linutronix.de>
 <20200625082838.GF6156@alley> <87sgeh3m5j.fsf@jogness.linutronix.de>
 <20200629140445.GK6156@alley>
Date: Mon, 29 Jun 2020 23:57:59 +0200
In-Reply-To: <20200629140445.GK6156@alley> (Petr Mladek's message of "Mon, 29
 Jun 2020 16:04:45 +0200")
Message-ID: <87ftad8rh4.fsf@jogness.linutronix.de>
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

On 2020-06-29, Petr Mladek <pmladek@suse.com> wrote:
>> @@ @@ void __init setup_log_buf(int early)
>> +	prb_init(&printk_rb_dynamic,
>> +		 new_log_buf, order_base_2(new_log_buf_len),
>> +		 new_dict_buf, order_base_2(new_log_buf_len),
>> +		 new_descs, order_base_2(new_descs_count));
>
> order_base_2() is safe. But the result might be tat some allocated
> space is not used.
>
> I would prefer to make sure that new_log_buf_len is rounded, e.g.
> by roundup_pow_of_two(), at the beginning of the function. Then we
> could use ilog2() here.

new_log_buf_len can only be set within log_buf_len_update(), and it
is already doing exactly what you want:

        if (size)
                size = roundup_pow_of_two(size);
        if (size > log_buf_len)
                new_log_buf_len = (unsigned long)size;

I can switch to ilog2() instead of the more conservative order_base_2().

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
