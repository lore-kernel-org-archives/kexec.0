Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joNFQ-00023s-I9
 for kexec@lists.infradead.org; Thu, 25 Jun 2020 08:28:41 +0000
Date: Thu, 25 Jun 2020 10:28:38 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: buffer allocation: was: [PATCH v3 3/3] printk: use the lockless
 ringbuffer
Message-ID: <20200625082838.GF6156@alley>
References: <20200618144919.9806-1-john.ogness@linutronix.de>
 <20200618144919.9806-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200618144919.9806-4-john.ogness@linutronix.de>
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
Cc: Andrea Parri <parri.andrea@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Paul McKenney <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu 2020-06-18 16:55:19, John Ogness wrote:
> Replace the existing ringbuffer usage and implementation with
> lockless ringbuffer usage. Even though the new ringbuffer does not
> require locking, all existing locking is left in place. Therefore,
> this change is purely replacing the underlining ringbuffer.
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1176,11 +1068,46 @@ static void __init set_percpu_data_ready(void)
>  	__printk_percpu_data_ready = true;
>  }
>  
> +static unsigned int __init add_to_rb(struct printk_ringbuffer *rb,
> +				     struct printk_record *r)
> +{
> +	struct prb_reserved_entry e;
> +	struct printk_record dest_r;
> +
> +	prb_rec_init_wr(&dest_r, r->info->text_len, r->info->dict_len);
> +
> +	if (!prb_reserve(&e, rb, &dest_r))
> +		return 0;
> +
> +	memcpy(&dest_r.text_buf[0], &r->text_buf[0], dest_r.text_buf_size);
> +	if (dest_r.dict_buf) {
> +		memcpy(&dest_r.dict_buf[0], &r->dict_buf[0],
> +		       dest_r.dict_buf_size);
> +	}
> +	dest_r.info->facility = r->info->facility;
> +	dest_r.info->level = r->info->level;
> +	dest_r.info->flags = r->info->flags;
> +	dest_r.info->ts_nsec = r->info->ts_nsec;
> +	dest_r.info->caller_id = r->info->caller_id;
> +
> +	prb_commit(&e);
> +
> +	return prb_record_text_space(&e);
> +}
> +
> +static char setup_text_buf[CONSOLE_EXT_LOG_MAX] __initdata;
> +static char setup_dict_buf[CONSOLE_EXT_LOG_MAX] __initdata;
> +
>  void __init setup_log_buf(int early)
>  {
> +	struct prb_desc *new_descs;
> +	struct printk_info info;
> +	struct printk_record r;
>  	unsigned long flags;
> +	char *new_dict_buf;
>  	char *new_log_buf;
>  	unsigned int free;
> +	u64 seq;
>  
>  	/*
>  	 * Some archs call setup_log_buf() multiple times - first is very
> @@ -1201,17 +1128,50 @@ void __init setup_log_buf(int early)
>  
>  	new_log_buf = memblock_alloc(new_log_buf_len, LOG_ALIGN);
>  	if (unlikely(!new_log_buf)) {
> -		pr_err("log_buf_len: %lu bytes not available\n",
> +		pr_err("log_buf_len: %lu text bytes not available\n",
>  			new_log_buf_len);
>  		return;
>  	}
>  
> +	new_dict_buf = memblock_alloc(new_log_buf_len, LOG_ALIGN);
> +	if (unlikely(!new_dict_buf)) {
> +		/* dictionary failure is allowed */
> +		pr_err("log_buf_len: %lu dict bytes not available\n",
> +			new_log_buf_len);
> +	}
> +
> +	new_descs = memblock_alloc((new_log_buf_len >> PRB_AVGBITS) *
> +				   sizeof(struct prb_desc), LOG_ALIGN);
> +	if (unlikely(!new_descs)) {
> +		pr_err("log_buf_len: %lu desc bytes not available\n",
> +			new_log_buf_len >> PRB_AVGBITS);
> +		if (new_dict_buf)
> +			memblock_free(__pa(new_dict_buf), new_log_buf_len);
> +		memblock_free(__pa(new_log_buf), new_log_buf_len);
> +		return;
> +	}
> +
> +	prb_rec_init_rd(&r, &info,
> +			&setup_text_buf[0], sizeof(setup_text_buf),
> +			&setup_dict_buf[0], sizeof(setup_dict_buf));
> +
>  	logbuf_lock_irqsave(flags);
> +
> +	prb_init(&printk_rb_dynamic,
> +		 new_log_buf, bits_per(new_log_buf_len) - 1,
> +		 new_dict_buf, bits_per(new_log_buf_len) - 1,

This does not check whether new_dict_buf was really allocated.

We should reuse the static one when it was not allocated. But it might
become tricky. We would need to preserve the sequence
numbers of each copied messages and do not copy the dictionary.

I suggest to make it easy and switch to the new buffers only when
all three could get allocated.

Well, we still should try to preserve the sequence numbers. For this,
we might need to allow storing empty messages instead of the lost ones.


> +		 new_descs, (bits_per(new_log_buf_len) - 1) - PRB_AVGBITS);

This is likely safe because new_log_buf_len is assigned only when it is
greater than the previous one. As a result bits_per(new_log_buf_len)
- 1) should be greater than PRB_AVGBITS.

Well, I still feel a bit uneasy about these PRB_AVGBITS operations,
including new_log_buf_len >> PRB_AVGBITS used above.

A more safe design would be to add some sanity checks at the beginning of
the function. And maybe convert new_log_buf_let to number of bits.
Then operate with the number of bits in the rest of the function.
It might be easier to make sure that we are on the safe side.


>  	log_buf_len = new_log_buf_len;
>  	log_buf = new_log_buf;
>  	new_log_buf_len = 0;
> -	free = __LOG_BUF_LEN - log_next_idx;
> -	memcpy(log_buf, __log_buf, __LOG_BUF_LEN);
> +
> +	free = __LOG_BUF_LEN;
> +	prb_for_each_record(0, &printk_rb_static, seq, &r)
> +		free -= add_to_rb(&printk_rb_dynamic, &r);
> +
> +	prb = &printk_rb_dynamic;

This might deserve a comment that this is safe (no lost message)
because it is called early enough when everything is still running
on the boot CPU.

> +
>  	logbuf_unlock_irqrestore(flags);
>  
>  	pr_info("log_buf_len: %u bytes\n", log_buf_len);

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
