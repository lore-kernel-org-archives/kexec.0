Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Ix7d6-0001Ig-QX
	for kexec@lists.infradead.org; Tue, 27 Nov 2007 21:06:11 +0000
Date: Tue, 27 Nov 2007 16:05:58 -0500
From: Neil Horman <nhorman@redhat.com>
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on boot
	cpu
Message-ID: <20071127210558.GI14887@hmsendeavour.rdu.redhat.com>
References: <20071127014740.GA28622@hmsreliant.think-freely.org>
	<200711271445.56792.ak@suse.de>
	<20071127142826.GB31376@hmsreliant.think-freely.org>
	<200711271543.11809.ak@suse.de>
	<20071127144856.GC31376@hmsreliant.think-freely.org>
	<m14pf7k8ns.fsf@ebiederm.dsl.xmission.com>
	<474C832C.1060903@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <474C832C.1060903@redhat.com>
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
To: Ben Woodard <woodard@redhat.com>
Cc: Neil Horman <nhorman@redhat.com>, Neil Horman <nhorman@tuxdriver.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>, hbabu@us.ibm.com, vgoyal@in.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>

On Tue, Nov 27, 2007 at 12:50:52PM -0800, Ben Woodard wrote:
> Eric W. Biederman wrote:
> >Neil Horman <nhorman@tuxdriver.com> writes:
> >
> >>So, it sounds to me then, like unless I'm willing to really re-write the 
> >>APIC
> >>setup code (which I don't feel qualified to do quite yet), that the 
> >>immediate
> >>solution would be to not rely on interrupts in legacy mode, which was 
> >>according
> >>to my understanding, what the use of the irqpoll command line option was
> >>supposed to enable.  Any thoughts as to why that might not be working in 
> >>this
> >>case, or suggested tests to determine a cause there?
> >
> >Hmm.  It looks like irqpoll expects to have at least one irq working.
> >I wonder if we can fix that.
> >
> >Looking at it from the other direction what does this line
> >from check_timer() look like when you boot a normal kernel?
> >
> >	apic_printk(APIC_VERBOSE,KERN_INFO "..TIMER: vector=0x%02X apic1=%d 
> >	pin1=%d apic2=%d pin2=%d\n",
> >		cfg->vector, apic1, pin1, apic2, pin2);
> >
> 
> Here is what I get on a normal boot of the problem motherboard:
> 
> ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
> 

Ok, I think from what I understand of what we're reading here, the apic2 = -1
and pin2 = -1 indicate that the 8259 has no direct connection to any cpu, which
means that on shutdown disable_IO_APIC should take us into virtual wire mode.
As such enabling the APIC early in boot should fix us, but more consisely,
rewriting the entry in the IOAPIC to deliver int0 to the only running cpu should
accomplish the same goal for this problem.  Does that sound reasonable (at least
as a test to ensure we understand the problem) to everyone?

Neil


> 
> >I'm curious what values we see at boot for the legacy mode the first
> >time it is setup, and possibly what chipset you are on.
> >I know we have had a few times where we have failed to reprogram
> >the ioapic properly at shutdown.  So it can't hurt to look at
> >that possibility one last time.
> >
> >
> >For whatever it is worth my original attempt at using only the
> >apic mode was commit: f2b36db692b7ff6972320ad9839ae656a3b0ee3e
> >Looks like I didn't have an x86_64 version.
> >
> >It looks like about half the cleanups I needed was to decouple
> >smp cpu startup and apic initialization.  I think the hotplug cpu
> >case has done a more thorough version of that now.
> >
> >There was a bit of reshuffling needed to get the everything initialized
> >in the right order when we started apic mode sooner.
> >
> >Anyway I might just take another look at this if I can find enough
> >moments to string together.
> >
> >Eric
> >
> >_______________________________________________
> >kexec mailing list
> >kexec@lists.infradead.org
> >http://lists.infradead.org/mailman/listinfo/kexec
> 
> 
> -- 
> -ben
> -=-

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
