Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dNZsR-0004BN-Fn
 for kexec@lists.infradead.org; Wed, 21 Jun 2017 07:16:37 +0000
Date: Wed, 21 Jun 2017 09:16:05 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v7 08/36] x86/mm: Add support to enable SME in early boot
 processing
In-Reply-To: <20170616185115.18967.79622.stgit@tlendack-t1.amdoffice.net>
Message-ID: <alpine.DEB.2.20.1706202259290.2157@nanos>
References: <20170616184947.18967.84890.stgit@tlendack-t1.amdoffice.net>
 <20170616185115.18967.79622.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
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
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, linux-doc@vger.kernel.org, Matt Fleming <matt@codeblueprint.co.uk>, x86@kernel.org, linux-mm@kvack.org, =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, "Michael S. Tsirkin" <mst@redhat.com>, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, Juergen Gross <jgross@suse.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, xen-devel@lists.xen.org, iommu@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>

On Fri, 16 Jun 2017, Tom Lendacky wrote:
> diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
> index a105796..988b336 100644
> --- a/arch/x86/include/asm/mem_encrypt.h
> +++ b/arch/x86/include/asm/mem_encrypt.h
> @@ -15,16 +15,24 @@
>  
>  #ifndef __ASSEMBLY__
>  
> +#include <linux/init.h>
> +
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  
>  extern unsigned long sme_me_mask;
>  
> +void __init sme_enable(void);
> +
>  #else	/* !CONFIG_AMD_MEM_ENCRYPT */
>  
>  #define sme_me_mask	0UL
>  
> +static inline void __init sme_enable(void) { }
> +
>  #endif	/* CONFIG_AMD_MEM_ENCRYPT */
>  
> +unsigned long sme_get_me_mask(void);

Why is this an unconditional function? Isn't the mask simply 0 when the MEM
ENCRYPT support is disabled?

> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index 6225550..ef12729 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -78,7 +78,29 @@ startup_64:
>  	call	__startup_64
>  	popq	%rsi
>  
> -	movq	$(early_top_pgt - __START_KERNEL_map), %rax
> +	/*
> +	 * Encrypt the kernel if SME is active.
> +	 * The real_mode_data address is in %rsi and that register can be
> +	 * clobbered by the called function so be sure to save it.
> +	 */
> +	push	%rsi
> +	call	sme_encrypt_kernel
> +	pop	%rsi

That does not make any sense. Neither the call to sme_encrypt_kernel() nor
the following call to sme_get_me_mask().

__startup_64() is already C code, so why can't you simply call that from
__startup_64() in C and return the mask from there?

> @@ -98,7 +120,20 @@ ENTRY(secondary_startup_64)
>  	/* Sanitize CPU configuration */
>  	call verify_cpu
>  
> -	movq	$(init_top_pgt - __START_KERNEL_map), %rax
> +	/*
> +	 * Get the SME encryption mask.
> +	 *  The encryption mask will be returned in %rax so we do an ADD
> +	 *  below to be sure that the encryption mask is part of the
> +	 *  value that will stored in %cr3.
> +	 *
> +	 * The real_mode_data address is in %rsi and that register can be
> +	 * clobbered by the called function so be sure to save it.
> +	 */
> +	push	%rsi
> +	call	sme_get_me_mask
> +	pop	%rsi

Do we really need a call here? The mask is established at this point, so
it's either 0 when the encryption stuff is not compiled in or it can be
retrieved from a variable which is accessible at this point.

> +
> +	addq	$(init_top_pgt - __START_KERNEL_map), %rax
>  1:
>  
>  	/* Enable PAE mode, PGE and LA57 */

Thanks,

	tglx

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
