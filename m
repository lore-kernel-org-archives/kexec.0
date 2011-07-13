Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1Qh5bN-0006xp-Rh
	for kexec@lists.infradead.org; Wed, 13 Jul 2011 20:00:10 +0000
Date: Wed, 13 Jul 2011 16:00:04 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [patch 0/9] kdump: Patch series for s390 support
Message-ID: <20110713200004.GG4426@redhat.com>
References: <20110704170922.976299676@linux.vnet.ibm.com>
	<20110705202615.GJ24348@redhat.com>
	<1309944287.3937.39.camel@br98xy6r>
	<20110707193321.GE28850@redhat.com>
	<20110708110121.5acfc3c9@mschwide>
	<20110711144255.GE30674@redhat.com>
	<20110711175626.121dcc58@mschwide>
	<20110713160239.GE4426@redhat.com>
	<20110713184611.6dcb09b4@mschwide>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110713184611.6dcb09b4@mschwide>
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
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, horms@verge.net.au, ebiederm@xmission.com, Michael Holzheu <holzheu@linux.vnet.ibm.com>, kexec@lists.infradead.org

On Wed, Jul 13, 2011 at 06:46:11PM +0200, Martin Schwidefsky wrote:

[..]
> > What I am suggesting is that stand alone dumper gets control only if
> > kdump kernel is corrupted.
> > 
> > So following sequence.
> > 
> > Kernel Crash ---> purgatory --> either kdump kenrel/IPL stand alone tools
> > 
> > Here only drawback seems to be that we assume that purgatory code and
> > pre-calculated checksum has not been corrupted. The big advantage is
> > that s390 kdump support looks very similar to other arches and
> > understaning and supporting kdump across architectures becomes easy.
> 
> My problem with that is the following: how do we get from the "Kernel Crash"
> step to the purgatory code? It does work for "normal" panics, but it fails
> miserably for a hard crash that does not even get as far as panic. That is
> why we insist on a possible second order of things:

What is hard crash? How does that happen and what does x86 and s390
do in that case?

Though I don't have details but your argument seems to be that in s390
we are always guranteed that we will jump to IPLing the stand alone
tools code irresepective of the system state hence it is relatively
safer to do checks in stand alone tools instead of purgatory where
code is in memory.

If due to hard hang, code can not even make to purgatory, where would
it go? Can't we do IPLing of stand alone tool then. 

So we first try to take purgatory path which does the checksum and is
consistent with other architectures. If that does not work in case
of hard hang, you always have the option of IPLing the stand alone tool
later manually.

This will also get rid of requirement passing all the segment and cheksum
info to stand alone tool with the help of meminfo (That's another sore
point). 

Bottom line, even if you can't make to purgatory reliably, you always
have the option of capturing dump manually using stand alone tools. We
don't have to mix up kdump and stand alone mechanism. If kdump fails, we
just need to have capability to still capture the dump using stand alone
tools manually. I think that will make things simpler even for stand alone
tools.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
