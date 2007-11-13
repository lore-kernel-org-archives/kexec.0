Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Irq64-0001aW-LW
	for kexec@lists.infradead.org; Tue, 13 Nov 2007 02:22:16 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lAD7M0r8016629
	for <kexec@lists.infradead.org>; Tue, 13 Nov 2007 02:22:00 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	lAD7Lxxn127182
	for <kexec@lists.infradead.org>; Tue, 13 Nov 2007 00:21:59 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lAD7LxSh017600
	for <kexec@lists.infradead.org>; Tue, 13 Nov 2007 00:21:59 -0700
Date: Tue, 13 Nov 2007 12:52:07 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: Timer interrupt lost on some x86_64 systems
Message-ID: <20071113072207.GA24067@in.ibm.com>
References: <20071107140006.GC14371@hmsendeavour.rdu.redhat.com>
	<20071112044903.GA6433@in.ibm.com>
	<20071112151721.GB11751@hmsendeavour.rdu.redhat.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071112151721.GB11751@hmsendeavour.rdu.redhat.com>
Reply-To: vgoyal@in.ibm.com
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
To: Neil Horman <nhorman@redhat.com>
Cc: kexec@lists.infradead.org

On Mon, Nov 12, 2007 at 10:17:21AM -0500, Neil Horman wrote:
> On Mon, Nov 12, 2007 at 10:19:03AM +0530, Vivek Goyal wrote:
> > On Wed, Nov 07, 2007 at 09:00:06AM -0500, Neil Horman wrote:
> > > Hey all-
> > > 	I've been getting reports of some x86_64 systems that, on kdump kernel
> > > boot get stuck in calibrate_delay(),  in both RHEL kernels and upstream kernels.
> > > The current thinking is that the lapic timer interrupt is no longer getting
> > > delivered, likely because we handle a crash condition on a cpu that isn't the
> > > boot cpu.  One known offender is this motherboard:
> > > http://www.supermicro.com/Aplus/motherboard/Opteron8000/MCP55/H8QM8-2.cfm
> > > My current thought is that the TIMER_LVT entry is masked on all but the boot cpu
> > > on this system (which is strange, as I was under the impression that the timer
> > > interrupt was supposed to be enabled on all CPU's nominally.
> > 
> > I also thought that LAPIC timer interrupts are enabled on all cpus.
> > 
> That doesn't appear to be the case.  The configuration I've seen is that only
> one lapic has timer interrupts enabled, and the interrupt handler for the timer
> interrupt broadcasts the interrupt to all the other processors via IPI
> 
> > >  At any rate, I was
> > > going to try to read/write the TIMER_LVT on the crashing processor before we
> > > jump to purgatory, or in purgatory itself, to see if that fixes the problem, but
> > 
> > I think calibrate_dealy() depends on external timer interrupt coming and
> > not the local APIC timer interrupt. Generally it is 8254 timer chip. Now a
> > days motherboards seems to be having HPET and I know somebody has reported
> > problems with HPET where HPET interrupts are not coming in second kernel and
> > system hangs in second kernel. I suspect  that same might be the issue here.
> > 
> Perhaps, do you have a pointer to any list discussions on the subject?  I've not
> seen any yet.
> 

http://lkml.org/lkml/2007/8/20/155

Reading through the thread again looks like this guy faced issue with
i386 machines and not x86_64 machines.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
