Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cFK7M-0000uW-7w
 for kexec@lists.infradead.org; Fri, 09 Dec 2016 12:17:38 +0000
Received: by mail-qt0-f171.google.com with SMTP id n6so14188015qtd.1
 for <kexec@lists.infradead.org>; Fri, 09 Dec 2016 04:17:15 -0800 (PST)
Subject: Re: [PATCH v2 kexec-tools] arm: do not build iomem.o target with no
 soruce
References: <1481281212-16929-1-git-send-email-horms@verge.net.au>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <9d7b9d56-f4a6-4f0c-533b-20f56296c61a@redhat.com>
Date: Fri, 9 Dec 2016 17:45:55 +0530
MIME-Version: 1.0
In-Reply-To: <1481281212-16929-1-git-send-email-horms@verge.net.au>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org
Cc: Dave Young <dyoung@redhat.com>



On Friday 09 December 2016 04:30 PM, Simon Horman wrote:
> Header files should be added to the distribution but not
> used to derive targets for compilation. In this an attempt was
> made to build iomem.o, but iomem.c does not exist so this fails.
>
> Fixes: 1574ff1aae4f ("arm: include phys_to_virt.h and iomem.h in distribution")
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Pratyush Anand <panand@redhat.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>
> ---
> v2
> * add headers directly to dist
> ---
>  kexec/arch/arm/Makefile | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/kexec/arch/arm/Makefile b/kexec/arch/arm/Makefile
> index 871979e0ae26..4454f47a48df 100644
> --- a/kexec/arch/arm/Makefile
> +++ b/kexec/arch/arm/Makefile
> @@ -27,9 +27,8 @@ arm_KEXEC_SRCS += $(libfdt_SRCS)
>
>  arm_UIMAGE = kexec/kexec-uImage.c
>  arm_PHYS_TO_VIRT = kexec/arch/arm/phys_to_virt.c
> -arm_PHYS_TO_VIRT += kexec/arch/arm/iomem.h
> -arm_PHYS_TO_VIRT += kexec/arch/arm/phys_to_virt.h
>
>  dist += kexec/arch/arm/Makefile $(arm_KEXEC_SRCS) $(arm_PHYS_TO_VIRT)	\
> -	kexec/arch/arm/crashdump-arm.h kexec/arch/arm/kexec-arm.h	\
> +	kexec/arch/arm/iomem.h kexec/arch/arm/phys_to_virt.h \
> +	kexec/arch/arm/crashdump-arm.h kexec/arch/arm/kexec-arm.h \
>  	kexec/arch/arm/include/arch/options.h
>

Reviewed-by: Pratyush Anand <panand@redhat.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
