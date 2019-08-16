Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hyVBx-0002Js-KI
 for kexec@lists.infradead.org; Fri, 16 Aug 2019 05:54:26 +0000
Date: Fri, 16 Aug 2019 13:54:16 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [RFC PATCH v4 9/9] printk: use a new ringbuffer implementation
Message-ID: <20190816055416.GA4460@dhcp-128-65.nay.redhat.com>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190807222634.1723-10-john.ogness@linutronix.de>
 <20190816054651.GA4403@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190816054651.GA4403@dhcp-128-65.nay.redhat.com>
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
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, Petr Mladek <pmladek@suse.com>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Brendan Higgins <brendanhiggins@google.com>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Simon Horman <horms@verge.net.au>, Thomas Gleixner <tglx@linutronix.de>, David Woodhouse <dwmw2@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, kexec@lists.infradead.org

On 08/16/19 at 01:46pm, Dave Young wrote:
> John, can you cc kexec list for your later series?
> 
> On 08/08/19 at 12:32am, John Ogness wrote:
> > This is a major change because the API (and underlying workings)
> > of the new ringbuffer are completely different than the previous
> > ringbuffer. Since there are several components of the printk
> > infrastructure that use the ringbuffer API (console, /dev/kmsg,
> > syslog, kmsg_dump), there are quite a few changes throughout the
> > printk implementation.
> > 
> > This is also a conservative change because it continues to use the
> > logbuf_lock raw spinlock even though the new ringbuffer is lockless.
> > 
> > The externally visible changes are:
> > 
> > 1. The exported vmcore info has changed:
> > 
> >     - VMCOREINFO_SYMBOL(log_buf);
> >     - VMCOREINFO_SYMBOL(log_buf_len);
> >     - VMCOREINFO_SYMBOL(log_first_idx);
> >     - VMCOREINFO_SYMBOL(clear_idx);
> >     - VMCOREINFO_SYMBOL(log_next_idx);
> >     + VMCOREINFO_SYMBOL(printk_rb_static);
> >     + VMCOREINFO_SYMBOL(printk_rb_dynamic);
> 
> I assumed this needs some userspace work in kexec,  how did you test
> them?
> 
> makedumpfile should need changes to dump the kernel log.
> 
> Also kexec-tools includes a vmcore-dmesg.c to extrace dmesg from
> /proc/vmcore.
> 
> > 
> > 2. For the CONFIG_PPC_POWERNV powerpc platform, kernel log buffer
> >    registration is no longer available because there is no longer
> >    a single contigous block of memory to represent all of the
> >    ringbuffer.
> > 
> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
> > ---
> >  arch/powerpc/platforms/powernv/opal.c |  22 +-
> >  include/linux/kmsg_dump.h             |   6 +-
> >  include/linux/printk.h                |  12 -
> >  kernel/printk/printk.c                | 745 ++++++++++++++------------
> >  kernel/printk/ringbuffer.h            |  24 +
> >  5 files changed, 415 insertions(+), 394 deletions(-)
> > 

[snip]

Seems kexec list has 40k limitation for msg body.  Simon and David, maybe it is
too small?

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
