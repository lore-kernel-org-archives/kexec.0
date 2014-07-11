Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X5VjV-0002QI-5p
 for kexec@lists.infradead.org; Fri, 11 Jul 2014 07:59:05 +0000
Date: Fri, 11 Jul 2014 15:58:35 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: Can't load bzImage crashkernel on xen system with 32 bit kernel
Message-ID: <20140711075835.GA21010@dhcp-17-89.nay.redhat.com>
References: <53BBC94B.8060905@overnetdata.com>
 <20140710074713.GA23099@dhcp-17-89.nay.redhat.com>
 <53BE66C5.6090604@overnetdata.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53BE66C5.6090604@overnetdata.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Anthony Wright <anthony@overnetdata.com>
Cc: Daniel Kiper <daniel.kiper@oracle.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, David Vrabel <david.vrabel@citrix.com>

On 07/10/14 at 11:11am, Anthony Wright wrote:
> Hi Chao,
> 
> Thanks for looking at this.
> 
> On 10/07/2014 08:47, WANG Chao wrote:
> > Hi, Anthony
> >
> > On 07/08/14 at 11:34am, Anthony Wright wrote:
> >> After successfully modifying kexec-tools to get it to load a crashkernel
> >> on a standard 32 bit linux 3.10.17 kernel, I tried to get it to load the
> >> same crashkernel on the same 32 bit linux kernel running under xen
> >> 4.4.0, but get the error "Cannot load <kernel-path>".
> >>
> >> I've patched the code to include some diagnostics, and the problem is
> >> caused by add_memmap() reporting that it's been called with overlapping
> >> memory.
> >>
> >> It's called twice, the first time it's called with:
> >> 	address: 0x00000000
> >> 	size:    0x0009f800
> >> 	type:    0
> >>
> >> This comes from info->backup_src_*
> >>
> >> The second time it is passed
> >> 	address: 0x00000000
> >> 	size:    0x00000000
> >> 	type:    0
> >>
> >> This is derived from the crash_reserved_mem[] array, which has one
> >> element with the values:
> >> 	start: 0x0000000000000000 (16 0's)
> >> 	end:   0xffffffffffffffff (16 f's)
> > Why it looks like that? crashkernel memory region shouldn't be that
> > extreme.
> Is it something to do with xen 4.4.0? The xen hypervisor is 64 bit, but
> the Dom0 linux kernel is 32 bit. I realise this is a bit of a strange
> combination, but we run this way for historical reasons.
> > Maybe there's something wrong when it retrieves crashkernel reserved
> > region. How you does your /proc/iomem look like?
> >
> > Turn on debug option (-d) would be helpful too.
> I've attached a copy of /proc/iomem and the output of kexec with the -d
> flag.
> >> The problem isn't caused by the zero size because the maths in
> >> add_memmap, uses size to calculate end which overflows back again, and
> >> (partially) cancels out the error. The problem is caused by the two
> >> memory blocks being based at 0x0, causing the blocks to overlap.
> > The overflow issue should be easy to fix once we figure out why the
> > crash_reserved_mem[] has a element like that.
> >
> > Thanks
> > WANG Chao
> thanks,
> 
> Anthony.

> 00000000-00000fff : reserved
> 00001000-0009efff : System RAM
> 0009f000-0009f7ff : RAM buffer
> 0009f800-000fffff : reserved
>   000a0000-000bffff : PCI Bus 0000:00
>   000c0000-000cebff : Video ROM
>   000d0000-000dffff : PCI Bus 0000:00
>   000f0000-000fffff : System ROM
> 00100000-cff9ffff : System RAM
>   01000000-015897cd : Kernel code
>   015897ce-0182debf : Kernel data
>   018e6000-019bbfff : Kernel bss
>   18000000-1fffffff : Crash kernel
> cffa0000-cffaffff : ACPI Tables
> cffb0000-cffdffff : ACPI Non-volatile Storage
> cffe0000-cfffffff : reserved
> d0000000-dfffffff : PCI Bus 0000:00
>   d0000000-dfffffff : PCI Bus 0000:01
>     d0000000-dfffffff : 0000:01:05.0
> e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]
>   e0000000-efffffff : pnp 00:0c
> f0000000-febfffff : PCI Bus 0000:00
>   fdf00000-fdffffff : PCI Bus 0000:03
>     fdff8000-fdffbfff : 0000:03:00.0
>       fdff8000-fdffbfff : r8169
>     fdfff000-fdffffff : 0000:03:00.0
>       fdfff000-fdffffff : r8169
>   fe7f4000-fe7f7fff : 0000:00:14.2
>   fe7fa000-fe7fafff : 0000:00:14.5
>     fe7fa000-fe7fafff : ohci_hcd
>   fe7fb000-fe7fbfff : 0000:00:13.1
>     fe7fb000-fe7fbfff : ohci_hcd
>   fe7fc000-fe7fcfff : 0000:00:13.0
>     fe7fc000-fe7fcfff : ohci_hcd
>   fe7fd000-fe7fdfff : 0000:00:12.1
>     fe7fd000-fe7fdfff : ohci_hcd
>   fe7fe000-fe7fefff : 0000:00:12.0
>     fe7fe000-fe7fefff : ohci_hcd
>   fe7ff400-fe7ff4ff : 0000:00:13.2
>     fe7ff400-fe7ff4ff : ehci_hcd
>   fe7ff800-fe7ff8ff : 0000:00:12.2
>     fe7ff800-fe7ff8ff : ehci_hcd
>   fe7ffc00-fe7fffff : 0000:00:11.0
>     fe7ffc00-fe7fffff : ahci
>   fe800000-fe9fffff : PCI Bus 0000:01
>     fe800000-fe8fffff : 0000:01:05.0
>     fe9f0000-fe9fffff : 0000:01:05.0
>   fea00000-feafffff : PCI Bus 0000:02
>     feaff800-feafffff : 0000:02:00.0
>       feaff800-feafffff : firewire_ohci
>   feb00000-febfffff : PCI Bus 0000:03
>     febe0000-febfffff : 0000:03:00.0
> fec00000-fec003ff : IOAPIC 0
> fec10000-fec1001f : pnp 00:08
> fee00000-feefffff : reserved
>   fee00000-fee00fff : Local APIC
>     fee00000-fee00fff : pnp 00:07
> ffb80000-ffbfffff : pnp 00:08
> fff00000-ffffffff : reserved
> 100000000-21fffffff : System RAM
> fd00000000-ffffffffff : reserved

> kernel: 0xb6dbb008 kernel_size: 0x3b09f0
> MEMORY RANGES
> 0000000000000100-000000000009f7ff (0)
> 000000000009f800-000000000009ffff (1)
> 00000000000e7000-00000000000fffff (1)
> 0000000000100000-00000000cff9ffff (0)
> 00000000cffa0000-00000000cffaffff (2)
> 00000000cffb0000-00000000cffdffff (3)
> 00000000cffe0000-00000000cfffffff (1)
> 00000000fee00000-00000000feefffff (1)
> 00000000fff00000-00000000ffffffff (1)
> 0000000100000000-000000021fffffff (0)
> 000000fd00000000-000000ffffffffff (1)
> bzImage is relocatable
> get_backup_area: 0000000000000000-000000000009f7ff : System RAM
> CRASH MEMORY RANGES
> 0000000000000000-000000000009f7ff (0)
> 000000000009f800-ffffffffffffffff (1)
> 00000000000e7000-ffffffffffffffff (1)
> 0000000000100000-ffffffffffffffff (0)
> 0000000038000000-ffffffffffffffff (0)
> 00000000cffa0000-ffffffffffffffff (2)
> 00000000cffb0000-ffffffffffffffff (3)
> 00000000cffe0000-ffffffffffffffff (1)
> 00000000fee00000-ffffffffffffffff (1)
> 00000000fff00000-ffffffffffffffff (1)
> 0000000100000000-ffffffffffffffff (0)
> 000000fd00000000-ffffffffffffffff (1)
> 0000000000000000-000000ffffffffff (0)

Above doesn't look right to me. kexec is using Xen hypercall to get
these memory region. I'm not able to get kexec to work on box because at
the verify beginning get_xc_kexec_get_range returns -1. And I'm not
familiar with Xen.

CC some authors of kexec/Xen. They might help you on this.

Thanks
WANG Chao

> Memmap after adding segment
> 0000000000000000-000000000009f7ff (0)
> Cannot load /boot/master/XenMaster-6.9.0/kernel


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
