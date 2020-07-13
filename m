Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1juo8R-0003kg-G4
 for kexec@lists.infradead.org; Mon, 13 Jul 2020 02:24:04 +0000
Received: by mail-pf1-x441.google.com with SMTP id u5so5343520pfn.7
 for <kexec@lists.infradead.org>; Sun, 12 Jul 2020 19:24:02 -0700 (PDT)
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Date: Mon, 13 Jul 2020 11:23:56 +0900
Subject: Re: [PATCH v5 0/4] printk: replace ringbuffer
Message-ID: <20200713022356.GB491026@jagdpanzerIV.localdomain>
References: <20200709132344.760-1-john.ogness@linutronix.de>
 <20200710082833.GM4751@alley>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200710082833.GM4751@alley>
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
Cc: Andrea Parri <parri.andrea@gmail.com>, Paul McKenney <paulmck@kernel.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, John Ogness <john.ogness@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On (20/07/10 10:28), Petr Mladek wrote:
> On Thu 2020-07-09 15:29:40, John Ogness wrote:
> > Hello,
> > 
> > Here is a v5 for the first series to rework the printk
> > subsystem. The v4 is here [0]. This first series
> > only replaces the existing ringbuffer implementation. No locking
> > is removed. The semantics/behavior of printk are kept the same
> > except for a minor optimization that is reverted (patch 3).
> > 
> > John Ogness (4):
> >   crash: add VMCOREINFO macro to define offset in a struct declared by
> >     typedef
> >   printk: add lockless ringbuffer
> >   Revert "printk: lock/unlock console only for new logbuf entries"
> >   printk: use the lockless ringbuffer
> 
> The patchset is committed in printk/linux.git, branch printk-rework.

FWIW,
Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

Thank you.

	-ss

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
