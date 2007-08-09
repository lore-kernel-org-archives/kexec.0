Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IJ51Z-0002B2-Cp
	for kexec@lists.infradead.org; Thu, 09 Aug 2007 11:13:54 +0100
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l79ABKx7026444
	for <kexec@lists.infradead.org>; Thu, 9 Aug 2007 06:11:20 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l79ABKVG527502
	for <kexec@lists.infradead.org>; Thu, 9 Aug 2007 06:11:20 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l79ABKAr010595
	for <kexec@lists.infradead.org>; Thu, 9 Aug 2007 06:11:20 -0400
Date: Thu, 9 Aug 2007 15:41:28 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: PATCH/RFC: [kdump] fix APIC shutdown sequence
Message-ID: <20070809101128.GA14738@in.ibm.com>
References: <46B73955.2080007@fujitsu-siemens.com>
	<20070807142928.GA18839@in.ibm.com>
	<46B8AECA.7050908@fujitsu-siemens.com>
	<20070808103603.GC13808@in.ibm.com>
	<Pine.LNX.4.64.0708081003000.29193@bogart.boston.redhat.com>
	<20070808144239.GA1499@in.ibm.com>
	<46BA0844.9080703@fujitsu-siemens.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <46BA0844.9080703@fujitsu-siemens.com>
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
To: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Cc: Haren Myneni <hbabu@us.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Chip Coldwell <coldwell@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Aug 08, 2007 at 08:15:32PM +0200, Martin Wilck wrote:
> Vivek Goyal wrote:
> 
> > But the issue here seems to be that LAPIC state got clear but IRR bit
> > at IOAPIC bit is not cleared because IOAPIC vector information was deleted
> > in first kernel and now upon receiving EOI, it does not know this EOI belongs
> > to which vector.
> 
> I am making another experiment right now. I check the LAPIC ISR flags in
> machine_crash_shutdown() before disabling the LAPIC, trying to send EOI if
> I find one ISR bit set. So far, I haven't seen a single case where an ISR bit
> was set, but several (9) where the IO-APIC IRR bit was set. OTOH, I know that if
> I'd re-enable IRQs, IRQ 225 would be raised. The whole thing is done before
> disable_IO_APIC().
> 
> Don't ask me for an explanation why I don't see the ISR bits.
> 

Did you also check IRR bits on LAPIC. May be some interrupt is already
being served and your new interrupts has been queued on LAPIC and IRR bit
on LAPIC is set?

Following is the text from intel system programming manual.

The IRR contains the active interrupt requests that have been accepted, but
not yet dispatched to the processor for servicing. When the local APIC accepts
an interrupt, it sets the bit in the IRR that corresponds the vector of the
accepted interrupt. When the processor core is ready to handle the next
interrupt, the local APIC clears the highest priority IRR bit that is set and
sets the corresponding ISR bit. The vector for the highest priority bit set in
the ISR is then dispatched to the processor core for servicing.

In this case, I suspect that your interrupt gets queued at LAPIC (IRR is set)
but it does not make into ISR (may be because interrupts are disabled and
some other vector is already being served. Can you please paste your LAPIC
and IOAPIC state here.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
