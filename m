Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l41zC-0007iI-KW
 for kexec@lists.infradead.org; Mon, 25 Jan 2021 13:32:55 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: Issue in dmesg time with lockless ring buffer
In-Reply-To: <20210122235238.655049-1-elavila@google.com>
References: <20210122235238.655049-1-elavila@google.com>
Date: Mon, 25 Jan 2021 14:38:20 +0106
Message-ID: <87im7l2lcr.fsf@jogness.linutronix.de>
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
To: "J. Avila" <elavila@google.com>
Cc: Andrea Parri <parri.andrea@gmail.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Paul McKenney <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Saravana Kannan <saravanak@google.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On 2021-01-22, "J. Avila" <elavila@google.com> wrote:
> When doing some internal testing on a 5.10.4 kernel, we found that the
> time taken for dmesg seemed to increase from the order of milliseconds
> to the order of seconds when the dmesg size approached the ~1.2MB
> limit. After doing some digging, we found that by reverting all of the
> patches in printk/ up to and including
> 896fbe20b4e2333fb55cc9b9b783ebcc49eee7c7 ("use the lockless
> ringbuffer"), we were able to once more see normal dmesg times.
>
> This kernel had no meaningful diffs in the printk/ dir when compared
> to Linus' tree. This behavior was consistently reproducible using the
> following steps:
>
> 1) In one shell, run "time dmesg > /dev/null"
> 2) In another, constantly write to /dev/kmsg
>
> Within ~5 minutes, we saw that dmesg times increased to 1 second, only
> increasing further from there. Is this a known issue?

The last couple days I have tried to reproduce this issue with no
success.

Is your dmesg using /dev/kmsg or syslog() to read the buffer?

Are there any syslog daemons or systemd running? Perhaps you can run
your test within an initrd to see if this effect is still visible?

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
