Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i2KEi-00072U-OK
 for kexec@lists.infradead.org; Mon, 26 Aug 2019 19:01:08 +0000
Received: by mail-qk1-x743.google.com with SMTP id r21so14972600qke.2
 for <kexec@lists.infradead.org>; Mon, 26 Aug 2019 12:01:04 -0700 (PDT)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v1 4/6] rqchip/gic-v3-its: move reset pending table outside of
 allocator
Date: Mon, 26 Aug 2019 15:00:54 -0400
Message-Id: <20190826190056.27854-5-pasha.tatashin@soleen.com>
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

Again, in preparation of adding a new allocator, move the reset function
outside of the current allocator.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 124e2cb890cd..d5f3508ca11f 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1999,15 +1999,7 @@ static void gic_reset_pending_table(void *va)
 
 static struct page *its_allocate_pending_table(gfp_t gfp_flags)
 {
-	struct page *pend_page;
-
-	pend_page = alloc_pages(gfp_flags, get_order(LPI_PENDBASE_SZ));
-	if (!pend_page)
-		return NULL;
-
-	gic_reset_pending_table(page_address(pend_page));
-
-	return pend_page;
+	return alloc_pages(gfp_flags, get_order(LPI_PENDBASE_SZ));
 }
 
 static void its_free_pending_table(struct page *pt)
@@ -2064,6 +2056,7 @@ static int __init allocate_lpi_tables(void)
 			pr_err("Failed to allocate PENDBASE for CPU%d\n", cpu);
 			return -ENOMEM;
 		}
+		gic_reset_pending_table(page_address(pend_page));
 
 		gic_data_rdist_cpu(cpu)->pend_page = pend_page;
 	}
@@ -3007,6 +3000,7 @@ static int its_vpe_init(struct its_vpe *vpe)
 		its_vpe_id_free(vpe_id);
 		return -ENOMEM;
 	}
+	gic_reset_pending_table(page_address(vpt_page));
 
 	if (!its_alloc_vpe_table(vpe_id)) {
 		its_vpe_id_free(vpe_id);
-- 
2.23.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
