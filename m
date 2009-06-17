Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1MGvHp-0001Pu-BH
	for kexec@lists.infradead.org; Wed, 17 Jun 2009 13:34:52 +0000
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp07.au.ibm.com (8.13.1/8.13.1) with ESMTP id n5HNYagt031338
	for <kexec@lists.infradead.org>; Thu, 18 Jun 2009 09:34:36 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5HDYa0v987366
	for <kexec@lists.infradead.org>; Wed, 17 Jun 2009 23:34:36 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5HDYZph005468
	for <kexec@lists.infradead.org>; Wed, 17 Jun 2009 23:34:36 +1000
Date: Wed, 17 Jun 2009 19:04:35 +0530
From: "M. Mohan Kumar" <mohan@in.ibm.com>
Subject: Re: [PATCH] Do not inline putprops function
Message-ID: <20090617133435.GB4059@in.ibm.com>
References: <20090617113456.GC31595@in.ibm.com>
	<20090617114551.GA5672@verge.net.au>
	<20090617115917.GD31595@in.ibm.com>
	<1245241595.4269.15.camel@concordia>
	<20090617130413.GB2774@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20090617130413.GB2774@localhost.localdomain>
Reply-To: mohan@in.ibm.com
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Neil Horman <nhorman@redhat.com>
Cc: Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev@ozlabs.org, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, miltonm@bga.com

On Wed, Jun 17, 2009 at 09:04:13AM -0400, Neil Horman wrote:
> On Wed, Jun 17, 2009 at 10:26:35PM +1000, Michael Ellerman wrote:
> > 
> > What compiler version are you using? Does the behaviour change if you
> > use a newer/older compiler? It sounds to me like there's some deeper bug
> > and your patch is just papering over it.
> > 

I tried with gcc 4.3.2. Let me try with a recent version and update.

> Agreed, this doesn't make any sense. Try changing the compiler version to see if
> the problem goes away or stops.  It might also be worthwhile to dump the
> contents of the device tree at the start and end of the kexec process.  If the
> changing of how a function is inlined is causing a hang, its likely changing how
> the putprops function is writing information to the device tree.  Understanding
> what that change is will likely provide clues to how the code has changed.

Neil, there was no code change in fs2dt.c

Regards,
M. Mohan Kumar

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
