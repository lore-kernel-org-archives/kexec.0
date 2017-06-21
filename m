Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dNaDE-00041n-2x
 for kexec@lists.infradead.org; Wed, 21 Jun 2017 07:38:06 +0000
Date: Wed, 21 Jun 2017 09:37:39 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v7 07/36] x86/mm: Don't use phys_to_virt in ioremap() if
 SME is active
In-Reply-To: <20170616185104.18967.7867.stgit@tlendack-t1.amdoffice.net>
Message-ID: <alpine.DEB.2.20.1706210934540.2328@nanos>
References: <20170616184947.18967.84890.stgit@tlendack-t1.amdoffice.net>
 <20170616185104.18967.7867.stgit@tlendack-t1.amdoffice.net>
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
> Currently there is a check if the address being mapped is in the ISA
> range (is_ISA_range()), and if it is then phys_to_virt() is used to
> perform the mapping.  When SME is active, however, this will result
> in the mapping having the encryption bit set when it is expected that
> an ioremap() should not have the encryption bit set. So only use the
> phys_to_virt() function if SME is not active
> 
> Reviewed-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/mm/ioremap.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index 4c1b5fd..a382ba9 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -13,6 +13,7 @@
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
>  #include <linux/mmiotrace.h>
> +#include <linux/mem_encrypt.h>
>  
>  #include <asm/set_memory.h>
>  #include <asm/e820/api.h>
> @@ -106,9 +107,11 @@ static void __iomem *__ioremap_caller(resource_size_t phys_addr,
>  	}
>  
>  	/*
> -	 * Don't remap the low PCI/ISA area, it's always mapped..
> +	 * Don't remap the low PCI/ISA area, it's always mapped.
> +	 *   But if SME is active, skip this so that the encryption bit
> +	 *   doesn't get set.
>  	 */
> -	if (is_ISA_range(phys_addr, last_addr))
> +	if (is_ISA_range(phys_addr, last_addr) && !sme_active())
>  		return (__force void __iomem *)phys_to_virt(phys_addr);

More thoughts about that.

Making this conditional on !sme_active() is not the best idea. I'd rather
remove that whole thing and make it unconditional so the code pathes get
always exercised and any subtle wreckage is detected on a broader base and
not only on that hard to access and debug SME capable machine owned by Joe
User.

Thanks,

	tglx

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
