Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fwerw-0006jb-Vp
 for kexec@lists.infradead.org; Mon, 03 Sep 2018 02:45:38 +0000
Date: Mon, 3 Sep 2018 10:45:12 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 2/5 V6] x86/ioremap: strengthen the logic in
 early_memremap_pgprot_adjust() to adjust encryption mask
Message-ID: <20180903024512.GA2568@dhcp-128-65.nay.redhat.com>
References: <20180831081930.31561-1-lijiang@redhat.com>
 <20180831081930.31561-3-lijiang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180831081930.31561-3-lijiang@redhat.com>
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
Cc: thomas.lendacky@amd.com, bhe@redhat.com, joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de

On 08/31/18 at 04:19pm, Lianbo Jiang wrote:
> For kdump kernel, when SME is enabled, the acpi table and dmi table will need
> to be remapped without the memory encryption mask. So we have to strengthen
> the logic in early_memremap_pgprot_adjust(), which makes us have an opportunity
> to adjust the memory encryption mask.
> 
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  arch/x86/mm/ioremap.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index e01e6c695add..f9d9a39955f3 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -689,8 +689,15 @@ pgprot_t __init early_memremap_pgprot_adjust(resource_size_t phys_addr,
>  	encrypted_prot = true;
>  
>  	if (sme_active()) {
> +                /*
> +                 * In kdump kernel, the acpi table and dmi table will need
> +                 * to be remapped without the memory encryption mask. Here
> +                 * we have to strengthen the logic to adjust the memory
> +                 * encryption mask.

Assume the acpi/dmi tables are identical for both 1st kernel and kdump
kernel, I'm not sure what is the difference, why need special handling
for kdump. Can you add more explanations?

> +                 */
>  		if (early_memremap_is_setup_data(phys_addr, size) ||
> -		    memremap_is_efi_data(phys_addr, size))
> +		    memremap_is_efi_data(phys_addr, size) ||
> +		    is_kdump_kernel())
>  			encrypted_prot = false;
>  	}
>  
> -- 
> 2.17.1
> 

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
