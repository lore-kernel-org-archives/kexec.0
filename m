Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2120.oracle.com ([156.151.31.85])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRLuX-004w1O-Mv
 for kexec@lists.infradead.org; Tue, 30 Mar 2021 21:28:34 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC v2 38/43] mm: implement splicing a list of pages to the LRU
Date: Tue, 30 Mar 2021 14:36:13 -0700
Message-Id: <1617140178-8773-39-git-send-email-anthony.yznaga@oracle.com>
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

Considerable contention on the LRU lock happens when multiple threads
are used to insert pages into a shmem file in parallel. To alleviate this
provide a way for pages to be added to the same LRU to be staged so that
they can be added by splicing lists and updating stats once with the lock
held. For now only unevictable pages are supported.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/swap.h | 13 ++++++++
 mm/swap.c            | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 4cc6ec3bf0ab..254c9c8d71d0 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -351,6 +351,19 @@ extern void lru_note_cost(struct lruvec *lruvec, bool file,
 
 extern void lru_cache_add_inactive_or_unevictable(struct page *page,
 						struct vm_area_struct *vma);
+struct lru_splice {
+	struct list_head	splice;
+	struct list_head	*lru_head;
+	struct lruvec		*lruvec;
+	enum lru_list		lru;
+	unsigned long		nr_pages[MAX_NR_ZONES];
+	unsigned long		pgculled;
+};
+#define LRU_SPLICE_INIT(name)	{ .splice = LIST_HEAD_INIT(name.splice) }
+#define LRU_SPLICE(name) \
+	struct lru_splice name = LRU_SPLICE_INIT(name)
+extern void lru_splice_add(struct page *page, struct lru_splice *splice);
+extern void add_splice_to_lru_list(struct lru_splice *splice);
 
 /* linux/mm/vmscan.c */
 extern unsigned long zone_reclaimable_pages(struct zone *zone);
diff --git a/mm/swap.c b/mm/swap.c
index 31b844d4ed94..a1db6a748608 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -200,6 +200,92 @@ int get_kernel_page(unsigned long start, int write, struct page **pages)
 }
 EXPORT_SYMBOL_GPL(get_kernel_page);
 
+/*
+ * Update stats and move accumulated pages from an lru_splice to the lru.
+ */
+void add_splice_to_lru_list(struct lru_splice *splice)
+{
+	struct lruvec *lruvec = splice->lruvec;
+	enum lru_list lru = splice->lru;
+	unsigned long flags = 0;
+	int zid;
+
+	if (list_empty(&splice->splice))
+		return;
+
+	spin_lock_irqsave(&lruvec->lru_lock, flags);
+	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
+		if (splice->nr_pages[zid])
+			update_lru_size(lruvec, lru, zid, splice->nr_pages[zid]);
+	}
+	count_vm_events(UNEVICTABLE_PGCULLED, splice->pgculled);
+	list_splice_init(&splice->splice, splice->lru_head);
+	spin_unlock_irqrestore(&lruvec->lru_lock, flags);
+}
+
+static void add_page_to_lru_splice(struct page *page, struct lru_splice *splice,
+				   struct lruvec *lruvec, enum lru_list lru)
+{
+	if (list_empty(&splice->splice)) {
+		int zid;
+
+		splice->lruvec = lruvec;
+		splice->lru_head = &lruvec->lists[lru];
+		splice->lru = lru;
+		for (zid = 0; zid < MAX_NR_ZONES; zid++)
+			splice->nr_pages[zid] = 0;
+		splice->pgculled = 0;
+	}
+
+	BUG_ON(splice->lruvec != lruvec);
+	BUG_ON(splice->lru_head != &lruvec->lists[lru]);
+
+	list_add(&page->lru, &splice->splice);
+	splice->nr_pages[page_zonenum(page)] += thp_nr_pages(page);
+}
+
+/*
+ * Similar in functionality to __pagevec_lru_add_fn() but here the page is
+ * being added to an lru_splice and the LRU lock is not held.
+ */
+static void page_lru_splice_add(struct page *page, struct lru_splice *splice, struct lruvec *lruvec)
+{
+	enum lru_list lru;
+	int was_unevictable = TestClearPageUnevictable(page);
+	int nr_pages = thp_nr_pages(page);
+
+	VM_BUG_ON_PAGE(PageLRU(page), page);
+	/* XXX only supports unevictable pages at the moment */
+	VM_BUG_ON_PAGE(was_unevictable, page);
+
+	SetPageLRU(page);
+	smp_mb__after_atomic();
+
+	lru = LRU_UNEVICTABLE;
+	ClearPageActive(page);
+	SetPageUnevictable(page);
+	if (!was_unevictable)
+		splice->pgculled += nr_pages;
+
+	add_page_to_lru_splice(page, splice, lruvec, lru);
+	trace_mm_lru_insertion(page);
+}
+
+void lru_splice_add(struct page *page, struct lru_splice *splice)
+{
+	struct lruvec *lruvec;
+
+	VM_BUG_ON_PAGE(PageActive(page) && PageUnevictable(page), page);
+	VM_BUG_ON_PAGE(PageLRU(page), page);
+
+	get_page(page);
+	lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
+	if (lruvec != splice->lruvec)
+		add_splice_to_lru_list(splice);
+	page_lru_splice_add(page, splice, lruvec);
+	put_page(page);
+}
+
 static void pagevec_lru_move_fn(struct pagevec *pvec,
 	void (*move_fn)(struct page *page, struct lruvec *lruvec))
 {
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
