Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([193.142.43.55])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kCYLh-0000yQ-Df
 for kexec@lists.infradead.org; Mon, 31 Aug 2020 01:11:10 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH next v3 5/8] printk: ringbuffer: clear initial reserved fields
Date: Mon, 31 Aug 2020 03:16:55 +0206
Message-Id: <20200831011058.6286-6-john.ogness@linutronix.de>
In-Reply-To: <20200831011058.6286-1-john.ogness@linutronix.de>
References: <20200831011058.6286-1-john.ogness@linutronix.de>
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
---
 kernel/printk/printk.c            |  7 ++++++-
 kernel/printk/printk_ringbuffer.c | 29 +++++++++++++++++++----------
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ad8d1dfe5fbe..7e7d596c8878 100644
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
@@ -1078,9 +1081,11 @@ static unsigned int __init add_to_rb(struct printk_ringbuffer *rb,
 		return 0;
 
 	memcpy(&dest_r.text_buf[0], &r->text_buf[0], dest_r.text_buf_size);
+	dest_r.info->text_len = r->info->text_len;
 	if (dest_r.dict_buf) {
 		memcpy(&dest_r.dict_buf[0], &r->dict_buf[0],
 		       dest_r.dict_buf_size);
+		dest_r.info->dict_len = r->info->dict_len;
 	}
 	dest_r.info->facility = r->info->facility;
 	dest_r.info->level = r->info->level;
diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index d66718e74aae..da54d4fadf96 100644
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
@@ -1159,6 +1162,18 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 
 	d = to_desc(desc_ring, id);
 
+	/*
+	 * Clear all @info fields except for @seq, which is used to determine
+	 * the new sequence number. The writer must fill in new values.
+	 */
+	d->info.ts_nsec = 0;
+	d->info.text_len = 0;
+	d->info.dict_len = 0;
+	d->info.facility = 0;
+	d->info.flags = 0;
+	d->info.level = 0;
+	d->info.caller_id = 0;
+
 	/*
 	 * Set the @e fields here so that prb_commit() can be used if
 	 * text data allocation fails.
@@ -1186,8 +1201,6 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 				 &d->text_blk_lpos, id);
 	/* If text data allocation fails, a data-less record is committed. */
 	if (r->text_buf_size && !r->text_buf) {
-		d->info.text_len = 0;
-		d->info.dict_len = 0;
 		prb_commit(e);
 		/* prb_commit() re-enabled interrupts. */
 		goto fail;
@@ -1204,10 +1217,6 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 
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
