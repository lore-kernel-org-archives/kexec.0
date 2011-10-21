Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Date: Fri, 21 Oct 2011 17:34:26 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: Possible regression in kexec on ARM ARMv6 and ARMv7 cores
Message-ID: <20111021083426.GA16088@verge.net.au>
References: <20111020042444.GA20260@verge.net.au>
	<20111020070105.GA28548@mudshark.cambridge.arm.com>
	<20111020080823.GA2716@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111020080823.GA2716@verge.net.au>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Cc: Dave Martin <dave.martin@linaro.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Frank Hofmann <frank.hofmann@tomtom.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Oct 20, 2011 at 05:08:24PM +0900, Simon Horman wrote:
> On Thu, Oct 20, 2011 at 08:01:06AM +0100, Will Deacon wrote:
> > On Thu, Oct 20, 2011 at 05:24:45AM +0100, Simon Horman wrote:
> > > Hi Will, Hi All,
> > 
> > Hi Simon,
> 
> Hi Will,
> 
> > > it appears that "ARM: proc: add definition of cpu_reset for
> > >  ARMv6 and ARMv7 cores" (f4daf06fc23b99df5ca5b3e892428b91e148cc52),
> > > which was introduced for 3.1-rc1, causes a regression and that
> > > kexec no longer works on ARM. The board that I am testing
> > > on is a Renesas Mackerel which has an SH7372 (ARMv7) processor.
> > 
> > Wow, I'm surprised the old code worked at all on an ARMv7 CPU! It's certainly
> > highly unlikely to work by the letter of the architecture, so I guess the
> > planets aligned in just the right way for your particular implementation.
> > 
> > Please can you try my kexec/mmu-off patches? They should add the bits and
> > pieces you need for kexec to work reliably on a UP system. I plan to finish
> > these off next week in Prague so hopefully they'll hit mainline in the near
> > future.
> > 
> > https://github.com/wdeacon/linux-wd/commits/kexec/mmu-off
> 
> Thanks, I will try your patches and let you know how I go.

I have tested the kexec/mmu-off branch of your tree on the UP board
I mentioned above and kexec works :)

> You mention UP in particular, which I will test.
> Do you have any thoughts on SMP?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
