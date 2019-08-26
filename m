Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i2KEi-0006zp-EE
 for kexec@lists.infradead.org; Mon, 26 Aug 2019 19:01:05 +0000
Received: by mail-qk1-x741.google.com with SMTP id u190so14982023qkh.5
 for <kexec@lists.infradead.org>; Mon, 26 Aug 2019 12:01:03 -0700 (PDT)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v1 3/6] rqchip/gic-v3-its: add reset pending table function
Date: Mon, 26 Aug 2019 15:00:53 -0400
Message-Id: <20190826190056.27854-4-pasha.tatashin@soleen.com>
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

Add function that is similar to gic_reset_prop_table but for pending
table.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 656b6c6e1bf8..124e2cb890cd 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1989,17 +1989,23 @@ static int its_alloc_collections(struct its_node *its)
 	return 0;
 }
 
+static void gic_reset_pending_table(void *va)
+{
+	memset(va, 0, LPI_PENDBASE_SZ);
+
+	/* Make sure the GIC will observe the zero-ed page */
+	gic_flush_dcache_to_poc(va, LPI_PENDBASE_SZ);
+}
+
 static struct page *its_allocate_pending_table(gfp_t gfp_flags)
 {
 	struct page *pend_page;
 
-	pend_page = alloc_pages(gfp_flags | __GFP_ZERO,
-				get_order(LPI_PENDBASE_SZ));
+	pend_page = alloc_pages(gfp_flags, get_order(LPI_PENDBASE_SZ));
 	if (!pend_page)
 		return NULL;
 
-	/* Make sure the GIC will observe the zero-ed page */
-	gic_flush_dcache_to_poc(page_address(pend_page), LPI_PENDBASE_SZ);
+	gic_reset_pending_table(page_address(pend_page));
 
 	return pend_page;
 }
-- 
2.23.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
