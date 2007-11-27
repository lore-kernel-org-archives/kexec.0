Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Ix7QP-0000Lj-Bb
	for kexec@lists.infradead.org; Tue, 27 Nov 2007 20:53:03 +0000
Date: Tue, 27 Nov 2007 15:52:55 -0500
From: Neil Horman <nhorman@redhat.com>
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on boot
	cpu
Message-ID: <20071127205255.GH14887@hmsendeavour.rdu.redhat.com>
References: <20071127014740.GA28622@hmsreliant.think-freely.org>
	<20071127131355.GA14887@hmsendeavour.rdu.redhat.com>
	<m1y7cjkec2.fsf@ebiederm.dsl.xmission.com>
	<200711271445.56792.ak@suse.de>
	<m1lk8jka8j.fsf@ebiederm.dsl.xmission.com>
	<474C64CB.7080004@redhat.com>
	<20071127194220.GG14887@hmsendeavour.rdu.redhat.com>
	<20071127200011.GA3703@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071127200011.GA3703@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Ben Woodard <woodard@redhat.com>, Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>, hbabu@us.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>

On Tue, Nov 27, 2007 at 03:00:11PM -0500, Vivek Goyal wrote:
> On Tue, Nov 27, 2007 at 02:42:20PM -0500, Neil Horman wrote:
> 
> [..]
> > 
> > Ben I tend to agree.  I think re-enabling the APIC early in the boot process
> > provides a greater degree of reliability in that it more quickly restores the
> > system to a state where booting on a cpu other than cpu0 will be more likely to
> > work, but I have to say that overall it seems like booting a secondary kernel on
> > cpu0, when possible offers the highest degree of reliability.
> > 
> > Perhaps what we need is a 'both solution'.  Re-enabling the apic to full smp
> > functionality early in the boot process is a good solution for the problems
> > which we are hypothesizing here, and would be a good thing to do in general, but
> > it doesn't preclude also attmpting to switch back to cpu0 during a crash.
> > 
> > Perhaps it would be worthwhile to:
> > 
> > 1) Investigate the early enablement of the ioapic for x86[_64]
> > 2) implement my prevoiusly proposed patch with the addition of a handshake
> > element, such that:
> > 	a) when the boot cpu gets the ipi from machine_crash_shutdown it flags
> > 	   the fact that it is going to boot the kexec kernel with a global
> > 	   variable
> > 	b) the crashing cpu loops waiting for either:
> > 		I) a timeout of 1 second
> > 		II) a reduction of the halt count to zero
> > 		III) the setting of the flag mentioned in (a)
> > 	c) the crashing cpu, if it sees that it is not the boot cpu AND
> > 	   that the flag in (III) is set, will halt itself, otherwise it
> > 	   will set the flag and boot the kexec image itself.
> > 
> > With this modification, we can try to relocate to cpu0,  and if we fail, we fall
> > back to booting on the crashing processor.
> > 
> > I'll work up a patch that implements (2), unless there are strong objections.  I
> > see no reason why we can't implment this 'both' solution.
> > 
> 
> Hi Neil,
> 
> If we implement first solution, we don't have to implement second. Problem
> will automatically be solved.
> 
Agreed, assuming:
1) The problems we have been hypothesising are accurate.  As you note below, Ben
and I have dug deep to find the problem, but we could try to go deeper.

2) There are no other issues with (re)booting a system on the non-boot cpu.  It
seems to me that if its possible to reboot on cpu0, we should try.  I understand
that we're trying to keep that code small for obvious reasons, but if we have a
fall back method to the crashing cpu, it seems reasonable safe to me.
 
> In general adding more code in crash shutdown path is not good. We are
> trying to make that code path as small as possible.
> 
> OTOH, I think we have not root caused this problem yet. We don't know yet
> why interrupts are not coming to non-boot cpu. I think we can go little
> deeper to compare the system state in normal boot and kdump boot and see
> what has changed. System state would include, LAPIC and IOAPIC entries
> etc.
> 

> Are we putting the system back in PIC mode or virtual wire mode? I have
> not seen systems which support PIC mode. All latest systems seems
> to be having virtual wire mode. I think in case of PIC mode, interrupts
> can be delivered to cpu0 only. In virt wire mode, one can program IOAPIC
> to deliver interrupt to any of the cpus and that's what we have been
> relying on  until and unless there is something board specific.
> 

This is actually a very interesting question.  Looking at disable_IO_APIC in the
latest git tree, which is used to revert the APIC to a legacy mode, we do one of
two things.  If the on board 8259 is routed through the IOAPIC, then we
configure the APIC to be in virtual wire mode, so that the interrupt is
delivered via the APIC to whatever processor you want to configure.  If however,
the 8259 bypasses the IOAPIC, then we simply disable the LAPICS LVT0 interrupt,
so that any legacy timer interrupts from the apic are ignored, ostesibly because
the 8259 will assert the interrupt pin on the processor it is wired to directly.
I wonder if most (almost all) modern systems use the former configuration, while
the supermicro board in question in a rare exception, uses the latter.  If the
8259 was routed directly to cpu0, that would explain this hang.

Regards
Neil
> Thanks
> Vivek

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
