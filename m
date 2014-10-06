Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 6 Oct 2014 11:13:28 +0100
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/7] arm64: Convert hcalls to use ISS field
Message-ID: <20141006101328.GD24686@leverpostej>
References: <cover.1411604443.git.geoff@infradead.org>
 <579bf2ec37edcfa6208f9220588a98327d832fd4.1411604443.git.geoff@infradead.org>
 <20141003105106.GB26643@leverpostej>
 <1412373387.32313.41.camel@smoke>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1412373387.32313.41.camel@smoke>
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
Cc: Marc Zyngier <Marc.Zyngier@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>

[...]

> > >  el1_sync:
> > > -	mrs	x1, esr_el2
> > > -	lsr	x1, x1, #26
> > > -	cmp	x1, #0x16
> > > -	b.ne	2f				// Not an HVC trap
> > > -	cbz	x0, 1f
> > > -	msr	vbar_el2, x0			// Set vbar_el2
> > > +	mrs	x18, esr_el2
> > > +	lsr	x17, x18, #26			// x17=EC
> > 
> > The first patch enabled kvm_arm.h macros to be used from asm. Can't we
> > use them here? If we don't include kvm_arm.h in the hyp stub, maybe we
> > should (ideally we'd factor common stuff out, but I can see that getting
> > messy fast).
> 
> I didn't want to tackle the cleanup of the headers in this patch
> series, and I thought it odd to include a kvm header in this core
> arm64 file, but maybe it is better to include kvm_arm.h and use the
> ESR_EL2_ macros so the values are at least easier to understand and
> keep track of.

I'd rather we used the mnemonics. If that involves pulling in the kvm
header I'd rather we do that for the moment.

[...]

> > > diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
> > > index b72aa9f..9607f15 100644
> > > --- a/arch/arm64/kvm/hyp.S
> > > +++ b/arch/arm64/kvm/hyp.S
> > > @@ -26,6 +26,7 @@
> > >  #include <asm/kvm_asm.h>
> > >  #include <asm/kvm_arm.h>
> > >  #include <asm/kvm_mmu.h>
> > > +#include <asm/virt.h>
> > 
> > As far as I can see, virt.h only defines BOOT_CPU_MODE_EL{1,2}, which we
> > don't use below. So I don't think we need this include.
> 
> We need asm/virt.h for the new HVC_ macros added to it by this
> patch (above)...

Sorry, my comment was bogus. I'd evidently confused myself when reading
this.

Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
