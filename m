Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([193.142.43.55])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kA9pG-0001cB-NZ
 for kexec@lists.infradead.org; Mon, 24 Aug 2020 10:35:47 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH v2 0/7][next] printk: reimplement LOG_CONT handling
Date: Mon, 24 Aug 2020 12:41:31 +0206
Message-Id: <20200824103538.31446-1-john.ogness@linutronix.de>
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

Hello,

Here is v2 for the second series to rework the printk subsystem.
(The v1 is here [0].) This series implements a new ringbuffer
feature that allows the last record to be extended. Petr Mladek
provided the initial proof of concept [1] for this.

Using the record extension feature, LOG_CONT is re-implemented
in a way that exactly preserves its behavior, but avoids the
need for an extra buffer. In particular, it avoids the need for
any synchronization that such a buffer requires.

This series deviates from the agreements [2] made at the meeting
during LPC2019 in Lisbon. The test results of the v1 series
showed that the effects on existing userspace tools using
/dev/kmsg (journalctl, dmesg) were not acceptable [3]. That is
why a new decision [4] was made to preserve the current LOG_CONT
behavior.

Patch 5 introduces two new memory barriers. However, both are
alternate path memory barriers. They exactly match the purpose
and context of the two existing memory barriers that they
provide an alternate path for. For this reason, I do not
believe that a new memory barrier review is necessary.
Nevertheless, I have included the memory barrier experts CC.

Patch 6 assumes that the gdb script series [5] for the new
printk ringbuffer has been applied.

John Ogness

[0] https://lkml.kernel.org/r/20200717234818.8622-1-john.ogness@linutronix.de
[1] https://lkml.kernel.org/r/20200812163908.GH12903@alley
[2] https://lkml.kernel.org/r/87k1acz5rx.fsf@linutronix.de
[3] https://lkml.kernel.org/r/20200811160551.GC12903@alley
[4] https://lkml.kernel.org/r/CAHk-=wj_b6Bh=d-Wwh0xYqoQBhHkYeExhszkpxdRA6GjTvkRiQ@mail.gmail.com
[5] https://lkml.kernel.org/r/20200814212525.6118-1-john.ogness@linutronix.de

John Ogness (7):
  printk: ringbuffer: rename DESC_COMMITTED_MASK flag
  printk: ringbuffer: change representation of reusable
  printk: ringbuffer: relocate get_data()
  printk: ringbuffer: add BLK_DATALESS() macro
  printk: ringbuffer: add finalization/extension support
  printk: reimplement log_cont using record extension
  scripts/gdb: support printk finalized records

 Documentation/admin-guide/kdump/gdbmacros.txt |  10 +-
 kernel/printk/printk.c                        |  98 +---
 kernel/printk/printk_ringbuffer.c             | 496 +++++++++++++++---
 kernel/printk/printk_ringbuffer.h             |  12 +-
 scripts/gdb/linux/dmesg.py                    |  10 +-
 5 files changed, 453 insertions(+), 173 deletions(-)

-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
