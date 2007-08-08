Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IImkL-0004Jl-Fv
	for kexec@lists.infradead.org; Wed, 08 Aug 2007 15:42:51 +0100
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l78Egemh019888
	for <kexec@lists.infradead.org>; Wed, 8 Aug 2007 10:42:40 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l78Egcvl259822
	for <kexec@lists.infradead.org>; Wed, 8 Aug 2007 08:42:40 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l78EgTXA028121
	for <kexec@lists.infradead.org>; Wed, 8 Aug 2007 08:42:29 -0600
Date: Wed, 8 Aug 2007 20:12:39 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: PATCH/RFC: [kdump] fix APIC shutdown sequence
Message-ID: <20070808144239.GA1499@in.ibm.com>
References: <46B73955.2080007@fujitsu-siemens.com>
	<20070807142928.GA18839@in.ibm.com>
	<46B8AECA.7050908@fujitsu-siemens.com>
	<20070808103603.GC13808@in.ibm.com>
	<Pine.LNX.4.64.0708081003000.29193@bogart.boston.redhat.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708081003000.29193@bogart.boston.redhat.com>
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
To: Chip Coldwell <coldwell@redhat.com>
Cc: Martin Wilck <martin.wilck@fujitsu-siemens.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Haren Myneni <hbabu@us.ibm.com>

On Wed, Aug 08, 2007 at 10:06:13AM -0400, Chip Coldwell wrote:
> On Wed, 8 Aug 2007, Vivek Goyal wrote:
> 
> > On Tue, Aug 07, 2007 at 07:41:30PM +0200, Martin Wilck wrote:
> > > 
> > > Can you explain how, on the front side bus, the IO-APIC knows whether
> > > a CPU has accepted the INT message? There is no response
> > > to the INT message on the bus, except for the EOI which comes much later.
> > > I'm not saying that you're wrong, I just really don't understand this
> > > point.
> > > 
> > 
> > I don't know what is exactly hardware protocol. I am just going by 
> > intel documentation. 
> 
> I think it's important to distinguish between the LAPIC receiving an
> interrupt and the CPU receiving an interrupt.  The former could happen
> without the latter if the CPU has set the TPR above the priority of
> the interrupt received by the LAPIC.  In that case, the interrupt is
> kept pending in the LAPIC and recorded in the IRR if I understand the
> Intel documentation correctly.
> 
> So I think the scenario which leaves IRR set when the kdump kernel
> starts is possible.

Hi Chip,

That's true. I agree that once kdump kernel starts we very well can be
in a situation where ISR/IRR bits of LAPIC are set and IRR bit of IOAPIC
is set. These are pending interrupt which will be delivered in the
second kernel and that kernel will reject these pending interrupts as spurious
interrupt and send an EOI. This will clear the LAPIC state. 

But the issue here seems to be that LAPIC state got clear but IRR bit
at IOAPIC bit is not cleared because IOAPIC vector information was deleted
in first kernel and now upon receiving EOI, it does not know this EOI belongs
to which vector.

Given the fact that "irqpoll" makes things work, I think we should not 
complicate the logic and leave it like that. Anyway, our goal is to capture
the dump and not make sure in second kernel interrupt from all the devices
are coming.

Otherwise we shall have to resort to techniques like first masking all
the interrupts at IOAPIC level, then issuing EOI on all the cpus in the
first kernel itself. It makes the logic little twisted. 

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
