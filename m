From: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Date: Thu, 19 May 2022 14:43:38 +0530
Subject: [PATCH] kexec_file: Drop weak attribute from
 arch_kexec_apply_relocations[_add]
In-Reply-To: <20220518134705.7ae186d5419b24d689a38ccc@linux-foundation.org>
References: <20220518181828.645877-1-naveen.n.rao@linux.vnet.ibm.com>
 <20220518134705.7ae186d5419b24d689a38ccc@linux-foundation.org>
Message-ID: <1652950421.sq10xtycz9.naveen@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Andrew Morton wrote:
> On Wed, 18 May 2022 23:48:28 +0530 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
>> Since commit d1bcae833b32f1 ("ELF: Don't generate unused section
>> symbols") [1], binutils (v2.36+) started dropping section symbols that
>> it thought were unused.  This isn't an issue in general, but with
>> kexec_file.c, gcc is placing kexec_arch_apply_relocations[_add] into a
>> separate .text.unlikely section and the section symbol ".text.unlikely"
>> is being dropped. Due to this, recordmcount is unable to find a non-weak
>> symbol in .text.unlikely to generate a relocation record against.
>> 
>> Address this by dropping the weak attribute from these functions:
>> - arch_kexec_apply_relocations() is not overridden by any architecture
>>   today, so just drop the weak attribute.
>> - arch_kexec_apply_relocations_add() is only overridden by x86 and s390.
>>   Retain the function prototype for those and move the weak
>>   implementation into the header as a static inline for other
>>   architectures.
>> 
>> ...
>>
> 
> Sigh.  This patch demonstrates why I like __weak :<
> 
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -229,6 +225,30 @@ extern int crash_exclude_mem_range(struct crash_mem *mem,
>>  				   unsigned long long mend);
>>  extern int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
>>  				       void **addr, unsigned long *sz);
>> +
>> +#if defined(CONFIG_X86_64) || defined(CONFIG_S390)
> 
> Let's avoid listing the architectures here?  Better to add
> 
> 	select ARCH_HAVE_ARCH_KEXEC_APPLY_RELOCATIONS_ADD
> 
> to arch/<arch>/Kconfig?

I followed the approach used in commit 6e7b64b9dd6d96 ("elfcore: fix 
building with clang") since here again, it was overridden on only two 
architectures. I also wanted to avoid touching the architecture headers 
so as to make it simpler to backport.

But, as Michael points out, using a #ifdef isn't too much of a change 
either. I also confirmed that those changes still apply cleanly all the 
way back to v5.10. I've posted a v2 which takes this approach.

> 
> Please cc me on any additional work on this.

I've copied you on the v2 patch. Thanks!


- Naveen


