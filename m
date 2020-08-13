Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6ANx-0003Fj-8q
 for kexec@lists.infradead.org; Thu, 13 Aug 2020 10:23:02 +0000
Date: Thu, 13 Aug 2020 12:22:58 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC PATCH] printk: Change timestamp to triplet as mono, boot
 and real
Message-ID: <20200813102258.GL12903@alley>
References: <1597120822-11999-1-git-send-email-orsonzhai@gmail.com>
 <20200811094413.GA12903@alley>
 <87zh7175hj.fsf@nanos.tec.linutronix.de>
 <20200811130218.GI6215@alley>
 <20200813015500.GC2020879@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200813015500.GC2020879@jagdpanzerIV.localdomain>
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
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Prarit Bhargava <prarit@redhat.com>, John Ogness <john.ogness@linutronix.de>, Orson Zhai <orson.zhai@unisoc.com>, Baoquan He <bhe@redhat.com>, cixi.geng1@unisoc.com, Stephen Boyd <sboyd@kernel.org>, zhang.lyra@gmail.com, Steven Sistare <steven.sistare@oracle.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Jon DeVree <nuxi@vault24.org>, John Stultz <john.stultz@linaro.org>, ruifeng.zhang1@unisoc.com, Orson Zhai <orsonzhai@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Salvatore Bonaccorso <carnil@debian.org>, Dave Young <dyoung@redhat.com>, Dominique Martinet <asmadeus@codewreck.org>, Vivek Goyal <vgoyal@redhat.com>, Pavel Tatashin <pasha.tatashin@soleen.com>

On Thu 2020-08-13 10:55:00, Sergey Senozhatsky wrote:
> On (20/08/11 15:02), Petr Mladek wrote:
> > On Tue 2020-08-11 14:05:12, Thomas Gleixner wrote:
> > > Petr Mladek <pmladek@suse.com> writes:
> > > > At least "crash" tool would need an update anyway. AFAIK, it checks
> > > > the size of struct printk_log and refuses to read it when it changes.
> > > >
> > > > It means that the hack with VMCOREINFO_FIELD_OFFSET probably is not
> > > > needed because we would need to update the crashdump-related tools anyway.
> > > >
> > > > Well, the timing is good. We are about to switch the printk ring
> > > > buffer into a lockless one. It requires updating the crashdump tools
> > > > as well. We could do this at the same time. The lockless ring buffer
> > > > already is in linux-next. It is aimed for 5.10 or 5.11.
> > > ...
> > > > It would be great to synchronize all these changes changes of the
> > > > printk log buffer structures.
> > > 
> > > I agree that having one update is a good thing, but pretty please can we
> > > finally make progress with this and not create yet another dependency?
> > 
> > To make it clear. I definitely do not want to block lockless printk by
> > this.
> > 
> > BTW: I am not 100% convinced that storing all three timestamps is
> > worth it. It increases the code complexity, metadata size. It needs
> > an interface with the userspace that has to stay backward compatible.
> 
> Can we, perhaps, store those various "alternative" timestamps in dict so
> then whoever wants to read them can just parse the dict key:value pairs
> attach to each printk message?

Interesting idea. It might be a way how to add optional metadata
without breaking compatibility with crashdump tools.

Well, I have bad feeling about it. Some of the reasons might be:

  + would take more space (prefix + text vs. binary representation)
  + not reliable because dict is currently dropped when no space
  + it would make the controversial dictionary feature more important


I would prefer to solve this by storing the timestamps in the
structure with metadata.

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
