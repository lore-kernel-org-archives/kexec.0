Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g4zSi-0003ZA-Pg
 for kexec@lists.infradead.org; Wed, 26 Sep 2018 02:22:04 +0000
Date: Wed, 26 Sep 2018 10:21:23 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/4 v7] x86/ioremap: add a function ioremap_encrypted()
 to remap kdump old memory
Message-ID: <20180926022123.GA2555@MiWiFi-R3L-srv>
References: <20180907081805.368-1-lijiang@redhat.com>
 <20180907081805.368-2-lijiang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180907081805.368-2-lijiang@redhat.com>
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
To: Lianbo Jiang <lijiang@redhat.com>
Cc: thomas.lendacky@amd.com, joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com

Hi Lianbo,

On 09/07/18 at 04:18pm, Lianbo Jiang wrote:
> When SME is enabled on AMD machine, the memory is encrypted in the first
> kernel. In this case, SME also needs to be enabled in kdump kernel, and
> we have to remap the old memory with the memory encryption mask.

This patch series looks good to me. One thing is in your v5 post, Boris
reviewed and complained about the git log, we worked together to make an
document to explain, wondering why you don't rearrange it into log of
this patch. Other than this, all looks fine.

http://lkml.kernel.org/r/53536964-2b57-4630-de91-3d4da2b643a8@redhat.com


> 
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  arch/x86/include/asm/io.h |  3 +++
>  arch/x86/mm/ioremap.c     | 25 +++++++++++++++++--------
>  2 files changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
> index 6de64840dd22..f8795f9581c7 100644
> --- a/arch/x86/include/asm/io.h
> +++ b/arch/x86/include/asm/io.h
> @@ -192,6 +192,9 @@ extern void __iomem *ioremap_cache(resource_size_t offset, unsigned long size);
>  #define ioremap_cache ioremap_cache
>  extern void __iomem *ioremap_prot(resource_size_t offset, unsigned long size, unsigned long prot_val);
>  #define ioremap_prot ioremap_prot
> +extern void __iomem *ioremap_encrypted(resource_size_t phys_addr,
> +					unsigned long size);
> +#define ioremap_encrypted ioremap_encrypted
>  
>  /**
>   * ioremap     -   map bus memory into CPU space
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index c63a545ec199..e01e6c695add 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -24,6 +24,7 @@
>  #include <asm/pgalloc.h>
>  #include <asm/pat.h>
>  #include <asm/setup.h>
> +#include <linux/crash_dump.h>
>  
>  #include "physaddr.h"
>  
> @@ -131,7 +132,8 @@ static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
>   * caller shouldn't need to know that small detail.
>   */
>  static void __iomem *__ioremap_caller(resource_size_t phys_addr,
> -		unsigned long size, enum page_cache_mode pcm, void *caller)
> +		unsigned long size, enum page_cache_mode pcm,
> +		void *caller, bool encrypted)
>  {
>  	unsigned long offset, vaddr;
>  	resource_size_t last_addr;
> @@ -199,7 +201,7 @@ static void __iomem *__ioremap_caller(resource_size_t phys_addr,
>  	 * resulting mapping.
>  	 */
>  	prot = PAGE_KERNEL_IO;
> -	if (sev_active() && mem_flags.desc_other)
> +	if ((sev_active() && mem_flags.desc_other) || encrypted)
>  		prot = pgprot_encrypted(prot);
>  
>  	switch (pcm) {
> @@ -291,7 +293,7 @@ void __iomem *ioremap_nocache(resource_size_t phys_addr, unsigned long size)
>  	enum page_cache_mode pcm = _PAGE_CACHE_MODE_UC_MINUS;
>  
>  	return __ioremap_caller(phys_addr, size, pcm,
> -				__builtin_return_address(0));
> +				__builtin_return_address(0), false);
>  }
>  EXPORT_SYMBOL(ioremap_nocache);
>  
> @@ -324,7 +326,7 @@ void __iomem *ioremap_uc(resource_size_t phys_addr, unsigned long size)
>  	enum page_cache_mode pcm = _PAGE_CACHE_MODE_UC;
>  
>  	return __ioremap_caller(phys_addr, size, pcm,
> -				__builtin_return_address(0));
> +				__builtin_return_address(0), false);
>  }
>  EXPORT_SYMBOL_GPL(ioremap_uc);
>  
> @@ -341,7 +343,7 @@ EXPORT_SYMBOL_GPL(ioremap_uc);
>  void __iomem *ioremap_wc(resource_size_t phys_addr, unsigned long size)
>  {
>  	return __ioremap_caller(phys_addr, size, _PAGE_CACHE_MODE_WC,
> -					__builtin_return_address(0));
> +					__builtin_return_address(0), false);
>  }
>  EXPORT_SYMBOL(ioremap_wc);
>  
> @@ -358,14 +360,21 @@ EXPORT_SYMBOL(ioremap_wc);
>  void __iomem *ioremap_wt(resource_size_t phys_addr, unsigned long size)
>  {
>  	return __ioremap_caller(phys_addr, size, _PAGE_CACHE_MODE_WT,
> -					__builtin_return_address(0));
> +					__builtin_return_address(0), false);
>  }
>  EXPORT_SYMBOL(ioremap_wt);
>  
> +void __iomem *ioremap_encrypted(resource_size_t phys_addr, unsigned long size)
> +{
> +	return __ioremap_caller(phys_addr, size, _PAGE_CACHE_MODE_WB,
> +				__builtin_return_address(0), true);
> +}
> +EXPORT_SYMBOL(ioremap_encrypted);
> +
>  void __iomem *ioremap_cache(resource_size_t phys_addr, unsigned long size)
>  {
>  	return __ioremap_caller(phys_addr, size, _PAGE_CACHE_MODE_WB,
> -				__builtin_return_address(0));
> +				__builtin_return_address(0), false);
>  }
>  EXPORT_SYMBOL(ioremap_cache);
>  
> @@ -374,7 +383,7 @@ void __iomem *ioremap_prot(resource_size_t phys_addr, unsigned long size,
>  {
>  	return __ioremap_caller(phys_addr, size,
>  				pgprot2cachemode(__pgprot(prot_val)),
> -				__builtin_return_address(0));
> +				__builtin_return_address(0), false);
>  }
>  EXPORT_SYMBOL(ioremap_prot);
>  
> -- 
> 2.17.1
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
