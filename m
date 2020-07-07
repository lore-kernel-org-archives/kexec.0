Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jsp4Q-0001yG-OC
 for kexec@lists.infradead.org; Tue, 07 Jul 2020 14:59:44 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH v4 0/4] printk: replace ringbuffer
Date: Tue,  7 Jul 2020 17:05:28 +0206
Message-Id: <20200707145932.8752-1-john.ogness@linutronix.de>
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

Here is a v4 for the first series to rework the printk
subsystem. The v3 is here [0]. This first series
only replaces the existing ringbuffer implementation. No locking
is removed. The semantics/behavior of printk are kept the same
except for a minor optimization that is reverted (patch 3).

Despite minor changes to the ringbuffer code since v3 (comments,
function names, very minor refactoring), the ringbuffer logic
itself has not changed. And, in particular, the memory barriers
have been exactly preserved from v3. For this reason I deem it
appropriate to keep Paul's reviewed by tag (patch 2).

RFC patches for various userspace tools to dump the kernel log
are available: crash [1], makedumpfile [2], kexec-tools [3].

Finally, I would like to thank some people/organizations that
helped with performing ringbuffer stress tests on big or rare
hardware that I do not have access to:

- Prarit Bhargava of Red Hat (x86_64, ppc64le power8)
- Michael Cree of Debian (alpha)
- Jeff Scheel of OSU Open Source Lab (ppc64le power8 kvm)

These tests were extremely valuable during the memory barrier
work. Thank you!

This series is based on v5.8-rc4.

The list of changes since v3:

printk_ringbuffer
=================

- data_alloc(): remove unneeded check for a NULL data ring [4]

- prb_next_seq(): simplified by assuming u64 never overflows [4]

- added prb_for_each_info() macro to iterate record meta-data [5]

- prb_count_lines() renamed to count_lines() and is now a static
  helper function [5]

- buffers defined by DECLARE_PRINTKRB() now static [6]

- DECLARE_PRINTKRB() renamed to DEFINE_PRINTKRB() because it is
  defining, not declaring

printk.c
========

- added a compiler macro test to ensure CONFIG_LOG_BUF_SHIFT
  is greater than PRB_AVGBITS [7]

- setup_log_buf(): fixed handling of failed allocation of the
  dictionary data ring [7]

- setup_log_buf(): now verify that no messages were dropped
  during the transition to the dynamic buffer [7]

- setup_log_buf(): added size checks, comments, and temporary
  variables to clean up the code [7]

- setup_log_buf(): use ilog2() instead of order_base_2() [8]

- truncate_msg(): no longer truncate dictionary data [9]

- record_print_text(): refactored code and comments [10]

- get_record_text_size() renamed to
  get_record_print_text_size() [11]

- use prb_for_each_info() instead of prb_count_lines() to get
  the number of lines in a message (also avoids unnecessarily
  allocating buffer space and/or copying message text) [5]

- reverted printk optimization to only wake klogd if
  vprintk_emit() actually produced new printing content [12]

[0] https://lkml.kernel.org/r/20200618144919.9806-1-john.ogness@linutronix.de
[1] https://github.com/Linutronix/crash.git (printk branch)
[2] https://github.com/Linutronix/makedumpfile.git (printk branch)
[3] https://github.com/Linutronix/kexec-tools.git (printk branch)
[4] https://lkml.kernel.org/r/20200702083518.GB14288@alley
[5] https://lkml.kernel.org/r/87k0zp8rrn.fsf@jogness.linutronix.de
[6] https://lkml.kernel.org/r/20200619082919.5d604e58@oasis.local.home
[7] https://lkml.kernel.org/r/87sgeh3m5j.fsf@jogness.linutronix.de
[8] https://lkml.kernel.org/r/20200702132758.GD14288@alley
[9] https://lkml.kernel.org/r/87wo3u2b0l.fsf@jogness.linutronix.de
[10] https://lkml.kernel.org/r/87k0ztbea9.fsf@jogness.linutronix.de
[11] https://lkml.kernel.org/r/20200625152523.GJ8444@alley
[12] https://lkml.kernel.org/r/87o8oznh2c.fsf@jogness.linutronix.de

John Ogness (4):
  crash: add VMCOREINFO macro to define offset in a struct declared by
    typedef
  printk: add lockless ringbuffer
  Revert "printk: lock/unlock console only for new logbuf entries"
  printk: use the lockless ringbuffer

 include/linux/crash_core.h        |    3 +
 kernel/printk/Makefile            |    1 +
 kernel/printk/printk.c            |  950 ++++++++--------
 kernel/printk/printk_ringbuffer.c | 1676 +++++++++++++++++++++++++++++
 kernel/printk/printk_ringbuffer.h |  399 +++++++
 5 files changed, 2575 insertions(+), 454 deletions(-)
 create mode 100644 kernel/printk/printk_ringbuffer.c
 create mode 100644 kernel/printk/printk_ringbuffer.h

-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
