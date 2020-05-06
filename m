Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Amit Kachhap <amit.kachhap@arm.com>
Subject: Re: [PATCH v2 1/2] arm64/crash_core: Export KERNELPACMASK in
 vmcoreinfo
References: <1587968702-19996-1-git-send-email-amit.kachhap@arm.com>
 <20200504171741.GD1833@willie-the-truck>
Message-ID: <bc5e6fc5-15f4-40bb-4466-816de5912893@arm.com>
Date: Wed, 6 May 2020 17:32:56 +0530
MIME-Version: 1.0
In-Reply-To: <20200504171741.GD1833@willie-the-truck>
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
To: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>, Vincenzo Frascino <Vincenzo.Frascino@arm.com>, linux-arm-kernel@lists.infradead.org

Hi Will,

On 5/4/20 10:47 PM, Will Deacon wrote:
> On Mon, Apr 27, 2020 at 11:55:01AM +0530, Amit Daniel Kachhap wrote:
>> Recently arm64 linux kernel added support for Armv8.3-A Pointer
>> Authentication feature. If this feature is enabled in the kernel and the
>> hardware supports address authentication then the return addresses are
>> signed and stored in the stack to prevent ROP kind of attack. Kdump tool
>> will now dump the kernel with signed lr values in the stack.
>>
>> Any user analysis tool for this kernel dump may need the kernel pac mask
>> information in vmcoreinfo to generate the correct return address for
>> stacktrace purpose as well as to resolve the symbol name.
>>
>> This patch is similar to commit ec6e822d1a22d0eef ("arm64: expose user PAC
>> bit positions via ptrace") which exposes pac mask information via ptrace
>> interfaces.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
>> ---
>> Changes since v1:
>> * Rebased to kernel 5.7-rc3.
>> * commit log change.
>>
>> An implementation of this new KERNELPACMASK vmcoreinfo field used by crash
>> tool can be found here[1]. This change is accepted by crash utility
>> maintainer [2].
>>
>> [1]: https://www.redhat.com/archives/crash-utility/2020-April/msg00095.html
>> [2]: https://www.redhat.com/archives/crash-utility/2020-April/msg00099.html
>>
>>   arch/arm64/include/asm/compiler.h | 3 +++
>>   arch/arm64/kernel/crash_core.c    | 4 ++++
>>   2 files changed, 7 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/compiler.h b/arch/arm64/include/asm/compiler.h
>> index eece20d..32d5900 100644
>> --- a/arch/arm64/include/asm/compiler.h
>> +++ b/arch/arm64/include/asm/compiler.h
>> @@ -19,6 +19,9 @@
>>   #define __builtin_return_address(val)					\
>>   	(void *)(ptrauth_clear_pac((unsigned long)__builtin_return_address(val)))
>>   
>> +#else  /* !CONFIG_ARM64_PTR_AUTH */
>> +#define	ptrauth_user_pac_mask()		0ULL
>> +#define	ptrauth_kernel_pac_mask()	0ULL
> 
> This doesn't look quite right to me, since you still have to take into
> account the case where CONFIG_ARM64_PTR_AUTH=y but the feature is not
> available at runtime:

Yes agree with you here. However the config gaurd is saving some extra
computation for __builtin_return_address. There are some compiler
support being added in __builtin_extract_return_address to mask the PAC.
Hopefully that will improve this code. In the meantime let it be like this.

I can remove this else case and as other users of
ptrauth_{kernel,user}_pac_mask(ptrace.c) protect it with a config gaurd
there.

> 
>> @@ -16,4 +17,7 @@ void arch_crash_save_vmcoreinfo(void)
>>   	vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=0x%llx\n",
>>   						PHYS_OFFSET);
>>   	vmcoreinfo_append_str("KERNELOFFSET=%lx\n", kaslr_offset());
>> +	vmcoreinfo_append_str("NUMBER(KERNELPACMASK)=0x%llx\n",
>> +						system_supports_address_auth() ?
>> +						ptrauth_kernel_pac_mask() : 0);
> 
> In which case, would it make more sense to define
> ptrauth_{kernel,user}_pac_mask() unconditionally? In fact, I'd probably
> just remove the guards completely from asm/compiler.h because I think
> they're misleading.

As answered above. Let me know your opinion. Although I don't have 
strong reservation in keeping the config gaurd.

Thanks,
Amit Daniel

> 
> Will
> 
> --->8
> 
> diff --git a/arch/arm64/include/asm/compiler.h b/arch/arm64/include/asm/compiler.h
> index eece20d2c55f..51a7ce87cdfe 100644
> --- a/arch/arm64/include/asm/compiler.h
> +++ b/arch/arm64/include/asm/compiler.h
> @@ -2,8 +2,6 @@
>   #ifndef __ASM_COMPILER_H
>   #define __ASM_COMPILER_H
>   
> -#if defined(CONFIG_ARM64_PTR_AUTH)
> -
>   /*
>    * The EL0/EL1 pointer bits used by a pointer authentication code.
>    * This is dependent on TBI0/TBI1 being enabled, or bits 63:56 would also apply.
> @@ -19,6 +17,4 @@
>   #define __builtin_return_address(val)					\
>   	(void *)(ptrauth_clear_pac((unsigned long)__builtin_return_address(val)))
>   
> -#endif /* CONFIG_ARM64_PTR_AUTH */
> -
>   #endif /* __ASM_COMPILER_H */
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
