Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([193.142.43.55])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kdiXA-0001IF-UL
 for kexec@lists.infradead.org; Fri, 13 Nov 2020 23:31:14 +0000
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
In-Reply-To: <20201113164638.GA1019448@bjorn-Precision-5520>
References: <20201113164638.GA1019448@bjorn-Precision-5520>
Date: Sat, 14 Nov 2020 00:31:09 +0100
Message-ID: <87ft5cltqa.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
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
To: Bjorn Helgaas <helgaas@kernel.org>, "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc: kernel@gpiccoli.net, andi@firstfloor.org, bhe@redhat.com, lukas@wunner.de, shan.gavin@linux.alibaba.com, linux-pci@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kernelfans@gmail.com, ddstreet@canonical.com, mingo@redhat.com, bp@alien8.de, gavin.guo@canonical.com, hpa@zytor.com, bhelgaas@google.com, jay.vosburgh@canonical.com, okaya@kernel.org, dyoung@redhat.com, vgoyal@redhat.com

Bjorn,

On Fri, Nov 13 2020 at 10:46, Bjorn Helgaas wrote:
> On Fri, Nov 06, 2020 at 10:14:14AM -0300, Guilherme G. Piccoli wrote:
>> On 23/10/2018 14:03, Bjorn Helgaas wrote:
> I guess Thomas' patch [2] (from thread [1]) doesn't solve this
> problem?

No. As I explained in [1] patch from [2] cannot solve it because the
patch from [2] which is what Liu was trying to solve requires that there
is a registered interrupt handler which knows how to shut up the
interrupt.

> I think [0] proposes using early_quirks() to disable MSIs at
> boot-time.  That doesn't seem like a robust solution because (a) the
> problem affects all arches but early_quirks() is x86-specific and (b)
> even on x86 early_quirks() only works for PCI segment 0 because it
> relies on the 0xCF8/0xCFC I/O ports.
>
> If I understand Thomas' email correctly, the IRQ storm occurs here:
>
>   start_kernel
>     setup_arch
>       early_quirks               # x86-only
>         ...
>           read_pci_config_16(num, slot, func, PCI_VENDOR_ID)
>             outl(..., 0xcf8)     # PCI segment 0 only
>             inw(0xcfc)
>     local_irq_enable
>       ...
>         native_irq_enable
>           asm("sti")             # <-- enable IRQ, storm occurs
>
> native_irq_enable() happens long before we discover PCI host bridges
> and run the normal PCI quirks, so those would be too late to disable
> MSIs.

Correct.

> It doesn't seem practical to disable MSIs in the kdump kernel at the
> PCI level.  I was hoping we could disable them somewhere in the IRQ
> code, e.g., at IOAPICs, but I think Thomas is saying that's not
> feasible.

MSIs are not even going near the IOAPIC and as long as the interrupt
core does not have an interrupt set up for the device is has no idea
where to look at to shut it down. Actually it does not even reach the
interrupt core. The raised vector arrives at the CPU and the low level
code sees: No handler associated, ignore it. We cannot do anything from
the low level code because all we know is that the vector was raised,
but we have absolutely zero clue where that came from. At that point the
IO-APIC interrupts are definitely not the problem because they are all
disabled.

> It seems like the only option left is to disable MSIs before the
> kexec.  We used to clear the MSI/MSI-X Enable bits in
> pci_device_shutdown(), but that broke console devices that relied on
> MSI and caused "nobody cared" warnings when the devices fell back to
> using INTx, so fda78d7a0ead ("PCI/MSI: Stop disabling MSI/MSI-X in
> pci_device_shutdown()") left them unchanged.

That might be solvable because INTx arrives at the IO-APIC and we could
mask all the INTx related IO-APIC lines, but that's icky because of
this:

> pci_device_shutdown() still clears the Bus Master Enable bit if we're
> doing a kexec and the device is in D0-D3hot, which should also disable
> MSI/MSI-X.  Why doesn't this solve the problem?  Is this because the
> device causing the storm was in PCI_UNKNOWN state?

That's indeed a really good question.

Thanks,

        tglx

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
