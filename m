Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([193.142.43.55])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kf6kE-0000q8-0V
 for kexec@lists.infradead.org; Tue, 17 Nov 2020 19:34:26 +0000
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
In-Reply-To: <f0d35834054cc1ac77ac0e6b68e84d62de3c48f7.camel@infradead.org>
References: <20201117001907.GA1342260@bjorn-Precision-5520>
 <87h7poeqqn.fsf@x220.int.ebiederm.org>
 <873618xqaa.fsf@nanos.tec.linutronix.de>
 <f0d35834054cc1ac77ac0e6b68e84d62de3c48f7.camel@infradead.org>
Date: Tue, 17 Nov 2020 20:34:23 +0100
Message-ID: <87wnyjwzeo.fsf@nanos.tec.linutronix.de>
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
To: David Woodhouse <dwmw2@infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Guowen Shan <gshan@redhat.com>, linux-pci@vger.kernel.org, kernelfans@gmail.com, andi@firstfloor.org, hpa@zytor.com, bhe@redhat.com, x86@kernel.org, okaya@kernel.org, mingo@redhat.com, jay.vosburgh@canonical.com, dyoung@redhat.com, vgoyal@redhat.com, "Guilherme G. Piccoli" <gpiccoli@canonical.com>, bp@alien8.de, bhelgaas@google.com, kexec@lists.infradead.org, kernel@gpiccoli.net, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, ddstreet@canonical.com, lukas@wunner.de, gavin.guo@canonical.com

On Tue, Nov 17 2020 at 12:19, David Woodhouse wrote:
> On Tue, 2020-11-17 at 10:53 +0100, Thomas Gleixner wrote:
>> But that does not solve the problem either simply because then the IOMMU
>> will catch the rogue MSIs and you get an interrupt storm on the IOMMU
>> error interrupt.
>
> Not if you can tell the IOMMU to stop reporting those errors.
>
> We can easily do it per-device for DMA errors; not quite sure what
> granularity we have for interrupts. Perhaps the Intel IOMMU only lets
> you set the Fault Processing Disable bit per IRTE entry, and you still
> get faults for Compatibility Format interrupts? Not sure about AMD...

It looks like the fault (DMAR) and event (AMD) interrupts can be
disabled in the IOMMU. That might help to bridge the gap until the PCI
bus is scanned in full glory and the devices can be shut up for real.

If we make this conditional for a crash dump kernel that might do the
trick.

Lot's of _might_ there :)

Thanks

        tglx






_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
