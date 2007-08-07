Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IIT3s-0000DM-Qj
	for kexec@lists.infradead.org; Tue, 07 Aug 2007 13:41:46 -0400
Message-ID: <46B8AECA.7050908@fujitsu-siemens.com>
Date: Tue, 07 Aug 2007 19:41:30 +0200
From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: PATCH/RFC: [kdump] fix APIC shutdown sequence
References: <46B73955.2080007@fujitsu-siemens.com>
	<20070807142928.GA18839@in.ibm.com>
In-Reply-To: <20070807142928.GA18839@in.ibm.com>
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
To: "vgoyal@in.ibm.com" <vgoyal@in.ibm.com>
Cc: Haren Myneni <hbabu@us.ibm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hello Vivek,

thank you very much for looking at this problem, and for your
comments.

>> The error is caused by IRQs arriving while the APIC
>> subsystem is deactivated in machine_crash_shutdown().
>>
>> Apparently, the IO-APIC gets stuck if it sends an IRQ
>> message to a Local APIC and never receives an EOI for that
>> message. This can have several possible reasons:
>>
> We need to zoom onto one precise reason to solve the issue
> Speculation will not help.

We have made a number of logical analyzer traces. In all cases
where the error occurred, there was a INT message from the IO-APIC
that never received an EOI. These INT messages always occurred shortly
before or during machine_crash_shutdown(); unfortunately it is
impossible from analyzer traces to tell exactly when
machine_crash_shutdown() was entered.

Such a situation has never been observed in the "good" case.
So, we do have some evidence, not just bare speculation.

>> 2. The crashing CPU itself disables its local APIC
>>    before the IO-APIC, leaving a short time window
>>    where the IOAPIC can receive IRQs, but not
>>    deliver them.
>>
> 
> I doubut that it would be the issue. Looking at intel IOAPIC (82093AA)
> documentation, it says that IRR bit of IOAPIC will be set only if
> destination CPU has accepted the interrupt. So if we have disabled
> the LAPIC, it will not accept the interrupt and IRR bit of IOAPIC
> should not be set.

Can you explain how, on the front side bus, the IO-APIC knows whether
a CPU has accepted the INT message? There is no response
to the INT message on the bus, except for the EOI which comes much later.
I'm not saying that you're wrong, I just really don't understand this
point.

In the logical analyzer, we can't see when exactly the local APICs are
disabled. But we see that IRQs arriving after the IO APIC pin is
masked never do any harm, while IRQs arriving "during the shutdown
sequence" (we can see e.g. the 2nd CPU taking the bus after the NMI
IPI) cause the error situation.

>> 3. An IRQ is received and delivered to a local APIC, but
>>    no CPU ever executes the IRQ handler and therefore no
>>    EOI is sent.
>>
> 
> We do issue EOI for all the pending interrupts in second
> kernel. Look at setup_local_APIC(). Once the second is booting, it
> checks if there are any pending interrupts (ISR bit is set). If yes,
> it goes ahead and issues an extra EOI. This should also clear the
> IRR register of IOAPIC.

In an earlier patch, I tried to add that same code in
machine_crash_shutdown() and crash_nmi_callback(),  in order
to send EOIs for pending IRQs on all CPUs. Unfortunately,
that had no effect.

> disable_IO_APIC() code does not clear the vector information
> in routing table. It just masks the interrupt. So even if
> an EOI is issued later in second kernel, it should clear the
> IRR bit at IOAPIC.

Hmm... ioapic_mask_entry() writes
"union entry_union eu = { .entry.mask = 1 }" to the  LVT register.
That clears all bits except the mask bit, so that the vector information
is lost. Please correct me if I'm mistaken.

>> c) There are indications that besides the EOI, it's also
>> necessary that the PCI IRQ pin is deasserted at least for
>> a short time.

> I doubt this. There are situations when there is no device
> driver for the device and device pushes the interrupt (frequently
> observed in the case of kdump). Kernel still keeps on receiving
> the interrupt without driver telling device to lower the interrupt
> line.

So far I haven't come up with a patch that just sends EOI without
actually calling any HW IRQ handler. That would clarify this question.
It's on my todo list.

> I can imagine one possibility. There might be pending interrupts
> on a non-crashing cpu. When second kernel boots, we initialize only
> one cpu and issue EOI for pending interrupts only on that CPU. So
> if an interrupt is pending on other CPU, then IRR bit for that interrupt
> on IOAPIC will remain set and one would not get further interrupts from
> that device.

> - Can you please see if you can reproduce same problem with a
>   single processor (maxcpus=1)

That has been done in the past. The error occurs, too, although not
quite as often.

> - Can you please print local apic (print_local_APIC) and
>   ioapic registers (print_IO_APIC) and verify above theory?

We always see the IO-APIC IRR  bit in the error situation, before and
after the start of the kdump kernel.

*Before* the kdump kernel starts (more precisely: before the call
to disable_IO_APIC()), the IO-APIC "delivery status" bit is also set.

I checked local APIC ISR and IRR bits in an earlier version of my patch
(see above). They were sometimes set, and sometimes not (unlike the IO-APIC
IRR/Delivery Status which behave always the same).

The patch was very different at that time, e.g. it didn't call the
crash_mask_IO_APIC() function yet. So perhaps, it's worth a try to
modify it and just send EOI on all CPUs instead of enabling interrupts.
I'll put it on the toto list, too.

Regards and thanks
Martin

--
Martin Wilck
PRIMERGY System Software Engineer
FSC IP ESP DE6

Fujitsu Siemens Computers GmbH
Heinz-Nixdorf-Ring 1
33106 Paderborn
Germany

Tel:			++49 5251 8 15113
Fax:			++49 5251 8 20409
Email:			mailto:martin.wilck@fujitsu-siemens.com
Internet:		http://www.fujitsu-siemens.com
Company Details:	http://www.fujitsu-siemens.com/imprint.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
