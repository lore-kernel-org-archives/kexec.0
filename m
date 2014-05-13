Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1400020030.11178.71.camel@smoke>
Subject: Re: [PATCH 1/8] arm64: Use cpu_ops for smp_stop
From: Geoff Levand <geoff@infradead.org>
Date: Tue, 13 May 2014 15:27:10 -0700
In-Reply-To: <20140509084416.GD4757@e106331-lin.cambridge.arm.com>
References: <cover.1399594544.git.geoff@infradead.org>
 <dfed1c27146457caec8f3c228a499f5e44678fd2.1399594544.git.geoff@infradead.org>
 <20140509084416.GD4757@e106331-lin.cambridge.arm.com>
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
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, Deepak Saxena <dsaxena@linaro.org>, Will Deacon <Will.Deacon@arm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Mark,

On Fri, 2014-05-09 at 09:44 +0100, Mark Rutland wrote:
> On Fri, May 09, 2014 at 01:48:17AM +0100, Geoff Levand wrote:
> > +	/* If we have the cup_ops use them. */
> > +
> > +	if (cpu_ops[cpu]->cpu_disable && cpu_ops[cpu]->cpu_die
> > +		&& !cpu_ops[cpu]->cpu_disable(cpu))
> > +		cpu_ops[cpu]->cpu_die(cpu);
> 
> For PSCI 0.2 support, we're going to need a cpu_kill callback which we
> can't call from the dying CPU. Specifically, we'll need to poll
> CPU_AFFINITY_INFO to ensure that secondaries have _actually_ left the
> kernel and aren't going to be adversely affected by the kernel text
> getting clobbered.
> 
> As we're going to wire that up to the cpu hotplug infrastructure it
> would be nice to perform the hotplug for kexec by reusing the generic
> hotplug infrastructure rather than calling portions of the arm64
> implementation directly.

OK, is there somewhere I can see that new code, and when do you expect
it to be merged?

> > +
> > +	/* Spin here if the cup_ops fail. */
> > +
> >  	while (1)
> >  		cpu_relax();
> 
> This seems very dodgy to me. If a CPU doesn't actually die it's going to
> be spinning in some memory that we may later clobber. At that point the
> CPU will do arbitrarily bad things when it begins executing whatever its
> currently executing instructions (or vectors) were replaced by, and you
> will waste hours trying to figure out what went wrong (See 8121cf312a19
> "ARM: 7766/1: versatile: don't mark pen as __INIT" for a similar mess).
> 
> If we fail to hotplug a CPU we at minimum need some acknowledgement that
> we failed. I would rather we failed to kexec entirely in that case.

This loop is for the non-hotplug power-off shutdown.  This whole smp_stop
support needs to be reconsidered for a hotplug spin-table re-work.

-Geoff



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
