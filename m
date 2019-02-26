Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyVKx-0002OD-9r
 for kexec@lists.infradead.org; Tue, 26 Feb 2019 05:31:29 +0000
Received: by mail-pg1-f194.google.com with SMTP id m2so5644667pgl.5
 for <kexec@lists.infradead.org>; Mon, 25 Feb 2019 21:31:26 -0800 (PST)
Subject: Re: [PATCH v2 1/2] makedumpfile/arm64: Add support for ARMv8.2-LPA
 (52-bit PA support)
References: <1550348658-15300-1-git-send-email-bhsharma@redhat.com>
 <1550348658-15300-2-git-send-email-bhsharma@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03568BED@BPXM09GP.gisp.nec.co.jp>
 <e4c3d54a-057c-c611-6ab1-c0870b30275f@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03568E41@BPXM09GP.gisp.nec.co.jp>
From: Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <d3dee972-8549-d525-e62c-e4828d8c4813@redhat.com>
Date: Tue, 26 Feb 2019 11:01:21 +0530
MIME-Version: 1.0
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC03568E41@BPXM09GP.gisp.nec.co.jp>
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
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi Kazu,

On 02/22/2019 09:54 PM, Kazuhito Hagio wrote:
> Hi Bhupesh,
> 
> -----Original Message-----
>> Hi Kazu,
>>
>> Thanks for the review.
>>
>> On 02/21/2019 09:05 PM, Kazuhito Hagio wrote:
>>> Hi Bhupesh,
>>>
>>> -----Original Message-----
>>>> ARMv8.2-LPA architecture extension (if available on underlying hardware)
>>>> can support 52-bit physical addresses, while the kernel virtual
>>>> addresses remain 48-bit.
>>>>
>>>> This patch is in accordance with ARMv8 Architecture Reference Manual
>>>> version D.a
>>>>
>>>> Make sure that we read the 52-bit PA address capability from
>>>> 'MAX_PHYSMEM_BITS' variable (if available in vmcoreinfo) and
>>>> accordingly change the pte_to_phy() mask values and also traverse
>>>> the page-table walk accordingly.
>>>>
>>>> Also make sure that it works well for the existing 48-bit PA address
>>>> platforms and also on environments which use newer kernels with 52-bit
>>>> PA support but hardware which is not ARM8.2-LPA compliant.
>>>>
>>>> I have sent a kernel patch upstream to add 'MAX_PHYSMEM_BITS' to
>>>> vmcoreinfo for arm64 (see [0]).
>>>>
>>>> [0]. http://lists.infradead.org/pipermail/kexec/2019-February/022411.html
>>>>
>>>> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
>>>
>>> This patch looks good to me.
>>> For two slight things below, I will remove them when merging.
>>>
>>>> +/*
>>>> + * Size mapped by an entry at level n ( 0 <= n <= 3)
>>>> + * We map (PAGE_SHIFT - 3) at all translation levels and PAGE_SHIFT bits
>>>> + * in the final page. The maximum number of translation levels supported by
>>>> + * the architecture is 4. Hence, starting at at level n, we have further
>>>> + * ((4 - n) - 1) levels of translation excluding the offset within the page.
>>>> + * So, the total number of bits mapped by an entry at level n is :
>>>> + *
>>>> + *  ((4 - n) - 1) * (PAGE_SHIFT - 3) + PAGE_SHIFT
>>>> + *
>>>> + * Rearranging it a bit we get :
>>>> + *   (4 - n) * (PAGE_SHIFT - 3) + 3
>>>> + */
>>>
>>> Will remove this comment.
>>
>> Ok.
>>
>>>> +#define pmd_offset_pgtbl_lvl_2(dir, vaddr) ((pmd_t *)dir)
>>>> +#define pmd_offset_pgtbl_lvl_3(dir, vaddr) (pud_page_paddr((*(dir))) + pmd_index(vaddr) *
>> sizeof(pmd_t))
>>>
>>> Will remove these two macros not in use.
>>
>> Ok.
>>
>>>
>>> And, as I said on another thread, I'm thinking to merge the following
>>> patch after your patch 1/2, it tested OK with 48-bit and 52-bit PA
>>> without NUMBER(MAX_PHYSMEM_BITS) in vmcoreinfo.
>>> Do you think of any case that this will not work well?
>>>
>>> diff --git a/arch/arm64.c b/arch/arm64.c
>>> index 29247a7..c7e60e0 100644
>>> --- a/arch/arm64.c
>>> +++ b/arch/arm64.c
>>> @@ -127,6 +127,9 @@ typedef unsigned long pgdval_t;
>>>     */
>>>    #define SECTIONS_SIZE_BITS	30
>>>
>>> +#define _MAX_PHYSMEM_BITS_48	48
>>> +#define _MAX_PHYSMEM_BITS_52	52
>>> +
>>>    /*
>>>     * Hardware page table definitions.
>>>     *
>>> @@ -402,17 +405,27 @@ get_stext_symbol(void)
>>>    	return(found ? kallsym : FALSE);
>>>    }
>>>
>>> +static int
>>> +set_max_physmem_bits_arm64(void)
>>> +{
>>> +	long array_len = ARRAY_LENGTH(mem_section);
>>> +
>>> +	info->max_physmem_bits = _MAX_PHYSMEM_BITS_48;
>>> +	if ((array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT_EXTREME()))
>>> +		|| (array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT())))
>>> +		return TRUE;
>>> +
>>> +	info->max_physmem_bits = _MAX_PHYSMEM_BITS_52;
>>> +	if ((array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT_EXTREME()))
>>> +		|| (array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT())))
>>> +		return TRUE;
>>> +
>>> +	return FALSE;
>>> +}
>>> +
>>>    int
>>>    get_machdep_info_arm64(void)
>>>    {
>>> -	/* Determine if the PA address range is 52-bits: ARMv8.2-LPA */
>>> -	if (NUMBER(MAX_PHYSMEM_BITS) != NOT_FOUND_NUMBER) {
>>> -		info->max_physmem_bits = NUMBER(MAX_PHYSMEM_BITS);
>>> -		if (info->max_physmem_bits == 52)
>>> -			lpa_52_bit_support_available = 1;
>>> -	} else
>>> -		info->max_physmem_bits = 48;
>>> -
>>>    	/* Check if va_bits is still not initialized. If still 0, call
>>>    	 * get_versiondep_info() to initialize the same.
>>>    	 */
>>> @@ -428,9 +441,24 @@ get_machdep_info_arm64(void)
>>>    	info->section_size_bits = SECTIONS_SIZE_BITS;
>>>
>>>    	DEBUG_MSG("kimage_voffset   : %lx\n", kimage_voffset);
>>> -	DEBUG_MSG("max_physmem_bits : %ld\n", info->max_physmem_bits);
>>>    	DEBUG_MSG("section_size_bits: %ld\n", info->section_size_bits);
>>>
>>> +	/* Determine if the PA address range is 52-bits: ARMv8.2-LPA */
>>> +	if (NUMBER(MAX_PHYSMEM_BITS) != NOT_FOUND_NUMBER) {
>>> +		info->max_physmem_bits = NUMBER(MAX_PHYSMEM_BITS);
>>> +		DEBUG_MSG("max_physmem_bits : %ld (vmcoreinfo)\n",
>>> +				info->max_physmem_bits);
>>> +	} else if (set_max_physmem_bits_arm64()) {
>>> +		DEBUG_MSG("max_physmem_bits : %ld (detected)\n",
>>> +				info->max_physmem_bits);
>>> +	} else {
>>> +		ERRMSG("Can't determine max_physmem_bits value\n");
>>> +		return FALSE;
>>> +	}
>>> +
>>> +	if (info->max_physmem_bits == 52)
>>> +		lpa_52_bit_support_available = 1;
>>> +
>>>    	return TRUE;
>>>    }
>>
>> I have not tested the above suggestion on a real hardware or emulation
>> model yet, but as we were discussing in the kernel patch review thread
>> (see [0]), IMO, we don't need to carry the above hoops for
>> 'MAX_PHYSMEM_BITS' calculation in makedumpfile code as it makes the code
>> less portable for a newer kernel version and also since other user-space
>> utilities (like crash) also need a mechanism to determine the PA_BITS
>> supported by the underlying kernel, so we can use the same uniform
>> method of using an exported 'MAX_PHYSMEM_BITS' value in the vmcoreinfo
>> so that all user-land applications can use the same.
>>
>> I think Dave A. (crash utility maintainer) also pointed to a similar
>> concern in the above thread.
> 
> I see. As I replied [1], I also think ideally we should export it.
> [1] http://lists.infradead.org/pipermail/kexec/2019-February/022474.html
> 
> Can we export it from kernel/crash_core.c?
> I'd like to avoid repeating such a discussion every time we need it
> for each architecture..

Sure. I will try and convince the maintainers of other archs (x86 and  
ppc) for a common export via 'kernel/crash_core.c'. I will continue this  
discussion with the other maintainers on the kernel thread.

In the meanwhile, from makedumpfile p-o-v, I will send a v3 to address  
your concerns on the LVA patch (v1), which I seem to have missed while  
sending out the v2.

Thanks,
Bhupesh



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
