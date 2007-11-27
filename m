Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Ix0UY-0006qM-NZ
	for kexec@lists.infradead.org; Tue, 27 Nov 2007 13:28:53 +0000
Date: Tue, 27 Nov 2007 08:28:11 -0500
From: Neil Horman <nhorman@redhat.com>
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on boot
	cpu
Message-ID: <20071127132811.GB14887@hmsendeavour.rdu.redhat.com>
References: <20071127014740.GA28622@hmsreliant.think-freely.org>
	<20071127105503.GD24223@one.firstfloor.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071127105503.GD24223@one.firstfloor.org>
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
To: Andi Kleen <andi@firstfloor.org>
Cc: Neil Horman <nhorman@tuxdriver.com>, kexec@lists.infradead.org, ak@suse.de, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, vgoyal@in.ibm.com, ebiederm@xmission.com

On Tue, Nov 27, 2007 at 11:55:03AM +0100, Andi Kleen wrote:
> On Mon, Nov 26, 2007 at 08:47:40PM -0500, Neil Horman wrote:
> > Hey all-
> > 	I've been working on an issue lately involving multi socket x86_64
> > systems connected via hypertransport bridges.  It appears that some systems,
> > disable the hypertransport connections during a kdump operation when all but the
> > crashing processor gets halted in machine_crash_shutdown.  This becomes a
> 
> That would be hard to believe. Linux cannot shut down CPUs
> completely (put them back to SINIT state) because there is no generic
> interface for this and it might be impossible. They just get put 
> into a HLT loop.
> 
> And even if they were in SINIT they would still need the HT connections
> otherwise it would be impossible to ever wake them up.
> 
I understand that this is how its supposed to work, but my analysis nevertheless
in my mind points to an inability to route irqs to any processor other than the
boot cpu.  I conducted a test whereby I forced a crash on cpu0, and then again
on cpu3.  I've found that on all the systems I have available, I'm able to boot
to a kexec kernel without issue.  However, on this system:
http://www.supermicro.com/Aplus/motherboard/Opteron8000/MCP55/H8QM8-2.cfm

Crashing on any cpu other than the boot cpu leads to a hang in calibrate_delay
on reboot.  I certainly make room for the notion that this could be an ioapic
programming error, but I don't see that this system has a different ioapic that
my other test systems.  I've also simply tried booting the system that is
failing with noapic, to force the system to not use the ioapic, to no avail.  If
you could suggest another test to point to another root cause, I would happily
run it, but the evidence that I have at the moment suggests to me that the
ioapic, while normally getting succefully programmed to deliver interrupts to
the appropriate cpu, is unable to on this system, and removing the traversal of
the system bus on the affected system restores functionality.  That suggests a
system bus error to me.

> The way HT setup is normally done is that the BIOS sets it all up
> and then it never changes (except for some error conditions that 
> may cause SYNC flood) 
> 
I think thats part of the issue.  Somehow (and in fairness I don't know how this
occurs), the crash of the kernel affects the functionality of the hypertransport
bus in such a way that it can no longer deliver interrupts.  I'm not sur how,
beyond the testing that I describe above, that I can further prove or disprove
this.


> 
> > problem when the ioapic attempts to route interrupts to the only remaining
> > processor.  Even though the active processor is targeted for interrupt
> > reception, the fact that the hypertransport connections are inactive result in
> > interrupts not getting delivered.  The effective result is that timer interrupts
> > are not delivered to the running cpu, and the system hangs on reboot into the
> > kdump kernel during calibrate_delay.  I've found that I've been able to avoid
> > this hang, by forcing a transition to the bios defined boot cpu during the
> > crashing kernel shutdown.  This patch accomplished that.  Tested by myself and
> > the origional reporter with successful results.
> 
> While that may help I doubt your analysis of the source of the problem
> is correct. Most likely something is broken with the IO-APIC, but not
> related to HyperTransport.
> 

If you could suggest a test or observation to make so that I could further
diagnose this, I would appreciate it.  Currently the code seems to configure the
ioapic properly on all systems available to me, except the supermicro board
above.  Any thoughts welcome here.


Thanks  & Regards
Neil

> It would be better to properly root cause before applying.
> 
> -Andi
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

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
