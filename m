Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ke2KX-0007PF-7t
 for kexec@lists.infradead.org; Sat, 14 Nov 2020 20:39:30 +0000
Date: Sat, 14 Nov 2020 14:39:25 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
Message-ID: <20201114203925.GA1182595@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87d00gltb9.fsf@nanos.tec.linutronix.de>
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
Cc: linux-pci@vger.kernel.org, kernelfans@gmail.com, andi@firstfloor.org, hpa@zytor.com, bhe@redhat.com, x86@kernel.org, okaya@kernel.org, mingo@redhat.com, jay.vosburgh@canonical.com, dyoung@redhat.com, gavin.guo@canonical.com, Eric Biederman <ebiederm@xmission.com>, "Guilherme G. Piccoli" <gpiccoli@canonical.com>, bp@alien8.de, bhelgaas@google.com, shan.gavin@linux.alibaba.com, kernel@gpiccoli.net, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ddstreet@canonical.com, lukas@wunner.de, vgoyal@redhat.com

On Sat, Nov 14, 2020 at 12:40:10AM +0100, Thomas Gleixner wrote:
> Bjorn,
> 
> On Sat, Nov 14 2020 at 00:31, Thomas Gleixner wrote:
> > On Fri, Nov 13 2020 at 10:46, Bjorn Helgaas wrote:
> >> pci_device_shutdown() still clears the Bus Master Enable bit if we're
> >> doing a kexec and the device is in D0-D3hot, which should also disable
> >> MSI/MSI-X.  Why doesn't this solve the problem?  Is this because the
> >> device causing the storm was in PCI_UNKNOWN state?
> >
> > That's indeed a really good question.
> 
> So we do that on kexec, but is that true when starting a kdump kernel
> from a kernel crash? I doubt it.

Ah, right, I bet that's it, thanks.  The kdump path is basically this:

  crash_kexec
    machine_kexec

while the usual kexec path is:

  kernel_kexec
    kernel_restart_prepare
      device_shutdown
        while (!list_empty(&devices_kset->list))
          dev->bus->shutdown
            pci_device_shutdown            # pci_bus_type.shutdown
    machine_kexec

So maybe we need to explore doing some or all of device_shutdown() in
the crash_kexec() path as well as in the kernel_kexec() path.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
