Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from saeurebad.de ([85.214.36.134])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K5T2p-0000tu-0d
	for kexec@lists.infradead.org; Sun, 08 Jun 2008 22:07:23 +0000
From: Johannes Weiner <hannes@saeurebad.de>
Subject: Re: [patch 2/3] Add flags parameter to reserve_bootmem_generic()
References: <20080608134628.757299158@halley.suse.de>
	<20080608134629.743220278@halley.suse.de>
Date: Mon, 09 Jun 2008 00:06:36 +0200
In-Reply-To: <20080608134629.743220278@halley.suse.de> (Bernhard Walle's
	message of "Sun, 08 Jun 2008 15:46:30 +0200")
Message-ID: <877iczmvir.fsf@saeurebad.de>
MIME-Version: 1.0
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
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, anderson@redhat.com, hpa@zytor.com, tglx@linutronix.de, vgoyal@redhat.com

Hi,

Bernhard Walle <bwalle@suse.de> writes:

> This patch adds a 'flags' parameter to reserve_bootmem_generic() like it
> already has been added in reserve_bootmem() with commit
> 72a7fe3967dbf86cb34e24fbf1d957fe24d2f246.
>
> It also changes all users to use BOOTMEM_DEFAULT, which doesn't effectively
> change the behaviour. Since the change is x86-specific, I don't think it's
> necessary to add a new API for migration. There are only 4 users of that
> function.
>
> The change is necessary for the next patch, using reserve_bootmem_generic()
> for crashkernel reservation.
>
>
> Signed-off-by: Bernhard Walle <bwalle@suse.de>
>
> ---
>  arch/x86/kernel/e820_64.c |    3 ++-
>  arch/x86/kernel/efi_64.c  |    3 ++-
>  arch/x86/kernel/mpparse.c |    5 +++--
>  arch/x86/mm/init_64.c     |   17 ++++++++++++-----
>  include/asm-x86/proto.h   |    2 +-
>  5 files changed, 20 insertions(+), 10 deletions(-)
>
> --- a/arch/x86/kernel/e820_64.c
> +++ b/arch/x86/kernel/e820_64.c
> @@ -118,7 +118,8 @@ void __init early_res_to_bootmem(unsigne
>  			continue;
>  		printk(KERN_INFO "  early res: %d [%lx-%lx] %s\n", i,
>  			final_start, final_end - 1, r->name);
> -		reserve_bootmem_generic(final_start, final_end - final_start);
> +		reserve_bootmem_generic(final_start, final_end - final_start,
> +			BOOTMEM_DEFAULT);
>  	}
>  }
>  
> --- a/arch/x86/kernel/efi_64.c
> +++ b/arch/x86/kernel/efi_64.c
> @@ -100,7 +100,8 @@ void __init efi_call_phys_epilog(void)
>  void __init efi_reserve_bootmem(void)
>  {
>  	reserve_bootmem_generic((unsigned long)memmap.phys_map,
> -				memmap.nr_map * memmap.desc_size);
> +				memmap.nr_map * memmap.desc_size,
> +				BOOTMEM_DEFAULT);
>  }
>  
>  void __iomem * __init efi_ioremap(unsigned long phys_addr, unsigned long size)
> --- a/arch/x86/kernel/mpparse.c
> +++ b/arch/x86/kernel/mpparse.c
> @@ -729,10 +729,11 @@ static int __init smp_scan_config(unsign
>  			if (!reserve)
>  				return 1;
>  
> -			reserve_bootmem_generic(virt_to_phys(mpf), PAGE_SIZE);
> +			reserve_bootmem_generic(virt_to_phys(mpf), PAGE_SIZE,
> +				BOOTMEM_DEFAULT);
>  			if (mpf->mpf_physptr)
>  				reserve_bootmem_generic(mpf->mpf_physptr,
> -							PAGE_SIZE);
> +					PAGE_SIZE, BOOTMEM_DEFAULT);
>  #endif
>  		return 1;
>  		}
> Files a/arch/x86/kernel/setup_64.o and b/arch/x86/kernel/setup_64.o differ
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -798,12 +798,13 @@ void free_initrd_mem(unsigned long start
>  }
>  #endif
>  
> -void __init reserve_bootmem_generic(unsigned long phys, unsigned len)
> +int __init reserve_bootmem_generic(unsigned long phys, unsigned len, int flags)
>  {
>  #ifdef CONFIG_NUMA
>  	int nid, next_nid;
>  #endif
>  	unsigned long pfn = phys >> PAGE_SHIFT;
> +	int ret;
>  
>  	if (pfn >= end_pfn) {
>  		/*
> @@ -811,11 +812,11 @@ void __init reserve_bootmem_generic(unsi
>  		 * firmware tables:
>  		 */
>  		if (pfn < max_pfn_mapped)
> -			return;
> +			return -EFAULT;
>  
>  		printk(KERN_ERR "reserve_bootmem: illegal reserve %lx %u\n",
>  				phys, len);
> -		return;
> +		return -EFAULT;
>  	}
>  
>  	/* Should check here against the e820 map to avoid double free */
> @@ -823,9 +824,13 @@ void __init reserve_bootmem_generic(unsi
>  	nid = phys_to_nid(phys);
>  	next_nid = phys_to_nid(phys + len - 1);
>  	if (nid == next_nid)
> -		reserve_bootmem_node(NODE_DATA(nid), phys, len, BOOTMEM_DEFAULT);
> +		ret = reserve_bootmem_node(NODE_DATA(nid), phys, len, flags);
>  	else
> -		reserve_bootmem(phys, len, BOOTMEM_DEFAULT);
> +		ret = reserve_bootmem(phys, len, flags);
> +
> +	if (ret != 0)
> +		return ret;
> +
>  #else
>  	reserve_bootmem(phys, len, BOOTMEM_DEFAULT);
                                   ^^^^^^^^^^^^^^^   flags?
And you ignore the return value here.

	Hannes

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
