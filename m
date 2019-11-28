Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ia905-0004SR-K6
 for kexec@lists.infradead.org; Thu, 28 Nov 2019 01:53:47 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: [RFC PATCH v5 0/3] printk: new ringbuffer implementation
Date: Thu, 28 Nov 2019 02:58:32 +0106
Message-Id: <20191128015235.12940-1-john.ogness@linutronix.de>
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
To: linux-kernel@vger.kernel.org
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Brendan Higgins <brendanhiggins@google.com>, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, kexec@lists.infradead.org

Hello,

This is a follow-up RFC on the work to re-implement much of the
core of printk. The threads for the previous RFC versions are
here[0][1][2][3].

This RFC includes only the ringbuffer and a test module. This is
a rewrite of the proposed ringbuffer, now based on the proof of
concept[4] from Petr Mladek as agreed at the meeting[5] during
LPC2019 in Lisbon.

The internal structure has been reworked such that the printk
strings are in their own array, each separated by a 32-bit
integer.

A 2nd array contains the dictionary strings (also with each
separated by a 32-bit integer).

A 3rd array is made up of descriptors that contain all the
meta-data for each printk record (sequence number, timestamp,
loglevel, caller, etc.) as well as pointers into the other data
arrays for the text and dictionary data.

The writer interface is somewhat similar to v4, but the reader
interface has changed significantly. Rather than using an
iterator object, readers just specify the sequence number they
want to read. In effect, the sequence number acts as the
iterator.

I have been communicating with Petr the last couple months to
make sure this implementation fits his expectations. This RFC is
mainly to get some feedback from anyone else that may see
something that Petr and I have missed.

This series also includes my test module. On a 16-core ARM64
test machine, the module runs without any errors. I am seeing
the 15 writing cores each writing about 34500 records per
second, while the 1 reading core misses only about 15% of the
total records.

John Ogness

[0] https://lkml.kernel.org/r/20190212143003.48446-1-john.ogness@linutronix.de
[1] https://lkml.kernel.org/r/20190607162349.18199-1-john.ogness@linutronix.de
[2] https://lkml.kernel.org/r/20190727013333.11260-1-john.ogness@linutronix.de
[3] https://lkml.kernel.org/r/20190807222634.1723-1-john.ogness@linutronix.de
[4] https://lkml.kernel.org/r/20190704103321.10022-1-pmladek@suse.com
[5] https://lkml.kernel.org/r/87k1acz5rx.fsf@linutronix.de

John Ogness (3):
  printk-rb: new printk ringbuffer implementation (writer)
  printk-rb: new printk ringbuffer implementation (reader)
  printk-rb: add test module

 kernel/printk/Makefile            |   3 +
 kernel/printk/printk_ringbuffer.c | 910 ++++++++++++++++++++++++++++++
 kernel/printk/printk_ringbuffer.h | 249 ++++++++
 kernel/printk/test_prb.c          | 347 ++++++++++++
 4 files changed, 1509 insertions(+)
 create mode 100644 kernel/printk/printk_ringbuffer.c
 create mode 100644 kernel/printk/printk_ringbuffer.h
 create mode 100644 kernel/printk/test_prb.c

-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
