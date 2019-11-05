Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 5 Nov 2019 09:27:01 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64: mm: Remove MAX_USER_VA_BITS definition
Message-ID: <20191105092701.GD4743@lakrids.cambridge.arm.com>
References: <1572904606-27961-1-git-send-email-bhsharma@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1572904606-27961-1-git-send-email-bhsharma@redhat.com>
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
Cc: Steve Capper <steve.capper@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>, bhupesh.linux@gmail.com, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org

On Tue, Nov 05, 2019 at 03:26:46AM +0530, Bhupesh Sharma wrote:
> commit 9b31cf493ffa ("arm64: mm: Introduce MAX_USER_VA_BITS definition")
> introduced the MAX_USER_VA_BITS definition, which was used to support
> the arm64 mm use-cases where the user-space could use 52-bit virtual
> addresses whereas the kernel-space would still could a maximum of 48-bit
> virtual addressing.
> 
> But, now with commit b6d00d47e81a ("arm64: mm: Introduce 52-bit Kernel
> VAs"), we removed the 52-bit user/48-bit kernel kconfig option and hence
> there is no longer any scenario where user VA != kernel VA size
> (even with CONFIG_ARM64_FORCE_52BIT enabled, the same is true).
> 
> Hence we can do away with the MAX_USER_VA_BITS macro as it is equal to
> VA_BITS (maximum VA space size) in all possible use-cases. Note that
> even though the 'vabits_actual' value would be 48 for arm64 hardware
> which don't support LVA-8.2 extension (even when CONFIG_ARM64_VA_BITS_52
> is enabled), VA_BITS would still be set to a value 52. Hence this change
> would be safe in all possible VA address space combinations.
> 
> Cc: James Morse <james.morse@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Steve Capper <steve.capper@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: kexec@lists.infradead.org
> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>

As the commit message says, there should be no functional change as a
result of this patch, and it looks like a nice cleanup to me:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/memory.h        | 6 ------
>  arch/arm64/include/asm/pgtable-hwdef.h | 2 +-
>  arch/arm64/include/asm/processor.h     | 2 +-
>  3 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index c23c47360664..a4f9ca5479b0 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -69,12 +69,6 @@
>  #define KERNEL_START		_text
>  #define KERNEL_END		_end
>  
> -#ifdef CONFIG_ARM64_VA_BITS_52
> -#define MAX_USER_VA_BITS	52
> -#else
> -#define MAX_USER_VA_BITS	VA_BITS
> -#endif
> -
>  /*
>   * Generic and tag-based KASAN require 1/8th and 1/16th of the kernel virtual
>   * address space for the shadow region respectively. They can bloat the stack
> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> index 3df60f97da1f..d9fbd433cc17 100644
> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> @@ -69,7 +69,7 @@
>  #define PGDIR_SHIFT		ARM64_HW_PGTABLE_LEVEL_SHIFT(4 - CONFIG_PGTABLE_LEVELS)
>  #define PGDIR_SIZE		(_AC(1, UL) << PGDIR_SHIFT)
>  #define PGDIR_MASK		(~(PGDIR_SIZE-1))
> -#define PTRS_PER_PGD		(1 << (MAX_USER_VA_BITS - PGDIR_SHIFT))
> +#define PTRS_PER_PGD		(1 << (VA_BITS - PGDIR_SHIFT))
>  
>  /*
>   * Section address mask and size definitions.
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index 5623685c7d13..586fcd4b1965 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -9,7 +9,7 @@
>  #define __ASM_PROCESSOR_H
>  
>  #define KERNEL_DS		UL(-1)
> -#define USER_DS			((UL(1) << MAX_USER_VA_BITS) - 1)
> +#define USER_DS			((UL(1) << VA_BITS) - 1)
>  
>  /*
>   * On arm64 systems, unaligned accesses by the CPU are cheap, and so there is
> -- 
> 2.7.4
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
