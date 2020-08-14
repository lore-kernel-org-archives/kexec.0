Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([193.142.43.55])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6YJt-0004Oe-Ct
 for kexec@lists.infradead.org; Fri, 14 Aug 2020 11:56:26 +0000
Message-Id: <20200814101933.574326079@linutronix.de>
Date: Fri, 14 Aug 2020 12:19:33 +0200
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 0/2] timekeeping: NMI safe timekeeper enhancements
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Prarit Bhargava <prarit@redhat.com>, Petr Mladek <pmladek@suse.com>, Baoquan He <bhe@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kexec@lists.infradead.org, Stephen Boyd <sboyd@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, John Stultz <john.stultz@linaro.org>, Orson Zhai <orsonzhai@gmail.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

printk intends to store various timestamps (MONOTONIC, REALTIME, BOOTTIME)
to make correlation of dmesg accross different machines easier.

The NMI safe timekeeper allows to retrieve these timestamps from any
context, but it lacks a few things:

  1) The nmi safe accessors are not providing time stamps until timekeeping
     is initialized during early boot.

     This can be mitigated by using sched clock up to the point where time-
     keeping becomes available. This has no side effects because clock
     monotonic takes sched clock into account at initialization time
     anyway. So no random time jumps are possible.

     If early sched clock is not available then there is no difference
     either, obviously. Both return 0.

  2) It requires a new accessor which allows to retrieve all three clock
     timestamps in one go.

     Trivial excercise. But there are a few twists:

     A) Access to boot time can be racy if the sleep time offset on resume
     	is injected after timekeeping resume. That's the case when the RTC
     	or whatever is used to calculate sleep time is not availble when
	the timekeeping core is resumed.

     B) Timestamps are frozen accross the very inner low level
     	suspend/resume path. Not a big problem, but might affect the
     	developer debug printks.

     A detailed description of these two points is in the changelog of
     patch 2.

Thanks,

	tglx

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
