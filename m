Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VgdCU-0005Ja-5N
 for kexec@lists.infradead.org; Wed, 13 Nov 2013 16:21:55 +0000
Message-ID: <5283A6DD.2030808@zytor.com>
Date: Wed, 13 Nov 2013 08:20:45 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [patch 7/7 v2] x86: add xloadflags bit for efi runtime support
 on kexec
References: <20131105082007.872550445@dhcp-16-126.nay.redhat.com>
 <20131105082719.416282009@dhcp-16-126.nay.redhat.com>
In-Reply-To: <20131105082719.416282009@dhcp-16-126.nay.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: dyoung@redhat.com, linux-kernel@vger.kernel.org
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, vgoyal@redhat.com

On 11/05/2013 12:20 AM, dyoung@redhat.com wrote:
> Old kexec-tools can not load new kernel. The reason is previously kexec-tools
> do not fill efi_info in x86 setup header thus efi init fail and switch
> to noefi boot. In new kexec-tools it will by default fill efi_info and
> pass other efi required infomation to 2nd kernel so kexec kernel efi
> initialization will success finally.
> 
> To prevent from breaking userspace, add a new xloadflags bit so kexec-tools
> will check the flag and switch to old logic.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  arch/x86/boot/header.S                |    9 ++++++++-
>  arch/x86/include/uapi/asm/bootparam.h |    1 +
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> --- linux-2.6.orig/arch/x86/boot/header.S
> +++ linux-2.6/arch/x86/boot/header.S
> @@ -391,7 +391,14 @@ xloadflags:
>  #else
>  # define XLF23 0
>  #endif
> -			.word XLF0 | XLF1 | XLF23
> +
> +#if defined(CONFIG_X86_64) && defined(CONFIG_EFI)
> +# define XLF4 XLF_EFI_KEXEC
> +#else
> +# define XLF4 0
> +#endif
> +
> +			.word XLF0 | XLF1 | XLF23 | XLF4
>  
>  cmdline_size:   .long   COMMAND_LINE_SIZE-1     #length of the command line,
>                                                  #added with boot protocol
> --- linux-2.6.orig/arch/x86/include/uapi/asm/bootparam.h
> +++ linux-2.6/arch/x86/include/uapi/asm/bootparam.h
> @@ -24,6 +24,7 @@
>  #define XLF_CAN_BE_LOADED_ABOVE_4G	(1<<1)
>  #define XLF_EFI_HANDOVER_32		(1<<2)
>  #define XLF_EFI_HANDOVER_64		(1<<3)
> +#define XLF_EFI_KEXEC			(1<<4)
>  
>  #ifndef __ASSEMBLY__
>  
> 

Also needs to be added to Documentation/x86/boot.txt with the exact
semantics being exposed.

	-hpa


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
