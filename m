Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i2KEe-0006yA-Fm
 for kexec@lists.infradead.org; Mon, 26 Aug 2019 19:01:03 +0000
Received: by mail-qt1-x843.google.com with SMTP id j15so18901657qtl.13
 for <kexec@lists.infradead.org>; Mon, 26 Aug 2019 12:01:00 -0700 (PDT)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v1 1/6] rqchip/gic-v3-its: reset prop table outside of
 allocation
Date: Mon, 26 Aug 2019 15:00:51 -0400
Message-Id: <20190826190056.27854-2-pasha.tatashin@soleen.com>
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

In preparation of adding another variant of allocation, move
the resetting outside of the current allocator.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 1b5c3672aea2..ada18748ed1c 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1621,15 +1621,7 @@ static void gic_reset_prop_table(void *va)
 
 static struct page *its_allocate_prop_table(gfp_t gfp_flags)
 {
-	struct page *prop_page;
-
-	prop_page = alloc_pages(gfp_flags, get_order(LPI_PROPBASE_SZ));
-	if (!prop_page)
-		return NULL;
-
-	gic_reset_prop_table(page_address(prop_page));
-
-	return prop_page;
+	return alloc_pages(gfp_flags, get_order(LPI_PROPBASE_SZ));
 }
 
 static void its_free_prop_table(struct page *prop_page)
@@ -1685,7 +1677,6 @@ static int __init its_setup_lpi_prop_table(void)
 		gic_rdists->prop_table_va = memremap(gic_rdists->prop_table_pa,
 						     LPI_PROPBASE_SZ,
 						     MEMREMAP_WB);
-		gic_reset_prop_table(gic_rdists->prop_table_va);
 	} else {
 		struct page *page;
 
@@ -1703,6 +1694,7 @@ static int __init its_setup_lpi_prop_table(void)
 		WARN_ON(gic_reserve_range(gic_rdists->prop_table_pa,
 					  LPI_PROPBASE_SZ));
 	}
+	gic_reset_prop_table(gic_rdists->prop_table_va);
 
 	pr_info("GICv3: using LPI property table @%pa\n",
 		&gic_rdists->prop_table_pa);
@@ -3079,6 +3071,7 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
 		its_lpi_free(bitmap, base, nr_ids);
 		return -ENOMEM;
 	}
+	gic_reset_prop_table(page_address(vprop_page));
 
 	vm->db_bitmap = bitmap;
 	vm->db_lpi_base = base;
-- 
2.23.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
