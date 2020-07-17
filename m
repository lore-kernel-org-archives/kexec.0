Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([193.142.43.55])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwa65-0007Zh-HG
 for kexec@lists.infradead.org; Fri, 17 Jul 2020 23:48:59 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH 0/4] printk: reimplement LOG_CONT handling
Date: Sat, 18 Jul 2020 01:54:14 +0206
Message-Id: <20200717234818.8622-1-john.ogness@linutronix.de>
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
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

Hello,

Here is the second series to rework the printk subsystem. This series
removes LOG_CONT handling from printk() callers, storing all LOG_CONT
parts individually in the ringbuffer. With this series, LOG_CONT
handling is moved to the ringbuffer readers that provide the record
contents to users (console printing, syslog, /dev/kmsg).

This change is necessary in order to support the upcoming move to a
fully lockless printk() implementation.

This series is in line with the agreements [0] made at the meeting
during LPC2019 in Lisbon, with 1 exception: For the /dev/kmsg
interface, empty line placeholder records are reported for the
LOG_CONT parts.

Using placeholders avoids tools such as systemd-journald from
erroneously reporting missed messages. However, it also means that
empty placeholder records are visible in systemd-journald logs and
displayed in tools such as dmesg.

The effect can be easily observed with the sysrq help:

$ echo h | sudo tee /proc/sysrq-trigger
$ sudo dmesg | tail -n 30
$ sudo journalctl -k -n 30

Providing the placeholder entries allows a userspace tool to identify
if records were actually lost. IMHO this an important feature. Its
side effect can be addressed by userspace tools if they change to
silently consume empty records.

For dump tools that process the ringbuffer directly (such as crash,
makedumpfile, kexec-tools), they will need to implement LOG_CONT
handling if they want to present clean continuous line messages.

Finally, by moving LOG_CONT handling from writers to readers, some
incorrect pr_cont() usage is revealed. Patch 4 of this series
addresses one such example.

This series is based on the printk git tree [1] printk-rework branch.

[0] https://lkml.kernel.org/r/87k1acz5rx.fsf@linutronix.de
[1] https://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git (printk-rework branch)

John Ogness (4):
  printk: ringbuffer: support dataless records
  printk: store instead of processing cont parts
  printk: process cont records during reading
  ipconfig: cleanup printk usage

 kernel/printk/printk.c            | 569 ++++++++++++++++++++----------
 kernel/printk/printk_ringbuffer.c |  58 ++-
 kernel/printk/printk_ringbuffer.h |  15 +-
 net/ipv4/ipconfig.c               |  25 +-
 4 files changed, 434 insertions(+), 233 deletions(-)

-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
