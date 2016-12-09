Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cFIQ4-0000UM-49
 for kexec@lists.infradead.org; Fri, 09 Dec 2016 10:28:49 +0000
Received: by mail-pg0-f50.google.com with SMTP id 3so6647560pgd.0
 for <kexec@lists.infradead.org>; Fri, 09 Dec 2016 02:28:27 -0800 (PST)
Subject: Re: [PATCH kexec-tools] arm: do not build iomem.o target with no
 soruce
References: <1481274775-32373-1-git-send-email-horms@verge.net.au>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <ad1d1741-7619-9e73-fbdc-0b18e6839274@redhat.com>
Date: Fri, 9 Dec 2016 15:58:21 +0530
MIME-Version: 1.0
In-Reply-To: <1481274775-32373-1-git-send-email-horms@verge.net.au>
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



On Friday 09 December 2016 02:42 PM, Simon Horman wrote:
> Header files should be added to the distribution but not
> used to derive targets for compilation. In this an attempt was
> made to build iomem.o, but iomem.c does not exist so this fails.
>
> Fixes: 1574ff1aae4f ("arm: include phys_to_virt.h and iomem.h in distribution")
> Cc: Dave Young <dyoung@redhat.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>
> ---
>  kexec/arch/arm/Makefile | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kexec/arch/arm/Makefile b/kexec/arch/arm/Makefile
> index 871979e0ae26..a1b730034de8 100644
> --- a/kexec/arch/arm/Makefile
> +++ b/kexec/arch/arm/Makefile
> @@ -27,9 +27,9 @@ arm_KEXEC_SRCS += $(libfdt_SRCS)
>
>  arm_UIMAGE = kexec/kexec-uImage.c
>  arm_PHYS_TO_VIRT = kexec/arch/arm/phys_to_virt.c
> -arm_PHYS_TO_VIRT += kexec/arch/arm/iomem.h
> -arm_PHYS_TO_VIRT += kexec/arch/arm/phys_to_virt.h
> +arm_PHYS_TO_VIRT_INCLUDE = kexec/arch/arm/iomem.h
> +arm_PHYS_TO_VIRT_INCLUDE += kexec/arch/arm/phys_to_virt.h

Since they are needed only in dist definition, so probably we could have 
avoided to define arm_PHYS_TO_VIRT_INCLUDE  and could have added these 
files directly to dist. It will keep it similar like other makefiles 
(kexec/arch/x86_64/Makefile)

>
>  dist += kexec/arch/arm/Makefile $(arm_KEXEC_SRCS) $(arm_PHYS_TO_VIRT)	\
> -	kexec/arch/arm/crashdump-arm.h kexec/arch/arm/kexec-arm.h	\
> -	kexec/arch/arm/include/arch/options.h
> +	$(arm_PHYS_TO_VIRT_INCLUDE) kexec/arch/arm/crashdump-arm.h \
> +	kexec/arch/arm/kexec-arm.h kexec/arch/arm/include/arch/options.h
>

Otherwise, changes looks fine to me.


~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
