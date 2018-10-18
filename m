Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gDEb4-0005Pg-WB
 for kexec@lists.infradead.org; Thu, 18 Oct 2018 20:08:44 +0000
Subject: Re: [PATCH 3/3] x86/quirks: Add parameter to clear MSIs early on boot
References: <20181018183721.27467-1-gpiccoli@canonical.com>
 <20181018183721.27467-3-gpiccoli@canonical.com>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <6fd4e2d2-c0ac-b26d-9a14-0379b4421679@kernel.org>
Date: Thu, 18 Oct 2018 16:08:27 -0400
MIME-Version: 1.0
In-Reply-To: <20181018183721.27467-3-gpiccoli@canonical.com>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Guilherme G. Piccoli" <gpiccoli@canonical.com>, linux-pci@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org
Cc: cascardo@canonical.com, andi@firstfloor.org, bhe@redhat.com, lukas@wunner.de, shan.gavin@linux.alibaba.com, kernel@gpiccoli.net, linux-kernel@vger.kernel.org, gavin.guo@canonical.com, ddstreet@canonical.com, mingo@redhat.com, bp@alien8.de, billy.olsen@canonical.com, mfo@canonical.com, hpa@zytor.com, bhelgaas@google.com, jay.vosburgh@canonical.com, tglx@linutronix.de, dyoung@redhat.com, fabiomirmar@canonical.com, vgoyal@redhat.com

On 10/18/2018 2:37 PM, Guilherme G. Piccoli wrote:
> We observed a kdump failure in x86 that was narrowed down to MSI irq
> storm coming from a PCI network device. The bug manifests as a lack of
> progress in the boot process of kdump kernel, and a flood of kernel
> messages like:
> 
> [...]
> [ 342.265294] do_IRQ: 0.155 No irq handler for vector
> [ 342.266916] do_IRQ: 0.155 No irq handler for vector
> [ 347.258422] do_IRQ: 14053260 callbacks suppressed
> [...]

These kind of issues are usually fixed by fixing the network driver's
shutdown routine to ensure that MSI interrupts are cleared there.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
