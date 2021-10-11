Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20211009095458.297191-1-coxu@redhat.com>
 <20211009095458.297191-2-coxu@redhat.com>
Date: Mon, 11 Oct 2021 08:58:36 -0500
In-Reply-To: <20211009095458.297191-2-coxu@redhat.com> (Coiby Xu's message of
 "Sat, 9 Oct 2021 17:54:57 +0800")
Message-ID: <87ily3br3n.fsf@disp2133>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] kexec,
 KEYS: make the code in bzImage64_verify_sig generic
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
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "open list:X86 ARCHITECTURE 32-BIT AND 64-BIT" <linux-kernel@vger.kernel.org>

Coiby Xu <coxu@redhat.com> writes:

> The code in bzImage64_verify_sig could make use of system keyrings including
> .buitin_trusted_keys, .secondary_trusted_keys and .platform keyring to verify
> signed kernel image as PE file. Make it generic so both x86_64 and arm64 can 
> use it.

The naming is problematic.

At a minimum please name the new function kexec_kernel_verify_pe_sig.
AKA what you named it without the "arch_" prefix.  A function named with
an "arch_" prefix  implies that it has an architecture specific
implementation.

It looks like arch_kexec_kernel_verify_sig should be killed as well
as it only has one implementation in the generic code.  And the code
should always call kexec_image_verify_sig_default.  Not that you should
do that but I am pointing it out as it seems that is the bad example you
are copying.

Eric

> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  arch/x86/kernel/kexec-bzimage64.c | 13 +------------
>  include/linux/kexec.h             |  3 +++
>  kernel/kexec_file.c               | 17 +++++++++++++++++
>  3 files changed, 21 insertions(+), 12 deletions(-)
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
> index 33400ff051a8..0530275b7aa3 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -106,6 +106,23 @@ int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
>  {
>  	return kexec_image_verify_sig_default(image, buf, buf_len);
>  }
> +
> +#ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
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
> +#endif
>  #endif
>  
>  /*

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
