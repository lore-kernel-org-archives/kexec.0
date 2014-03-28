Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WTXPl-0006fY-7Y
 for kexec@lists.infradead.org; Fri, 28 Mar 2014 14:05:46 +0000
Date: Fri, 28 Mar 2014 10:05:22 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [kexec-tools PATCH v2] x86, kaslr: add alternative way to locate
 kernel text mapping area
Message-ID: <20140328140522.GF2089@redhat.com>
References: <1395990300-17830-1-git-send-email-chaowang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1395990300-17830-1-git-send-email-chaowang@redhat.com>
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
To: WANG Chao <chaowang@redhat.com>
Cc: kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, Dave Young <dyoung@redhat.com>

On Fri, Mar 28, 2014 at 03:05:00PM +0800, WANG Chao wrote:
> When kASLR is enabled (CONFIG_RANDOMIZED_BASE=y), kernel text mapping
> base is randomized. The max base offset of such randomization is
> configured at compile time through CONFIG_RANDOMIZE_MAX_BASE_OFFSET (by
> default 1G).
> 
> Currently kexec-tools is using hard code macro X86_64__START_KERNEL_map
> (0xffffffff80000000) and X86_64_KERNEL_TEXT_SIZE (512M) to determine
> kernel text mapping from kcore's PT_LOAD. With kASLR, the mapping is
> changed as the following:
> 
> ffffffff80000000 - (ffffffff80000000+CONFIG_RANDOMIZE_BASE_MAX_OFFSET)
> 
> As Vivek suggested, we can get _stext kernel symbol address from
> /proc/kallsyms, and search for kcore's PT_LOAD which contains _stext,
> and we can say that this area represents the kernel mapping area.
> 
> Let's first use this way to find out kernel text mapping. If failed for
> whatever reason, fall back to use the old way.
> 
> Suggested-by: Vivek Goyal <vgoyal@redhat.com>
> Signed-off-by: WANG Chao <chaowang@redhat.com>

Looks good to me.

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Vivek

> ---
>  kexec/arch/i386/crashdump-x86.c | 63 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 61 insertions(+), 2 deletions(-)
> 
> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> index cb19e7d..fb92029 100644
> --- a/kexec/arch/i386/crashdump-x86.c
> +++ b/kexec/arch/i386/crashdump-x86.c
> @@ -100,6 +100,36 @@ static int get_kernel_paddr(struct kexec_info *UNUSED(info),
>  	return -1;
>  }
>  
> +/* Retrieve kernel _stext symbol virtual address from /proc/kallsyms */
> +static unsigned long long get_kernel_stext_sym(void)
> +{
> +	const char *kallsyms = "/proc/kallsyms";
> +	const char *stext = "_stext";
> +	char sym[128];
> +	char line[128];
> +	FILE *fp;
> +	unsigned long long vaddr;
> +	char type;
> +
> +	fp = fopen(kallsyms, "r");
> +	if (!fp) {
> +		fprintf(stderr, "Cannot open %s\n", kallsyms);
> +		return 0;
> +	}
> +
> +	while(fgets(line, sizeof(line), fp) != NULL) {
> +		if (sscanf(line, "%Lx %c %s", &vaddr, &type, sym) != 3)
> +			continue;
> +		if (strcmp(sym, stext) == 0) {
> +			dbgprintf("kernel symbol %s vaddr = %16llx\n", stext, vaddr);
> +			return vaddr;
> +		}
> +	}
> +
> +	fprintf(stderr, "Cannot get kernel %s symbol address\n", stext);
> +	return 0;
> +}
> +
>  /* Retrieve info regarding virtual address kernel has been compiled for and
>   * size of the kernel from /proc/kcore. Current /proc/kcore parsing from
>   * from kexec-tools fails because of malformed elf notes. A kernel patch has
> @@ -118,6 +148,7 @@ static int get_kernel_vaddr_and_size(struct kexec_info *UNUSED(info),
>  	int align;
>  	off_t size;
>  	uint32_t elf_flags = 0;
> +	uint64_t stext_sym;
>  
>  	if (elf_info->machine != EM_X86_64)
>  		return 0;
> @@ -145,9 +176,36 @@ static int get_kernel_vaddr_and_size(struct kexec_info *UNUSED(info),
>  		return -1;
>  	}
>  
> -	/* Traverse through the Elf headers and find the region where
> -	 * kernel is mapped. */
>  	end_phdr = &ehdr.e_phdr[ehdr.e_phnum];
> +
> +	/* Traverse through the Elf headers and find the region where
> +	 * _stext symbol is located in. That's where kernel is mapped */
> +	stext_sym = get_kernel_stext_sym();
> +	for(phdr = ehdr.e_phdr; stext_sym && phdr != end_phdr; phdr++) {
> +		if (phdr->p_type == PT_LOAD) {
> +			unsigned long long saddr = phdr->p_vaddr;
> +			unsigned long long eaddr = phdr->p_vaddr + phdr->p_memsz;
> +			unsigned long long size;
> +
> +			/* Look for kernel text mapping header. */
> +			if (saddr < stext_sym && eaddr > stext_sym) {
> +				saddr = _ALIGN_DOWN(saddr, X86_64_KERN_VADDR_ALIGN);
> +				elf_info->kern_vaddr_start = saddr;
> +				size = eaddr - saddr;
> +				/* Align size to page size boundary. */
> +				size = _ALIGN(size, align);
> +				elf_info->kern_size = size;
> +				dbgprintf("kernel vaddr = 0x%llx size = 0x%llx\n",
> +					saddr, size);
> +				return 0;
> +			}
> +		}
> +	}
> +
> +	/* If failed to retrieve kernel text mapping through
> +	 * /proc/kallsyms, Traverse through the Elf headers again and
> +	 * find the region where kernel is mapped using hard-coded
> +	 * kernel mapping boundries */
>  	for(phdr = ehdr.e_phdr; phdr != end_phdr; phdr++) {
>  		if (phdr->p_type == PT_LOAD) {
>  			unsigned long long saddr = phdr->p_vaddr;
> @@ -169,6 +227,7 @@ static int get_kernel_vaddr_and_size(struct kexec_info *UNUSED(info),
>  			}
>  		}
>  	}
> +
>  	fprintf(stderr, "Can't find kernel text map area from kcore\n");
>  	return -1;
>  }
> -- 
> 1.8.5.3

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
