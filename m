Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hBe2E-0000bu-5S
 for kexec@lists.infradead.org; Wed, 03 Apr 2019 11:26:28 +0000
Received: by mail-pf1-f196.google.com with SMTP id 10so8011043pfo.5
 for <kexec@lists.infradead.org>; Wed, 03 Apr 2019 04:26:25 -0700 (PDT)
Subject: Re: [PATCH 8/9] arm64: mm: Logic to make offset_ttbr1 conditional
References: <20190218170245.14915-1-steve.capper@arm.com>
 <20190218170245.14915-9-steve.capper@arm.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <47e8dd37-fbcf-8b4f-0f95-b1e0b8efe0e4@redhat.com>
Date: Wed, 3 Apr 2019 16:56:16 +0530
MIME-Version: 1.0
In-Reply-To: <20190218170245.14915-9-steve.capper@arm.com>
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
To: Steve Capper <steve.capper@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: crecklin@redhat.com, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, will.deacon@arm.com, Dave Anderson <anderson@redhat.com>, James Morse <james.morse@arm.com>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi Steve,

On 02/18/2019 10:32 PM, Steve Capper wrote:
> When running with a 52-bit userspace VA and a 48-bit kernel VA we offset
> ttbr1_el1 to allow the kernel pagetables with a 52-bit PTRS_PER_PGD to
> be used for both userspace and kernel.
> 
> Moving on to a 52-bit kernel VA we no longer require this offset to
> ttbr1_el1 should we be running on a system with HW support for 52-bit
> VAs.
> 
> This patch introduces alternative logic to offset_ttbr1 and expands out
> the very early case in head.S. We need to use the alternative framework
> as offset_ttbr1 is used in places in the kernel where it is not possible
> to safely adrp address kernel constants (such as the kpti paths); thus
> code patching is the safer route.
> 
> Signed-off-by: Steve Capper <steve.capper@arm.com>
> ---
>   arch/arm64/include/asm/assembler.h | 10 +++++++++-
>   arch/arm64/include/asm/cpucaps.h   |  3 ++-
>   arch/arm64/kernel/cpufeature.c     | 18 ++++++++++++++++++
>   arch/arm64/kernel/head.S           | 14 +++++++++++++-
>   arch/arm64/kernel/hibernate-asm.S  |  1 +
>   5 files changed, 43 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index 4feb6119c3c9..58ed5d086e1e 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -551,6 +551,14 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
>   	.macro	offset_ttbr1, ttbr
>   #ifdef CONFIG_ARM64_USER_VA_BITS_52
>   	orr	\ttbr, \ttbr, #TTBR1_BADDR_4852_OFFSET
> +#endif
> +
> +#ifdef CONFIG_ARM64_USER_KERNEL_VA_BITS_52
> +alternative_if_not ARM64_HAS_52BIT_VA
> +	orr	\ttbr, \ttbr, #TTBR1_BADDR_4852_OFFSET
> +alternative_else
> +	nop
> +alternative_endif
>   #endif
>   	.endm
>   
> @@ -560,7 +568,7 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
>    * to be nop'ed out when dealing with 52-bit kernel VAs.
>    */
>   	.macro	restore_ttbr1, ttbr
> -#ifdef CONFIG_ARM64_USER_VA_BITS_52
> +#if defined(CONFIG_ARM64_USER_VA_BITS_52) || defined(CONFIG_ARM64_KERNEL_VA_BITS_52)
>   	bic	\ttbr, \ttbr, #TTBR1_BADDR_4852_OFFSET
>   #endif
>   	.endm
> diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
> index 82e9099834ae..d71aecb6d6db 100644
> --- a/arch/arm64/include/asm/cpucaps.h
> +++ b/arch/arm64/include/asm/cpucaps.h
> @@ -60,7 +60,8 @@
>   #define ARM64_HAS_ADDRESS_AUTH_IMP_DEF		39
>   #define ARM64_HAS_GENERIC_AUTH_ARCH		40
>   #define ARM64_HAS_GENERIC_AUTH_IMP_DEF		41
> +#define ARM64_HAS_52BIT_VA			42
>   
> -#define ARM64_NCAPS				42
> +#define ARM64_NCAPS				43
>   
>   #endif /* __ASM_CPUCAPS_H */
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index f6d84e2c92fe..2e150c564f2a 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -944,6 +944,16 @@ has_useable_cnp(const struct arm64_cpu_capabilities *entry, int scope)
>   	return has_cpuid_feature(entry, scope);
>   }
>   
> +#ifdef CONFIG_ARM64_USER_KERNEL_VA_BITS_52
> +extern u64 vabits_actual;
> +static bool __maybe_unused
> +has_52bit_kernel_va(const struct arm64_cpu_capabilities *entry, int scope)
> +{
> +	return vabits_actual == 52;
> +}
> +
> +#endif /* CONFIG_ARM64_USER_KERNEL_VA_BITS_52 */
> +
>   #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>   static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
>   
> @@ -1480,6 +1490,14 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>   		.matches = has_cpuid_feature,
>   	},
>   #endif /* CONFIG_ARM64_PTR_AUTH */
> +#ifdef CONFIG_ARM64_USER_KERNEL_VA_BITS_52
> +	{
> +		.desc = "52-bit kernel VA",
> +		.capability = ARM64_HAS_52BIT_VA,
> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> +		.matches = has_52bit_kernel_va,
> +	},
> +#endif /* CONFIG_ARM64_USER_KERNEL_VA_BITS_52 */
>   	{},
>   };

Right, so now the question is how do we export the 52-bit VA properties 
(that we select in the kernel) to user-space. There are two things to 
consider:

a). CPUs which support ARMv8.2-LVA + newer kernels which export 52-bit 
address capabilities:

- Right now, neither the cpu-feature-registers interface (see [1]) nor 
the HWCAPS interface (see [2]), provide a mechanism to export these 
properties to the user-space.

- I had shared a patch in the past for enabling atleast LVA and LPA 
extension bits to be exported via the cpu-feature-registers interface 
(See: 
http://lists.infradead.org/pipermail/kexec/2019-January/022371.html), 
but we didn't make much progress on the same.

May be Suzuki (in Cc), will have more comments on the same.

[1]. 
https://www.kernel.org/doc/Documentation/arm64/cpu-feature-registers.txt
[2]. https://www.kernel.org/doc/Documentation/arm64/elf_hwcaps.txt

b). CPUs which do not support ARMv8.2-LVA + newer kernels which export 
52-bit address capabilities:

- Right now, for older CPUs running with kernels with 
CONFIG_ARM64_USER_KERNEL_VA_BITS_52=y, if we have:

VA_BITS = 52,
VA_BITS_ACTUAL = vabits_actual = 48,
VA_BITS_MIN = min (48, VA_BITS) = 48.

Now, we need to make user-space aware of the VA_BITS_ACTUAL value, so 
that it can process virtual addresses. Let's consider two different 
use-cases which are normally used to debug live-kernel or debug crashes 
(via kdump):

- Calculating 'vaddr_to_paddr' for a given vaddr (provided to user-space 
for e.g from /proc/kcore file).

A). An essential part of the calculation is to know if the provided 
vaddr lies in the linear map range. In kernel, we use the following 
computation to determine whether an address lies in the linear map range:

#define __is_lm_address(addr)	(!((addr) & BIT(VA_BITS_ACTUAL - 1)))

A similar check is performed in user-space utilities while performing 
live debugging to determine paddr value for a given vaddr (for 
performing a page-table walk).

So, we need a mechanism to have the VA_BITS_ACTUAL value in user-space.
Reading kernel CONFIG flags, vmlinux information and /proc/kallsyms is 
not a portable approach for all user-space use-cases, hence we need a 
standard method of exporting this information to user-space.

May be something like a 
'/sys/devices/system/cpu/addressing-capabilities' node? (similar to 
'/sys/devices/system/cpu/vulnerabilities' we added for sideband 
vulnerabilities).

I understand that it may be difficult to standardize a 'sysfs' 
placeholder for different archs for addressing ranges, but I am just 
thinking out loud here.

May be something like:

+ssize_t cpu_show_address_capabilities(struct device *dev, struct 
device_attribute *attr,
+			    char *buf)
+{
+	return sprintf(buf, "va_bits_actual: %ld\n", vabits_actual);
+}

and more..

See 
<https://github.com/torvalds/linux/blob/master/arch/x86/kernel/cpu/bugs.c#L1188> 
for an example.

B). Debugging a crash dump obtained on one arm64 system (say a 
reporter's machine with VA_BITS_ACTUAL = 48) on another arm64 system 
(say the maintainer's machine with VA_BITS_ACTUAL = 52)

So, we again need a mechanism to have the VA_BITS_ACTUAL value in crash 
vmcore dump'ed on the reporter's machine.

Note, that reading kernel CONFIG flags, vmlinux information or 
/proc/kallsyms on the maintainer's machine will not help in such cases 
as they can be different from the configuration on the reporter's machine.

In such case, it is _mandatory_ to have VA_BITS_ACTUAL information 
exported in vmcoreinfo. Also since commit 23c85094fe18 ("proc/kcore: add 
vmcoreinfo note to /proc/kcore"), we have the same information available 
in kcore.

So, it would make sense to have the following patch for exporting 
VA_BITS_ACTUAL information in vmcoreinfo. I would suggest that we have 
the same added in the re-worked version v2 of the patchset so that the 
user-space works as expected:

----------------------------x

 From 0a4f30357932bf2addd1dda66acde8c26ecd3f75 Mon Sep 17 00:00:00 2001
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Wed, 3 Apr 2019 16:27:10 +0530
Subject: [PATCH] arm64/crash_core: Export VA_BITS_ACTUAL in vmcoreinfo

VA_BITS_ACTUAL indicates the actual VA_BITS detected at boot time which
is required for determining 52-bit kernel address support at boot time.

User-space utilities like makedumpfile and crash-utility, need to
read/write this value from/to vmcoreinfo for determining if a virtual
address lies in the linear map range.

The user-space computation for determining whether an address lies in
the linear map range is the same as we have in kernel-space:

   #define __is_lm_address(addr)	(!((addr) & BIT(VA_BITS_ACTUAL - 1)))

Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
  Documentation/kdump/vmcoreinfo.txt | 7 +++++++
  arch/arm64/kernel/crash_core.c     | 1 +
  2 files changed, 8 insertions(+)

diff --git a/Documentation/kdump/vmcoreinfo.txt 
b/Documentation/kdump/vmcoreinfo.txt
index bb94a4bd597a..a23ae95e3a93 100644
--- a/Documentation/kdump/vmcoreinfo.txt
+++ b/Documentation/kdump/vmcoreinfo.txt
@@ -376,6 +376,13 @@ VA_BITS
  The maximum number of bits for virtual addresses. Used to compute the
  virtual memory ranges.

+VA_BITS_ACTUAL
+--------------
+
+Indicates the actual VA_BITS detected at boot time, i.e. the maximum
+number of bits for virtual addresses. Required for determing 52-bit kernel
+address support at boot time.
+
  kimage_voffset
  --------------

diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/crash_core.c
index ca4c3e12d8c5..1cde442ce8b2 100644
--- a/arch/arm64/kernel/crash_core.c
+++ b/arch/arm64/kernel/crash_core.c
@@ -10,6 +10,7 @@
  void arch_crash_save_vmcoreinfo(void)
  {
  	VMCOREINFO_NUMBER(VA_BITS);
+	VMCOREINFO_NUMBER(VA_BITS_ACTUAL);
  	/* Please note VMCOREINFO_NUMBER() uses "%d", not "%x" */
  	vmcoreinfo_append_str("NUMBER(kimage_voffset)=0x%llx\n",
  						kimage_voffset);
-- 
2.7.4


Please let me know your views.

Thanks,
Bhupesh

> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 68c391b26858..4877b82d2091 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -789,7 +789,19 @@ ENTRY(__enable_mmu)
>   	phys_to_ttbr x1, x1
>   	phys_to_ttbr x2, x2
>   	msr	ttbr0_el1, x2			// load TTBR0
> -	offset_ttbr1 x1
> +
> +#if defined(CONFIG_ARM64_USER_VA_BITS_52)
> +	orr     x1, x1, #TTBR1_BADDR_4852_OFFSET
> +#endif
> +
> +#if defined(CONFIG_ARM64_USER_KERNEL_VA_BITS_52)
> +	ldr_l	x3, vabits_actual
> +	cmp	x3, #52
> +	b.eq	1f
> +	orr     x1, x1, #TTBR1_BADDR_4852_OFFSET
> +1:
> +#endif
> +
>   	msr	ttbr1_el1, x1			// load TTBR1
>   	isb
>   	msr	sctlr_el1, x0
> diff --git a/arch/arm64/kernel/hibernate-asm.S b/arch/arm64/kernel/hibernate-asm.S
> index fe36d85c60bd..d32725a2b77f 100644
> --- a/arch/arm64/kernel/hibernate-asm.S
> +++ b/arch/arm64/kernel/hibernate-asm.S
> @@ -19,6 +19,7 @@
>   #include <linux/linkage.h>
>   #include <linux/errno.h>
>   
> +#include <asm/alternative.h>
>   #include <asm/asm-offsets.h>
>   #include <asm/assembler.h>
>   #include <asm/cputype.h>
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
