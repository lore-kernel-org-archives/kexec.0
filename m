Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Fri, 2 Mar 2018 13:58:59 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 1/7] kexec_file: make an use of purgatory optional
Message-ID: <20180302055859.GB15422@dhcp-128-65.nay.redhat.com>
References: <20180227044814.24808-1-takahiro.akashi@linaro.org>
 <20180227044814.24808-2-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180227044814.24808-2-takahiro.akashi@linaro.org>
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
Cc: linux-s390@vger.kernel.org, prudo@linux.vnet.ibm.com, bhe@redhat.com, mpe@ellerman.id.au, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bauerman@linux.vnet.ibm.com, vgoyal@redhat.com

On 02/27/18 at 01:48pm, AKASHI Takahiro wrote:
> On arm64, crash dump kernel's usable memory is protected by
> *unmapping* it from kernel virtual space unlike other architectures
> where the region is just made read-only. It is highly unlikely that
> the region is accidentally corrupted and this observation rationalizes
> that digest check code can also be dropped from purgatory.
> The resulting code is so simple as it doesn't require a bit ugly
> re-linking/relocation stuff, i.e. arch_kexec_apply_relocations_add().
> 
> Please see:
>    http://lists.infradead.org/pipermail/linux-arm-kernel/2017-December/545428.html
> All that the purgatory does is to shuffle arguments and jump into a new
> kernel, while we still need to have some space for a hash value
> (purgatory_sha256_digest) which is never checked against.
> 
> As such, it doesn't make sense to have trampline code between old kernel
> and new kernel on arm64.
> 
> This patch introduces a new configuration, ARCH_HAS_KEXEC_PURGATORY, and
> allows related code to be compiled in only if necessary.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> ---
>  arch/powerpc/Kconfig | 3 +++
>  arch/x86/Kconfig     | 3 +++
>  kernel/kexec_file.c  | 6 ++++++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 73ce5dd07642..c32a181a7cbb 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -552,6 +552,9 @@ config KEXEC_FILE
>  	  for kernel and initramfs as opposed to a list of segments as is the
>  	  case for the older kexec call.
>  
> +config ARCH_HAS_KEXEC_PURGATORY
> +	def_bool KEXEC_FILE
> +
>  config RELOCATABLE
>  	bool "Build a relocatable kernel"
>  	depends on PPC64 || (FLATMEM && (44x || FSL_BOOKE))
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index c1236b187824..f031c3efe47e 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2019,6 +2019,9 @@ config KEXEC_FILE
>  	  for kernel and initramfs as opposed to list of segments as
>  	  accepted by previous system call.
>  
> +config ARCH_HAS_KEXEC_PURGATORY
> +	def_bool KEXEC_FILE
> +
>  config KEXEC_VERIFY_SIG
>  	bool "Verify kernel signature during kexec_file_load() syscall"
>  	depends on KEXEC_FILE
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index e5bcd94c1efb..990adae52151 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -26,7 +26,11 @@
>  #include <linux/vmalloc.h>
>  #include "kexec_internal.h"
>  
> +#ifdef CONFIG_ARCH_HAS_KEXEC_PURGATORY
>  static int kexec_calculate_store_digests(struct kimage *image);
> +#else
> +static int kexec_calculate_store_digests(struct kimage *image) { return 0; };
> +#endif
>  
>  /* Architectures can provide this probe function */
>  int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
> @@ -520,6 +524,7 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_ARCH_HAS_KEXEC_PURGATORY
>  /* Calculate and store the digest of segments */
>  static int kexec_calculate_store_digests(struct kimage *image)
>  {
> @@ -1022,3 +1027,4 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
>  
>  	return 0;
>  }
> +#endif /* CONFIG_ARCH_HAS_KEXEC_PURGATORY */
> -- 
> 2.16.2
> 

For this one, I think purgatory digest verification is still good to
have, but I do not insist since this is arch specific.

If nobody else objects then I think I can ack the series after some
testing passed.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
