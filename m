Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1414799272.23621.50.camel@smoke>
Subject: Re: [PATCH 04/10] arm64: Add EL2 switch to soft_restart
From: Geoff Levand <geoff@infradead.org>
Date: Fri, 31 Oct 2014 16:47:52 -0700
In-Reply-To: <20141024105724.GF24265@leverpostej>
References: <cover.1414099246.git.geoff@infradead.org>
 <d878ad0595c9372fcbbf5e299b3949f2b59d8968.1414099246.git.geoff@infradead.org>
 <20141024105724.GF24265@leverpostej>
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

On Fri, 2014-10-24 at 11:57 +0100, Mark Rutland wrote:
> On Fri, Oct 24, 2014 at 12:10:58AM +0100, Geoff Levand wrote:
> > When a CPU is reset it needs to be put into the exception level it had when it
> > entered the kernel.  Update cpu_reset() to accept an argument el2_switch which
> > signals cpu_reset() to enter the soft reset address at EL2.  If el2_switch is
> > not set the soft reset address will be entered at EL1.
> > 
> > Update cpu_soft_restart() and soft_restart() to pass the return of
> > is_hyp_mode_available() as the el2_switch value to cpu_reset().  Also update the
> > comments of cpu_reset(), cpu_soft_restart() and soft_restart() to reflect this
> > change.
> 
> This will blow up without warning with KVM, and I think we need to
> address that first.

Yes.  I think we can just put in a conditional on KVM as a workaround
until KVM will work with this.

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
