Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtUYB-0006b6-6b
 for kexec@lists.infradead.org; Thu, 09 Jul 2020 11:17:12 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [printk] 18a2dc6982: ltp.kmsg01.fail
In-Reply-To: <20200709111310.GD11164@alley>
References: <20200707145932.8752-5-john.ogness@linutronix.de>
 <20200709071411.GR3874@shao2-debian>
 <20200709083323.GA572@jagdpanzerIV.localdomain>
 <874kqhm1v8.fsf@jogness.linutronix.de> <20200709105906.GC11164@alley>
 <20200709111310.GD11164@alley>
Date: Thu, 09 Jul 2020 13:23:07 +0206
Message-ID: <87zh89kkek.fsf@jogness.linutronix.de>
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
Cc: Andrea Parri <parri.andrea@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Paul McKenney <paulmck@kernel.org>, kernel test robot <rong.a.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, lkp@lists.01.org, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On 2020-07-09, Petr Mladek <pmladek@suse.com> wrote:
> I though more about it. IMHO, it will be better to modify
> prb_first_seq() to do the same cycle as prb_next_seq()
> and return seq number of the first valid entry.

Exactly!

Here is a patch that does just that. I added a prb_first_valid_seq()
function and made prb_first_seq() static. (The ringbuffer still needs
prb_first_seq() for itself.)

John Ogness


diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 0b1337f4188c..fec71229169e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -775,9 +775,9 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 		logbuf_lock_irq();
 	}
 
-	if (user->seq < prb_first_seq(prb)) {
+	if (user->seq < prb_first_valid_seq(prb)) {
 		/* our last seen message is gone, return error and reset */
-		user->seq = prb_first_seq(prb);
+		user->seq = prb_first_valid_seq(prb);
 		ret = -EPIPE;
 		logbuf_unlock_irq();
 		goto out;
@@ -820,7 +820,7 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
 	switch (whence) {
 	case SEEK_SET:
 		/* the first record */
-		user->seq = prb_first_seq(prb);
+		user->seq = prb_first_valid_seq(prb);
 		break;
 	case SEEK_DATA:
 		/*
@@ -854,7 +854,7 @@ static __poll_t devkmsg_poll(struct file *file, poll_table *wait)
 	logbuf_lock_irq();
 	if (prb_read_valid(prb, user->seq, NULL)) {
 		/* return error when data has vanished underneath us */
-		if (user->seq < prb_first_seq(prb))
+		if (user->seq < prb_first_valid_seq(prb))
 			ret = EPOLLIN|EPOLLRDNORM|EPOLLERR|EPOLLPRI;
 		else
 			ret = EPOLLIN|EPOLLRDNORM;
@@ -894,7 +894,7 @@ static int devkmsg_open(struct inode *inode, struct file *file)
 			&user->dict_buf[0], sizeof(user->dict_buf));
 
 	logbuf_lock_irq();
-	user->seq = prb_first_seq(prb);
+	user->seq = prb_first_valid_seq(prb);
 	logbuf_unlock_irq();
 
 	file->private_data = user;
@@ -1631,9 +1631,9 @@ int do_syslog(int type, char __user *buf, int len, int source)
 	/* Number of chars in the log buffer */
 	case SYSLOG_ACTION_SIZE_UNREAD:
 		logbuf_lock_irq();
-		if (syslog_seq < prb_first_seq(prb)) {
+		if (syslog_seq < prb_first_valid_seq(prb)) {
 			/* messages are gone, move to first one */
-			syslog_seq = prb_first_seq(prb);
+			syslog_seq = prb_first_valid_seq(prb);
 			syslog_partial = 0;
 		}
 		if (source == SYSLOG_FROM_PROC) {
@@ -2120,7 +2120,7 @@ EXPORT_SYMBOL(printk);
 #define printk_time		false
 
 #define prb_read_valid(rb, seq, r)	false
-#define prb_first_seq(rb)		0
+#define prb_first_valid_seq(rb)		0
 
 static u64 syslog_seq;
 static u64 console_seq;
@@ -2627,7 +2627,7 @@ void console_flush_on_panic(enum con_flush_mode mode)
 		unsigned long flags;
 
 		logbuf_lock_irqsave(flags);
-		console_seq = prb_first_seq(prb);
+		console_seq = prb_first_valid_seq(prb);
 		logbuf_unlock_irqrestore(flags);
 	}
 	console_unlock();
@@ -3395,9 +3395,9 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 		goto out;
 
 	logbuf_lock_irqsave(flags);
-	if (dumper->cur_seq < prb_first_seq(prb)) {
+	if (dumper->cur_seq < prb_first_valid_seq(prb)) {
 		/* messages are gone, move to first available one */
-		dumper->cur_seq = prb_first_seq(prb);
+		dumper->cur_seq = prb_first_valid_seq(prb);
 	}
 
 	/* last entry */
diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index f4a670f7289d..70ad5a091e96 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -1420,22 +1420,8 @@ static int prb_read(struct printk_ringbuffer *rb, u64 seq,
 	return desc_read_committed_seq(desc_ring, id, seq, &desc);
 }
 
-/**
- * prb_first_seq() - Get the sequence number of the tail descriptor.
- *
- * @rb:  The ringbuffer to get the sequence number from.
- *
- * This is the public function available to readers to see what the
- * first/oldest sequence number is.
- *
- * This provides readers a starting point to begin iterating the ringbuffer.
- * Note that the returned sequence number might not belong to a valid record.
- *
- * Context: Any context.
- * Return: The sequence number of the first/oldest record or, if the
- *         ringbuffer is empty, 0 is returned.
- */
-u64 prb_first_seq(struct printk_ringbuffer *rb)
+/* Get the sequence number of the tail descriptor. */
+static u64 prb_first_seq(struct printk_ringbuffer *rb)
 {
 	struct prb_desc_ring *desc_ring = &rb->desc_ring;
 	enum desc_state d_state;
@@ -1576,6 +1562,31 @@ bool prb_read_valid_info(struct printk_ringbuffer *rb, u64 seq,
 	return _prb_read_valid(rb, &seq, &r, line_count);
 }
 
+/**
+ * prb_first_valid_seq() - Get the sequence number of the oldest available
+ *                         record.
+ *
+ * @rb: The ringbuffer to get the sequence number from.
+ *
+ * This is the public function available to readers to see what the
+ * first/oldest sequence number is.
+ *
+ * This provides readers a starting point to begin iterating the ringbuffer.
+ *
+ * Context: Any context.
+ * Return: The sequence number of the first/oldest record or, if the
+ *         ringbuffer is empty, 0 is returned.
+ */
+u64 prb_first_valid_seq(struct printk_ringbuffer *rb)
+{
+	u64 seq = 0;
+
+	if (!_prb_read_valid(rb, &seq, NULL, NULL))
+		return 0;
+
+	return seq;
+}
+
 /**
  * prb_next_seq() - Get the sequence number after the last available record.
  *
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 711ced305cc7..3e46a7423c13 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -393,7 +393,7 @@ bool prb_read_valid(struct printk_ringbuffer *rb, u64 seq,
 bool prb_read_valid_info(struct printk_ringbuffer *rb, u64 seq,
 			 struct printk_info *info, unsigned int *line_count);
 
-u64 prb_first_seq(struct printk_ringbuffer *rb);
+u64 prb_first_valid_seq(struct printk_ringbuffer *rb);
 u64 prb_next_seq(struct printk_ringbuffer *rb);
 
 #endif /* _KERNEL_PRINTK_RINGBUFFER_H */


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
