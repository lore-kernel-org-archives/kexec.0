Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlvrM-0000GX-5y
 for kexec@lists.infradead.org; Thu, 18 Jun 2020 14:49:46 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH v3 0/3] printk: replace ringbuffer
Date: Thu, 18 Jun 2020 16:55:16 +0206
Message-Id: <20200618144919.9806-1-john.ogness@linutronix.de>
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

Here is a v3 for the first series to rework the printk
subsystem. The v2 and history are here [0]. This first series
only replaces the existing ringbuffer implementation. No locking
is removed. No semantics/behavior of printk are changed.

Reviews on the ringbuffer are still ongoing, but I was asked to
post this new version since several changes from v2 have been
already agreed upon.

The series is based on v5.8-rc1.

The list of changes since v2:

printk.c
========

- console_unlock(): fix extended console printing [1]

printk_ringbuffer
=================

- data_push_tail(): fixed handling when another CPU already
  pushed the tail [2]

- desc_push_tail(): added a full memory barrier before the
  descriptor tail push [3]

- data_make_reusable()/data_alloc(): changed block ID
  reading/writing from READ_ONCE()/WRITE_ONCE() to regular
  assignments [4]

- data_make_reusable(): removed unnecessary data tail
  re-check [5]

- general: folded all smp_mb() and smp_wmb() calls into their
  neighboring cmpxchg_relaxed(), changing them to full cmpxchg()
  calls [6]

- desc_read(): changed descriptor content reading from
  READ_ONCE() to memcpy() since it served no purpose for the
  legal data race

- general: cleaned up memory barrier comments; in particular
  made sure that the reader and writer sides of the memory
  barrier pairs match in their descriptions

- added a new section in the memory barrier documentation (near
  the top of printk_ringbuffer.c) that lists all 10 memory
  barrier pairs and briefly describes what they are ordering

- _prb_read_valid(): changed the helper function to static

- general: changed block size argument type from "unsigned long"
  to "unsigned int" since a record's *_buf_size fields are of
  type "unsigned int"

- general: allow some lines to go beyond 80 characters

John Ogness

[0] https://lkml.kernel.org/r/20200501094010.17694-1-john.ogness@linutronix.de
[1] https://lkml.kernel.org/r/87ftcd86d2.fsf@vostro.fn.ogness.net
[2] https://lkml.kernel.org/r/87v9ktcs3q.fsf@vostro.fn.ogness.net
[3] https://lkml.kernel.org/r/87bllpyzgr.fsf@vostro.fn.ogness.net
[4] https://lkml.kernel.org/r/87tuzkuxtw.fsf@vostro.fn.ogness.net
[5] https://lkml.kernel.org/r/87pna5mjtp.fsf@vostro.fn.ogness.net

John Ogness (3):
  crash: add VMCOREINFO macro to define offset in a struct declared by
    typedef
  printk: add lockless ringbuffer
  printk: use the lockless ringbuffer

 include/linux/crash_core.h        |    3 +
 include/linux/kmsg_dump.h         |    2 -
 kernel/printk/Makefile            |    1 +
 kernel/printk/printk.c            |  944 ++++++++--------
 kernel/printk/printk_ringbuffer.c | 1674 +++++++++++++++++++++++++++++
 kernel/printk/printk_ringbuffer.h |  352 ++++++
 6 files changed, 2527 insertions(+), 449 deletions(-)
 create mode 100644 kernel/printk/printk_ringbuffer.c
 create mode 100644 kernel/printk/printk_ringbuffer.h

-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
