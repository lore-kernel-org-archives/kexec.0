Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v6 2/2] arm64/crash_core: Export TCR_EL1.T1SZ in vmcoreinfo
References: <1589395957-24628-1-git-send-email-bhsharma@redhat.com>
 <1589395957-24628-3-git-send-email-bhsharma@redhat.com>
From: James Morse <james.morse@arm.com>
Message-ID: <7abd195f-2091-0ef9-2e0b-4a8bf2cf820e@arm.com>
Date: Wed, 1 Jul 2020 12:59:39 +0100
MIME-Version: 1.0
In-Reply-To: <1589395957-24628-3-git-send-email-bhsharma@redhat.com>
Content-Language: en-GB
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
To: Bhupesh Sharma <bhsharma@redhat.com>, linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Steve Capper <steve.capper@arm.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Dave Anderson <anderson@redhat.com>, bhupesh.linux@gmail.com, Will Deacon <will@kernel.org>

Hi Bhupesh,

On 13/05/2020 19:52, Bhupesh Sharma wrote:
> vabits_actual variable on arm64 indicates the actual VA space size,
> and allows a single binary to support both 48-bit and 52-bit VA
> spaces.

I'd prefer the commit message not to refer to this 'vabits_actual' thing at all. By the
time a git-archaeologist comes to read this, it may be long gone.

Ideally this would refer to: TCR_EL1.TxSZ, which controls the VA space size,
and can be configured by a single kernel image to support either 48-bit or 52-bit VA space.


> If the ARMv8.2-LVA optional feature is present, and we are running
> with a 64KB page size; then it is possible to use 52-bits of address
> space for both userspace and kernel addresses. However, any kernel
> binary that supports 52-bit must also be able to fall back to 48-bit
> at early boot time if the hardware feature is not present.
> 
> Since TCR_EL1.T1SZ indicates the size offset of the memory region
> addressed by TTBR1_EL1 (and hence can be used for determining the
> vabits_actual value) it makes more sense to export the same in
> vmcoreinfo rather than vabits_actual variable, as the name of the
> variable can change in future kernel versions, but the architectural
> constructs like TCR_EL1.T1SZ can be used better to indicate intended
> specific fields to user-space.
> 
> User-space utilities like makedumpfile and crash-utility, need to
> read this value from vmcoreinfo for determining if a virtual
> address lies in the linear map range.
> 
> While at it also add documentation for TCR_EL1.T1SZ variable being
> added to vmcoreinfo.
> 
> It indicates the size offset of the memory region addressed by TTBR1_EL1

> diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/crash_core.c
> index 1f646b07e3e9..314391a156ee 100644
> --- a/arch/arm64/kernel/crash_core.c
> +++ b/arch/arm64/kernel/crash_core.c
> @@ -7,6 +7,14 @@
>  #include <linux/crash_core.h>
>  #include <asm/cpufeature.h>
>  #include <asm/memory.h>
> +#include <asm/pgtable-hwdef.h>
> +
> +static inline u64 get_tcr_el1_t1sz(void);
> +
> +static inline u64 get_tcr_el1_t1sz(void)
> +{
> +	return (read_sysreg(tcr_el1) & TCR_T1SZ_MASK) >> TCR_T1SZ_OFFSET;
> +}
>  
>  void arch_crash_save_vmcoreinfo(void)
>  {
> @@ -16,6 +24,8 @@ void arch_crash_save_vmcoreinfo(void)
>  						kimage_voffset);
>  	vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=0x%llx\n",
>  						PHYS_OFFSET);
> +	vmcoreinfo_append_str("NUMBER(TCR_EL1_T1SZ)=0x%llx\n",
> +						get_tcr_el1_t1sz());
>  	vmcoreinfo_append_str("KERNELOFFSET=%lx\n", kaslr_offset());
>  	vmcoreinfo_append_str("NUMBER(KERNELPACMASK)=0x%llx\n",
>  						system_supports_address_auth() ?

(I think second guessing the kernel memory map is a sisyphean effort), but this register
isn't going to disappear, or change its meaning!:

Reviewed-by: James Morse <james.morse@arm.com>

You may need to re-post this to get the maintainer's attention as its normally safe to
assume patches posted before rc1 no longer apply. (in this case, this one does)


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
