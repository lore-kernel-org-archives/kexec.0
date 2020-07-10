Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtoci-00058O-Fp
 for kexec@lists.infradead.org; Fri, 10 Jul 2020 08:43:13 +0000
Received: by mail-pj1-x1041.google.com with SMTP id cv18so4305834pjb.1
 for <kexec@lists.infradead.org>; Fri, 10 Jul 2020 01:43:09 -0700 (PDT)
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Date: Fri, 10 Jul 2020 17:43:05 +0900
Subject: Re: [PATCH v5 2/4] printk: add lockless ringbuffer
Message-ID: <20200710084305.GA144760@jagdpanzerIV.localdomain>
References: <20200709132344.760-1-john.ogness@linutronix.de>
 <20200709132344.760-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200709132344.760-3-john.ogness@linutronix.de>
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
Cc: Andrea Parri <parri.andrea@gmail.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Paul McKenney <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On (20/07/09 15:29), John Ogness wrote:
[..]
> +/*
> + * A data block: mapped directly to the beginning of the data block area
> + * specified as a logical position within the data ring.
> + *
> + * @id:   the ID of the associated descriptor
> + * @data: the writer data
> + *
> + * Note that the size of a data block is only known by its associated
> + * descriptor.
> + */
> +struct prb_data_block {
> +	unsigned long	id;
> +	char		data[0];
> +};

A nit: I think someone will send "Replace zero-length arrays with
flexible array member" soon enough:

-	char		data[0];
+	char		data[];

[..]
> +/*
> + * Sanity checker for reserve size. The ringbuffer code assumes that a data
> + * block does not exceed the maximum possible size that could fit within the
> + * ringbuffer. This function provides that basic size check so that the
> + * assumption is safe.
> + *
> + * Writers are also not allowed to write 0-sized (data-less) records. Such
> + * records are used only internally by the ringbuffer.
> + */
> +static bool data_check_size(struct prb_data_ring *data_ring, unsigned int size)
> +{
> +	struct prb_data_block *db = NULL;
> +
> +	/*
> +	 * Writers are not allowed to write data-less records. Such records
> +	 * are used only internally by the ringbuffer to denote records where
> +	 * their data failed to allocate or have been lost.
> +	 */

A nit: The same data-less records comment is some 5 lines earlier. But OK.

> +	if (size == 0)
> +		return false;

[..]

> +void prb_init(struct printk_ringbuffer *rb,
> +	      char *text_buf, unsigned int textbits,
> +	      char *dict_buf, unsigned int dictbits,
> +	      struct prb_desc *descs, unsigned int descbits)
> +{
> +	memset(descs, 0, _DESCS_COUNT(descbits) * sizeof(descs[0]));
> +
> +	rb->desc_ring.count_bits = descbits;
> +	rb->desc_ring.descs = descs;
> +	atomic_long_set(&rb->desc_ring.head_id, DESC0_ID(descbits));
> +	atomic_long_set(&rb->desc_ring.tail_id, DESC0_ID(descbits));
> +
> +	rb->text_data_ring.size_bits = textbits;
> +	rb->text_data_ring.data = text_buf;
> +	atomic_long_set(&rb->text_data_ring.head_lpos, BLK0_LPOS(textbits));
> +	atomic_long_set(&rb->text_data_ring.tail_lpos, BLK0_LPOS(textbits));
> +
> +	rb->dict_data_ring.size_bits = dictbits;
> +	rb->dict_data_ring.data = dict_buf;
> +	atomic_long_set(&rb->dict_data_ring.head_lpos, BLK0_LPOS(dictbits));
> +	atomic_long_set(&rb->dict_data_ring.tail_lpos, BLK0_LPOS(dictbits));
> +

Just a side note: some people want !CONFIG_PRINTK builds. I wonder
how many people will want !CONFIG_PRINTK_DICT. The core logbuf/dict
logbuf split is really cool.

	-ss

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
