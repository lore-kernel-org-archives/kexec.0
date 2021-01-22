Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l36Ek-0006S5-By
 for kexec@lists.infradead.org; Fri, 22 Jan 2021 23:53:07 +0000
Received: by mail-pj1-x104a.google.com with SMTP id l7so4320699pjy.0
 for <kexec@lists.infradead.org>; Fri, 22 Jan 2021 15:53:03 -0800 (PST)
Date: Fri, 22 Jan 2021 23:52:39 +0000
In-Reply-To: <20200709132344.760-5-john.ogness@linutronix.de>
Message-Id: <20210122235238.655049-1-elavila@google.com>
Mime-Version: 1.0
Subject: Issue in dmesg time with lockless ring buffer
From: "J. Avila" <elavila@google.com>
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
To: John Ogness <john.ogness@linutronix.de>
Cc: Andrea Parri <parri.andrea@gmail.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Paul McKenney <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Saravana Kannan <saravanak@google.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

Hello,

When doing some internal testing on a 5.10.4 kernel, we found that the
time taken for dmesg seemed to increase from the order of milliseconds to
the order of seconds when the dmesg size approached the ~1.2MB limit. After
doing some digging, we found that by reverting all of the patches in printk/
up to and including 896fbe20b4e2333fb55cc9b9b783ebcc49eee7c7 ("use the
lockless ringbuffer"), we were able to once more see normal dmesg times.

This kernel had no meaningful diffs in the printk/ dir when compared to
Linus' tree. This behavior was consistently reproducible using the
following steps:

1) In one shell, run "time dmesg > /dev/null"
2) In another, constantly write to /dev/kmsg

Within ~5 minutes, we saw that dmesg times increased to 1 second, only
increasing further from there. Is this a known issue?

Thank you,

Avila

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
