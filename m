Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1keoiE-00019k-D0
 for kexec@lists.infradead.org; Tue, 17 Nov 2020 00:19:11 +0000
Date: Mon, 16 Nov 2020 18:19:07 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
Message-ID: <20201117001907.GA1342260@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c8238524-4197-c22d-7bae-df61133fcbfe@canonical.com>
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
To: "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc: Guowen Shan <gshan@redhat.com>, linux-pci@vger.kernel.org, kernelfans@gmail.com, andi@firstfloor.org, hpa@zytor.com, bhe@redhat.com, x86@kernel.org, okaya@kernel.org, mingo@redhat.com, jay.vosburgh@canonical.com, dyoung@redhat.com, gavin.guo@canonical.com, bp@alien8.de, bhelgaas@google.com, Thomas Gleixner <tglx@linutronix.de>, kexec@lists.infradead.org, kernel@gpiccoli.net, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, vgoyal@redhat.com, ddstreet@canonical.com, lukas@wunner.de, "Eric W. Biederman" <ebiederm@xmission.com>

On Mon, Nov 16, 2020 at 05:31:36PM -0300, Guilherme G. Piccoli wrote:
> First of all, thanks everybody for the great insights/discussion! This
> thread ended-up being a great learning for (at least) me.
> 
> Given the big amount of replies and intermixed comments, I wouldn't be
> able to respond inline to all, so I'll try another approach below.
> 
> 
> From Bjorn:
> "I think [0] proposes using early_quirks() to disable MSIs at boot-time.
> That doesn't seem like a robust solution because (a) the problem affects
> all arches but early_quirks() is x86-specific and (b) even on x86
> early_quirks() only works for PCI segment 0 because it relies on the
> 0xCF8/0xCFC I/O ports."
> 
> Ah. I wasn't aware of that limitation, I thought enhancing the
> early_quirks() search to go through all buses would fix that, thanks for
> the clarification! And again, worth to clarify that this is not a
> problem affecting all arches _in practice_ - PowerPC for example has the
> FW primitives allowing a powerful PCI controller (out-of-band) reset,
> preventing this kind of issue usually.
> 
> [0]
> https://lore.kernel.org/linux-pci/20181018183721.27467-1-gpiccoli@canonical.com
> 
> 
> From Bjorn:
> "A crash_device_shutdown() could do something at the host bridge level
> if that's possible, or reset/disable bus mastering/disable MSI/etc on
> individual PCI devices if necessary."
> 
> From Lukas:
> "Guilherme's original patches from 2018 iterate over all 256 PCI buses.
> That might impact boot time negatively.  The reason he has to do that is
> because the crashing kernel doesn't know which devices exist and which
> have interrupts enabled.  However the crashing kernel has that
> information.  It should either disable interrupts itself or pass the
> necessary information to the crashing kernel as setup_data or whatever.

I don't think passing the device information to the kdump kernel is
really practical.  The kdump kernel would use it to do PCI config
writes to disable MSIs before enabling IRQs, and it doesn't know how
to access config space that early.

We could invent special "early config access" things, but that gets
really complicated really fast.  Config access depends on ACPI MCFG
tables, firmware interfaces, and in many cases, on the native host
bridge drivers in drivers/pci/controllers/.

I think we need to disable MSIs in the crashing kernel before the
kexec.  It adds a little more code in the crash_kexec() path, but it
seems like a worthwhile tradeoff.

Bjorn

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
