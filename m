Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gF060-0001yR-Mn
 for kexec@lists.infradead.org; Tue, 23 Oct 2018 17:04:06 +0000
Date: Tue, 23 Oct 2018 12:03:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
Message-ID: <20181023170343.GA4587@bhelgaas-glaptop.roam.corp.google.com>
References: <20181018183721.27467-1-gpiccoli@canonical.com>
 <20181018221538.GN5906@bhelgaas-glaptop.roam.corp.google.com>
 <d4e10c8d-aa39-7577-fbc8-0430ac44ba54@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d4e10c8d-aa39-7577-fbc8-0430ac44ba54@canonical.com>
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
Cc: cascardo@canonical.com, linux-pci@vger.kernel.org, andi@firstfloor.org, mfo@canonical.com, hpa@zytor.com, bhe@redhat.com, x86@kernel.org, mingo@redhat.com, jay.vosburgh@canonical.com, dyoung@redhat.com, fabiomirmar@canonical.com, gavin.guo@canonical.com, bp@alien8.de, bhelgaas@google.com, tglx@linutronix.de, shan.gavin@linux.alibaba.com, kernel@gpiccoli.net, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com, ddstreet@canonical.com, lukas@wunner.de, billy.olsen@canonical.com

On Mon, Oct 22, 2018 at 05:35:06PM -0300, Guilherme G. Piccoli wrote:
> On 18/10/2018 19:15, Bjorn Helgaas wrote:
> > On Thu, Oct 18, 2018 at 03:37:19PM -0300, Guilherme G. Piccoli wrote:
> > [...] 
> I understand your point, but I think this is inherently an architecture
> problem. No matter what solution we decide for, it'll need to be applied
> in early boot time, like before the PCI layer gets initialized.

This is the part I want to know more about.  Apparently there's some
event X between early_quirks() and the PCI device enumeration, and we
must disable MSIs before X:

  setup_arch()
      early_quirks()                     # arch/x86/kernel/early-quirks.c
      early_pci_clear_msi()
  ...
  X
  ...
  pci_scan_root_bus_bridge()
    ...
    DECLARE_PCI_FIXUP_EARLY              # drivers/pci/quirks.c

I want to know specifically what X is.  If we don't know what X is and
all we know is "we have to disable MSIs earlier than PCI init", then
we're likely to break things again in the future by changing the order
of disabling MSIs and whatever X is.

Bjorn

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
