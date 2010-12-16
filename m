Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10] helo=mail.zytor.com)
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PTKLi-0005H0-Kn
	for kexec@lists.infradead.org; Thu, 16 Dec 2010 20:22:51 +0000
Message-ID: <4D0A74F6.6070002@zytor.com>
Date: Thu, 16 Dec 2010 12:22:14 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2][EFI] Run EFI in physical mode
References: <F7CB3D97D99F33indou.takao@jp.fujitsu.com>
	<4D06E7FE.5000600@jp.fujitsu.com>
	<9CB9BB8ED64BAindou.takao@jp.fujitsu.com>
In-Reply-To: <9CB9BB8ED64BAindou.takao@jp.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Takao Indoh <indou.takao@jp.fujitsu.com>
Cc: nhorman@tuxdriver.com, horms@verge.net.au, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, ebiederm@xmission.com, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, tglx@linutronix.de, vgoyal@redhat.com

On 12/14/2010 10:01 AM, Takao Indoh wrote:
> On Tue, 14 Dec 2010 12:43:58 +0900, Kenji Kaneshige wrote:
> 
>> Hi,
>>
>> I tested this patch on the system that has large amount of memory (1TB),
>> and I encountered the immediate system reset problem that happens every
>> time I modify the EFI boot entry using efibootmgr command. It seems that
>> triple fault happens due to the incorrect page table setup.
>>
>>> +void __init efi_pagetable_init(void)
>>> +{
>> (snip.)
>>> +	pgd = efi_pgd + pgd_index(PAGE_OFFSET);
>>> +	set_pgd(pgd, *pgd_offset_k(PAGE_OFFSET));
>>> +	pgd = efi_pgd + pgd_index(__START_KERNEL_map);
>>> +	set_pgd(pgd, *pgd_offset_k(__START_KERNEL_map));
>>> +}
>>
>> Maybe we need to map whole kernel address space. The problem doesn't
>> happen by modifying as follows.
>>
>> 	clone_pgd_range(efi_pgd + KERNEL_PGD_BOUNDARY,
>> 			swapper_pg_dir + KERNEL_PGD_BOUNDARY, 
>> KERNEL_PGD_PTRS);
> 
> Agree, I'll merge this to the patch. And I got another bug report. This
> should be also merged.
> 
> 
> @@ -177,8 +177,8 @@ void __init efi_pagetable_init(void)
>  	memset(efi_pgd, 0, sizeof(efi_pgd));
>  	for (p = memmap.map; p < memmap.map_end; p += memmap.desc_size) {
>  		md = p;
> -		if (!(md->type & EFI_RUNTIME_SERVICES_CODE) &&
> -		    !(md->type & EFI_RUNTIME_SERVICES_DATA))
> +		if ((md->type != EFI_RUNTIME_SERVICES_CODE) &&
> +		    (md->type != EFI_RUNTIME_SERVICES_DATA))
>  			continue;
>  
>  		start_pfn = md->phys_addr >> PAGE_SHIFT;
> @@ -191,7 +191,7 @@ void __init efi_pagetable_init(void)
>  			pud = fill_pud(pgd, vaddr);
>  			pmd = fill_pmd(pud, vaddr);
>  			pte = fill_pte(pmd, vaddr);
> -			if (md->type & EFI_RUNTIME_SERVICES_CODE)
> +			if (md->type == EFI_RUNTIME_SERVICES_CODE)
>  				set_pte(pte, pfn_pte(pfn, PAGE_KERNEL_EXEC));
>  			else
>  				set_pte(pte, pfn_pte(pfn, PAGE_KERNEL));
> 

Note: the current kernel has initial_page_table around for 32 bits; we
should do the equivalent for 64 bits and always keep a 1:1 page table
set around instead of having a special page table.  As such, I would
prefer to not merge a patchset that adds yet another set of ad hoc page
tables if at all possible.

	-hpa


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
