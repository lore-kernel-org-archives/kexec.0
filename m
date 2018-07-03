Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v10 13/14] arm64: kexec_file: add kernel signature
 verification support
References: <20180623022058.10935-1-takahiro.akashi@linaro.org>
 <20180623022058.10935-14-takahiro.akashi@linaro.org>
From: James Morse <james.morse@arm.com>
Message-ID: <ff77f2d9-82c6-8fbb-3696-e1fcfd61c333@arm.com>
Date: Tue, 3 Jul 2018 18:47:38 +0100
MIME-Version: 1.0
In-Reply-To: <20180623022058.10935-14-takahiro.akashi@linaro.org>
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
> With this patch, kernel verification can be done without IMA security
> subsystem enabled. Turn on CONFIG_KEXEC_VERIFY_SIG instead.
> 
> On x86, a signature is embedded into a PE file (Microsoft's format) header
> of binary. Since arm64's "Image" can also be seen as a PE file as far as
> CONFIG_EFI is enabled, we adopt this format for kernel signing.
> 
> You can create a signed kernel image with:
>     $ sbsign --key ${KEY} --cert ${CERT} Image

> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index f68318f61c85..5133c22a01ab 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -845,6 +845,30 @@ config KEXEC_FILE
>  	  for kernel and initramfs as opposed to list of segments as
>  	  accepted by previous system call.
>  
> +config KEXEC_VERIFY_SIG
> +	bool "Verify kernel signature during kexec_file_load() syscall"
> +	depends on KEXEC_FILE
> +	help
> +	  Select this option to verify a signature with loaded kernel
> +	  image. If configured, any attempt of loading a image without
> +	  valid signature will fail.
> +
> +	  In addition to that option, you need to enable signature
> +	  verification for the corresponding kernel image type being
> +	  loaded in order for this to work.
> +
> +config KEXEC_IMAGE_VERIFY_SIG
> +	bool "Enable Image signature verification support"
> +	default y
> +	depends on KEXEC_VERIFY_SIG
> +	depends on EFI && SIGNED_PE_FILE_VERIFICATION
> +	help
> +	  Enable Image signature verification support.
> +
> +comment "Image signature verification is missing yet"
> +	depends on KEXEC_VERIFY_SIG
> +	depends on !EFI || !SIGNED_PE_FILE_VERIFICATION


This comment thing is a good idea, but its also a bit confusing... it took me
quite a while to work out what was missing. Could we phrase it something like:
"Support for PE file signature verification disabled!"
This tells us its about PE files, and its probably a missing config option
somewhere, not some code that hasn't been written yet. (which was my first
assumption!).

KEXEC_VERIFY_SIG presumably turns on just the IMA verification, which verifies
the Image, but not in the same way as KEXEC_IMAGE_VERIFY_SIG.... (if I've
understood it properly) Is there any reason to have these as separate enables?
Couldn't we 'select SIGNED_PE_FILE_VERIFICATION if EFI' in KEXEC_VERIFY_SIG?
This would mean there is one option to verify signatures, instead of two...
(does it really depend on EFI?)


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
