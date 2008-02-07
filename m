Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ebiederm.dsl.xmission.com ([166.70.28.69])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JMuj8-0003WJ-50
	for kexec@lists.infradead.org; Thu, 07 Feb 2008 00:35:00 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH],
	issue EOI to APIC prior to calling crash_kexec in die_nmi path
References: <20080206192555.GA24910@hmsendeavour.rdu.redhat.com>
	<20080206220001.GA15155@elte.hu> <20080206224805.GD11886@redhat.com>
	<47AA3B16.7000507@zytor.com> <20080206233657.GB12393@elte.hu>
Date: Wed, 06 Feb 2008 17:31:11 -0700
In-Reply-To: <20080206233657.GB12393@elte.hu> (Ingo Molnar's message of "Thu, 
	7 Feb 2008 00:36:57 +0100")
Message-ID: <m1r6fpd2uo.fsf@ebiederm.dsl.xmission.com>
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
To: Ingo Molnar <mingo@elte.hu>
Cc: Neil Horman <nhorman@tuxdriver.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, "H. Peter Anvin" <hpa@zytor.com>, tglx@linutronix.de, Vivek Goyal <vgoyal@redhat.com>

Ingo Molnar <mingo@elte.hu> writes:

> * H. Peter Anvin <hpa@zytor.com> wrote:
>
>>> I am wondering if interrupts are disabled on crashing cpu or if 
>>> crashing cpu is inside die_nmi(), how would it stop/prevent delivery 
>>> of NMI IPI to other cpus.
>>
>> I don't see how it would.
>
> cross-CPU IPIs are a bit fragile on some PC platforms. So if the kexec 
> code relies on getting IPIs to all other CPUs, it might not be able to 
> do it reliably. There might be limitations on how many APIC irqs there 
> can be queued at a time, and if those slots are used up and the CPU is 
> not servicing irqs then stuff gets retried. This might even affect NMIs 
> sent via APIC messages - not sure about that.



The design was as follows:
- Doing anything in the crashing kernel is unreliable.
- We do not have the information to do anything useful in the recovery/target
  kernel.
- Having the other cpus stopped is very nice as it reduces the amount of
  weirdness happening.  We do not share the same text or data addresses
  so stopping the other cpus is not mandatory.  On some other architectures
  there are cpu tables that must live at a fixed address but this is not
  the case on x86.
- Having the location the other cpus were running at is potentially very
  interesting debugging information.

Therefore the intent of the code is to send an NMI to each other cpu.  With
a timeout of a second or so.  So that if the NMI do not get sent we continue
on.

There is certainly still room for improving the robustness by not shutting
down the ioapics and using less general infrastructure code on that path.
That said I would be a little surprised if that is what is biting us.

Looking at the patch the local_irq_enable() is totally bogus.  As soon
was we hit machine_crash_shutdown the first thing we do is disable irqs.

I'm wondering if someone was using the switch cpus on crash patch that was
floating around.  That would require the ipis to work.

I don't know if nmi_exit makes sense.  There are enough layers of abstraction
in that piece of code I can't quickly spot the part that is banging the hardware.

The location of nmi_exit in the patch is clearly wrong.  crash_kexec is a noop
if we don't have a crash kernel loaded (and if we are not the first cpu into it),
so if we don't execute the crash code something weird may happen.  Further the
code is just more maintainable if that kind of code lives in machine_crash_shutdown.



Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
