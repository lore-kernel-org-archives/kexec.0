Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i3d8N-0002Mt-PC
 for kexec@lists.infradead.org; Fri, 30 Aug 2019 09:23:57 +0000
Date: Fri, 30 Aug 2019 17:23:51 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] x86: Fix PAGE_OFFSET for kernels since 4.20
Message-ID: <20190830092351.GE12242@MiWiFi-R3L-srv>
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
Cc: Bhupesh Sharma <bhsharma@redhat.com>, horms@verge.net.au, kexec@lists.infradead.org, k-hagio@ab.jp.nec.com

On 08/30/19 at 11:12am, Donald Buczek wrote:
> Linux kernel commit d52888aa2753 ("x86/mm: Move LDT remap out of KASLR
> region on 5-level paging") changed the base of the direct mapping
> from 0xffff880000000000 to 0xffff888000000000. This was merged
> into v4.20-rc2.

A good catch and necessary fix, thanks.

Does it have issue in makedumpfile?

#ifdef __x86_64__
#define __PAGE_OFFSET_ORIG      (0xffff810000000000) /* 2.6.26, or former */
#define __PAGE_OFFSET_2_6_27    (0xffff880000000000) /* 2.6.27, or later  */
#define __PAGE_OFFSET_5LEVEL    (0xff10000000000000) /* 5-level page table */ 
...
#endif

Thanks
Baoquan

> 
> Update to new address accordingly.
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
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
