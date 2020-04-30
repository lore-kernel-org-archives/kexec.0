Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v2 1/2] arm64/crash_core: Export KERNELPACMASK in
 vmcoreinfo
References: <1587968702-19996-1-git-send-email-amit.kachhap@arm.com>
From: Amit Kachhap <amit.kachhap@arm.com>
Message-ID: <f7dad36c-6944-f5c9-b835-0992ff0391e5@arm.com>
Date: Thu, 30 Apr 2020 17:14:34 +0530
MIME-Version: 1.0
In-Reply-To: <1587968702-19996-1-git-send-email-amit.kachhap@arm.com>
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
To: linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>, Vincenzo Frascino <Vincenzo.Frascino@arm.com>

Hi Will/Catalin,

Sorry: Resending with correct To list.

On 4/27/20 11:55 AM, Amit Daniel Kachhap wrote:
> Recently arm64 linux kernel added support for Armv8.3-A Pointer
> Authentication feature. If this feature is enabled in the kernel and the
> hardware supports address authentication then the return addresses are
> signed and stored in the stack to prevent ROP kind of attack. Kdump tool
> will now dump the kernel with signed lr values in the stack.
> 
> Any user analysis tool for this kernel dump may need the kernel pac mask
> information in vmcoreinfo to generate the correct return address for
> stacktrace purpose as well as to resolve the symbol name.
> 
> This patch is similar to commit ec6e822d1a22d0eef ("arm64: expose user PAC
> bit positions via ptrace") which exposes pac mask information via ptrace
> interfaces.

This patch user side changes are accepted by crash-utility maintainer [1]
so I think this is in a good shape to go in.

Thanks,
Amit Daniel

[1]: https://www.redhat.com/archives/crash-utility/2020-April/msg00095.html

> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
> ---
> Changes since v1:
> * Rebased to kernel 5.7-rc3.
> * commit log change.
> 
> An implementation of this new KERNELPACMASK vmcoreinfo field used by crash
> tool can be found here[1]. This change is accepted by crash utility
> maintainer [2].
> 
> [1]: https://www.redhat.com/archives/crash-utility/2020-April/msg00095.html
> [2]: https://www.redhat.com/archives/crash-utility/2020-April/msg00099.html
> 
>   arch/arm64/include/asm/compiler.h | 3 +++
>   arch/arm64/kernel/crash_core.c    | 4 ++++
>   2 files changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/compiler.h b/arch/arm64/include/asm/compiler.h
> index eece20d..32d5900 100644
> --- a/arch/arm64/include/asm/compiler.h
> +++ b/arch/arm64/include/asm/compiler.h
> @@ -19,6 +19,9 @@
>   #define __builtin_return_address(val)					\
>   	(void *)(ptrauth_clear_pac((unsigned long)__builtin_return_address(val)))
>   
> +#else  /* !CONFIG_ARM64_PTR_AUTH */
> +#define	ptrauth_user_pac_mask()		0ULL
> +#define	ptrauth_kernel_pac_mask()	0ULL
>   #endif /* CONFIG_ARM64_PTR_AUTH */
>   
>   #endif /* __ASM_COMPILER_H */
> diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/crash_core.c
> index ca4c3e1..25cf2ce 100644
> --- a/arch/arm64/kernel/crash_core.c
> +++ b/arch/arm64/kernel/crash_core.c
> @@ -6,6 +6,7 @@
>   
>   #include <linux/crash_core.h>
>   #include <asm/memory.h>
> +#include <asm/pointer_auth.h>
>   
>   void arch_crash_save_vmcoreinfo(void)
>   {
> @@ -16,4 +17,7 @@ void arch_crash_save_vmcoreinfo(void)
>   	vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=0x%llx\n",
>   						PHYS_OFFSET);
>   	vmcoreinfo_append_str("KERNELOFFSET=%lx\n", kaslr_offset());
> +	vmcoreinfo_append_str("NUMBER(KERNELPACMASK)=0x%llx\n",
> +						system_supports_address_auth() ?
> +						ptrauth_kernel_pac_mask() : 0);
>   }
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
