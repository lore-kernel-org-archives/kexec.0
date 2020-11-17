Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kexgT-0003FP-DF
 for kexec@lists.infradead.org; Tue, 17 Nov 2020 09:53:58 +0000
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
In-Reply-To: <87h7poeqqn.fsf@x220.int.ebiederm.org>
References: <20201117001907.GA1342260@bjorn-Precision-5520>
 <87h7poeqqn.fsf@x220.int.ebiederm.org>
Date: Tue, 17 Nov 2020 10:53:49 +0100
Message-ID: <873618xqaa.fsf@nanos.tec.linutronix.de>
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
Cc: Guowen Shan <gshan@redhat.com>, linux-pci@vger.kernel.org, kernelfans@gmail.com, andi@firstfloor.org, hpa@zytor.com, bhe@redhat.com, x86@kernel.org, okaya@kernel.org, mingo@redhat.com, jay.vosburgh@canonical.com, dyoung@redhat.com, vgoyal@redhat.com, "Guilherme G. Piccoli" <gpiccoli@canonical.com>, bp@alien8.de, bhelgaas@google.com, kexec@lists.infradead.org, kernel@gpiccoli.net, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, ddstreet@canonical.com, lukas@wunner.de, gavin.guo@canonical.com

On Mon, Nov 16 2020 at 19:06, Eric W. Biederman wrote:
> Bjorn Helgaas <helgaas@kernel.org> writes:
> My two top candidates are poking the IOMMUs early to shut things off,
> and figuring out if we can delay enabling interrupts until we have
> initialized pci.

Keeping interrupts disabled post PCI initialization would be nice, but
that requires feeding the whole init machinery through a shredder and
collecting the bits and pieces.

> Poking at IOMMUs early should work for most systems with ``enterprise''
> hardware.  Systems where people care about kdump the most.

The IOMMU IRQ remapping part _is_ initialized early and _before_
interrupts are enabled.

But that does not solve the problem either simply because then the IOMMU
will catch the rogue MSIs and you get an interrupt storm on the IOMMU
error interrupt.

This one is not going to be turned off because the IOMMU error interrupt
handler will handle each of them and tell the core code that everything
is under control.

As I explained several times now, the only way to shut this up reliably
is at the source. Curing the symptom is almost never a good solution.

Thanks,

        tglx

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
