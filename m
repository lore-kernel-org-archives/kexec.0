Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1422654431.21823.33.camel@infradead.org>
Subject: Re: [PATCH 4/8] arm64: Add EL2 switch to soft_restart
From: Geoff Levand <geoff@infradead.org>
Date: Fri, 30 Jan 2015 13:47:11 -0800
In-Reply-To: <20150127175740.GK3226@e104818-lin.cambridge.arm.com>
References: <cover.1421449714.git.geoff@infradead.org>
 <bb44d4eee4fab15278e4a8829a0981878bc9acd7.1421449714.git.geoff@infradead.org>
 <20150127175740.GK3226@e104818-lin.cambridge.arm.com>
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
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <Marc.Zyngier@arm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Will Deacon <Will.Deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>

Hi Catalin,

On Tue, 2015-01-27 at 17:57 +0000, Catalin Marinas wrote:
> On Sat, Jan 17, 2015 at 12:23:34AM +0000, Geoff Levand wrote:
> >  ENTRY(cpu_reset)
> > -	mrs	x1, sctlr_el1
> > -	bic	x1, x1, #1
> > -	msr	sctlr_el1, x1			// disable the MMU
> > +	mrs	x2, sctlr_el1
> > +	bic	x2, x2, #1
> > +	msr	sctlr_el1, x2			// disable the MMU
> >  	isb
> > -	ret	x0
> > +
> > +	cbz	x0, 1f				// el2_switch?
> > +	mov	x0, x1
> > +	mov	x1, xzr
> > +	mov	x2, xzr
> > +	mov	x3, xzr
> > +	hvc	#HVC_CALL_FUNC			// no return
> 
> If that's the only user of HVC_CALL_FUNC, why do we bother with
> arguments, calling convention?

It was intended that HVC_CALL_FUNC be a mechanism to call a generic
function in hyp mode.  cpu_reset() is the only user of it now.

As Mark explained in another post, the use of x18 by the hyp stub
is to avoid the complication of setting up a stack for EL2.  We
thought this solution was acceptable since there are relatively
few HVC_CALL_FUNC calls and we could assure they would do the
right thing.

-Geoff 





_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
