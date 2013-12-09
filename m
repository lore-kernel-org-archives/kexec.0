Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vq2P8-0007aw-0U
 for kexec@lists.infradead.org; Mon, 09 Dec 2013 15:05:53 +0000
Date: Mon, 9 Dec 2013 16:05:21 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 01/14] x86/mm: sparse warning fix for early_memremap
Message-ID: <20131209150521.GE31650@pd.tnic>
References: <1386582147-9802-1-git-send-email-dyoung@redhat.com>
 <1386582147-9802-2-git-send-email-dyoung@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1386582147-9802-2-git-send-email-dyoung@redhat.com>
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
To: Dave Young <dyoung@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, ebiederm@xmission.com, vgoyal@redhat.com

On Mon, Dec 09, 2013 at 05:42:14PM +0800, Dave Young wrote:
> There's a lot of sparse warnings for code like below:
> void *a = early_memremap(phys_addr, size);
> 
> early_memremap intend to map kernel memory with ioremap facility, the return
> pointer should be a kernel ram pointer instead of iomem one.
> 
> For making the function clearer and supressing sparse warnings this patch
> do below two things:
> 1. cast to (__force void *) for the return value of early_memremap

I'd guess this is to shut up the __iomem thing? And we're getting that
because we're using ioremap, ... hohum...

> 2. add early_memunmap function and pass (__force void __iomem *) to iounmap
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  arch/x86/include/asm/io.h |  3 ++-
>  arch/x86/mm/ioremap.c     | 10 +++++++---
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
> index 34f69cb..1db414f 100644
> --- a/arch/x86/include/asm/io.h
> +++ b/arch/x86/include/asm/io.h
> @@ -325,9 +325,10 @@ extern void early_ioremap_init(void);
>  extern void early_ioremap_reset(void);
>  extern void __iomem *early_ioremap(resource_size_t phys_addr,
>  				   unsigned long size);
> -extern void __iomem *early_memremap(resource_size_t phys_addr,
> +extern void *early_memremap(resource_size_t phys_addr,
>  				    unsigned long size);
>  extern void early_iounmap(void __iomem *addr, unsigned long size);
> +extern void early_memunmap(void *addr, unsigned long size);
>  extern void fixup_early_ioremap(void);
>  extern bool is_early_ioremap_ptep(pte_t *ptep);
>  
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index 799580c..bbb4504 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -562,10 +562,9 @@ early_ioremap(resource_size_t phys_addr, unsigned long size)
>  }
>  
>  /* Remap memory */
> -void __init __iomem *
> -early_memremap(resource_size_t phys_addr, unsigned long size)
> +void __init *early_memremap(resource_size_t phys_addr, unsigned long size)

Btw, the patch that added memremap was

commit 1494177942b23b7094ca291d37e6f6263fa60fdd
Author: Jeremy Fitzhardinge <jeremy@goop.org>
Date:   Sun Sep 7 15:21:15 2008 -0700

    x86: add early_memremap()


and AFAICR, the intention really was to do normal memory mapping through
ioremap.

Then

commit 1d6cf1feb854c53c6d59e0d879603692b379e208
Author: Harvey Harrison <harvey.harrison@gmail.com>
Date:   Tue Oct 28 22:46:04 2008 -0700

    x86: start annotating early ioremap pointers with __iomem

    Impact: some new sparse warnings in e820.c etc, but no functional change.

    As with regular ioremap, iounmap etc, annotate with __iomem.


went and added the __iomem sparse attributes annotation which doesn't
make any sense to me since the original intention of memremap was to
give *normal* memory and not io memory. IOW, memory we can *certainly*
*deref* and which is in the same address space so __iomem is completely
wrong and ass backwards to put there.

But I'm not all that sure.

hpa, Ingo, what do you guys think?

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
