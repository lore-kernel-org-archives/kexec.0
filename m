Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from new3-smtp.messagingengine.com ([66.111.4.229])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBier-00Abb2-1b
 for kexec@lists.infradead.org; Thu, 05 Aug 2021 19:03:59 +0000
From: Zi Yan <zi.yan@sent.com>
Subject: [RFC PATCH 13/15] mm: convert MAX_ORDER sized static arrays to
 dynamic ones.
Date: Thu,  5 Aug 2021 15:02:51 -0400
Message-Id: <20210805190253.2795604-14-zi.yan@sent.com>
In-Reply-To: <20210805190253.2795604-1-zi.yan@sent.com>
References: <20210805190253.2795604-1-zi.yan@sent.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Mike Kravetz <mike.kravetz@oracle.com>, Michal Hocko <mhocko@kernel.org>, John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>, Dave Young <dyoung@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Christian Koenig <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, kexec@lists.infradead.org, linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org

From: Zi Yan <ziy@nvidia.com>

This prepares for the upcoming changes to make MAX_ORDER a boot time
parameter instead of compilation time constant. All static arrays with
MAX_ORDER size are converted to pointers and their memory is allocated
at runtime.

free_area array in struct zone is allocated using memblock_alloc_node()
at boot time and using kzalloc() when memory is hot-added.

MAX_ORDER in arm64 nVHE code is independent of kernel buddy allocator,
so use CONFIG_FORCE_MAX_ZONEORDER instead.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: kexec@lists.infradead.org
Cc: linux-doc@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 .../admin-guide/kdump/vmcoreinfo.rst          |  2 +-
 drivers/gpu/drm/ttm/ttm_device.c              |  7 ++-
 drivers/gpu/drm/ttm/ttm_pool.c                | 58 +++++++++++++++++--
 include/drm/ttm/ttm_pool.h                    |  4 +-
 include/linux/memory_hotplug.h                |  1 +
 include/linux/mmzone.h                        |  2 +-
 mm/memory_hotplug.c                           |  1 +
 mm/page_alloc.c                               | 48 ++++++++++++---
 8 files changed, 104 insertions(+), 19 deletions(-)

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index 3861a25faae1..1c9449b9458f 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -172,7 +172,7 @@ variables.
 Offset of the free_list's member. This value is used to compute the number
 of free pages.
 
-Each zone has a free_area structure array called free_area[MAX_ORDER].
+Each zone has a free_area structure array called free_area with length of MAX_ORDER.
 The free_list represents a linked list of free page blocks.
 
 (list_head, next|prev)
diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_device.c
index 74e3b460132b..7d994c03fbd0 100644
--- a/drivers/gpu/drm/ttm/ttm_device.c
+++ b/drivers/gpu/drm/ttm/ttm_device.c
@@ -94,7 +94,9 @@ static int ttm_global_init(void)
 		>> PAGE_SHIFT;
 	num_dma32 = min(num_dma32, 2UL << (30 - PAGE_SHIFT));
 
-	ttm_pool_mgr_init(num_pages);
+	ret = ttm_pool_mgr_init(num_pages);
+	if (ret)
+		goto out;
 	ttm_tt_mgr_init(num_pages, num_dma32);
 
 	glob->dummy_read_page = alloc_page(__GFP_ZERO | GFP_DMA32);
@@ -216,7 +218,8 @@ int ttm_device_init(struct ttm_device *bdev, struct ttm_device_funcs *funcs,
 	bdev->funcs = funcs;
 
 	ttm_sys_man_init(bdev);
-	ttm_pool_init(&bdev->pool, dev, use_dma_alloc, use_dma32);
+	if (ttm_pool_init(&bdev->pool, dev, use_dma_alloc, use_dma32))
+		return -ENOMEM;
 
 	bdev->vma_manager = vma_manager;
 	INIT_DELAYED_WORK(&bdev->wq, ttm_device_delayed_workqueue);
diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index cb38b1a17b09..ae20c80f14a4 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -64,11 +64,11 @@ module_param(page_pool_size, ulong, 0644);
 
 static atomic_long_t allocated_pages;
 
-static struct ttm_pool_type global_write_combined[MAX_ORDER];
-static struct ttm_pool_type global_uncached[MAX_ORDER];
+static struct ttm_pool_type *global_write_combined;
+static struct ttm_pool_type *global_uncached;
 
-static struct ttm_pool_type global_dma32_write_combined[MAX_ORDER];
-static struct ttm_pool_type global_dma32_uncached[MAX_ORDER];
+static struct ttm_pool_type *global_dma32_write_combined;
+static struct ttm_pool_type *global_dma32_uncached;
 
 static struct mutex shrinker_lock;
 static struct list_head shrinker_list;
@@ -493,8 +493,10 @@ EXPORT_SYMBOL(ttm_pool_free);
  * @use_dma32: true if GFP_DMA32 should be used
  *
  * Initialize the pool and its pool types.
+ *
+ * Returns: 0 on successe, negative error code otherwise
  */
-void ttm_pool_init(struct ttm_pool *pool, struct device *dev,
+int ttm_pool_init(struct ttm_pool *pool, struct device *dev,
 		   bool use_dma_alloc, bool use_dma32)
 {
 	unsigned int i, j;
@@ -506,11 +508,30 @@ void ttm_pool_init(struct ttm_pool *pool, struct device *dev,
 	pool->use_dma32 = use_dma32;
 
 	if (use_dma_alloc) {
-		for (i = 0; i < TTM_NUM_CACHING_TYPES; ++i)
+		for (i = 0; i < TTM_NUM_CACHING_TYPES; ++i) {
+			pool->caching[i].orders =
+				kzalloc(sizeof(struct ttm_pool_type) * MAX_ORDER,
+					GFP_KERNEL);
+			if (!pool->caching[i].orders) {
+				i--;
+				goto failed;
+			}
 			for (j = 0; j < MAX_ORDER; ++j)
 				ttm_pool_type_init(&pool->caching[i].orders[j],
 						   pool, i, j);
+
+		}
+		return 0;
+
+failed:
+		for (; i >= 0; i--) {
+			for (j = 0; j < MAX_ORDER; ++j)
+				ttm_pool_type_fini(&pool->caching[i].orders[j]);
+			kfree(pool->caching[i].orders);
+		}
+		return -ENOMEM;
 	}
+	return 0;
 }
 
 /**
@@ -696,6 +717,31 @@ int ttm_pool_mgr_init(unsigned long num_pages)
 	mutex_init(&shrinker_lock);
 	INIT_LIST_HEAD(&shrinker_list);
 
+	if (!global_write_combined) {
+		global_write_combined = kzalloc(sizeof(struct ttm_pool_type) * MAX_ORDER,
+						GFP_KERNEL);
+		if (!global_write_combined)
+			return -ENOMEM;
+	}
+	if (!global_uncached) {
+		global_uncached = kzalloc(sizeof(struct ttm_pool_type) * MAX_ORDER,
+					  GFP_KERNEL);
+		if (!global_uncached)
+			return -ENOMEM;
+	}
+	if (!global_dma32_write_combined) {
+		global_dma32_write_combined = kzalloc(sizeof(struct ttm_pool_type) * MAX_ORDER,
+						      GFP_KERNEL);
+		if (!global_dma32_write_combined)
+			return -ENOMEM;
+	}
+	if (!global_dma32_uncached) {
+		global_dma32_uncached = kzalloc(sizeof(struct ttm_pool_type) * MAX_ORDER,
+						GFP_KERNEL);
+		if (!global_dma32_uncached)
+			return -ENOMEM;
+	}
+
 	for (i = 0; i < MAX_ORDER; ++i) {
 		ttm_pool_type_init(&global_write_combined[i], NULL,
 				   ttm_write_combined, i);
diff --git a/include/drm/ttm/ttm_pool.h b/include/drm/ttm/ttm_pool.h
index 4321728bdd11..5c09e3cf63ce 100644
--- a/include/drm/ttm/ttm_pool.h
+++ b/include/drm/ttm/ttm_pool.h
@@ -71,7 +71,7 @@ struct ttm_pool {
 	bool use_dma32;
 
 	struct {
-		struct ttm_pool_type orders[MAX_ORDER];
+		struct ttm_pool_type *orders;
 	} caching[TTM_NUM_CACHING_TYPES];
 };
 
@@ -79,7 +79,7 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 		   struct ttm_operation_ctx *ctx);
 void ttm_pool_free(struct ttm_pool *pool, struct ttm_tt *tt);
 
-void ttm_pool_init(struct ttm_pool *pool, struct device *dev,
+int ttm_pool_init(struct ttm_pool *pool, struct device *dev,
 		   bool use_dma_alloc, bool use_dma32);
 void ttm_pool_fini(struct ttm_pool *pool);
 
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 97f874a60607..c16aa66db61e 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -326,6 +326,7 @@ extern void clear_zone_contiguous(struct zone *zone);
 
 #ifdef CONFIG_MEMORY_HOTPLUG
 extern void __ref free_area_init_core_hotplug(int nid);
+extern void __ref free_area_deinit_core_hotplug(int nid);
 extern int __add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
 extern int add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
 extern int add_memory_resource(int nid, struct resource *resource,
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 322b995942e5..09aafc05aef4 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -609,7 +609,7 @@ struct zone {
 	ZONE_PADDING(_pad1_)
 
 	/* free areas of different sizes */
-	struct free_area	free_area[MAX_ORDER];
+	struct free_area	*free_area;
 
 	/* zone flags, see below */
 	unsigned long		flags;
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 91ca751ac20c..4ce20b6482aa 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1239,6 +1239,7 @@ static void rollback_node_hotadd(int nid)
 
 	arch_refresh_nodedata(nid, NULL);
 	free_percpu(pgdat->per_cpu_nodestats);
+	free_area_deinit_core_hotplug(nid);
 	arch_free_nodedata(pgdat);
 }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e4657009fd4f..bfa6962f7615 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6053,11 +6053,21 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 
 	for_each_populated_zone(zone) {
 		unsigned int order;
-		unsigned long nr[MAX_ORDER], flags, total = 0;
-		unsigned char types[MAX_ORDER];
+		unsigned long *nr, flags, total = 0;
+		unsigned char *types;
 
 		if (show_mem_node_skip(filter, zone_to_nid(zone), nodemask))
 			continue;
+
+		nr = kmalloc(sizeof(unsigned long) * MAX_ORDER, GFP_KERNEL);
+		if (!nr)
+			goto skip_zone;
+		types = kmalloc(sizeof(unsigned char) * MAX_ORDER, GFP_KERNEL);
+		if (!types) {
+			kfree(nr);
+			goto skip_zone;
+		}
+
 		show_node(zone);
 		printk(KERN_CONT "%s: ", zone->name);
 
@@ -6083,8 +6093,11 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 				show_migration_types(types[order]);
 		}
 		printk(KERN_CONT "= %lukB\n", K(total));
-	}
 
+		kfree(nr);
+		kfree(types);
+	}
+skip_zone:
 	hugetlb_show_meminfo();
 
 	printk("%ld total pagecache pages\n", global_node_page_state(NR_FILE_PAGES));
@@ -7429,8 +7442,8 @@ static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
 	lruvec_init(&pgdat->__lruvec);
 }
 
-static void __meminit zone_init_internals(struct zone *zone, enum zone_type idx, int nid,
-							unsigned long remaining_pages)
+static void __init zone_init_internals(struct zone *zone, enum zone_type idx, int nid,
+							unsigned long remaining_pages, bool hotplug)
 {
 	atomic_long_set(&zone->managed_pages, remaining_pages);
 	zone_set_nid(zone, nid);
@@ -7439,6 +7452,16 @@ static void __meminit zone_init_internals(struct zone *zone, enum zone_type idx,
 	spin_lock_init(&zone->lock);
 	zone_seqlock_init(zone);
 	zone_pcp_init(zone);
+	if (hotplug)
+		zone->free_area =
+			kzalloc_node(sizeof(struct free_area) * MAX_ORDER,
+				     GFP_KERNEL, nid);
+	else
+		zone->free_area =
+			memblock_alloc_node(sizeof(struct free_area) * MAX_ORDER,
+					    sizeof(struct free_area), nid);
+	BUG_ON(!zone->free_area);
+
 }
 
 /*
@@ -7456,7 +7479,18 @@ void __ref free_area_init_core_hotplug(int nid)
 
 	pgdat_init_internals(pgdat);
 	for (z = 0; z < MAX_NR_ZONES; z++)
-		zone_init_internals(&pgdat->node_zones[z], z, nid, 0);
+		zone_init_internals(&pgdat->node_zones[z], z, nid, 0, true);
+}
+
+void __ref free_area_deinit_core_hotplug(int nid)
+{
+	enum zone_type z;
+	pg_data_t *pgdat = NODE_DATA(nid);
+
+	for (z = 0; z < MAX_NR_ZONES; z++) {
+		kfree(pgdat->node_zones[z].free_area);
+		pgdat->node_zones[z].free_area = NULL;
+	}
 }
 #endif
 
@@ -7519,7 +7553,7 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
 		 * when the bootmem allocator frees pages into the buddy system.
 		 * And all highmem pages will be managed by the buddy system.
 		 */
-		zone_init_internals(zone, j, nid, freesize);
+		zone_init_internals(zone, j, nid, freesize, false);
 
 		if (!size)
 			continue;
-- 
2.30.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
