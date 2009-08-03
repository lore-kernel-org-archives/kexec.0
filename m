Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp07.in.ibm.com ([59.145.155.7])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1MXqQs-00022Y-Pt
	for kexec@lists.infradead.org; Mon, 03 Aug 2009 05:50:07 +0000
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp07.in.ibm.com (8.14.3/8.13.1) with ESMTP id n735nlQR027721
	for <kexec@lists.infradead.org>; Mon, 3 Aug 2009 11:19:47 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n735nkG31515526
	for <kexec@lists.infradead.org>; Mon, 3 Aug 2009 11:19:46 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n735njgJ018459
	for <kexec@lists.infradead.org>; Mon, 3 Aug 2009 15:49:46 +1000
Date: Mon, 3 Aug 2009 11:19:19 +0530
From: "M. Mohan Kumar" <mohan@in.ibm.com>
Subject: Re: [PATCH] Do not inline putprops function
Message-ID: <20090803054919.GA19594@in.ibm.com>
References: <20090617115917.GD31595@in.ibm.com>
	<1245241595.4269.15.camel@concordia>
	<20090617130413.GB2774@localhost.localdomain>
	<20090617133435.GB4059@in.ibm.com>
	<20090617140514.GB31383@hmsreliant.think-freely.org>
	<20090617142652.GC4059@in.ibm.com>
	<20090617144007.GC31383@hmsreliant.think-freely.org>
	<20090623125534.GA8664@in.ibm.com>
	<20090623135604.GC1157@hmsreliant.think-freely.org>
	<1245803263.9237.3.camel@concordia>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1245803263.9237.3.camel@concordia>
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
To: Michael Ellerman <michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Neil Horman <nhorman@redhat.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, miltonm@bga.com

On Wed, Jun 24, 2009 at 10:27:43AM +1000, Michael Ellerman wrote:
> On Tue, 2009-06-23 at 09:56 -0400, Neil Horman wrote:
> > On Tue, Jun 23, 2009 at 06:25:34PM +0530, M. Mohan Kumar wrote:
> > > 
> > Well it definately looks like removing that variable had some code changes.
> > It'll take some time to match it up to source, but Most interesting I think is
> > the variance in putprops around address f34.  Looks like its doing some string
> > maniuplation in a reversed order, using a huge offset.  Might be worthwhile to
> > check to see if theres any string overruns in this code.
> 
> Yeah I still suspect it's just a bug in the code that's being exposed
> now.
> 
Hi,

The same code works with gcc-3.4.

> Mohan, can you try running it under valgrind?

Still I am not able to use valgrind to debug kexec-tools

Regards,
M. Mohan Kumar.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
