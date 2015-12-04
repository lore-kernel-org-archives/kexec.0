Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a4x6a-0007xi-5G
 for kexec@lists.infradead.org; Fri, 04 Dec 2015 20:37:24 +0000
Subject: Re: [PATCH] arm64: Fix for ARM64 3 level translation tables
References: <1449088854-13968-1-git-send-email-sgoel@codeaurora.org>
 <20151204130222.GA6116@dhcppc13.redhat.com>
From: "Goel, Sameer" <sgoel@codeaurora.org>
Message-ID: <5661F96D.2000100@codeaurora.org>
Date: Fri, 4 Dec 2015 13:37:01 -0700
MIME-Version: 1.0
In-Reply-To: <20151204130222.GA6116@dhcppc13.redhat.com>
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
To: Pratyush Anand <panand@redhat.com>
Cc: timur@codeaurora.org, asamson@codeaurora.org, kexec@lists.infradead.org, rruigrok@codeaurora.org

Agree to the changes. Posting PATCH v2.

On 12/4/2015 6:02 AM, Pratyush Anand wrote:
> Hi Sameer,
>
> Thanks for the patch.
>
> On 02/12/2015:01:40:54 PM, Sameer Goel wrote:
>> Add the implementation for PMD translation in case of 3 level page tables.
>> Assign the kernel page size based on the page structure read from the kernel
>> ELF file.
>>
>> Signed-off-by: Sameer Goel <sgoel@codeaurora.org>
>> ---
>> This change targets the arm64_support branch of Pratush Anand's repository at:
>> https://github.com/pratyushanand/makedumpfile.git
>>
>>   arch/arm64.c   | 36 ++++++++++++++++++++++++++++++------
>>   makedumpfile.c |  2 +-
>>   2 files changed, 31 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm64.c b/arch/arm64.c
>> index a94a4ba..ab20389 100644
>> --- a/arch/arm64.c
>> +++ b/arch/arm64.c
>> @@ -36,7 +36,7 @@ typedef struct {
>>   } pmd_t;
>>
>>   #define pud_offset(pgd, vaddr) 	((pud_t *)pgd)
>> -#define pmd_offset(pud, vaddr) 	((pmd_t *)pud)
>> +
>>   #define pgd_val(x)		((x).pgd)
>>   #define pud_val(x)		(pgd_val((x).pgd))
>>   #define pmd_val(x)		(pud_val((x).pud))
>> @@ -68,6 +68,11 @@ typedef struct {
>>   */
>>   #define PHYS_MASK_SHIFT		48
>>   #define PHYS_MASK		((1UL << PHYS_MASK_SHIFT) - 1)
>> +/*
>> + * Remove the highest order bits that are not a part of the
>> + * physical address in a section
>> + */
>> +#define PMD_SECTION_MASK        ((1UL << 40) - 1)
>>
>>   #define PMD_TYPE_MASK		3
>>   #define PMD_TYPE_SECT		1
>> @@ -83,10 +88,18 @@ typedef struct {
>>   #define pmd_page_vaddr(pmd)		(__va(pmd_val(pmd) & PHYS_MASK & (int32_t)PAGE_MASK))
>>   #define pte_offset(dir, vaddr) 		((pte_t*)pmd_page_vaddr((*dir)) + pte_index(vaddr))
>>
>> +
>> +#define pmd_offset_pgtbl_lvl_2(pud, vaddr) ((pmd_t *)pud)
>> +
>> +#define pmd_index(vaddr)		(((vaddr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
>> +#define pud_page_vaddr(pud)		(__va(pud_val(pud) & PHYS_MASK & (int32_t)PAGE_MASK))
>> +#define pmd_offset_pgtbl_lvl_3(pud, vaddr) ((pmd_t *)pud_page_vaddr((*pud)) + pmd_index(vaddr))
>> +
>>   /* kernel struct page size can be kernel version dependent, currently
>>    * keep it constant.
>>    */
>> -#define KERN_STRUCT_PAGE_SIZE		64
>> +#define KERN_STRUCT_PAGE_SIZE		get_structure_size("page", DWARF_INFO_GET_STRUCT_SIZE)
>> +
>>   #define ALIGN(x, a) 			(((x) + (a) - 1) & ~((a) - 1))
>>   #define PFN_DOWN(x)			((x) >> PAGE_SHIFT)
>>   #define VMEMMAP_SIZE			ALIGN((1UL << (VA_BITS - PAGE_SHIFT)) * KERN_STRUCT_PAGE_SIZE, PUD_SIZE)
>> @@ -97,6 +110,15 @@ static int pgtable_level;
>>   static int va_bits;
>>   static int page_shift;
>>
>> +pmd_t *
>> +pmd_offset(pud_t *pud, unsigned long vaddr)
>> +{
>> +	if (pgtable_level == 2) {
>> +		return pmd_offset_pgtbl_lvl_2(pud, vaddr);
>> +	} else {
>> +		return pmd_offset_pgtbl_lvl_3(pud, vaddr);
>> +	}
>> +}
>>   int
>>   get_pgtable_level_arm64(void)
>>   {
>> @@ -256,7 +278,7 @@ vtop_arm64(unsigned long vaddr)
>>   {
>>   	unsigned long long paddr = NOT_PADDR;
>>   	pgd_t	*pgda, pgdv;
>> -	pud_t	*puda;
>> +	pud_t	*puda, pudv;
>>   	pmd_t	*pmda, pmdv;
>>   	pte_t 	*ptea, ptev;
>>
>> @@ -271,8 +293,9 @@ vtop_arm64(unsigned long vaddr)
>>   		return NOT_PADDR;
>>   	}
>>
>> -	puda = pud_offset(pgda, vaddr);
>> -	pmda = pmd_offset(puda, vaddr);
>> +	pudv.pgd = pgdv;
>> +
>> +	pmda = pmd_offset(&pudv, vaddr);
>>   	if (!readmem(VADDR, (unsigned long long)pmda, &pmdv, sizeof(pmdv))) {
>>   		ERRMSG("Can't read pmd\n");
>>   		return NOT_PADDR;
>> @@ -298,7 +321,8 @@ vtop_arm64(unsigned long vaddr)
>>   		break;
>>   	case PMD_TYPE_SECT:
>>   		/* 1GB section */
>> -		paddr = (pmd_val(pmdv) & PMD_MASK) + (vaddr & (PMD_SIZE - 1));
>> +		paddr = (pmd_val(pmdv) & (PMD_MASK & PMD_SECTION_MASK))
>> +					+ (vaddr & (PMD_SIZE - 1));
>>   		break;
>>   	}
>>
>> diff --git a/makedumpfile.c b/makedumpfile.c
>> index cc71f20..df11f73 100644
>> --- a/makedumpfile.c
>> +++ b/makedumpfile.c
>> @@ -5955,7 +5955,7 @@ create_dump_bitmap(void)
>>   	ret = TRUE;
>>   out:
>>   	/* Should keep the buffer in the 1-cycle case. */
>> -	if (info->flag_cyclic)
>> +	if (info->flag_cyclic && (!info->flag_elf_dumpfile))
>
> I think, this is a change which is not ARM64 specific, so should go to a
> separate patch.
> Moreover, probably you need:
> if (info->flag_cyclic && !info->flag_elf_dumpfile && ret)
>
> ~Pratyush
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
