Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1ciawR-0001It-A4
 for kexec@lists.infradead.org; Tue, 28 Feb 2017 06:07:20 +0000
Date: Tue, 28 Feb 2017 14:06:25 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] Only search page_offset_base when KASLR mm code is
 compiled in
Message-ID: <20170228060625.GA4872@dhcp-128-65.nay.redhat.com>
References: <1487932732-24539-1-git-send-email-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1487932732-24539-1-git-send-email-bhe@redhat.com>
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
To: Baoquan He <bhe@redhat.com>
Cc: horms@verge.net.au, kexec@lists.infradead.org, piliu@redhat.com

On 02/24/17 at 06:38pm, Baoquan He wrote:
> Otherwise it will print false positve message as below. So add
> a check when do the search.
> 
>     "Cannot get kernel page_offset_base symbol address"
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  kexec/arch/i386/crashdump-x86.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> index 88aeee3..b2c1be5 100644
> --- a/kexec/arch/i386/crashdump-x86.c
> +++ b/kexec/arch/i386/crashdump-x86.c
> @@ -150,8 +150,6 @@ static int get_kernel_vaddr_and_size(struct kexec_info *UNUSED(info),
>  	off_t size;
>  	uint32_t elf_flags = 0;
>  	uint64_t stext_sym;
> -	const unsigned long long pud_mask = ~((1 << 30) - 1);
> -	unsigned long long vaddr, lowest_vaddr = 0;
>  
>  	if (elf_info->machine != EM_X86_64)
>  		return 0;
> @@ -181,8 +179,11 @@ static int get_kernel_vaddr_and_size(struct kexec_info *UNUSED(info),
>  
>  	end_phdr = &ehdr.e_phdr[ehdr.e_phnum];
>  
> +#ifdef CONFIG_RANDOMIZE_MEMORY

It does not work in userspace code.

Maybe mute the error message or move it to kexec --debug is more
reasonable..

>  	/* Search for the real PAGE_OFFSET when KASLR memory randomization
>  	 * is enabled */
> +	const unsigned long long pud_mask = ~((1 << 30) - 1);
> +	unsigned long long vaddr, lowest_vaddr = 0;
>  	if (get_kernel_sym("page_offset_base") != 0) {
>  		for(phdr = ehdr.e_phdr; phdr != end_phdr; phdr++) {
>  			if (phdr->p_type == PT_LOAD) {
> @@ -194,6 +195,7 @@ static int get_kernel_vaddr_and_size(struct kexec_info *UNUSED(info),
>  		if (lowest_vaddr != 0)
>  			elf_info->page_offset = lowest_vaddr;
>  	}
> +#endif
>  
>  	/* Traverse through the Elf headers and find the region where
>  	 * _stext symbol is located in. That's where kernel is mapped */
> -- 
> 2.5.5
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
