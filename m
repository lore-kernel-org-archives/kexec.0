Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IIQ4w-0004KT-Ee
	for kexec@lists.infradead.org; Tue, 07 Aug 2007 15:30:38 +0100
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l77ETsvb016558
	for <kexec@lists.infradead.org>; Tue, 7 Aug 2007 10:29:54 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l77EThdQ079968
	for <kexec@lists.infradead.org>; Tue, 7 Aug 2007 08:29:43 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l77ETgYC014791
	for <kexec@lists.infradead.org>; Tue, 7 Aug 2007 08:29:42 -0600
Date: Tue, 7 Aug 2007 19:59:28 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: PATCH/RFC: [kdump] fix APIC shutdown sequence
Message-ID: <20070807142928.GA18839@in.ibm.com>
References: <46B73955.2080007@fujitsu-siemens.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <46B73955.2080007@fujitsu-siemens.com>
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
Cc: Haren Myneni <hbabu@us.ibm.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Mon, Aug 06, 2007 at 05:08:05PM +0200, Martin Wilck wrote:
> PATCH/RFC: [kdump] fix APIC shutdown sequence
> 
> This patch fixes a problem that we have encountered
> with kdump under high I/O load on some machines.
> The machines showing the errors have an Intel ICH7
> chip set with a 6702PXH  PCI Express-to-PCI Bridge
> (8086:032c) containing an IO-APIC.
> 

I quickly went through the problem description and the
patch. I think currently problem is not fully understood
and we are trying to put a patch. I think we need to
do little more study of the problem and then think of
a solution.

> The bug symptom is that certain controllers connected
> to the 6702PXH bridge wouldn't receive any IRQs in the
> kdump kernel. In the error case (which is about 20% of
> all cases) the IRR bit of the IO-APIC pin for that
> controller is always set after the start of the kdump
> kernel, indicating an IRQ in progress. We haven't found
> a way to recover from this situation when it has once
> occured, except for a system reset.
> 
> The error is caused by IRQs arriving while the APIC
> subsystem is deactivated in machine_crash_shutdown().
> 
> Apparently, the IO-APIC gets stuck if it sends an IRQ
> message to a Local APIC and never receives an EOI for that
> message. This can have several possible reasons:
> 

We need to zoom onto one precise reason to solve the issue
Speculation will not help.

> 1. If, under SMP, the IO-APIC logical destination field is
>    set by the IRQ balancing code to one of the "other"
>    CPUs (i.e. not the crashing_cpu), and an IRQ arrives
>    on the respective pin after that CPU has shut down
>    its local APIC (but before the IO-APIC pin is masked)
>    the IRQ message can't be delivered.

Point 1 and Point 2 seems to be same.

> 
> 2. The crashing CPU itself disables its local APIC
>    before the IO-APIC, leaving a short time window
>    where the IOAPIC can receive IRQs, but not
>    deliver them.
> 

I doubut that it would be the issue. Looking at intel IOAPIC (82093AA)
documentation, it says that IRR bit of IOAPIC will be set only if
destination CPU has accepted the interrupt. So if we have disabled
the LAPIC, it will not accept the interrupt and IRR bit of IOAPIC
should not be set.
 
> 3. An IRQ is received and delivered to a local APIC, but
>    no CPU ever executes the IRQ handler and therefore no
>    EOI is sent.
> 

We do issue EOI for all the pending interrupts in second
kernel. Look at setup_local_APIC(). Once the second is booting, it
checks if there are any pending interrupts (ISR bit is set). If yes,
it goes ahead and issues an extra EOI. This should also clear the
IRR register of IOAPIC.


> After a lot of failed attempts, i have come up with the
> following patch, which fixes the problem.
> 
> The patch first masks all IO-Apic pins to avoid a sitation
> where the IO-Apic can receive, but not deliver, the IRQs.
> Moreover, it enables interrupts for a short period before
> eventually starting the kdump kernel, so that EOIs can be
> sent to the APICs as necessary.
> 
> Notes:
> a) Simply calling disable_IO_APIC() early doesn't
> work, probably because that also clears the IRQ vector
> information, so that arriving EOI messages can't be
> associated with pins by the IO-APIC.

disable_IO_APIC() code does not clear the vector information
in routing table. It just masks the interrupt. So even if
an EOI is issued later in second kernel, it should clear the
IRR bit at IOAPIC.

> b) We have tried patches that avoid re-enabling interrupts,
> but so far without success. Re-enabling IRQs is of course
> dangerous while dumping, and I'd rather find a way to avoid it.
> c) There are indications that besides the EOI, it's also
> necessary that the PCI IRQ pin is deasserted at least for
> a short time. That usually requires that the driver IRQ
> handler is called and tells the FW that the IRQ was received.
> Whether or not this is a requirement hasn't been finally
> clarified yet.

I doubt this. There are situations when there is no device
driver for the device and device pushes the interrupt (frequently
observed in the case of kdump). Kernel still keeps on receiving
the interrupt without driver telling device to lower the interrupt
line.

> d) The problem is only seen with the IO-APIC in the 6702PXH
> PCI bridge, which is the system's secondary IO-APIC. On the
> system's main IO-APIC, we see other IRQs (timer etc) arrive
> and never get an EOI, but we see no errors.
> 
> The patch below is against 2.6.23-rc1. The problem was
> originally analyzed and the patch developed against the
> Red Hat EL5 kernel (2.6.18-8.el5). I verified that the
> problem still occurs with 2.6.23-rc1, and that the patch
> below fixes the problem.
> 

I can imagine one possibility. There might be pending interrupts
on a non-crashing cpu. When second kernel boots, we initialize only
one cpu and issue EOI for pending interrupts only on that CPU. So
if an interrupt is pending on other CPU, then IRR bit for that interrupt
on IOAPIC will remain set and one would not get further interrupts from
that device.

- Can you please see if you can reproduce same problem with a
  single processor (maxcpus=1)

- Can you please print local apic (print_local_APIC) and
  ioapic registers (print_IO_APIC) and verify above theory?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
