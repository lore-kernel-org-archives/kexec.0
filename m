Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kepSd-0003n3-19
 for kexec@lists.infradead.org; Tue, 17 Nov 2020 01:07:08 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20201117001907.GA1342260@bjorn-Precision-5520>
Date: Mon, 16 Nov 2020 19:06:40 -0600
In-Reply-To: <20201117001907.GA1342260@bjorn-Precision-5520> (Bjorn Helgaas's
 message of "Mon, 16 Nov 2020 18:19:07 -0600")
Message-ID: <87h7poeqqn.fsf@x220.int.ebiederm.org>
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
Cc: Guowen Shan <gshan@redhat.com>, linux-pci@vger.kernel.org, kernelfans@gmail.com, andi@firstfloor.org, hpa@zytor.com, bhe@redhat.com, x86@kernel.org, okaya@kernel.org, mingo@redhat.com, jay.vosburgh@canonical.com, dyoung@redhat.com, gavin.guo@canonical.com, "Guilherme G. Piccoli" <gpiccoli@canonical.com>, bp@alien8.de, bhelgaas@google.com, Thomas Gleixner <tglx@linutronix.de>, kexec@lists.infradead.org, kernel@gpiccoli.net, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, ddstreet@canonical.com, lukas@wunner.de, vgoyal@redhat.com

Bjorn Helgaas <helgaas@kernel.org> writes:

> I don't think passing the device information to the kdump kernel is
> really practical.  The kdump kernel would use it to do PCI config
> writes to disable MSIs before enabling IRQs, and it doesn't know how
> to access config space that early.

I don't think it is particularly practical either.  But in practice
on x86 it is either mmio writes or 0xcf8 style writes and we could
pass a magic table that would have all of that information.

> We could invent special "early config access" things, but that gets
> really complicated really fast.  Config access depends on ACPI MCFG
> tables, firmware interfaces, and in many cases, on the native host
> bridge drivers in drivers/pci/controllers/.

I do agree that the practical problem with passing information early
is that gets us into the weeds and creates code that we only care
about in the case of kexec-on-panic.  It is much better to make the
existing code more robust, so that we reduce our dependency on firmware
doing the right thing.

> I think we need to disable MSIs in the crashing kernel before the
> kexec.  It adds a little more code in the crash_kexec() path, but it
> seems like a worthwhile tradeoff.

Disabling MSIs in the b0rken kernel is not possible.

Walking the device tree or even a significant subset of it hugely
decreases the chances that we will run into something that is incorrect
in the known broken kernel.  I expect the code to do that would double
or triple the amount of code that must be executed in the known broken
kernel.  The last time something like that happened (switching from xchg
to ordinary locks) we had cases that stopped working.  Walking all of
the pci devices in the system is much more invasive.

That is not to downplay the problems of figuring out how to disable
things in early boot.

My two top candidates are poking the IOMMUs early to shut things off,
and figuring out if we can delay enabling interrupts until we have
initialized pci.

Poking at IOMMUs early should work for most systems with ``enterprise''
hardware.  Systems where people care about kdump the most.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
