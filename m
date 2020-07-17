Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([193.142.43.55])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwa65-0007Zp-I2
 for kexec@lists.infradead.org; Fri, 17 Jul 2020 23:49:02 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH 2/4] printk: store instead of processing cont parts
Date: Sat, 18 Jul 2020 01:54:16 +0206
Message-Id: <20200717234818.8622-3-john.ogness@linutronix.de>
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

Instead of buffering continuous line parts before storing the full
line into the ringbuffer, store each part as its own record.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 114 ++++-------------------------------------
 1 file changed, 11 insertions(+), 103 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fec71229169e..c4274c867771 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -495,9 +495,14 @@ static void truncate_msg(u16 *text_len, u16 *trunc_msg_len)
 		*trunc_msg_len = 0;
 }
 
+static inline u32 printk_caller_id(void)
+{
+	return in_task() ? task_pid_nr(current) :
+		0x80000000 + raw_smp_processor_id();
+}
+
 /* insert record into the buffer, discard old ones, update heads */
-static int log_store(u32 caller_id, int facility, int level,
-		     enum log_flags flags, u64 ts_nsec,
+static int log_store(int facility, int level, enum log_flags flags,
 		     const char *dict, u16 dict_len,
 		     const char *text, u16 text_len)
 {
@@ -525,11 +530,8 @@ static int log_store(u32 caller_id, int facility, int level,
 	r.info->facility = facility;
 	r.info->level = level & 7;
 	r.info->flags = flags & 0x1f;
-	if (ts_nsec > 0)
-		r.info->ts_nsec = ts_nsec;
-	else
-		r.info->ts_nsec = local_clock();
-	r.info->caller_id = caller_id;
+	r.info->ts_nsec = local_clock();
+	r.info->caller_id = printk_caller_id();
 
 	/* insert message */
 	prb_commit(&e);
@@ -1874,100 +1876,6 @@ static inline void printk_delay(void)
 	}
 }
 
-static inline u32 printk_caller_id(void)
-{
-	return in_task() ? task_pid_nr(current) :
-		0x80000000 + raw_smp_processor_id();
-}
-
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
-static size_t log_output(int facility, int level, enum log_flags lflags, const char *dict, size_t dictlen, char *text, size_t text_len)
-{
-	const u32 caller_id = printk_caller_id();
-
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
-			return text_len;
-	}
-
-	/* Store it in the record log */
-	return log_store(caller_id, facility, level, lflags, 0,
-			 dict, dictlen, text, text_len);
-}
-
 /* Must be called under logbuf_lock. */
 int vprintk_store(int facility, int level,
 		  const char *dict, size_t dictlen,
@@ -2015,8 +1923,8 @@ int vprintk_store(int facility, int level,
 	if (dict)
 		lflags |= LOG_NEWLINE;
 
-	return log_output(facility, level, lflags,
-			  dict, dictlen, text, text_len);
+	return log_store(facility, level, lflags, dict, dictlen,
+			 text, text_len);
 }
 
 asmlinkage int vprintk_emit(int facility, int level,
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
