Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga11.intel.com ([192.55.52.93])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IPXvC-0000lC-3d
	for kexec@lists.infradead.org; Mon, 27 Aug 2007 02:18:02 -0400
Subject: Re: [RFC][PATCH 0/2 -mm] kexec based hibernation
From: "Huang, Ying" <ying.huang@intel.com>
In-Reply-To: <20070827050027.GB9809@in.ibm.com>
References: <1188177245.3247.36.camel@caritas-dev.intel.com>
	<20070827050027.GB9809@in.ibm.com>
Date: Mon, 27 Aug 2007 14:18:49 +0800
Message-Id: <1188195529.3247.82.camel@caritas-dev.intel.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: vgoyal@in.ibm.com
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

On Mon, 2007-08-27 at 10:30 +0530, Vivek Goyal wrote:
> On Mon, Aug 27, 2007 at 09:14:05AM +0800, Huang, Ying wrote:
> > Kexec base hibernation has some potential advantages over uswsusp and
> > TuxOnIce (suspend2). Some most obvious advantages are:
> > 
> > 1. The hibernation image size can exceed half of memory size easily.
> > 
> > 2. The hibernation image can be written to and read from almost
> >    anywhere, such as USB disk, NFS.
> > 
> > 3. It is possible to eliminate freezer from kexec based hibernation
> >    implementation.
> > 
> > 4. Based on kexec/kdump implementation, the kernel code needed is
> >    less.
> > 
> > 
> > This patch set implements a prototype of kexec based hibernation. The
> > kernel functionalities added are as follow:
> > 
> > 1. Jumping from kexeced kernel back to original kernel. This is used
> >    by hibernation to save/load necessary state in original kernel and
> >    jumping back to original kernel after restore the memory of
> >    original kernel.
> > 
> > 2. Add writing support to /dev/oldmem. This is used by hibernation to
> >    restore the memory of original kernel.
> > 
> > 
> > The hibernation process with the patch set is as follow:
> > 
> > 1. Boot a kernel A
> > 
> > 2. Work under kernel A
> > 
> > 3. Kexec another kernel B (crash dump enabled) in kernel A.
> > 
> > 4. Save the memory image of kernel A through crash dump (such as "cp
> >    /proc/vmcore ~"). Save the "jump buffer pfn".
> > 
> > 5. Shutdown or reboot
> > 
> > 
> > The restore process with the patch set is as follow:
> > 
> > 1. Boot a kernel C
> > 
> > 2. Kexec another kernel D (crash dump enabled) in kernel C. The memory
> >    area used by kernel D must be a subset of memory area used by
> >    kernel B.
> > 
> 
> If one compiles the kernel C to boot from reserved memory area (subset
> of memory area used by kernel B), then I can skip the step of kexecing
> from C to D? (COFIG_PHYSICAL_START)

Yes. I think so.

> Alternatively, can we give hint to kernel C to run from a specified address
> at run time with the help of command line parameters. What I mean boot-loader
> can load the kernel at any address, but kernel will move itself to run
> from a different location depending on command line parameter.  For example,
> let say kernel_run_addr = 0x1000000. This parameter will tell the kernel
> to move itself to 16MB address and run from there. I think it can be made
> to work with little work in existing setup of relocatable kernel.
> 
> Kernel run address can be put by some user space script which will save
> the hibernated image of original kernel. So after saving the /proc/vmcore,
> script can modify the boot loader config file to append the right
> command line to the kernel (kernel_run_addr).
> 
> After hibernation, user will shutdown/reboot. Next time the kernel boots
> it will load at 16MB addr (because of kernel_run_addr) and then it can
> restore the previously saved image.
> 
> We shall have to get rid of (kernel_run_addr) parameter from command
> line while resuming. One can restore the image (krestore) and then edit
> the boot loader config file to get rid of command line param, kernel_run_addr.
> 
> In this scheme, with the help of relocatable kernel, we can use a single
> kernel for everything. (A, B, C, D). We will also avoid additional kexec
> from kernel C to kernel D.
> 
> I think in the long run we shall have to work out so that a user does
> not have to maintain multiple kernels. 

Only one relocatable kernel image is needed. In fact, I use one
relocatable kernel image in testing during development.

> Does this make sense?

Yes, this is a sensible optimization. But I think it may be better to
make bootloader load kernel D directly into a specified memory location.
For example, we can add a option to "kernel" command of grub. 

And, I think we can do more in bootloader. Such as we can prepare two
kernel command line for one grub menu item, one for normal kernel, the
other for restore kernel. After hibernating successfully, the effective
kernel command line is switched.

Best Regards,
Huang Ying

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
