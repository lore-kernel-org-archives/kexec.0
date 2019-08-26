Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i2KEe-0006y8-7b
 for kexec@lists.infradead.org; Mon, 26 Aug 2019 19:01:01 +0000
Received: by mail-qt1-x843.google.com with SMTP id 44so18929532qtg.11
 for <kexec@lists.infradead.org>; Mon, 26 Aug 2019 12:00:59 -0700 (PDT)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v1 0/6] Allow kexec reboot for GICv3 and device tree
Date: Mon, 26 Aug 2019 15:00:50 -0400
Message-Id: <20190826190056.27854-1-pasha.tatashin@soleen.com>
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
To: pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com, james.morse@arm.com, vladimir.murzin@arm.com, mark.rutland@arm.com

Marc Zyngier added the support for kexec and GICv3 for EFI based systems.
However, it is still not possible todo on systems with device trees.

Here is EFI fixes from Marc:
https://lore.kernel.org/lkml/20180921195954.21574-1-marc.zyngier@arm.com

For Device Tree variant: lets allow reserve a memory region in interrupt
controller node, and use this property to allocate interrupt tables.

This way we are safe during kexec, as these page tables are going to stay
the same after kexec.

Pavel Tatashin (6):
  rqchip/gic-v3-its: reset prop table outside of allocation
  rqchip/gic-v3-its: use temporary va / pa variables
  rqchip/gic-v3-its: add reset pending table function
  rqchip/gic-v3-its: move reset pending table outside of allocator
  rqchip/gic-v3-its: move reset pending table outside of allocator
  dt-bindings: interrupt-controller: add optional memory-region

 .../interrupt-controller/arm,gic-v3.yaml      |   7 +
 drivers/irqchip/irq-gic-v3-its.c              | 121 +++++++++++++-----
 2 files changed, 96 insertions(+), 32 deletions(-)

-- 
2.23.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
