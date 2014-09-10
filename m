Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-la0-f45.google.com ([209.85.215.45])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XRdS5-0000xD-Mu
 for kexec@lists.infradead.org; Wed, 10 Sep 2014 08:40:34 +0000
Received: by mail-la0-f45.google.com with SMTP id pn19so21198758lab.18
 for <kexec@lists.infradead.org>; Wed, 10 Sep 2014 01:40:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <bc4abc340eaa4da448f62326a134fabfb5a2a875.1410302383.git.geoff@infradead.org>
References: <cover.1410302383.git.geoff@infradead.org>
 <bc4abc340eaa4da448f62326a134fabfb5a2a875.1410302383.git.geoff@infradead.org>
Date: Wed, 10 Sep 2014 10:40:08 +0200
Message-ID: <CAKv+Gu_hs-Sv=Bg6uyKc41OV9sKS0sfM1YAcCMaTF7aTH9YPwA@mail.gmail.com>
Subject: Re: [PATCH 02/13] arm64/kvm: Fix assembler compatibility of macros
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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
Cc: Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, kexec@lists.infradead.org, Christoffer Dall <christoffer.dall@linaro.org>

On 10 September 2014 00:49, Geoff Levand <geoff@infradead.org> wrote:
> Some of the macros defined in kvm_arm.h are useful in the exception vector
> routines, but they are not compatible with the assembler.  Change the
> definition of ESR_EL2_ISS to be compatible.
>
> Fixes build errors like these when using kvm_arm.h in assembly
> source files:
>
>   Error: unexpected characters following instruction at operand 3 -- `add x0,x1,#((1U<<25)-1)'
>
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
>  arch/arm64/include/asm/kvm_arm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> index cc83520..e0e7e64 100644
> --- a/arch/arm64/include/asm/kvm_arm.h
> +++ b/arch/arm64/include/asm/kvm_arm.h
> @@ -176,7 +176,7 @@
>  #define ESR_EL2_EC_SHIFT       (26)
>  #define ESR_EL2_EC             (0x3fU << ESR_EL2_EC_SHIFT)
>  #define ESR_EL2_IL             (1U << 25)
> -#define ESR_EL2_ISS            (ESR_EL2_IL - 1)
> +#define ESR_EL2_ISS            (0xffff)

Don't you mean 0x1ffffff?
And, there is a macro UL() for this purpose, so I suppose you could
redefine ESR_EL2_IL as (UL(1) << 25) as well. I know it is not
strictly the same thing, but it should be good enough as this is arm64
only

>  #define ESR_EL2_ISV_SHIFT      (24)
>  #define ESR_EL2_ISV            (1U << ESR_EL2_ISV_SHIFT)
>  #define ESR_EL2_SAS_SHIFT      (22)
> --
> 1.9.1
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
