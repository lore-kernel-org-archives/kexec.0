Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PT109-0001Z9-1F
	for kexec@lists.infradead.org; Wed, 15 Dec 2010 23:43:17 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <F7CB3D97D99F33indou.takao@jp.fujitsu.com>
	<4D06E7FE.5000600@jp.fujitsu.com>
	<ACB9BDFABD971indou.takao@jp.fujitsu.com>
Date: Wed, 15 Dec 2010 15:42:44 -0800
In-Reply-To: <ACB9BDFABD971indou.takao@jp.fujitsu.com> (Takao Indoh's message
	of "Tue, 14 Dec 2010 17:38:47 -0500")
Message-ID: <m1d3p2vc0b.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2][EFI] Run EFI in physical mode
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
Cc: nhorman@tuxdriver.com, horms@verge.net.au, hpa@zytor.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, tglx@linutronix.de, vgoyal@redhat.com

Takao Indoh <indou.takao@jp.fujitsu.com> writes:

> On Tue, 14 Dec 2010 12:43:58 +0900, Kenji Kaneshige wrote:
>
>>Hi,
>>
>>I tested this patch on the system that has large amount of memory (1TB),
>>and I encountered the immediate system reset problem that happens every
>>time I modify the EFI boot entry using efibootmgr command. It seems that
>>triple fault happens due to the incorrect page table setup.
>>
>>> +void __init efi_pagetable_init(void)
>>> +{
>>(snip.)
>>> +	pgd = efi_pgd + pgd_index(PAGE_OFFSET);
>>> +	set_pgd(pgd, *pgd_offset_k(PAGE_OFFSET));
>>> +	pgd = efi_pgd + pgd_index(__START_KERNEL_map);
>>> +	set_pgd(pgd, *pgd_offset_k(__START_KERNEL_map));
>>> +}
>>
>>Maybe we need to map whole kernel address space. The problem doesn't
>>happen by modifying as follows.
>>
>>	clone_pgd_range(efi_pgd + KERNEL_PGD_BOUNDARY,
>>			swapper_pg_dir + KERNEL_PGD_BOUNDARY, 
>>KERNEL_PGD_PTRS);
>
>
> Besides this bug, I'm thinking that we need global TLB flush after
> restoring cr3 because EFI code page is mapped with PAGE_KERNEL_EXEC.
>
>  void efi_call_phys_epilog_in_physmode(void)
>  {
>  	write_cr3(get_cpu_var(save_cr3));
> +	if (cpu_has_pge)
> +		__flush_tlb_global();
>  	local_irq_restore(get_cpu_var(efi_flags));
>  }
>
> Somethinkg like this. Anybody comments?

If only one cpu runs efi we shouldn't need a global flush.
I presume you aren't modifying the kernel's global page table?

If we are giving the entire machine to efi then yes we would need
to set cr3 on all machines.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
