Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kf9QO-0003LO-7v
 for kexec@lists.infradead.org; Tue, 17 Nov 2020 22:26:09 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20201117001907.GA1342260@bjorn-Precision-5520>
 <87h7poeqqn.fsf@x220.int.ebiederm.org>
 <873618xqaa.fsf@nanos.tec.linutronix.de>
 <f0d35834054cc1ac77ac0e6b68e84d62de3c48f7.camel@infradead.org>
 <87wnyjwzeo.fsf@nanos.tec.linutronix.de>
Date: Tue, 17 Nov 2020 16:25:23 -0600
In-Reply-To: <87wnyjwzeo.fsf@nanos.tec.linutronix.de> (Thomas Gleixner's
 message of "Tue, 17 Nov 2020 20:34:23 +0100")
Message-ID: <87blfv7h9o.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Guowen Shan <gshan@redhat.com>, linux-pci@vger.kernel.org, kernelfans@gmail.com, andi@firstfloor.org, hpa@zytor.com, bhe@redhat.com, x86@kernel.org, okaya@kernel.org, mingo@redhat.com, Bjorn Helgaas <helgaas@kernel.org>, jay.vosburgh@canonical.com, dyoung@redhat.com, gavin.guo@canonical.com, "Guilherme G. Piccoli" <gpiccoli@canonical.com>, bp@alien8.de, bhelgaas@google.com, kexec@lists.infradead.org, kernel@gpiccoli.net, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, ddstreet@canonical.com, lukas@wunner.de, vgoyal@redhat.com, David Woodhouse <dwmw2@infradead.org>

Thomas Gleixner <tglx@linutronix.de> writes:

> On Tue, Nov 17 2020 at 12:19, David Woodhouse wrote:
>> On Tue, 2020-11-17 at 10:53 +0100, Thomas Gleixner wrote:
>>> But that does not solve the problem either simply because then the IOMMU
>>> will catch the rogue MSIs and you get an interrupt storm on the IOMMU
>>> error interrupt.
>>
>> Not if you can tell the IOMMU to stop reporting those errors.
>>
>> We can easily do it per-device for DMA errors; not quite sure what
>> granularity we have for interrupts. Perhaps the Intel IOMMU only lets
>> you set the Fault Processing Disable bit per IRTE entry, and you still
>> get faults for Compatibility Format interrupts? Not sure about AMD...
>
> It looks like the fault (DMAR) and event (AMD) interrupts can be
> disabled in the IOMMU. That might help to bridge the gap until the PCI
> bus is scanned in full glory and the devices can be shut up for real.
>
> If we make this conditional for a crash dump kernel that might do the
> trick.
>
> Lot's of _might_ there :)

Worth testing.

Folks tracking this down is this enough of a hint for you to write a
patch and test?

Also worth checking how close irqpoll is to handling a case like this.
At least historically it did a pretty good job at shutting down problem
interrupts.

I really find it weird that an edge triggered irq was firing fast enough
to stop a system from booting.  Level triggered irqs do that if they are
acknolwedged without actually being handled.  I think edge triggered
irqs only fire when another event comes in, and it seems odd to get so
many actual events causing interrupts that the system soft locks
up.  Is my memory of that situation confused?

I recommend making these facilities general debug facilities so that
they can be used for cases other than crash dump.  The crash dump kernel
would always enable them because it can assume that the hardware is
very likely in a wonky state.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
