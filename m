Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kHngE-0005Oq-Dd
 for kexec@lists.infradead.org; Mon, 14 Sep 2020 12:34:01 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH printk v5 3/6] printk: ringbuffer: clear initial reserved
 fields
Date: Mon, 14 Sep 2020 14:39:51 +0206
Message-Id: <20200914123354.832-4-john.ogness@linutronix.de>
In-Reply-To: <20200914123354.832-1-john.ogness@linutronix.de>
References: <20200914123354.832-1-john.ogness@linutronix.de>
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

prb_reserve() will set some meta data values and leave others
uninitialized (or rather, containing the values of the previous
wrap). Simplify the API by always clearing out all the fields.
Only the sequence number is filled in. The caller is now
responsible for filling in the rest of the meta data fields.
In particular, for correctly filling in text and dict lengths.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c            | 12 ++++++++----
 kernel/printk/printk_ringbuffer.c | 30 ++++++++++++++++++------------
 2 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fec71229169e..964b5701688f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -520,8 +520,11 @@ static int log_store(u32 caller_id, int facility, int level,
 	memcpy(&r.text_buf[0], text, text_len);
 	if (trunc_msg_len)
 		memcpy(&r.text_buf[text_len], trunc_msg, trunc_msg_len);
-	if (r.dict_buf)
+	r.info->text_len = text_len + trunc_msg_len;
+	if (r.dict_buf) {
 		memcpy(&r.dict_buf[0], dict, dict_len);
+		r.info->dict_len = dict_len;
+	}
 	r.info->facility = facility;
 	r.info->level = level & 7;
 	r.info->flags = flags & 0x1f;
@@ -1069,10 +1072,11 @@ static unsigned int __init add_to_rb(struct printk_ringbuffer *rb,
 	if (!prb_reserve(&e, rb, &dest_r))
 		return 0;
 
-	memcpy(&dest_r.text_buf[0], &r->text_buf[0], dest_r.text_buf_size);
+	memcpy(&dest_r.text_buf[0], &r->text_buf[0], r->info->text_len);
+	dest_r.info->text_len = r->info->text_len;
 	if (dest_r.dict_buf) {
-		memcpy(&dest_r.dict_buf[0], &r->dict_buf[0],
-		       dest_r.dict_buf_size);
+		memcpy(&dest_r.dict_buf[0], &r->dict_buf[0], r->info->dict_len);
+		dest_r.info->dict_len = r->info->dict_len;
 	}
 	dest_r.info->facility = r->info->facility;
 	dest_r.info->level = r->info->level;
diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 6ee5ebce1450..82347abb22a5 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -146,10 +146,13 @@
  *
  *	if (prb_reserve(&e, &test_rb, &r)) {
  *		snprintf(r.text_buf, r.text_buf_size, "%s", textstr);
+ *		r.info->text_len = strlen(textstr);
  *
  *		// dictionary allocation may have failed
- *		if (r.dict_buf)
+ *		if (r.dict_buf) {
  *			snprintf(r.dict_buf, r.dict_buf_size, "%s", dictstr);
+ *			r.info->dict_len = strlen(dictstr);
+ *		}
  *
  *		r.info->ts_nsec = local_clock();
  *
@@ -1125,9 +1128,9 @@ static const char *get_data(struct prb_data_ring *data_ring,
  * @dict_buf_size is set to 0. Writers must check this before writing to
  * dictionary space.
  *
- * @info->text_len and @info->dict_len will already be set to @text_buf_size
- * and @dict_buf_size, respectively. If dictionary space reservation fails,
- * @info->dict_len is set to 0.
+ * Important: @info->text_len and @info->dict_len need to be set correctly by
+ *            the writer in order for data to be readable and/or extended.
+ *            Their values are initialized to 0.
  */
 bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 		 struct printk_record *r)
@@ -1135,6 +1138,7 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 	struct prb_desc_ring *desc_ring = &rb->desc_ring;
 	struct prb_desc *d;
 	unsigned long id;
+	u64 seq;
 
 	if (!data_check_size(&rb->text_data_ring, r->text_buf_size))
 		goto fail;
@@ -1159,6 +1163,14 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 
 	d = to_desc(desc_ring, id);
 
+	/*
+	 * All @info fields (except @seq) are cleared and must be filled in
+	 * by the writer. Save @seq before clearing because it is used to
+	 * determine the new sequence number.
+	 */
+	seq = d->info.seq;
+	memset(&d->info, 0, sizeof(d->info));
+
 	/*
 	 * Set the @e fields here so that prb_commit() can be used if
 	 * text data allocation fails.
@@ -1177,17 +1189,15 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 	 * See the "Bootstrap" comment block in printk_ringbuffer.h for
 	 * details about how the initializer bootstraps the descriptors.
 	 */
-	if (d->info.seq == 0 && DESC_INDEX(desc_ring, id) != 0)
+	if (seq == 0 && DESC_INDEX(desc_ring, id) != 0)
 		d->info.seq = DESC_INDEX(desc_ring, id);
 	else
-		d->info.seq += DESCS_COUNT(desc_ring);
+		d->info.seq = seq + DESCS_COUNT(desc_ring);
 
 	r->text_buf = data_alloc(rb, &rb->text_data_ring, r->text_buf_size,
 				 &d->text_blk_lpos, id);
 	/* If text data allocation fails, a data-less record is committed. */
 	if (r->text_buf_size && !r->text_buf) {
-		d->info.text_len = 0;
-		d->info.dict_len = 0;
 		prb_commit(e);
 		/* prb_commit() re-enabled interrupts. */
 		goto fail;
@@ -1204,10 +1214,6 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 
 	r->info = &d->info;
 
-	/* Set default values for the sizes. */
-	d->info.text_len = r->text_buf_size;
-	d->info.dict_len = r->dict_buf_size;
-
 	/* Record full text space used by record. */
 	e->text_space = space_used(&rb->text_data_ring, &d->text_blk_lpos);
 
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
