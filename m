Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwkQs-009TpF-Vm
 for kexec@lists.infradead.org; Mon, 13 Dec 2021 12:27:56 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 3/5] mm_zone: add function to check if managed dma zone
 exists
Date: Mon, 13 Dec 2021 20:27:10 +0800
Message-Id: <20211213122712.23805-4-bhe@redhat.com>
In-Reply-To: <20211213122712.23805-1-bhe@redhat.com>
References: <20211213122712.23805-1-bhe@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de, cl@linux.com, John.p.donnelly@oracle.com, kexec@lists.infradead.org, bhe@redhat.com, stable@vger.kernel.org

In some places of the current kernel, it assumes that dma zone must have
managed pages if CONFIG_ZONE_DMA is enabled. While this is not always true.
E.g in kdump kernel of x86_64, only low 1M is presented and locked down
at very early stage of boot, so that there's no managed pages at all in
DMA zone. This exception will always cause page allocation failure if page
is requested from DMA zone.

Here add function has_managed_dma() and the relevant helper functions to
check if there's DMA zone with managed pages. It will be used in later
patches.

Fixes: 6f599d84231f ("x86/kdump: Always reserve the low 1M when the crashkernel option is specified")
Cc: stable@vger.kernel.org
Signed-off-by: Baoquan He <bhe@redhat.com>
---
v2->v3:
 Rewrite has_managed_dma() in a simpler and more efficient way which is
 sugggested by DavidH. 

 include/linux/mmzone.h |  9 +++++++++
 mm/page_alloc.c        | 15 +++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 58e744b78c2c..6e1b726e9adf 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1046,6 +1046,15 @@ static inline int is_highmem_idx(enum zone_type idx)
 #endif
 }
 
+#ifdef CONFIG_ZONE_DMA
+bool has_managed_dma(void);
+#else
+static inline bool has_managed_dma(void)
+{
+	return false;
+}
+#endif
+
 /**
  * is_highmem - helper function to quickly check if a struct zone is a
  *              highmem zone or not.  This is an attempt to keep references
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c5952749ad40..7c7a0b5de2ff 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -9460,3 +9460,18 @@ bool take_page_off_buddy(struct page *page)
 	return ret;
 }
 #endif
+
+#ifdef CONFIG_ZONE_DMA
+bool has_managed_dma(void)
+{
+	struct pglist_data *pgdat;
+
+	for_each_online_pgdat(pgdat) {
+		struct zone *zone = &pgdat->node_zones[ZONE_DMA];
+
+		if (managed_zone(zone))
+			return true;
+	}
+	return false;
+}
+#endif /* CONFIG_ZONE_DMA */
-- 
2.17.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
