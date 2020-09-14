Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kHngD-0005Oa-Ow
 for kexec@lists.infradead.org; Mon, 14 Sep 2020 12:33:58 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH printk v5 0/6] printk: reimplement LOG_CONT handling
Date: Mon, 14 Sep 2020 14:39:48 +0206
Message-Id: <20200914123354.832-1-john.ogness@linutronix.de>
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

Here is v5 for the second series to rework the printk subsystem.
(The v4 is here [0].) This series implements a new ringbuffer
feature that allows the last record to be extended. Petr Mladek
provided the initial proof of concept [1] for this.

Using the record extension feature, LOG_CONT is re-implemented
in a way that exactly preserves its behavior, but avoids the
need for an extra buffer. In particular, it avoids the need for
any synchronization that such a buffer requires.

This series deviates from the agreements [2] made at the meeting
during LPC2019 in Lisbon. The test results of the v1 series,
which implemented LOG_CONT as agreed upon, showed that the
effects on existing userspace tools using /dev/kmsg (journalctl,
dmesg) were not acceptable [3].

Patch 5 introduces *four* new memory barrier pairs. Two of them
are insignificant additions (data_realloc:A/desc_read:D and
data_realloc:A/data_push_tail:B) because they are alternate path
memory barriers that exactly match the purpose and context of
the two existing memory barrier pairs they provide an alternate
path for. The other two new memory barrier pairs are significant
additions:

desc_reopen_last:A / _prb_commit:B - When reopening a descriptor,
    ensure the state transitions back to desc_reserved before
    fully trusting the descriptor data.

_prb_commit:B / desc_reserve:D - When committing a descriptor,
    ensure the state transitions to desc_committed before checking
    the head ID to see if the descriptor needs to be finalized.

The test module used to test the ringbuffer is available
here [4].

The series is based on the printk-rework branch of the printk git
tree:

e60768311af8 ("scripts/gdb: update for lockless printk ringbuffer")

The list of changes since v4:

printk_ringbuffer
=================

- desc_read(): revert setting @state_var when inconsistent (a
  separate series [5] is addressing this bug)

- desc_reserve(): use DESC_SV() when setting reserved

- data_realloc(): also do nothing if the size is the same

- prb_reserve_in_last(): adjust dataless checks/warnings to match
  the non-dataless case

- prb_reserve_in_last(): fix length modifier in warnings

- change comments about "state flags" to just talk about "states"

John Ogness

[0] https://lkml.kernel.org/r/20200908202859.2736-1-john.ogness@linutronix.de
[1] https://lkml.kernel.org/r/20200812163908.GH12903@alley
[2] https://lkml.kernel.org/r/87k1acz5rx.fsf@linutronix.de
[3] https://lkml.kernel.org/r/20200811160551.GC12903@alley
[4] https://github.com/Linutronix/prb-test.git
[5] https://lkml.kernel.org/r/20200914094803.27365-1-john.ogness@linutronix.de

John Ogness (6):
  printk: ringbuffer: relocate get_data()
  printk: ringbuffer: add BLK_DATALESS() macro
  printk: ringbuffer: clear initial reserved fields
  printk: ringbuffer: change representation of states
  printk: ringbuffer: add finalization/extension support
  printk: reimplement log_cont using record extension

 Documentation/admin-guide/kdump/gdbmacros.txt |  13 +-
 kernel/printk/printk.c                        | 110 +--
 kernel/printk/printk_ringbuffer.c             | 683 ++++++++++++++----
 kernel/printk/printk_ringbuffer.h             |  35 +-
 scripts/gdb/linux/dmesg.py                    |  12 +-
 5 files changed, 615 insertions(+), 238 deletions(-)

-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
