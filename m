Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KBLyG-0006At-Lo
	for kexec@lists.infradead.org; Wed, 25 Jun 2008 03:47:01 +0000
Date: Wed, 25 Jun 2008 11:46:53 +0800 (CST)
Message-Id: <20080625.114653.534764946533767806.qcai@redhat.com>
Subject: Re: [RFC] [KDUMP] [PROPOSED WORK] kdump on Xen hypervisor and
	guests, more tests for utilities, like makedumpfile, mkdumprd, kexec etc
From: Cai Qian <qcai@redhat.com>
In-Reply-To: <20080624124243.GA16734@redhat.com>
References: <1214230370.4719.53.camel@subratamodak.linux.ibm.com>
	<20080624124243.GA16734@redhat.com>
Mime-Version: 1.0
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
To: ltp-list@lists.sourceforge.net
Cc: poornima.nayak@in.ibm.com, sachinp@linux.vnet.ibm.com, vapier@gentoo.org, iranna.ankad@in.ibm.com, qcai@redhat.com, kexec@lists.infradead.org, yamato@redhat.com, maknayak@in.ibm.com, risrajak@in.ibm.com, hbabu@us.ibm.com, pkirsch@suse.de, risrajak@linux.vnet.ibm.com, jburke@redhat.com, subrata@linux.vnet.ibm.com, inddurai@in.ibm.com, vgoyal@redhat.com

Hi,

From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC] [KDUMP] [PROPOSED WORK] kdump on Xen hypervisor and guests, more tests for utilities, like makedumpfile, mkdumprd, kexec etc
Date: Tue, 24 Jun 2008 08:42:43 -0400

> On Mon, Jun 23, 2008 at 07:42:50PM +0530, Subrata Modak wrote:
> > Hi,
> > 
> > Cai has proposed to work on the above LTP-KDUMP test cases
> > enrichment/enhancements. Please let us know about your views on the
> > same. We encourage people to review his proposal and the corresponding
> > upcoming test cases. I am going to put this soon on the LTP-KDUMP plan
> > document.
> > 
> > http://ltp.cvs.sourceforge.net/ltp/ltp/testcases/kdump/doc/TEST_PLAN.txt,
> > 
> 
> Hi Subrata/Cai,
> 
> That's a very good idea. We need to increase kdump test coverage and 
> automate the whole thing.
> 
> > ..................................
> > 
> > Here is my first draft plan of Kexec/Kdump tests enhancement sorted by
> > priorities. I would like to add them as many as possible.
> > 
> > == filtered vmcore utilities ==
> > - in different compressed levels, verify the vmcore with the correct
> >   layout. 
> > - verify it in flat file or ELF formats from a network host.
> > 
> > == analyse vmcore utilities ==
> > - GDB
> > - crash with better error detecting.
> > - crash to analyse Hypervisor and Dom0 Kernel.
> > 
> > == test scripts ==
> > - timestamp information for crash was triggered, vmcore was generated,
> >   and vmcore was verified.
> > - aim to 100% automation, and reduce manual setup.
> > - tidy up scripts.
> > 
> > == crash scenarios ==
> > - SDINT switch for ia64 if possible.
> > - Hypervisor crash for Virtualization.
> > - crashes on full- and para-virt guests.
> > 
> > == fix bugs in existing tests ==
> > - printk LKDTM module can hang the second Kernel.
> > 
> > == kdump configurations and init script ==
> > - capture vmcore after init runs.
> > - rpm pre- and post-scripts
> > - kdump_pre and kdump_post directives
> > 
> 
> Can we boost the priority of this item. Making sure all the
> kdump config options are working as stated. This is the interface
> a kdump user first sees and if it does not work, then it leaves a very
> bad impression.

Yes. Initally, I put this item to a relative low priority, partly
because kdump config options and init scripts are tend to be
distro-specific, so it won't be easy to write portable tests for
different distros. In addition, lots of config options are not easy to
be tested automately, like raw disk target, vfat disk target, and
network target etc, as testers have to setup those name manually. But,
you are right, those are high priority tests for kexec/kdump in distro
release, we tested most of those options manually for RHEL anyway and we
had some automated tests of it, which I'll try to submit to LTP as many
as possible. For those manual tests, I'll also try to find some ways to
automate them. For example, for different dump targets, it is possible
to verify the generated initrd file as expected.

> 
> > == increase coverages for new kexec/kdump development efforts ==
> > - new reserved region syntax in Kernel.
> 
> Another important thing we need to focus on is driver testing. Drivers
> can fail to initialize in second kernel and kdump will fail. Can we do
> something so that we can do following.
>

That isn't something I have not thought of. For RHEL release testing, we
will have a workflow to run those tests on any storage/network drivers,
and it will report back testing results and driver matrix. However, this
workflow is very distro-specific, and depends on the test farm it is
using, so it does not make any sense to put it here.
 
> - Collect the machine statistics on which kdump was tested and send
>   the reports to a common place. Especially capture the storage/network
>   driver data which can be probably be available through LTP site.
> 

That sounds like a good idea to me.

> - Also capture how much memory was reserved on what architecture and
>   whether it worked or not. This will help us verify for sure that how
>  much memory to reserve for second kernel on various architectures.
>

This is something could be done. I'll have a look at it.

Thanks,
CaiQian
 
> Thanks
> Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
