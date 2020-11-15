Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([193.142.43.55])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1keNXH-0007MB-4A
 for kexec@lists.infradead.org; Sun, 15 Nov 2020 19:18:04 +0000
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
In-Reply-To: <20201115170158.GA27152@wunner.de>
References: <20201114212215.GA1194074@bjorn-Precision-5520>
 <87v9e6n2b2.fsf@x220.int.ebiederm.org> <87sg9almmg.fsf@x220.int.ebiederm.org>
 <874klqac40.fsf@nanos.tec.linutronix.de> <20201115170158.GA27152@wunner.de>
Date: Sun, 15 Nov 2020 20:18:00 +0100
Message-ID: <87k0um8m53.fsf@nanos.tec.linutronix.de>
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
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, kernelfans@gmail.com, andi@firstfloor.org, hpa@zytor.com, bhe@redhat.com, x86@kernel.org, okaya@kernel.org, mingo@redhat.com, Bjorn Helgaas <helgaas@kernel.org>, jay.vosburgh@canonical.com, dyoung@redhat.com, gavin.guo@canonical.com, "Guilherme G. Piccoli" <gpiccoli@canonical.com>, bp@alien8.de, bhelgaas@google.com, shan.gavin@linux.alibaba.com, kexec@lists.infradead.org, kernel@gpiccoli.net, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, vgoyal@redhat.com, ddstreet@canonical.com, "Eric W. Biederman" <ebiederm@xmission.com>

On Sun, Nov 15 2020 at 18:01, Lukas Wunner wrote:
> On Sun, Nov 15, 2020 at 04:11:43PM +0100, Thomas Gleixner wrote:
>> Unfortunately there is no way to tell the APIC "Mask vector X" and the
>> dump kernel does neither know which device it comes from nor does it
>> have enumerated PCI completely which would reset the device and shutup
>> the spew. Due to the interrupt storm it does not get that far.
>
> Can't we just set DisINTx, clear MSI Enable and clear MSI-X Enable
> on all active PCI devices in the crashing kernel before starting the
> crash kernel?  So that the crash kernel starts with a clean slate?
>
> Guilherme's original patches from 2018 iterate over all 256 PCI buses.
> That might impact boot time negatively.  The reason he has to do that
> is because the crashing kernel doesn't know which devices exist and
> which have interrupts enabled.  However the crashing kernel has that
> information.  It should either disable interrupts itself or pass the
> necessary information to the crashing kernel as setup_data or whatever.

As I explained before: The problem with doing anything between crashing
and starting the crash kernel is reducing the chance of actually
starting it. The kernel crashed for whatever reason, so it's in a
completely undefined state.

Ergo there is no 'just do something'. You really have to think hard
about what can be done safely with the least probability of running into
another problem.

Thanks,

        tglx



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
