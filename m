Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb1ZS-0002kp-8f
 for kexec@lists.infradead.org; Fri, 06 Nov 2020 13:14:27 +0000
Received: from mail-qv1-f71.google.com ([209.85.219.71])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <gpiccoli@canonical.com>) id 1kb1ZP-00036g-B7
 for kexec@lists.infradead.org; Fri, 06 Nov 2020 13:14:23 +0000
Received: by mail-qv1-f71.google.com with SMTP id es11so607937qvb.10
 for <kexec@lists.infradead.org>; Fri, 06 Nov 2020 05:14:23 -0800 (PST)
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
References: <20181018183721.27467-1-gpiccoli@canonical.com>
 <20181018221538.GN5906@bhelgaas-glaptop.roam.corp.google.com>
 <d4e10c8d-aa39-7577-fbc8-0430ac44ba54@canonical.com>
 <20181023170343.GA4587@bhelgaas-glaptop.roam.corp.google.com>
From: "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Message-ID: <684cf38f-3977-4ec2-c4a6-7c4c31f9851a@canonical.com>
Date: Fri, 6 Nov 2020 10:14:14 -0300
MIME-Version: 1.0
In-Reply-To: <20181023170343.GA4587@bhelgaas-glaptop.roam.corp.google.com>
Content-Language: en-US
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
To: Bjorn Helgaas <helgaas@kernel.org>, tglx@linutronix.de
Cc: kernel@gpiccoli.net, andi@firstfloor.org, bhe@redhat.com, lukas@wunner.de, shan.gavin@linux.alibaba.com, linux-pci@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kernelfans@gmail.com, ddstreet@canonical.com, mingo@redhat.com, bp@alien8.de, gavin.guo@canonical.com, hpa@zytor.com, bhelgaas@google.com, jay.vosburgh@canonical.com, okaya@kernel.org, dyoung@redhat.com, vgoyal@redhat.com

On 23/10/2018 14:03, Bjorn Helgaas wrote:
> On Mon, Oct 22, 2018 at 05:35:06PM -0300, Guilherme G. Piccoli wrote:
>> On 18/10/2018 19:15, Bjorn Helgaas wrote:
>>> On Thu, Oct 18, 2018 at 03:37:19PM -0300, Guilherme G. Piccoli wrote:
>>> [...] 
>> I understand your point, but I think this is inherently an architecture
>> problem. No matter what solution we decide for, it'll need to be applied
>> in early boot time, like before the PCI layer gets initialized.
> 
> This is the part I want to know more about.  Apparently there's some
> event X between early_quirks() and the PCI device enumeration, and we
> must disable MSIs before X:
> 
>   setup_arch()
>       early_quirks()                     # arch/x86/kernel/early-quirks.c
>       early_pci_clear_msi()
>   ...
>   X
>   ...
>   pci_scan_root_bus_bridge()
>     ...
>     DECLARE_PCI_FIXUP_EARLY              # drivers/pci/quirks.c
> 
> I want to know specifically what X is.  If we don't know what X is and
> all we know is "we have to disable MSIs earlier than PCI init", then
> we're likely to break things again in the future by changing the order
> of disabling MSIs and whatever X is.
> 
> Bjorn
> 

Hi Bjorn (and all CCed), I'm sorry to necro-bump a thread >2 years
later, but recent discussions led to a better understanding of this 'X'
point, thanks to Thomas!

For those that deleted this thread from their email clients, it's
available in [0] - the summary is that we faced an IRQ storm really
early in boot, due to a bogus PCIe device MSI behavior, when booting a
kdump kernel. This led the machine to get stuck in the boot and we
couldn't kdump. The solution hereby proposed is to clear MSI interrupts
early in x86, if a parameter is provided. I don't have the reproducer
anymore and it was pretty hard to reproduce in virtual environments.

So, about the 'X' Bjorn, in another recent thread about IRQ storms [1],
Thomas clarified that and after a brief discussion, it seems there's no
better way to prevent the MSI storm other than clearing the MSI
capability early in boot. As discussed both here and in thread [1], this
is indeed a per-architecture issue (powerpc is not subject to that, due
to a better FW reset mechanism), so I think we still could benefit in
having this idea implemented upstream, at least in x86 (we could expand
to other architectures if desired, in the future).

As a "test" data point, this was implemented in Ubuntu (same 3 patches
present in this series) for ~2 years and we haven't received bug reports
- I'm saying that because I understand your concerns about expanding the
early PCI quirks scope.

Let me know your thoughts. I'd suggest all to read thread [1], which
addresses a similar issue but in a different "moment" of the system boot
and provides some more insight on why the early MSI clearing seems to
make sense.

Thanks,


Guilherme


[0]
https://lore.kernel.org/linux-pci/20181018183721.27467-1-gpiccoli@canonical.com

[1] https://lore.kernel.org/lkml/87y2js3ghv.fsf@nanos.tec.linutronix.de

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
