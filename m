Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goxZz-0005L1-IZ
 for kexec@lists.infradead.org; Wed, 30 Jan 2019 21:39:34 +0000
Received: by mail-pf1-f196.google.com with SMTP id i12so428997pfo.7
 for <kexec@lists.infradead.org>; Wed, 30 Jan 2019 13:39:31 -0800 (PST)
Subject: Re: [PATCH] arm64, vmcoreinfo : Append 'MAX_USER_VA_BITS' and
 'MAX_PHYSMEM_BITS' to vmcoreinfo
References: <1548850991-11879-1-git-send-email-bhsharma@redhat.com>
 <239cdca4-1c7d-f236-f4a9-a0a3fe98f966@arm.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <86c0dd9f-a55b-8ce8-69ca-893f63087d1a@redhat.com>
Date: Thu, 31 Jan 2019 03:09:24 +0530
MIME-Version: 1.0
In-Reply-To: <239cdca4-1c7d-f236-f4a9-a0a3fe98f966@arm.com>
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
To: James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, kexec@lists.infradead.org, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, bhupesh.linux@gmail.com, linux-arm-kernel@lists.infradead.org

Hi James,

Thanks for review.
Please see my comments inline.


On 01/30/2019 08:51 PM, James Morse wrote:
> Hi Bhupesh,
> 
> On 01/30/2019 12:23 PM, Bhupesh Sharma wrote:
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
>> User-space tools like 'makedumpfile' and 'crash-utility' can instead
>> use the 'MAX_USER_VA_BITS' and 'MAX_PHYSMEM_BITS' values to determine
>> the maximum virtual address and physical address (respectively)
>> supported by underlying kernel.
>>
>> A reference 'makedumpfile' implementation which uses this approach to
>> determining the maximum physical address is available in [0].
> 
> Why does it need to know?
> 
> (Suzuki asked the same question on your earlier version)
> https://lore.kernel.org/linux-arm-kernel/cff44754-7fe4-efea-bc8e-4dde2277c821@arm.com/ 

I have shared some details (after discussion with our test teams) in 
reply to the review comments from Suzuki here:
http://lists.infradead.org/pipermail/kexec/2019-January/022389.html, and
http://lists.infradead.org/pipermail/kexec/2019-January/022390.html

Just to summarize, I mentioned in my replies to the review comments tha 
the makedumpfile implementation (for decoding the PTE) was just as an 
example, however there can be other user-space applications, for e.g a 
user-space application running with 48-bit kernel VA and 52-bit user 
space VA and requesting allocation in 'high' address via a 'hint' to mmap.

>  From your github link it looks like you use this to re-assemble the two 
> bits of the PFN from the pte. Can't you always do this for 64K pages? 
> CPUs with the feature always do this too, its not something the kernel 
> turns on.

Ok, let me try to give some perspective of a common makedumpfile 
use-case before I jump into the details:

(a) makedumpfile tool can be used to generate a vmcore and analyze it 
later. So for example we can create vmcore for a system running with 
page-size = 64K and analyze it later on a different system using 
page-size = 4K.

Since several makedumpfile code legs (for page-table walk) are common in 
both the paths (creating a vmcore and analyzing a vmcore), we cannot 
hardcode the PTE calculation masks for either 48-bit or 52-bit address 
spaces (or 4K/64K page sizes). The example invocations for the two cases 
is given below:

Create a vmcore dump on a 64K machine:
# makedumpfile -l --message-level 1 -d 31 /proc/vmcore vmcore

Analyze the vmcore dump on a 4K machine:
# makedumpfile -d 31 -x vmlinux vmcore dumpfile

Also hardcoding the PTE calculation to use the high address bit mask 
always will break the backward compatibility with older kernels (which 
don't support 52-bit address space extensions).

(b). Also x86_64 already has a vmcoreinfo export for 'pgtable_l5_enabled':

void arch_crash_save_vmcoreinfo(void)
{
	<.. snip..>
	vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
			pgtable_l5_enabled());
}

And the makedumpfile code uses the same to determine support for 5-level 
page tables in x86_64, see 
<https://github.com/bhupesh-sharma/makedumpfile/blob/52-bit-pa-support-via-vmcore-v1/arch/x86_64.c#L36> 
for example.

Thanks,
Bhupesh

> 
>> diff --git a/arch/arm64/kernel/crash_core.c 
>> b/arch/arm64/kernel/crash_core.c
>> index ca4c3e12d8c5..ad231be5c0d8 100644
>> --- a/arch/arm64/kernel/crash_core.c
>> +++ b/arch/arm64/kernel/crash_core.c
>> @@ -10,6 +10,8 @@
>>   void arch_crash_save_vmcoreinfo(void)
>>   {
>>       VMCOREINFO_NUMBER(VA_BITS);
>> +    VMCOREINFO_NUMBER(MAX_USER_VA_BITS);
>> +    VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
>>       /* Please note VMCOREINFO_NUMBER() uses "%d", not "%x" */
>>       vmcoreinfo_append_str("NUMBER(kimage_voffset)=0x%llx\n",
>>                           kimage_voffset);
>>
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
