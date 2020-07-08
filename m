Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtBrk-0004YQ-UF
 for kexec@lists.infradead.org; Wed, 08 Jul 2020 15:20:10 +0000
Date: Wed, 8 Jul 2020 17:20:05 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v4 0/4] printk: replace ringbuffer
Message-ID: <20200708152005.GF4751@alley>
References: <20200707145932.8752-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200707145932.8752-1-john.ogness@linutronix.de>
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
Cc: Andrea Parri <parri.andrea@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Paul McKenney <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On Tue 2020-07-07 17:05:28, John Ogness wrote:
> Hello,
> 
> Here is a v4 for the first series to rework the printk
> subsystem. The v3 is here [0]. This first series
> only replaces the existing ringbuffer implementation. No locking
> is removed. The semantics/behavior of printk are kept the same
> except for a minor optimization that is reverted (patch 3).
> 
> Despite minor changes to the ringbuffer code since v3 (comments,
> function names, very minor refactoring), the ringbuffer logic
> itself has not changed. And, in particular, the memory barriers
> have been exactly preserved from v3. For this reason I deem it
> appropriate to keep Paul's reviewed by tag (patch 2).
> 
> RFC patches for various userspace tools to dump the kernel log
> are available: crash [1], makedumpfile [2], kexec-tools [3].
> 
> Finally, I would like to thank some people/organizations that
> helped with performing ringbuffer stress tests on big or rare
> hardware that I do not have access to:
> 
> - Prarit Bhargava of Red Hat (x86_64, ppc64le power8)
> - Michael Cree of Debian (alpha)
> - Jeff Scheel of OSU Open Source Lab (ppc64le power8 kvm)

OK, I think that we are ready to try this in linux-next.
I am going to push it there via printk/linux.git.

I have a good feeling about the patchset. The great thing is that
the access is still synchronized using logbuf_lock so that we do not
have to deal with races for the moment.

Of course, there are still many potential problems. The following comes
to my mind:

   + Bugs in the algorithm logic or implementation might prevent
     showing any messages on consoles or via syslog or /dev/kmsg.
     We did our best to avoid it.

   + Debugging tools accessing the buffer directly would need to
     understand the new structure. Fortunately John provided
     patches for the most prominent ones.

   + Small devices might complain about less effective use of memory.
     Part of descriptors and dictionaries ring buffers might stay
     unused. But it hopefully could get tuned.


This is basically just a start of the journey. I hope that it will be a
good one.

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
