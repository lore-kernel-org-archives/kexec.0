Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h1Swa-0002at-JN
 for kexec@lists.infradead.org; Wed, 06 Mar 2019 09:34:34 +0000
Date: Wed, 6 Mar 2019 17:34:23 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v2] x86: Introduce a new option --reuse-video-type
Message-ID: <20190306093423.GA6947@dhcp-128-65.nay.redhat.com>
References: <20190305113433.20628-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190305113433.20628-1-kasong@redhat.com>
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
To: Kairui Song <kasong@redhat.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

On 03/05/19 at 07:34pm, Kairui Song wrote:
> After commit 060eee58 "x86: use old screen_info if needed", kexec-tools
> will force use old screen_info and vga type if failed to determine
> current vga type. But it is not always a good idea.
> 
> Currently kernel hanging is inspected on some hyper-v VMs after this
> commit, because hyperv_fb will mimic EFI (or VESA) VGA on first boot
> up, but after the real driver is loaded, it will switch to new mode
> and no longer compatible with EFI/VESA VGA. Keep setting
> orig_video_isVGA to EFI/VESA VGA flag will get wrong driver loaded and
> try to manipulate the framebuffer in a wrong way.
> 
> We can't ensure this won't happen on other framebuffer drivers, But
> it's a helpful feature if the framebuffer drivers just work. So this
> patch introduce a --reuse-video-type options to let user decide if the
> old screen_info hould be used unconditional or not.
> 
> Signed-off-by: Kairui Song <kasong@redhat.com>
> 
> ---
> 
> Update from V1:
> - Fix a fd leak
> - Rename the option from --force-vga to --reuse-video-type
> 
>  kexec/arch/i386/include/arch/options.h | 2 ++
>  kexec/arch/i386/kexec-x86.h            | 1 +
>  kexec/arch/i386/x86-linux-setup.c      | 8 ++++++--
>  kexec/arch/x86_64/kexec-x86_64.c       | 5 +++++
>  4 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/kexec/arch/i386/include/arch/options.h b/kexec/arch/i386/include/arch/options.h
> index c113a83..0e57951 100644
> --- a/kexec/arch/i386/include/arch/options.h
> +++ b/kexec/arch/i386/include/arch/options.h
> @@ -32,6 +32,7 @@
>  #define OPT_ENTRY_32BIT		(OPT_ARCH_MAX+10)
>  #define OPT_PASS_MEMMAP_CMDLINE	(OPT_ARCH_MAX+11)
>  #define OPT_NOEFI		(OPT_ARCH_MAX+12)
> +#define OPT_REUSE_VIDEO_TYPE	(OPT_ARCH_MAX+13)
>  
>  /* Options relevant to the architecture (excluding loader-specific ones): */
>  #define KEXEC_ARCH_OPTIONS \
> @@ -45,6 +46,7 @@
>  	{ "elf64-core-headers", 0, 0, OPT_ELF64_CORE }, \
>  	{ "pass-memmap-cmdline", 0, 0, OPT_PASS_MEMMAP_CMDLINE }, \
>  	{ "noefi", 0, 0, OPT_NOEFI}, \
> +	{ "reuse-video-type", 0, 0, OPT_REUSE_VIDEO_TYPE },	\
>  
>  #define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR ""
>  
> diff --git a/kexec/arch/i386/kexec-x86.h b/kexec/arch/i386/kexec-x86.h
> index 51855f8..c2bcd37 100644
> --- a/kexec/arch/i386/kexec-x86.h
> +++ b/kexec/arch/i386/kexec-x86.h
> @@ -52,6 +52,7 @@ struct arch_options_t {
>  	enum coretype	core_header_type;
>  	uint8_t  	pass_memmap_cmdline;
>  	uint8_t		noefi;
> +	uint8_t		reuse_video_type;
>  };
>  
>  int multiboot_x86_probe(const char *buf, off_t len);
> diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
> index 1bd408b..8fad115 100644
> --- a/kexec/arch/i386/x86-linux-setup.c
> +++ b/kexec/arch/i386/x86-linux-setup.c
> @@ -144,7 +144,7 @@ static int setup_linux_vesafb(struct x86_linux_param_header *real_mode)
>  	} else if (0 == strcmp(fix.id, "EFI VGA")) {
>  		/* VIDEO_TYPE_EFI */
>  		real_mode->orig_video_isVGA = 0x70;
> -	} else {
> +	} else if (arch_options.reuse_video_type) {
>  		int err;
>  		off_t offset = offsetof(typeof(*real_mode), orig_video_isVGA);
>  
> @@ -152,6 +152,10 @@ static int setup_linux_vesafb(struct x86_linux_param_header *real_mode)
>  		err = get_bootparam(&real_mode->orig_video_isVGA, offset, 1);
>  		if (err)
>  			goto out;
> +	} else {
> +		real_mode->orig_video_isVGA = 0;
> +		close(fd);
> +		return 0;
>  	}
>  	close(fd);
>  
> @@ -844,7 +848,7 @@ void setup_linux_system_parameters(struct kexec_info *info,
>  	setup_subarch(real_mode);
>  	if (bzImage_support_efi_boot && !arch_options.noefi)
>  		setup_efi_info(info, real_mode);
> -	
> +
>  	/* Default screen size */
>  	real_mode->orig_x = 0;
>  	real_mode->orig_y = 0;
> diff --git a/kexec/arch/x86_64/kexec-x86_64.c b/kexec/arch/x86_64/kexec-x86_64.c
> index 041b007..ccdc980 100644
> --- a/kexec/arch/x86_64/kexec-x86_64.c
> +++ b/kexec/arch/x86_64/kexec-x86_64.c
> @@ -55,6 +55,7 @@ void arch_usage(void)
>  		"     --console-serial          Enable the serial console\n"
>  		"     --pass-memmap-cmdline     Pass memory map via command line in kexec on panic case\n"
>  		"     --noefi                   Disable efi support\n"
> +		"     --reuse-video-type        Reuse old boot time video type blindly\n"
>  		);
>  }
>  
> @@ -67,6 +68,7 @@ struct arch_options_t arch_options = {
>  	.core_header_type = CORE_TYPE_ELF64,
>  	.pass_memmap_cmdline = 0,
>  	.noefi = 0,
> +	.reuse_video_type = 0,
>  };
>  
>  int arch_process_options(int argc, char **argv)
> @@ -136,6 +138,9 @@ int arch_process_options(int argc, char **argv)
>  		case OPT_NOEFI:
>  			arch_options.noefi = 1;
>  			break;
> +		case OPT_REUSE_VIDEO_TYPE:
> +			arch_options.reuse_video_type = 1;
> +			break;
>  		}
>  	}
>  	/* Reset getopt for the next pass; called in other source modules */
> -- 
> 2.20.1
> 

Reviewed-by: Dave Young <dyoung@redhat.com>

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
