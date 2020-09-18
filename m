Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kJOxV-00041J-6V
 for kexec@lists.infradead.org; Fri, 18 Sep 2020 22:34:26 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH printk v2 0/3] printk: move dictionaries to meta data
Date: Sat, 19 Sep 2020 00:40:18 +0206
Message-Id: <20200918223421.21621-1-john.ogness@linutronix.de>
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
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

Hello,

Here is v2 for a series to move all existing dictionary
properties (SUBSYSTEM and DEVICE) into the meta data of a
record, thus eliminating the need for the dict ring. This
change affects how the dictionaries are stored, but does not
affect how they are presented to userspace. (v1 is here [0]).

The main purpose of the change is to address concerns [1]
about the reliability of dictionary properties as well as
allowing to efficiently expand the type and amount of
meta data available [2].

This series is based heavily on the proof of concept [3] from
Petr Mladek. (Petr, feel free to add Co-developed-by tags.)

The series is based on the printk-rework branch of the printk
git tree:

f5f022e53b87 ("printk: reimplement log_cont using record extension")

The list of changes since v1:

drivers/base/core.c
===================

- set_dev_info(): use strscpy() instead of snprintf() (thank
  you Rasmus Villemoes)

kernel/printk/printk.c
======================

- setup_log_buf(): fix cleanup in error handling

- log_buf_vmcoreinfo_setup(): add VMCOREINFO for
  struct dev_printk_info array sizes so that crash tools
  do not need to rely on property value termination

John Ogness

[0] https://lkml.kernel.org/r/20200917131644.25838-1-john.ogness@linutronix.de
[1] https://lkml.kernel.org/r/20200904151336.GC20558@alley
[2] https://lkml.kernel.org/r/008801d684f9$43e1c140$cba543c0$@samsung.com
[3] https://lkml.kernel.org/r/20200911095035.GI3864@alley

John Ogness (3):
  printk: move printk_info into separate array
  printk: move dictionary keys to dev_printk_info
  printk: remove dict ring

 Documentation/admin-guide/kdump/gdbmacros.txt |  73 ++---
 drivers/base/core.c                           |  46 +--
 include/linux/dev_printk.h                    |   8 +
 include/linux/printk.h                        |   6 +-
 kernel/printk/internal.h                      |   4 +-
 kernel/printk/printk.c                        | 221 ++++++-------
 kernel/printk/printk_ringbuffer.c             | 292 ++++++++----------
 kernel/printk/printk_ringbuffer.h             |  95 ++----
 kernel/printk/printk_safe.c                   |   2 +-
 scripts/gdb/linux/dmesg.py                    |  16 +-
 10 files changed, 346 insertions(+), 417 deletions(-)

-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
