Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mXfev-009Vpr-Ln
 for kexec@lists.infradead.org; Tue, 05 Oct 2021 08:18:47 +0000
Date: Tue, 5 Oct 2021 10:18:32 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec-tools: multiboot2: Correct BASIC_MEMINFO memory
 units
Message-ID: <20211005081832.GA23961@vergenet.net>
References: <20210924170327.6775-1-dinhngoc.tu@irit.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210924170327.6775-1-dinhngoc.tu@irit.fr>
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
To: dinhngoc.tu@irit.fr
Cc: kexec@lists.infradead.org

On Fri, Sep 24, 2021 at 07:03:27PM +0200, dinhngoc.tu@irit.fr wrote:
> From: Tu Dinh <dinhngoc.tu@irit.fr>
> 
> mem_lower and mem_upper are measured in kilobytes.

Thanks,

I'm curious to know how the current code could have worked.
Do we have some testing to verify this change?

> ---
>  kexec/arch/i386/kexec-mb2-x86.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kexec/arch/i386/kexec-mb2-x86.c b/kexec/arch/i386/kexec-mb2-x86.c
> index 36fef20..0d2e93b 100644
> --- a/kexec/arch/i386/kexec-mb2-x86.c
> +++ b/kexec/arch/i386/kexec-mb2-x86.c
> @@ -256,8 +256,8 @@ static uint64_t multiboot2_make_mbi(struct kexec_info *info, char *cmdline, int
>  
>  		tag->type = MULTIBOOT_TAG_TYPE_BASIC_MEMINFO;
>  		tag->size = sizeof (struct multiboot_tag_basic_meminfo);
> -		tag->mem_lower = mem_lower;
> -		tag->mem_upper = mem_upper;
> +		tag->mem_lower = mem_lower >> 10;
> +		tag->mem_upper = mem_upper >> 10;
>  		ptrorig += ALIGN_UP (tag->size, MULTIBOOT_TAG_ALIGN) / sizeof (*ptrorig);
>  	}
>  
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
