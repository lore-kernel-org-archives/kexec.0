Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1muQqB-006pbP-4A
 for kexec@lists.infradead.org; Tue, 07 Dec 2021 03:08:28 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH RESEND v2 3/5] mm_zone: add function to check if managed dma
 zone exists
Date: Tue,  7 Dec 2021 11:07:48 +0800
Message-Id: <20211207030750.30824-4-bhe@redhat.com>
In-Reply-To: <20211207030750.30824-1-bhe@redhat.com>
References: <20211207030750.30824-1-bhe@redhat.com>
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
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de, robin.murphy@arm.com, cl@linux.com, penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz, m.szyprowski@samsung.com, John.p.donnelly@oracle.com, kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>

In some places of the current kernel, it assumes that dma zone must have
managed pages if CONFIG_ZONE_DMA is enabled. While this is not always true.
E.g in kdump kernel of x86_64, only low 1M is presented and locked down
at very early stage of boot, so that there's no managed pages at all in
DMA zone. This exception will always cause page allocation failure if page
is requested from DMA zone.

Here add function has_managed_dma() and the relevant helper functions to
check if there's DMA zone with managed pages. It will be used in later
patches.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 include/linux/mmzone.h | 21 +++++++++++++++++++++
 mm/page_alloc.c        | 11 +++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 58e744b78c2c..82d23e13e0e5 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -998,6 +998,18 @@ static inline bool zone_is_zone_device(struct zone *zone)
 }
 #endif
 
+#ifdef CONFIG_ZONE_DMA
+static inline bool zone_is_dma(struct zone *zone)
+{
+	return zone_idx(zone) == ZONE_DMA;
+}
+#else
+static inline bool zone_is_dma(struct zone *zone)
+{
+	return false;
+}
+#endif
+
 /*
  * Returns true if a zone has pages managed by the buddy allocator.
  * All the reclaim decisions have to use this function rather than
@@ -1046,6 +1058,7 @@ static inline int is_highmem_idx(enum zone_type idx)
 #endif
 }
 
+bool has_managed_dma(void);
 /**
  * is_highmem - helper function to quickly check if a struct zone is a
  *              highmem zone or not.  This is an attempt to keep references
@@ -1131,6 +1144,14 @@ extern struct zone *next_zone(struct zone *zone);
 			; /* do nothing */		\
 		else
 
+#define for_each_managed_zone(zone)		        \
+	for (zone = (first_online_pgdat())->node_zones; \
+	     zone;					\
+	     zone = next_zone(zone))			\
+		if (!managed_zone(zone))		\
+			; /* do nothing */		\
+		else
+
 static inline struct zone *zonelist_zone(struct zoneref *zoneref)
 {
 	return zoneref->zone;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c5952749ad40..ac0ea42a4e5f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -9459,4 +9459,15 @@ bool take_page_off_buddy(struct page *page)
 	spin_unlock_irqrestore(&zone->lock, flags);
 	return ret;
 }
+
+bool has_managed_dma(void)
+{
+	struct zone *zone;
+
+	for_each_managed_zone(zone) {
+		if (zone_is_dma(zone))
+			return true;
+	}
+	return false;
+}
 #endif
-- 
2.17.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
