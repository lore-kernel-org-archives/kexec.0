Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kfUdk-0000Po-7f
 for kexec@lists.infradead.org; Wed, 18 Nov 2020 21:05:21 +0000
Date: Wed, 18 Nov 2020 15:05:16 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
Message-ID: <20201118210516.GA76543@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHD1Q_zS9Hs8mUsm=q0Ei0kQ+y+wQhkroD+M2eCPKo2xLO6hBw@mail.gmail.com>
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

On Tue, Nov 17, 2020 at 09:04:07AM -0300, Guilherme Piccoli wrote:

> Also, taking here the opportunity to clarify my understanding about
> the limitations of that approach: Bjorn, in our reproducer machine we
> had 3 parents in the PCI tree (as per lspci -t), 0000:00, 0000:ff and
> 0000:80 - are those all under "segment 0" as per your verbiage?

Yes.  The "0000" is the PCI segment (or "domain" in the Linux PCI core).
It's common on x86 to have multiple host bridges in segment 0000.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
