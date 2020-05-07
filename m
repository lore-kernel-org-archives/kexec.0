Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v9 14/18] arm64: kexec: offset for relocation function
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-15-pasha.tatashin@soleen.com>
From: James Morse <james.morse@arm.com>
Message-ID: <2c23b35d-d4b7-904c-9516-5f317dd963c7@arm.com>
Date: Thu, 7 May 2020 17:22:30 +0100
MIME-Version: 1.0
In-Reply-To: <20200326032420.27220-15-pasha.tatashin@soleen.com>
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
To: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: sashal@kernel.org, mark.rutland@arm.com, vladimir.murzin@arm.com, corbet@lwn.net, catalin.marinas@arm.com, bhsharma@redhat.com, steve.capper@arm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jmorris@namei.org, linux-mm@kvack.org, rfontana@redhat.com, ebiederm@xmission.com, maz@kernel.org, matthias.bgg@gmail.com, tglx@linutronix.de, will@kernel.org, selindag@gmail.com, linux-arm-kernel@lists.infradead.org

Hi Pavel,

On 26/03/2020 03:24, Pavel Tatashin wrote:
> Soon, relocation function will share the same page with EL2 vectors.

The EL2 vectors would only be executed with the MMU off, so they don't need to be mapped
anywhere in particular. (this is something hibernate probably does sloppily).


> Add offset within this page to arm64_relocate_new_kernel, and also
> the total size of relocation code which will include both the function
> and the EL2 vectors.

See arch/arm64/kernel/vmlinux.lds.S and sections.h for an example of how the idmap,
hibernate and the non-KVM hyp code do this.

If we're going to change this, I'd prefer it be the same as the other users...


> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> index 990185744148..d944c2e289b2 100644
> --- a/arch/arm64/include/asm/kexec.h
> +++ b/arch/arm64/include/asm/kexec.h
> @@ -90,6 +90,13 @@ static inline void crash_prepare_suspend(void) {}
>  static inline void crash_post_resume(void) {}
>  #endif
>  
> +#if defined(CONFIG_KEXEC_CORE)
> +/* The beginning and size of relcation code to stage 2 kernel */
> +extern const unsigned long kexec_relocate_code_size;
> +extern const unsigned char kexec_relocate_code_start[];
> +extern const unsigned long kexec_kern_reloc_offset;
> +#endif

This makes these things visible globally ... but drops the arm64_ prefix!


> diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
> index 22ccdcb106d3..aa9f2b2cd77c 100644
> --- a/arch/arm64/kernel/relocate_kernel.S
> +++ b/arch/arm64/kernel/relocate_kernel.S
> @@ -14,6 +14,9 @@
>  #include <asm/page.h>
>  #include <asm/sysreg.h>
>  
> +.globl kexec_relocate_code_start
> +kexec_relocate_code_start:

Which of the fancy new asm-annotations should this be?



> @@ -86,13 +89,16 @@ ENTRY(arm64_relocate_new_kernel)
>  .ltorg
>  END(arm64_relocate_new_kernel)
>  
> -.Lcopy_end:
> +.Lkexec_relocate_code_end:
>  .org	KEXEC_CONTROL_PAGE_SIZE
>  .align 3	/* To keep the 64-bit values below naturally aligned. */

>  /*
> - * arm64_relocate_new_kernel_size - Number of bytes to copy to the
> + * kexec_relocate_code_size - Number of bytes to copy to the
>   * control_code_page.
>   */
> -.globl arm64_relocate_new_kernel_size
> -arm64_relocate_new_kernel_size:
> -	.quad	.Lcopy_end - arm64_relocate_new_kernel
> +.globl kexec_relocate_code_size
> +kexec_relocate_code_size:
> +	.quad	.Lkexec_relocate_code_end - kexec_relocate_code_start
> +.globl kexec_kern_reloc_offset
> +kexec_kern_reloc_offset:
> +	.quad	arm64_relocate_new_kernel - kexec_relocate_code_start
> 

Can't we calculate this from the start/end markers? These variables held in assembly
generated code is pretty manky.


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
