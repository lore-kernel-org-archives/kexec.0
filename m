Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([193.142.43.55])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kCYLe-0000v0-PD
 for kexec@lists.infradead.org; Mon, 31 Aug 2020 01:11:04 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH next v3 0/8] printk: reimplement LOG_CONT handling
Date: Mon, 31 Aug 2020 03:16:50 +0206
Message-Id: <20200831011058.6286-1-john.ogness@linutronix.de>
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

Here is v3 for the second series to rework the printk subsystem.
(The v2 is here [0].) This series implements a new ringbuffer
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

The main difference to v2 is the implementation of the new
descriptor finalization. For v3 the implementation closely
follows the example [4] from Petr Mladek.

Patch 6 introduces *four* new memory barrier pairs. Two of them
are insignificant additions (data_realloc:A/desc_read:D and
data_realloc:A/data_push_tail:B) because they are alternate path
memory barriers that exactly match the purpose and context of
the two existing memory barrier pairs they provide an alternate
path for. The other two new memory barrier pairs are significant
additions:

desc_reopen_last:A/_prb_commit:B - When reopening a descriptor,
    ensure the commit flag is removed before fully trusing the
    descriptor data.

_prb_commit:B / desc_reserve:D - When committing a descriptor,
    ensure the commit flag is set before checking the head ID
    to see if the finalize flag should be set.

Patch 8 assumes the gdb script series [5] for the new printk
ringbuffer has been applied.

The test module used to test the ringbuffer is available
here [6].

The series is based on next-20200828.

The list of changes since v2:

printk_ringbuffer
=================

- prb_commit(): finalize self if no longer the head

- prb_reserve(): clear @info fields on success

- prb_reserve(): do not finalize the -1 placeholder descriptor

- desc_make_final(): renamed from desc_finalize()

- desc_make_final(): remove loop, change to single shot attempt

- prb_reserve_in_last(): renamed from prb_reserve_last()

- prb_reserve_in_last(): add new fail goto target

- prb_reserve_in_last(): fix logic for calculating
  @text_buf_size and add size check

- desc_reopen_last(): add extra caller ID check before reopening

- desc_reopen_last(): change cmpcxhg() to full memory barrier

- get_desc_state(): remove unneeded @is_final argument

- documentation: update finalization, sample code, and memory
  barrier list

printk.c
========

- set @text_len and @dict_len as required by prb_reserve() change

John Ogness

[0] https://lkml.kernel.org/r/20200824103538.31446-1-john.ogness@linutronix.de
[1] https://lkml.kernel.org/r/20200812163908.GH12903@alley
[2] https://lkml.kernel.org/r/87k1acz5rx.fsf@linutronix.de
[3] https://lkml.kernel.org/r/20200811160551.GC12903@alley
[4] https://lkml.kernel.org/r/20200827151710.GB4928@alley
[5] https://lkml.kernel.org/r/CAHk-=wj_b6Bh=d-Wwh0xYqoQBhHkYeExhszkpxdRA6GjTvkRiQ@mail.gmail.com
[6] https://lkml.kernel.org/r/20200814212525.6118-1-john.ogness@linutronix.de
[7] https://github.com/Linutronix/prb-test.git

John Ogness (8):
  printk: ringbuffer: rename DESC_COMMITTED_MASK flag
  printk: ringbuffer: change representation of reusable
  printk: ringbuffer: relocate get_data()
  printk: ringbuffer: add BLK_DATALESS() macro
  printk: ringbuffer: clear initial reserved fields
  printk: ringbuffer: add finalization/extension support
  printk: reimplement log_cont using record extension
  scripts/gdb: support printk finalized records

 Documentation/admin-guide/kdump/gdbmacros.txt |  10 +-
 kernel/printk/printk.c                        | 105 +--
 kernel/printk/printk_ringbuffer.c             | 604 +++++++++++++++---
 kernel/printk/printk_ringbuffer.h             |  12 +-
 scripts/gdb/linux/dmesg.py                    |  10 +-
 5 files changed, 558 insertions(+), 183 deletions(-)

-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
