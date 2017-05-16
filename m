Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1dAgOM-0005Ti-Pk
 for kexec@lists.infradead.org; Tue, 16 May 2017 17:36:17 +0000
Date: Tue, 16 May 2017 19:35:41 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 26/32] x86, drm, fbdev: Do not specify encrypted
 memory for video mappings
Message-ID: <20170516173541.q2rbh5dhkluzsjae@pd.tnic>
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418212056.10190.25468.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170418212056.10190.25468.stgit@tlendack-t1.amdoffice.net>
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
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, x86@kernel.org, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Apr 18, 2017 at 04:20:56PM -0500, Tom Lendacky wrote:
> Since video memory needs to be accessed decrypted, be sure that the
> memory encryption mask is not set for the video ranges.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/include/asm/vga.h       |   13 +++++++++++++
>  arch/x86/mm/pageattr.c           |    2 ++
>  drivers/gpu/drm/drm_gem.c        |    2 ++
>  drivers/gpu/drm/drm_vm.c         |    4 ++++
>  drivers/gpu/drm/ttm/ttm_bo_vm.c  |    7 +++++--
>  drivers/gpu/drm/udl/udl_fb.c     |    4 ++++
>  drivers/video/fbdev/core/fbmem.c |   12 ++++++++++++
>  7 files changed, 42 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/vga.h b/arch/x86/include/asm/vga.h
> index c4b9dc2..5c7567a 100644
> --- a/arch/x86/include/asm/vga.h
> +++ b/arch/x86/include/asm/vga.h
> @@ -7,12 +7,25 @@
>  #ifndef _ASM_X86_VGA_H
>  #define _ASM_X86_VGA_H
>  
> +#include <asm/cacheflush.h>
> +
>  /*
>   *	On the PC, we can just recalculate addresses and then
>   *	access the videoram directly without any black magic.
> + *	To support memory encryption however, we need to access
> + *	the videoram as decrypted memory.
>   */
>  
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +#define VGA_MAP_MEM(x, s)					\
> +({								\
> +	unsigned long start = (unsigned long)phys_to_virt(x);	\
> +	set_memory_decrypted(start, (s) >> PAGE_SHIFT);		\
> +	start;							\
> +})
> +#else
>  #define VGA_MAP_MEM(x, s) (unsigned long)phys_to_virt(x)
> +#endif

Can we push the check in and save us the ifdeffery?

#define VGA_MAP_MEM(x, s)                                       \
({                                                              \
        unsigned long start = (unsigned long)phys_to_virt(x);   \
                                                                \
        if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))                 \
                set_memory_decrypted(start, (s) >> PAGE_SHIFT); \
                                                                \
        start;                                                  \
})

It does build here. :)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
