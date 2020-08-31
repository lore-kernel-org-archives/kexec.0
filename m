Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([193.142.43.55])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kCjL9-0006UR-O5
 for kexec@lists.infradead.org; Mon, 31 Aug 2020 12:55:17 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH next v3 6/8] printk: ringbuffer: add
 finalization/extension support
In-Reply-To: <20200831011058.6286-7-john.ogness@linutronix.de>
References: <20200831011058.6286-1-john.ogness@linutronix.de>
 <20200831011058.6286-7-john.ogness@linutronix.de>
Date: Mon, 31 Aug 2020 15:00:58 +0206
Message-ID: <878sdvq8kd.fsf@jogness.linutronix.de>
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

This critical piece was missing from patch 6...


From 0b745d507f0c38e6d1612ed9468aa52845ca025b Mon Sep 17 00:00:00 2001
From: John Ogness <john.ogness@linutronix.de>
Date: Mon, 31 Aug 2020 14:45:40 +0206
Subject: [PATCH] printk: ringbuffer: allow reading consistent descriptors

desc_read() will fail to read if a descriptor is in the desc_reserved
queried state because such data would be inconsistent. However, since
("printk: ringbuffer: add finalization/extension support") the
desc_reserved state can have the DESC_COMMIT_MASK flag set, in which
case it _is_ consistent. And indeed, desc_reopen_last() is expecting
a read in this case.

Allow desc_read() to read desc_reserved descriptors if the
DESC_COMMIT_MASK flag is set.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reported-by: Andy Lavr <andy.lavr@gmail.com>
Fixes: ("printk: ringbuffer: add finalization/extension support")
---
 kernel/printk/printk_ringbuffer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 0731d5e2dddd..6ba7d3fc96f1 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -446,8 +446,10 @@ static enum desc_state desc_read(struct prb_desc_ring *desc_ring,
 	/* Check the descriptor state. */
 	state_val = atomic_long_read(state_var); /* LMM(desc_read:A) */
 	d_state = get_desc_state(id, state_val);
-	if (d_state != desc_committed && d_state != desc_reusable)
+	if (d_state == desc_miss ||
+	    (d_state == desc_reserved && !(state_val & DESC_COMMIT_MASK))) {
 		return d_state;
+	}
 
 	/*
 	 * Guarantee the state is loaded before copying the descriptor
-- 
2.20.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
