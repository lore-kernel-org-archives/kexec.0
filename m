Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gEgvC-0008Ty-3h
 for kexec@lists.infradead.org; Mon, 22 Oct 2018 20:35:31 +0000
Received: from mail-qt1-f197.google.com ([209.85.160.197])
 by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.76) (envelope-from <gpiccoli@canonical.com>)
 id 1gEgv0-0000fK-Ax
 for kexec@lists.infradead.org; Mon, 22 Oct 2018 20:35:18 +0000
Received: by mail-qt1-f197.google.com with SMTP id e19-v6so6960531qtq.1
 for <kexec@lists.infradead.org>; Mon, 22 Oct 2018 13:35:18 -0700 (PDT)
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
References: <20181018183721.27467-1-gpiccoli@canonical.com>
 <20181018221538.GN5906@bhelgaas-glaptop.roam.corp.google.com>
From: "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Message-ID: <d4e10c8d-aa39-7577-fbc8-0430ac44ba54@canonical.com>
Date: Mon, 22 Oct 2018 17:35:06 -0300
MIME-Version: 1.0
In-Reply-To: <20181018221538.GN5906@bhelgaas-glaptop.roam.corp.google.com>
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
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: cascardo@canonical.com, linux-pci@vger.kernel.org, andi@firstfloor.org, mfo@canonical.com, hpa@zytor.com, bhe@redhat.com, x86@kernel.org, mingo@redhat.com, jay.vosburgh@canonical.com, dyoung@redhat.com, fabiomirmar@canonical.com, gavin.guo@canonical.com, gpiccoli@canonical.com, bp@alien8.de, bhelgaas@google.com, tglx@linutronix.de, shan.gavin@linux.alibaba.com, kernel@gpiccoli.net, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com, ddstreet@canonical.com, lukas@wunner.de, billy.olsen@canonical.com

On 18/10/2018 19:15, Bjorn Helgaas wrote:
> On Thu, Oct 18, 2018 at 03:37:19PM -0300, Guilherme G. Piccoli wrote:
> [...] 

> I don't want to expand the early quirk infrastructure unless there is
> absolutely no other way to solve this.  The early quirk stuff is
> x86-specific, and it's not obvious that this problem is x86-only.
> 
> This patch scans buses 0-255, but still only in domain 0, so it won't
> help with even more complicated systems that use other domains.
> 
> I'm not an IRQ expert, but it seems wrong to me that we are enabling
> this interrupt before we're ready for it.  The MSI should target an
> IOAPIC.  Can't that IOAPIC entry be masked until later?  I guess the
> kdump kernel doesn't know what MSI address the device might be using.
> 
> Could the IRQ core be more tolerant of this somehow, e.g., if it
> notices incoming interrupts with no handler, could it disable the
> IOAPIC entry and fall back to polling periodically until a handler is
> added?

Hi Bjorn, thanks for your quick reply.
I understand your point, but I think this is inherently an architecture
problem. No matter what solution we decide for, it'll need to be applied
in early boot time, like before the PCI layer gets initialized.

So, I think a first step would be to split the solution "timing" in 2
possibilities:

a) We could try to disable MSIs or whatever approach we take in the
quiesce path of crash_kexec(), before the bootstrap of the kdump kernel.
The pro is we could use PCI handlers to do it generically. The con is
it'd touch that delicate shutdown path, from a broken kernel, and this
is unreliable. Also, I've noticed changes in those crash paths
usually gain huge amount of criticism by community, seems nobody wants
to change a bit of this code, if not utterly necessary.

b) Continue using an early boot approach. IMO, this would be per-arch by
nature.
Currently, powerpc for example does not suffer this issue due to their
arch code performing a FW-aided PCI fundamental reset in the devices[0].
On the other hand, x86 has no generic fundamental reset infrastructure
to my knowledge (we tried some alternatives, like a Bridge reset[1] that
didn't work, or zeroing the the command register, which worked), but if
we go with the IOAPIC way of handling this (which we tried a bit and
failed too), it'll be even more arch-dependent, since IOAPIC is x86 concept.


After discussing here internally, an alternative way for this MSI
approach work without requiring the change in the early PCI
infrastructure is to check if we're in kdump kernel and perform manually
the full scan in that case, instead of changing the generic case as
proposed here. This would still be x86-only, but again, it's difficult
if not impossible to fix all archs using the same code here.

Finally, about multi-domain PCI topologies, I've never saw it on x86, I
wasn't aware that such things existed in x86 - but if required we can
quickly extend the logic to contemplate it too.

Thanks again, looking forward for you suggestions.
Cheers,


Guilherme

[0]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/platforms/powernv/pci-ioda.c#n3992

[1] Based in https://patchwork.kernel.org/patch/2562841, adapted to work
in early boot time.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
