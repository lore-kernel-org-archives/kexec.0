Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SPg6U-0006T2-3t
 for kexec@lists.infradead.org; Wed, 02 May 2012 20:24:50 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1330546129-4812-1-git-send-email-dzickus@redhat.com>
 <20120315202652.GA13930@redhat.com>
 <5C4C569E8A4B9B42A84A977CF070A35B2E31C6F859@USINDEVS01.corp.hds.com>
 <20120430205354.GA32472@redhat.com>
 <5C4C569E8A4B9B42A84A977CF070A35B2E4D461583@USINDEVS01.corp.hds.com>
 <87vckemkyt.fsf@xmission.com> <20120502195919.GU32472@redhat.com>
Date: Wed, 02 May 2012 13:24:35 -0700
In-Reply-To: <20120502195919.GU32472@redhat.com> (Don Zickus's message of
 "Wed, 2 May 2012 15:59:19 -0400")
Message-ID: <8762cel4ak.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH] x86, kdump: No need to disable ioapic in crash path
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Don Zickus <dzickus@redhat.com>
Cc: Seiji Aguchi <seiji.aguchi@hds.com>, kexec-list <kexec@lists.infradead.org>, "x86@kernel.org" <x86@kernel.org>, Vivek Goyal <vgoyal@redhat.com>, LKML <linux-kernel@vger.kernel.org>

Don Zickus <dzickus@redhat.com> writes:

> On Wed, May 02, 2012 at 12:39:06PM -0700, Eric W. Biederman wrote:
>> Seiji Aguchi <seiji.aguchi@hds.com> writes:
>> 
>> >> Perhaps calling setup_IO_APIC before setup_local_APIC would be a better fix?
>> >
>> > I checked Intel develper's manual and there is no restriction about the order of enabling IO_APIC/local_APIC.
>> > So, it may work.
>> >
>> > But, I don't understand why we have to change the stable boot-up code.
>> 
>> Because the boot-up code is buggy.  We need to get a better handle on
>> how it is buggy but apparently an interrupt coming in at the wrong
>> moment while booting with interrupts on the interrupt flag on the cpus
>> disalbed puts us in a state where we fail to boot.
>> 
>> We should be able to boot with apics enabled, and we almost can
>> emperically there are a few bugs.
>> 
>> The kdump path is particularly good at finding bugs.
>> 
>> > If kdump disables both local_apic and IO_APIC in proper way in 1st kernel,  2nd kernel works without any change.
>> 
>> We can not guarnatee disabling the local apics in the first kernel.
>> 
>> Ultimately the less we do in the first kernel the more reliable kdump is
>> going to be.  Disabling the apics has been a long standing bug work
>> around.
>> 
>> At worst we may have been a smidge premature in using assuming the
>> kernel can boot with the apics enabled but it I would hope we can
>> track down and fix the boot up code.
>> 
>> Probably what we want to do is not to disable the I/O apics but
>> to program the I/O apics before we enable the local apic so that
>> we have control of the in-comming interrupts.  But I haven't
>> looked at this in nearly enough detail to even guess what needs
>> to happen.
>
> Hi Eric,
>
> Thanks for the info.  I have don't have a problem with what you say above,
> I think that is a noble effort worth pursuing.  From a high level
> perspective, I am trying to understand how that is supposed to be
> acheived.  Getting the code to match the theory is probably easier to do
> than throw random patches/hacks at various kdump problems as they
> arise.

The very basic theory is:

--- Prepare to handle a crash (load kdump kernel etc)

panic.
locally disable interrupts
do things that can only be done in the panicing kernel
jump to purgatory

It is pretty clear from Peter Anvin's comments that we can perform a
generic nmi disable in the panicing kernel just by disabling nmi's
handling in the local apic.  We need to confirm that but it sounds
like a single write.

We shoot down other cpus in a best effort in the crashing kernel because
that is the only way we can possibly get their cpu registers.

> (this leaves apics and virt stuff untouched?)

We have to disable virt stuff because you can't change cpu modes with
virt stuff enabled (trying causes faults).  But disabling the virt stuff
is just a register write.

> 2nd kernel:
>
> normal early boot stuff
> setup memory
> setup scheduler
> ...
> program ioapic/lapic??
>    #currently this is down _after_ boot cpu interrupts are enabled
>    #which seem problematic if you have leftover screaming interrupts
>    #probably a reason for this like timers or something

Yes, we need to figure out how to deal with screaming interrupts in
this stage.  I have not long ago disabled msi interrupts at pci bus
scan time for a similar reason.  The msi interrupts I encountered were
not technically screaming but I did encounter one that was firing ever
couple of microseconds which is effectively the same as screaming.

Basically I don't particularly care how we do this so long as the
screamming or rapid fire interrupts don't stop the boot.

> enable boot cpu interrupts
> setup boot cpu
> setup other cpus
> ....

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
