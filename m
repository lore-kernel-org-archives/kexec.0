Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from arkanian.console-pimps.org ([212.110.184.194])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VgciE-0004Dr-EQ
 for kexec@lists.infradead.org; Wed, 13 Nov 2013 15:50:39 +0000
Date: Wed, 13 Nov 2013 15:50:08 +0000
From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [patch 1/7 v2] Add function efi_remap_region for remapping to
 saved virt address
Message-ID: <20131113155008.GA17248@console-pimps.org>
References: <20131105082007.872550445@dhcp-16-126.nay.redhat.com>
 <20131105082715.502723229@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131105082715.502723229@dhcp-16-126.nay.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: dyoung@redhat.com
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On Tue, 05 Nov, at 04:20:08PM, dyoung@redhat.com wrote:
> Kexec kernel will use saved runtime virtual mapping, so add a
> new function efi_remap_region to remapping it directly without
> calculate the virt addr from efi_va.
> 
> The md is passed in from 1st kernel, the virtual addr is
> saved in md->virt_addr.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  arch/x86/include/asm/efi.h     |    1 +
>  arch/x86/platform/efi/efi_32.c |    3 +++
>  arch/x86/platform/efi/efi_64.c |   19 +++++++++++++++++++
>  3 files changed, 23 insertions(+)

[...]

> @@ -203,6 +203,25 @@ void __init efi_map_region(efi_memory_de
>  	md->virt_addr = efi_va;
>  }
>  
> +/*
> + * kexec kernel will use efi_map_region_fixed to map efi
> + * runtime memory ranges. md->virt_addr is the original virtual
> + * address which had been mapped in kexec 1st kernel.
> + */
> +void __init efi_map_region_fixed(efi_memory_desc_t *md)
> +{
> +	pgd_t *pgd = (pgd_t *)__va(real_mode_header->trampoline_pgd);
> +	unsigned long pf = 0;
> +
> +	if (!(md->attribute & EFI_MEMORY_WB))
> +		pf |= _PAGE_PCD;
> +
> +	if (kernel_map_pages_in_pgd(pgd, md->phys_addr, md->virt_addr,
> +			md->num_pages, pf))
> +		pr_warn("Error mapping PA 0x%llx -> VA 0x%llx!\n",
> +			   md->phys_addr, md->virt_addr);
> +}
> +

This function is almost identical to __map_region(). Please implement
efi_map_region_fixed() in terms of __map_region(), e.g.

void __init efi_map_region_fixed(efi_memory_desc_t *md)
{
	__map_region(md, md->virt_addr);
}

> @@ -47,6 +47,9 @@ void __init efi_map_region(efi_memory_de
>  	old_map_region(md);
>  }
>  
> +void __init efi_map_region_fixed(efi_memory_desc_t *md)
> +{}
> +

The braces should be on the same line as the rest of the function
prototype. Look at how it's done elsewhere in this file.

-- 
Matt Fleming, Intel Open Source Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
