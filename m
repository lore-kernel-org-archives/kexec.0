Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1P0H3X-00007P-Qn
	for kexec@lists.infradead.org; Mon, 27 Sep 2010 17:00:01 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <5C4C569E8A4B9B42A84A977CF070A35B2C0979C90E@USINDEVS01.corp.hds.com>
	<m1wrql2sf1.fsf@fess.ebiederm.org>
	<5C4C569E8A4B9B42A84A977CF070A35B2C0DCFFB3E@USINDEVS01.corp.hds.com>
Date: Mon, 27 Sep 2010 09:59:28 -0700
In-Reply-To: <5C4C569E8A4B9B42A84A977CF070A35B2C0DCFFB3E@USINDEVS01.corp.hds.com>
	(Seiji Aguchi's message of "Fri, 24 Sep 2010 09:08:14 -0400")
Message-ID: <m1eicfp1fz.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [RFC][PATCH] Fix kexec abort due to IPI from panic().
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Seiji Aguchi <seiji.aguchi@hds.com>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "dle-develop@lists.sourceforge.net" <dle-develop@lists.sourceforge.net>, "David.Woodhouse@intel.com" <David.Woodhouse@intel.com>, "jason.wessel@windriver.com" <jason.wessel@windriver.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Satoru Moriya <satoru.moriya@hds.com>, "anton@samba.org" <anton@samba.org>, "simon.kagstrom@netinsight.net" <simon.kagstrom@netinsight.net>, "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "ben@decadent.org.uk" <ben@decadent.org.uk>

Seiji Aguchi <seiji.aguchi@hds.com> writes:

> Hi Eric,
>
> This is a patch which makes kmsg_dump() non-blocking.
> Please give me your comments and suggestions.
>
> I improved it as follows.
>
> (1) Improvement of dump_list_lock
>     (1-1) I changed dump_list to RCU for deleting dump_list_lock in kmsg_dump().
>     (1-2) I moved kmsg_dump(KMSG_DUMP_KEXEC) behind machine_crash_shutdown() 
>           for avoiding concurrent execution of dump_list functions.
>     (1-3) I also moved kmsg_dump(KMSG_DUMP_PANIC) behind smp_send_stop() for the 
>           same reason.
>  
> (2) Improvement of logbuf_lock
>     I added spinlock_init(&logbuf_lock) when executing kmsg_dump() in kexec or panic path
>     for preventing dead lock.
>
> We can delete blocking kmsg_dump call in crash_kexec and panic path.

This looks better, but it still gives me the willies.

I tried tracing through the ramoops code to see if there were anything
else that could block, but I couldn't make it through do_gettimeofday.

I couldn't even make it that far with the mtd oops tracer.

The fact that the code is exported and modular doesn't make me feel
safe because there have been people in the past who have asked for an
notifier on crash so they could do stupid things when the kernel is
broken.

The fact that this wasn't noticed until we actually had a hang, doesn't
give me an especially great feeling about long term stability.

Most of all I don't see the use case of calling kmsg_dump when you have
kexec on panic setup to do the same thing.  Having kmsg_dump not on
the kexec on panic code path would let me sleep much easier at night.

Then there is the historical side of this.  Through many failed attempts
it has been show that dumpers in the kernel are fragile beasts that work
up until you actually have a real world failure and then they let you
down.  Kexec on panic is better as it works 65% or so of the time,
and definitely won't corrupt your bits if it fails.  I don't see what
makes kmsg_dump better than all of the past failed and useless kernel
dumpers.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
