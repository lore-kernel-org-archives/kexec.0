Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1dAdpz-0006vs-Pi
 for kexec@lists.infradead.org; Tue, 16 May 2017 14:52:37 +0000
Date: Tue, 16 May 2017 16:52:09 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 23/32] swiotlb: Add warnings for use of bounce buffers
 with SME
Message-ID: <20170516145209.ltbmaq3a2teqr2uv@pd.tnic>
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418212019.10190.24034.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170418212019.10190.24034.stgit@tlendack-t1.amdoffice.net>
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

On Tue, Apr 18, 2017 at 04:20:19PM -0500, Tom Lendacky wrote:
> Add warnings to let the user know when bounce buffers are being used for
> DMA when SME is active.  Since the bounce buffers are not in encrypted
> memory, these notifications are to allow the user to determine some
> appropriate action - if necessary.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/include/asm/mem_encrypt.h |   11 +++++++++++
>  include/linux/dma-mapping.h        |   11 +++++++++++
>  include/linux/mem_encrypt.h        |    6 ++++++
>  lib/swiotlb.c                      |    3 +++
>  4 files changed, 31 insertions(+)
> 
> diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
> index 0637b4b..b406df2 100644
> --- a/arch/x86/include/asm/mem_encrypt.h
> +++ b/arch/x86/include/asm/mem_encrypt.h
> @@ -26,6 +26,11 @@ static inline bool sme_active(void)
>  	return !!sme_me_mask;
>  }
>  
> +static inline u64 sme_dma_mask(void)
> +{
> +	return ((u64)sme_me_mask << 1) - 1;
> +}
> +
>  void __init sme_early_encrypt(resource_size_t paddr,
>  			      unsigned long size);
>  void __init sme_early_decrypt(resource_size_t paddr,
> @@ -50,6 +55,12 @@ static inline bool sme_active(void)
>  {
>  	return false;
>  }
> +
> +static inline u64 sme_dma_mask(void)
> +{
> +	return 0ULL;
> +}
> +
>  #endif
>  
>  static inline void __init sme_early_encrypt(resource_size_t paddr,
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 0977317..f825870 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -10,6 +10,7 @@
>  #include <linux/scatterlist.h>
>  #include <linux/kmemcheck.h>
>  #include <linux/bug.h>
> +#include <linux/mem_encrypt.h>
>  
>  /**
>   * List of possible attributes associated with a DMA mapping. The semantics
> @@ -577,6 +578,11 @@ static inline int dma_set_mask(struct device *dev, u64 mask)
>  
>  	if (!dev->dma_mask || !dma_supported(dev, mask))
>  		return -EIO;
> +
> +	if (sme_active() && (mask < sme_dma_mask()))
> +		dev_warn_ratelimited(dev,
> +				     "SME is active, device will require DMA bounce buffers\n");

Bah, no need to break that line - just let it stick out. Ditto for the
others.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
