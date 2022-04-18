From: Baoquan He <bhe@redhat.com>
Date: Mon, 18 Apr 2022 10:14:31 +0800
Subject: [PATCH v6 3/4] arm64: kexec_file: use more system keyrings to
 verify kernel image signature
In-Reply-To: <20220414014344.228523-4-coxu@redhat.com>
References: <20220414014344.228523-1-coxu@redhat.com>
 <20220414014344.228523-4-coxu@redhat.com>
Message-ID: <YlzJh8SE8pV1Et+O@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 04/14/22 at 09:43am, Coiby Xu wrote:
> Currently, a problem faced by arm64 is if a kernel image is signed by a
> MOK key, loading it via the kexec_file_load() system call would be
> rejected with the error "Lockdown: kexec: kexec of unsigned images is
> restricted; see man kernel_lockdown.7".
> 
> This happens because image_verify_sig uses only the primary keyring that
> contains only kernel built-in keys to verify the kexec image.
> 
> This patch allows to verify arm64 kernel image signature using not only
> .builtin_trusted_keys but also .platform and .secondary_trusted_keys
> keyring.
> 
> Fixes: 732b7b93d849 ("arm64: kexec_file: add kernel signature verification support")

Cc stable?

Otherwise, LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> Cc: kexec at lists.infradead.org
> Cc: keyrings at vger.kernel.org
> Cc: linux-security-module at vger.kernel.org
> Cc: stable at kernel.org
> Co-developed-by: Michal Suchanek <msuchanek@suse.de>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> Acked-by: Will Deacon <will@kernel.org>
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  arch/arm64/kernel/kexec_image.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> index 9ec34690e255..5ed6a585f21f 100644
> --- a/arch/arm64/kernel/kexec_image.c
> +++ b/arch/arm64/kernel/kexec_image.c
> @@ -14,7 +14,6 @@
>  #include <linux/kexec.h>
>  #include <linux/pe.h>
>  #include <linux/string.h>
> -#include <linux/verification.h>
>  #include <asm/byteorder.h>
>  #include <asm/cpufeature.h>
>  #include <asm/image.h>
> @@ -130,18 +129,10 @@ static void *image_load(struct kimage *image,
>  	return NULL;
>  }
>  
> -#ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
> -static int image_verify_sig(const char *kernel, unsigned long kernel_len)
> -{
> -	return verify_pefile_signature(kernel, kernel_len, NULL,
> -				       VERIFYING_KEXEC_PE_SIGNATURE);
> -}
> -#endif
> -
>  const struct kexec_file_ops kexec_image_ops = {
>  	.probe = image_probe,
>  	.load = image_load,
>  #ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
> -	.verify_sig = image_verify_sig,
> +	.verify_sig = kexec_kernel_verify_pe_sig,
>  #endif
>  };
> -- 
> 2.34.1
> 
> 


