Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e28smtp02.in.ibm.com ([122.248.162.2])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QQ0MF-0005J0-7w
	for kexec@lists.infradead.org; Fri, 27 May 2011 16:57:57 +0000
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp02.in.ibm.com (8.14.4/8.13.1) with ESMTP id p4RGvjWd009806
	for <kexec@lists.infradead.org>; Fri, 27 May 2011 22:27:45 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p4RGvjHt4354052
	for <kexec@lists.infradead.org>; Fri, 27 May 2011 22:27:45 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p4RGvjVL000594
	for <kexec@lists.infradead.org>; Sat, 28 May 2011 02:57:45 +1000
Date: Fri, 27 May 2011 22:27:36 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [RFC Patch 5/6] slimdump: Capture slimdump for fatal MCE
	generated crashes
Message-ID: <20110527165736.GC2384@in.ibm.com>
References: <20110526170722.GB23266@in.ibm.com>
	<20110526172305.GA18295@in.ibm.com>
	<20110526174447.GC29496@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110526174447.GC29496@redhat.com>
Reply-To: prasad@linux.vnet.ibm.com
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
Cc: "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, anderson@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>

On Thu, May 26, 2011 at 01:44:47PM -0400, Vivek Goyal wrote:
> On Thu, May 26, 2011 at 10:53:05PM +0530, K.Prasad wrote:
> > 
> > slimdump: Capture slimdump for fatal MCE generated crashes
> > 
> > System crashes resulting from fatal hardware errors (such as MCE) don't need
> > all the contents from crashing-kernel's memory. Generate a new 'slimdump' that
> > retains only essential information while discarding the old memory.
> > 
> 
> Why to enforce zeroing out of rest of the vmcore data in kernel. Why not
> leave it to user space. 
> 

Our concern comes from the fact that it is unsafe for the OS to read
any part of the corrupt memory region, so the kernel does not have to make
that address space available for read/write.

> As Andi said, you anyway will require disabling MCE temporarily in second
> kernel. So that should allay the concern that we might run into second
> MCE while trying to read the vmcore.
> 

The processor manuals don't define the behaviour for a read operation
upon a corrupt memory location. So the consequences for a read after
disabling MCE is unknown (as I've mentioned here:
https://lkml.org/lkml/2011/5/27/258). 

> A user might want to extract just the dmesg buffers also after MCE from
> vmcore.
>
> What I am saying is that this sounds more like a policy. Don't enforce
> it in kernel. Probably give user MCE registers as part of ELF note of
> vmcore. Now leave it up to user what data he wants to extract from vmcore.
> Just the MCE registers or something more then that.

I'm unsure, at the moment, as to what it actually entails to extract
dmesg buffers from the old kernel's memory; but given that there exists
a corrupt memory region with unknown consequences for read operations
upon it, I doubt if it is a safe idea to allow user-space application to
navigate through the kernel data-structures to extract the dmesg.

Alternatively, we might leave MCE enabled for the kdump kernel and
modify the user-space application to turn resilient to SIGBUS signal. So
if it reads a corrupt memory region, it will receive a signal from
do_machine_check() upon which it can skip that particular address and/or
fill it with zeroes (or somesuch). We haven't gone through the
details....but just some loud thinking

Thanks,
K.Prasad

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
