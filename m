Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-la0-f42.google.com ([209.85.215.42])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YOY9t-00052S-Aj
 for kexec@lists.infradead.org; Thu, 19 Feb 2015 20:57:18 +0000
Received: by labgq15 with SMTP id gq15so2227604lab.3
 for <kexec@lists.infradead.org>; Thu, 19 Feb 2015 12:56:54 -0800 (PST)
Date: Thu, 19 Feb 2015 21:57:14 +0100
From: Christoffer Dall <christoffer.dall@linaro.org>
Subject: Re: [PATCH v2 2/8] arm64: Convert hcalls to use ISS field
Message-ID: <20150219205714.GC24460@cbox>
References: <cover.1421449714.git.geoff@infradead.org>
 <6719b2520095926ae0e8ac888663b87f2098f565.1421449714.git.geoff@infradead.org>
 <1422660828.21823.40.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1422660828.21823.40.camel@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Grant Likely <grant.likely@linaro.org>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Fri, Jan 30, 2015 at 03:33:48PM -0800, Geoff Levand wrote:
> To allow for additional hcalls to be defined and to make the arm64 hcall API
> more consistent across exception vector routines, change the hcall implementations
> to use the ISS field of the ESR_EL2 register to specify the hcall type.

how does this make things more consistent?  Do we have other examples of
things using the immediate field which I'm missing?

> 
> The existing arm64 hcall implementations are limited in that they only allow
> for two distinct hcalls; with the x0 register either zero, or not zero.  Also,
> the API of the hyp-stub exception vector routines and the KVM exception vector
> routines differ; hyp-stub uses a non-zero value in x0 to implement
> __hyp_set_vectors, whereas KVM uses it to implement kvm_call_hyp.

this seems orthogonal to the use of the immediate field vs. x0 though,
so why it the immediate field preferred again?

> 
> Define three new preprocessor macros HVC_CALL_HYP, HVC_GET_VECTORS, and
> HVC_SET_VECTORS to be used as hcall type specifiers and convert the
> existing __hyp_get_vectors(), __hyp_set_vectors() and kvm_call_hyp() routines
> to use these new macros when executing an HVC call.  Also change the
> corresponding hyp-stub and KVM el1_sync exception vector routines to use these
> new macros.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
>  arch/arm64/include/asm/virt.h | 27 +++++++++++++++++++++++++++
>  arch/arm64/kernel/hyp-stub.S  | 32 +++++++++++++++++++++-----------
>  arch/arm64/kernel/psci.c      |  3 ++-
>  arch/arm64/kvm/hyp.S          | 16 +++++++++-------
>  4 files changed, 59 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
> index 7a5df52..eb10368 100644
> --- a/arch/arm64/include/asm/virt.h
> +++ b/arch/arm64/include/asm/virt.h
> @@ -18,6 +18,33 @@
>  #ifndef __ASM__VIRT_H
>  #define __ASM__VIRT_H
>  
> +/*
> + * The arm64 hcall implementation uses the ISS field of the ESR_EL2 register to
> + * specify the hcall type.  The exception handlers are allowed to use registers
> + * x17 and x18 in their implementation.  Any routine issuing an hcall must not
> + * expect these registers to be preserved.
> + */

I thought the existing use of registers were based on the arm procedure
call standard so we didn't have to worry about adding more caller-save
registers.

Don't we now have to start adding code around callers to make sure
callers know that x17 and x18 may be clobbered?

Thanks,
-Christoffer

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
