Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([193.142.43.55])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtWWo-0004Me-PU
 for kexec@lists.infradead.org; Thu, 09 Jul 2020 13:23:57 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH v5 0/4] printk: replace ringbuffer
Date: Thu,  9 Jul 2020 15:29:40 +0206
Message-Id: <20200709132344.760-1-john.ogness@linutronix.de>
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

Here is a v5 for the first series to rework the printk
subsystem. The v4 is here [0]. This first series
only replaces the existing ringbuffer implementation. No locking
is removed. The semantics/behavior of printk are kept the same
except for a minor optimization that is reverted (patch 3).

RFC patches for various userspace tools to dump the kernel log
are available: crash [1], makedumpfile [2], kexec-tools [3].

This series is based on v5.8-rc4.

The list of changes since v4:

printk_ringbuffer
=================

- added new prb_first_valid_seq() for readers to retrieve the
  oldest valid sequence number

- prb_first_seq(): now static

printk.c
========

- devkmsg_read(): fixed returning EPIPE on buffer wrap [4]

- setup_log_buf(): fixed printk conversion specifier [5]

- replace all prb_first_seq() usage with the new
  prb_first_valid_seq() (because that is what the readers are
  actually interested in)

[0] https://lkml.kernel.org/r/20200707145932.8752-1-john.ogness@linutronix.de
[1] https://github.com/Linutronix/crash.git (printk branch)
[2] https://github.com/Linutronix/makedumpfile.git (printk branch)
[3] https://github.com/Linutronix/kexec-tools.git (printk branch)
[4] https://lkml.kernel.org/r/87zh89kkek.fsf@jogness.linutronix.de
[5] https://lkml.kernel.org/r/87r1tmcfhf.fsf@jogness.linutronix.de

John Ogness (4):
  crash: add VMCOREINFO macro to define offset in a struct declared by
    typedef
  printk: add lockless ringbuffer
  Revert "printk: lock/unlock console only for new logbuf entries"
  printk: use the lockless ringbuffer

 include/linux/crash_core.h        |    3 +
 kernel/printk/Makefile            |    1 +
 kernel/printk/printk.c            |  950 ++++++++--------
 kernel/printk/printk_ringbuffer.c | 1687 +++++++++++++++++++++++++++++
 kernel/printk/printk_ringbuffer.h |  399 +++++++
 5 files changed, 2586 insertions(+), 454 deletions(-)
 create mode 100644 kernel/printk/printk_ringbuffer.c
 create mode 100644 kernel/printk/printk_ringbuffer.h

-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
