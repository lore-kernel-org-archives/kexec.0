Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cjbcN-00085N-As
 for kexec@lists.infradead.org; Fri, 03 Mar 2017 01:02:49 +0000
Date: Fri, 3 Mar 2017 09:02:18 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2] Fix the false positive error message when search
 /proc/kallsyms for kernel symbol
Message-ID: <20170303010218.GA24001@x1>
References: <1488447581-16465-1-git-send-email-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1488447581-16465-1-git-send-email-bhe@redhat.com>
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
To: horms@verge.net.au
Cc: kexec@lists.infradead.org, dyoung@redhat.com

On 03/02/17 at 05:39pm, Baoquan He wrote:
> Function get_kernel_sym in kexec will search /proc/kallsyms for
> kernel symbol and print error message anyway if expected symbol
> is not found. While page_offset_base definition and exporting
> codes are only available when mm KASLR code is compiled in kernel.
> Otherwise search will fail and print out error message, obviously
> this is false positive warning.

This doesn't work, I must have been dizzy yesterday, NACK it. Will
repost with a new one.

> 
> So in this patch take out the error message from get_kernel_sym and
> put it where get_kernel_sym is called and expected symbol is not found.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  kexec/arch/i386/crashdump-x86.c | 41 +++++++++++++++++++++++------------------
>  1 file changed, 23 insertions(+), 18 deletions(-)
> 
> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> index 88aeee3..b9adc8c 100644
> --- a/kexec/arch/i386/crashdump-x86.c
> +++ b/kexec/arch/i386/crashdump-x86.c
> @@ -127,7 +127,6 @@ static unsigned long long get_kernel_sym(const char *symbol)
>  		}
>  	}
>  
> -	fprintf(stderr, "Cannot get kernel %s symbol address\n", symbol);
>  	return 0;
>  }
>  
> @@ -193,30 +192,36 @@ static int get_kernel_vaddr_and_size(struct kexec_info *UNUSED(info),
>  		}
>  		if (lowest_vaddr != 0)
>  			elf_info->page_offset = lowest_vaddr;
> +	} else {
> +		fprintf(stderr, "Cannot get kernel page_offset_base symbol address\n");
>  	}
>  
>  	/* Traverse through the Elf headers and find the region where
>  	 * _stext symbol is located in. That's where kernel is mapped */
>  	stext_sym = get_kernel_sym("_stext");
> -	for(phdr = ehdr.e_phdr; stext_sym && phdr != end_phdr; phdr++) {
> -		if (phdr->p_type == PT_LOAD) {
> -			unsigned long long saddr = phdr->p_vaddr;
> -			unsigned long long eaddr = phdr->p_vaddr + phdr->p_memsz;
> -			unsigned long long size;
> -
> -			/* Look for kernel text mapping header. */
> -			if (saddr <= stext_sym && eaddr > stext_sym) {
> -				saddr = _ALIGN_DOWN(saddr, X86_64_KERN_VADDR_ALIGN);
> -				elf_info->kern_vaddr_start = saddr;
> -				size = eaddr - saddr;
> -				/* Align size to page size boundary. */
> -				size = _ALIGN(size, align);
> -				elf_info->kern_size = size;
> -				dbgprintf("kernel vaddr = 0x%llx size = 0x%llx\n",
> -					saddr, size);
> -				return 0;
> +	if (stext_sym) {
> +		for(phdr = ehdr.e_phdr; stext_sym && phdr != end_phdr; phdr++) {
> +			if (phdr->p_type == PT_LOAD) {
> +				unsigned long long saddr = phdr->p_vaddr;
> +				unsigned long long eaddr = phdr->p_vaddr + phdr->p_memsz;
> +				unsigned long long size;
> +
> +				/* Look for kernel text mapping header. */
> +				if (saddr <= stext_sym && eaddr > stext_sym) {
> +					saddr = _ALIGN_DOWN(saddr, X86_64_KERN_VADDR_ALIGN);
> +					elf_info->kern_vaddr_start = saddr;
> +					size = eaddr - saddr;
> +					/* Align size to page size boundary. */
> +					size = _ALIGN(size, align);
> +					elf_info->kern_size = size;
> +					dbgprintf("kernel vaddr = 0x%llx size = 0x%llx\n",
> +						saddr, size);
> +					return 0;
> +				}
>  			}
>  		}
> +	} else {
> +		fprintf(stderr, "Cannot get kernel _stext symbol address\n");
>  	}
>  
>  	/* If failed to retrieve kernel text mapping through
> -- 
> 2.5.5
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
