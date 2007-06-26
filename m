Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mercury.realtime.net ([205.238.132.86] helo=ruth.realtime.net)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1I32fV-0003LU-V0
	for kexec@lists.infradead.org; Tue, 26 Jun 2007 00:28:47 -0400
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <467AE260.7030906@hp.com>
Message-Id: <46eb88a1cac22924681bf03284d60d50@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [IA64] [kdump] machveg=dig on hpzx1 platforms
Date: Mon, 25 Jun 2007 23:28:36 -0500
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
To: Terry Loftin <terry.loftin@hp.com>, Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org

On Thu Jun 21 16:41:04 EDT 2007, Terry Loftin wrote:
> Bernhard Walle wrote:
>> Hello,
>>
>> on most HP machines, the 'machveg=dig' parameter is needed for the
>> kdump kernel to avoid problems with the HP ioc. In the original kdump
>> patches, a function ioc_iova_disable() was used, which (as I
>> understand) disabled the IOC before executing the new kernel.  
>> However,
>> that function wasn't added to mainline [2].
>
> ioc_iova_disable() was used during the initial development of kexec.
> In-flight DMA from improperly shutdown drivers would land on the
> booting kexec kernel and cause all sorts of hard to find problems.
> An MCA was actually preferred, to help identify errant drivers.
>
> Some of kdump was based on this initial work and included
> ioc_iova_disable().  This function was later dropped - a kdump
> kernel boots in it's own memory space and shouldn't get incoming
> DMA dropped on it.  The problem now is that during the boot of
> the kdump kernel, the ioc is re-initialized, so in-flight DMA
> causes an ioc IOTLB miss which leads to an MCA.  With kdump, the
> idea is to get to the new kernel with as little code as we can,
> so shutting down drivers properly is not an option.
>
> Two possible solutions are:
>    Fix the ioc to handle this situation, maybe by not clearing the
>    IOTLB, and by reserving a few entries for the kdump kernel.  I
>    personally don't understand the IOC well enough to implement this.

This is basically what the powerpc 64-bit port is doing, except we 
don't explicitly reserve any entries.  See arch/powerpc/kernel/iommu.c 
near line 467.  Basically, our generic iommu layer has a bitmap of 
pages for available for allocation per iommu table, and calls a 
platform-specific back-end to give the mapping to the iommu.  If a 
method is supplied to read the existing mappings, then we will fetch 
them and mark any slot with an existing translation as busy in the 
kdump kernel.

For the normal (non-crash-dump) kernel, we will kill any preexisting 
translations the firmware may have left behind; if something was still 
using a translation we would get a machine check (or at least the slot 
would go into an error state, for the platforms that support Enhanced 
Error Handling (EEH)).

I am not familier with the IA64 code and don't know the the iommu 
allocates translation slots.

> Or
>    Use machvec=dig and avoid using the ioc altogether for the kdump
>    kernel, (leaving the IOTLB intact).  This is something of a hack,
>    but it works.
>
> Because this ioc is HP specific hardware, the machvec=dig hack is only
> needed for HP platforms.

milton


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
