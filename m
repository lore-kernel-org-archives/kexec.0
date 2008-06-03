Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K3MpH-0007X4-2v
	for kexec@lists.infradead.org; Tue, 03 Jun 2008 03:04:43 +0000
Date: Mon, 2 Jun 2008 23:04:40 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] Implement support for mem command line parameter
Message-ID: <20080603030440.GC32687@redhat.com>
References: <1212449384-22819-1-git-send-email-bwalle@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1212449384-22819-1-git-send-email-bwalle@suse.de>
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
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org

On Tue, Jun 03, 2008 at 01:29:44AM +0200, Bernhard Walle wrote:
> When the kernel is booted with the "mem" kernel command line (see
> Documentation/kernel-parameters.txt of kernel source tree), the /proc/iomem
> is not modified. Instead, it shows the whole memory space as "System RAM".
> I consider that as correct because the file is named "iomem", and for I/O,
> the behaviour makes sense.
> 

IIUC, in the past the behavior of /proc/iomem was different for i386 and
x86_64. One arch used to truncate it and other would not. I don't remember
which one used to do what.

I had a quick look at the current code and looks like truncation of e820
map is taking place before request_resource(). In that case we should
see the truncated map. But I am not sure and will test it tomorrow...

I am not sure which one is the right behavior as one can argue for both.
So it essentially boils down to two interfaces. One view corresponds to
BIOS view and other view corresponds to kernel view (override BIOS by
user options). I think we need to export both to user space.
 
We need BIOS view so that pure "kexec" can pass it to new kernel, 
irrespecitve of the view seen by first kernel. For example if system
has 4G of memory but user passed mem=2G and first kernel is using only
2G, but if we kexec a new kernel, it should see the full 4G mememory as
obtained by BIOS.

We need user view for "kdump" purposes as we don't want to dump memory
not used by first kernel. (you have already explained it).

> However, when the kernel is booted with the "mem" parameter, the user expects
> the crashdump to be as small as the system memory, not containing the whole
> unused system RAM. To implement this, there are several options:
> 
>  1. Modify /proc/iomem.
>  2. Add a new /proc/iomem_used or something like that, i.e. a new kernel
>     interface.
>  3. Parse /proc/meminfo to read the system RAM.
>  4. Parse /proc/cmdline to read the command line.
> 
> I choosed the 4th possibility because of several reasons.
> 
>  - The /proc/iomem interface should be stable and not modified. That may break
>    other stuff we don't know. It may also be difficult to convince kernel
>    maintainers.

We probably will not touch /proc/iomem. We need to create a new interface
which will change based on user options. That should not break any 
user space applications?

>  - We should not add yet another interface between kernel and userspace for
>    a feature 99 % of the people don't need and don't even know about.
> 
> The semantics of mem is different on different architectures. i386 and x86_64
> (x86) treat the limit specified on the command line as physical address limit

You mean system RAM limit? Because PCI devices are still mapped at higher
physical addresses. So it is not physical address limit?

> while IA64 count the real memory. That is because of different practises of
> memory mapping on PC architecture vs. "new" architectures.
> 
> However, on x86 (which that implementation covers) it's most easy to read
> the /proc/cmdline and the mem parameter. That parameter should be very stable
> since bootloaders need to parse it, so no fancy features are likely to be
> added in future. So we can use that.
> 
> The new function limit_system_memory() now reads the memory map kexec built for

What happens if user booted first kernel with user specified map (using
memmap=exactmap)? How will /proc/iomem look like? I think it will show
user specified IO regions and ignore BIOS map?

So lets say a system has got 4G of RAM, and for testing purpose a user
boots with user speicified map which says 1G of RAM is available. Now
we kexec into second kernel. Should second kernel see 4G of RAM or 1G
of RAM. I feel, second kernel should see 4G of RAM.

Hence I feel that we need to create two views. /proc/iomem can serve
as unmodied io resource view as reported by BIOS, and /proc/iomem_used
can serve as modified view as seen by kernel (due to user options.)

I think its the hard way of doing things as it might break something but
I feel this will also make semantics very clear than patching things
in user space.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
