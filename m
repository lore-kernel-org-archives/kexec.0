Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1diBq7-0001SE-JL
 for kexec@lists.infradead.org; Thu, 17 Aug 2017 03:51:25 +0000
Received: by mail-pg0-f48.google.com with SMTP id v189so33959130pgd.2
 for <kexec@lists.infradead.org>; Wed, 16 Aug 2017 20:51:02 -0700 (PDT)
Subject: Re: [PATCH v2] makedumpfile: arm64: Fix page table walk of 1GB section
References: <20170817000129.3955-1-bradleybolen@gmail.com>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <bfb79bd9-5a17-5eb3-5c7e-def47b8d0832@redhat.com>
Date: Thu, 17 Aug 2017 09:12:55 +0530
MIME-Version: 1.0
In-Reply-To: <20170817000129.3955-1-bradleybolen@gmail.com>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bradley Bolen <bradleybolen@gmail.com>, kexec@lists.infradead.org
Cc: Bradley Bolen <bbolen@lexmark.com>



On Thursday 17 August 2017 05:31 AM, Bradley Bolen wrote:
> From: Bradley Bolen <bbolen@lexmark.com>
> 
> makedumpfile was generating large (> 500MB) vmcore files for an arm64
> board with 2GB of DRAM.  It was not excluding any pages because the
> mem_map address was not being converted correctly.
> 
> readmem: Can't convert a virtual address(ffffffc07fff6000) to physical
> address.
> readmem: type_addr: 0, addr:ffffffc07fff6000, size:16
> section_mem_map_addr: Can't get a struct mem_section(ffffffc07fff6000).
> mem_map (0)
> mem_map : 0
> 
> makedumpfile was not handling 1GB sections in the PGD and was trying to
> drill down to a PTE in which it was trying to dereference invalid
> memory.  This patch adds code to check the PGD for a section type and
> handle it instead of treating it as a table entry.
> 
> Signed-off-by: Bradley Bolen <bradleybolen@gmail.com>

Reviewed-by: Pratyush Anand <panand@redhat.com>

> ---
> Changes in v2:
> - updated comments
> 
>   arch/arm64.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64.c b/arch/arm64.c
> index 958f57f..25d7a1f 100644
> --- a/arch/arm64.c
> +++ b/arch/arm64.c
> @@ -57,6 +57,8 @@ static unsigned long kimage_voffset;
>   #define PGDIR_SHIFT		((PAGESHIFT() - 3) * pgtable_level + 3)
>   #define PTRS_PER_PGD		(1 << (va_bits - PGDIR_SHIFT))
>   #define PUD_SHIFT		get_pud_shift_arm64()
> +#define PUD_SIZE		(1UL << PUD_SHIFT)
> +#define PUD_MASK		(~(PUD_SIZE - 1))
>   #define PTRS_PER_PTE		(1 << (PAGESHIFT() - 3))
>   #define PTRS_PER_PUD		PTRS_PER_PTE
>   #define PMD_SHIFT		((PAGESHIFT() - 3) * 2 + 3)
> @@ -79,6 +81,10 @@ static unsigned long kimage_voffset;
>   #define PMD_TYPE_SECT		1
>   #define PMD_TYPE_TABLE		3
>   
> +#define PUD_TYPE_MASK		3
> +#define PUD_TYPE_SECT		1
> +#define PUD_TYPE_TABLE		3
> +
>   #define pgd_index(vaddr) 		(((vaddr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
>   #define pgd_offset(pgdir, vaddr)	((pgd_t *)(pgdir) + pgd_index(vaddr))
>   
> @@ -253,6 +259,13 @@ vaddr_to_paddr_arm64(unsigned long vaddr)
>   		return NOT_PADDR;
>   	}
>   
> +	if ((pud_val(pudv) & PUD_TYPE_MASK) == PUD_TYPE_SECT) {
> +		/* 1GB section for Page Table level = 4 and Page Size = 4KB */
> +		paddr = (pud_val(pudv) & (PUD_MASK & PMD_SECTION_MASK))
> +					+ (vaddr & (PUD_SIZE - 1));
> +		return paddr;
> +	}
> +
>   	pmda = pmd_offset(puda, &pudv, vaddr);
>   	if (!readmem(PADDR, (unsigned long long)pmda, &pmdv, sizeof(pmdv))) {
>   		ERRMSG("Can't read pmd\n");
> @@ -278,7 +291,7 @@ vaddr_to_paddr_arm64(unsigned long vaddr)
>   		}
>   		break;
>   	case PMD_TYPE_SECT:
> -		/* 1GB section */
> +		/* 512MB section for Page Table level = 3 and Page Size = 64KB*/
>   		paddr = (pmd_val(pmdv) & (PMD_MASK & PMD_SECTION_MASK))
>   					+ (vaddr & (PMD_SIZE - 1));
>   		break;
> 

-- 
Regards
Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
