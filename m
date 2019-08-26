Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i2KEg-0006z0-7z
 for kexec@lists.infradead.org; Mon, 26 Aug 2019 19:01:03 +0000
Received: by mail-qt1-x844.google.com with SMTP id j15so18901779qtl.13
 for <kexec@lists.infradead.org>; Mon, 26 Aug 2019 12:01:01 -0700 (PDT)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v1 2/6] rqchip/gic-v3-its: use temporary va / pa variables
Date: Mon, 26 Aug 2019 15:00:52 -0400
Message-Id: <20190826190056.27854-3-pasha.tatashin@soleen.com>
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
To: pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com, james.morse@arm.com, vladimir.murzin@arm.com, mark.rutland@arm.com

This is a cleanup, that will help later when a variant that does not
require memremap is added.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index ada18748ed1c..656b6c6e1bf8 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1668,15 +1668,17 @@ static int gic_reserve_range(phys_addr_t addr, unsigned long size)
 static int __init its_setup_lpi_prop_table(void)
 {
 	if (gic_rdists->flags & RDIST_FLAGS_RD_TABLES_PREALLOCATED) {
+		unsigned long pa;
 		u64 val;
+		void *va;
 
 		val = gicr_read_propbaser(gic_data_rdist_rd_base() + GICR_PROPBASER);
 		lpi_id_bits = (val & GICR_PROPBASER_IDBITS_MASK) + 1;
 
-		gic_rdists->prop_table_pa = val & GENMASK_ULL(51, 12);
-		gic_rdists->prop_table_va = memremap(gic_rdists->prop_table_pa,
-						     LPI_PROPBASE_SZ,
-						     MEMREMAP_WB);
+		pa = val & GENMASK_ULL(51, 12);
+		va = memremap(pa, LPI_PROPBASE_SZ, MEMREMAP_WB);
+		gic_rdists->prop_table_pa = pa;
+		gic_rdists->prop_table_va = va;
 	} else {
 		struct page *page;
 
-- 
2.23.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
