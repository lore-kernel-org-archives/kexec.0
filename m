Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1411604655.6001.176.camel@smoke>
Subject: Re: [PATCH 07/13] arm64: Add new routine local_disable
From: Geoff Levand <geoff@infradead.org>
Date: Wed, 24 Sep 2014 17:24:15 -0700
In-Reply-To: <20140915185625.GB14191@leverpostej>
References: <cover.1410302383.git.geoff@infradead.org>
 <8db284c1443918ca692a5c2e30a0c7f13b37428f.1410302383.git.geoff@infradead.org>
 <20140915185625.GB14191@leverpostej>
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

On Mon, 2014-09-15 at 19:56 +0100, Mark Rutland wrote:
> Hi Geoff,
> 
> On Tue, Sep 09, 2014 at 11:49:04PM +0100, Geoff Levand wrote:
> > Add the new arm64 routine local_disable() to allow the masking of several DAIF
> > flags in one operation.  Currently, we only have routines to mask individual
> > flags, and to mask several flags multiple calls to daifset are required.
> >
> > Signed-off-by: Geoff Levand <geoff@infradead.org>
> > ---
> >  arch/arm64/include/asm/irqflags.h | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
> > index 11cc941..28521d4 100644
> > --- a/arch/arm64/include/asm/irqflags.h
> > +++ b/arch/arm64/include/asm/irqflags.h
> > @@ -113,5 +113,18 @@ static inline int arch_irqs_disabled_flags(unsigned long flags)
> >  #define local_dbg_enable()	asm("msr	daifclr, #8" : : : "memory")
> >  #define local_dbg_disable()	asm("msr	daifset, #8" : : : "memory")
> >  
> > +enum daif_flag {
> 
> Is there any reason for this to be an enum rather than a set of
> #defines?
> 
> It would be nice to be able to use these in asm.
> 
> > +	DAIF_FIQ   = (1UL << 6),
> > +	DAIF_IRQ   = (1UL << 7),
> > +	DAIF_ASYNC = (1UL << 8),
> > +	DAIF_DBG   = (1UL << 9),
> > +	DAIF_ALL   = (0xffUL << 6),
> 
> Not 0xf?
> 
> It would be nicer to OR the other flags.
> 
> > +};
> > +
> > +static inline void local_disable(unsigned long daif_flags)
> > +{
> > +	arch_local_irq_restore(daif_flags | arch_local_save_flags());
> 
> If we knew the value was a constant (which we could check with
> __builting_constant_p) we could use daifset here, rather than having a
> RMW sequence.
> 
> With that, the other local_*_{enable,disable} calls could be rewritten
> in terms of this, without affecting the generated code. That would
> require some shifting to account for the difference between pstate and
> daif{clr,set} layout, but for constants that shouldn't be a problem.

Since kexec just needs to mask all the DAIF exceptions before the main
CPU is reset I'll just do that inline, and put this rework of the
exception mask routines on my todo list.

-Geoff




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
