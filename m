Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WxI2B-0006bi-RU
 for kexec@lists.infradead.org; Wed, 18 Jun 2014 15:44:24 +0000
Date: Wed, 18 Jun 2014 17:43:55 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 13/13] kexec: Support kexec/kdump on EFI systems
Message-ID: <20140618154355.GH24024@pd.tnic>
References: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
 <1401800822-27425-14-git-send-email-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1401800822-27425-14-git-send-email-vgoyal@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: mjg59@srcf.ucam.org, bhe@redhat.com, jkosina@suse.cz, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, dyoung@redhat.com, chaowang@redhat.com

On Tue, Jun 03, 2014 at 09:07:02AM -0400, Vivek Goyal wrote:
> This patch does two thigns. It passes EFI run time mappings to second
> kernel in bootparams efi_info. Second kernel parse this info and create
> new mappings in second kernel. That means mappings in first and second
> kernel will be same. This paves the way to enable EFI in kexec kernel.
> 
> This patch also prepares and passes EFI setup data through bootparams.
> This contains bunch of information about various tables and their
> addresses.
> 
> These information gathering and passing has been written along the lines
> of what current kexec-tools is doing to make kexec work with UEFI.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  arch/x86/include/asm/kexec.h       |  4 +-
>  arch/x86/kernel/kexec-bzimage.c    | 40 ++++++++++++----
>  arch/x86/kernel/machine_kexec.c    | 93 ++++++++++++++++++++++++++++++++++++--
>  drivers/firmware/efi/runtime-map.c | 21 +++++++++
>  include/linux/efi.h                | 19 ++++++++
>  5 files changed, 163 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
> index 4cbe5f7..d8461cf 100644
> --- a/arch/x86/include/asm/kexec.h
> +++ b/arch/x86/include/asm/kexec.h
> @@ -214,7 +214,9 @@ extern int kexec_setup_cmdline(struct kimage *image,
>  		unsigned long cmdline_offset, char *cmdline,
>  		unsigned long cmdline_len);
>  extern int kexec_setup_boot_parameters(struct kimage *image,
> -					struct boot_params *params);
> +		struct boot_params *params, unsigned long params_load_addr,
> +		unsigned int efi_map_offset, unsigned int efi_map_sz,
> +		unsigned int efi_setup_data_offset);
>  
>  
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/x86/kernel/kexec-bzimage.c b/arch/x86/kernel/kexec-bzimage.c
> index 8e762d3..55716e1 100644
> --- a/arch/x86/kernel/kexec-bzimage.c
> +++ b/arch/x86/kernel/kexec-bzimage.c
> @@ -15,10 +15,12 @@
>  #include <linux/kexec.h>
>  #include <linux/kernel.h>
>  #include <linux/mm.h>
> +#include <linux/efi.h>
>  
>  #include <asm/bootparam.h>
>  #include <asm/setup.h>
>  #include <asm/crash.h>
> +#include <asm/efi.h>
>  
>  #define MAX_ELFCOREHDR_STR_LEN	30	/* elfcorehdr=0x<64bit-value> */
>  
> @@ -106,7 +108,7 @@ void *bzImage64_load(struct kimage *image, char *kernel,
>  
>  	struct setup_header *header;
>  	int setup_sects, kern16_size, ret = 0;
> -	unsigned long setup_header_size, params_cmdline_sz;
> +	unsigned long setup_header_size, params_cmdline_sz, params_misc_sz;
>  	struct boot_params *params;
>  	unsigned long bootparam_load_addr, kernel_load_addr, initrd_load_addr;
>  	unsigned long purgatory_load_addr;
> @@ -116,6 +118,7 @@ void *bzImage64_load(struct kimage *image, char *kernel,
>  	struct kexec_entry64_regs regs64;
>  	void *stack;
>  	unsigned int setup_hdr_offset = offsetof(struct boot_params, hdr);
> +	unsigned int efi_map_offset, efi_map_sz, efi_setup_data_offset;
>  
>  	header = (struct setup_header *)(kernel + setup_hdr_offset);
>  	setup_sects = header->setup_sects;
> @@ -168,28 +171,47 @@ void *bzImage64_load(struct kimage *image, char *kernel,
>  
>  	pr_debug("Loaded purgatory at 0x%lx\n", purgatory_load_addr);
>  
> -	/* Load Bootparams and cmdline */
> +
> +	/*
> +	 * Load Bootparams and cmdline and space for efi stuff.
> +	 *
> +	 * Allocate memory together for multiple data structures so
> +	 * that they all can go in single area/segment and we don't
> +	 * have to create separate segment for each. Keeps things
> +	 * little bit simple
> +	 */
> +	efi_map_sz = get_efi_runtime_map_size();
> +	efi_map_sz = ALIGN(efi_map_sz, 16);

Yeah, those and the ones below should be inside #ifdef CONFIG_EFI,
strictly speaking. I see you've added dummy functions for the case when
EFI is not enabled to save yourself the ifdeffery. Hm, ok, I guess the
ifdeffery is uglier and the couple of bytes more is simply not worth the
trouble.

:-)

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
