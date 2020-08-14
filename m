Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6WM6-0007sl-JK
 for kexec@lists.infradead.org; Fri, 14 Aug 2020 09:50:35 +0000
Date: Fri, 14 Aug 2020 11:50:31 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC PATCH] printk: Change timestamp to triplet as mono, boot
 and real
Message-ID: <20200814095031.GM6215@alley>
References: <1597120822-11999-1-git-send-email-orsonzhai@gmail.com>
 <20200811094413.GA12903@alley>
 <87zh7175hj.fsf@nanos.tec.linutronix.de>
 <20200811130218.GI6215@alley>
 <20200813015500.GC2020879@jagdpanzerIV.localdomain>
 <20200813102258.GL12903@alley>
 <20200813113155.GA483@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200813113155.GA483@jagdpanzerIV.localdomain>
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

On Thu 2020-08-13 20:31:55, Sergey Senozhatsky wrote:
> On (20/08/13 12:22), Petr Mladek wrote:
> >
> >   + would take more space (prefix + text vs. binary representation)
> 
> Dict buffer is allocated regardless of how we use it, and only printks
> from drivers/* (dev_printk*) add dict payload. It might be the case
> that on some (if not most) systems dict pages are not used 90% of times
> (if not 99%).
> 
> >   + not reliable because dict is currently dropped when no space
> 
> Well, in the perfect world this is a problem, but "maybe not having
> alternative timestamps sometimes" can be OK approach for people who
> wants to use those triplet timestamps.

I am afraid the people would see missing timestamps as a bug.
They want it because they want to corelate kernel and userspace logs.
The timestamps from realtime clock are supposed to make it
straightforward.

More importantly. I do not see a reasonable way how to handle it.
No timestamp is worse than timestamps from non-synchronized clock.
Mixing timestamps from different clocks (as fallback) would cause
a lot of confusion (more harm than good).

> But, in general, how real this problem is? What I sae so far (on my boxes)
> was that printk messages are longer than dict payload.

Yeah, I think that dict are less used on normal systems. But it might
be very different when a driver gets more verbose during debugging
and the amount of dev_printk() calls is much higher.

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
