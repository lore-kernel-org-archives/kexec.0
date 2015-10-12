Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <561BB576.3060104@arm.com>
Date: Mon, 12 Oct 2015 14:28:22 +0100
From: James Morse <james.morse@arm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v5 1/2] arm64: kvm: allows kvm cpu hotplug
References: <1432877920-12527-1-git-send-email-takahiro.akashi@linaro.org>
 <1432877920-12527-2-git-send-email-takahiro.akashi@linaro.org>
In-Reply-To: <1432877920-12527-2-git-send-email-takahiro.akashi@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Mark Rutland <Mark.Rutland@arm.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "geoff@infradead.org" <geoff@infradead.org>, "broonie@kernel.org" <broonie@kernel.org>, "david.griego@linaro.org" <david.griego@linaro.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "freddy77@gmail.com" <freddy77@gmail.com>

On 29/05/15 06:38, AKASHI Takahiro wrote:
> The current kvm implementation on arm64 does cpu-specific initialization
> at system boot, and has no way to gracefully shutdown a core in terms of
> kvm. This prevents, especially, kexec from rebooting the system on a boot
> core in EL2.
> 
> This patch adds a cpu tear-down function and also puts an existing cpu-init
> code into a separate function, kvm_arch_hardware_disable() and
> kvm_arch_hardware_enable() respectively.
> We don't need arm64-specific cpu hotplug hook any more.

I think we do... on platforms where cpuidle uses psci to temporarily turn
off cores that aren't in use, we lose the el2 state. This hotplug hook
restores the state, even if there a no vms running.

This patch prevents me from running vms on such a platform, qemu gives:
> kvm [1500]: Unsupported exception type: 6264688KVM internal error.
Suberror: 0

kvmtool goes with a more dramatic:
> KVM exit reason: 17 ("KVM_EXIT_INTERNAL_ERROR")

Disabling CONFIG_ARM_CPUIDLE solves this problem.


(Sorry to revive an old thread - I've been using v4 of this patch for the
hibernate/suspend-to-disk series).


> Since this patch modifies common part of code between arm and arm64, one
> stub definition, __cpu_reset_hyp_mode(), is added on arm side to avoid
> compiling errors.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>

> diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
> index fd085ec..afe6263 100644
> --- a/arch/arm64/kvm/hyp.S
> +++ b/arch/arm64/kvm/hyp.S
> @@ -1136,6 +1136,11 @@ ENTRY(kvm_call_hyp)
>  	ret
>  ENDPROC(kvm_call_hyp)
>  
> +ENTRY(kvm_call_reset)
> +	hvc	#HVC_RESET
> +	ret
> +ENDPROC(kvm_call_reset)
> +
>  .macro invalid_vector	label, target
>  	.align	2
>  \label:
> @@ -1179,10 +1184,27 @@ el1_sync:					// Guest trapped into EL2
>  	cmp	x18, #HVC_GET_VECTORS
>  	b.ne	1f
>  	mrs	x0, vbar_el2
> -	b	2f
> -
> -1:	/* Default to HVC_CALL_HYP. */
> +	b	do_eret
>  
> +	/* jump into trampoline code */
> +1:	cmp	x18, #HVC_RESET
> +	b.ne	2f
> +	/*
> +	 * Entry point is:
> +	 *	TRAMPOLINE_VA
> +	 *	+ (__kvm_hyp_reset - (__hyp_idmap_text_start & PAGE_MASK))
> +	 */
> +	adrp	x2, __kvm_hyp_reset
> +	add	x2, x2, #:lo12:__kvm_hyp_reset
> +	adrp	x3, __hyp_idmap_text_start
> +	add	x3, x3, #:lo12:__hyp_idmap_text_start
> +	and	x3, x3, PAGE_MASK
> +	sub	x2, x2, x3
> +	ldr	x3, =TRAMPOLINE_VA
> +	add	x2, x2, x3
> +	br	x2				// no return
> +
> +2:	/* Default to HVC_CALL_HYP. */

What was the reason not to use kvm_call_hyp(__kvm_hyp_reset, ...)?
(You mentioned you wanted to at [0] - I can't find the details in the archive)


Thanks,

James


[0] http://lists.infradead.org/pipermail/kexec/2015-April/335533.html


>  	push	lr, xzr
>  
>  	/*
> @@ -1196,7 +1218,9 @@ el1_sync:					// Guest trapped into EL2
>  	blr	lr
>  
>  	pop	lr, xzr
> -2:	eret
> +
> +do_eret:
> +	eret
>  
>  el1_trap:
>  	/*
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
