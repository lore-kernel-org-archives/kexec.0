Return-path: <kexec-bounces@lists.infradead.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IbrYE-00033C-HS
	for kexec@lists.infradead.org; Sun, 30 Sep 2007 06:41:15 +0100
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8U5buCx017809
	for <kexec@lists.infradead.org>; Sun, 30 Sep 2007 01:37:56 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8U5brXc695674
	for <kexec@lists.infradead.org>; Sun, 30 Sep 2007 01:37:56 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8U5brtZ028243
	for <kexec@lists.infradead.org>; Sun, 30 Sep 2007 01:37:53 -0400
Date: Sun, 30 Sep 2007 11:08:14 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [Kgdb-bugreport] Problem getting kgdb to read kernel symbols.
	addresses shifted?
Message-ID: <20070930053813.GC16593@in.ibm.com>
References: <sjmabr8j6d7.fsf@pgpdev.ihtfp.org> <46FD03CD.9060404@windriver.com>
	<sjmve9uj3d2.fsf@pgpdev.ihtfp.org> <46FD1B6A.3000500@windriver.com>
	<20070928114522.n0cdrcebykkgg408@webmail.mit.edu>
	<46FD2CFB.9010404@windriver.com> <46FD75E1.3090602@bluelane.com>
	<m18x6qbfip.fsf@ebiederm.dsl.xmission.com>
	<sjm641uid1x.fsf@pgpdev.ihtfp.org>
	<m11wcibbpq.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m11wcibbpq.fsf@ebiederm.dsl.xmission.com>
Reply-To: vgoyal@in.ibm.com
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
Errors-To: kexec-bounces@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Derek Atkins <warlord@MIT.EDU>, kgdb-bugreport@lists.sourceforge.net, Kexec Mailing List <kexec@lists.infradead.org>, Dave Anderson <anderson@redhat.com>, Jason Wessel <jason.wessel@windriver.com>, pete@bluelane.com

On Fri, Sep 28, 2007 at 05:40:33PM -0600, Eric W. Biederman wrote:
> Derek Atkins <warlord@MIT.EDU> writes:
> 
> > Well, gdb agrees with System.map, so I'm sure that gdb itself is
> > okay.  It's certainly possible that that the kgdb stub is weird,
> > but /proc/kallsyms doesn't match System.map, and THAT'S what's
> > confusing me most of all.
> 
> Ok.  So we must have a relocatable kernel that figures it has been
> relocated.  Interesting.  
> 
> What is your bootloader?
> What is your kernel version?
> What is your kernel config?
> 
> The only time I would expect to see what you are seeing is if
> you are debugging the kdump kernel, which doesn't sound like
> the case.
> 
> If we actually have a truly offset kernel then while things
> may not be perfect this is at least expected.  I don't think
> I have heard of anyone handling this case very well.
> 

Hi Eric and others,

I think we might be running into the issues because i386, FC7 relocatable
kernel has been compiled for 16MB physical address but effectively it
runs at 4MB physical address. So kernel does not run at compiled address
and any kind of debugging tools reading symbol address from System.map
or rom vmlinux will fail as run time symbol addresses are different.

/proc/kallsyms should help though. This is one problem with shift in run
time virtual address while relocating the kernel. We should be running kernel
at compiled address to be able to debug it. Or enable any tools to parse
/proc/kallsyms to read the shift in symbol addresses and adjust accordingly.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
