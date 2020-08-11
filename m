Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5Tv3-0006iU-4K
 for kexec@lists.infradead.org; Tue, 11 Aug 2020 13:02:21 +0000
Date: Tue, 11 Aug 2020 15:02:18 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC PATCH] printk: Change timestamp to triplet as mono, boot
 and real
Message-ID: <20200811130218.GI6215@alley>
References: <1597120822-11999-1-git-send-email-orsonzhai@gmail.com>
 <20200811094413.GA12903@alley>
 <87zh7175hj.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87zh7175hj.fsf@nanos.tec.linutronix.de>
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
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Prarit Bhargava <prarit@redhat.com>, John Ogness <john.ogness@linutronix.de>, Orson Zhai <orson.zhai@unisoc.com>, Baoquan He <bhe@redhat.com>, cixi.geng1@unisoc.com, Stephen Boyd <sboyd@kernel.org>, zhang.lyra@gmail.com, Steven Sistare <steven.sistare@oracle.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Jon DeVree <nuxi@vault24.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, John Stultz <john.stultz@linaro.org>, ruifeng.zhang1@unisoc.com, Orson Zhai <orsonzhai@gmail.com>, Salvatore Bonaccorso <carnil@debian.org>, Dave Young <dyoung@redhat.com>, Dominique Martinet <asmadeus@codewreck.org>, Vivek Goyal <vgoyal@redhat.com>, Pavel Tatashin <pasha.tatashin@soleen.com>

On Tue 2020-08-11 14:05:12, Thomas Gleixner wrote:
> Petr Mladek <pmladek@suse.com> writes:
> > At least "crash" tool would need an update anyway. AFAIK, it checks
> > the size of struct printk_log and refuses to read it when it changes.
> >
> > It means that the hack with VMCOREINFO_FIELD_OFFSET probably is not
> > needed because we would need to update the crashdump-related tools anyway.
> >
> > Well, the timing is good. We are about to switch the printk ring
> > buffer into a lockless one. It requires updating the crashdump tools
> > as well. We could do this at the same time. The lockless ring buffer
> > already is in linux-next. It is aimed for 5.10 or 5.11.
> ...
> > It would be great to synchronize all these changes changes of the
> > printk log buffer structures.
> 
> I agree that having one update is a good thing, but pretty please can we
> finally make progress with this and not create yet another dependency?

To make it clear. I definitely do not want to block lockless printk by
this.

BTW: I am not 100% convinced that storing all three timestamps is
worth it. It increases the code complexity, metadata size. It needs
an interface with the userspace that has to stay backward compatible.

Also it still will be racy because the timestamp is taken when the message
is printed. It might be "long" before or after the event that
it talks about.

There is still the alternative to print all three timestamps regularly
for those interested. It is less user convenient but much easier
to maintain.

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
