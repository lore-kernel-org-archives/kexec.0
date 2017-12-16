Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1eQ0ru-0001YQ-Oa
 for kexec@lists.infradead.org; Sat, 16 Dec 2017 01:02:29 +0000
Date: Sat, 16 Dec 2017 09:01:42 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2] x86/kexec: Exclude GART aperture from vmcore
Message-ID: <20171216010142.GK12442@x1>
References: <20171216001514.x5eg37ad4aa2fwqt@dwarf.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20171216001514.x5eg37ad4aa2fwqt@dwarf.suse.cz>
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
To: Jiri Bohac <jbohac@suse.cz>
Cc: Toshi Kani <toshi.kani@hpe.com>, David Airlie <airlied@linux.ie>, yinghai@kernel.org, joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On 12/16/17 at 01:15am, Jiri Bohac wrote:
> On machines where the GART aperture is mapped over physical RAM
> /proc/vmcore contains the remapped range and reading it may
> cause hangs or reboots. 
> 
> In the past, the GART region was added into the resource map, implemented by
> commit 56dd669a138c ("[PATCH] Insert GART region into resource map")
> 
> However, inserting the iomem_resource from the early GART code caused
> resource conflicts with some AGP drivers (bko#72201), which got avoided by
> reverting the patch in commit 707d4eefbdb3 ("Revert [PATCH] Insert GART
> region into resource map"). This revert introduced the /proc/vmcore bug.
> 
> The vmcore ELF header is either prepared by the kernel (when using the
> kexec_file_load syscall) or by the kexec userspace (when using the kexec_load
> syscall). Since we no longer have the GART iomem resource, the userspace
> kexec has no way of knowing which region to exclude from the ELF header.
> 
> Changes from v1 of this patch:
> Instead of excluding the aperture from the ELF header, this patch
> makes /proc/vmcore return zeroes in the second kernel when attempting to
> read the aperture region. This is done by reusing the
> gart_oldmem_pfn_is_ram infrastructure originally intended to exclude XEN
> balooned memory. This works for both, the kexec_file_load and kexec_load
> syscalls.

This is funny and smart way. While it may not be good, E.g what if
people add iommu=off in kdump kernel? You made an assumption on this,
which people must use iommu in kdump kernel and aperture_pfn_start can
be got naturally.

As I said in v1, I listed 3 options. In fact 1st option is doable. Just
need to figure out why peopld did the quirk to enable gart anyway when
not enable gart in bios. You replied that you guess there's firmware bug
so that people have to do this. I have to say guess is not convincing.

Well, in fact, I have several questions:

1) In your case, the HP machine with gart, when you enable gart support
in bios, is it OK to you?

2) If firmware is broken, you can't enable gart in firmware, will
firmware engineer fix this since it's a firmware bug?

If above two have answer 'yes', then it's not a blocker to you. And we
should remove the quirk code which enable gart in kernel when people
forget enableing gart support in firmware.

OR

Take the option 3 as I said. Take the gart region off from iomem. But
you said there will be conflict with pci issue. If I did, I would make
clear what's the pci issue and why they conflict. Can we do in another
way to dig it out from iomem, e.g in different stage, after pci bus
iteration. 

I didn't reply to you later since I think my comments have been clear,
and I am very busy on rhel regression bug fix. Kernel bug fix sometime
is not easy. I don't find a gart system in redhat's lab, otherwise I
will make a post to have a try.

Thanks
Baoquan

> 
> [Note that the GART region is the same in the first and second kernels:
> regardless whether the first kernel fixed up the northbridge/bios setting
> and mapped the aperture over physical memory, the second kernel finds the
> northbridge properly configured by the first kernel and the aperture
> never overlaps with e820 memory because the second kernel has a fake e820
> map created from the crashkernel memory regions. Thus, the second kernel
> keeps the aperture address/size as configured by the first kernel.]
> 
> register_oldmem_pfn_is_ram can only register one callback and returns an error
> if the callback has been registered already. Since XEN used to be the only user
> of this function, it never checks the return value. Now that we have more than
> one user, I added a WARN_ON just in case agp, XEN, or any other future user of
> register_oldmem_pfn_is_ram were to step on each other's toes.
> 
> 
> Signed-off-by: Jiri Bohac <jbohac@suse.cz>
> Fixes: 707d4eefbdb3 ("Revert [PATCH] Insert GART region into resource map")
> 
> diff --git a/arch/x86/kernel/aperture_64.c b/arch/x86/kernel/aperture_64.c
> index f5d92bc3b884..837efa32110c 100644
> --- a/arch/x86/kernel/aperture_64.c
> +++ b/arch/x86/kernel/aperture_64.c
> @@ -30,6 +30,7 @@
>  #include <asm/dma.h>
>  #include <asm/amd_nb.h>
>  #include <asm/x86_init.h>
> +#include <linux/crash_dump.h>
>  
>  /*
>   * Using 512M as goal, in case kexec will load kernel_big
> @@ -56,6 +57,27 @@ int fallback_aper_force __initdata;
>  
>  int fix_aperture __initdata = 1;
>  
> +#ifdef CONFIG_PROC_VMCORE
> +static unsigned long aperture_pfn_start, aperture_page_count;
> +
> +static int gart_oldmem_pfn_is_ram(unsigned long pfn)
> +{
> +	return likely((pfn < aperture_pfn_start) ||
> +		      (pfn >= aperture_pfn_start + aperture_page_count));
> +}
> +
> +static void exclude_from_vmcore(u64 aper_base, u32 aper_order)
> +{
> +	aperture_pfn_start = aper_base >> PAGE_SHIFT;
> +	aperture_page_count = (32 * 1024 * 1024) << aper_order >> PAGE_SHIFT;
> +	WARN_ON(register_oldmem_pfn_is_ram(&gart_oldmem_pfn_is_ram));
> +}
> +#else
> +static void exclude_from_vmcore(u64 aper_base, u32 aper_order)
> +{
> +}
> +#endif
> +
>  /* This code runs before the PCI subsystem is initialized, so just
>     access the northbridge directly. */
>  
> @@ -435,8 +457,10 @@ int __init gart_iommu_hole_init(void)
>  
>  out:
>  	if (!fix && !fallback_aper_force) {
> -		if (last_aper_base)
> +		if (last_aper_base) {
> +			exclude_from_vmcore(last_aper_base, last_aper_order);
>  			return 1;
> +		}
>  		return 0;
>  	}
>  
> @@ -473,6 +497,8 @@ int __init gart_iommu_hole_init(void)
>  		return 0;
>  	}
>  
> +	exclude_from_vmcore(aper_alloc, aper_order);
> +
>  	/* Fix up the north bridges */
>  	for (i = 0; i < amd_nb_bus_dev_ranges[i].dev_limit; i++) {
>  		int bus, dev_base, dev_limit;
> diff --git a/arch/x86/xen/mmu_hvm.c b/arch/x86/xen/mmu_hvm.c
> index 2cfcfe4f6b2a..dd2ad82eee80 100644
> --- a/arch/x86/xen/mmu_hvm.c
> +++ b/arch/x86/xen/mmu_hvm.c
> @@ -75,6 +75,6 @@ void __init xen_hvm_init_mmu_ops(void)
>  	if (is_pagetable_dying_supported())
>  		pv_mmu_ops.exit_mmap = xen_hvm_exit_mmap;
>  #ifdef CONFIG_PROC_VMCORE
> -	register_oldmem_pfn_is_ram(&xen_oldmem_pfn_is_ram);
> +	WARN_ON(register_oldmem_pfn_is_ram(&xen_oldmem_pfn_is_ram));
>  #endif
>  }
> -- 
> Jiri Bohac <jbohac@suse.cz>
> SUSE Labs, Prague, Czechia
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
