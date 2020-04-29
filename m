Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v9 07/18] arm64: trans_pgd: hibernate: idmap the single
 page that holds the copy page routines
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-8-pasha.tatashin@soleen.com>
From: James Morse <james.morse@arm.com>
Message-ID: <b79b0b58-5f8e-913b-3913-b95551ef7ce1@arm.com>
Date: Wed, 29 Apr 2020 18:01:19 +0100
MIME-Version: 1.0
In-Reply-To: <20200326032420.27220-8-pasha.tatashin@soleen.com>
Content-Language: en-GB
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
To: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: sashal@kernel.org, mark.rutland@arm.com, vladimir.murzin@arm.com, corbet@lwn.net, catalin.marinas@arm.com, bhsharma@redhat.com, steve.capper@arm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jmorris@namei.org, linux-mm@kvack.org, rfontana@redhat.com, ebiederm@xmission.com, maz@kernel.org, matthias.bgg@gmail.com, tglx@linutronix.de, will@kernel.org, selindag@gmail.com, linux-arm-kernel@lists.infradead.org

Hi Pavel,

On 26/03/2020 03:24, Pavel Tatashin wrote:
> From: James Morse <james.morse@arm.com>
> 
> To resume from hibernate, the contents of memory are restored from
> the swap image. This may overwrite any page, including the running
> kernel and its page tables.
> 
> Hibernate copies the code it uses to do the restore into a single
> page that it knows won't be overwritten, and maps it with page tables
> built from pages that won't be overwritten.
> 
> Today the address it uses for this mapping is arbitrary, but to allow
> kexec to reuse this code, it needs to be idmapped. To idmap the page
> we must avoid the kernel helpers that have VA_BITS baked in.
> 
> Convert create_single_mapping() to take a single PA, and idmap it.
> The page tables are built in the reverse order to normal using
> pfn_pte() to stir in any bits between 52:48. T0SZ is always increased
> to cover 48bits, or 52 if the copy code has bits 52:48 in its PA.
> 
> Pasha: The original patch from James
> inux-arm-kernel/20200115143322.214247-4-james.morse@arm.com

-EBROKENLINK

The convention is to use a 'Link:' tag in the signed-off area.
e.g. 5a3577039cbe

> Adopted it to trans_pgd, so it can be commonly used by both Kexec
> and Hibernate. Some minor clean-ups.

Please describe your changes just before your SoB. This means each author sign's off on
the stuff above their SoB, and its obvious who made which changes.

Search for 'Lucky K Maintainer' in process/submitting-patches.rst for an example.


> diff --git a/arch/arm64/include/asm/trans_pgd.h b/arch/arm64/include/asm/trans_pgd.h
> index 97a7ea73b289..4912d3caf0ca 100644
> --- a/arch/arm64/include/asm/trans_pgd.h
> +++ b/arch/arm64/include/asm/trans_pgd.h
> @@ -32,4 +32,7 @@ int trans_pgd_create_copy(struct trans_pgd_info *info, pgd_t **trans_pgd,
>  int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
>  		       void *page, unsigned long dst_addr, pgprot_t pgprot);

This trans_pgd_map_page() used to be create_single_mapping(), which is where the original
patch made its changes.

You should only need one of these, not both.


> +int trans_pgd_idmap_page(struct trans_pgd_info *info, phys_addr_t *trans_ttbr0,
> +			 unsigned long *t0sz, void *page);
> +
>  #endif /* _ASM_TRANS_TABLE_H */

> diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
> index 37d7d1c60f65..c2517d1af2af 100644
> --- a/arch/arm64/mm/trans_pgd.c
> +++ b/arch/arm64/mm/trans_pgd.c
> @@ -242,3 +242,52 @@ int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
>  
>  	return 0;
>  }
> +
> +/*
> + * The page we want to idmap may be outside the range covered by VA_BITS that
> + * can be built using the kernel's p?d_populate() helpers. As a one off, for a
> + * single page, we build these page tables bottom up and just assume that will
> + * need the maximum T0SZ.
> + *
> + * Returns 0 on success, and -ENOMEM on failure.
> + * On success trans_ttbr0 contains page table with idmapped page, t0sz is set to

> + * maxumum T0SZ for this page.

maxumum

> + */


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
