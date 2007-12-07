Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [2002:a646:1c45::1] (helo=ebiederm.dsl.xmission.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1J0iEU-0007lf-DU
	for kexec@lists.infradead.org; Fri, 07 Dec 2007 18:47:31 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on boot
	cpu
References: <20071128190525.GD3192@redhat.com> <474F7177.7050306@redhat.com>
	<20071130144250.GC23810@redhat.com>
	<20071130145131.GB5822@hmsendeavour.rdu.redhat.com>
	<20071206213951.GB28898@hmsreliant.think-freely.org>
	<20071206221143.GC2863@redhat.com>
	<20071207001023.GA7312@hmsendeavour.rdu.redhat.com>
	<20071207143944.GF2863@redhat.com>
	<20071207145315.GB10389@hmsendeavour.rdu.redhat.com>
	<20071207151623.GG2863@redhat.com>
	<20071207155331.GC10389@hmsendeavour.rdu.redhat.com>
Date: Fri, 07 Dec 2007 11:46:21 -0700
In-Reply-To: <20071207155331.GC10389@hmsendeavour.rdu.redhat.com> (Neil
	Horman's message of "Fri, 7 Dec 2007 10:53:31 -0500")
Message-ID: <m1tzmuqr5u.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
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
Cc: Ben Woodard <woodard@redhat.com>, Neil Horman <nhorman@tuxdriver.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>, hbabu@us.ibm.com, Andi Kleen <andi@firstfloor.org>, Vivek Goyal <vgoyal@redhat.com>

Neil Horman <nhorman@redhat.com> writes:

>> Does LAPIC allow to disable a specific vector and not accept interrupts? I
>> don't think so. If a timer interrupt is broadcasted to every cpu I think
>> everybody will accept it (like broadcast IPI). That's why intelligence
>> is built into IOAPIC and direct interrupts to a cpu or group of cpu.
>> 
> See disable_APIC_timer().  It seems to set the mask bit in the APIC_LVTT entry.

Yes.  The local allows us to choose to accept ExtInt interrupts or not.
We can't do it per vector but we can do by interrupt delivery path.
External Interrupt.
External NMI.
Logical Apic Bus (Although I don't know if we can disable this one).

>
>> I am just trying to understand the functionality better. Can somebody help me
>> understand how do we make sure that same timer interrupt is not processed by
>> all cpus (assuming hypertransport is broadcasting it)?
>> 
> I understand your desire, but clearly, something prevents it.  Note our earlier
> conversation, this bit doesn't actually force a unicast of an interrupt packet,
> but simply masks the destination field.  When set to zero, it simply means that
> the ht interrupt packet destination field is restricted to 4 bits rather than 8.
> So its not like when its set to zero we are guaranteed that it is forced to a
> single processor anyway.  All setting this bit does is ensure that if any apics
> out on a system are addresed using an extended apic id, that interrupts can
> reach them.  Thats why it was suggested that this bit only be forcibly set if
> bit 18 is also set.

We should only have a single cpus local apic configured to accept the
interrupt.  Further it would not surprise me if there was some first
come first served logic with accepting the interrupt in there
somewhere.


>> Again for my understanding, I got few questions.
>> 
>> - Why does nvidia choose not to broadcast the interrupts and still works
>>   fine? Does that mean nvidia chipse will not work the extended cpu apic
>>   ids?
>> 
> It doesn't! When booting normally getting interrupts to apics that use 4 bit
> apic ids is sufficient since cpu0 is in that set, but if we crash on a cpu with
> an extended id, we hang.

Yes.  This sounds like a BIOS bug at present.  A chipset feature
residing in the CPUs was not enabled properly.

>> - Why do I need to broadcast the interrupts and not target specific cpus?
>> 
> Its not a forced broadcast, its a mask on the apic id.  The IOAPIC still
> addresses specific cpus.

This is a broadcast for legacy mode interrupts which don't have a cpu
destination field.  Once we are running the timer through the ioapic
we have a destination field and the broadcast logic should not matter.

>> - If I am broadcasting interrupts, how do I make sure only one cpu
>>   picks it up.
>> 
> The IOAPIC handles that.

Well the local apics.   If you are in ioapic mode and give the
cpus a choice of which cpu to deliver to it is a hardware anycast irq
transmission.  That is the hardware magically picks one cpu of the
set of allow cpus to deliver the irq to.  How that happens is
implementation specific.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
