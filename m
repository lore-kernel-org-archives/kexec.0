Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate7.uk.ibm.com ([194.196.100.167])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RJUTx-0005eY-1h
	for kexec@lists.infradead.org; Thu, 27 Oct 2011 18:15:14 +0000
Received: from d06nrmr1507.portsmouth.uk.ibm.com
	(d06nrmr1507.portsmouth.uk.ibm.com [9.149.38.233])
	by mtagate7.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p9RIF40q028268
	for <kexec@lists.infradead.org>; Thu, 27 Oct 2011 18:15:04 GMT
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
	[9.149.37.250])
	by d06nrmr1507.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p9RIF3Xf2113658
	for <kexec@lists.infradead.org>; Thu, 27 Oct 2011 19:15:04 +0100
Received: from d06av09.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av09.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p9RIF39W009191
	for <kexec@lists.infradead.org>; Thu, 27 Oct 2011 12:15:03 -0600
Message-ID: <1319739303.2830.18.camel@br98xy6r>
Subject: Re: kdump: A memory hotplug issue on s390
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Thu, 27 Oct 2011 20:15:03 +0200
In-Reply-To: <20111027172822.GI7491@redhat.com>
References: <1319563037.3056.30.camel@br98xy6r>
	<20111026223126.GA9754@verge.net.au> <20111027172822.GI7491@redhat.com>
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
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

Hello Vivek,

On Thu, 2011-10-27 at 13:28 -0400, Vivek Goyal wrote:
> On Thu, Oct 27, 2011 at 07:31:26AM +0900, Simon Horman wrote:
> > On Tue, Oct 25, 2011 at 07:17:17PM +0200, Michael Holzheu wrote:
> > > Hello Simon and Vivek,
> > > 
> > > For s390 we currently use /proc/iomem for defining the memory layout in
> > > the kexec elfcore header. Unfortunately this is not correct, when using
> > > memory hotplug. When a memory chunk is set offline (e.g. with "echo
> > > offline > /sys/devices/system/memory/memoryX/state") this is not
> > > reflected in /proc/iomem.
> > > 
> > > To fix this I could parse /sys/devices/system/memory and exclude each
> > > memory chunk that in not online from the /proc/iomem info. Do you think
> > > that this approach is fine or is there a better solution?
> > 
> > Hi Michael,
> > 
> > that sounds like a reasonable approach to me.
> > IIRC, kexec xen on ia64 makes use of an alternate iomem file,
> > and this seems to be another example of /proc/iomem not being
> > the right source of information.
> 
> Secondly we should do this only for kdump and not for kexec. If some
> memory is offlined, then we still want to use it in case of kexec.

I don't think so. At least on s390 we can't use it for kexec. If memory
is set offline, it is gone (given back to the hypervisor) and can't be
used any more before it is set to online again.

> What's the meaning of various entries. I see lots of memory[1-n] entries
> in my system and under memory0/ dir I see following.
> 
> [memory0]# grep ".*" *
> end_phys_index:00000000
> phys_device:0
> phys_index:00000000

> removable:0

This means that it is not removable, e.g. because not movable kernel
structures are located in this chunk.

> state:online

It is online.

> What does it mean. Is memory0 representing a chunk of physical memory?
> If yes, then where does the segment start and where does it end. Everything
> seems to be zero.
> So is it representing chunk0 of memory. So both starting and end index
> are 0. But where is the chunk size mentioned?

The file "/sys/devices/system/memory/block_size_bytes" tells you how big
each memory chunk is (in hex).

Assume block_size_bytes is 0x10000000 (256MiB). Then "memory0"
represents the memory from 0x0-0x10000000, "memory1" represents memory
from 0x10000000-0x20000000 and so on. So when you find that the "state"
of "memory1" is "offline", you know that memory 0x10000000-0x20000000 is
not used by the Linux kernel (and should not included in vmcore) and (at
least on s390) this area is not backed with real memory.

With this information I can update the /proc/iommem info accordingly.

Michael





_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
