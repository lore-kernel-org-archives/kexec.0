Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [2002:a646:1c45::1] (helo=ebiederm.dsl.xmission.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1IxWKp-0000Cw-9X
	for kexec@lists.infradead.org; Wed, 28 Nov 2007 23:28:51 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on boot
	cpu
References: <m1lk8jka8j.fsf@ebiederm.dsl.xmission.com>
	<474C64CB.7080004@redhat.com>
	<20071127194220.GG14887@hmsendeavour.rdu.redhat.com>
	<20071127200011.GA3703@redhat.com>
	<20071127222408.GH24223@one.firstfloor.org>
	<474CA733.9050908@redhat.com> <20071128153649.GC3192@redhat.com>
	<20071128160206.GA21286@hmsendeavour.rdu.redhat.com>
	<20071128190525.GD3192@redhat.com>
	<m1d4tudun5.fsf@ebiederm.dsl.xmission.com>
	<20071128210944.GA28236@hmsendeavour.rdu.redhat.com>
Date: Wed, 28 Nov 2007 16:27:43 -0700
In-Reply-To: <20071128210944.GA28236@hmsendeavour.rdu.redhat.com> (Neil
	Horman's message of "Wed, 28 Nov 2007 16:09:44 -0500")
Message-ID: <m18x4idk7k.fsf@ebiederm.dsl.xmission.com>
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

> On Wed, Nov 28, 2007 at 12:42:22PM -0700, Eric W. Biederman wrote:
>> Vivek Goyal <vgoyal@redhat.com> writes:
>> 
>> > Ok. Got it. So in this case we route the interrupts directly through LAPIC
>> > and put LVT0 in ExtInt mode and IOAPIC is bypassed.
>> >
>> > I am looking at Intel Multiprocessor specification v1.4 and as per figure
>> > 3-3 on page 3-9, 8259 is connected to LINTIN0 line, which in turn is 
>> > connected to LINTIN0 pin on all processors. If that is the case, even in
>> > this mode, all the CPU should see the timer interrupts (which is coming
>> > from 8259)?
>> 
>> However things are implemented completely differently now.  I don't think
>> the coherent hypertransport domain of AMD processors actually routes
>> ExtINT interrupts to all cpus but instead one (the default route?) is
>> picked.
>> 
>
> http://www.hypertransport.org/docs/tech/HTC20051222-0046-0008-Final-4-21-06.pdf
> Table 143 suggest to me that legacy interrupts should be routed to all cpus,
> which certainly doesn't seem to be the case in this situation.  Perhaps Nvidia
> goofed on that part of the specification?

Once it hits the coherent hypertransport fabric only AMD has control.
The packet does not have a destination field that could specify which
cpu.  So Nvidia could not have goofed.  It is a magic property of
the coherent hypertransport domain as which cpu gets it.


>> So I think for the kdump case we pretty much need to use an IOAPIC
>> in virtual wire mode for recent AMD systems.
>> 
>> For current Intel systems I believe either scenario still works.
>> 
>> > Can you print the LAPIC registers (print_local_APIC) during normal boot
>> > and during kdump boot and paste here?
>> 
>> It's worth a look.
>> 
>> I still think we need to just use apic mode at kernel startup, and
>> be done with it.
>> 
> Certainly, this seems like the best solution long term.
>
> So I'm looking at the implementation for 64 bit system, and it seems a little
> cleaner than 32 bit setup.  I'm wondering if we can just call setup_IO_APIC
> immediately after init_IRQ in start_kernel?  Could it be that straightforward?

Pretty much.

The essence of what I did last round was put at the end of
init_IRQ():


if (!disable_apic && cpu_has_apic) {
	/*
	 * Switch to APIC mode.
	 */
	setup_local_APIC();

	/*
	 * Now start the IO-APICs
	 */
	if (smp_found_config && !skip_ioapic_setup && nr_ioapics)
		setup_IO_APIC();
	else
		nr_ioapics = 0;
}

Beyond that it is just dotting i's and crossing t's.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
