Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IIpR8-0001RH-Uf
	for kexec@lists.infradead.org; Wed, 08 Aug 2007 13:35:15 -0400
Message-ID: <46B9FEC8.20004@fujitsu-siemens.com>
Date: Wed, 08 Aug 2007 19:35:04 +0200
From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: PATCH/RFC: [kdump] fix APIC shutdown sequence
References: <46B73955.2080007@fujitsu-siemens.com>	<20070807142928.GA18839@in.ibm.com>	<46B8AECA.7050908@fujitsu-siemens.com>	<m1ir7qg7kd.fsf@ebiederm.dsl.xmission.com>	<46B986D5.2010407@fujitsu-siemens.com>
	<m1myx2dpcc.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1myx2dpcc.fsf@ebiederm.dsl.xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Haren Myneni <hbabu@us.ibm.com>, "vgoyal@in.ibm.com" <vgoyal@in.ibm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Eric W. Biederman wrote:

> Ok.  Later in the thread it sounds like you have retried this and
> irqpoll is working now.

Yes. I'd give a lot to know what went wrong when I tried that in April.
It'd have saved me many hours of work if I had discovered this workaround
before.

>>> Have you done any looking at moving where the kernel initalizes
>>> io_apics?  One of the todo items on the path is to leave
>>> io_apic mode enabled and just startup the kernel in io_apic
>>> mode.
>> I have tried to recover from the "IRR set" situation in several ways by
>> changing setup_IO_APIC_irq(). But I haven't found a way to recover from
>> this situation once disable_IO_APIC() had been called.
> 
> Yes.  The long term goal is to remove the need for calling
> disable_IO_APIC(). Because that makes the code simpler etc.

I think a lot would be gained if disable_IO_APIC() would just mask the IRQs
(like the function in my patch does), and perhaps fix the dest ID, instead of
totally clearing the registers.

Moreover, it'd be reasonable to separate out the code that restores virtual
wire mode from disable_IO_APIC().

> It is quite possible.  I have observed a lot of obscure bugs in the
> corner cases of the state machines, although it is possible
> this is correct behavior and it is just specific to level
> triggered interrupts which are almost exclusively not on
> the first ioapic in a system like you describe.

Even if my patch in the form in which I submitted it is unusable,
I think the basic idea that IRQs should be masked bottom-up
(IO-APIC first, then local APIC, then CPU) is correct.

Or is there any specific reason why the current code does it vice-versa?

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
