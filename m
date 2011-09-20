Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate3.uk.ibm.com ([194.196.100.163])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R5wFW-0001HD-Jy
	for kexec@lists.infradead.org; Tue, 20 Sep 2011 09:04:20 +0000
Received: from d06nrmr1806.portsmouth.uk.ibm.com
	(d06nrmr1806.portsmouth.uk.ibm.com [9.149.39.193])
	by mtagate3.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p8K94B5a015631
	for <kexec@lists.infradead.org>; Tue, 20 Sep 2011 09:04:11 GMT
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
	[9.149.37.247])
	by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p8K94B3r2666724
	for <kexec@lists.infradead.org>; Tue, 20 Sep 2011 10:04:11 +0100
Received: from d06av12.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av12.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p8K94AZb002498
	for <kexec@lists.infradead.org>; Tue, 20 Sep 2011 03:04:11 -0600
Subject: Re: [patch 1/2] kdump: Initialize vmcoreinfo note at startup
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
In-Reply-To: <20110919183656.GC3373@redhat.com>
References: <20110909102659.320220628@linux.vnet.ibm.com>
	<20110909102732.497569031@linux.vnet.ibm.com>
	<20110915184637.GF32658@redhat.com> <1316161277.3507.8.camel@br98xy6r>
	<20110919183656.GC3373@redhat.com>
Date: Tue, 20 Sep 2011 11:04:10 +0200
Message-ID: <1316509450.2793.32.camel@br98xy6r>
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
Cc: linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org

Hello Vivek,

On Mon, 2011-09-19 at 14:36 -0400, Vivek Goyal wrote:
> On Fri, Sep 16, 2011 at 10:21:17AM +0200, Michael Holzheu wrote:
> > > Curious that how these two dump schemes make use vmcoreinfo data?
> > 
> > We have a tool named zgetdump. With this tool it is possible to convert
> > dump formats on the fly using fuse. E.g. you can mount a s390
> > stand-alone dump as ELF dump. When this is done, the tool finds the
> > vmcoreinfo in the stand-alone dump via our well known ABI defined
> > address and it creates the respective VMCOREINFO ELF note in the output
> > ELF dump. This then can be used e.g. by makedumpfile for dump filtering.
> > No more need for a vmlinux file with debug information.
> 
> Ok, so you basically need it so that makedumpfile can do filtering without
> debug info.
> 
> Well, if zgetdump is doing everything and you are stashing away an arch
> specific pointer, I guss you could have saved pointer directly to
> vmcoreinfo_data and then zgetdump could have made an ELF note out of it
> for use of makedumpfile.

Yes that would also be an option. But still you have to initialize the
data at startup.

> But anyway, having kernel exported the note does not harm.

Correct.

> > So this will look like the following:
> > 
> > # zgetdump --mount standalone.dump -f elf /mnt
> > # ls /mnt
> > # dump.elf
> > # readelf -n /mnt/dump.elf
> > # ...
> >   VMCOREINFO		0x00000474	Unknown note type: (0x00000000)
> > # makedumpfile -c -d 31 /mnt/dump.elf dump.kdump
> 
> If you can do this easily, then you really did not need kdump in kernel? 
> Just use stand alone dump to take dump and then do this to filter dump.

For large systems we still need kdump to do the the filtering while
dumping. Currently with stand-alone dump tools we first have to dump all
the memory (which takes a long time) and afterwards do the filtering.

And with kdump we just can reuse all the installer stuff that is already
available.

> But what happens to ELF headers which map kernel virtual address to
> physical addresses? kexec-tools prepares those. So in this case when
> you are capturing the dump, who prepares those? IOW, how does zgetdump
> creates a mapping between kernel virtual and physical addresses?

On s390 we have a 1:1 mapping for the kernel. For the ELF header loads
created by zgetdump virtual=real.

I hope this answers your questions.

So do you agree now with the patch and give us your ACK?

Thanks
Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
