Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpuOv-0004BQ-Ta
 for kexec@lists.infradead.org; Mon, 29 Jun 2020 14:04:52 +0000
Date: Mon, 29 Jun 2020 16:04:45 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: buffer allocation: was: [PATCH v3 3/3] printk: use the lockless
 ringbuffer
Message-ID: <20200629140445.GK6156@alley>
References: <20200618144919.9806-1-john.ogness@linutronix.de>
 <20200618144919.9806-4-john.ogness@linutronix.de>
 <20200625082838.GF6156@alley>
 <87sgeh3m5j.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87sgeh3m5j.fsf@jogness.linutronix.de>
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

On Fri 2020-06-26 17:02:48, John Ogness wrote:
> On 2020-06-25, Petr Mladek <pmladek@suse.com> wrote:
> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> >> +	free = __LOG_BUF_LEN;
> >> +	prb_for_each_record(0, &printk_rb_static, seq, &r)
> >> +		free -= add_to_rb(&printk_rb_dynamic, &r);
> >> +
> >> +	prb = &printk_rb_dynamic;
> >
> > This might deserve a comment that this is safe (no lost message)
> > because it is called early enough when everything is still running
> > on the boot CPU.
> 
> I will add a comment and an extra check to make sure.
> 
> Once everything is lockless, new messages could appear (for example, due
> to NMI messages). The simple check should probably change to a loop. But
> let us not worry about that at this point.

Yup.

> Below is a new version of the relevant patch snippets against mainline
> just to show you how I plan to make it look for the next version.
> 
> John Ogness
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ @@
> +#define PRB_AVGBITS 5	/* 32 character average length */
> +
> +#if CONFIG_LOG_BUF_SHIFT <= PRB_AVGBITS
> +#error CONFIG_LOG_BUF_SHIFT value too small.
> +#endif
> +_DEFINE_PRINTKRB(printk_rb_static, CONFIG_LOG_BUF_SHIFT - PRB_AVGBITS,
> +		 PRB_AVGBITS, PRB_AVGBITS, &__log_buf[0]);
> +
> @@ @@
>  void __init setup_log_buf(int early)
>  {
> +	unsigned int new_descs_count;
> +	struct prb_desc *new_descs;
> +	struct printk_info info;
> +	struct printk_record r;
> +	size_t new_descs_size;
>  	unsigned long flags;
> +	char *new_dict_buf;
>  	char *new_log_buf;
>  	unsigned int free;
> +	u64 seq;
>  
>  	/*
>  	 * Some archs call setup_log_buf() multiple times - first is very
> @@ @@ void __init setup_log_buf(int early)
>  	if (!new_log_buf_len)
>  		return;
>  
> +	new_descs_count = new_log_buf_len >> PRB_AVGBITS;
> +	if (new_descs_count == 0) {
> +		pr_err("new_log_buf_len: %lu too small\n", new_log_buf_len);
> +		return;
> +	}
> +
>  	new_log_buf = memblock_alloc(new_log_buf_len, LOG_ALIGN);
>  	if (unlikely(!new_log_buf)) {
> -		pr_err("log_buf_len: %lu bytes not available\n",
> -			new_log_buf_len);
> +		pr_err("log_buf_len: %lu text bytes not available\n",
> +		       new_log_buf_len);
> +		return;
> +	}
> +
> +	new_dict_buf = memblock_alloc(new_log_buf_len, LOG_ALIGN);
> +	if (unlikely(!new_dict_buf)) {
> +		pr_err("log_buf_len: %lu dict bytes not available\n",
> +		       new_log_buf_len);
> +		memblock_free(__pa(new_log_buf), new_log_buf_len);
>  		return;
>  	}
>  
> +	new_descs_size = new_descs_count * sizeof(struct prb_desc);
> +	new_descs = memblock_alloc(new_descs_size, LOG_ALIGN);
> +	if (unlikely(!new_descs)) {
> +		pr_err("log_buf_len: %lu desc bytes not available\n",
> +		       new_descs_size);
> +		memblock_free(__pa(new_dict_buf), new_log_buf_len);
> +		memblock_free(__pa(new_log_buf), new_log_buf_len);
> +		return;
> +	}
> +
> +	prb_rec_init_rd(&r, &info,
> +			&setup_text_buf[0], sizeof(setup_text_buf),
> +			&setup_dict_buf[0], sizeof(setup_dict_buf));
> +
> +	prb_init(&printk_rb_dynamic,
> +		 new_log_buf, order_base_2(new_log_buf_len),
> +		 new_dict_buf, order_base_2(new_log_buf_len),
> +		 new_descs, order_base_2(new_descs_count));

order_base_2() is safe. But the result might be tat some allocated
space is not used.

I would prefer to make sure that new_log_buf_len is rounded, e.g.
by roundup_pow_of_two(), at the beginning of the function. Then we
could use ilog2() here.

Otherwise, it looks fine to me.

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
