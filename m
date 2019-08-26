Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i2MUU-0002bo-8B
 for kexec@lists.infradead.org; Mon, 26 Aug 2019 21:25:31 +0000
Received: by mail-ed1-x543.google.com with SMTP id r12so28415135edo.5
 for <kexec@lists.infradead.org>; Mon, 26 Aug 2019 14:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190826190056.27854-1-pasha.tatashin@soleen.com>
 <20190826201313.246208e9@why>
In-Reply-To: <20190826201313.246208e9@why>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 26 Aug 2019 17:25:16 -0400
Message-ID: <CA+CK2bAS-jDwY-qKfZQD8TbvyAhS1+rBvcxGqkR4BHd5NR5BGQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] Allow kexec reboot for GICv3 and device tree
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
To: Marc Zyngier <maz@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, kexec mailing list <kexec@lists.infradead.org>, James Morris <jmorris@namei.org>, LKML <linux-kernel@vger.kernel.org>, James Morse <james.morse@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Mon, Aug 26, 2019 at 3:13 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 26 Aug 2019 15:00:50 -0400
> Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
>
> > Marc Zyngier added the support for kexec and GICv3 for EFI based systems.
> > However, it is still not possible todo on systems with device trees.
> >
> > Here is EFI fixes from Marc:
> > https://lore.kernel.org/lkml/20180921195954.21574-1-marc.zyngier@arm.com
> >
> > For Device Tree variant: lets allow reserve a memory region in interrupt
> > controller node, and use this property to allocate interrupt tables.
>
> There is no such thing as a "device tree variant". As long as your
> bootloader implements EFI, everything will work correctly, whether
> you're using DT, ACPI, or the anything else.
>
> This already works today, without any need to add anything to the
> kernel (I have systems using EDK II and u-boot, both implementing EFI,
> and I'm able to kexec without any issue). If your bootloader doesn't
> support EFI, here's a good opportunity to implement it!

Hi Marc,

Thank you very much for looking at this work.

Running Linux without EFI is common, and there are scenarios which
make it appropriate. As I understand most of embedded linux do not
have EFI enabled, and thus I do not see a reason why we would not
support a first class feature of Linux (kexec) on non-EFI bootloaders.

We (Microsoft) have a small highly secure device with a high uptime
requirement. The device also has PCIe and thus GICv3. The update for
this device relies on kexec. For a number of reasons, it was decided
to use U-Boot and Linux without EFI enabled. One of those reasons is
to improve boot performance, enabling EFI in U-Boot alone reduces the
boot performance by half a second. Our total reboot budget is under a
second which makes that half a second unacceptable. Also, adding EFI
support to kernel increases its size and there are security
implications from enabling more code both in U-Boot and Linux.

> --
> Without deviation from the norm, progress is not possible.

Totally agreed.

Thank you,
Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
