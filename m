Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 1 Oct 2018 13:52:26 +0100
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v15 07/16] arm64: add image head flag definitions
Message-ID: <20181001125225.7tlfzt5n25sckhyy@lakrids.cambridge.arm.com>
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
 <20180928064841.14117-8-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180928064841.14117-8-takahiro.akashi@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: prudo@linux.ibm.com, herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, bhsharma@redhat.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com, dhowells@redhat.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, schwidefsky@de.ibm.com, james.morse@arm.com, dyoung@redhat.com, davem@davemloft.net, vgoyal@redhat.com

On Fri, Sep 28, 2018 at 03:48:32PM +0900, AKASHI Takahiro wrote:
> Those image head's flags will be used later by kexec_file loader.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Acked-by: James Morse <james.morse@arm.com>
> ---
>  arch/arm64/include/asm/boot.h | 15 +++++++++++++++
>  arch/arm64/kernel/head.S      |  2 +-
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/boot.h b/arch/arm64/include/asm/boot.h
> index 355e552a9175..0bab7eed3012 100644
> --- a/arch/arm64/include/asm/boot.h
> +++ b/arch/arm64/include/asm/boot.h
> @@ -5,6 +5,21 @@
>  
>  #include <asm/sizes.h>
>  
> +#define ARM64_MAGIC		"ARM\x64"
> +
> +#define HEAD_FLAG_BE_SHIFT		0
> +#define HEAD_FLAG_PAGE_SIZE_SHIFT	1
> +#define HEAD_FLAG_BE_MASK		0x1
> +#define HEAD_FLAG_PAGE_SIZE_MASK	0x3
> +
> +#define HEAD_FLAG_BE			1

These already exist in some form in arch/arm64/kernel/image.h; can we
please factor those out rather than duplicating them?

I'd be happy if you'd update image.h to use the new HEAD_FLAG_* names,
and removed the old definitions.

> +#define HEAD_FLAG_PAGE_SIZE_4K		1
> +#define HEAD_FLAG_PAGE_SIZE_16K		2
> +#define HEAD_FLAG_PAGE_SIZE_64K		3

I appreciate these are new, since we didn't previously need definitions.

Thanks,
Mark.

> +
> +#define head_flag_field(flags, field) \
> +		(((flags) >> field##_SHIFT) & field##_MASK)
> +
>  /*
>   * arm64 requires the DTB to be 8 byte aligned and
>   * not exceed 2MB in size.
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index b0853069702f..8cbac6232ed1 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -91,7 +91,7 @@ _head:
>  	.quad	0				// reserved
>  	.quad	0				// reserved
>  	.quad	0				// reserved
> -	.ascii	"ARM\x64"			// Magic number
> +	.ascii	ARM64_MAGIC			// Magic number
>  #ifdef CONFIG_EFI
>  	.long	pe_header - _head		// Offset to the PE header.
>  
> -- 
> 2.19.0
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
