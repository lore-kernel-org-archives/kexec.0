Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate4.uk.ibm.com ([194.196.100.164])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Qh5Ao-0006mH-RX
	for kexec@lists.infradead.org; Wed, 13 Jul 2011 19:32:44 +0000
Received: from d06nrmr1806.portsmouth.uk.ibm.com
	(d06nrmr1806.portsmouth.uk.ibm.com [9.149.39.193])
	by mtagate4.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p6DGkGip019388
	for <kexec@lists.infradead.org>; Wed, 13 Jul 2011 16:46:16 GMT
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
	[9.149.37.247])
	by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p6DGkGNo2474130
	for <kexec@lists.infradead.org>; Wed, 13 Jul 2011 17:46:16 +0100
Received: from d06av12.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av12.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p6DGkFfH005265
	for <kexec@lists.infradead.org>; Wed, 13 Jul 2011 10:46:15 -0600
Date: Wed, 13 Jul 2011 18:46:11 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 0/9] kdump: Patch series for s390 support
Message-ID: <20110713184611.6dcb09b4@mschwide>
In-Reply-To: <20110713160239.GE4426@redhat.com>
References: <20110704170922.976299676@linux.vnet.ibm.com>
	<20110705202615.GJ24348@redhat.com>
	<1309944287.3937.39.camel@br98xy6r>
	<20110707193321.GE28850@redhat.com>
	<20110708110121.5acfc3c9@mschwide>
	<20110711144255.GE30674@redhat.com>
	<20110711175626.121dcc58@mschwide>
	<20110713160239.GE4426@redhat.com>
Mime-Version: 1.0
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
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, horms@verge.net.au, ebiederm@xmission.com, Michael Holzheu <holzheu@linux.vnet.ibm.com>, kexec@lists.infradead.org

On Wed, 13 Jul 2011 12:02:39 -0400
Vivek Goyal <vgoyal@redhat.com> wrote:

> On Mon, Jul 11, 2011 at 05:56:26PM +0200, Martin Schwidefsky wrote:
> 
> [..]
> > > kexec-tools purgatory code already has the checksum logic. So you don't
> > > have to redo that in stand alone tools. I think you probably need to
> > > s390 specic purgatory and jump to IPLing stand alone kernel if kdump
> > > kernel is corrupted instead of rebooting back or spinning infinitely
> > > in the loop/
> > 
> > I can not quite follow you here. The purgatory code is part of the kdump kernel,
> > no? When we trigger a dump with the stand-alone tools we will start executing
> > code in the assembler function of that stand-alone tools. We can not trust
> > the kdump kernel yet, not without doing the checksums first.
> 
> Purgatory is another piece of binary code which is loaded along with kdump
> kernel in reserved memory area. So yes, there is a chance that this code
> itself get corrupted.

Yes, that is one of the possible failure scenarios.
 
> So in case of stand alone dump, you save the calculated checksum of
> kdump kernel at disk and not in memory? And then calculate the checksum
> of memory image of kdump kernel and decide whether kdump kenrel is 
> corrupted or not?
> 
> If yes, this sounds more reliable as checksum of kernel is stored on
> some disk/tape.

No, the checksum for the purgatory code is stored in memory. If the purgatory
code is corrupted you would have to corrupt the checksum in a very specific
way as well to make it fail. The likelihood for that to happen is very low,
but if it does we still have a fallback plan: before we branch to the
purgatory code we invalidate the checksum. If the purgatory code has been
corrupt although the checksum told us that it is fine the machine will crash
again. If we then start the stand-alone dump tool again it will create a
full dump. But mind you that second IPL of the stand-alone dump tool is only
required for a very, very rare case.

> [..]
> > > Ok. So again why not reuse the checksump capability of kexec-tools and
> > > instead of infinite looping you can jump to stand alone tools + IPL etc.
> > > I understand this will require a tighter integration with kexec-tools
> > > and using ELF header mechanism and will not cover the early kernel
> > > crashes.
> > 
> > Imho the checksum of kexec-tools is in the wrong place.
> 
> Because you think that stored checksum can get corrupted?

No, what I meant is that the code that verifies the checksum has to be part
of the stand-alone dump tool and not the purgatory code.

> [..]
> > > To me we seem to be diverging a lot from existing kdump+kexec-tools
> > > mechanism just to solve the case of early crash dumping. If we break
> > > down the problem in two parts and do thing kexec-tools way (with a
> > > backup path of booting stand alone kernel if kdump kenrel is corrupted),
> > > things might be better.
> > 
> > The "backup path of booting stand alone kernel" would result in passing
> > the control twice, once from the stand-alone dumper to the kexec purgatory
> > (after the purgatory checksum has been verified), then doing more checks 
> > in the kdump kernel, only to return to the stand-alone dumper if some check
> > fails. Does not really sound enticing to me.
> 
> What I am suggesting is that stand alone dumper gets control only if
> kdump kernel is corrupted.
> 
> So following sequence.
> 
> Kernel Crash ---> purgatory --> either kdump kenrel/IPL stand alone tools
> 
> Here only drawback seems to be that we assume that purgatory code and
> pre-calculated checksum has not been corrupted. The big advantage is
> that s390 kdump support looks very similar to other arches and
> understaning and supporting kdump across architectures becomes easy.

My problem with that is the following: how do we get from the "Kernel Crash"
step to the purgatory code? It does work for "normal" panics, but it fails
miserably for a hard crash that does not even get as far as panic. That is
why we insist on a possible second order of things:

Kernel Crash --> IPL of stand-alone dump tool --> branch to kdump if the
checksums turn out ok. 

If the kernel called panic itself and branched to the purgatory code but the
checksum turned out to be bad we just stop there. Then the operator has to
do a manual IPL of the stand-alone dump tool to get the dump.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
