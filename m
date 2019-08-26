Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 26 Aug 2019 20:13:13 +0100
From: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v1 0/6] Allow kexec reboot for GICv3 and device tree
Message-ID: <20190826201313.246208e9@why>
In-Reply-To: <20190826190056.27854-1-pasha.tatashin@soleen.com>
References: <20190826190056.27854-1-pasha.tatashin@soleen.com>
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
To: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: sashal@kernel.org, mark.rutland@arm.com, vladimir.murzin@arm.com, kexec@lists.infradead.org, jmorris@namei.org, linux-kernel@vger.kernel.org, james.morse@arm.com, linux-arm-kernel@lists.infradead.org

On Mon, 26 Aug 2019 15:00:50 -0400
Pavel Tatashin <pasha.tatashin@soleen.com> wrote:

> Marc Zyngier added the support for kexec and GICv3 for EFI based systems.
> However, it is still not possible todo on systems with device trees.
> 
> Here is EFI fixes from Marc:
> https://lore.kernel.org/lkml/20180921195954.21574-1-marc.zyngier@arm.com
> 
> For Device Tree variant: lets allow reserve a memory region in interrupt
> controller node, and use this property to allocate interrupt tables.

There is no such thing as a "device tree variant". As long as your
bootloader implements EFI, everything will work correctly, whether
you're using DT, ACPI, or the anything else.

This already works today, without any need to add anything to the
kernel (I have systems using EDK II and u-boot, both implementing EFI,
and I'm able to kexec without any issue). If your bootloader doesn't
support EFI, here's a good opportunity to implement it!

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
