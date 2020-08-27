Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBEgQ-0003FO-Kl
 for kexec@lists.infradead.org; Thu, 27 Aug 2020 09:59:03 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v2 5/7][next] printk: ringbuffer: add
 finalization/extension support
In-Reply-To: <20200826150726.GA4928@alley>
References: <20200824103538.31446-1-john.ogness@linutronix.de>
 <20200824103538.31446-6-john.ogness@linutronix.de>
 <87lfi1ls2g.fsf@jogness.linutronix.de>
 <20200826100113.GA8849@jagdpanzerIV.localdomain>
 <87eentlh19.fsf@jogness.linutronix.de> <20200826150726.GA4928@alley>
Date: Thu, 27 Aug 2020 12:04:58 +0206
Message-ID: <87pn7c5s0t.fsf@jogness.linutronix.de>
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

On 2020-08-26, Petr Mladek <pmladek@suse.com> wrote:
>> This series makes a very naive assumption that the previous
>> descriptor is either in the reserved or committed queried states. The
>> fact is, it can be in any of the 4 queried states. Adding support for
>> finalization of all the states then gets quite complex, since any
>> state transition (cmpxchg) may have to deal with an unexpected FINAL
>> flag.
>
> It has to be done in two steps to avoid race:
>
> prb_commit()
>
>    + set PRB_COMMIT_MASK
>    + check if it is still the last descriptor in the array
>    + set PRB_FINAL_MASK when it is not the last descriptor
>
> It should work because prb_reserve() finalizes the previous
> descriptor after the new one is reserved. As a result:
>
>    + prb_reserve() should either see PRB_COMMIT_MASK in the previous
>      descriptor and be able to finalize it.
>
>    + or prb_commit() will see that the head moved and it is not
>      longer the last reserved one.

I do not like the idea of relying on descriptors to finalize
themselves. I worry that there might be some hole there. Failing to
finalize basically disables printk, so that is pretty serious.

Below is a patch against this series that adds support for finalizing
all 4 queried states. It passes all my tests. Note that the code handles
2 corner cases:

1. When seq is 0, there is no previous descriptor to finalize. This
   exception is important because we don't want to finalize the -1
   placeholder. Otherwise, upon the first wrap, a descriptor will be
   prematurely finalized.

2. When a previous descriptor is being reserved for the first time, it
   might have a state_var value of 0 because the writer is still in
   prb_reserve() and has not set the initial value yet. I added
   considerable comments on this special case.

I am comfortable with adding this new code, although it clearly adds
complexity.

John Ogness

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 90d48973ac9e..1ed1e9eb930f 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -860,9 +860,11 @@ static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
 	struct prb_desc_ring *desc_ring = &rb->desc_ring;
 	unsigned long prev_state_val;
 	unsigned long id_prev_wrap;
+	unsigned long state_val;
 	struct prb_desc *desc;
 	unsigned long head_id;
 	unsigned long id;
+	bool is_final;
 
 	head_id = atomic_long_read(&desc_ring->head_id); /* LMM(desc_reserve:A) */
 
@@ -953,10 +955,17 @@ static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
 	 * See "ABA Issues" about why this verification is performed.
 	 */
 	prev_state_val = atomic_long_read(&desc->state_var); /* LMM(desc_reserve:E) */
-	if (prev_state_val &&
-	    get_desc_state(id_prev_wrap, prev_state_val, NULL) != desc_reusable) {
-		WARN_ON_ONCE(1);
-		return false;
+	if (get_desc_state(id_prev_wrap, prev_state_val, &is_final) != desc_reusable) {
+		/*
+		 * If this descriptor has never been used, @prev_state_val
+		 * will be 0. However, even though it may have never been
+		 * used, it may have been finalized. So that flag must be
+		 * ignored.
+		 */
+		if ((prev_state_val & ~DESC_FINAL_MASK)) {
+			WARN_ON_ONCE(1);
+			return false;
+		}
 	}
 
 	/*
@@ -967,10 +976,25 @@ static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
 	 * any other changes. A write memory barrier is sufficient for this.
 	 * This pairs with desc_read:D.
 	 */
-	if (!atomic_long_try_cmpxchg(&desc->state_var, &prev_state_val,
-				     id | 0)) { /* LMM(desc_reserve:F) */
-		WARN_ON_ONCE(1);
-		return false;
+	if (is_final)
+		state_val = id | 0 | DESC_FINAL_MASK;
+	else
+		state_val = id | 0;
+	if (atomic_long_cmpxchg(&desc->state_var, prev_state_val,
+				state_val) != prev_state_val) { /* LMM(desc_reserve:F) */
+		/*
+		 * This reusable descriptor must have been finalized already.
+		 * Retry with a reusable+final expected value.
+		 */
+		prev_state_val |= DESC_FINAL_MASK;
+		state_val |= DESC_FINAL_MASK;
+
+		if (!atomic_long_try_cmpxchg(&desc->state_var, &prev_state_val,
+					     state_val)) { /* LMM(desc_reserve:FIXME) */
+
+			WARN_ON_ONCE(1);
+			return false;
+		}
 	}
 
 	/* Now data in @desc can be modified: LMM(desc_reserve:G) */
@@ -1364,9 +1388,37 @@ static void desc_finalize(struct prb_desc_ring *desc_ring, unsigned long id)
 	while (!atomic_long_try_cmpxchg_relaxed(&d->state_var, &prev_state_val,
 						prev_state_val | DESC_FINAL_MASK)) {
 
-		if (get_desc_state(id, prev_state_val, &is_final) != desc_reserved)
+		switch (get_desc_state(id, prev_state_val, &is_final)) {
+		case desc_miss:
+			/*
+			 * If the ID is exactly 1 wrap behind the expected, it is
+			 * in the process of being reserved by another writer and
+			 * must be considered reserved.
+			 */
+			if (get_desc_state(DESC_ID_PREV_WRAP(desc_ring, id),
+					   prev_state_val, &is_final) != desc_reusable) {
+				/*
+				 * If this descriptor has never been used, @prev_state_val
+				 * will be 0. However, even though it may have never been
+				 * used, it may have been finalized. So that flag must be
+				 * ignored.
+				 */
+				if ((prev_state_val & ~DESC_FINAL_MASK)) {
+					WARN_ON_ONCE(1);
+					return;
+				}
+			}
+			fallthrough;
+		case desc_reserved:
+		case desc_reusable:
+			/* finalizable, try again */
 			break;
+		case desc_committed:
+			/* already finalized */
+			return;
+		}
 
+		/* already finalized? */
 		if (is_final)
 			break;
 	}
@@ -1431,14 +1483,6 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 		goto fail;
 	}
 
-	/*
-	 * New data is about to be reserved. Once that happens, previous
-	 * descriptors are no longer able to be extended. Finalize the
-	 * previous descriptor now so that it can be made available to
-	 * readers (when committed).
-	 */
-	desc_finalize(desc_ring, DESC_ID(id - 1));
-
 	d = to_desc(desc_ring, id);
 
 	/*
@@ -1464,6 +1508,16 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 	else
 		d->info.seq += DESCS_COUNT(desc_ring);
 
+	/*
+	 * New data is about to be reserved. Once that happens, previous
+	 * descriptors are no longer able to be extended. Finalize the
+	 * previous descriptor now so that it can be made available to
+	 * readers (when committed). (For the first descriptor, there is
+	 * no previous record to finalize.)
+	 */
+	if (d->info.seq > 0)
+		desc_finalize(desc_ring, DESC_ID(id - 1));
+
 	r->text_buf = data_alloc(rb, &rb->text_data_ring, r->text_buf_size,
 				 &d->text_blk_lpos, id);
 	/* If text data allocation fails, a data-less record is committed. */

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
