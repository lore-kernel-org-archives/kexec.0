Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IIhRw-00012o-Dt
	for kexec@lists.infradead.org; Wed, 08 Aug 2007 05:03:30 -0400
Message-ID: <46B986D5.2010407@fujitsu-siemens.com>
Date: Wed, 08 Aug 2007 11:03:17 +0200
From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: PATCH/RFC: [kdump] fix APIC shutdown sequence
References: <46B73955.2080007@fujitsu-siemens.com>	<20070807142928.GA18839@in.ibm.com>	<46B8AECA.7050908@fujitsu-siemens.com>
	<m1ir7qg7kd.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1ir7qg7kd.fsf@ebiederm.dsl.xmission.com>
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

Hello Eric,

> How bad is it if you just run with irqpoll in the kdump kernel?
> If running with irqpoll is usable that is probably preferable
> to putting in a hardware work around we can survive without.

Yes, I tried that. No effect.

> Have you done any looking at moving where the kernel initalizes
> io_apics?  One of the todo items on the path is to leave
> io_apic mode enabled and just startup the kernel in io_apic
> mode.

I have tried to recover from the "IRR set" situation in several ways by
changing setup_IO_APIC_irq(). But I haven't found a way to recover from
this situation once disable_IO_APIC() had been called.
I concluded thatthe sequence of events
"send INT message - never receive EOI - disable IO-APIC pin"
messes up the IO-APIC (at least this specific one in the
PCIEx-PCI bridge of the ICH7).

The current state of affairs is that the only thing that "worked" was to
re-enable irqs.

> When doing that a version of your work around (if needed)
> would certainly be reasonable.

> My general concern is that the trickier we get in the code
> running in the crashed kernel the less reliable the entire
> process will be.

That's certainly correct. I am grateful for all hints that simplify my patch.

Thanks,
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
