Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kItmK-0001Rt-Kx
 for kexec@lists.infradead.org; Thu, 17 Sep 2020 13:16:49 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH printk 0/3] printk: move dictionaries to meta data
Date: Thu, 17 Sep 2020 15:22:41 +0206
Message-Id: <20200917131644.25838-1-john.ogness@linutronix.de>
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

Here is a series to move dictionary properties (currently only
SUBSYSTEM and DEVICE exist) into the meta data of a record,
thus eliminating the need for the dict ring. This change
affects how the dictionaries are stored, but does not affect
how they are presented to userspace.

The main purpose of the change is to address concerns [0]
about the reliability of dictionary properties as well as
allowing to efficiently expand the type and number of
properties available [1].

This series is based heavily on the proof of concept [2] from
Petr Mladek. (Petr, feel free to add Co-developed-by tags.)

The series is based on the printk-rework branch of the printk git                                          
tree:                                                                                                      
                                                                                                           
f5f022e53b87 ("printk: reimplement log_cont using record extension")

John Ogness

[0] https://lkml.kernel.org/r/20200904151336.GC20558@alley
[1] https://lkml.kernel.org/r/008801d684f9$43e1c140$cba543c0$@samsung.com
[2] https://lkml.kernel.org/r/20200911095035.GI3864@alley

John Ogness (3):
  printk: move printk_info into separate array
  printk: move dictionary keys to dev_printk_info
  printk: remove dict ring

 Documentation/admin-guide/kdump/gdbmacros.txt |  73 ++---
 drivers/base/core.c                           |  46 +--
 include/linux/dev_printk.h                    |   8 +
 include/linux/printk.h                        |   6 +-
 kernel/printk/internal.h                      |   4 +-
 kernel/printk/printk.c                        | 209 ++++++-------
 kernel/printk/printk_ringbuffer.c             | 292 ++++++++----------
 kernel/printk/printk_ringbuffer.h             |  95 ++----
 kernel/printk/printk_safe.c                   |   2 +-
 scripts/gdb/linux/dmesg.py                    |  16 +-
 10 files changed, 336 insertions(+), 415 deletions(-)

-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
