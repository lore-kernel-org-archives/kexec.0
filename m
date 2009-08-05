Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp01.in.ibm.com ([59.145.155.1])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1MYjgf-0003se-Jx
	for kexec@lists.infradead.org; Wed, 05 Aug 2009 16:50:06 +0000
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp01.in.ibm.com (8.14.3/8.13.1) with ESMTP id n75Gnklb020449
	for <kexec@lists.infradead.org>; Wed, 5 Aug 2009 22:19:46 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n75Gnkhh1671210
	for <kexec@lists.infradead.org>; Wed, 5 Aug 2009 22:19:46 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n75GnjgN025490
	for <kexec@lists.infradead.org>; Wed, 5 Aug 2009 22:19:46 +0530
Date: Wed, 5 Aug 2009 22:19:38 +0530
From: "M. Mohan Kumar" <mohan@in.ibm.com>
Subject: Re: [PATCH] Do not inline putprops function
Message-ID: <20090805164938.GA2970@in.ibm.com>
References: <1245241595.4269.15.camel@concordia>
	<20090617130413.GB2774@localhost.localdomain>
	<20090617133435.GB4059@in.ibm.com>
	<20090617140514.GB31383@hmsreliant.think-freely.org>
	<20090617142652.GC4059@in.ibm.com>
	<20090617144007.GC31383@hmsreliant.think-freely.org>
	<20090623125534.GA8664@in.ibm.com>
	<20090623135604.GC1157@hmsreliant.think-freely.org>
	<1245803263.9237.3.camel@concordia>
	<20090803054919.GA19594@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20090803054919.GA19594@in.ibm.com>
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

Hi,

When I align the dtstruct variable to 8 bytes, I am able to invoke kdump.

When the line
	static unsigned dtstruct[TREEWORDS], *dt;
changed to 
	static unsigned dtstruct[TREEWORDS] __attribute__ ((aligned (8))), *dt;

kexec-tool works.

Regards,
M. Mohan Kumar

On Mon, Aug 03, 2009 at 11:19:19AM +0530, M. Mohan Kumar wrote:
> On Wed, Jun 24, 2009 at 10:27:43AM +1000, Michael Ellerman wrote:
> > On Tue, 2009-06-23 at 09:56 -0400, Neil Horman wrote:
> > > On Tue, Jun 23, 2009 at 06:25:34PM +0530, M. Mohan Kumar wrote:
> > > > 
> > > Well it definately looks like removing that variable had some code changes.
> > > It'll take some time to match it up to source, but Most interesting I think is
> > > the variance in putprops around address f34.  Looks like its doing some string
> > > maniuplation in a reversed order, using a huge offset.  Might be worthwhile to
> > > check to see if theres any string overruns in this code.
> > 
> > Yeah I still suspect it's just a bug in the code that's being exposed
> > now.
> > 
> Hi,
> 
> The same code works with gcc-3.4.
> 
> > Mohan, can you try running it under valgrind?
> 
> Still I am not able to use valgrind to debug kexec-tools
> 
> Regards,
> M. Mohan Kumar.
> 
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
