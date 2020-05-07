Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v9 11/18] arm64: kexec: arm64_relocate_new_kernel clean-ups
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-12-pasha.tatashin@soleen.com>
From: James Morse <james.morse@arm.com>
Message-ID: <dc47bee6-69ee-2ece-12d4-258bd964b954@arm.com>
Date: Thu, 7 May 2020 17:22:13 +0100
MIME-Version: 1.0
In-Reply-To: <20200326032420.27220-12-pasha.tatashin@soleen.com>
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
> Remove excessive empty lines from arm64_relocate_new_kernel.

To make it harder to read? Or just for the churn ...

> Also, use comments on the same lines with instructions where
> appropriate.

Churn,


> Change ENDPROC to END it never returns.

It might be more useful to convert this to the new style annotations, which should be a
separate patch. See Documentation/asm-annotations.rst


> copy_page(dest, src, tmps...)
> Increments dest and src by PAGE_SIZE, so no need to store dest
> prior to calling copy_page and increment it after. Also, src is not
> used after a copy, not need to copy either.

This bit sounds like cleanup, but I can't isolate it from the noise below....


> Call raw_dcache_line_size()  only when relocation is actually going to
> happen.

Why?

The pattern in this code is to setup register that don't change at the top, then do all
the work. I think this was an attempt to make it more readable.

Nothing branches back to that label, so this is fine, its just less obviously correct.


> Since '.align 3' is intended to align globals at the end of the file,
> move it there.


Please don't make noisy changes to whitespace and comments, its never worth it.


Thanks,

James


> diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
> index c1d7db71a726..e9c974ea4717 100644
> --- a/arch/arm64/kernel/relocate_kernel.S
> +++ b/arch/arm64/kernel/relocate_kernel.S
> @@ -8,7 +8,6 @@
>  
>  #include <linux/kexec.h>
>  #include <linux/linkage.h>
> -
>  #include <asm/assembler.h>
>  #include <asm/kexec.h>
>  #include <asm/page.h>
> @@ -17,25 +16,21 @@
>  /*
>   * arm64_relocate_new_kernel - Put a 2nd stage image in place and boot it.
>   *
> - * The memory that the old kernel occupies may be overwritten when coping the
> + * The memory that the old kernel occupies may be overwritten when copying the
>   * new image to its final location.  To assure that the
>   * arm64_relocate_new_kernel routine which does that copy is not overwritten,
>   * all code and data needed by arm64_relocate_new_kernel must be between the
>   * symbols arm64_relocate_new_kernel and arm64_relocate_new_kernel_end.  The
>   * machine_kexec() routine will copy arm64_relocate_new_kernel to the kexec
> - * control_code_page, a special page which has been set up to be preserved
> - * during the copy operation.
> + * safe memory that has been set up to be preserved during the copy operation.
>   */
>  ENTRY(arm64_relocate_new_kernel)
> -
>  	/* Setup the list loop variables. */
>  	mov	x18, x2				/* x18 = dtb address */
>  	mov	x17, x1				/* x17 = kimage_start */
>  	mov	x16, x0				/* x16 = kimage_head */
> -	raw_dcache_line_size x15, x0		/* x15 = dcache line size */
>  	mov	x14, xzr			/* x14 = entry ptr */
>  	mov	x13, xzr			/* x13 = copy dest */
> -
>  	/* Clear the sctlr_el2 flags. */
>  	mrs	x0, CurrentEL
>  	cmp	x0, #CurrentEL_EL2
> @@ -46,14 +41,11 @@ ENTRY(arm64_relocate_new_kernel)
>  	pre_disable_mmu_workaround
>  	msr	sctlr_el2, x0
>  	isb
> -1:
> -
> -	/* Check if the new image needs relocation. */
> +1:	/* Check if the new image needs relocation. */
>  	tbnz	x16, IND_DONE_BIT, .Ldone
> -
> +	raw_dcache_line_size x15, x1		/* x15 = dcache line size */
>  .Lloop:
>  	and	x12, x16, PAGE_MASK		/* x12 = addr */
> -
>  	/* Test the entry flags. */
>  .Ltest_source:
>  	tbz	x16, IND_SOURCE_BIT, .Ltest_indirection
> @@ -69,34 +61,18 @@ ENTRY(arm64_relocate_new_kernel)
>  	b.lo    2b
>  	dsb     sy
>  
> -	mov x20, x13
> -	mov x21, x12
> -	copy_page x20, x21, x0, x1, x2, x3, x4, x5, x6, x7
> -
> -	/* dest += PAGE_SIZE */
> -	add	x13, x13, PAGE_SIZE
> +	copy_page x13, x12, x0, x1, x2, x3, x4, x5, x6, x7
>  	b	.Lnext
> -
>  .Ltest_indirection:
>  	tbz	x16, IND_INDIRECTION_BIT, .Ltest_destination
> -
> -	/* ptr = addr */
> -	mov	x14, x12
> +	mov	x14, x12			/* ptr = addr */
>  	b	.Lnext
> -
>  .Ltest_destination:
>  	tbz	x16, IND_DESTINATION_BIT, .Lnext
> -
> -	/* dest = addr */
> -	mov	x13, x12
> -
> +	mov	x13, x12			/* dest = addr */
>  .Lnext:
> -	/* entry = *ptr++ */
> -	ldr	x16, [x14], #8
> -
> -	/* while (!(entry & DONE)) */
> -	tbz	x16, IND_DONE_BIT, .Lloop
> -
> +	ldr	x16, [x14], #8			/* entry = *ptr++ */
> +	tbz	x16, IND_DONE_BIT, .Lloop	/* while (!(entry & DONE)) */
>  .Ldone:
>  	/* wait for writes from copy_page to finish */
>  	dsb	nsh
> @@ -110,16 +86,12 @@ ENTRY(arm64_relocate_new_kernel)
>  	mov	x2, xzr
>  	mov	x3, xzr
>  	br	x17
> -
> -ENDPROC(arm64_relocate_new_kernel)
> -
>  .ltorg
> -
> -.align 3	/* To keep the 64-bit values below naturally aligned. */
> +END(arm64_relocate_new_kernel)
>  
>  .Lcopy_end:
>  .org	KEXEC_CONTROL_PAGE_SIZE
> -
> +.align 3	/* To keep the 64-bit values below naturally aligned. */
>  /*
>   * arm64_relocate_new_kernel_size - Number of bytes to copy to the
>   * control_code_page.
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
