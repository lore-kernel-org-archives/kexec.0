Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate7.uk.ibm.com ([194.196.100.167])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QqTvf-0006sm-Vx
	for kexec@lists.infradead.org; Mon, 08 Aug 2011 17:47:57 +0000
Received: from d06nrmr1307.portsmouth.uk.ibm.com
	(d06nrmr1307.portsmouth.uk.ibm.com [9.149.38.129])
	by mtagate7.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p78HleZi012407
	for <kexec@lists.infradead.org>; Mon, 8 Aug 2011 17:47:40 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1307.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p78HleSU2502656
	for <kexec@lists.infradead.org>; Mon, 8 Aug 2011 18:47:40 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p78Hle4R023817
	for <kexec@lists.infradead.org>; Mon, 8 Aug 2011 11:47:40 -0600
Subject: Re: [patch v2 04/10] kdump: Trigger kdump via panic notifier chain
	on s390
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
In-Reply-To: <20110804211432.GE429@redhat.com>
References: <20110727125504.491183728@linux.vnet.ibm.com>
	<20110727125808.028895659@linux.vnet.ibm.com>
	<20110801204114.GJ3805@redhat.com> <1312274279.4881.18.camel@br98xy6r>
	<20110802192147.GJ6399@redhat.com> <1312365039.3783.36.camel@br98xy6r>
	<20110804211432.GE429@redhat.com>
Date: Mon, 08 Aug 2011 19:47:39 +0200
Message-ID: <1312825659.3537.62.camel@br98xy6r>
Mime-Version: 1.0
Reply-To: holzheu@linux.vnet.ibm.com
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, horms@verge.net.au, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org

Hello Vivek,

On Thu, 2011-08-04 at 17:14 -0400, Vivek Goyal wrote:
> On Wed, Aug 03, 2011 at 11:50:39AM +0200, Michael Holzheu wrote:

[snip]
 
> > Only if the user has specified panic action stand-alone dump, we do the
> > detour via the stand-alone dump tools.
> 
> If a user decides to load kdump kernel to capture dump, then why does it
> still make sense to set panic action as "stand-alone dump tools". One
> could argue that user loaded kdump kernel but not necessarily wants
> that mechanism to use, in that case dump-tools does not have to jump
> to kdump kernel at all. 

The user on s390 can currently freely configure the panic action. If we
would always do kdump on panic, when kdump is active, we would have to
ensure in sysfs that the user can't change the setting any more.
Technically we could do that of course.

One use case we had in mind was that the s390 Linux administrator does
not have to learn new things when using kdump. kdump can be used as
extension of the already existing mechanism. Today users configure
stand-alone dump via sysfs. With kdump + trigger via dump tools they
could do it still the same way. And also for manual dump they just IPL
the dump tool as they are used to do it and if kdump is fine, kdump will
be triggered. Nothing new has to be learned.

If users only want to use kdump without stand-alone dump tools as on
other architectures also this is possible. Then the panic action will be
just kdump.

> > 
> > > like other architectures and jump to stand
> > > alone kernel only if some piece of code is corrupted and that action
> > > failed.
> > > 
> > > What's the point of jumping to stand alone kenrel in case of panic()
> > > and then re-enter it back to original kernel using crash_kexec(). Sound
> > > like a very odd design choice to me.
> > > 
> > > I am now I am repeating this question umpteen time simply because
> > > I never got a good answer except "we have to do it this way".
> > 
> > Sometimes communication is really hard and frustrating.
> > ... but at least we are still communicating.
> > 
> > Ok very last try:
> > 
> > * We can use the same mechanism for manual dump and automatic dump on
> > panic: IPL the stand-alone dump tools.
> 
> So manual dump/intervention is only required if automatic dump failed?

Manual intervention is required only if panic code does not make it to
the "IPL stand-alone dump tools" code.

> 
> > kdump check and backup
> > stand-alone dump is implemented only in the stand-alone dump code.
> 
> My argument is that why stand alone dump is trying to trigger kdump
> at all? Shouldn't it all be part of loading kdump kernel and user
> setting panic() action to kdump?

To summarize: Our approach was to do it in the stand-alone dump tools
code for both the manual and the automatic on panic case:

panic ------+                                 +- valid -> kdump
            +-> IPL dump tools -> try kdump --+
hard hang --+                                 +- invalid -> stand-alone dump

Your suggestion looks like the following:

panic --> try kdump +-- valid ---> kdump
                    |
                    +-- invalid -> IPL dump tools --> stand-alone dump

                                            +- valid -> kdump
hard hang --> IPL dump tools -> try kdump --+ 
                                            +- invalid -> stand-alone dump

Is that what you are suggesting? We can do it that way, too. Then
we would not need the #ifdef CONFIG_S390 in panic().

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
