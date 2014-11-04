Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1415065777.12884.8.camel@smoke>
Subject: Re: [PATCH 09/10] arm64/kexec: Enable kexec in the arm64 defconfig
From: Geoff Levand <geoff@infradead.org>
Date: Mon, 03 Nov 2014 17:49:37 -0800
In-Reply-To: <20141103200516.GC30366@leverpostej>
References: <cover.1414099246.git.geoff@infradead.org>
 <9570f274b9649430b34e5c7e15b63679b94c2c50.1414099246.git.geoff@infradead.org>
 <20141024103150.GC24265@leverpostej> <1414799415.23621.52.camel@smoke>
 <20141103200516.GC30366@leverpostej>
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
Cc: Marc Zyngier <Marc.Zyngier@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Mark,

On Mon, 2014-11-03 at 20:05 +0000, Mark Rutland wrote:
> On Fri, Oct 31, 2014 at 11:50:15PM +0000, Geoff Levand wrote:
> > On Fri, 2014-10-24 at 11:31 +0100, Mark Rutland wrote:
> > > On Fri, Oct 24, 2014 at 12:10:59AM +0100, Geoff Levand wrote:
> > > > Signed-off-by: Geoff Levand <geoff@infradead.org>
> > > > ---
> > > >  arch/arm64/configs/defconfig | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > > > index d92ef3c..ebf8b3f 100644
> > > > --- a/arch/arm64/configs/defconfig
> > > > +++ b/arch/arm64/configs/defconfig
> > > > @@ -39,6 +39,7 @@ CONFIG_PREEMPT=y
> > > >  CONFIG_KSM=y
> > > >  CONFIG_TRANSPARENT_HUGEPAGE=y
> > > >  CONFIG_CMA=y
> > > > +CONFIG_KEXEC=y
> > > 
> > > Given this is going to be incompatible with KVM, and KVM is already in
> > > defconfig, I don't think we can add this until that incompatibility is
> > > fixed (or at the very least detected and handled gracefully).
> > 
> > Sure, I can put in a workaround to print out a message and fail the
> > kexec_load sys call if KVM is configured.
> 
> What would be the plan for fixing up kexec to work with kvm were we to
> do that?

As we discussed at on this ML and in detail at Linaro Connect, KVM needs
to shut itself down properly and free up the resources it acquired at
startup, mainly the hyp mode vectors.  I don't have any time free to do
that now, but if no one fixes it by the time I do have some time, then
I'll work on it.  Kexec needs no fixing for this that I know of.

-Geoff



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
