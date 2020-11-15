Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1keOvP-0006m0-H6
 for kexec@lists.infradead.org; Sun, 15 Nov 2020 20:47:06 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20201114212215.GA1194074@bjorn-Precision-5520>
 <87v9e6n2b2.fsf@x220.int.ebiederm.org>
 <87sg9almmg.fsf@x220.int.ebiederm.org>
 <874klqac40.fsf@nanos.tec.linutronix.de>
Date: Sun, 15 Nov 2020 14:46:38 -0600
In-Reply-To: <874klqac40.fsf@nanos.tec.linutronix.de> (Thomas Gleixner's
 message of "Sun, 15 Nov 2020 16:11:43 +0100")
Message-ID: <87lff2ic0h.fsf@x220.int.ebiederm.org>
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
Cc: linux-pci@vger.kernel.org, kernelfans@gmail.com, andi@firstfloor.org, hpa@zytor.com, bhe@redhat.com, x86@kernel.org, okaya@kernel.org, mingo@redhat.com, Bjorn Helgaas <helgaas@kernel.org>, jay.vosburgh@canonical.com, dyoung@redhat.com, gavin.guo@canonical.com, "Guilherme G. Piccoli" <gpiccoli@canonical.com>, bp@alien8.de, bhelgaas@google.com, shan.gavin@linux.alibaba.com, kexec@lists.infradead.org, kernel@gpiccoli.net, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, ddstreet@canonical.com, lukas@wunner.de, vgoyal@redhat.com

Thomas Gleixner <tglx@linutronix.de> writes:

> On Sun, Nov 15 2020 at 08:29, Eric W. Biederman wrote:
>> ebiederm@xmission.com (Eric W. Biederman) writes:
>> For ordinary irqs you can have this with level triggered irqs
>> and the kernel has code that will shutdown the irq at the ioapic
>> level.  Then the kernel continues by polling the irq source.
>>
>> I am still missing details but my first question is can our general
>> solution to screaming level triggered irqs apply?
>
> No.
>
>> How can edge triggered MSI irqs be screaming?
>>
>> Is there something we can do in enabling the APICs or IOAPICs that
>> would allow this to be handled better.  My memory when we enable
>> the APICs and IOAPICs we completely clear the APIC entries and so
>> should be disabling sources.
>
> Yes, but MSI has nothing to do with APIC/IOAPIC

Yes, sorry.  It has been long enough that the details were paged out
of my memory.

>> Is the problem perhaps that we wind up using an APIC entry that was
>> previously used for the MSI interrupt as something else when we
>> reprogram them?  Even with this why doesn't the generic code
>> to stop screaming irqs apply here?
>
> Again. No. The problem cannot be solved at the APIC level. The APIC is
> the receiving end of MSI and has absolutely no control over it.
>
> An MSI interrupt is a (DMA) write to the local APIC base address
> 0xfeexxxxx which has the target CPU and control bits encoded in the
> lower bits. The written data is the vector and more control bits.
>
> The only way to stop that is to shut it up at the PCI device level.

Or to write to magic chipset registers that will stop transforming DMA
writes to 0xfeexxxxx into x86 interrupts.  With an IOMMU I know x86 has
such registers (because the point of the IOMMU is to limit the problems
rogue devices can cause).  Without an IOMMU I don't know if x86 has any
such registers.  I remember that other platforms have an interrupt
controller that does provide some level of control.  That x86 does not
is what makes this an x86 specific problem.

The generic solution is to have the PCI code set bus master disables
when it is enumerationg and initializing devices.  Last time I was
paying attention that was actually the policy of the pci layer and
drivers that did not enable bus mastering were considered buggy.

Looking at patch 3/3 what this patchset does is an early disable of
of the msi registers.  Which is mostly reasonable.  Especially as has
been pointed out the only location the x86 vector and x86 cpu can
be found is in the msi configuration registers.

That also seems reasonable.  But Bjorn's concern about not finding all
devices in all domains does seem real.

There are a handful of devices where the Bus master disable bit doesn't
disable bus mastering.  I wonder if there are devices where MSI and MSIX
disables don't fully work.  It seems completely possible to have MSI or
MSIX equivalent registers at a non-standard location as drivers must be
loaded to handle them.

So if we can safely and reliably disable DMA and MSI at the generic PCI
device level during boot up I am all for it.


How difficult would it be to tell the IOMMUs to stop passing traffic
through in an early pci quirk?  The problem setup was apparently someone
using the device directly from a VM.  So I presume there is an IOMMU
in that configuration.

> Unfortunately there is no way to tell the APIC "Mask vector X" and the
> dump kernel does neither know which device it comes from nor does it
> have enumerated PCI completely which would reset the device and shutup
> the spew. Due to the interrupt storm it does not get that far.

So the question is how do we make this robust?

Can we perhaps disable all interrupts in this case and limp along
in polling mode until the pci bus has been enumerated?

It is nice and desirable to be able to use the hardware in high
performance mode in a kexec-on-panic situation but if we can detect a
problem and figure out how to limp along sometimes that is acceptable.

The failure mode in the kexec-on-panic kernel is definitely the corect
one.  We could not figure out how to wrestle the hardware into usability
so we fail to take a crash dump or do anything else that might corrupt
the system.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
