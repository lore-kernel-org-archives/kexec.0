Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jafR7-00029O-Nh
 for kexec@lists.infradead.org; Mon, 18 May 2020 13:04:10 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v2 2/3] printk: add lockless buffer
References: <20200501094010.17694-1-john.ogness@linutronix.de>
 <20200501094010.17694-3-john.ogness@linutronix.de>
Date: Mon, 18 May 2020 15:03:53 +0200
In-Reply-To: <20200501094010.17694-3-john.ogness@linutronix.de> (John Ogness's
 message of "Fri, 1 May 2020 11:46:09 +0206")
Message-ID: <87v9ktcs3q.fsf@vostro.fn.ogness.net>
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
Cc: Andrea Parri <parri.andrea@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

Hi,

For the v2 I was supposed to have fixed a bug in v1. The cover letter
stated:

- data_push_tail(): continue loop rather than try cmpxchg() if
  tail LPOS was pushed

Unfortunately, the fix was incorrect and actually made it worse. The
explanation and patch are below.

On 2020-05-01, John Ogness <john.ogness@linutronix.de> wrote:
> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> new file mode 100644
> index 000000000000..e0a66468d4f3
> --- /dev/null
> +++ b/kernel/printk/printk_ringbuffer.c
...
> +/*
> + * Advance the data ring tail to at least @lpos. This function puts
> + * descriptors into the reusable state if the tail is pushed beyond
> + * their associated data block.
> + */
> +static bool data_push_tail(struct printk_ringbuffer *rb,
> +			   struct prb_data_ring *data_ring,
> +			   unsigned long lpos)
> +{
> +	unsigned long tail_lpos;
> +	unsigned long next_lpos;
> +
> +	/* If @lpos is not valid, there is nothing to do. */
> +	if (lpos == INVALID_LPOS)
> +		return true;
> +
> +	tail_lpos = atomic_long_read(&data_ring->tail_lpos);
> +
> +	do {
> +		/* Done, if the tail lpos is already at or beyond @lpos. */
> +		if ((lpos - tail_lpos) - 1 >= DATA_SIZE(data_ring))
> +			break;
> +
> +		/*
> +		 * Make all descriptors reusable that are associated with
> +		 * data blocks before @lpos.
> +		 */
> +		if (!data_make_reusable(rb, data_ring, tail_lpos, lpos,
> +					&next_lpos)) {
> +			/*
> +			 * Guarantee the descriptor state loaded in
> +			 * data_make_reusable() is performed before reloading
> +			 * the tail lpos. The failed data_make_reusable() may
> +			 * be due to a newly recycled descriptor causing
> +			 * the tail lpos to have been previously pushed. This
> +			 * pairs with desc_reserve:D.
> +			 *
> +			 * Memory barrier involvement:
> +			 *
> +			 * If data_make_reusable:D reads from desc_reserve:G,
> +			 * then data_push_tail:B reads from data_push_tail:D.
> +			 *
> +			 * Relies on:
> +			 *
> +			 * MB from data_push_tail:D to desc_reserve:G
> +			 *    matching
> +			 * RMB from data_make_reusable:D to data_push_tail:B
> +			 *
> +			 * Note: data_push_tail:D and desc_reserve:G can be
> +			 *       different CPUs. However, the desc_reserve:G
> +			 *       CPU (which performs the full memory barrier)
> +			 *       must have previously seen data_push_tail:D.
> +			 */
> +			smp_rmb(); /* LMM(data_push_tail:A) */
> +
> +			next_lpos = atomic_long_read(&data_ring->tail_lpos
> +						); /* LMM(data_push_tail:B) */
> +			if (next_lpos == tail_lpos)
> +				return false;
> +
> +			/* Another task pushed the tail. Try again. */
> +			tail_lpos = next_lpos;
> +			continue;

The purpose of the continue is to try again _without_ attempting a
cmpxchg(). However, since the cmpxchg() is in the while condition, it
_is_ called. This is a major problem because if the cmpxchg() succeeds
(highly likely at this point) then the smp_mb() is not called and
success is returned even though the tail may not have been pushed far
enough.

The cmpxchg() needs to be moved out of the while condition so that a
continue can be used as intended. Patch below.

> +		}
> +
> +		/*
> +		 * Guarantee any descriptor states that have transitioned to
> +		 * reusable are stored before pushing the tail lpos. This
> +		 * allows readers to identify if data has expired while
> +		 * reading the descriptor. This pairs with desc_read:D.
> +		 */
> +		smp_mb(); /* LMM(data_push_tail:C) */
> +
> +	} while (!atomic_long_try_cmpxchg_relaxed(&data_ring->tail_lpos,
> +			&tail_lpos, next_lpos)); /* LMM(data_push_tail:D) */
> +
> +	return true;
> +}

John Ogness

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index e0a66468d4f3..ac542bdb8deb 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -546,11 +546,8 @@ static bool data_push_tail(struct printk_ringbuffer *rb,
 
 	tail_lpos = atomic_long_read(&data_ring->tail_lpos);
 
-	do {
-		/* Done, if the tail lpos is already at or beyond @lpos. */
-		if ((lpos - tail_lpos) - 1 >= DATA_SIZE(data_ring))
-			break;
-
+	/* Done, if the tail lpos is already at or beyond @lpos. */
+	while ((lpos - tail_lpos) - 1 < DATA_SIZE(data_ring)) {
 		/*
 		 * Make all descriptors reusable that are associated with
 		 * data blocks before @lpos.
@@ -601,8 +598,12 @@ static bool data_push_tail(struct printk_ringbuffer *rb,
 		 */
 		smp_mb(); /* LMM(data_push_tail:C) */
 
-	} while (!atomic_long_try_cmpxchg_relaxed(&data_ring->tail_lpos,
-			&tail_lpos, next_lpos)); /* LMM(data_push_tail:D) */
+		if (atomic_long_try_cmpxchg_relaxed(&data_ring->tail_lpos,
+				&tail_lpos,
+				next_lpos)) { /* LMM(data_push_tail:D) */
+			break;
+		}
+	}
 
 	return true;
 }

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
