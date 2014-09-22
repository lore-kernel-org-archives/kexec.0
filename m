Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1411422366.6001.29.camel@smoke>
Subject: Re: [PATCH 03/13] arm64: Convert hcalls to use ISS field
From: Geoff Levand <geoff@infradead.org>
Date: Mon, 22 Sep 2014 14:46:06 -0700
In-Reply-To: <20140915175708.GD13789@leverpostej>
References: <cover.1410302383.git.geoff@infradead.org>
 <2d8dd1ea41dc51878dd4ce75de00eaec2518a76b.1410302383.git.geoff@infradead.org>
 <20140915175708.GD13789@leverpostej>
Mime-Version: 1.0
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
To: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <Marc.Zyngier@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>


Hi Mark,

On Mon, 2014-09-15 at 18:57 +0100, Mark Rutland wrote:
> On Tue, Sep 09, 2014 at 11:49:04PM +0100, Geoff Levand wrote:
> > +/*
> > + * HVC_GET_VECTORS - Return the value of the vbar_el2 register.
> > + */
> > +
> > +#define HVC_GET_VECTORS 1
> > +
> > +/*
> > + * HVC_SET_VECTORS - Set the value of the vbar_el2 register.
> > + *
> > + * @x0: Physical address of the new vector table.
> > + */
> > +
> > +#define HVC_SET_VECTORS 2
> > +
> > +/*
> > + * HVC_KVM_CALL_HYP - Execute kvm_call_hyp routine.
> > + */
> > +
> > +#define HVC_KVM_CALL_HYP 3
> 
> If this can be used without KVM (e.g. in the hyp stub) I'd just call
> this HVC_CALL_HYP, or the name will be a little misleading.

Yes, it is more or less generic, so we could have it as HVC_CALL_HYP.

> >  #ifndef __ASSEMBLY__
> >  
> >  /*
> > diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
> > index 2d960a9..9ab5f70 100644
> > --- a/arch/arm64/kernel/hyp-stub.S
> > +++ b/arch/arm64/kernel/hyp-stub.S
> > @@ -54,16 +54,29 @@ ENDPROC(__hyp_stub_vectors)
> >  
> >  #define ESR_EL2_EC_SHIFT	26
> >  #define ESR_EL2_EC_HVC64	0x16
> > +#define ESR_EL2_ISS		0xffff
> 
> The last patch tried to add an identical macro to a header file. Can we
> use that header please?

As I mentioned in my reply to your comment on that patch, I'll prepare a
separate header/macro cleanup patch.

> >  
> >  el1_sync:
> > -	mrs	x1, esr_el2
> > -	lsr	x1, x1, #ESR_EL2_EC_SHIFT
> > -	cmp	x1, #ESR_EL2_EC_HVC64
> > -	b.ne	2f				// Not an HVC trap
> > -	cbz	x0, 1f
> > -	msr	vbar_el2, x0			// Set vbar_el2
> > +	mrs	x10, esr_el2
> 
> Any reason for using x10?
> 
> If we want to preserve the lowest register numbers, start with the
> highest caller-saved register numbers (i.e. x18). At least for me it
> makes the code far easier to read; it doesn't make it look like x10 is
> special.

OK, sure.

> > +	lsr	x9, x10, #ESR_EL2_EC_SHIFT	// x9=EC
> > +	and	x10, x10, #ESR_EL2_ISS		// x10=ISS
> 
> The mnemonics make these comments redundant.
> 
> > +	cmp     x9, #ESR_EL2_EC_HVC64
> > +	b.ne    2f                              // Not a host HVC trap
> 
> Now that we have the nice mnemonic, we could get rid of the comment
> here. I'd drop the 'host' from the comment; it wasn't there orginally
> and it's somewhat meaningless for the stub (KVM isn't up yet, and the
> only the native OS can make a HVC).

Sure, I copied this from the KVM vector so they would be more similar.

> 
> > +	mrs     x9, vttbr_el2
> > +	cbnz    x9, 2f                          // Not a host HVC trap
> 
> I don't understand this. When is vttbr_el2 non-zero, and why do we want
> to silently return from a HVC in that case? That didn't seem to be the
> case in the original code.

No it is not in the original.  I copied this from the KVM vector so they
would be more similar.

> > +
> > +	cmp	x10, #HVC_GET_VECTORS
> > +	b.ne	1f
> > +	mrs	x0, vbar_el2
> >  	b	2f
> > -1:	mrs	x0, vbar_el2			// Return vbar_el2
> > +
> > +1:	cmp	x10, #HVC_SET_VECTORS
> > +	b.ne	1f
> > +	msr	vbar_el2, x0
> > +
> > +1:
> 
> It feels like we should explode if we ever reach here from the host --
> if we've made an unsupported HVC wereally want to know that we've done
> so.

Sure, I can put something in, but I would think that whoever tries a bad
hcall is going to find out it doesn't work regardless.

Do you have a good idea of how we can do this 'explode'?

-Geoff





_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
