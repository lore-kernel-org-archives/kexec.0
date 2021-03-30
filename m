Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2120.oracle.com ([141.146.126.78])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRLsq-004vUW-Oe
 for kexec@lists.infradead.org; Tue, 30 Mar 2021 21:26:48 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC v2 15/43] PKRAM: provide a way to ban pages from use by PKRAM
Date: Tue, 30 Mar 2021 14:35:50 -0700
Message-Id: <1617140178-8773-16-git-send-email-anthony.yznaga@oracle.com>
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

Not all memory ranges can be used for saving preserved over-kexec data.
For example, a kexec kernel may be loaded before pages are preserved.
The memory regions where the kexec segments will be copied to on kexec
must not contain preserved pages or else they will be clobbered.

Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |   2 +
 mm/pkram.c            | 205 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 207 insertions(+)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index c2099a4f2004..97a7c2ac44a9 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -103,10 +103,12 @@ int pkram_prepare_save(struct pkram_stream *ps, const char *name,
 extern unsigned long pkram_reserved_pages;
 void pkram_reserve(void);
 void pkram_cleanup(void);
+void pkram_ban_region(unsigned long start, unsigned long end);
 #else
 #define pkram_reserved_pages 0UL
 static inline void pkram_reserve(void) { }
 static inline void pkram_cleanup(void) { }
+static inline void pkram_ban_region(unsigned long start, unsigned long end) { }
 #endif
 
 #endif /* _LINUX_PKRAM_H */
diff --git a/mm/pkram.c b/mm/pkram.c
index 8670d1633a9d..d15be75c1032 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -141,6 +141,28 @@ struct pkram_super_block {
 unsigned long __initdata pkram_reserved_pages;
 
 /*
+ * For tracking a region of memory that PKRAM is not allowed to use.
+ */
+struct banned_region {
+	unsigned long start, end;		/* pfn, inclusive */
+};
+
+#define MAX_NR_BANNED		(32 + MAX_NUMNODES * 2)
+
+static unsigned int nr_banned;			/* number of banned regions */
+
+/* banned regions; arranged in ascending order, do not overlap */
+static struct banned_region banned[MAX_NR_BANNED];
+/*
+ * If a page allocated for PKRAM turns out to belong to a banned region,
+ * it is placed on the banned_pages list so subsequent allocation attempts
+ * do not encounter it again. The list is shrunk when system memory is low.
+ */
+static LIST_HEAD(banned_pages);			/* linked through page::lru */
+static DEFINE_SPINLOCK(banned_pages_lock);
+static unsigned long nr_banned_pages;
+
+/*
  * The PKRAM super block pfn, see above.
  */
 static int __init parse_pkram_sb_pfn(char *arg)
@@ -207,12 +229,116 @@ void __init pkram_reserve(void)
 	pr_info("PKRAM: %lu pages reserved\n", pkram_reserved_pages);
 }
 
+/*
+ * Ban pfn range [start..end] (inclusive) from use in PKRAM.
+ */
+void pkram_ban_region(unsigned long start, unsigned long end)
+{
+	int i, merged = -1;
+
+	/* first try to merge the region with an existing one */
+	for (i = nr_banned - 1; i >= 0 && start <= banned[i].end + 1; i--) {
+		if (end + 1 >= banned[i].start) {
+			start = min(banned[i].start, start);
+			end = max(banned[i].end, end);
+			if (merged < 0)
+				merged = i;
+		} else
+			/*
+			 * Regions are arranged in ascending order and do not
+			 * intersect so the merged region cannot jump over its
+			 * predecessors.
+			 */
+			BUG_ON(merged >= 0);
+	}
+
+	i++;
+
+	if (merged >= 0) {
+		banned[i].start = start;
+		banned[i].end = end;
+		/* shift if merged with more than one region */
+		memmove(banned + i + 1, banned + merged + 1,
+			sizeof(*banned) * (nr_banned - merged - 1));
+		nr_banned -= merged - i;
+		return;
+	}
+
+	/*
+	 * The region does not intersect with an existing one;
+	 * try to create a new one.
+	 */
+	if (nr_banned == MAX_NR_BANNED) {
+		pr_err("PKRAM: Failed to ban %lu-%lu: "
+		       "Too many banned regions\n", start, end);
+		return;
+	}
+
+	memmove(banned + i + 1, banned + i,
+		sizeof(*banned) * (nr_banned - i));
+	banned[i].start = start;
+	banned[i].end = end;
+	nr_banned++;
+}
+
+static void pkram_show_banned(void)
+{
+	int i;
+	unsigned long n, total = 0;
+
+	pr_info("PKRAM: banned regions:\n");
+	for (i = 0; i < nr_banned; i++) {
+		n = banned[i].end - banned[i].start + 1;
+		pr_info("%4d: [%08lx - %08lx] %ld pages\n",
+			i, banned[i].start, banned[i].end, n);
+		total += n;
+	}
+	pr_info("Total banned: %ld pages in %d regions\n",
+		total, nr_banned);
+}
+
+/*
+ * Returns true if the page may not be used for storing preserved data.
+ */
+static bool pkram_page_banned(struct page *page)
+{
+	unsigned long epfn, pfn = page_to_pfn(page);
+	int l = 0, r = nr_banned - 1, m;
+
+	epfn = pfn + compound_nr(page) - 1;
+
+	/* do binary search */
+	while (l <= r) {
+		m = (l + r) / 2;
+		if (epfn < banned[m].start)
+			r = m - 1;
+		else if (pfn > banned[m].end)
+			l = m + 1;
+		else
+			return true;
+	}
+	return false;
+}
+
 static inline struct page *pkram_alloc_page(gfp_t gfp_mask)
 {
 	struct page *page;
+	LIST_HEAD(list);
+	unsigned long len = 0;
 	int err;
 
 	page = alloc_page(gfp_mask);
+	while (page && pkram_page_banned(page)) {
+		len++;
+		list_add(&page->lru, &list);
+		page = alloc_page(gfp_mask);
+	}
+	if (len > 0) {
+		spin_lock(&banned_pages_lock);
+		nr_banned_pages += len;
+		list_splice(&list, &banned_pages);
+		spin_unlock(&banned_pages_lock);
+	}
 	if (page) {
 		err = pkram_add_identity_map(page);
 		if (err) {
@@ -235,6 +361,53 @@ static inline void pkram_free_page(void *addr)
 	free_page((unsigned long)addr);
 }
 
+static void __banned_pages_shrink(unsigned long nr_to_scan)
+{
+	struct page *page;
+
+	if (nr_to_scan <= 0)
+		return;
+
+	while (nr_banned_pages > 0) {
+		BUG_ON(list_empty(&banned_pages));
+		page = list_first_entry(&banned_pages, struct page, lru);
+		list_del(&page->lru);
+		__free_page(page);
+		nr_banned_pages--;
+		nr_to_scan--;
+		if (!nr_to_scan)
+			break;
+	}
+}
+
+static unsigned long
+banned_pages_count(struct shrinker *shrink, struct shrink_control *sc)
+{
+	return nr_banned_pages;
+}
+
+static unsigned long
+banned_pages_scan(struct shrinker *shrink, struct shrink_control *sc)
+{
+	int nr_left = nr_banned_pages;
+
+	if (!sc->nr_to_scan || !nr_left)
+		return nr_left;
+
+	spin_lock(&banned_pages_lock);
+	__banned_pages_shrink(sc->nr_to_scan);
+	nr_left = nr_banned_pages;
+	spin_unlock(&banned_pages_lock);
+
+	return nr_left;
+}
+
+static struct shrinker banned_pages_shrinker = {
+	.count_objects = banned_pages_count,
+	.scan_objects = banned_pages_scan,
+	.seeks = DEFAULT_SEEKS,
+};
+
 static inline void pkram_insert_node(struct pkram_node *node)
 {
 	list_add(&virt_to_page(node)->lru, &pkram_nodes);
@@ -709,6 +882,31 @@ static int __pkram_save_page(struct pkram_access *pa, struct page *page,
 	return 0;
 }
 
+static int __pkram_save_page_copy(struct pkram_access *pa, struct page *page)
+{
+	int nr_pages = compound_nr(page);
+	pgoff_t index = page->index;
+	int i, err;
+
+	for (i = 0; i < nr_pages; i++, index++) {
+		struct page *p = page + i;
+		struct page *new;
+
+		new = pkram_alloc_page(pa->ps->gfp_mask);
+		if (!new)
+			return -ENOMEM;
+
+		copy_highpage(new, p);
+		err = __pkram_save_page(pa, new, index);
+		if (err) {
+			pkram_free_page(page_address(new));
+			return err;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * Save file page @page to the preserved memory node and object associated
  * with pkram stream access @pa. The stream must have been initialized with
@@ -731,6 +929,10 @@ int pkram_save_file_page(struct pkram_access *pa, struct page *page)
 
 	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
 
+	/* if page is banned, relocate it */
+	if (pkram_page_banned(page))
+		return __pkram_save_page_copy(pa, page);
+
 	err = __pkram_save_page(pa, page, page->index);
 	if (!err)
 		err = pkram_add_identity_map(page);
@@ -968,6 +1170,7 @@ static void __pkram_reboot(void)
 	int err = 0;
 
 	if (!list_empty(&pkram_nodes)) {
+		pkram_show_banned();
 		err = pkram_add_identity_map(virt_to_page(pkram_sb));
 		if (err) {
 			pr_err("PKRAM: failed to add super block to pagetable\n");
@@ -1054,6 +1257,7 @@ static int __init pkram_init_sb(void)
 		page = alloc_page(GFP_KERNEL | __GFP_ZERO);
 		if (!page) {
 			pr_err("PKRAM: Failed to allocate super block\n");
+			__banned_pages_shrink(ULONG_MAX);
 			return 0;
 		}
 		pkram_sb = page_address(page);
@@ -1076,6 +1280,7 @@ static int __init pkram_init(void)
 {
 	if (pkram_init_sb()) {
 		register_reboot_notifier(&pkram_reboot_notifier);
+		register_shrinker(&banned_pages_shrinker);
 		sysfs_update_group(kernel_kobj, &pkram_attr_group);
 	}
 	return 0;
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
