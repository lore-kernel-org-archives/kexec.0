Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x236.google.com ([2607:f8b0:400e:c05::236])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cBbGR-0004lW-ME
 for kexec@lists.infradead.org; Tue, 29 Nov 2016 05:47:36 +0000
Received: by mail-pg0-x236.google.com with SMTP id p66so65575114pga.2
 for <kexec@lists.infradead.org>; Mon, 28 Nov 2016 21:47:13 -0800 (PST)
Date: Tue, 29 Nov 2016 14:47:04 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v28 4/9] arm64: kdump: implement machine_crash_shutdown()
Message-ID: <20161129054703.GC23034@linaro.org>
References: <20161124095523.6972-1-takahiro.akashi@linaro.org>
 <20161124095809.7092-3-takahiro.akashi@linaro.org>
 <20161128150433.GC17125@e104818-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20161128150433.GC17125@e104818-lin.cambridge.arm.com>
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
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: mark.rutland@arm.com, geoff@infradead.org, kexec@lists.infradead.org, will.deacon@arm.com, james.morse@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org

On Mon, Nov 28, 2016 at 03:04:33PM +0000, Catalin Marinas wrote:
> On Thu, Nov 24, 2016 at 06:58:05PM +0900, AKASHI Takahiro wrote:
> > diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> > index 04744dc..b5168e8 100644
> > --- a/arch/arm64/include/asm/kexec.h
> > +++ b/arch/arm64/include/asm/kexec.h
> > @@ -40,7 +40,47 @@
> >  static inline void crash_setup_regs(struct pt_regs *newregs,
> >  				    struct pt_regs *oldregs)
> >  {
> > -	/* Empty routine needed to avoid build errors. */
> > +	if (oldregs) {
> > +		memcpy(newregs, oldregs, sizeof(*newregs));
> > +	} else {
> > +		u64 tmp1, tmp2;
> > +
> > +		__asm__ __volatile__ (
> > +			"stp	 x0,   x1, [%2, #16 *  0]\n"
> > +			"stp	 x2,   x3, [%2, #16 *  1]\n"
> > +			"stp	 x4,   x5, [%2, #16 *  2]\n"
> > +			"stp	 x6,   x7, [%2, #16 *  3]\n"
> > +			"stp	 x8,   x9, [%2, #16 *  4]\n"
> > +			"stp	x10,  x11, [%2, #16 *  5]\n"
> > +			"stp	x12,  x13, [%2, #16 *  6]\n"
> > +			"stp	x14,  x15, [%2, #16 *  7]\n"
> > +			"stp	x16,  x17, [%2, #16 *  8]\n"
> > +			"stp	x18,  x19, [%2, #16 *  9]\n"
> > +			"stp	x20,  x21, [%2, #16 * 10]\n"
> > +			"stp	x22,  x23, [%2, #16 * 11]\n"
> > +			"stp	x24,  x25, [%2, #16 * 12]\n"
> > +			"stp	x26,  x27, [%2, #16 * 13]\n"
> > +			"stp	x28,  x29, [%2, #16 * 14]\n"
> > +			"mov	 %0,  sp\n"
> > +			"stp	x30,  %0,  [%2, #16 * 15]\n"
> > +
> > +			"/* faked current PSTATE */\n"
> > +			"mrs	 %0, CurrentEL\n"
> > +			"mrs	 %1, SPSEL\n"
> > +			"orr	 %0, %0, %1\n"
> > +			"mrs	 %1, DAIF\n"
> > +			"orr	 %0, %0, %1\n"
> > +			"mrs	 %1, NZCV\n"
> > +			"orr	 %0, %0, %1\n"
> > +			/* pc */
> > +			"adr	 %1, 1f\n"
> > +		"1:\n"
> > +			"stp	 %1, %0,   [%2, #16 * 16]\n"
> > +			: "+r" (tmp1), "+r" (tmp2)
> > +			: "r" (newregs)
> > +			: "memory"
> 
> tmp1 and tmp2 are not input arguments here, so you should use the "=&"
> modifier. With my compiler, I get warnings of these variables being used
> uninitialised.

Thank you for this heads-up.
(I misunderstood "+" a bit.)
With this change applied, I confirmed that kdump still works.

-Takahiro AKASHI

> -- 
> Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
