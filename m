Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate4.uk.ibm.com ([194.196.100.164])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QhjHF-0003pK-65
	for kexec@lists.infradead.org; Fri, 15 Jul 2011 14:22:02 +0000
Received: from d06nrmr1707.portsmouth.uk.ibm.com
	(d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate4.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p6FELwUt003139
	for <kexec@lists.infradead.org>; Fri, 15 Jul 2011 14:21:58 GMT
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
	[9.149.37.251])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p6FELwbj1892592
	for <kexec@lists.infradead.org>; Fri, 15 Jul 2011 15:21:58 +0100
Received: from d06av10.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av10.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p6FELwWf009706
	for <kexec@lists.infradead.org>; Fri, 15 Jul 2011 08:21:58 -0600
Subject: Re: [patch 0/9] kdump: Patch series for s390 support
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
In-Reply-To: <20110714180528.GF6672@redhat.com>
References: <1309944287.3937.39.camel@br98xy6r>
	<20110707193321.GE28850@redhat.com> <20110708110121.5acfc3c9@mschwide>
	<20110711144255.GE30674@redhat.com> <20110711175626.121dcc58@mschwide>
	<20110713160239.GE4426@redhat.com> <20110713184611.6dcb09b4@mschwide>
	<20110713200004.GG4426@redhat.com> <20110714091800.720da848@mschwide>
	<20110714175532.GE6672@redhat.com> <20110714180528.GF6672@redhat.com>
Date: Fri, 15 Jul 2011 16:21:57 +0200
Message-ID: <1310739717.10789.31.camel@br98xy6r>
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

On Thu, 2011-07-14 at 14:05 -0400, Vivek Goyal wrote:
> On Thu, Jul 14, 2011 at 01:55:32PM -0400, Vivek Goyal wrote:
> 
> [..]
> > > > So we first try to take purgatory path which does the checksum and is
> > > > consistent with other architectures. If that does not work in case
> > > > of hard hang, you always have the option of IPLing the stand alone tool
> > > > later manually.
> > > 
> > > How are we suddenly on the purgatory path again? The code that gets
> > > control in case of a hard crash + IPL is the stand-alone dump tool,
> > > not the purgatory code.
> > 
> > I think that's the biggest contetion point. From the start of discussion
> > you have this hardcoded requirement that the moment panic() happens
> > you are jumping to some IPL code and that's what I am questioning. Why
> > can't you execute some more code after panic() (purgatory), before
> > you jump to IPL code (only if you have to). 
> > 
> 
> In your parlance of shutdown actions, I think it is equivalnet to saying
> that "kdump" is a shutdown action and that that means is that for specific
> trigger points we will execute "crash_kexec()" function which will try
> to capture the dump.
> 
> In user space I think one can modify the kexec-tools infrastrucuture a
> bit so that one is able to define an entry point in case checksum of
> loaded segment failes. Once you are loding kdump kernel, you can define
> that entry point. (And this would be jump to IPL etc.).

You mean to jump back into the crashed kernel code in case the kdump
checksum failed?

In the meantime I was looking a bit more into the kexec code to find
out, what we would have to do, if we use the preallocated ELF header as
you want us to do. With our actual solution, we do not have to reserve
any special areas for the kdump kernel. Now we have to reserve the ELF
header. So what are the options?

The x86 implementation uses a kernel parameter "memmap=exactmap" to do
that.

On ia64 - if I understood the code correctly - they seem to pass a kdump
segment "EFI_memmap" to the kdump kernel that contains information about
all loaded kexec segments. With this segment they can find out the size
of the ELF header segment in the kdump kernel and then do the memory
reservation at boot time. Is that correct?

Michael



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
