Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joois-00044C-01
 for kexec@lists.infradead.org; Fri, 26 Jun 2020 13:48:54 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: truncate dict: was: Re: [PATCH v3 3/3] printk: use the lockless
 ringbuffer
References: <20200618144919.9806-1-john.ogness@linutronix.de>
 <20200618144919.9806-4-john.ogness@linutronix.de>
 <20200625081650.GE6156@alley>
Date: Fri, 26 Jun 2020 15:48:42 +0200
In-Reply-To: <20200625081650.GE6156@alley> (Petr Mladek's message of "Thu, 25
 Jun 2020 10:16:50 +0200")
Message-ID: <87wo3u2b0l.fsf@jogness.linutronix.de>
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
>> @@ -594,22 +473,26 @@ static u32 msg_used_size(u16 text_len, u16 dict_len, u32 *pad_len)
>>  #define MAX_LOG_TAKE_PART 4
>>  static const char trunc_msg[] = "<truncated>";
>>  
>> -static u32 truncate_msg(u16 *text_len, u16 *trunc_msg_len,
>> -			u16 *dict_len, u32 *pad_len)
>> +static void truncate_msg(u16 *text_len, u16 *trunc_msg_len, u16 *dict_len)
>>  {
>>  	/*
>>  	 * The message should not take the whole buffer. Otherwise, it might
>>  	 * get removed too soon.
>>  	 */
>>  	u32 max_text_len = log_buf_len / MAX_LOG_TAKE_PART;
>> +
>>  	if (*text_len > max_text_len)
>>  		*text_len = max_text_len;
>> -	/* enable the warning message */
>> +
>> +	/* enable the warning message (if there is room) */
>>  	*trunc_msg_len = strlen(trunc_msg);
>> +	if (*text_len >= *trunc_msg_len)
>> +		*text_len -= *trunc_msg_len;
>> +	else
>> +		*trunc_msg_len = 0;
>> +
>>  	/* disable the "dict" completely */
>>  	*dict_len = 0;
>
> The dictionary does not longer need to be removed at this point.
> It is stored in a separate buffer. It is ignored by prb_reserve()
> when there is not enough space for it.

Agreed. @dict_len argument will also be dropped from the function.

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
