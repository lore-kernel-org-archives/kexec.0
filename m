Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtbhf-0007lx-1r
 for kexec@lists.infradead.org; Tue, 12 Feb 2019 17:18:40 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH] makedumpfile/arm64: Add support for ARMv8.2-LPA (52-bit
 PA support)
Date: Tue, 12 Feb 2019 17:15:32 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC035682A9@BPXM09GP.gisp.nec.co.jp>
References: <1549484034-17027-1-git-send-email-bhsharma@redhat.com>
 <CACi5LpNYCY0_0zOCd=7fQ=cLZdinM8Z9xPtmKr5WMmvJruE-6A@mail.gmail.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03567FF6@BPXM09GP.gisp.nec.co.jp>
 <887cb122-0c2e-5fdd-ea54-ecf8adf3cd79@redhat.com>
In-Reply-To: <887cb122-0c2e-5fdd-ea54-ecf8adf3cd79@redhat.com>
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

On 2/12/2019 3:44 AM, Bhupesh Sharma wrote:
>>>> +/* See 'arch/arm64/include/asm/pgtable-hwdef.h' for definitions below */
>>>> +
>>>> +/*
>>>> + * Number of page-table levels required to address 'va_bits' wide
>>>> + * address, without section mapping. We resolve the top (va_bits - PAGE_SHIFT)
>>>> + * bits with (PAGE_SHIFT - 3) bits at each page table level. Hence:
>>>> + *
>>>> + *  levels = DIV_ROUND_UP((va_bits - PAGE_SHIFT), (PAGE_SHIFT - 3))
>>>> + *
>>>> + * where DIV_ROUND_UP(n, d) => (((n) + (d) - 1) / (d))
>>>> + *
>>>> + * We cannot include linux/kernel.h which defines DIV_ROUND_UP here
>>>> + * due to build issues. So we open code DIV_ROUND_UP here:
>>>> + *
>>>> + *     ((((va_bits) - PAGE_SHIFT) + (PAGE_SHIFT - 3) - 1) / (PAGE_SHIFT - 3))
>>>> + *
>>>> + * which gets simplified as :
>>>> + */
>>>> +#define ARM64_HW_PGTABLE_LEVELS(va_bits) (((va_bits) - 4) / (PAGE_SHIFT - 3))
>>
>> Is this needed?
> 
> Yes, it is needed for both the LPA and LVA patches (the LVA patch was sent out separately), since we need to calculate values like PMD_SHIFT on basis of the page-table levels.
> 
> Also this makes the makedumpfile code confirm more to the recent kernel definitions as otherwise one needs to read the makedumpfile code and dig kernel change history to understand the calculation of these macros.
> 
> In future also, I plan to keep these values in sync with the kernel and send patches accordingly.

I agree to sync these macros with the kernel, but currently this one
is not used in your patches, and you wrote the path of the source file
(pgtable-hwdef.h) above for reference, so we don't need to import this
one for now. I'd like to import it when it is needed.

>>>> +/* Highest possible physical address supported */
>>>> +static inline int
>>>> +get_phy_mask_shift_arm64(void)
>>>> +{
>>>> +       int pa_bits = 48 /* default: 48-bit PA */;
>>>> +
>>>> +       if (NUMBER(MAX_PHYSMEM_BITS) != NOT_FOUND_NUMBER)
>>>> +               pa_bits = NUMBER(MAX_PHYSMEM_BITS);
>>>> +
>>>> +       return pa_bits;
>>>> +}
>>
>> Is this needed to be an inline function?
> 
> IMO, its better to keep this as inline.

Once you modify the part of setting info->max_physmem_bits below,
we can remove this function, because we don't use PHYS_MASK_SHIFT
anymore.

>>>> -#define PMD_TYPE_MASK          3
>>>> -#define PMD_TYPE_SECT          1
>>>> -#define PMD_TYPE_TABLE         3
>>>> +#define PHYS_MASK_SHIFT                get_phy_mask_shift_arm64()
>>>>
>>>> -#define PUD_TYPE_MASK          3
>>>> -#define PUD_TYPE_SECT          1
>>>> -#define PUD_TYPE_TABLE         3
>>>> +/* Helper API to convert between a physical address and its placement
>>>> + * in a page table entry, taking care of 52-bit addresses.
>>>> + */
>>>> +static inline unsigned long
>>>> +__pte_to_phys(pte_t pte)
>>>> +{
>>>> +       if (lpa_52_bit_support_available)
>>
>> OK.
>>
>> According to the related emails, it looks like "PAGESIZE() == SZ_64K"
>> is also usable here, but this is the same condition as kernel's one
>> and easy to understand.
> 
> No, like I clarified to the upstream maintainers, distributions like Fedora already support a default page size of 64K, but the PA address space can be 48 or 52, depending on the kernel version and kernel CONFIG flags used.

My understanding is that with 64k page, we can convert a page table
entry to a physicall address without awareness of 52-bit.

According to this patch, the top 4 bits of a 52-bit physical address
are positioned at bits 12..15 of a page table entry.

commit 75387b92635e7dca410c1ef92cfe510019248f76
Author: Kristina Martsenko <kristina.martsenko@arm.com>
Date:   Wed Dec 13 17:07:21 2017 +0000

    arm64: handle 52-bit physical addresses in page table entries
    
    The top 4 bits of a 52-bit physical address are positioned at bits
    12..15 of a page table entry. Introduce macros to convert between a
    physical address and its placement in a table entry, and change all
    macros/functions that access PTEs to use them.

With 64k page and non-52-bit kernel, it looks like the bits 12..15
are zero, so we can move the zeros to bits 49..51 because the zeros
don't affect the PA, for example:

      52-bit              non-52-bit (48-bit)
  PTE 0x0000123456789000  0x0000123456780000
           v--------^          v--------^   __pte_to_phys() w/52-bit support
  PA  0x0009123456780000  0x0000123456780000

I think that this was what the upstream maintainers said..
But "if (lpa_52_bit_support_available)" is also fine for me.

>>>> @@ -287,6 +481,15 @@ get_stext_symbol(void)
>>>>   int
>>>>   get_machdep_info_arm64(void)
>>>>   {
>>>> +       int pa_bits;
>>>> +
>>>> +       /* Determine if the PA address range is 52-bits: ARMv8.2-LPA */
>>>> +       pa_bits = get_phy_mask_shift_arm64();
>>>> +       DEBUG_MSG("pa_bits    : %d\n", pa_bits);
>>>> +
>>>> +       if (pa_bits == 52)
>>>> +               lpa_52_bit_support_available = 1;
>>>> +
>>
>> This looks a bit redundant, so for example
>>
>>    if (NUMBER(MAX_PHYSMEM_BITS) != NOT_FOUND_NUMBER) {
>>      info->max_physmem_bits = NUMBER(MAX_PHYSMEM_BITS);
>>      if (info->max_physmem_bits == 52)
>>        lpa_52_bit_support_available = 1;
>>    } else
>>      info->max_physmem_bits = 48;
> 
> Ok.
> 

>>>> @@ -425,14 +628,13 @@ vaddr_to_paddr_arm64(unsigned long vaddr)
>>>>                          ERRMSG("Can't get a valid pte.\n");
>>>>                          return NOT_PADDR;
>>>>                  } else {
>>>> -
>>>> -                       paddr = (PAGEBASE(pte_val(ptev)) & PHYS_MASK)
>>>> +                       paddr = (PAGEBASE(pte_val(ptev)) & PTE_ADDR_MASK)
>>>>                                          + (vaddr & (PAGESIZE() - 1));
>>
>> I think __pte_to_phys() is needed also here, not PTE_ADDR_MASK.
> 
> I had some issues with the same on ARMv8 simulator, so lets stick with the tested 'PTE_ADDR_MASK' usage for now.

Did you test this PTE_ADDR_MASK line on a system actually using
52-bit PA? If a 52-bit physical address is actually used, this will
return a wrong address, for example:

  PTE_ADDR_MASK  0x0000fffffffff000
  PTE            0x0000123456789000
  PAGEBASE'd     0x0000123456780000
   v
  paddr          0x0000123456780000 + 64k offset // incorrect

With 52-bit PA, the PTE_ADDR_MASK is used for __phys_to_pte_val(),
not __pte_to_phys().

If I understand correctly, we should need __pte_to_phys() also here.

  paddr = __pte_to_phys(ptev)
                  + (vaddr & (PAGESIZE() - 1));

Could you try this?

Thanks,
Kazu


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
