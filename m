Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([193.142.43.55])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtQaz-0000Oq-1F
 for kexec@lists.infradead.org; Thu, 09 Jul 2020 07:03:50 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v4 0/4] printk: replace ringbuffer
In-Reply-To: <20200708152005.GF4751@alley>
References: <20200707145932.8752-1-john.ogness@linutronix.de>
 <20200708152005.GF4751@alley>
Date: Thu, 09 Jul 2020 09:09:31 +0206
Message-ID: <87wo3d9nlo.fsf@jogness.linutronix.de>
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

On 2020-07-08, Petr Mladek <pmladek@suse.com> wrote:
> OK, I think that we are ready to try this in linux-next.
> I am going to push it there via printk/linux.git.
>
> [...]
> 
> Of course, there are still many potential problems. The following comes
> to my mind:
>
> [...]
>
>    + Debugging tools accessing the buffer directly would need to
>      understand the new structure. Fortunately John provided
>      patches for the most prominent ones.

The next series in the printk-rework (move LOG_CONT handling from
writers to readers) makes some further changes that, while not
incompatible, could affect the output of existing tools. It may be a
good idea to let the new ringbuffer sit in linux-next until the next
series has been discussed/reviewed/merged. After the next series,
everything will be in place (with regard to userspace tools) to finish
the rework.

As reminder, here are all the steps planned for the full rework:

1. replace ringbuffer
2. implement NMI-safe LOG_CONT (i.e. move handling to readers)
3. remove logbuf_lock
4. remove safe buffers
5. implement per-console printing kthreads
6. implement emergency mode and write_atomic() support
7. implement write_atomic() for 8250 UART

Some of the steps may be combined into a single series if the changes
are not too dramatic.

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
