Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([193.142.43.55])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kHngE-0005Of-3M
 for kexec@lists.infradead.org; Mon, 14 Sep 2020 12:33:59 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH printk v5 1/6] printk: ringbuffer: relocate get_data()
Date: Mon, 14 Sep 2020 14:39:49 +0206
Message-Id: <20200914123354.832-2-john.ogness@linutronix.de>
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

Move the internal get_data() function as-is above prb_reserve() so
that a later change can make use of the static function.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk_ringbuffer.c | 116 +++++++++++++++---------------
 1 file changed, 58 insertions(+), 58 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 0659b50872b5..aa6e31a27601 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -1038,6 +1038,64 @@ static unsigned int space_used(struct prb_data_ring *data_ring,
 		DATA_SIZE(data_ring) - DATA_INDEX(data_ring, blk_lpos->begin));
 }
 
+/*
+ * Given @blk_lpos, return a pointer to the writer data from the data block
+ * and calculate the size of the data part. A NULL pointer is returned if
+ * @blk_lpos specifies values that could never be legal.
+ *
+ * This function (used by readers) performs strict validation on the lpos
+ * values to possibly detect bugs in the writer code. A WARN_ON_ONCE() is
+ * triggered if an internal error is detected.
+ */
+static const char *get_data(struct prb_data_ring *data_ring,
+			    struct prb_data_blk_lpos *blk_lpos,
+			    unsigned int *data_size)
+{
+	struct prb_data_block *db;
+
+	/* Data-less data block description. */
+	if (LPOS_DATALESS(blk_lpos->begin) && LPOS_DATALESS(blk_lpos->next)) {
+		if (blk_lpos->begin == NO_LPOS && blk_lpos->next == NO_LPOS) {
+			*data_size = 0;
+			return "";
+		}
+		return NULL;
+	}
+
+	/* Regular data block: @begin less than @next and in same wrap. */
+	if (DATA_WRAPS(data_ring, blk_lpos->begin) == DATA_WRAPS(data_ring, blk_lpos->next) &&
+	    blk_lpos->begin < blk_lpos->next) {
+		db = to_block(data_ring, blk_lpos->begin);
+		*data_size = blk_lpos->next - blk_lpos->begin;
+
+	/* Wrapping data block: @begin is one wrap behind @next. */
+	} else if (DATA_WRAPS(data_ring, blk_lpos->begin + DATA_SIZE(data_ring)) ==
+		   DATA_WRAPS(data_ring, blk_lpos->next)) {
+		db = to_block(data_ring, 0);
+		*data_size = DATA_INDEX(data_ring, blk_lpos->next);
+
+	/* Illegal block description. */
+	} else {
+		WARN_ON_ONCE(1);
+		return NULL;
+	}
+
+	/* A valid data block will always be aligned to the ID size. */
+	if (WARN_ON_ONCE(blk_lpos->begin != ALIGN(blk_lpos->begin, sizeof(db->id))) ||
+	    WARN_ON_ONCE(blk_lpos->next != ALIGN(blk_lpos->next, sizeof(db->id)))) {
+		return NULL;
+	}
+
+	/* A valid data block will always have at least an ID. */
+	if (WARN_ON_ONCE(*data_size < sizeof(db->id)))
+		return NULL;
+
+	/* Subtract block ID space from size to reflect data size. */
+	*data_size -= sizeof(db->id);
+
+	return &db->data[0];
+}
+
 /**
  * prb_reserve() - Reserve space in the ringbuffer.
  *
@@ -1192,64 +1250,6 @@ void prb_commit(struct prb_reserved_entry *e)
 	local_irq_restore(e->irqflags);
 }
 
-/*
- * Given @blk_lpos, return a pointer to the writer data from the data block
- * and calculate the size of the data part. A NULL pointer is returned if
- * @blk_lpos specifies values that could never be legal.
- *
- * This function (used by readers) performs strict validation on the lpos
- * values to possibly detect bugs in the writer code. A WARN_ON_ONCE() is
- * triggered if an internal error is detected.
- */
-static const char *get_data(struct prb_data_ring *data_ring,
-			    struct prb_data_blk_lpos *blk_lpos,
-			    unsigned int *data_size)
-{
-	struct prb_data_block *db;
-
-	/* Data-less data block description. */
-	if (LPOS_DATALESS(blk_lpos->begin) && LPOS_DATALESS(blk_lpos->next)) {
-		if (blk_lpos->begin == NO_LPOS && blk_lpos->next == NO_LPOS) {
-			*data_size = 0;
-			return "";
-		}
-		return NULL;
-	}
-
-	/* Regular data block: @begin less than @next and in same wrap. */
-	if (DATA_WRAPS(data_ring, blk_lpos->begin) == DATA_WRAPS(data_ring, blk_lpos->next) &&
-	    blk_lpos->begin < blk_lpos->next) {
-		db = to_block(data_ring, blk_lpos->begin);
-		*data_size = blk_lpos->next - blk_lpos->begin;
-
-	/* Wrapping data block: @begin is one wrap behind @next. */
-	} else if (DATA_WRAPS(data_ring, blk_lpos->begin + DATA_SIZE(data_ring)) ==
-		   DATA_WRAPS(data_ring, blk_lpos->next)) {
-		db = to_block(data_ring, 0);
-		*data_size = DATA_INDEX(data_ring, blk_lpos->next);
-
-	/* Illegal block description. */
-	} else {
-		WARN_ON_ONCE(1);
-		return NULL;
-	}
-
-	/* A valid data block will always be aligned to the ID size. */
-	if (WARN_ON_ONCE(blk_lpos->begin != ALIGN(blk_lpos->begin, sizeof(db->id))) ||
-	    WARN_ON_ONCE(blk_lpos->next != ALIGN(blk_lpos->next, sizeof(db->id)))) {
-		return NULL;
-	}
-
-	/* A valid data block will always have at least an ID. */
-	if (WARN_ON_ONCE(*data_size < sizeof(db->id)))
-		return NULL;
-
-	/* Subtract block ID space from size to reflect data size. */
-	*data_size -= sizeof(db->id);
-
-	return &db->data[0];
-}
-
 /*
  * Count the number of lines in provided text. All text has at least 1 line
  * (even if @text_size is 0). Each '\n' processed is counted as an additional
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
