Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2120.oracle.com ([156.151.31.85])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRLuy-004w7J-C4
 for kexec@lists.infradead.org; Tue, 30 Mar 2021 21:29:07 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC v2 31/43] memblock, mm: defer initialization of preserved pages
Date: Tue, 30 Mar 2021 14:36:06 -0700
Message-Id: <1617140178-8773-32-git-send-email-anthony.yznaga@oracle.com>
In-Reply-To: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
References: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
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
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: willy@infradead.org, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org, hughd@google.com, ebiederm@xmission.com, keescook@chromium.org, ardb@kernel.org, nivedita@alum.mit.edu, jroedel@suse.de, masahiroy@kernel.org, nathan@kernel.org, terrelln@fb.com, vincenzo.frascino@arm.com, martin.b.radev@gmail.com, andreyknvl@google.com, daniel.kiper@oracle.com, rafael.j.wysocki@intel.com, dan.j.williams@intel.com, Jonathan.Cameron@huawei.com, bhe@redhat.com, rminnich@gmail.com, ashish.kalra@amd.com, guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org, iamjoonsoo.kim@lge.com, vbabka@suse.cz, alex.shi@linux.alibaba.com, david@redhat.com, richard.weiyang@gmail.com, vdavydov.dev@gmail.com, graf@amazon.com, jason.zeng@intel.com, lei.l.li@intel.com, daniel.m.jordan@oracle.com, steven.sistare@oracle.com, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, kexec@lists.infradead.org

Preserved pages are represented in the memblock reserved list, but page
structs for pages in the reserved list are initialized early while boot
is single threaded which means that a large number of preserved pages
can impact boot time. To mitigate, defer initialization of preserved
pages by skipping them when other reserved pages are initialized and
initializing them later with a separate kernel thread.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 arch/x86/mm/init_64.c |  1 -
 include/linux/mm.h    |  2 +-
 mm/memblock.c         | 11 +++++++++--
 mm/page_alloc.c       | 55 +++++++++++++++++++++++++++++++++++++++++++--------
 4 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 69bd71996b8b..8efb2fb2a88b 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1294,7 +1294,6 @@ void __init mem_init(void)
 	after_bootmem = 1;
 	x86_init.hyper.init_after_bootmem();
 
-	pkram_cleanup();
 	totalram_pages_add(pkram_reserved_pages);
 	/*
 	 * Must be done after boot memory is put on freelist, because here we
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 64a71bf20536..2a93b2a6ec8d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2337,7 +2337,7 @@ extern unsigned long free_reserved_area(void *start, void *end,
 extern void adjust_managed_page_count(struct page *page, long count);
 extern void mem_init_print_info(const char *str);
 
-extern void reserve_bootmem_region(phys_addr_t start, phys_addr_t end);
+extern void reserve_bootmem_region(phys_addr_t start, phys_addr_t end, int nid);
 
 /* Free the reserved page into the buddy system, so it gets managed. */
 static inline void free_reserved_page(struct page *page)
diff --git a/mm/memblock.c b/mm/memblock.c
index afaefa8fc6ab..461ea0f85495 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2007,11 +2007,18 @@ static unsigned long __init free_low_memory_core_early(void)
 	unsigned long count = 0;
 	phys_addr_t start, end;
 	u64 i;
+	struct memblock_region *r;
 
 	memblock_clear_hotplug(0, -1);
 
-	for_each_reserved_mem_range(i, &start, &end)
-		reserve_bootmem_region(start, end);
+	for_each_reserved_mem_region(r) {
+		if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT) && memblock_is_preserved(r))
+			continue;
+
+		start = r->base;
+		end = r->base + r->size;
+		reserve_bootmem_region(start, end, NUMA_NO_NODE);
+	}
 
 	/*
 	 * We need to use NUMA_NO_NODE instead of NODE_DATA(0)->node_id
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cfc72873961d..999fcc8fe907 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -72,6 +72,7 @@
 #include <linux/padata.h>
 #include <linux/khugepaged.h>
 #include <linux/buffer_head.h>
+#include <linux/pkram.h>
 
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
@@ -1475,15 +1476,18 @@ static void __meminit __init_single_page(struct page *page, unsigned long pfn,
 }
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
-static void __meminit init_reserved_page(unsigned long pfn)
+static void __meminit init_reserved_page(unsigned long pfn, int nid)
 {
 	pg_data_t *pgdat;
-	int nid, zid;
+	int zid;
 
-	if (!early_page_uninitialised(pfn))
-		return;
+	if (nid == NUMA_NO_NODE) {
+		if (!early_page_uninitialised(pfn))
+			return;
+
+		nid = early_pfn_to_nid(pfn);
+	}
 
-	nid = early_pfn_to_nid(pfn);
 	pgdat = NODE_DATA(nid);
 
 	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
@@ -1495,7 +1499,7 @@ static void __meminit init_reserved_page(unsigned long pfn)
 	__init_single_page(pfn_to_page(pfn), pfn, zid, nid);
 }
 #else
-static inline void init_reserved_page(unsigned long pfn)
+static inline void init_reserved_page(unsigned long pfn, int nid)
 {
 }
 #endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
@@ -1506,7 +1510,7 @@ static inline void init_reserved_page(unsigned long pfn)
  * marks the pages PageReserved. The remaining valid pages are later
  * sent to the buddy page allocator.
  */
-void __meminit reserve_bootmem_region(phys_addr_t start, phys_addr_t end)
+void __meminit reserve_bootmem_region(phys_addr_t start, phys_addr_t end, int nid)
 {
 	unsigned long start_pfn = PFN_DOWN(start);
 	unsigned long end_pfn = PFN_UP(end);
@@ -1515,7 +1519,7 @@ void __meminit reserve_bootmem_region(phys_addr_t start, phys_addr_t end)
 		if (pfn_valid(start_pfn)) {
 			struct page *page = pfn_to_page(start_pfn);
 
-			init_reserved_page(start_pfn);
+			init_reserved_page(start_pfn, nid);
 
 			/* Avoid false-positive PageTail() */
 			INIT_LIST_HEAD(&page->lru);
@@ -2008,6 +2012,35 @@ static int __init deferred_init_memmap(void *data)
 	return 0;
 }
 
+#ifdef CONFIG_PKRAM
+static int __init deferred_init_preserved(void *dummy)
+{
+	unsigned long start = jiffies;
+	unsigned long nr_pages = 0;
+	struct memblock_region *r;
+	phys_addr_t spa, epa;
+	int nid;
+
+	for_each_reserved_mem_region(r) {
+		if (!memblock_is_preserved(r))
+			continue;
+
+		spa = r->base;
+		epa = r->base + r->size;
+		nid = memblock_get_region_node(r);
+
+		reserve_bootmem_region(spa, epa, nid);
+		nr_pages += ((epa - spa) >> PAGE_SHIFT);
+	}
+
+	pr_info("initialised %lu preserved pages in %ums\n", nr_pages,
+					jiffies_to_msecs(jiffies - start));
+
+	pgdat_init_report_one_done();
+	return 0;
+}
+#endif /* CONFIG_PKRAM */
+
 /*
  * If this zone has deferred pages, try to grow it by initializing enough
  * deferred pages to satisfy the allocation specified by order, rounded up to
@@ -2107,6 +2140,10 @@ void __init page_alloc_init_late(void)
 
 	/* There will be num_node_state(N_MEMORY) threads */
 	atomic_set(&pgdat_init_n_undone, num_node_state(N_MEMORY));
+#ifdef CONFIG_PKRAM
+	atomic_inc(&pgdat_init_n_undone);
+	kthread_run(deferred_init_preserved, NULL, "pgdatainit_preserved");
+#endif
 	for_each_node_state(nid, N_MEMORY) {
 		kthread_run(deferred_init_memmap, NODE_DATA(nid), "pgdatinit%d", nid);
 	}
@@ -2114,6 +2151,8 @@ void __init page_alloc_init_late(void)
 	/* Block until all are initialised */
 	wait_for_completion(&pgdat_init_all_done_comp);
 
+	pkram_cleanup();
+
 	/*
 	 * The number of managed pages has changed due to the initialisation
 	 * so the pcpu batch and high limits needs to be updated or the limits
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
