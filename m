Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtohD-0005mR-Ok
 for kexec@lists.infradead.org; Fri, 10 Jul 2020 08:47:52 +0000
Received: by mail-pf1-x441.google.com with SMTP id z3so2230206pfn.12
 for <kexec@lists.infradead.org>; Fri, 10 Jul 2020 01:47:48 -0700 (PDT)
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Date: Fri, 10 Jul 2020 17:47:44 +0900
Subject: Re: [PATCH v5 2/4] printk: add lockless ringbuffer
Message-ID: <20200710084744.GA488397@jagdpanzerIV.localdomain>
References: <20200709132344.760-1-john.ogness@linutronix.de>
 <20200709132344.760-3-john.ogness@linutronix.de>
 <20200710084305.GA144760@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200710084305.GA144760@jagdpanzerIV.localdomain>
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
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Andrea Parri <parri.andrea@gmail.com>, Petr Mladek <pmladek@suse.com>, Paul McKenney <paulmck@kernel.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, John Ogness <john.ogness@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On (20/07/10 17:43), Sergey Senozhatsky wrote:
> [..]
> 
> > +void prb_init(struct printk_ringbuffer *rb,
> > +	      char *text_buf, unsigned int textbits,
> > +	      char *dict_buf, unsigned int dictbits,
> > +	      struct prb_desc *descs, unsigned int descbits)
> > +{
> > +	memset(descs, 0, _DESCS_COUNT(descbits) * sizeof(descs[0]));
> > +
> > +	rb->desc_ring.count_bits = descbits;
> > +	rb->desc_ring.descs = descs;
> > +	atomic_long_set(&rb->desc_ring.head_id, DESC0_ID(descbits));
> > +	atomic_long_set(&rb->desc_ring.tail_id, DESC0_ID(descbits));
> > +
> > +	rb->text_data_ring.size_bits = textbits;
> > +	rb->text_data_ring.data = text_buf;
> > +	atomic_long_set(&rb->text_data_ring.head_lpos, BLK0_LPOS(textbits));
> > +	atomic_long_set(&rb->text_data_ring.tail_lpos, BLK0_LPOS(textbits));
> > +
> > +	rb->dict_data_ring.size_bits = dictbits;
> > +	rb->dict_data_ring.data = dict_buf;
> > +	atomic_long_set(&rb->dict_data_ring.head_lpos, BLK0_LPOS(dictbits));
> > +	atomic_long_set(&rb->dict_data_ring.tail_lpos, BLK0_LPOS(dictbits));
> > +
> 
> Just a side note: some people want !CONFIG_PRINTK builds. I wonder
> how many people will want !CONFIG_PRINTK_DICT. The core logbuf/dict
> logbuf split is really cool.

We also may be can add a dedicated logbuf for the user-space logs,
as opposed to current "user space can write to the kernel logbuf".
Some folks really dislike that systemd, for instance, can trash
the core kernel logbuf doing a lot of /dev/kmsg writes.

	-ss

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
