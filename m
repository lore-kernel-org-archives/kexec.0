From: Baoquan He <bhe@redhat.com>
Date: Thu, 12 May 2022 15:21:54 +0800
Subject: [PATCH v8 2/4] kexec, KEYS: make the code in
 bzImage64_verify_sig generic
In-Reply-To: <20220512070123.29486-3-coxu@redhat.com>
References: <20220512070123.29486-1-coxu@redhat.com>
 <20220512070123.29486-3-coxu@redhat.com>
Message-ID: <Yny1kqrkgQ9u7h8L@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 05/12/22 at 03:01pm, Coiby Xu wrote:
> commit 278311e417be ("kexec, KEYS: Make use of platform keyring for
> signature verify") adds platform keyring support on x86 kexec but not
> arm64.
> 
> The code in bzImage64_verify_sig makes use of system keyrings including
> .buitin_trusted_keys, .secondary_trusted_keys and .platform keyring to
> verify signed kernel image as PE file. Make it generic so both x86_64
> and arm64 can use it.

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Cc: kexec at lists.infradead.org
> Cc: keyrings at vger.kernel.org
> Cc: linux-security-module at vger.kernel.org
> Reviewed-by: Michal Suchanek <msuchanek@suse.de>
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  arch/x86/kernel/kexec-bzimage64.c | 20 +-------------------
>  include/linux/kexec.h             |  7 +++++++
>  kernel/kexec_file.c               | 17 +++++++++++++++++
>  3 files changed, 25 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 170d0fd68b1f..f299b48f9c9f 100644
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
> @@ -528,28 +527,11 @@ static int bzImage64_cleanup(void *loader_data)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
> -static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
> -{
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
> -}
> -#endif
> -
>  const struct kexec_file_ops kexec_bzImage64_ops = {
>  	.probe = bzImage64_probe,
>  	.load = bzImage64_load,
>  	.cleanup = bzImage64_cleanup,
>  #ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
> -	.verify_sig = bzImage64_verify_sig,
> +	.verify_sig = kexec_kernel_verify_pe_sig,
>  #endif
>  };
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 413235c6c797..da83abfc628b 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -19,6 +19,7 @@
>  #include <asm/io.h>
>  
>  #include <uapi/linux/kexec.h>
> +#include <linux/verification.h>
>  
>  /* Location of a reserved region to hold the crash kernel.
>   */
> @@ -202,6 +203,12 @@ int arch_kexec_apply_relocations(struct purgatory_info *pi,
>  				 const Elf_Shdr *relsec,
>  				 const Elf_Shdr *symtab);
>  int arch_kimage_file_post_load_cleanup(struct kimage *image);
> +#ifdef CONFIG_KEXEC_SIG
> +#ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
> +int kexec_kernel_verify_pe_sig(const char *kernel,
> +				    unsigned long kernel_len);
> +#endif
> +#endif
>  int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
>  
>  extern int kexec_add_buffer(struct kexec_buf *kbuf);
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 3720435807eb..754885b96aab 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -165,6 +165,23 @@ void kimage_file_post_load_cleanup(struct kimage *image)
>  }
>  
>  #ifdef CONFIG_KEXEC_SIG
> +#ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
> +int kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len)
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
> +
>  static int kexec_image_verify_sig(struct kimage *image, void *buf,
>  		unsigned long buf_len)
>  {
> -- 
> 2.35.3
> 


