Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.66 #1 (Red Hat Linux))
	id 1IrbQG-0004HJ-UM
	for kexec@lists.infradead.org; Mon, 12 Nov 2007 10:42:07 -0500
Date: Mon, 12 Nov 2007 10:41:19 -0500
From: Neil Horman <nhorman@redhat.com>
Subject: Re: Timer interrupt lost on some x86_64 systems
Message-ID: <20071112154119.GC11751@hmsendeavour.rdu.redhat.com>
References: <20071107140006.GC14371@hmsendeavour.rdu.redhat.com>
	<20071112044903.GA6433@in.ibm.com>
	<20071112151721.GB11751@hmsendeavour.rdu.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071112151721.GB11751@hmsendeavour.rdu.redhat.com>
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
Cc: Vivek Goyal <vgoyal@in.ibm.com>, kexec@lists.infradead.org

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
> Thanks
> Neil
> 
> > Thanks
> > Vivek
> 


Although, as I look at it, it would appear that time_init from start_kernel does
seem to init the hpet if its available, and it silently fails if that doesn't
work, moving on to the pmtimer and pit.  I wonder if there is some extra magic
to resetting the hpet to run on a different cpu for some systems...
Neil

> -- 
> /***************************************************
>  *Neil Horman
>  *Software Engineer
>  *Red Hat, Inc.
>  *nhorman@redhat.com
>  *gpg keyid: 1024D / 0x92A74FA1
>  *http://pgp.mit.edu
>  ***************************************************/

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
