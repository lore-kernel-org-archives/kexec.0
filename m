Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjpeq-0006YQ-Cn
 for kexec@lists.infradead.org; Mon, 30 Nov 2020 20:20:26 +0000
Date: Mon, 30 Nov 2020 14:20:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
Message-ID: <20201130202021.GA1106292@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHD1Q_yfFYrfAEHTA3mW25hK9DFFYnKQ2_1HCEnL4m=bc=rLfg@mail.gmail.com>
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
To: Guilherme Piccoli <gpiccoli@canonical.com>
Cc: Guowen Shan <gshan@redhat.com>, linux-pci@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>, andi@firstfloor.org, "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>, x86@kernel.org, Sinan Kaya <okaya@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jay Vosburgh <jay.vosburgh@canonical.com>, Dave Young <dyoung@redhat.com>, Gavin Guo <gavin.guo@canonical.com>, Borislav Petkov <bp@alien8.de>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, kexec mailing list <kexec@lists.infradead.org>, "Guilherme G. Piccoli" <kernel@gpiccoli.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, Vivek Goyal <vgoyal@redhat.com>, Dan Streetman <ddstreet@canonical.com>, lukas@wunner.de, "Eric W. Biederman" <ebiederm@xmission.com>

On Wed, Nov 18, 2020 at 07:36:08PM -0300, Guilherme Piccoli wrote:
> Thanks a lot Bjorn! I confess except for PPC64 Server machines, I
> never saw other "domains" or segments. Is it common in x86 to have
> that? The early_quirks() are restricted to the first segment, no
> matter how many host bridges we have in segment 0000?

I don't know whether it's *common* to have multiple domains on x86,
but they're definitely used on large systems.  This includes some
lspci info from an HPE Superdome Flex system:
https://lore.kernel.org/lkml/5350E02A-6457-41A8-8F33-AF67BFDAEE3E@fb.com/

The early quirks in arch/x86/kernel/early-quirks.c (not the
DECLARE_PCI_FIXUP_EARLY quirks in drivers/pci/quirks.c) are restricted
to segment 0, no matter how many host bridges there are.  This is
because they use read_pci_config_16(), which uses a config access
mechanism that has no provision for a segment number.

Bjorn

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
