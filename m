Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ys5OJ-0001ch-JE
 for kexec@lists.infradead.org; Tue, 12 May 2015 08:18:16 +0000
Date: Tue, 12 May 2015 16:17:23 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v11 02/10] iommu/vt-d: Items required for kdump
Message-ID: <20150512081723.GC4561@localhost.localdomain>
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
 <1431337974-545-3-git-send-email-zhen-hual@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1431337974-545-3-git-send-email-zhen-hual@hp.com>
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
To: "Li, Zhen-Hua" <zhen-hual@hp.com>
Cc: alex.williamson@redhat.com, indou.takao@jp.fujitsu.com, bhe@redhat.com, tom.vaden@hp.com, rwright@hp.com, linux-pci@vger.kernel.org, joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, jerry.hoemann@hp.com, iommu@lists.linux-foundation.org, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, billsumnerlinux@gmail.com, li.zhang6@hp.com, dwmw2@infradead.org, vgoyal@redhat.com

On 05/11/15 at 05:52pm, Li, Zhen-Hua wrote:
> Add context entry functions needed for kdump.
> 
> Bill Sumner:
>     Original version;
> 
> Li, Zhenhua:
>     Changed the name of new functions, make them consistent with current
>     context get/set functions.
>     Remove the structure dve which is not used in new version.
> 
> Signed-off-by: Bill Sumner <billsumnerlinux@gmail.com>
> Signed-off-by: Li, Zhen-Hua <zhen-hual@hp.com>
> ---
>  drivers/iommu/intel-iommu.c | 72 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index cb9d6cc..1e7ceb5 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -190,6 +190,31 @@ struct root_entry {
>  };
>  #define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
>  
> +static inline bool root_present(struct root_entry *root)
> +{
> +	return (root->lo & 1);
> +}
> +
> +static inline void set_root_value(struct root_entry *root, unsigned long value)
> +{
> +	root->lo &= ~VTD_PAGE_MASK;
> +	root->lo |= value & VTD_PAGE_MASK;
> +}
> +
> +static inline struct context_entry *
> +get_context_addr_from_root(struct root_entry *root)
> +{
> +	return (struct context_entry *)
> +		(root_present(root)?phys_to_virt(
> +		root->lo & VTD_PAGE_MASK) :
> +		NULL);
> +}
> +
> +static inline unsigned long
> +get_context_phys_from_root(struct root_entry *root)
> +{
> +	return  root_present(root) ? (root->lo & VTD_PAGE_MASK) : 0;
> +}
>  
>  /*
>   * low 64 bits:
> @@ -211,6 +236,32 @@ static inline bool context_present(struct context_entry *context)
>  {
>  	return (context->lo & 1);
>  }
> +
> +static inline int context_fault_enable(struct context_entry *c)
> +{
> +	return((c->lo >> 1) & 0x1);
> +}
> +
> +static inline int context_translation_type(struct context_entry *c)
> +{
> +	return((c->lo >> 2) & 0x3);
> +}
> +
> +static inline u64 context_address_root(struct context_entry *c)
> +{
> +	return((c->lo >> VTD_PAGE_SHIFT));
> +}
> +
> +static inline int context_address_width(struct context_entry *c)
> +{
> +	return((c->hi >> 0) & 0x7);
> +}
> +
> +static inline int context_domain_id(struct context_entry *c)
> +{
> +	return((c->hi >> 8) & 0xffff);
> +}
> +
>  static inline void context_set_present(struct context_entry *context)
>  {
>  	context->lo |= 1;
> @@ -296,6 +347,27 @@ static inline int first_pte_in_page(struct dma_pte *pte)
>  	return !((unsigned long)pte & ~VTD_PAGE_MASK);
>  }
>  
> +
> +/*
> + * Fix Crashdump failure caused by leftover DMA through a hardware IOMMU
> + *
> + * Fixes the crashdump kernel to deal with an active iommu and legacy
> + * DMA from the (old) panicked kernel in a manner similar to how legacy
> + * DMA is handled when no hardware iommu was in use by the old kernel --
> + * allow the legacy DMA to continue into its current buffers.
> + *
> + * In the crashdump kernel, this code:
> + * 1. skips disabling the IOMMU's translating.
> + * 2. Do not re-enable IOMMU's translating.
> + * 3. In kdump kernel, use the old root entry table.
> + * 4. Allocate pages for new context entry, copy data from old context entries
> + *    in the old kernel to the new ones.
> + *
> + * In other kinds of kernel, for example, a kernel started by kexec,
> + * do the same thing as crashdump kernel.
> + */
> +
> +

Above comments should come along with the code changes instead of putting it
in this patch.

BTW, there's one more blank line at the end..

>  /*
>   * This domain is a statically identity mapping domain.
>   *	1. This domain creats a static 1:1 mapping to all usable memory.
> -- 
> 2.0.0-rc0
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
