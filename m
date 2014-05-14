Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WkU2z-00089e-3V
 for kexec@lists.infradead.org; Wed, 14 May 2014 07:56:18 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [RFC PATCH 2/2] makedumpfile: get additional information from
 vmcore
Date: Wed, 14 May 2014 07:53:38 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE97210997@BPXM01GP.gisp.nec.co.jp>
References: <1399469234-54925-1-git-send-email-sdu.liu@huawei.com>
 <1399469234-54925-3-git-send-email-sdu.liu@huawei.com>
 <0910DD04CBD6DE4193FCF86B9C00BE97210369@BPXM01GP.gisp.nec.co.jp>
 <5371C8E6.6080700@huawei.com>
In-Reply-To: <5371C8E6.6080700@huawei.com>
Content-Language: ja-JP
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
To: "sdu.liu@huawei.com" <sdu.liu@huawei.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>
Cc: "wangnan0@huawei.com" <wangnan0@huawei.com>, "peifeiyue@huawei.com" <peifeiyue@huawei.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "liusdu@126.com" <liusdu@126.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

>On 2014/5/13 14:21, Atsushi Kumagai wrote:
>> Hello Liu,
>>
>>> Now we define MAX_PHYSMEM_BITS and SECTION_SIZE_BITS as
>>> macros. So if we deal with vmcores with different values
>>> of these two macros. We have to recompile makedumpfile.
>>
>> There are other macros which have architecture-specific values
>> (e.g. __PAGE_OFFSET), and some functions are specific to each
>> architecture (e.g. vaddr_to_paddr()), so we need recompilation
>> eventually.
>>
>> OTOH, we already don't need recompilation for the same architecture
>> since the values of such macros are defined for each kernel version
>> like below:
>>
>> #ifdef __x86_64__
>> ...
>> #define _MAX_PHYSMEM_BITS_ORIG          (40)
>> #define _MAX_PHYSMEM_BITS_2_6_26        (44)
>> #define _MAX_PHYSMEM_BITS_2_6_31        (46)
>>
>> So I don't think this patch is valuable.
>
>Hi Atsushi,
>
>For x86, it is not necessory. But for arm, different venders
>may define different SECTION_SIZE_BITS. for example:
>
>   1 arch/arm/mach-clps711x/include/mach/memory.h
>     #define SECTION_SIZE_BITS 24
>   2 arch/arm/mach-exynos/include/mach/memory.h
>     #define SECTION_SIZE_BITS 28
>   4 arch/arm/mach-hisi/include/mach/memory.h
>     #define SECTION_SIZE_BITS 26
>   8 arch/arm/mach-sa1100/include/mach/memory.h
>     #define SECTION_SIZE_BITS 27
>
>Perhaps we should find another way to let the userspace tools
>to get the architecture-specific values.

I see, I think this description is better than the first one.

Now, makedumpfile can't get an appropriate values of the two macros since the
values are variable even if the architecture and the kernel version are fixed
(at least for arm), and we can't solve this without *manual code fixing*, right?

In practice, the current code expects that all arm machines adopt Exynos
processors, this is an problem definitely.

  #ifdef __arm__
  #define KVBASE_MASK             (0xffff)
  #define KVBASE                  (SYMBOL(_stext) & ~KVBASE_MASK)
  #define _SECTION_SIZE_BITS      (28)
  #define _MAX_PHYSMEM_BITS       (32)

I think it's better to fix the descriptions to get acceptability,
but this patch is necessary from the view point of makedumpfile.
So I recommend you to repost this patch set, then I'll accept it.


Thanks
Atsushi Kumagai

>>
>>> This patch makes makedumpfile get these two values from
>>> vmcore info, if existing. It makes the makedumpfile more
>>> compatible to vmcores with different section size.
>>>
>>> Signed-off-by: Liu Hua <sdu.liu@huawei.com>
>>> ---
>>> makedumpfile.c | 17 +++++++++++++++++
>>> makedumpfile.h |  2 ++
>>> 2 files changed, 19 insertions(+)
>>>
>>> diff --git a/makedumpfile.c b/makedumpfile.c
>>> index 6cf6e24..3cdf323 100644
>>> --- a/makedumpfile.c
>>> +++ b/makedumpfile.c
>>> @@ -2111,6 +2111,8 @@ read_vmcoreinfo(void)
>>> 	READ_NUMBER("PG_slab", PG_slab);
>>> 	READ_NUMBER("PG_buddy", PG_buddy);
>>> 	READ_NUMBER("PG_hwpoison", PG_hwpoison);
>>> +	READ_NUMBER("SECTION_SIZE_BITS", SECTION_SIZE_BITS);
>>> +	READ_NUMBER("MAX_PHYSMEM_BITS", MAX_PHYSMEM_BITS);
>>>
>>> 	READ_SRCFILE("pud_t", pud_t);
>>>
>>> @@ -2998,6 +3000,18 @@ initialize_bitmap_memory(void)
>>> }
>>>
>>> int
>>> +calibrate_machdep_info(void)
>>> +{
>>> +	if (NUMBER(MAX_PHYSMEM_BITS) > 0)
>>> +		info->max_physmem_bits = NUMBER(MAX_PHYSMEM_BITS);
>>> +
>>> +	if (NUMBER(SECTION_SIZE_BITS) > 0)
>>> +		info->section_size_bits = NUMBER(SECTION_SIZE_BITS);
>>> +
>>> +	return TRUE;
>>> +}
>>> +
>>> +int
>>> initial(void)
>>> {
>>> 	off_t offset;
>>> @@ -3214,6 +3228,9 @@ out:
>>> 	if (debug_info && !get_machdep_info())
>>> 		return FALSE;
>>>
>>> +	if (debug_info && !calibrate_machdep_info())
>>> +		return FALSE;
>>> +
>>> 	if (is_xen_memory() && !get_dom0_mapnr())
>>> 		return FALSE;
>>>
>>> diff --git a/makedumpfile.h b/makedumpfile.h
>>> index eb03688..7acb23a 100644
>>> --- a/makedumpfile.h
>>> +++ b/makedumpfile.h
>>> @@ -1434,6 +1434,8 @@ struct number_table {
>>> 	long    PG_hwpoison;
>>>
>>> 	long	PAGE_BUDDY_MAPCOUNT_VALUE;
>>> +	long	SECTION_SIZE_BITS;
>>> +	long	MAX_PHYSMEM_BITS;
>>> };
>>>
>>> struct srcfile_table {
>>> --
>>> 1.9.0
>>
>> .
>>
>
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
