Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ia905-0004SJ-N1
 for kexec@lists.infradead.org; Thu, 28 Nov 2019 01:53:49 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: [RFC PATCH v5 2/3] printk-rb: new printk ringbuffer implementation
 (reader)
Date: Thu, 28 Nov 2019 02:58:34 +0106
Message-Id: <20191128015235.12940-3-john.ogness@linutronix.de>
In-Reply-To: <20191128015235.12940-1-john.ogness@linutronix.de>
References: <20191128015235.12940-1-john.ogness@linutronix.de>
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
To: linux-kernel@vger.kernel.org
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Brendan Higgins <brendanhiggins@google.com>, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, kexec@lists.infradead.org

Add the reader implementation for the new ringbuffer.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk_ringbuffer.c | 234 ++++++++++++++++++++++++++++++
 kernel/printk/printk_ringbuffer.h |  12 +-
 2 files changed, 245 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 09c32e52fd40..f85762713583 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -674,3 +674,237 @@ void prb_commit(struct prb_reserved_entry *e)
 	local_irq_restore(e->irqflags);
 }
 EXPORT_SYMBOL(prb_commit);
+
+/*
+ * Given @blk_lpos, return a pointer to the raw data from the data block
+ * and calculate the size of the data part. A NULL pointer is returned
+ * if @blk_lpos specifies values that could never be legal.
+ *
+ * This function (used by readers) performs strict validation on the lpos
+ * values to possibly detect bugs in the writer code. A WARN_ON_ONCE() is
+ * triggered if an internal error is detected.
+ */
+static char *get_data(struct prb_data_ring *data_ring,
+		      struct prb_data_blk_lpos *blk_lpos,
+		      unsigned long *data_size)
+{
+	struct prb_data_block *db;
+
+	if (blk_lpos->begin == INVALID_LPOS &&
+	    blk_lpos->next == INVALID_LPOS) {
+		/* descriptor without a data block */
+		return NULL;
+	} else if (DATA_WRAPS(data_ring, blk_lpos->begin) ==
+		   DATA_WRAPS(data_ring, blk_lpos->next)) {
+		/* regular data block */
+		if (WARN_ON_ONCE(blk_lpos->next <= blk_lpos->begin))
+			return NULL;
+		db = to_block(data_ring, blk_lpos->begin);
+		*data_size = blk_lpos->next - blk_lpos->begin;
+
+	} else if ((DATA_WRAPS(data_ring, blk_lpos->begin) + 1 ==
+		    DATA_WRAPS(data_ring, blk_lpos->next)) ||
+		   ((DATA_WRAPS(data_ring, blk_lpos->begin) ==
+		     DATA_WRAPS(data_ring, -1UL)) &&
+		    (DATA_WRAPS(data_ring, blk_lpos->next) == 0))) {
+		/* wrapping data block */
+		db = to_block(data_ring, 0);
+		*data_size = DATA_INDEX(data_ring, blk_lpos->next);
+
+	} else {
+		WARN_ON_ONCE(1);
+		return NULL;
+	}
+
+	/* A valid data block will always be aligned to the ID size. */
+	if (WARN_ON_ONCE(blk_lpos->begin !=
+			 ALIGN(blk_lpos->begin, sizeof(db->id))) ||
+	    WARN_ON_ONCE(blk_lpos->next !=
+			 ALIGN(blk_lpos->next, sizeof(db->id)))) {
+		return NULL;
+	}
+
+	/* A valid data block will always have at least an ID. */
+	if (WARN_ON_ONCE(*data_size < sizeof(db->id)))
+		return NULL;
+
+	/* Subtract descriptor ID space from size. */
+	*data_size -= sizeof(db->id);
+
+	return &db->data[0];
+}
+
+/* Given @blk_lpos, copy an expected @len of data into the provided buffer. */
+static bool copy_data(struct prb_data_ring *data_ring,
+		      struct prb_data_blk_lpos *blk_lpos, u16 len, char *buf,
+		      unsigned int buf_size)
+{
+	unsigned long data_size;
+	char *data;
+
+	/* Caller might not want the data. */
+	if (!buf || !buf_size)
+		return true;
+
+	data = get_data(data_ring, blk_lpos, &data_size);
+	if (!data)
+		return false;
+
+	/* Actual cannot be less than expected. */
+	if (WARN_ON_ONCE(data_size < len))
+		return false;
+
+	data_size = min_t(u16, buf_size, len);
+
+	if (!WARN_ON_ONCE(!data_size))
+		memcpy(&buf[0], data, data_size);
+	return true;
+}
+
+/*
+ * Read the record @id and verify that it is committed and has the sequence
+ * number @seq.
+ *
+ * Error return values:
+ * -EINVAL: The record @seq does not exist.
+ * -ENOENT: The record @seq exists, but its data is not available. This is a
+ *          valid record, so readers should continue with the next seq.
+ */
+static int desc_read_committed(struct prb_desc_ring *desc_ring, u32 id,
+			       u64 seq, struct prb_desc *desc)
+{
+	enum desc_state d_state;
+
+	d_state = desc_read(desc_ring, id, desc);
+	if (desc->info.seq != seq)
+		return -EINVAL;
+	else if (d_state == desc_reusable)
+		return -ENOENT;
+	else if (d_state != desc_committed)
+		return -EINVAL;
+
+	return 0;
+}
+
+/*
+ * Copy the ringbuffer data from the record with @seq to the provided
+ * @r buffer. On success, 0 is returned.
+ *
+ * See desc_read_committed() for error return values.
+ */
+static int prb_read(struct printk_ringbuffer *rb, u64 seq,
+		    struct printk_record *r)
+{
+	struct prb_desc_ring *desc_ring = &rb->desc_ring;
+	struct prb_desc *rdesc = to_desc(desc_ring, seq);
+	atomic_t *state_var = &rdesc->state_var;
+	struct prb_desc desc;
+	int err;
+	u32 id;
+
+	/* Get a reliable local copy of the descriptor and check validity. */
+	id = DESC_ID(atomic_read(state_var));
+	err = desc_read_committed(desc_ring, id, seq, &desc);
+	if (err)
+		return err;
+
+	/* If requested, copy meta data. */
+	if (r->info)
+		memcpy(r->info, &desc.info, sizeof(*(r->info)));
+
+	/*
+	 * Load/copy text data. If it fails, this is a
+	 * data-less descriptor.
+	 */
+	if (!copy_data(&rb->text_data_ring, &desc.text_blk_lpos,
+		       desc.info.text_len, r->text_buf, r->text_buf_size)) {
+		return -ENOENT;
+	}
+
+	/*
+	 * Load/copy dict data. Although this should not fail, dict data
+	 * is not important. So if it fails, modify the copied meta data
+	 * to report that there is no dict data, thus silently dropping
+	 * the dict data.
+	 */
+	if (!copy_data(&rb->dict_data_ring, &desc.dict_blk_lpos,
+		       desc.info.dict_len, r->dict_buf, r->dict_buf_size)) {
+		if (r->info)
+			r->info->dict_len = 0;
+	}
+
+	/* Re-check real descriptor validity. */
+	return desc_read_committed(desc_ring, id, seq, &desc);
+}
+
+/* Get the sequence number of the tail descriptor. */
+static u64 get_desc_tail_seq(struct printk_ringbuffer *rb)
+{
+	struct prb_desc_ring *desc_ring = &rb->desc_ring;
+	enum desc_state d_state;
+	struct prb_desc desc;
+	u32 id;
+
+	do {
+		id = atomic_read(&rb->desc_ring.tail_id);
+		d_state = desc_read(desc_ring, id, &desc);
+
+		/*
+		 * This loop will not be infinite because the tail is
+		 * _always_ in the committed or reusable state.
+		 */
+	} while (d_state != desc_committed && d_state != desc_reusable);
+
+	return desc.info.seq;
+}
+
+/**
+ * prb_read_valid() - Non-blocking read of a requested record or (if gone)
+ *                    the next available record.
+ *
+ * @rb:  The ringbuffer to read from.
+ * @seq: The sequence number of the record to read.
+ * @r:   The record data buffer to store the read record to.
+ *
+ * This is the public function available to readers to read a record.
+ *
+ * The reader provides the @info, @text_buf, @dict_buf buffers of @r to be
+ * filled in.
+ *
+ * Context: Any context.
+ * Return: true if a record was read, otherwise false.
+ *
+ * On success, the reader must check r->info.seq to see which record was
+ * actually read. This allows the reader to detect dropped records.
+ *
+ * Failure means @seq refers to a not yet written record.
+ */
+bool prb_read_valid(struct printk_ringbuffer *rb, u64 seq,
+		    struct printk_record *r)
+{
+	u64 tail_seq;
+	int err;
+
+	while ((err = prb_read(rb, seq, r))) {
+		tail_seq = get_desc_tail_seq(rb);
+
+		if (seq < tail_seq) {
+			/*
+			 * Behind the tail. Catch up and try again. This
+			 * can happen for -ENOENT and -EINVAL cases.
+			 */
+			seq = tail_seq;
+
+		} else if (err == -ENOENT) {
+			/* Record exists, but no data available. Skip. */
+			seq++;
+
+		} else {
+			/* Non-existent/non-committed record. Must stop. */
+			return false;
+		}
+	}
+
+	return true;
+}
+EXPORT_SYMBOL(prb_read_valid);
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index b6f06e5edc1b..3c0eaa165a5f 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -17,11 +17,17 @@ struct printk_info {
 };
 
 /*
- * A structure providing the buffers, used by writers.
+ * A structure providing the buffers, used by writers and readers.
  *
  * Writers:
  * The writer sets @text_buf_size and @dict_buf_size before calling
  * prb_reserve(). On success, prb_reserve() sets @info, @text_buf, @dict_buf.
+ *
+ * Readers:
+ * The reader sets all fields before calling prb_read_valid(). Note that
+ * the reader provides the @info, @text_buf, @dict_buf buffers. On success,
+ * the struct pointed to by @info will be filled and the char arrays pointed
+ * to by @text_buf and @dict_buf will be filled with text and dict data.
  */
 struct printk_record {
 	struct printk_info	*info;
@@ -236,4 +242,8 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 		 struct printk_record *r);
 void prb_commit(struct prb_reserved_entry *e);
 
+/* Reader Interface */
+bool prb_read_valid(struct printk_ringbuffer *rb, u64 seq,
+		    struct printk_record *r);
+
 #endif /* _KERNEL_PRINTK_RINGBUFFER_H */
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
