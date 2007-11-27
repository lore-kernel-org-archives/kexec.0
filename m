Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ra.tuxdriver.com ([70.61.120.52])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Ix2Tc-0006Q4-Di
	for kexec@lists.infradead.org; Tue, 27 Nov 2007 15:36:03 +0000
Date: Tue, 27 Nov 2007 10:34:44 -0500
From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on
	boot cpu
Message-ID: <20071127153444.GD31376@hmsreliant.think-freely.org>
References: <20071127014740.GA28622@hmsreliant.think-freely.org>
	<20071127131355.GA14887@hmsendeavour.rdu.redhat.com>
	<m1y7cjkec2.fsf@ebiederm.dsl.xmission.com>
	<200711271445.56792.ak@suse.de>
	<m1lk8jka8j.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m1lk8jka8j.fsf@ebiederm.dsl.xmission.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, vgoyal@in.ibm.com

On Tue, Nov 27, 2007 at 07:56:44AM -0700, Eric W. Biederman wrote:
> Andi Kleen <ak@suse.de> writes:
> 
> > his is any less reliable that what we have currently.
> >> 
> >> It doesn't make things more reliable, and it adds code to a code path
> >> that already has to much code to be solid reliable (thus your
> >> problem). 
> >> 
> >> Putting the system back in PIC legacy mode on the kexec on panic path
> >> was supposed to be a short term hack until we could remove the need
> >> by always deliver interrupts in apic mode.
> >> 
> >> If you can't root cause your problem and figure out how the apics
> >> are misconfigured for legacy mode
> >
> > Probably legacy mode always routes to CPU #0. Makes sense and is
> > not really a misconfiguration of legacy mode.
> 
> Possible. So far I have not seen a hardware setup that would force
> interrupts to cpu #0 in legacy mode.  But I would not be truly
> surprised if it happened that there was hardware that only worked that
> way.
> 

That would certainly explain the behavior I am observing here.\

> > But if CPU #0 has interrupts disabled no interrupts get delivered.
> >
> > So choices are:
> > - Move to CPU #0
> > - Do not use legacy mode during shutdown.
>     (Do not use legacy mode in the kdump kernel. removing it from shutdown
>      is just minor optimization)
> > - Or do not rely on interrupts after enabling legacy mode
> > - Or do not disable interrupts on the other CPUs when they're
> > halted.
> >
> > First and last option are probably unreliable for the kdump case.
> > Second or third sound best. 
> >
> > I suspect the real fix would be to enable IOAPIC mode really
> > early and never use the timers in legacy mode. Then the kdump
> > kernel wouldn't care about the legacy mode pointing to the wrong CPU.
> 
> Exactly.  If we can work out the details that should be a much more reliable
> mode of operation.
> 
> > IIrc Eric even had  a patch for that a long time ago, but it broke some 
> > things so it wasn't included. But perhaps it should be revisited.
> 
> My real problem was the failure case was obscure (a bad interaction
> with ACPI on Linus's laptop) and I didn't have the time to track it
> down when it showed up.
> 
> My patch had two parts.  Some cleanups to enable the code to be enabled
> early, and the actually early enable.  I figure if we can get the
> cleanups in one major kernel version and then in the next enable
> the apic mode before we start getting interrupts we should be in good
> shape.
> 
> I expect with x86 becoming an embedded platform with multiple cpus we
> may start seeing systems that don't actually support legacy PIC mode
> for interrupt delivery.
do you have a pointer to the old patch set?  I'd like to try it out on the failing system here.

Regards
Neil

> 
> Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
