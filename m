Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate2.uk.ibm.com ([194.196.100.162])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QeOLw-0006Ej-Cq
	for kexec@lists.infradead.org; Wed, 06 Jul 2011 09:25:05 +0000
Received: from d06nrmr1507.portsmouth.uk.ibm.com
	(d06nrmr1507.portsmouth.uk.ibm.com [9.149.38.233])
	by mtagate2.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p669OuPU017933
	for <kexec@lists.infradead.org>; Wed, 6 Jul 2011 09:24:56 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1507.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p669OrCe1597472
	for <kexec@lists.infradead.org>; Wed, 6 Jul 2011 10:24:55 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p669Oqtf026560
	for <kexec@lists.infradead.org>; Wed, 6 Jul 2011 03:24:52 -0600
Subject: Re: [patch 0/9] kdump: Patch series for s390 support
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
In-Reply-To: <20110705202615.GJ24348@redhat.com>
References: <20110704170922.976299676@linux.vnet.ibm.com>
	<20110705202615.GJ24348@redhat.com>
Date: Wed, 06 Jul 2011 11:24:47 +0200
Message-ID: <1309944287.3937.39.camel@br98xy6r>
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
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, horms@verge.net.au, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org

Hello Vivec,

On Tue, 2011-07-05 at 16:26 -0400, Vivek Goyal wrote:
> On Mon, Jul 04, 2011 at 07:09:22PM +0200, Michael Holzheu wrote:

[snip]

> I don't understand what is stand-alone dump tools and 

S390 stand-alone dump tools are independent mini operating systems that
are installed on disks or tapes. When a dump should be created, these
stand-alone dump tools are booted. All that they do is to write the dump
(current memory plus the CPU registers) to the disk/tape device.

The advantage compared to kdump is that since they are freshly loaded
into memory they can't be overwritten in memory. Another advantage is
that since it is different code, it is much less likely that the dump
tool will run into the same problem than the previously crashed kernel.
Also the boot process ensures that the hardware is in a initialized
state. And last but not least, with the stand-alone dump tools you can
dump early kernel problems which is not possible using kdump, because
you can't dump before the kdump kernel has been loaded with kexec.

That were more or less the arguments, why we did not support kdump in
the past.

In order to increase dump reliability with kdump, we now implemented a
two stage approach. The stand-alone dump tools first check via meminfo,
if kdump is valid using checksums. If kdump is loaded and healthy it is
started. Otherwise the stand-alone dump tools create a full-blown
stand-alone dump.

With this approach we still keep our s390 dump reliability and gain the
great kdump features, e.g. distributor installer support, dump filtering
with makedumpfile, etc.

> why the existing
> mechanism of preparing ELF headers to describe all the above info
> and just passing the address of header on kernel commnad line
> (crashkernel=) will not work for s390. Introducing an entirely new
> infrastructure for communicating the same information does not
> sound too exciting.

We need the meminfo interface anyway for the two stage approach. The
stand-alone dump tools have to find and verify the kdump kernel in order
to start it. Therefore the interface is there and can be used. Also
creating the ELF header in the 2nd kernel is more flexible and easier
IMHO:
* You do not have to care about memory or CPU hotplug.
* You do not have to preallocate CPU crash notes etc.
* It works independently from the tool/mechanism that loads the kdump
kernel into memory. E.g. we have the idea to load the kdump kernel at
boot time into the crashkernel memory (not via the kexec_load system
call). That would solve the main kdump problems: The kdump kernel can't
be overwritten by I/O and also early kernel problems could then be
dumped using kdump.

What do you think?

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
