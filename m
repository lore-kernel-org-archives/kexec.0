Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVvV3-00EGZr-DO
 for kexec@lists.infradead.org; Thu, 30 Sep 2021 12:49:23 +0000
Date: Thu, 30 Sep 2021 20:49:02 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 1/2] kexec, KEYS: make the code in bzImage64_verify_sig
 public
Message-ID: <YVWyPu3pDvnEfATe@dhcp-128-65.nay.redhat.com>
References: <20210927005004.36367-1-coiby.xu@gmail.com>
 <20210927005004.36367-2-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210927005004.36367-2-coiby.xu@gmail.com>
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
To: Coiby Xu <coiby.xu@gmail.com>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Coiby Xu <coxu@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Eric Biederman <ebiederm@xmission.com>, "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>

Hi Coiby,
On 09/27/21 at 08:50am, Coiby Xu wrote:
> From: Coiby Xu <coxu@redhat.com>
> 
> The code in bzImage64_verify_sig could make use of system keyrings including
> .buitin_trusted_keys, .secondary_trusted_keys and .platform keyring to verify
> signed kernel image as PE file. Move it to a public function.
> 
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>  arch/x86/kernel/kexec-bzimage64.c | 13 +------------
>  include/linux/kexec.h             |  3 +++
>  kernel/kexec_file.c               | 15 +++++++++++++++
>  3 files changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 170d0fd68b1f..4136dd3be5a9 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -17,7 +17,6 @@
>  #include <linux/kernel.h>
>  #include <linux/mm.h>
>  #include <linux/efi.h>
> -#include <linux/verification.h>
>  
>  #include <asm/bootparam.h>
>  #include <asm/setup.h>
> @@ -531,17 +530,7 @@ static int bzImage64_cleanup(void *loader_data)
>  #ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
>  static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
>  {
> -	int ret;
> -
> -	ret = verify_pefile_signature(kernel, kernel_len,
> -				      VERIFY_USE_SECONDARY_KEYRING,
> -				      VERIFYING_KEXEC_PE_SIGNATURE);
> -	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
> -		ret = verify_pefile_signature(kernel, kernel_len,
> -					      VERIFY_USE_PLATFORM_KEYRING,
> -					      VERIFYING_KEXEC_PE_SIGNATURE);
> -	}
> -	return ret;
> +	return arch_kexec_kernel_verify_pe_sig(kernel, kernel_len);
>  }
>  #endif
>  
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 0c994ae37729..d45f32336dbe 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -19,6 +19,7 @@
>  #include <asm/io.h>
>  
>  #include <uapi/linux/kexec.h>
> +#include <linux/verification.h>
>  
>  #ifdef CONFIG_KEXEC_CORE
>  #include <linux/list.h>
> @@ -199,6 +200,8 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image);
>  #ifdef CONFIG_KEXEC_SIG
>  int arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
>  				 unsigned long buf_len);
> +int arch_kexec_kernel_verify_pe_sig(const char *kernel,
> +				    unsigned long kernel_len);
>  #endif
>  int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
>  
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 33400ff051a8..85ed6984ad8f 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -106,6 +106,21 @@ int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
>  {
>  	return kexec_image_verify_sig_default(image, buf, buf_len);
>  }
> +
> +int arch_kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len)
> +{
> +	int ret;
> +
> +	ret = verify_pefile_signature(kernel, kernel_len,
> +				      VERIFY_USE_SECONDARY_KEYRING,
> +				      VERIFYING_KEXEC_PE_SIGNATURE);
> +	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
> +		ret = verify_pefile_signature(kernel, kernel_len,
> +					      VERIFY_USE_PLATFORM_KEYRING,
> +					      VERIFYING_KEXEC_PE_SIGNATURE);
> +	}
> +	return ret;
> +}

Since the function is moved as generic code, the kconfig option
CONFIG_KEXEC_BZIMAGE_VERIFY_SIG can be removed.

Instead a CONFIG_KEXEC_PEFILE_VERIFY_SIG can be added so that it does
not need to be compiled for only platform which support UEFI pefile
signature verification.  And the related arch kexec_file kconfig can
just select it.

Coiby, can you try above?

>  #endif
>  
>  /*
> -- 
> 2.33.0
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 
> 

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
