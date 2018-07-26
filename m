Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v12 15/16] arm64: kexec_file: add kernel signature
 verification support
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
 <20180724065759.19186-16-takahiro.akashi@linaro.org>
From: James Morse <james.morse@arm.com>
Message-ID: <d3704585-9404-a56b-883a-30c123084ada@arm.com>
Date: Thu, 26 Jul 2018 14:39:25 +0100
MIME-Version: 1.0
In-Reply-To: <20180724065759.19186-16-takahiro.akashi@linaro.org>
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
Cc: herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, bhsharma@redhat.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com, dhowells@redhat.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, schwidefsky@de.ibm.com, dyoung@redhat.com, davem@davemloft.net, vgoyal@redhat.com

Hi Akashi,

On 24/07/18 07:57, AKASHI Takahiro wrote:
> With this patch, kernel verification can be done without IMA security
> subsystem enabled. Turn on CONFIG_KEXEC_VERIFY_SIG instead.
> 
> On x86, a signature is embedded into a PE file (Microsoft's format) header
> of binary. Since arm64's "Image" can also be seen as a PE file as far as
> CONFIG_EFI is enabled, we adopt this format for kernel signing.
> 
> You can create a signed kernel image with:
>     $ sbsign --key ${KEY} --cert ${CERT} Image

Reviewed-by: James Morse <james.morse@arm.com>


> diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> index d64f5e9f9d22..578d358632d0 100644
> --- a/arch/arm64/kernel/kexec_image.c
> +++ b/arch/arm64/kernel/kexec_image.c
> @@ -102,7 +106,18 @@ static void *image_load(struct kimage *image,
>  	return ERR_PTR(ret);
>  }
>  
> +#ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
> +static int image_verify_sig(const char *kernel, unsigned long kernel_len)
> +{
> +	return verify_pefile_signature(kernel, kernel_len, NULL,
> +				       VERIFYING_KEXEC_PE_SIGNATURE);
> +}
> +#endif

This is identical to x86's PE image verification helper. We can clean this up
later by providing some kexec_image_verify_pe() in the core kexec_file code. Its
not worth doing now.


>  const struct kexec_file_ops kexec_image_ops = {
>  	.probe = image_probe,
>  	.load = image_load,
> +#ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
> +	.verify_sig = image_verify_sig,
> +#endif
>  };


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
