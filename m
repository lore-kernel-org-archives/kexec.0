Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([193.142.43.55])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwa65-0007Zi-LB
 for kexec@lists.infradead.org; Fri, 17 Jul 2020 23:49:03 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH 1/4] printk: ringbuffer: support dataless records
Date: Sat, 18 Jul 2020 01:54:15 +0206
Message-Id: <20200717234818.8622-2-john.ogness@linutronix.de>
In-Reply-To: <20200717234818.8622-1-john.ogness@linutronix.de>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
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
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

In order to support storage of continuous lines, dataless records must
be allowed. For example, these are generated with the legal calls:

    pr_info("");
    pr_cont("\n");

Currently dataless records are denoted by INVALID_LPOS in order to
recognize failed prb_reserve() calls. Change the code to use two
different identifiers (FAILED_LPOS and NO_LPOS) to distinguish
between failed prb_reserve() records and successful dataless records.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk_ringbuffer.c | 58 ++++++++++++++-----------------
 kernel/printk/printk_ringbuffer.h | 15 ++++----
 2 files changed, 35 insertions(+), 38 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 7355ca99e852..54b0a6324dbf 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -264,6 +264,9 @@
 /* Determine how many times the data array has wrapped. */
 #define DATA_WRAPS(data_ring, lpos)	((lpos) >> (data_ring)->size_bits)
 
+/* Determine if a logical position refers to a data-less block. */
+#define LPOS_DATALESS(lpos)		((lpos) & 1UL)
+
 /* Get the logical position at index 0 of the current wrap. */
 #define DATA_THIS_WRAP_START_LPOS(data_ring, lpos) \
 ((lpos) & ~DATA_SIZE_MASK(data_ring))
@@ -320,21 +323,13 @@ static unsigned int to_blk_size(unsigned int size)
  * block does not exceed the maximum possible size that could fit within the
  * ringbuffer. This function provides that basic size check so that the
  * assumption is safe.
- *
- * Writers are also not allowed to write 0-sized (data-less) records. Such
- * records are used only internally by the ringbuffer.
  */
 static bool data_check_size(struct prb_data_ring *data_ring, unsigned int size)
 {
 	struct prb_data_block *db = NULL;
 
-	/*
-	 * Writers are not allowed to write data-less records. Such records
-	 * are used only internally by the ringbuffer to denote records where
-	 * their data failed to allocate or have been lost.
-	 */
 	if (size == 0)
-		return false;
+		return true;
 
 	/*
 	 * Ensure the alignment padded size could possibly fit in the data
@@ -568,8 +563,8 @@ static bool data_push_tail(struct printk_ringbuffer *rb,
 	unsigned long tail_lpos;
 	unsigned long next_lpos;
 
-	/* If @lpos is not valid, there is nothing to do. */
-	if (lpos == INVALID_LPOS)
+	/* If @lpos is from a data-less block, there is nothing to do. */
+	if (LPOS_DATALESS(lpos))
 		return true;
 
 	/*
@@ -962,8 +957,8 @@ static char *data_alloc(struct printk_ringbuffer *rb,
 
 	if (size == 0) {
 		/* Specify a data-less block. */
-		blk_lpos->begin = INVALID_LPOS;
-		blk_lpos->next = INVALID_LPOS;
+		blk_lpos->begin = NO_LPOS;
+		blk_lpos->next = NO_LPOS;
 		return NULL;
 	}
 
@@ -976,8 +971,8 @@ static char *data_alloc(struct printk_ringbuffer *rb,
 
 		if (!data_push_tail(rb, data_ring, next_lpos - DATA_SIZE(data_ring))) {
 			/* Failed to allocate, specify a data-less block. */
-			blk_lpos->begin = INVALID_LPOS;
-			blk_lpos->next = INVALID_LPOS;
+			blk_lpos->begin = FAILED_LPOS;
+			blk_lpos->next = FAILED_LPOS;
 			return NULL;
 		}
 
@@ -1025,6 +1020,10 @@ static char *data_alloc(struct printk_ringbuffer *rb,
 static unsigned int space_used(struct prb_data_ring *data_ring,
 			       struct prb_data_blk_lpos *blk_lpos)
 {
+	/* Data-less blocks take no space. */
+	if (LPOS_DATALESS(blk_lpos->begin))
+		return 0;
+
 	if (DATA_WRAPS(data_ring, blk_lpos->begin) == DATA_WRAPS(data_ring, blk_lpos->next)) {
 		/* Data block does not wrap. */
 		return (DATA_INDEX(data_ring, blk_lpos->next) -
@@ -1080,11 +1079,8 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 	if (!data_check_size(&rb->text_data_ring, r->text_buf_size))
 		goto fail;
 
-	/* Records are allowed to not have dictionaries. */
-	if (r->dict_buf_size) {
-		if (!data_check_size(&rb->dict_data_ring, r->dict_buf_size))
-			goto fail;
-	}
+	if (!data_check_size(&rb->dict_data_ring, r->dict_buf_size))
+		goto fail;
 
 	/*
 	 * Descriptors in the reserved state act as blockers to all further
@@ -1212,10 +1208,8 @@ static char *get_data(struct prb_data_ring *data_ring,
 	struct prb_data_block *db;
 
 	/* Data-less data block description. */
-	if (blk_lpos->begin == INVALID_LPOS &&
-	    blk_lpos->next == INVALID_LPOS) {
+	if (LPOS_DATALESS(blk_lpos->begin) && LPOS_DATALESS(blk_lpos->next))
 		return NULL;
-	}
 
 	/* Regular data block: @begin less than @next and in same wrap. */
 	if (DATA_WRAPS(data_ring, blk_lpos->begin) == DATA_WRAPS(data_ring, blk_lpos->next) &&
@@ -1355,11 +1349,11 @@ static int desc_read_committed_seq(struct prb_desc_ring *desc_ring,
 
 	/*
 	 * A descriptor in the reusable state may no longer have its data
-	 * available; report it as a data-less record. Or the record may
-	 * actually be a data-less record.
+	 * available; report it as existing but with lost data. Or the record
+	 * may actually be a record with lost data.
 	 */
 	if (d_state == desc_reusable ||
-	    (blk_lpos->begin == INVALID_LPOS && blk_lpos->next == INVALID_LPOS)) {
+	    (blk_lpos->begin == FAILED_LPOS && blk_lpos->next == FAILED_LPOS)) {
 		return -ENOENT;
 	}
 
@@ -1402,7 +1396,9 @@ static int prb_read(struct printk_ringbuffer *rb, u64 seq,
 	/* Copy text data. If it fails, this is a data-less record. */
 	if (!copy_data(&rb->text_data_ring, &desc.text_blk_lpos, desc.info.text_len,
 		       r->text_buf, r->text_buf_size, line_count)) {
-		return -ENOENT;
+		/* Report an error if there should have been data. */
+		if (desc.info.text_len != 0)
+			return -ENOENT;
 	}
 
 	/*
@@ -1659,10 +1655,10 @@ void prb_init(struct printk_ringbuffer *rb,
 
 	descs[_DESCS_COUNT(descbits) - 1].info.seq = 0;
 	atomic_long_set(&(descs[_DESCS_COUNT(descbits) - 1].state_var), DESC0_SV(descbits));
-	descs[_DESCS_COUNT(descbits) - 1].text_blk_lpos.begin = INVALID_LPOS;
-	descs[_DESCS_COUNT(descbits) - 1].text_blk_lpos.next = INVALID_LPOS;
-	descs[_DESCS_COUNT(descbits) - 1].dict_blk_lpos.begin = INVALID_LPOS;
-	descs[_DESCS_COUNT(descbits) - 1].dict_blk_lpos.next = INVALID_LPOS;
+	descs[_DESCS_COUNT(descbits) - 1].text_blk_lpos.begin = FAILED_LPOS;
+	descs[_DESCS_COUNT(descbits) - 1].text_blk_lpos.next = FAILED_LPOS;
+	descs[_DESCS_COUNT(descbits) - 1].dict_blk_lpos.begin = FAILED_LPOS;
+	descs[_DESCS_COUNT(descbits) - 1].dict_blk_lpos.next = FAILED_LPOS;
 }
 
 /**
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 3e46a7423c13..e6302da041f9 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -120,12 +120,13 @@ struct prb_reserved_entry {
 #define DESC_FLAGS_MASK			(DESC_COMMITTED_MASK | DESC_REUSE_MASK)
 #define DESC_ID_MASK			(~DESC_FLAGS_MASK)
 #define DESC_ID(sv)			((sv) & DESC_ID_MASK)
-#define INVALID_LPOS			1
+#define FAILED_LPOS			0x1
+#define NO_LPOS				0x3
 
-#define INVALID_BLK_LPOS	\
+#define FAILED_BLK_LPOS	\
 {				\
-	.begin	= INVALID_LPOS,	\
-	.next	= INVALID_LPOS,	\
+	.begin	= FAILED_LPOS,	\
+	.next	= FAILED_LPOS,	\
 }
 
 /*
@@ -147,7 +148,7 @@ struct prb_reserved_entry {
  *
  * To satisfy Req1, the tail initially points to a descriptor that is
  * minimally initialized (having no data block, i.e. data-less with the
- * data block's lpos @begin and @next values set to INVALID_LPOS).
+ * data block's lpos @begin and @next values set to FAILED_LPOS).
  *
  * To satisfy Req2, the initial tail descriptor is initialized to the
  * reusable state. Readers recognize reusable descriptors as existing
@@ -242,8 +243,8 @@ static struct prb_desc _##name##_descs[_DESCS_COUNT(descbits)] = {				\
 		/* reusable */									\
 		.state_var	= ATOMIC_INIT(DESC0_SV(descbits)),				\
 		/* no associated data block */							\
-		.text_blk_lpos	= INVALID_BLK_LPOS,						\
-		.dict_blk_lpos	= INVALID_BLK_LPOS,						\
+		.text_blk_lpos	= FAILED_BLK_LPOS,						\
+		.dict_blk_lpos	= FAILED_BLK_LPOS,						\
 	},											\
 };												\
 static struct printk_ringbuffer name = {							\
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
