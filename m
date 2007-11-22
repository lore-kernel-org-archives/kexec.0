Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [2002:a646:1c45::1] (helo=ebiederm.dsl.xmission.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1IvIJ3-000792-Oz
	for kexec@lists.infradead.org; Thu, 22 Nov 2007 15:05:50 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Timer interrupt lost on some x86_64 systems
References: <20071107140006.GC14371@hmsendeavour.rdu.redhat.com>
	<20071112044903.GA6433@in.ibm.com>
	<20071112151721.GB11751@hmsendeavour.rdu.redhat.com>
	<20071112154119.GC11751@hmsendeavour.rdu.redhat.com>
	<20071113073128.GB24067@in.ibm.com>
	<20071113143330.GA16830@hmsendeavour.rdu.redhat.com>
	<20071114063939.GA4349@in.ibm.com>
	<20071114115132.GA21411@hmsendeavour.rdu.redhat.com>
Date: Thu, 22 Nov 2007 13:04:38 -0700
In-Reply-To: <20071114115132.GA21411@hmsendeavour.rdu.redhat.com> (Neil
	Horman's message of "Wed, 14 Nov 2007 06:51:32 -0500")
Message-ID: <m163zuoxm1.fsf@ebiederm.dsl.xmission.com>
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
Cc: Vivek Goyal <vgoyal@in.ibm.com>, kexec@lists.infradead.org

Neil Horman <nhorman@redhat.com> writes:

> On Wed, Nov 14, 2007 at 12:09:39PM +0530, Vivek Goyal wrote:
>> On Tue, Nov 13, 2007 at 09:33:30AM -0500, Neil Horman wrote:
>> 
>> [..]
>> > > In the past I have found issues with interrupt routing on IOPAPIC and
>> > > interrupt lockup on LAPIC. But these issues are already solved. I would
>> > > also think of priting LAPIC and IOAPIC entries to see how timer interrupt
>> > > routing changes from first kernel to second.
>> > > 
>> > I recently read the ioapic section in the opteron processor guide and noted
> the
>> > ioapic routing field in the config registers, so I'll be looking at that.
> We
>> > also not that in the failing case on the systems in question the boot cpu is
>> > _not_ the cpu that boots the kdump kernel, and its APIC ID is 1 not 0, IIRC
>> > 
>> 
>> Failing on non-boot cpu should not be an issue. I had fixed an issue in the
>> past where non-boot cpu was not receiving the timer interrupts because of
>> IOAPIC settings where timer interrupts were always routed to boot cpu (cpu0).
>> 
>> Now it has been modified and while going down we determine which cpu we
>> are crashing on and setup IOAPIC entry accordingly. See disable_IO_APIC().
>> 
>
> I see the call to it in machine_crash_shutdown, but for whatever reason, it
> doesn't seem to be having the desired effect in this case....hmmmmm...

I don't know if anything has happened.  However a lot of this looks like
going back to the current todo list item of getting the kernel to come up
initially in ioapic mode.

That simultaneously removes the need for machine_kexec to reprogram interrupts
in virtual wire mode and it should ultimately simplify and make more robust
irq initialization.  At the very least reducing the amount of magic in
early irq processing.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
