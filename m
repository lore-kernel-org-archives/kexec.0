Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAsF6-0003wq-V1
 for kexec@lists.infradead.org; Wed, 26 Aug 2020 10:01:21 +0000
Received: by mail-pf1-x441.google.com with SMTP id x143so719374pfc.4
 for <kexec@lists.infradead.org>; Wed, 26 Aug 2020 03:01:18 -0700 (PDT)
Date: Wed, 26 Aug 2020 19:01:13 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH v2 5/7][next] printk: ringbuffer: add
 finalization/extension support
Message-ID: <20200826100113.GA8849@jagdpanzerIV.localdomain>
References: <20200824103538.31446-1-john.ogness@linutronix.de>
 <20200824103538.31446-6-john.ogness@linutronix.de>
 <87lfi1ls2g.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87lfi1ls2g.fsf@jogness.linutronix.de>
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
Cc: Andrea Parri <parri.andrea@gmail.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Paul McKenney <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On (20/08/26 10:45), John Ogness wrote:
> On 2020-08-24, John Ogness <john.ogness@linutronix.de> wrote:
> > @@ -1157,6 +1431,14 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
> >  		goto fail;
> >  	}
> >  
> > +	/*
> > +	 * New data is about to be reserved. Once that happens, previous
> > +	 * descriptors are no longer able to be extended. Finalize the
> > +	 * previous descriptor now so that it can be made available to
> > +	 * readers (when committed).
> > +	 */
> > +	desc_finalize(desc_ring, DESC_ID(id - 1));
> > +
> >  	d = to_desc(desc_ring, id);
> >  
> >  	/*
> 
> Apparently this is not enough to guarantee that past descriptors are
> finalized. I am able to reproduce a scenario where the finalization of a
> certain descriptor never happens. That leaves the descriptor permanently
> in the reserved queried state, which prevents any new records from being
> created. I am investigating.

Good to know. I also run into problems:
- broken dmesg (and broken journalctl -f /dev/kmsg poll) and broken
  syslog read

$ strace dmesg

...
openat(AT_FDCWD, "/dev/kmsg", O_RDONLY|O_NONBLOCK) = 3
lseek(3, 0, SEEK_DATA)                  = 0
read(3, 0x55dda8c240a8, 8191)           = -1 EAGAIN (Resource temporarily unavailable)
close(3)                                = 0
syslog(10 /* SYSLOG_ACTION_SIZE_BUFFER */) = 524288
mmap(NULL, 528384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f43ea847000
syslog(3 /* SYSLOG_ACTION_READ_ALL */, "", 524296) = 0
munmap(0x7f43ea847000, 528384)          = 0
...

	-ss

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
