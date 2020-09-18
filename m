Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kJEag-0002Ls-35
 for kexec@lists.infradead.org; Fri, 18 Sep 2020 11:30:11 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH printk 1/3] printk: move printk_info into separate array
In-Reply-To: <20200918100602.GB14605@alley>
References: <20200917131644.25838-1-john.ogness@linutronix.de>
 <20200917131644.25838-2-john.ogness@linutronix.de>
 <20200918100602.GB14605@alley>
Date: Fri, 18 Sep 2020 13:36:06 +0206
Message-ID: <87k0wrb9vl.fsf@jogness.linutronix.de>
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
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On 2020-09-18, Petr Mladek <pmladek@suse.com> wrote:
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -1097,6 +1097,7 @@ static char setup_dict_buf[CONSOLE_EXT_LOG_MAX] __initdata;
>>  
>>  void __init setup_log_buf(int early)
>>  {
>> +	struct printk_info *new_infos;
>>  	unsigned int new_descs_count;
>>  	struct prb_desc *new_descs;
>>  	struct printk_info info;
>> @@ -1156,6 +1157,17 @@ void __init setup_log_buf(int early)
>>  		return;
>>  	}
>>  
>> +	new_descs_size = new_descs_count * sizeof(struct printk_info);
>
> Must be stored into new variable, e.g.  new_infos_size.=

Ack.

>> +	new_infos = memblock_alloc(new_descs_size, LOG_ALIGN);
>> +	if (unlikely(!new_infos)) {
>> +		pr_err("log_buf_len: %zu info bytes not available\n",
>> +		       new_descs_size);
>> +		memblock_free(__pa(new_descs), new_log_buf_len);
>> +		memblock_free(__pa(new_dict_buf), new_log_buf_len);
>
> The above two calls have wrong size.
>
> The same problem is there also in the error path when new_descs
> allocation fail. It might be better to handle this using some
> goto err_* tagrets.
>
> Please, fix the old problem in a separate patch.

The "old problem" didn't exist. The problem is introduced with this
series. I will fix it with appropriate goto err_* targets for v2.

>> --- a/kernel/printk/printk_ringbuffer.c
>> +++ b/kernel/printk/printk_ringbuffer.c
>> @@ -1726,12 +1762,12 @@ static bool copy_data(struct prb_data_ring *data_ring,
>>  	/*
>>  	 * Actual cannot be less than expected. It can be more than expected
>>  	 * because of the trailing alignment padding.
>> +	 *
>> +	 * Note that invalid @len values can occur because the caller loads
>> +	 * the value during an allowed data race.
>
> I hope that this will not bite us in the future. The fact is that
> copying the entire struct printk_info in get_desc() is ugly and
> copy_data() has to be careful anyway.

It isn't an issue because the state is verified again at the end of
prb_read(). I added the comment because if all you are looking at is
copy_data(), you may not know that @len was read on a data-race. Whereas
inside of prb_read(), it is obvious that the memcpy() is a data-race.

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
