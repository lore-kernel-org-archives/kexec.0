Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KSn8S-0005we-Vk
	for kexec@lists.infradead.org; Tue, 12 Aug 2008 06:13:37 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7C6DZKK001406
	for <kexec@lists.infradead.org>; Tue, 12 Aug 2008 02:13:35 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7C6DZMH202866
	for <kexec@lists.infradead.org>; Tue, 12 Aug 2008 02:13:35 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7C6DYOK017039
	for <kexec@lists.infradead.org>; Tue, 12 Aug 2008 02:13:35 -0400
Subject: Re: [LTP] [RFC] [KDUMP] [PROPOSED WORK] kdump on Xen hypervisor
	and guests, more tests for utilities, like makedumpfile, mkdumprd,
	kexec etc
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20080812.101604.885631601452239140.qcai@redhat.com>
References: <20080625.114653.534764946533767806.qcai@redhat.com>
	<1216856493.5195.22.camel@subratamodak.linux.ibm.com>
	<1218461567.5010.76.camel@subratamodak.linux.ibm.com>
	<20080812.101604.885631601452239140.qcai@redhat.com>
Date: Tue, 12 Aug 2008 11:43:02 +0530
Message-Id: <1218521582.5132.8.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Reply-To: subrata@linux.vnet.ibm.com
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
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
To: Cai Qian <qcai@redhat.com>
Cc: poornima.nayak@in.ibm.com, ltp-list@lists.sourceforge.net, vapier@gentoo.org, iranna.ankad@in.ibm.com, kexec@lists.infradead.org, maknayak@in.ibm.com, risrajak@in.ibm.com, hbabu@us.ibm.com, sachinp@linux.vnet.ibm.com, jburke@redhat.com, inddurai@in.ibm.com, vgoyal@redhat.com

On Tue, 2008-08-12 at 10:16 +0800, Cai Qian wrote:
> Hi Subrata,
> 
> From: Subrata Modak <subrata@linux.vnet.ibm.com>
> Subject: Re: [LTP] [RFC] [KDUMP] [PROPOSED WORK] kdump on Xen hypervisor and guests, more tests for utilities, like makedumpfile, mkdumprd, kexec etc
> Date: Mon, 11 Aug 2008 19:02:47 +0530
> 
> > Cai,
> > 
> > Any headway in this front ?
> > 
> 
> I have all test cases finished, but I am working on implementing a
> suitable harness to run those tests.

Thanks Cai. Happy to know that you are done with all the test cases, and
only the integration part is pending. I am little bit confused when you
say that you are working on implementing a suitable harness to run those
tests. Does that mean that the way the present LTP-Kdump tests are run
is not suitable to accommodate the enhancements/additions that you are
doing to the LTP-Kdump ?

I do not mind in having a nice harness within LTP for executing the
LTP-Kdump tests, but i would hope that the new harness should also
include the existing LTP-Kdump tests, so that you use the same (new
harness) to tests everything in LTP-Kdump. Let me know what you think
for the same.

Regards--
Subrata

> 
> CaiQian
> 
> > Regards--
> > Subrata
> > 
> > On Thu, 2008-07-24 at 05:11 +0530, Subrata Modak wrote:
> > > Hi Cai,
> > > 
> > > Some patches in Bits and Pieces regarding this nearby ?
> > > 
> > > Regards--
> > > Subrata
> > > 
> > > > 
> > > > Yes. Initally, I put this item to a relative low priority, partly
> > > > because kdump config options and init scripts are tend to be
> > > > distro-specific, so it won't be easy to write portable tests for
> > > > different distros. In addition, lots of config options are not easy to
> > > > be tested automately, like raw disk target, vfat disk target, and
> > > > network target etc, as testers have to setup those name manually. But,
> > > > you are right, those are high priority tests for kexec/kdump in distro
> > > > release, we tested most of those options manually for RHEL anyway and we
> > > > had some automated tests of it, which I'll try to submit to LTP as many
> > > > as possible. For those manual tests, I'll also try to find some ways to
> > > > automate them. For example, for different dump targets, it is possible
> > > > to verify the generated initrd file as expected.
> > > > 
> > > > > 
> > > > > > == increase coverages for new kexec/kdump development efforts ==
> > > > > > - new reserved region syntax in Kernel.
> > > > > 
> > > > > Another important thing we need to focus on is driver testing. Drivers
> > > > > can fail to initialize in second kernel and kdump will fail. Can we do
> > > > > something so that we can do following.
> > > > >
> > > > 
> > > > That isn't something I have not thought of. For RHEL release testing, we
> > > > will have a workflow to run those tests on any storage/network drivers,
> > > > and it will report back testing results and driver matrix. However, this
> > > > workflow is very distro-specific, and depends on the test farm it is
> > > > using, so it does not make any sense to put it here.
> > > > 
> > > > > - Collect the machine statistics on which kdump was tested and send
> > > > >   the reports to a common place. Especially capture the storage/network
> > > > >   driver data which can be probably be available through LTP site.
> > > > > 
> > > > 
> > > > That sounds like a good idea to me.
> > > > 
> > > > > - Also capture how much memory was reserved on what architecture and
> > > > >   whether it worked or not. This will help us verify for sure that how
> > > > >  much memory to reserve for second kernel on various architectures.
> > > > >
> > > > 
> > > > This is something could be done. I'll have a look at it.
> > > > 
> > > > Thanks,
> > > > CaiQian
> > > > 
> > > > > Thanks
> > > > > Vivek
> > > 
> > > 
> > > -------------------------------------------------------------------------
> > > This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
> > > Build the coolest Linux based applications with Moblin SDK & win great prizes
> > > Grand prize is a trip for two to an Open Source event anywhere in the world
> > > http://moblin-contest.org/redirect.php?banner_id=100&url=/
> > > _______________________________________________
> > > Ltp-list mailing list
> > > Ltp-list@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/ltp-list
> > 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
