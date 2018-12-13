Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH] arm64: invalidate TLB before turning MMU on
References: <1544654224.18411.11.camel@lca.pw>
 <20181213052259.56352-1-cai@lca.pw>
From: James Morse <james.morse@arm.com>
Message-ID: <1b150a95-2b80-2be3-0b77-599404f882dc@arm.com>
Date: Thu, 13 Dec 2018 10:44:02 +0000
MIME-Version: 1.0
In-Reply-To: <20181213052259.56352-1-cai@lca.pw>
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
To: Qian Cai <cai@lca.pw>
Cc: ard.biesheuvel@linaro.org, marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, takahiro.akashi@linaro.org, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi Qian,

On 13/12/2018 05:22, Qian Cai wrote:
> On this HPE Apollo 70 arm64 server with 256 CPUs, triggering a crash
> dump just hung. It has 4 threads on each core. Each 2-core share a same
> L1 and L2 caches, so that is 8 CPUs shares those. All CPUs share a same
> L3 cache.
> 
> It turned out that this was due to the TLB contained stale entries (or
> uninitialized junk which just happened to look valid) from the first
> kernel before turning the MMU on in the second kernel which caused this
> instruction hung,

This is a great find, thanks for debugging this!

The kernel should already handle this, as we don't trust the bootloader to clean
up either.

In arch/arm64/mm/proc.S::__cpu_setup()
|/*
| *	__cpu_setup
| *
| *	Initialise the processor for turning the MMU on.  Return in x0 the
| *	value of the SCTLR_EL1 register.
| */
| 	.pushsection ".idmap.text", "awx"
| ENTRY(__cpu_setup)
| 	tlbi	vmalle1				// Invalidate local TLB
| 	dsb	nsh

This is called from stext, which then branches to __primary_switch(), which
calls __enable_mmu() where you see this problem. It shouldn't not be possible to
allocate new tlb entries between these points...

Do you have CONFIG_RANDOMIZE_BASE disabled? This causes enable_mmu() to be
called twice, the extra tlb maintenance is in __primary_switch.
(if it works with this turned off, it points to the extra off/tlbi/on sequence).


> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 4471f570a295..5196f3d729de 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -771,6 +771,10 @@ ENTRY(__enable_mmu)
>  	msr	ttbr0_el1, x2			// load TTBR0
>  	msr	ttbr1_el1, x1			// load TTBR1
>  	isb
> +	dsb	nshst
> +	tlbi	vmalle1				// invalidate TLB
> +	dsb	nsh
> +	isb
>  	msr	sctlr_el1, x0
>  	isb

The overall change here is that we do extra maintenance later.

Can move this around to bisect where the TLB entries are either coming from, or
failing-to-be invalidated?
Do your first and kdump kernels have the same VA_BITS/PAGE_SIZE?
As a stab in the dark, (totally untested):
------------------------------%<------------------------------
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 2c75b0b903ae..a5f3b7314bda 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -406,9 +406,6 @@ ENDPROC(idmap_kpti_install_ng_mappings)
  */
        .pushsection ".idmap.text", "awx"
 ENTRY(__cpu_setup)
-       tlbi    vmalle1                         // Invalidate local TLB
-       dsb     nsh
-
        mov     x0, #3 << 20
        msr     cpacr_el1, x0                   // Enable FP/ASIMD
        mov     x0, #1 << 12                    // Reset mdscr_el1 and disable
@@ -465,5 +462,10 @@ ENTRY(__cpu_setup)
 1:
 #endif /* CONFIG_ARM64_HW_AFDBM */
        msr     tcr_el1, x10
+       isb
+
+       tlbi    vmalle1                         // Invalidate local TLB
+       dsb     nsh
+
        ret                                     // return to head.S
 ENDPROC(__cpu_setup)
------------------------------%<------------------------------


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
