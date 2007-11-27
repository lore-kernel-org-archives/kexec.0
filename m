Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ra.tuxdriver.com ([70.61.120.52])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Ix3Zn-00026X-9S
	for kexec@lists.infradead.org; Tue, 27 Nov 2007 16:46:30 +0000
Date: Tue, 27 Nov 2007 11:45:21 -0500
From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on
	boot cpu
Message-ID: <20071127164521.GE31376@hmsreliant.think-freely.org>
References: <20071127014740.GA28622@hmsreliant.think-freely.org>
	<200711271445.56792.ak@suse.de>
	<20071127142826.GB31376@hmsreliant.think-freely.org>
	<200711271543.11809.ak@suse.de>
	<20071127144856.GC31376@hmsreliant.think-freely.org>
	<m14pf7k8ns.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m14pf7k8ns.fsf@ebiederm.dsl.xmission.com>
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
Cc: woodard@redhat.com, Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, vgoyal@in.ibm.com

On Tue, Nov 27, 2007 at 08:30:47AM -0700, Eric W. Biederman wrote:
> Neil Horman <nhorman@tuxdriver.com> writes:
> 
> > So, it sounds to me then, like unless I'm willing to really re-write the APIC
> > setup code (which I don't feel qualified to do quite yet), that the immediate
> > solution would be to not rely on interrupts in legacy mode, which was according
> > to my understanding, what the use of the irqpoll command line option was
> > supposed to enable.  Any thoughts as to why that might not be working in this
> > case, or suggested tests to determine a cause there?
> 
> Hmm.  It looks like irqpoll expects to have at least one irq working.
> I wonder if we can fix that.
> 
> Looking at it from the other direction what does this line
> from check_timer() look like when you boot a normal kernel?
> 
> 	apic_printk(APIC_VERBOSE,KERN_INFO "..TIMER: vector=0x%02X apic1=%d pin1=%d apic2=%d pin2=%d\n",
> 		cfg->vector, apic1, pin1, apic2, pin2);
> 

Sure, Ben, can you provide the output of that on the system in question?  You'll need to boot with apic=verbose to see it.

> I'm curious what values we see at boot for the legacy mode the first
> time it is setup, and possibly what chipset you are on.
> I know we have had a few times where we have failed to reprogram
> the ioapic properly at shutdown.  So it can't hurt to look at
> that possibility one last time.
> 
> 
> For whatever it is worth my original attempt at using only the
> apic mode was commit: f2b36db692b7ff6972320ad9839ae656a3b0ee3e
> Looks like I didn't have an x86_64 version.
> 
Thanks, I'll take a look at that.

> It looks like about half the cleanups I needed was to decouple
> smp cpu startup and apic initialization.  I think the hotplug cpu
> case has done a more thorough version of that now.
> 
> There was a bit of reshuffling needed to get the everything initialized
> in the right order when we started apic mode sooner.
> 
> Anyway I might just take another look at this if I can find enough
> moments to string together.
> 
> Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
