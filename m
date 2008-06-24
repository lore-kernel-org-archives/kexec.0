Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KB7sG-00050j-AK
	for kexec@lists.infradead.org; Tue, 24 Jun 2008 12:43:52 +0000
Date: Tue, 24 Jun 2008 08:42:43 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC] [KDUMP] [PROPOSED WORK] kdump on Xen hypervisor and
	guests, more tests for utilities, like makedumpfile, mkdumprd,
	kexec etc
Message-ID: <20080624124243.GA16734@redhat.com>
References: <1214230370.4719.53.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1214230370.4719.53.camel@subratamodak.linux.ibm.com>
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: "poornima.nayak" <poornima.nayak@in.ibm.com>, ltp-list <ltp-list@lists.sourceforge.net>, Mike Frysinger <vapier@gentoo.org>, "iranna.ankad" <iranna.ankad@in.ibm.com>, Cai Qian <qcai@redhat.com>, kexec@lists.infradead.org, Masatake YAMATO <yamato@redhat.com>, maknayak <maknayak@in.ibm.com>, risrajak <risrajak@in.ibm.com>, hbabu@us.ibm.com, sachinp <sachinp@linux.vnet.ibm.com>, Patrick Kirsch <pkirsch@suse.de>, Jeff Burke <jburke@redhat.com>, inddurai <inddurai@in.ibm.com>, risrajak <risrajak@linux.vnet.ibm.com>

On Mon, Jun 23, 2008 at 07:42:50PM +0530, Subrata Modak wrote:
> Hi,
> 
> Cai has proposed to work on the above LTP-KDUMP test cases
> enrichment/enhancements. Please let us know about your views on the
> same. We encourage people to review his proposal and the corresponding
> upcoming test cases. I am going to put this soon on the LTP-KDUMP plan
> document.
> 
> http://ltp.cvs.sourceforge.net/ltp/ltp/testcases/kdump/doc/TEST_PLAN.txt,
> 

Hi Subrata/Cai,

That's a very good idea. We need to increase kdump test coverage and 
automate the whole thing.

> ..................................
> 
> Here is my first draft plan of Kexec/Kdump tests enhancement sorted by
> priorities. I would like to add them as many as possible.
> 
> == filtered vmcore utilities ==
> - in different compressed levels, verify the vmcore with the correct
>   layout. 
> - verify it in flat file or ELF formats from a network host.
> 
> == analyse vmcore utilities ==
> - GDB
> - crash with better error detecting.
> - crash to analyse Hypervisor and Dom0 Kernel.
> 
> == test scripts ==
> - timestamp information for crash was triggered, vmcore was generated,
>   and vmcore was verified.
> - aim to 100% automation, and reduce manual setup.
> - tidy up scripts.
> 
> == crash scenarios ==
> - SDINT switch for ia64 if possible.
> - Hypervisor crash for Virtualization.
> - crashes on full- and para-virt guests.
> 
> == fix bugs in existing tests ==
> - printk LKDTM module can hang the second Kernel.
> 
> == kdump configurations and init script ==
> - capture vmcore after init runs.
> - rpm pre- and post-scripts
> - kdump_pre and kdump_post directives
> 

Can we boost the priority of this item. Making sure all the
kdump config options are working as stated. This is the interface
a kdump user first sees and if it does not work, then it leaves a very
bad impression.

> == increase coverages for new kexec/kdump development efforts ==
> - new reserved region syntax in Kernel.

Another important thing we need to focus on is driver testing. Drivers
can fail to initialize in second kernel and kdump will fail. Can we do
something so that we can do following.

- Collect the machine statistics on which kdump was tested and send
  the reports to a common place. Especially capture the storage/network
  driver data which can be probably be available through LTP site.

- Also capture how much memory was reserved on what architecture and
  whether it worked or not. This will help us verify for sure that how
 much memory to reserve for second kernel on various architectures.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
