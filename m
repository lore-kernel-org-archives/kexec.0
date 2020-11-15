Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([193.142.43.55])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1keJgx-0001Oh-FD
 for kexec@lists.infradead.org; Sun, 15 Nov 2020 15:11:48 +0000
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
In-Reply-To: <87sg9almmg.fsf@x220.int.ebiederm.org>
References: <20201114212215.GA1194074@bjorn-Precision-5520>
 <87v9e6n2b2.fsf@x220.int.ebiederm.org> <87sg9almmg.fsf@x220.int.ebiederm.org>
Date: Sun, 15 Nov 2020 16:11:43 +0100
Message-ID: <874klqac40.fsf@nanos.tec.linutronix.de>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, kernelfans@gmail.com, andi@firstfloor.org, hpa@zytor.com, bhe@redhat.com, x86@kernel.org, okaya@kernel.org, mingo@redhat.com, jay.vosburgh@canonical.com, dyoung@redhat.com, vgoyal@redhat.com, "Guilherme G. Piccoli" <gpiccoli@canonical.com>, bp@alien8.de, bhelgaas@google.com, shan.gavin@linux.alibaba.com, kexec@lists.infradead.org, kernel@gpiccoli.net, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, ddstreet@canonical.com, lukas@wunner.de, gavin.guo@canonical.com

On Sun, Nov 15 2020 at 08:29, Eric W. Biederman wrote:
> ebiederm@xmission.com (Eric W. Biederman) writes:
> For ordinary irqs you can have this with level triggered irqs
> and the kernel has code that will shutdown the irq at the ioapic
> level.  Then the kernel continues by polling the irq source.
>
> I am still missing details but my first question is can our general
> solution to screaming level triggered irqs apply?

No.

> How can edge triggered MSI irqs be screaming?
>
> Is there something we can do in enabling the APICs or IOAPICs that
> would allow this to be handled better.  My memory when we enable
> the APICs and IOAPICs we completely clear the APIC entries and so
> should be disabling sources.

Yes, but MSI has nothing to do with APIC/IOAPIC

> Is the problem perhaps that we wind up using an APIC entry that was
> previously used for the MSI interrupt as something else when we
> reprogram them?  Even with this why doesn't the generic code
> to stop screaming irqs apply here?

Again. No. The problem cannot be solved at the APIC level. The APIC is
the receiving end of MSI and has absolutely no control over it.

An MSI interrupt is a (DMA) write to the local APIC base address
0xfeexxxxx which has the target CPU and control bits encoded in the
lower bits. The written data is the vector and more control bits.

The only way to stop that is to shut it up at the PCI device level.

Assume the following situation:

  - PCI device has MSI enabled and a valid target vector assigned

  - Kernel crashes

  - Kdump kernel starts

  - PCI device raises interrupts which result in the MSI write

  - Kdump kernel enables interrupts and the pending vector is raised in
    the CPU.

  - The CPU has no interrupt descriptor assigned to the vector
    and does not even know where the interrupt originated from. So it
    treats it like any other spurious interrupt to an unassigned vector,
    emits a ratelimited message and ACKs the interrupt at the APIC.

  - PCI device behaves stupid and reraises the interrupt for whatever
    reason.

  - Lather, rinse and repeat.

Unfortunately there is no way to tell the APIC "Mask vector X" and the
dump kernel does neither know which device it comes from nor does it
have enumerated PCI completely which would reset the device and shutup
the spew. Due to the interrupt storm it does not get that far.

Thanks,

        tglx

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
