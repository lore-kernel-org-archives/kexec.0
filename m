Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kCYLh-0000ya-Je
 for kexec@lists.infradead.org; Mon, 31 Aug 2020 01:11:10 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH next v3 7/8] printk: reimplement log_cont using record
 extension
Date: Mon, 31 Aug 2020 03:16:57 +0206
Message-Id: <20200831011058.6286-8-john.ogness@linutronix.de>
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

Use the record extending feature of the ringbuffer to implement
continuous messages. This preserves the existing continuous message
behavior.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 98 +++++++++---------------------------------
 1 file changed, 20 insertions(+), 78 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 7e7d596c8878..d0b2bea1fd81 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -535,7 +535,10 @@ static int log_store(u32 caller_id, int facility, int level,
 	r.info->caller_id = caller_id;
 
 	/* insert message */
-	prb_commit(&e);
+	if ((flags & LOG_CONT) || !(flags & LOG_NEWLINE))
+		prb_commit(&e);
+	else
+		prb_final_commit(&e);
 
 	return (text_len + trunc_msg_len);
 }
@@ -1093,7 +1096,7 @@ static unsigned int __init add_to_rb(struct printk_ringbuffer *rb,
 	dest_r.info->ts_nsec = r->info->ts_nsec;
 	dest_r.info->caller_id = r->info->caller_id;
 
-	prb_commit(&e);
+	prb_final_commit(&e);
 
 	return prb_record_text_space(&e);
 }
@@ -1893,87 +1896,26 @@ static inline u32 printk_caller_id(void)
 		0x80000000 + raw_smp_processor_id();
 }
 
-/*
- * Continuation lines are buffered, and not committed to the record buffer
- * until the line is complete, or a race forces it. The line fragments
- * though, are printed immediately to the consoles to ensure everything has
- * reached the console in case of a kernel crash.
- */
-static struct cont {
-	char buf[LOG_LINE_MAX];
-	size_t len;			/* length == 0 means unused buffer */
-	u32 caller_id;			/* printk_caller_id() of first print */
-	u64 ts_nsec;			/* time of first print */
-	u8 level;			/* log level of first message */
-	u8 facility;			/* log facility of first message */
-	enum log_flags flags;		/* prefix, newline flags */
-} cont;
-
-static void cont_flush(void)
-{
-	if (cont.len == 0)
-		return;
-
-	log_store(cont.caller_id, cont.facility, cont.level, cont.flags,
-		  cont.ts_nsec, NULL, 0, cont.buf, cont.len);
-	cont.len = 0;
-}
-
-static bool cont_add(u32 caller_id, int facility, int level,
-		     enum log_flags flags, const char *text, size_t len)
-{
-	/* If the line gets too long, split it up in separate records. */
-	if (cont.len + len > sizeof(cont.buf)) {
-		cont_flush();
-		return false;
-	}
-
-	if (!cont.len) {
-		cont.facility = facility;
-		cont.level = level;
-		cont.caller_id = caller_id;
-		cont.ts_nsec = local_clock();
-		cont.flags = flags;
-	}
-
-	memcpy(cont.buf + cont.len, text, len);
-	cont.len += len;
-
-	// The original flags come from the first line,
-	// but later continuations can add a newline.
-	if (flags & LOG_NEWLINE) {
-		cont.flags |= LOG_NEWLINE;
-		cont_flush();
-	}
-
-	return true;
-}
-
 static size_t log_output(int facility, int level, enum log_flags lflags, const char *dict, size_t dictlen, char *text, size_t text_len)
 {
 	const u32 caller_id = printk_caller_id();
 
-	/*
-	 * If an earlier line was buffered, and we're a continuation
-	 * write from the same context, try to add it to the buffer.
-	 */
-	if (cont.len) {
-		if (cont.caller_id == caller_id && (lflags & LOG_CONT)) {
-			if (cont_add(caller_id, facility, level, lflags, text, text_len))
-				return text_len;
-		}
-		/* Otherwise, make sure it's flushed */
-		cont_flush();
-	}
-
-	/* Skip empty continuation lines that couldn't be added - they just flush */
-	if (!text_len && (lflags & LOG_CONT))
-		return 0;
-
-	/* If it doesn't end in a newline, try to buffer the current line */
-	if (!(lflags & LOG_NEWLINE)) {
-		if (cont_add(caller_id, facility, level, lflags, text, text_len))
+	if (lflags & LOG_CONT) {
+		struct prb_reserved_entry e;
+		struct printk_record r;
+
+		prb_rec_init_wr(&r, text_len, 0);
+		if (prb_reserve_in_last(&e, prb, &r, caller_id)) {
+			memcpy(&r.text_buf[r.info->text_len], text, text_len);
+			r.info->text_len += text_len;
+			if (lflags & LOG_NEWLINE) {
+				r.info->flags |= LOG_NEWLINE;
+				prb_final_commit(&e);
+			} else {
+				prb_commit(&e);
+			}
 			return text_len;
+		}
 	}
 
 	/* Store it in the record log */
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
