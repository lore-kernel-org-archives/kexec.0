Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kCYLf-0000vQ-SM
 for kexec@lists.infradead.org; Mon, 31 Aug 2020 01:11:06 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH next v3 4/8] printk: ringbuffer: add BLK_DATALESS() macro
Date: Mon, 31 Aug 2020 03:16:54 +0206
Message-Id: <20200831011058.6286-5-john.ogness@linutronix.de>
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

Rather than continually needing to explicitly check @begin and @next
to identify a dataless block, introduce and use a BLK_DATALESS()
macro.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk_ringbuffer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 86af38c2cf77..d66718e74aae 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -266,6 +266,8 @@
 
 /* Determine if a logical position refers to a data-less block. */
 #define LPOS_DATALESS(lpos)		((lpos) & 1UL)
+#define BLK_DATALESS(blk)		(LPOS_DATALESS((blk)->begin) && \
+					 LPOS_DATALESS((blk)->next))
 
 /* Get the logical position at index 0 of the current wrap. */
 #define DATA_THIS_WRAP_START_LPOS(data_ring, lpos) \
@@ -1021,7 +1023,7 @@ static unsigned int space_used(struct prb_data_ring *data_ring,
 			       struct prb_data_blk_lpos *blk_lpos)
 {
 	/* Data-less blocks take no space. */
-	if (LPOS_DATALESS(blk_lpos->begin))
+	if (BLK_DATALESS(blk_lpos))
 		return 0;
 
 	if (DATA_WRAPS(data_ring, blk_lpos->begin) == DATA_WRAPS(data_ring, blk_lpos->next)) {
@@ -1054,7 +1056,7 @@ static const char *get_data(struct prb_data_ring *data_ring,
 	struct prb_data_block *db;
 
 	/* Data-less data block description. */
-	if (LPOS_DATALESS(blk_lpos->begin) && LPOS_DATALESS(blk_lpos->next)) {
+	if (BLK_DATALESS(blk_lpos)) {
 		if (blk_lpos->begin == NO_LPOS && blk_lpos->next == NO_LPOS) {
 			*data_size = 0;
 			return "";
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
