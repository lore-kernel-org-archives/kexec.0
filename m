Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
 id 1i59zu-0004LG-Lv
 for kexec@lists.infradead.org; Tue, 03 Sep 2019 14:41:32 +0000
Date: Tue, 3 Sep 2019 16:41:27 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] x86: Fix PAGE_OFFSET for kernels since 4.20
Message-ID: <20190903144127.opmnw42pie6klghc@verge.net.au>
References: <20190830091258.51133-1-buczek@molgen.mpg.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190830091258.51133-1-buczek@molgen.mpg.de>
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
To: Donald Buczek <buczek@molgen.mpg.de>
Cc: Bhupesh Sharma <bhsharma@redhat.com>, kexec@lists.infradead.org

On Fri, Aug 30, 2019 at 11:12:58AM +0200, Donald Buczek wrote:
> Linux kernel commit d52888aa2753 ("x86/mm: Move LDT remap out of KASLR
> region on 5-level paging") changed the base of the direct mapping
> from 0xffff880000000000 to 0xffff888000000000. This was merged
> into v4.20-rc2.
> 
> Update to new address accordingly.

Thanks, applied for inclusion in v2.0.20.

> ---
>  kexec/arch/i386/crashdump-x86.c | 2 ++
>  kexec/arch/i386/crashdump-x86.h | 3 ++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> index a2aea31..c79791f 100644
> --- a/kexec/arch/i386/crashdump-x86.c
> +++ b/kexec/arch/i386/crashdump-x86.c
> @@ -61,6 +61,8 @@ static int get_kernel_page_offset(struct kexec_info *UNUSED(info),
>  
>  		if (kv < KERNEL_VERSION(2, 6, 27))
>  			elf_info->page_offset = X86_64_PAGE_OFFSET_PRE_2_6_27;
> +		else if (kv < KERNEL_VERSION(4, 20, 0))
> +			elf_info->page_offset = X86_64_PAGE_OFFSET_PRE_4_20_0;
>  		else
>  			elf_info->page_offset = X86_64_PAGE_OFFSET;
>  	}
> diff --git a/kexec/arch/i386/crashdump-x86.h b/kexec/arch/i386/crashdump-x86.h
> index ddee19f..e4fdc82 100644
> --- a/kexec/arch/i386/crashdump-x86.h
> +++ b/kexec/arch/i386/crashdump-x86.h
> @@ -13,7 +13,8 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline,
>  
>  #define X86_64__START_KERNEL_map	0xffffffff80000000ULL
>  #define X86_64_PAGE_OFFSET_PRE_2_6_27	0xffff810000000000ULL
> -#define X86_64_PAGE_OFFSET		0xffff880000000000ULL
> +#define X86_64_PAGE_OFFSET_PRE_4_20_0	0xffff880000000000ULL
> +#define X86_64_PAGE_OFFSET	0xffff888000000000ULL
>  
>  #define X86_64_MAXMEM        		0x3fffffffffffUL
>  
> -- 
> 2.22.0
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
