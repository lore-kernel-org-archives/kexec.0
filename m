Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1keJ26-00005E-Bg
 for kexec@lists.infradead.org; Sun, 15 Nov 2020 14:29:35 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20201114212215.GA1194074@bjorn-Precision-5520>
 <87v9e6n2b2.fsf@x220.int.ebiederm.org>
Date: Sun, 15 Nov 2020 08:29:11 -0600
In-Reply-To: <87v9e6n2b2.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
 message of "Sun, 15 Nov 2020 08:05:05 -0600")
Message-ID: <87sg9almmg.fsf@x220.int.ebiederm.org>
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
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, kernelfans@gmail.com, andi@firstfloor.org, hpa@zytor.com, bhe@redhat.com, x86@kernel.org, okaya@kernel.org, mingo@redhat.com, jay.vosburgh@canonical.com, dyoung@redhat.com, gavin.guo@canonical.com, "Guilherme G. Piccoli" <gpiccoli@canonical.com>, bp@alien8.de, bhelgaas@google.com, Thomas Gleixner <tglx@linutronix.de>, shan.gavin@linux.alibaba.com, kexec@lists.infradead.org, kernel@gpiccoli.net, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, ddstreet@canonical.com, lukas@wunner.de, vgoyal@redhat.com

ebiederm@xmission.com (Eric W. Biederman) writes:

> Bjorn Helgaas <helgaas@kernel.org> writes:
>
>> [+cc Rafael for question about ACPI method for PCI host bridge reset]
>>
>> On Sat, Nov 14, 2020 at 09:58:08PM +0100, Thomas Gleixner wrote:
>>> On Sat, Nov 14 2020 at 14:39, Bjorn Helgaas wrote:
>>> > On Sat, Nov 14, 2020 at 12:40:10AM +0100, Thomas Gleixner wrote:
>>> >> On Sat, Nov 14 2020 at 00:31, Thomas Gleixner wrote:
>>> >> > On Fri, Nov 13 2020 at 10:46, Bjorn Helgaas wrote:
>>> >> >> pci_device_shutdown() still clears the Bus Master Enable bit if we're
>>> >> >> doing a kexec and the device is in D0-D3hot, which should also disable
>>> >> >> MSI/MSI-X.  Why doesn't this solve the problem?  Is this because the
>>> >> >> device causing the storm was in PCI_UNKNOWN state?
>>> >> >
>>> >> > That's indeed a really good question.
>>> >> 
>>> >> So we do that on kexec, but is that true when starting a kdump kernel
>>> >> from a kernel crash? I doubt it.
>>> >
>>> > Ah, right, I bet that's it, thanks.  The kdump path is basically this:
>>> >
>>> >   crash_kexec
>>> >     machine_kexec
>>> >
>>> > while the usual kexec path is:
>>> >
>>> >   kernel_kexec
>>> >     kernel_restart_prepare
>>> >       device_shutdown
>>> >         while (!list_empty(&devices_kset->list))
>>> >           dev->bus->shutdown
>>> >             pci_device_shutdown            # pci_bus_type.shutdown
>>> >     machine_kexec
>>> >
>>> > So maybe we need to explore doing some or all of device_shutdown() in
>>> > the crash_kexec() path as well as in the kernel_kexec() path.
>>> 
>>> The problem is that if the machine crashed anything you try to attempt
>>> before starting the crash kernel is reducing the chance that the crash
>>> kernel actually starts.
>>
>> Right.
>>
>>> Is there something at the root bridge level which allows to tell the
>>> underlying busses to shut up, reset or go into a defined state? That
>>> might avoid chasing lists which might be already unreliable.
>>
>> Maybe we need some kind of crash_device_shutdown() that does the
>> minimal thing to protect the kdump kernel from devices.
>
> The kdump kernel does not use any memory the original kernel uses.
> Which should be a minimal and fairly robust level of protection
> until the device drivers can be loaded and get ahold of things.
>
>> The programming model for conventional PCI host bridges and PCIe Root
>> Complexes is device-specific since they're outside the PCI domain.
>> There probably *are* ways to do those things, but you would need a
>> native host bridge driver or something like an ACPI method.  I'm not
>> aware of an ACPI way to do this, but I added Rafael in case he is.
>>
>> A crash_device_shutdown() could do something at the host bridge level
>> if that's possible, or reset/disable bus mastering/disable MSI/etc on
>> individual PCI devices if necessary.
>
> Unless I am confused DMA'ing to memory that is not already in use
> is completely broken wether or not you are using the kdump kernel.

Bah.  I was confused because I had not read up-thread.

MSI mixes DMA and irqs so confusion is easy.

So the problem is screaming irqs when the kernel is booting up.
This is a fundamentally tricky problem.

For ordinary irqs you can have this with level triggered irqs
and the kernel has code that will shutdown the irq at the ioapic
level.  Then the kernel continues by polling the irq source.

I am still missing details but my first question is can our general
solution to screaming level triggered irqs apply?

How can edge triggered MSI irqs be screaming?

Is there something we can do in enabling the APICs or IOAPICs that
would allow this to be handled better.  My memory when we enable
the APICs and IOAPICs we completely clear the APIC entries and so
should be disabling sources.

Is the problem perhaps that we wind up using an APIC entry that was
previously used for the MSI interrupt as something else when we
reprogram them?  Even with this why doesn't the generic code
to stop screaming irqs apply here?

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
