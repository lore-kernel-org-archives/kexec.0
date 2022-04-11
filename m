From: Michal =?unknown-8bit?q?Such=C3=A1nek?= <msuchanek@suse.de>
Date: Mon, 11 Apr 2022 10:54:11 +0200
Subject: [PATCH v5 2/3] kexec, KEYS: make the code in
 bzImage64_verify_sig generic
In-Reply-To: <20220401013118.348084-3-coxu@redhat.com>
References: <20220401013118.348084-1-coxu@redhat.com>
 <20220401013118.348084-3-coxu@redhat.com>
Message-ID: <20220411085411.GZ163591@kunlun.suse.cz>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Fri, Apr 01, 2022 at 09:31:17AM +0800, Coiby Xu wrote:
> The code in bzImage64_verify_sig could make use of system keyrings
s/could make/makes/
> including .buitin_trusted_keys, .secondary_trusted_keys and .platform
> keyring to verify signed kernel image as PE file. Make it generic so
> both x86_64 and arm64 can use it.
> 
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  arch/x86/kernel/kexec-bzimage64.c | 13 +------------
>  include/linux/kexec.h             |  7 +++++++
>  kernel/kexec_file.c               | 17 +++++++++++++++++
>  3 files changed, 25 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 170d0fd68b1f..f73aab3fde33 100644
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
> +	return kexec_kernel_verify_pe_sig(kernel, kernel_len);
>  }

Maybe you can completely eliminate bzImage64_verify_sig and directly
assign kexec_kernel_verify_pe_sig to the fops?

Other than that

Reviewed-by: Michal Suchanek <msuchanek@suse.de>

>  #endif
>  
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 755fed183224..2fe39e946988 100644
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
> @@ -196,6 +197,12 @@ int arch_kexec_apply_relocations(struct purgatory_info *pi,
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
> 2.34.1
> 

