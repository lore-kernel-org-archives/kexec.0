Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KLnxz-0000SC-8F
	for kexec@lists.infradead.org; Wed, 23 Jul 2008 23:41:55 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6NNfoSH018243
	for <kexec@lists.infradead.org>; Wed, 23 Jul 2008 19:41:50 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6NNfoXX165326
	for <kexec@lists.infradead.org>; Wed, 23 Jul 2008 17:41:50 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6NNfncg011889
	for <kexec@lists.infradead.org>; Wed, 23 Jul 2008 17:41:50 -0600
Subject: Re: [RFC] [KDUMP] [PROPOSED WORK] kdump on Xen hypervisor and
	guests, more tests for utilities, like makedumpfile, mkdumprd, kexec etc
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20080625.114653.534764946533767806.qcai@redhat.com>
References: <1214230370.4719.53.camel@subratamodak.linux.ibm.com>
	<20080624124243.GA16734@redhat.com>
	<20080625.114653.534764946533767806.qcai@redhat.com>
Date: Thu, 24 Jul 2008 05:11:31 +0530
Message-Id: <1216856493.5195.22.camel@subratamodak.linux.ibm.com>
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
Cc: poornima.nayak@in.ibm.com, ltp-list@lists.sourceforge.net, vapier@gentoo.org, iranna.ankad@in.ibm.com, kexec@lists.infradead.org, yamato@redhat.com, maknayak@in.ibm.com, risrajak@in.ibm.com, hbabu@us.ibm.com, sachinp@linux.vnet.ibm.com, pkirsch@suse.de, risrajak@linux.vnet.ibm.com, jburke@redhat.com, inddurai@in.ibm.com, vgoyal@redhat.com

Hi Cai,

Some patches in Bits and Pieces regarding this nearby ?

Regards--
Subrata

> 
> Yes. Initally, I put this item to a relative low priority, partly
> because kdump config options and init scripts are tend to be
> distro-specific, so it won't be easy to write portable tests for
> different distros. In addition, lots of config options are not easy to
> be tested automately, like raw disk target, vfat disk target, and
> network target etc, as testers have to setup those name manually. But,
> you are right, those are high priority tests for kexec/kdump in distro
> release, we tested most of those options manually for RHEL anyway and we
> had some automated tests of it, which I'll try to submit to LTP as many
> as possible. For those manual tests, I'll also try to find some ways to
> automate them. For example, for different dump targets, it is possible
> to verify the generated initrd file as expected.
> 
> > 
> > > == increase coverages for new kexec/kdump development efforts ==
> > > - new reserved region syntax in Kernel.
> > 
> > Another important thing we need to focus on is driver testing. Drivers
> > can fail to initialize in second kernel and kdump will fail. Can we do
> > something so that we can do following.
> >
> 
> That isn't something I have not thought of. For RHEL release testing, we
> will have a workflow to run those tests on any storage/network drivers,
> and it will report back testing results and driver matrix. However, this
> workflow is very distro-specific, and depends on the test farm it is
> using, so it does not make any sense to put it here.
> 
> > - Collect the machine statistics on which kdump was tested and send
> >   the reports to a common place. Especially capture the storage/network
> >   driver data which can be probably be available through LTP site.
> > 
> 
> That sounds like a good idea to me.
> 
> > - Also capture how much memory was reserved on what architecture and
> >   whether it worked or not. This will help us verify for sure that how
> >  much memory to reserve for second kernel on various architectures.
> >
> 
> This is something could be done. I'll have a look at it.
> 
> Thanks,
> CaiQian
> 
> > Thanks
> > Vivek


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
