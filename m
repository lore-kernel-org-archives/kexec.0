Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ebiederm.dsl.xmission.com ([166.70.28.69])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IInOM-0004wM-FR
	for kexec@lists.infradead.org; Wed, 08 Aug 2007 11:24:12 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: PATCH/RFC: [kdump] fix APIC shutdown sequence
References: <46B73955.2080007@fujitsu-siemens.com>
	<20070807142928.GA18839@in.ibm.com>
	<46B8AECA.7050908@fujitsu-siemens.com>
	<m1ir7qg7kd.fsf@ebiederm.dsl.xmission.com>
	<46B986D5.2010407@fujitsu-siemens.com>
Date: Wed, 08 Aug 2007 09:21:23 -0600
In-Reply-To: <46B986D5.2010407@fujitsu-siemens.com> (Martin Wilck's message of
	"Wed, 08 Aug 2007 11:03:17 +0200")
Message-ID: <m1myx2dpcc.fsf@ebiederm.dsl.xmission.com>
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
To: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Cc: Haren Myneni <hbabu@us.ibm.com>, "vgoyal@in.ibm.com" <vgoyal@in.ibm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Martin Wilck <martin.wilck@fujitsu-siemens.com> writes:

> Hello Eric,
>
>> How bad is it if you just run with irqpoll in the kdump kernel?
>> If running with irqpoll is usable that is probably preferable
>> to putting in a hardware work around we can survive without.
>
> Yes, I tried that. No effect.

Ok.  Later in the thread it sounds like you have retried this and
irqpoll is working now.  

>> Have you done any looking at moving where the kernel initalizes
>> io_apics?  One of the todo items on the path is to leave
>> io_apic mode enabled and just startup the kernel in io_apic
>> mode.
>
> I have tried to recover from the "IRR set" situation in several ways by
> changing setup_IO_APIC_irq(). But I haven't found a way to recover from
> this situation once disable_IO_APIC() had been called.

Yes.  The long term goal is to remove the need for calling
disable_IO_APIC(). Because that makes the code simpler etc.

Once we get the kernel to the point where it can start in
ioapic mode (and not in i8259 mode) we can remove the
disabled code from the kexec on panic path.

> I concluded thatthe sequence of events
> "send INT message - never receive EOI - disable IO-APIC pin"
> messes up the IO-APIC (at least this specific one in the
> PCIEx-PCI bridge of the ICH7).

It is quite possible.  I have observed a lot of obscure bugs in the
corner cases of the state machines, although it is possible
this is correct behavior and it is just specific to level
triggered interrupts which are almost exclusively not on
the first ioapic in a system like you describe.

I suspect the issue is that we never send the EOI message from
the local apic, and so it waits forever.  Or that we have
reprogrammed the vectors by the time we send the EOI message
so that the EOI and the ioapic don't agree on the vector
number when the  EOI message is sent.  Grumble silly level
triggered interrupts grumble.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
