Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsEW3-0002LM-V1
 for kexec@lists.infradead.org; Fri, 08 Feb 2019 22:21:02 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH] makedumpfile/arm64: Add support for ARMv8.2-LPA (52-bit
 PA support)
Date: Fri, 8 Feb 2019 22:19:46 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC03567FF6@BPXM09GP.gisp.nec.co.jp>
References: <1549484034-17027-1-git-send-email-bhsharma@redhat.com>
 <CACi5LpNYCY0_0zOCd=7fQ=cLZdinM8Z9xPtmKr5WMmvJruE-6A@mail.gmail.com>
In-Reply-To: <CACi5LpNYCY0_0zOCd=7fQ=cLZdinM8Z9xPtmKr5WMmvJruE-6A@mail.gmail.com>
Content-Language: en-US
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: kexec mailing list <kexec@lists.infradead.org>

Hi Bhupesh,

On 2/6/2019 3:34 PM, Bhupesh Sharma wrote:
> Add kexec@lists.infradead.org.
> 
> On Thu, Feb 7, 2019 at 1:43 AM Bhupesh Sharma <bhsharma@redhat.com> wrote:
>>
>> With ARMv8.2-LPA architecture extension availability, arm64 hardware
>> which supports this extension can support upto 52-bit physical
>> addresses.
>>
>> Since at the moment we enable the support of this extensions in the
>> kernel via a CONFIG flag (CONFIG_ARM64_PA_BITS_52), so there are no
>> clear mechanisms in user-space to determine this CONFIG
>> flag value and use it to determine the PA address range values.
>>
>> 'makedumpfile' can instead use 'MAX_PHYSMEM_BITS' values to
>> determine the maximum physical address supported by underlying kernel.
>>
>> I have sent a kernel patch upstream to add 'MAX_PHYSMEM_BITS' to
>> vmcoreinfo for arm64.
>>
>> This patch is in accordance with ARMv8 Architecture Reference Manual
>> version D.a and also works well for the existing
>> lower PA address values (e.g. 48-bit PA addresses).
>>
>> [0].
>> http://lists.infradead.org/pipermail/kexec/2019-February/022411.html
>>
>> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
>> ---
>>  arch/arm64.c | 332 +++++++++++++++++++++++++++++++++++++++++++++++------------
>>  1 file changed, 267 insertions(+), 65 deletions(-)
>>
>> diff --git a/arch/arm64.c b/arch/arm64.c
>> index 053519359cbc..a1db7dc63107 100644
>> --- a/arch/arm64.c
>> +++ b/arch/arm64.c
>> @@ -39,72 +39,276 @@ typedef struct {
>>         unsigned long pte;
>>  } pte_t;
>>
>> +#define __pte(x)       ((pte_t) { (x) } )
>> +#define __pmd(x)       ((pmd_t) { (x) } )
>> +#define __pud(x)       ((pud_t) { (x) } )
>> +#define __pgd(x)       ((pgd_t) { (x) } )
>> +
>> +static int lpa_52_bit_support_available;
>>  static int pgtable_level;
>>  static int va_bits;
>>  static unsigned long kimage_voffset;
>>
>> -#define SZ_4K                  (4 * 1024)
>> -#define SZ_16K                 (16 * 1024)
>> -#define SZ_64K                 (64 * 1024)
>> -#define SZ_128M                        (128 * 1024 * 1024)
>> +#define SZ_4K                  4096
>> +#define SZ_16K                 16384
>> +#define SZ_64K                 65536
>>
>> -#define PAGE_OFFSET_36 ((0xffffffffffffffffUL) << 36)
>> -#define PAGE_OFFSET_39 ((0xffffffffffffffffUL) << 39)
>> -#define PAGE_OFFSET_42 ((0xffffffffffffffffUL) << 42)
>> -#define PAGE_OFFSET_47 ((0xffffffffffffffffUL) << 47)
>> -#define PAGE_OFFSET_48 ((0xffffffffffffffffUL) << 48)
>> +#define PAGE_OFFSET_36         ((0xffffffffffffffffUL) << 36)
>> +#define PAGE_OFFSET_39         ((0xffffffffffffffffUL) << 39)
>> +#define PAGE_OFFSET_42         ((0xffffffffffffffffUL) << 42)
>> +#define PAGE_OFFSET_47         ((0xffffffffffffffffUL) << 47)
>> +#define PAGE_OFFSET_48         ((0xffffffffffffffffUL) << 48)
>> +#define PAGE_OFFSET_52         ((0xffffffffffffffffUL) << 52)
>>
>>  #define pgd_val(x)             ((x).pgd)
>>  #define pud_val(x)             (pgd_val((x).pgd))
>>  #define pmd_val(x)             (pud_val((x).pud))
>>  #define pte_val(x)             ((x).pte)
>>
>> -#define PAGE_MASK              (~(PAGESIZE() - 1))
>> -#define PGDIR_SHIFT            ((PAGESHIFT() - 3) * pgtable_level + 3)
>> -#define PTRS_PER_PGD           (1 << (va_bits - PGDIR_SHIFT))
>> -#define PUD_SHIFT              get_pud_shift_arm64()
>> -#define PUD_SIZE               (1UL << PUD_SHIFT)
>> -#define PUD_MASK               (~(PUD_SIZE - 1))
>> -#define PTRS_PER_PTE           (1 << (PAGESHIFT() - 3))
>> -#define PTRS_PER_PUD           PTRS_PER_PTE
>> -#define PMD_SHIFT              ((PAGESHIFT() - 3) * 2 + 3)
>> -#define PMD_SIZE               (1UL << PMD_SHIFT)
>> -#define PMD_MASK               (~(PMD_SIZE - 1))
>> +/* See 'include/uapi/linux/const.h' for definitions below */
>> +#define __AC(X,Y)      (X##Y)
>> +#define _AC(X,Y)       __AC(X,Y)
>> +#define _AT(T,X)       ((T)(X))
>> +
>> +/* See 'include/asm/pgtable-types.h' for definitions below */
>> +typedef unsigned long pteval_t;
>> +typedef unsigned long pmdval_t;
>> +typedef unsigned long pudval_t;
>> +typedef unsigned long pgdval_t;
>> +
>> +#define PAGE_SIZE      get_pagesize_arm64()

Is this needed?

>> +#define PAGE_SHIFT     PAGESHIFT()
>> +
>> +/* See 'arch/arm64/include/asm/pgtable-hwdef.h' for definitions below */
>> +
>> +/*
>> + * Number of page-table levels required to address 'va_bits' wide
>> + * address, without section mapping. We resolve the top (va_bits - PAGE_SHIFT)
>> + * bits with (PAGE_SHIFT - 3) bits at each page table level. Hence:
>> + *
>> + *  levels = DIV_ROUND_UP((va_bits - PAGE_SHIFT), (PAGE_SHIFT - 3))
>> + *
>> + * where DIV_ROUND_UP(n, d) => (((n) + (d) - 1) / (d))
>> + *
>> + * We cannot include linux/kernel.h which defines DIV_ROUND_UP here
>> + * due to build issues. So we open code DIV_ROUND_UP here:
>> + *
>> + *     ((((va_bits) - PAGE_SHIFT) + (PAGE_SHIFT - 3) - 1) / (PAGE_SHIFT - 3))
>> + *
>> + * which gets simplified as :
>> + */
>> +#define ARM64_HW_PGTABLE_LEVELS(va_bits) (((va_bits) - 4) / (PAGE_SHIFT - 3))

Is this needed?

>> +
>> +/*
>> + * Size mapped by an entry at level n ( 0 <= n <= 3)
>> + * We map (PAGE_SHIFT - 3) at all translation levels and PAGE_SHIFT bits
>> + * in the final page. The maximum number of translation levels supported by
>> + * the architecture is 4. Hence, starting at at level n, we have further
>> + * ((4 - n) - 1) levels of translation excluding the offset within the page.
>> + * So, the total number of bits mapped by an entry at level n is :
>> + *
>> + *  ((4 - n) - 1) * (PAGE_SHIFT - 3) + PAGE_SHIFT
>> + *
>> + * Rearranging it a bit we get :
>> + *   (4 - n) * (PAGE_SHIFT - 3) + 3
>> + */
>> +#define ARM64_HW_PGTABLE_LEVEL_SHIFT(n)        ((PAGE_SHIFT - 3) * (4 - (n)) + 3)
>> +
>> +#define PTRS_PER_PTE           (1 << (PAGE_SHIFT - 3))
>> +
>> +/*
>> + * PMD_SHIFT determines the size a level 2 page table entry can map.
>> + */
>> +#define PMD_SHIFT              ARM64_HW_PGTABLE_LEVEL_SHIFT(2)
>> +#define PMD_SIZE               (_AC(1, UL) << PMD_SHIFT)
>> +#define PMD_MASK               (~(PMD_SIZE-1))
>>  #define PTRS_PER_PMD           PTRS_PER_PTE
>>
>> -#define PAGE_PRESENT           (1 << 0)
>> +/*
>> + * PUD_SHIFT determines the size a level 1 page table entry can map.
>> + */
>> +#define PUD_SHIFT              ARM64_HW_PGTABLE_LEVEL_SHIFT(1)
>> +#define PUD_SIZE               (_AC(1, UL) << PUD_SHIFT)
>> +#define PUD_MASK               (~(PUD_SIZE-1))
>> +#define PTRS_PER_PUD           PTRS_PER_PTE
>> +
>> +static inline int
>> +get_page_table_level_arm64(void)
>> +{
>> +       return pgtable_level;
>> +}
>> +
>> +/*
>> + * PGDIR_SHIFT determines the size a top-level page table entry can map
>> + * (depending on the configuration, this level can be 0, 1 or 2).
>> + */
>> +#define PGDIR_SHIFT            ARM64_HW_PGTABLE_LEVEL_SHIFT(4 - (get_page_table_level_arm64()))

Is this get_page_table_level_arm64() function replaced with the
pgtable_level variable?

>> +#define PGDIR_SIZE             (_AC(1, UL) << PGDIR_SHIFT)
>> +#define PGDIR_MASK             (~(PGDIR_SIZE-1))
>> +#define PTRS_PER_PGD           (1 << ((va_bits) - PGDIR_SHIFT))
>> +
>> +/*
>> + * Section address mask and size definitions.
>> + */
>> +#define SECTION_SHIFT          PMD_SHIFT
>> +#define SECTION_SIZE           (_AC(1, UL) << SECTION_SHIFT)
>> +#define SECTION_MASK           (~(SECTION_SIZE-1))
>> +
>>  #define SECTIONS_SIZE_BITS     30
>> -/* Highest possible physical address supported */
>> -#define PHYS_MASK_SHIFT                48
>> -#define PHYS_MASK              ((1UL << PHYS_MASK_SHIFT) - 1)
>> +
>> +/*
>> + * Hardware page table definitions.
>> + *
>> + * Level 1 descriptor (PUD).
>> + */
>> +#define PUD_TYPE_TABLE         (_AT(pudval_t, 3) << 0)
>> +#define PUD_TABLE_BIT          (_AT(pudval_t, 1) << 1)
>> +#define PUD_TYPE_MASK          (_AT(pudval_t, 3) << 0)
>> +#define PUD_TYPE_SECT          (_AT(pudval_t, 1) << 0)
>> +
>> +/*
>> + * Level 2 descriptor (PMD).
>> + */
>> +#define PMD_TYPE_MASK          (_AT(pmdval_t, 3) << 0)
>> +#define PMD_TYPE_FAULT         (_AT(pmdval_t, 0) << 0)
>> +#define PMD_TYPE_TABLE         (_AT(pmdval_t, 3) << 0)
>> +#define PMD_TYPE_SECT          (_AT(pmdval_t, 1) << 0)
>> +#define PMD_TABLE_BIT          (_AT(pmdval_t, 1) << 1)
>> +
>> +/*
>> + * Section
>> + */
>> +#define PMD_SECT_VALID         (_AT(pmdval_t, 1) << 0)
>> +#define PMD_SECT_USER          (_AT(pmdval_t, 1) << 6)         /* AP[1] */
>> +#define PMD_SECT_RDONLY                (_AT(pmdval_t, 1) << 7)         /* AP[2] */
>> +#define PMD_SECT_S             (_AT(pmdval_t, 3) << 8)
>> +#define PMD_SECT_AF            (_AT(pmdval_t, 1) << 10)
>> +#define PMD_SECT_NG            (_AT(pmdval_t, 1) << 11)
>> +#define PMD_SECT_CONT          (_AT(pmdval_t, 1) << 52)
>> +#define PMD_SECT_PXN           (_AT(pmdval_t, 1) << 53)
>> +#define PMD_SECT_UXN           (_AT(pmdval_t, 1) << 54)

Are these section things needed?
We can import them when we need them, so I don't like to import
them too much if not necessary.

>> +
>> +/*
>> + * AttrIndx[2:0] encoding (mapping attributes defined in the MAIR* registers).
>> + */
>> +#define PMD_ATTRINDX(t)                (_AT(pmdval_t, (t)) << 2)
>> +#define PMD_ATTRINDX_MASK      (_AT(pmdval_t, 7) << 2)
>> +

Ditto.

>>  /*
>> - * Remove the highest order bits that are not a part of the
>> - * physical address in a section
>> + * Level 3 descriptor (PTE).
>>   */
>> -#define PMD_SECTION_MASK       ((1UL << 40) - 1)
>> +#define PTE_TYPE_MASK          (_AT(pteval_t, 3) << 0)
>> +#define PTE_TYPE_FAULT         (_AT(pteval_t, 0) << 0)
>> +#define PTE_TYPE_PAGE          (_AT(pteval_t, 3) << 0)
>> +#define PTE_TABLE_BIT          (_AT(pteval_t, 1) << 1)
>> +#define PTE_USER               (_AT(pteval_t, 1) << 6)         /* AP[1] */
>> +#define PTE_RDONLY             (_AT(pteval_t, 1) << 7)         /* AP[2] */
>> +#define PTE_SHARED             (_AT(pteval_t, 3) << 8)         /* SH[1:0], inner shareable */
>> +#define PTE_AF                 (_AT(pteval_t, 1) << 10)        /* Access Flag */
>> +#define PTE_NG                 (_AT(pteval_t, 1) << 11)        /* nG */
>> +#define PTE_DBM                        (_AT(pteval_t, 1) << 51)        /* Dirty Bit Management */
>> +#define PTE_CONT               (_AT(pteval_t, 1) << 52)        /* Contiguous range */
>> +#define PTE_PXN                        (_AT(pteval_t, 1) << 53)        /* Privileged XN */
>> +#define PTE_UXN                        (_AT(pteval_t, 1) << 54)        /* User XN */
>> +#define PTE_HYP_XN             (_AT(pteval_t, 1) << 54)        /* HYP XN */

Ditto.

>> +
>> +#define PTE_ADDR_LOW           (((_AT(pteval_t, 1) << (48 - PAGE_SHIFT)) - 1) << PAGE_SHIFT)
>> +#define PTE_ADDR_HIGH          (_AT(pteval_t, 0xf) << 12)
>> +
>> +static inline unsigned long
>> +get_pte_addr_mask_arm64(void)
>> +{
>> +       if (lpa_52_bit_support_available)
>> +               return (PTE_ADDR_LOW | PTE_ADDR_HIGH);
>> +       else
>> +               return PTE_ADDR_LOW;
>> +}
>> +
>> +#define PTE_ADDR_MASK          get_pte_addr_mask_arm64()
>> +
>> +#define PAGE_MASK              (~(PAGESIZE() - 1))
>> +#define PAGE_PRESENT           (1 << 0)
>> +
>> +/* Highest possible physical address supported */
>> +static inline int
>> +get_phy_mask_shift_arm64(void)
>> +{
>> +       int pa_bits = 48 /* default: 48-bit PA */;
>> +
>> +       if (NUMBER(MAX_PHYSMEM_BITS) != NOT_FOUND_NUMBER)
>> +               pa_bits = NUMBER(MAX_PHYSMEM_BITS);
>> +
>> +       return pa_bits;
>> +}

Is this needed to be an inline function?

>>
>> -#define PMD_TYPE_MASK          3
>> -#define PMD_TYPE_SECT          1
>> -#define PMD_TYPE_TABLE         3
>> +#define PHYS_MASK_SHIFT                get_phy_mask_shift_arm64()
>>
>> -#define PUD_TYPE_MASK          3
>> -#define PUD_TYPE_SECT          1
>> -#define PUD_TYPE_TABLE         3
>> +/* Helper API to convert between a physical address and its placement
>> + * in a page table entry, taking care of 52-bit addresses.
>> + */
>> +static inline unsigned long
>> +__pte_to_phys(pte_t pte)
>> +{
>> +       if (lpa_52_bit_support_available)

OK.

According to the related emails, it looks like "PAGESIZE() == SZ_64K"
is also usable here, but this is the same condition as kernel's one
and easy to understand.

>> +               return ((pte_val(pte) & PTE_ADDR_LOW) | ((pte_val(pte) & PTE_ADDR_HIGH) << 36));
>> +       else
>> +               return (pte_val(pte) & PTE_ADDR_MASK);
>> +}
>>
>> +/* Find an entry in a page-table-directory */
>>  #define pgd_index(vaddr)               (((vaddr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
>> -#define pgd_offset(pgdir, vaddr)       ((pgd_t *)(pgdir) + pgd_index(vaddr))
>>
>> -#define pte_index(vaddr)               (((vaddr) >> PAGESHIFT()) & (PTRS_PER_PTE - 1))
>> -#define pmd_page_paddr(pmd)            (pmd_val(pmd) & PHYS_MASK & (int32_t)PAGE_MASK)
>> -#define pte_offset(dir, vaddr)                 ((pte_t*)pmd_page_paddr((*dir)) + pte_index(vaddr))
>> +static inline pte_t
>> +pgd_pte(pgd_t pgd)
>> +{
>> +       return __pte(pgd_val(pgd));
>> +}
>> +
>> +#define __pgd_to_phys(pgd)             __pte_to_phys(pgd_pte(pgd))
>> +#define pgd_offset(pgd, vaddr)         ((pgd_t *)(pgd) + pgd_index(vaddr))
>>
>> -#define pmd_index(vaddr)               (((vaddr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
>> -#define pud_page_paddr(pud)            (pud_val(pud) & PHYS_MASK & (int32_t)PAGE_MASK)
>> -#define pmd_offset_pgtbl_lvl_2(pud, vaddr) ((pmd_t *)pud)
>> -#define pmd_offset_pgtbl_lvl_3(pud, vaddr) ((pmd_t *)pud_page_paddr((*pud)) + pmd_index(vaddr))
>> +static inline pte_t pud_pte(pud_t pud)
>> +{
>> +       return __pte(pud_val(pud));
>> +}
>>
>> +static inline unsigned long
>> +pgd_page_paddr(pgd_t pgd)
>> +{
>> +       return __pgd_to_phys(pgd);
>> +}
>> +
>> +/* Find an entry in the first-level page table. */
>>  #define pud_index(vaddr)               (((vaddr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
>> -#define pgd_page_paddr(pgd)            (pgd_val(pgd) & PHYS_MASK & (int32_t)PAGE_MASK)
>> +#define __pud_to_phys(pud)             __pte_to_phys(pud_pte(pud))
>> +
>> +static inline unsigned long
>> +pud_page_paddr(pud_t pud)
>> +{
>> +       return __pud_to_phys(pud);
>> +}
>> +
>> +/* Find an entry in the second-level page table. */
>> +#define pmd_index(vaddr)                  (((vaddr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
>> +#define pmd_offset_pgtbl_lvl_2(dir, vaddr) ((pmd_t *)dir)
>> +#define pmd_offset_pgtbl_lvl_3(dir, vaddr) (pud_page_paddr((*(dir))) + pmd_index(vaddr) * sizeof(pmd_t))
>> +
>> +static inline pte_t pmd_pte(pmd_t pmd)
>> +{
>> +       return __pte(pmd_val(pmd));
>> +}
>> +
>> +#define __pmd_to_phys(pmd)             __pte_to_phys(pmd_pte(pmd))
>> +
>> +static inline unsigned long
>> +pmd_page_paddr(pmd_t pmd)
>> +{
>> +       return __pmd_to_phys(pmd);
>> +}
>> +
>> +/* Find an entry in the third-level page table. */
>> +#define pte_index(vaddr)               (((vaddr) >> PAGESHIFT()) & (PTRS_PER_PTE - 1))
>> +#define pte_offset(dir, vaddr)                 (pmd_page_paddr((*dir)) + pte_index(vaddr) * sizeof(pte_t))
>>
>>  static unsigned long long
>>  __pa(unsigned long vaddr)
>> @@ -116,30 +320,20 @@ __pa(unsigned long vaddr)
>>                 return (vaddr - kimage_voffset);
>>  }
>>
>> -static int
>> -get_pud_shift_arm64(void)
>> -{
>> -       if (pgtable_level == 4)
>> -               return ((PAGESHIFT() - 3) * 3 + 3);
>> -       else
>> -               return PGDIR_SHIFT;
>> -}
>> -
>>  static pmd_t *
>>  pmd_offset(pud_t *puda, pud_t *pudv, unsigned long vaddr)
>>  {
>> -       if (pgtable_level == 2) {
>> -               return pmd_offset_pgtbl_lvl_2(puda, vaddr);
>> -       } else {
>> -               return pmd_offset_pgtbl_lvl_3(pudv, vaddr);
>> -       }
>> +       if (pgtable_level > 2)

If you want to change, I prefer ">= 3".

And, please expand these macros at this oppotunity?
I don't see any big merit to have the two macros, and I'd like to
make them the same style as pud_offset().

>> +               return (pmd_t *)pmd_offset_pgtbl_lvl_3(pudv, vaddr);
>> +       else
>> +               return (pmd_t *)pmd_offset_pgtbl_lvl_2(puda, vaddr);
>>  }
>>
>>  static pud_t *
>>  pud_offset(pgd_t *pgda, pgd_t *pgdv, unsigned long vaddr)
>>  {
>> -       if (pgtable_level == 4)
>> -               return ((pud_t *)pgd_page_paddr((*pgdv)) + pud_index(vaddr));
>> +       if (pgtable_level > 3)

I prefer "== 4" because of no misreading.

>> +               return (pud_t *)(pgd_page_paddr((*pgdv)) + pud_index(vaddr) * sizeof(pud_t));
>>         else
>>                 return (pud_t *)(pgda);
>>  }
>> @@ -287,6 +481,15 @@ get_stext_symbol(void)
>>  int
>>  get_machdep_info_arm64(void)
>>  {
>> +       int pa_bits;
>> +
>> +       /* Determine if the PA address range is 52-bits: ARMv8.2-LPA */
>> +       pa_bits = get_phy_mask_shift_arm64();
>> +       DEBUG_MSG("pa_bits    : %d\n", pa_bits);
>> +
>> +       if (pa_bits == 52)
>> +               lpa_52_bit_support_available = 1;
>> +

This looks a bit redundant, so for example

  if (NUMBER(MAX_PHYSMEM_BITS) != NOT_FOUND_NUMBER) {
    info->max_physmem_bits = NUMBER(MAX_PHYSMEM_BITS);
    if (info->max_physmem_bits == 52)
      lpa_52_bit_support_available = 1;
  } else
    info->max_physmem_bits = 48;

>>         /* Check if va_bits is still not initialized. If still 0, call
>>          * get_versiondep_info() to initialize the same.
>>          */
>> @@ -303,8 +506,8 @@ get_machdep_info_arm64(void)
>>         info->section_size_bits = SECTIONS_SIZE_BITS;
>>
>>         DEBUG_MSG("kimage_voffset   : %lx\n", kimage_voffset);
>> -       DEBUG_MSG("max_physmem_bits : %lx\n", info->max_physmem_bits);
>> -       DEBUG_MSG("section_size_bits: %lx\n", info->section_size_bits);
>> +       DEBUG_MSG("max_physmem_bits : %ld\n", info->max_physmem_bits);
>> +       DEBUG_MSG("section_size_bits: %ld\n", info->section_size_bits);

Good fix.

>>
>>         return TRUE;
>>  }
>> @@ -401,7 +604,7 @@ vaddr_to_paddr_arm64(unsigned long vaddr)
>>
>>         if ((pud_val(pudv) & PUD_TYPE_MASK) == PUD_TYPE_SECT) {
>>                 /* 1GB section for Page Table level = 4 and Page Size = 4KB */
>> -               paddr = (pud_val(pudv) & (PUD_MASK & PMD_SECTION_MASK))
>> +               paddr = (pud_val(pudv) & (PUD_MASK & SECTION_MASK))
>>                                         + (vaddr & (PUD_SIZE - 1));

This may not be used for 64k page, but I think it would be better
to use __pte_to_phys() as well as the others below.

>>                 return paddr;
>>         }
>> @@ -414,7 +617,7 @@ vaddr_to_paddr_arm64(unsigned long vaddr)
>>
>>         switch (pmd_val(pmdv) & PMD_TYPE_MASK) {
>>         case PMD_TYPE_TABLE:
>> -               ptea = pte_offset(&pmdv, vaddr);
>> +               ptea = (pte_t *)pte_offset(&pmdv, vaddr);
>>                 /* 64k page */
>>                 if (!readmem(PADDR, (unsigned long long)ptea, &ptev, sizeof(ptev))) {
>>                         ERRMSG("Can't read pte\n");
>> @@ -425,14 +628,13 @@ vaddr_to_paddr_arm64(unsigned long vaddr)
>>                         ERRMSG("Can't get a valid pte.\n");
>>                         return NOT_PADDR;
>>                 } else {
>> -
>> -                       paddr = (PAGEBASE(pte_val(ptev)) & PHYS_MASK)
>> +                       paddr = (PAGEBASE(pte_val(ptev)) & PTE_ADDR_MASK)
>>                                         + (vaddr & (PAGESIZE() - 1));

I think __pte_to_phys() is needed also here, not PTE_ADDR_MASK.

>>                 }
>>                 break;
>>         case PMD_TYPE_SECT:
>>                 /* 512MB section for Page Table level = 3 and Page Size = 64KB*/
>> -               paddr = (pmd_val(pmdv) & (PMD_MASK & PMD_SECTION_MASK))
>> +               paddr = (pmd_val(pmdv) & (PMD_MASK & SECTION_MASK))
>>                                         + (vaddr & (PMD_SIZE - 1));

As I sent with a test result on another thread,

  paddr = (pmd_page_paddr(pmdv) & PMD_MASK)
               + (vaddr & (PMD_SIZE - 1));

This looks right to me. Is this right?

Thanks,
Kazu

>>                 break;
>>         }
>> --
>> 2.7.4
>>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
