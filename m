Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWUfG-0003cF-E5
 for kexec@lists.infradead.org; Thu, 07 May 2020 00:45:32 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC 31/43] memblock, mm: defer initialization of preserved pages
Date: Wed,  6 May 2020 17:41:57 -0700
Message-Id: <1588812129-8596-32-git-send-email-anthony.yznaga@oracle.com>
In-Reply-To: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
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
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, linux-doc@vger.kernel.org, gustavo@embeddedor.com, peterz@infradead.org, kexec@lists.infradead.org, paul.c.lai@intel.com, dave.hansen@linux.intel.com, mhocko@kernel.org, lei.l.li@intel.com, nivedita@alum.mit.edu, ziqian.lzq@antfin.com, hpa@zytor.com, ardb@kernel.org, ashok.raj@intel.com, bhe@redhat.com, corbet@lwn.net, masahiroy@kernel.org, rafael.j.wysocki@intel.com, hughd@google.com, willy@infradead.org, rppt@linux.ibm.com, mingo@redhat.com, vdavydov.dev@gmail.com, ying.huang@intel.com, Thomas.Lendacky@amd.com, kevin.tian@intel.com, jroedel@suse.de, keescook@chromium.org, dan.j.williams@intel.com, bp@alien8.de, zhiyuan.lv@intel.com, luto@kernel.org, tglx@linutronix.de, andriy.shevchenko@linux.intel.com, dima@golovin.in, yang.shi@linux.alibaba.com, ndesaulniers@google.com, zhenzhong.duan@oracle.com, guro@fb.com, minchan@kernel.org, ebiederm@xmission.com, jason.zeng@intel.com, hannes@cmpxchg.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, daniel.kiper@oracle.com

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
 mm/memblock.c         | 10 ++++++++--
 mm/page_alloc.c       | 52 +++++++++++++++++++++++++++++++++++++++++++--------
 4 files changed, 53 insertions(+), 12 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 72662615977b..ae569ef6bd7d 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1245,7 +1245,6 @@ void __init mem_init(void)
 	after_bootmem = 1;
 	x86_init.hyper.init_after_bootmem();
 
-	pkram_free_pgt();
 	totalram_pages_add(pkram_reserved_pages);
 	/*
 	 * Must be done after boot memory is put on freelist, because here we
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5a323422d783..69b9cd08c721 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2297,7 +2297,7 @@ extern void free_highmem_page(struct page *page);
 extern void adjust_managed_page_count(struct page *page, long count);
 extern void mem_init_print_info(const char *str);
 
-extern void reserve_bootmem_region(phys_addr_t start, phys_addr_t end);
+extern void reserve_bootmem_region(phys_addr_t start, phys_addr_t end, int nid);
 
 /* Free the reserved page into the buddy system, so it gets managed. */
 static inline void __free_reserved_page(struct page *page)
diff --git a/mm/memblock.c b/mm/memblock.c
index 33597f352dc0..5524edbaf691 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2042,11 +2042,17 @@ static unsigned long __init free_low_memory_core_early(void)
 	unsigned long count = 0;
 	phys_addr_t start, end;
 	u64 i;
+	enum memblock_flags exclude;
 
 	memblock_clear_hotplug(0, -1);
 
-	for_each_reserved_mem_region(i, &start, &end)
-		reserve_bootmem_region(start, end);
+	if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT))
+		exclude = MEMBLOCK_PRESERVED;
+	else
+		exclude = MEMBLOCK_NONE;
+
+	for_each_reserved_mem_range(i, 0, exclude, &start, &end, NULL)
+		reserve_bootmem_region(start, end, -1);
 
 	/*
 	 * We need to use NUMA_NO_NODE instead of NODE_DATA(0)->node_id
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 69827d4fa052..afd97b31725e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -68,6 +68,7 @@
 #include <linux/lockdep.h>
 #include <linux/nmi.h>
 #include <linux/psi.h>
+#include <linux/pkram.h>
 
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
@@ -1408,15 +1409,18 @@ static void __meminit __init_single_page(struct page *page, unsigned long pfn,
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
+	if (nid == -1) {
+		if (!early_page_uninitialised(pfn))
+			return;
+
+		nid = early_pfn_to_nid(pfn);
+	}
 
-	nid = early_pfn_to_nid(pfn);
 	pgdat = NODE_DATA(nid);
 
 	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
@@ -1428,7 +1432,7 @@ static void __meminit init_reserved_page(unsigned long pfn)
 	__init_single_page(pfn_to_page(pfn), pfn, zid, nid);
 }
 #else
-static inline void init_reserved_page(unsigned long pfn)
+static inline void init_reserved_page(unsigned long pfn, int nid)
 {
 }
 #endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
@@ -1439,7 +1443,7 @@ static inline void init_reserved_page(unsigned long pfn)
  * marks the pages PageReserved. The remaining valid pages are later
  * sent to the buddy page allocator.
  */
-void __meminit reserve_bootmem_region(phys_addr_t start, phys_addr_t end)
+void __meminit reserve_bootmem_region(phys_addr_t start, phys_addr_t end, int nid)
 {
 	unsigned long start_pfn = PFN_DOWN(start);
 	unsigned long end_pfn = PFN_UP(end);
@@ -1448,7 +1452,7 @@ void __meminit reserve_bootmem_region(phys_addr_t start, phys_addr_t end)
 		if (pfn_valid(start_pfn)) {
 			struct page *page = pfn_to_page(start_pfn);
 
-			init_reserved_page(start_pfn);
+			init_reserved_page(start_pfn, nid);
 
 			/* Avoid false-positive PageTail() */
 			INIT_LIST_HEAD(&page->lru);
@@ -1876,6 +1880,34 @@ static int __init deferred_init_memmap(void *data)
 	return 0;
 }
 
+#ifdef CONFIG_PKRAM
+static int __init deferred_init_preserved(void *dummy)
+{
+	unsigned long start = jiffies;
+	unsigned long nr_pages = 0;
+	phys_addr_t spa, epa;
+	int nid;
+	u64 i;
+
+	for_each_reserved_mem_range(i, MEMBLOCK_PRESERVED, 0, &spa, &epa, &nid) {
+		reserve_bootmem_region(spa, epa, nid);
+		nr_pages += ((epa - spa) >> PAGE_SHIFT);
+	}
+
+	pr_info("initialised %lu preserved pages in %ums\n", nr_pages,
+					jiffies_to_msecs(jiffies - start));
+
+	/*
+	 * Free the preserved pages pagetable now that page structs are
+	 * initialized.
+	 */
+	pkram_free_pgt();
+
+	pgdat_init_report_one_done();
+	return 0;
+}
+#endif /* CONFIG_PKRAM */
+
 /*
  * If this zone has deferred pages, try to grow it by initializing enough
  * deferred pages to satisfy the allocation specified by order, rounded up to
@@ -1985,6 +2017,10 @@ void __init page_alloc_init_late(void)
 
 	/* There will be num_node_state(N_MEMORY) threads */
 	atomic_set(&pgdat_init_n_undone, num_node_state(N_MEMORY));
+#ifdef CONFIG_PKRAM
+	atomic_inc(&pgdat_init_n_undone);
+	kthread_run(deferred_init_preserved, NULL, "pgdatainit_preserved");
+#endif
 	for_each_node_state(nid, N_MEMORY) {
 		kthread_run(deferred_init_memmap, NODE_DATA(nid), "pgdatinit%d", nid);
 	}
-- 
2.13.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
