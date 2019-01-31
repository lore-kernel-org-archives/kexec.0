Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp999-00086Y-Pc
 for kexec@lists.infradead.org; Thu, 31 Jan 2019 10:00:47 +0000
Received: by mail-pl1-f196.google.com with SMTP id p8so1262597plo.2
 for <kexec@lists.infradead.org>; Thu, 31 Jan 2019 02:00:33 -0800 (PST)
Subject: Re: [PATCH] arm64, vmcoreinfo : Append 'MAX_USER_VA_BITS' and
 'MAX_PHYSMEM_BITS' to vmcoreinfo
References: <1548850991-11879-1-git-send-email-bhsharma@redhat.com>
 <20190131014800.GB15785@dhcp-128-65.nay.redhat.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <fea7823d-60ab-2765-031f-6e8c312d7672@redhat.com>
Date: Thu, 31 Jan 2019 15:30:23 +0530
MIME-Version: 1.0
In-Reply-To: <20190131014800.GB15785@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, lijiang@redhat.com, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, kexec@lists.infradead.org, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, Borislav Petkov <bp@alien8.de>, anderson@redhat.com, bhupesh.linux@gmail.com, linux-arm-kernel@lists.infradead.org

On 01/31/2019 07:18 AM, Dave Young wrote:
> + more people
> On 01/30/19 at 05:53pm, Bhupesh Sharma wrote:
>> With ARMv8.2-LVA and LPA architecture extensions, arm64 hardware which
>> supports these extensions can support upto 52-bit virtual and 52-bit
>> physical addresses respectively.
>>
>> Since at the moment we enable the support of these extensions via CONFIG
>> flags, e.g.
>>   - LPA via CONFIG_ARM64_PA_BITS_52
>>
>> there are no clear mechanisms in user-space right now to
>> deteremine these CONFIG flag values and also determine the PARange and
>> VARange address values.
>>
>> User-space tools like 'makedumpfile' and 'crash-utility' can instead
>> use the 'MAX_USER_VA_BITS' and 'MAX_PHYSMEM_BITS' values to determine
>> the maximum virtual address and physical address (respectively)
>> supported by underlying kernel.
>>
>> A reference 'makedumpfile' implementation which uses this approach to
>> determining the maximum physical address is available in [0].
>>
>> [0]. https://github.com/bhupesh-sharma/makedumpfile/blob/52-bit-pa-support-via-vmcore-v1/arch/arm64.c#L490
> 
> I'm not objecting the patch, just want to make sure to make clear about
> things and make sure these issues are aware by people, and leave arm
> people to review the arm bits.
> 
> 1. MAX_PHYSMEM_BITS
> As we previously found, back to 2014 makedumpfile took a patch to read the
> value from vmcore but the kernel patch was not accepted.
> So we should first make clear if this is really needed, why other arches
> do not need this in makedumpfile.

I explained this a bit in my reply to Suzuki's and James's review 
comments yesterday, but let me summarize the same again for better clarity:

Let's take the example of x86. We have CONFIG_X86_5LEVEL config flag to 
indicate 5 level page-table support. We export the same in vmcoreinfo 
for x86_64 using:

void arch_crash_save_vmcoreinfo(void)
{
     <.. snip..>
     vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
             pgtable_l5_enabled());
}

Also a simple grep in makedumpfile and crash for the same indicates that 
the user-space code determines the MAX_PHYSMEM_BITS value using the 
'pgtable_l5_enabled' value available in vmcoreinfo:

Example from makedumpfile:
-------------------------
int
get_versiondep_info_x86_64(void)
{
	/*
	 * On linux-2.6.26, MAX_PHYSMEM_BITS is changed to 44 from 40.
	 */
	if (info->kernel_version < KERNEL_VERSION(2, 6, 26))
		info->max_physmem_bits  = _MAX_PHYSMEM_BITS_ORIG;
	else if (info->kernel_version < KERNEL_VERSION(2, 6, 31))
		info->max_physmem_bits  = _MAX_PHYSMEM_BITS_2_6_26;
	else if(check_5level_paging())
		info->max_physmem_bits  = _MAX_PHYSMEM_BITS_5LEVEL;
	else
		info->max_physmem_bits  = _MAX_PHYSMEM_BITS_2_6_31;

	...
}

As we can see above, we use several if-else cases to determine the 
'MAX_PHYSMEM_BITS', one of which is setting it to 52-bit, if the 
'pgtable_l5_enabled' value is available and TRUE in vmcoreinfo.

So, we determine 'MAX_PHYSMEM_BITS' value in makedumpfile via a 
vmcoreinfo export'ed variable (rather than using  named 
'MAX_PHYSMEM_BITS' its 'pgtable_l5_enabled' that is being used).

Since for arm64, we don't have a single CONFIG flag for 52-bit addresses 
spaces (kernel VA, user-space VA and PA), so its better to export the 
respective CONFIG flags in the vmcoreinfo directly.

> If we really need it then should it be arm64 only?

See above, since archs like x86 use a single flag: CONFIG_X86_5LEVEL, 
whereas arm64 can use the combination of following flags to indicate 
combinations of various address spaces:

- 48-bit kernel VA + 48-bit user-space VA + 52-bit PA
- 48-bit kernel VA + 52-bit user-space VA + 52-bit PA
- 52-bit kernel VA + 52-bit user-space VA + 52-bit PA


CONFIG_ARM64_64K_PAGES
CONFIG_ARM64_USER_VA_BITS_52
CONFIG_ARM64_VA_BITS
CONFIG_ARM64_PA_BITS_52
CONFIG_ARM64_PA_BITS
CONFIG_EXPERT, and
CONFIG_ARM64_FORCE_52BIT

so probably its not correct to compare the two cases one-to-one (its 
more like an apple and an orange comparison).

> If it is arm64 only then the makedumpfile code should read this number
> only for arm64.
> 
> Also Lianbo added the vmcoreinfo documents, I believe it stays in -tip
> tree,  need to make sure to document this as well.

Sure, I will send a separate patch to fix the same, once this gets in.

> 
> 2. MAX_USER_VA_BITS
> Does makedumpfile care about userspace VA bits? 

Yes. Consider the case 48-bit kernel VA and 52-bit user-space VA, which 
is a perfectly valid case on arm64. In such cases VA_BITS is set to 48, 
whereas  MAX_USER_VA_BITS is set to 52, which allows user-space 
applications which use 52-bit virtual address to pass a hint to 'mmap' 
to get high addresses.

  I do not see other code
> doing this,  Kazu and Dave A should be able to comment.

I talked to Dave A. yesterday off-list, I think he mentioned that these 
changes are useful for crash-utility as well and he was hoping it gets 
accepted soon so that kernel-debugging tools can handle increased 
address spaces on arm64.

But it will be great to have reviews/ACKs from Dave A and others as well.

Thanks,
Bhupesh

> 
> I tend to doubt about this.
> 
>>
>> Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: James Morse <james.morse@arm.com>
>> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
>> ---
>>   arch/arm64/kernel/crash_core.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/crash_core.c
>> index ca4c3e12d8c5..ad231be5c0d8 100644
>> --- a/arch/arm64/kernel/crash_core.c
>> +++ b/arch/arm64/kernel/crash_core.c
>> @@ -10,6 +10,8 @@
>>   void arch_crash_save_vmcoreinfo(void)
>>   {
>>   	VMCOREINFO_NUMBER(VA_BITS);
>> +	VMCOREINFO_NUMBER(MAX_USER_VA_BITS);
>> +	VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
>>   	/* Please note VMCOREINFO_NUMBER() uses "%d", not "%x" */
>>   	vmcoreinfo_append_str("NUMBER(kimage_voffset)=0x%llx\n",
>>   						kimage_voffset);
>> -- 
>> 2.7.4
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
> 
> Thanks
> Dave
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
