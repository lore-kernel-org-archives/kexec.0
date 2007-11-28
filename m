Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [2002:a646:1c45::1] (helo=ebiederm.dsl.xmission.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1IxQqj-0003YE-HL
	for kexec@lists.infradead.org; Wed, 28 Nov 2007 17:37:26 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on boot
	cpu
References: <20071127131355.GA14887@hmsendeavour.rdu.redhat.com>
	<m1y7cjkec2.fsf@ebiederm.dsl.xmission.com>
	<200711271445.56792.ak@suse.de>
	<m1lk8jka8j.fsf@ebiederm.dsl.xmission.com>
	<474C64CB.7080004@redhat.com>
	<20071127194220.GG14887@hmsendeavour.rdu.redhat.com>
	<20071127200011.GA3703@redhat.com>
	<20071127222408.GH24223@one.firstfloor.org>
	<474CA733.9050908@redhat.com> <20071128153649.GC3192@redhat.com>
	<20071128160206.GA21286@hmsendeavour.rdu.redhat.com>
Date: Wed, 28 Nov 2007 10:36:12 -0700
In-Reply-To: <20071128160206.GA21286@hmsendeavour.rdu.redhat.com> (Neil
	Horman's message of "Wed, 28 Nov 2007 11:02:06 -0500")
Message-ID: <m1ir3me0hf.fsf@ebiederm.dsl.xmission.com>
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
Cc: Ben Woodard <woodard@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>, hbabu@us.ibm.com, Andi Kleen <andi@firstfloor.org>, Vivek Goyal <vgoyal@redhat.com>

Neil Horman <nhorman@redhat.com> writes:

> On Wed, Nov 28, 2007 at 10:36:49AM -0500, Vivek Goyal wrote:
>> On Tue, Nov 27, 2007 at 03:24:35PM -0800, Ben Woodard wrote:
>> > Andi Kleen wrote:
>> >>> Are we putting the system back in PIC mode or virtual wire mode? I have
>> >>> not seen systems which support PIC mode. All latest systems seems
>> >>> to be having virtual wire mode. I think in case of PIC mode, interrupts
>> >>
>> >> Yes it's probably virtual wire. For real PIC mode we would need really
>> >> old systems without APIC.
>> >>
>> >>> can be delivered to cpu0 only. In virt wire mode, one can program IOAPIC
>> >>> to deliver interrupt to any of the cpus and that's what we have been
>> >>
>> >> The code doesn't try to program anything specific, it just restores the
> state
>> >> that was left over originally by the BIOS.
>> >>
>> >
>> > So if the BIOS originally left the IOAPIC in a state where the timer 
>> > interrupts were only going to CPU0 then by restoring that state we could be
>> > bringing this problem upon ourselves when we restore that state.
>> >
>> 
>> Hi Ben,
>> 
>> Apart from restoring the original state (Bring APICS back to virtual wire
>> mode), we also reprogram IOAPIC so that timer interrupt can go to crashing
>> cpu (and not necessarily cpu0). Look at following code in disable_IO_APIC.
>> 
>>                 entry.dest.physical.physical_dest =
>>                                         GET_APIC_ID(apic_read(APIC_ID));
>> 
>> Here we read the apic id of crashing cpu and program IOAPIC accordingly.
>> This will make sure that even in virtual wire mode, timer interrupts
>> will be delivered to crashing cpu APIC.
>> 
> Yes, but according to Bens last debug effort, the APIC printout regarding the
> timer setup, indicates that ioapic_i8259.pin == -1, meaning that the 8259 is not
> routed through the ioapic.  In those cases, disable_IO_APIC does not take us
> through the path you reference above, and does not revert to virtual wire mode.
> Instead, it simply disables legacy vector 0, which if I understand this
> correctly, simply tells the ioapic to not handle timer interrupts, trusting that
> the 8259 in the system will deliver that interrupt where it needs to be.  If the
> 8259 is wired to deliver timer interrupts to cpu0 only, then you get the problem
> that we have, do you?

Exactly.

It is still interesting to test to see what happens if you plugin the
normal values into ioapic_i8259 for .pin and .apic (.pin is 0 or 2 and .apic is 0)
and see what happens.

Having a command line parameter that could do that would be a cheap temporary
solution.

But this is the most likely reason why the timer interrupt is not working.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
