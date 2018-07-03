Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v10 05/14] arm64: add image head flag definitions
References: <20180623022058.10935-1-takahiro.akashi@linaro.org>
 <20180623022058.10935-6-takahiro.akashi@linaro.org>
From: James Morse <james.morse@arm.com>
Message-ID: <15a8c694-ea85-8d9f-7498-62995f46ca1a@arm.com>
Date: Tue, 3 Jul 2018 17:34:34 +0100
MIME-Version: 1.0
In-Reply-To: <20180623022058.10935-6-takahiro.akashi@linaro.org>
Content-Language: en-US
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
Cc: herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, bhsharma@redhat.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, dhowells@redhat.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, dyoung@redhat.com, davem@davemloft.net, vgoyal@redhat.com

Hi Akashi,

On 23/06/18 03:20, AKASHI Takahiro wrote:
> Those image head's flags will be used later by kexec_file loader.

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
> +#define HEAD_FLAG_PAGE_SIZE_4K		1
> +#define HEAD_FLAG_PAGE_SIZE_16K		2
> +#define HEAD_FLAG_PAGE_SIZE_64K		3

These match the linker-script-header kernel/image.h.
Generating one from the other is something we can do later.

Acked-by: James Morse <james.morse@arm.com>


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
