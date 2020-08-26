Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAqxY-00072R-Gm
 for kexec@lists.infradead.org; Wed, 26 Aug 2020 08:39:09 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v2 5/7][next] printk: ringbuffer: add
 finalization/extension support
In-Reply-To: <20200824103538.31446-6-john.ogness@linutronix.de>
References: <20200824103538.31446-1-john.ogness@linutronix.de>
 <20200824103538.31446-6-john.ogness@linutronix.de>
Date: Wed, 26 Aug 2020 10:45:03 +0206
Message-ID: <87lfi1ls2g.fsf@jogness.linutronix.de>
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

On 2020-08-24, John Ogness <john.ogness@linutronix.de> wrote:
> @@ -1157,6 +1431,14 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
>  		goto fail;
>  	}
>  
> +	/*
> +	 * New data is about to be reserved. Once that happens, previous
> +	 * descriptors are no longer able to be extended. Finalize the
> +	 * previous descriptor now so that it can be made available to
> +	 * readers (when committed).
> +	 */
> +	desc_finalize(desc_ring, DESC_ID(id - 1));
> +
>  	d = to_desc(desc_ring, id);
>  
>  	/*

Apparently this is not enough to guarantee that past descriptors are
finalized. I am able to reproduce a scenario where the finalization of a
certain descriptor never happens. That leaves the descriptor permanently
in the reserved queried state, which prevents any new records from being
created. I am investigating.

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
