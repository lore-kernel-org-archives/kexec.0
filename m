Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate5.uk.ibm.com ([194.196.100.165])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Qjuhw-0005qp-7t
	for kexec@lists.infradead.org; Thu, 21 Jul 2011 14:58:37 +0000
Received: from d06nrmr1507.portsmouth.uk.ibm.com
	(d06nrmr1507.portsmouth.uk.ibm.com [9.149.38.233])
	by mtagate5.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p6LEwJQh027126
	for <kexec@lists.infradead.org>; Thu, 21 Jul 2011 14:58:19 GMT
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
	[9.149.37.217])
	by d06nrmr1507.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p6LEwJTL2412734
	for <kexec@lists.infradead.org>; Thu, 21 Jul 2011 15:58:19 +0100
Received: from d06av06.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av06.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p6LEwJ4x019590
	for <kexec@lists.infradead.org>; Thu, 21 Jul 2011 08:58:19 -0600
Subject: Re: [patch 0/9] kdump: Patch series for s390 support
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
In-Reply-To: <20110720192509.GD10079@redhat.com>
References: <20110714180528.GF6672@redhat.com>
	<1310739717.10789.31.camel@br98xy6r>	<20110715143820.GG3428@redhat.com>
	<1310744603.10789.79.camel@br98xy6r>	<20110718123140.GB31986@redhat.com>
	<1310997641.4427.10.camel@br98xy6r>	<20110718141943.GE31986@redhat.com>
	<1311000253.4427.23.camel@br98xy6r>	<20110718152532.GF31986@redhat.com>
	<1311012188.4427.58.camel@br98xy6r> <20110720192509.GD10079@redhat.com>
Date: Thu, 21 Jul 2011 16:58:18 +0200
Message-ID: <1311260298.6160.43.camel@br98xy6r>
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
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, horms@verge.net.au, ebiederm@xmission.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, kexec@lists.infradead.org

Hello Vivek,

On Wed, 2011-07-20 at 15:25 -0400, Vivek Goyal wrote:
> On Mon, Jul 18, 2011 at 08:03:08PM +0200, Michael Holzheu wrote:

[snip]

> > What you as kdump framework maintainer would have to accept with this
> > solution is that it is allowed now to start kdump directly via purgatory
> > without using code from the old kernel (e.g. crash_kexec). This has as
> > implication that all things that the old kernel has to initialize for
> > kdump has to be done before the system crashes. Currently this is only
> > the initialization of vmcoreinfo.
> 
> Hi Michael,
> 
> Instead of introdcuing a new entry point for second kernel, why not
> jump to crash_kexec() from stand alone tools? That should be functionally
> equivalent to what you described above without any need to pass the 
> purgatory details to stand alone tools.

That has the drawback that we still execute unchecked code from the
crashed kernel. But ...

... I discussed that with Martin and we had an idea how to deal with
this problem. On s390 when an invalid opcode is executed or invalid
parameters are used, we get a program check interrupt. When the
crash_kexec() code path or data is corrupted, it is almost sure that we
get a program check. The stand-alone dump tools could establish a
program check interrupt handler that jumps back to the dump tools code
and then create full-blown dump.

So I think with this mechanism we could use an entry point (name it
s390_kdump_entry) in the old kernel that calls crash_kexec().

We would change the purgatory code that for s390 it returns to the
caller, if the checksum test fails. This *requires* that
s390_kdump_entry()->crash_kexec()->machine_kexec() is allowed to return.
Currently this is the case.

> Only thing which needs to be figured out is how to pass the address of
> crash_kexec() to stand alone tools and set registers/parameters 
> appropriately.

We could do this s390 specific (e.g. using meminfo). In this case this
would only be used for kernel/dump tools communication and not for
kernel/kernel communication. So I hope this should not be a problem for
you.

Then the design would look like the following:
* Define s390_kdump_entry in old kernel that calls crash_kexec()
* Use preallocated ELF core header
* s390_kdump_entry code path stores registers to ELF notes,  ...
* ... and finally jumps to purgatory code
* For s390 the purgatory code returns to caller in case of
  checksum failure
* dump tools call s390_kdump_entry with program check handler
  for error handling

I think, if we do it that way, we do not affect the current kdump
framework at all.

Is that acceptable for you? If yes, I would rework my patches
accordingly.

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
