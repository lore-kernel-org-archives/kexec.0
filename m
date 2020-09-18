Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kJHJk-0001T1-LT
 for kexec@lists.infradead.org; Fri, 18 Sep 2020 14:24:53 +0000
Date: Fri, 18 Sep 2020 16:24:50 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH printk 2/3] printk: move dictionary keys to dev_printk_info
Message-ID: <20200918142450.GE14605@alley>
References: <20200917131644.25838-1-john.ogness@linutronix.de>
 <20200917131644.25838-3-john.ogness@linutronix.de>
 <316cf147-0ae2-1c88-7375-07aedc58bd15@rasmusvillemoes.dk>
 <20200918121342.GD14605@alley>
 <3123b0b5-ca4f-e964-ecc7-95fe8409f1d2@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3123b0b5-ca4f-e964-ecc7-95fe8409f1d2@rasmusvillemoes.dk>
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
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, John Ogness <john.ogness@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri 2020-09-18 14:32:41, Rasmus Villemoes wrote:
> On 18/09/2020 14.13, Petr Mladek wrote:
> > On Fri 2020-09-18 08:16:37, Rasmus Villemoes wrote:
> >> On 17/09/2020 15.16, John Ogness wrote:
> >>
> >>>  	if (dev->class)
> >>>  		subsys = dev->class->name;
> >>>  	else if (dev->bus)
> >>>  		subsys = dev->bus->name;
> >>>  	else
> >>> -		return 0;
> >>> +		return;
> >>>  
> >>> -	pos += snprintf(hdr + pos, hdrlen - pos, "SUBSYSTEM=%s", subsys);
> >>> -	if (pos >= hdrlen)
> >>> -		goto overflow;
> >>> +	snprintf(dev_info->subsystem, sizeof(dev_info->subsystem), subsys);
> >>
> >> It's unlikely that subsys would contain a %, but this will be yet
> >> another place to spend brain cycles ignoring if doing static analysis.
> >> So can we not do this. Either of strXcpy() for X=s,l will do the same
> >> thing, and likely faster.
> > 
> > Good point! Better be on the safe size in a generic printk() API.
> > 
> > Well, I am afraid that this would be only small drop in a huge lake.
> > class->name and bus->name seems to be passed to %s in so many
> > *print*() calls all over the kernel code.
> 
> So what? printf("%s", some_string_that_might_contain_percent_chars) is
> not a problem.

Grr, shame on me. I have completely messed this. The combination of
Friday afternoon and noisy kids did not help me much to get it right.

> printf(some_string_that_might_contain_percent_chars) is.

I fully agree that passing unknown string as "fmt" is dangerous and
must be used carefully. It is not needed here.

> And yes, one could do
> 
>   snprintf(dev_info->subsystem, sizeof(dev_info->subsystem), "%s", subsys);
>
> but one might as well avoid the snprintf overhead and use one of the
> strX functions that have the exact same semantics (copy as much as
> there's room for, ensure nul-termination).

Yes, we should use either snprinf() with %s or strXcpy().

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
