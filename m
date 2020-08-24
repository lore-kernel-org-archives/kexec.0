Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kA9pG-0001cO-D8
 for kexec@lists.infradead.org; Mon, 24 Aug 2020 10:35:44 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH v2 1/7][next] printk: ringbuffer: rename DESC_COMMITTED_MASK
 flag
Date: Mon, 24 Aug 2020 12:41:32 +0206
Message-Id: <20200824103538.31446-2-john.ogness@linutronix.de>
In-Reply-To: <20200824103538.31446-1-john.ogness@linutronix.de>
References: <20200824103538.31446-1-john.ogness@linutronix.de>
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

The flag DESC_COMMITTED_MASK has a much longer name compared to the
other state flags and also is in past tense form, rather than in
command form. Rename the flag to DESC_COMMIT_MASK in order to match
the other state flags.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk_ringbuffer.c | 8 ++++----
 kernel/printk/printk_ringbuffer.h | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 0659b50872b5..76248c82d557 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -361,7 +361,7 @@ static enum desc_state get_desc_state(unsigned long id,
 	if (state_val & DESC_REUSE_MASK)
 		return desc_reusable;
 
-	if (state_val & DESC_COMMITTED_MASK)
+	if (state_val & DESC_COMMIT_MASK)
 		return desc_committed;
 
 	return desc_reserved;
@@ -462,7 +462,7 @@ static enum desc_state desc_read(struct prb_desc_ring *desc_ring,
 static void desc_make_reusable(struct prb_desc_ring *desc_ring,
 			       unsigned long id)
 {
-	unsigned long val_committed = id | DESC_COMMITTED_MASK;
+	unsigned long val_committed = id | DESC_COMMIT_MASK;
 	unsigned long val_reusable = val_committed | DESC_REUSE_MASK;
 	struct prb_desc *desc = to_desc(desc_ring, id);
 	atomic_long_t *state_var = &desc->state_var;
@@ -899,7 +899,7 @@ static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
 	 */
 	prev_state_val = atomic_long_read(&desc->state_var); /* LMM(desc_reserve:E) */
 	if (prev_state_val &&
-	    prev_state_val != (id_prev_wrap | DESC_COMMITTED_MASK | DESC_REUSE_MASK)) {
+	    prev_state_val != (id_prev_wrap | DESC_COMMIT_MASK | DESC_REUSE_MASK)) {
 		WARN_ON_ONCE(1);
 		return false;
 	}
@@ -1184,7 +1184,7 @@ void prb_commit(struct prb_reserved_entry *e)
 	 * this. This pairs with desc_read:B.
 	 */
 	if (!atomic_long_try_cmpxchg(&d->state_var, &prev_state_val,
-				     e->id | DESC_COMMITTED_MASK)) { /* LMM(prb_commit:B) */
+				     e->id | DESC_COMMIT_MASK)) { /* LMM(prb_commit:B) */
 		WARN_ON_ONCE(1);
 	}
 
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index e6302da041f9..dcda5e9b4676 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -115,9 +115,9 @@ struct prb_reserved_entry {
 #define _DATA_SIZE(sz_bits)		(1UL << (sz_bits))
 #define _DESCS_COUNT(ct_bits)		(1U << (ct_bits))
 #define DESC_SV_BITS			(sizeof(unsigned long) * 8)
-#define DESC_COMMITTED_MASK		(1UL << (DESC_SV_BITS - 1))
+#define DESC_COMMIT_MASK		(1UL << (DESC_SV_BITS - 1))
 #define DESC_REUSE_MASK			(1UL << (DESC_SV_BITS - 2))
-#define DESC_FLAGS_MASK			(DESC_COMMITTED_MASK | DESC_REUSE_MASK)
+#define DESC_FLAGS_MASK			(DESC_COMMIT_MASK | DESC_REUSE_MASK)
 #define DESC_ID_MASK			(~DESC_FLAGS_MASK)
 #define DESC_ID(sv)			((sv) & DESC_ID_MASK)
 #define FAILED_LPOS			0x1
@@ -213,7 +213,7 @@ struct prb_reserved_entry {
  */
 #define BLK0_LPOS(sz_bits)	(-(_DATA_SIZE(sz_bits)))
 #define DESC0_ID(ct_bits)	DESC_ID(-(_DESCS_COUNT(ct_bits) + 1))
-#define DESC0_SV(ct_bits)	(DESC_COMMITTED_MASK | DESC_REUSE_MASK | DESC0_ID(ct_bits))
+#define DESC0_SV(ct_bits)	(DESC_COMMIT_MASK | DESC_REUSE_MASK | DESC0_ID(ct_bits))
 
 /*
  * Define a ringbuffer with an external text data buffer. The same as
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
