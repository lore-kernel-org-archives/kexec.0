Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gDEwH-0005rx-F3
 for kexec@lists.infradead.org; Thu, 18 Oct 2018 20:30:39 +0000
Subject: Re: [PATCH 3/3] x86/quirks: Add parameter to clear MSIs early on boot
References: <20181018183721.27467-1-gpiccoli@canonical.com>
 <20181018183721.27467-3-gpiccoli@canonical.com>
 <6fd4e2d2-c0ac-b26d-9a14-0379b4421679@kernel.org>
 <12d6175b-7f09-872a-61c4-700e905579c7@canonical.com>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <50d84d48-eebf-ed91-8148-be727f76883f@kernel.org>
Date: Thu, 18 Oct 2018 16:30:22 -0400
MIME-Version: 1.0
In-Reply-To: <12d6175b-7f09-872a-61c4-700e905579c7@canonical.com>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Guilherme G. Piccoli" <gpiccoli@canonical.com>, linux-pci@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org
Cc: cascardo@canonical.com, andi@firstfloor.org, bhe@redhat.com, lukas@wunner.de, shan.gavin@linux.alibaba.com, kernel@gpiccoli.net, linux-kernel@vger.kernel.org, gavin.guo@canonical.com, ddstreet@canonical.com, mingo@redhat.com, bp@alien8.de, billy.olsen@canonical.com, mfo@canonical.com, hpa@zytor.com, bhelgaas@google.com, jay.vosburgh@canonical.com, tglx@linutronix.de, dyoung@redhat.com, fabiomirmar@canonical.com, vgoyal@redhat.com

On 10/18/2018 4:13 PM, Guilherme G. Piccoli wrote:
>> These kind of issues are usually fixed by fixing the network driver's
>> shutdown routine to ensure that MSI interrupts are cleared there.
> 
> Sinan, I'm not sure shutdown handlers for drivers are called in panic
> kexec (I remember of an old experiment I did, loading a kernel
> with "kexec -p" didn't trigger the handlers).

AFAIK, all shutdown (not remove) routines are called before launching the next
kernel even in crash scenario. It is not safe to start the new kernel while
hardware is doing a DMA to the system memory and triggering interrupts.

Shutdown routine in PCI core used to disable MSI/MSI-x on behalf of all
endpoints but it was later decided that this is the responsibility of the
endpoint driver.

commit fda78d7a0ead144f4b2cdb582dcba47911f4952c
Author: Prarit Bhargava <prarit@redhat.com>
Date:   Thu Jan 26 14:07:47 2017 -0500

     PCI/MSI: Stop disabling MSI/MSI-X in pci_device_shutdown()

     The pci_bus_type .shutdown method, pci_device_shutdown(), is called from
     device_shutdown() in the kernel restart and shutdown paths.

     Previously, pci_device_shutdown() called pci_msi_shutdown() and
     pci_msix_shutdown().  This disables MSI and MSI-X, which causes the device
     to fall back to raising interrupts via INTx.  But the driver is still bound
     to the device, it doesn't know about this change, and it likely doesn't
     have an INTx handler, so these INTx interrupts cause "nobody cared"
     warnings like this:

       irq 16: nobody cared (try booting with the "irqpoll" option)
       CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.2-1.el7_UNSUPPORTED.x86_64 #1
       Hardware name: Hewlett-Packard HP Z820 Workstation/158B, BIOS J63 v03.90 06/
       ...

     The MSI disabling code was added by d52877c7b1af ("pci/irq: let
     pci_device_shutdown to call pci_msi_shutdown v2") because a driver left MSI
     enabled and kdump failed because the kexeced kernel wasn't prepared to
     receive the MSI interrupts.

    Subsequent commits 1851617cd2da ("PCI/MSI: Disable MSI at enumeration even
     if kernel doesn't support MSI") and  e80e7edc55ba ("PCI/MSI: Initialize MSI
     capability for all architectures") changed the kexeced kernel to disable
     all MSIs itself so it no longer depends on the crashed kernel to clean up
     after itself.

     Stop disabling MSI/MSI-X in pci_device_shutdown().  This resolves the
     "nobody cared" unhandled IRQ issue above.  It also allows PCI serial
     devices, which may rely on the MSI interrupts, to continue outputting
     messages during reboot/shutdown.

     [bhelgaas: changelog, drop pci_msi_shutdown() and pci_msix_shutdown() calls
     altogether]
     Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=187351
     Signed-off-by: Prarit Bhargava <prarit@redhat.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
     CC: Alex Williamson <alex.williamson@redhat.com>
     CC: David Arcari <darcari@redhat.com>
     CC: Myron Stowe <mstowe@redhat.com>
     CC: Lukas Wunner <lukas@wunner.de>
     CC: Keith Busch <keith.busch@intel.com>
     CC: Mika Westerberg <mika.westerberg@linux.intel.com>



> 
> But this case is even worse, because the NICs were in PCI passthrough
> mode, using vfio. So, they were completely unaware of what happened
> in the host kernel.
> 
> Also, this is spec compliant - system reset events should guarantee the
> bits are cleared (although kexec is not exactly a system reset, it's
> similar)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
