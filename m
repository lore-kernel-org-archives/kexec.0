Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2120.oracle.com ([141.146.126.78])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWUhQ-0004wi-CC
 for kexec@lists.infradead.org; Thu, 07 May 2020 00:47:41 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC 38/43] mm: implement splicing a list of pages to the LRU
Date: Wed,  6 May 2020 17:42:04 -0700
Message-Id: <1588812129-8596-39-git-send-email-anthony.yznaga@oracle.com>
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

Considerable contention on the LRU lock happens when multiple threads
are used to insert pages into a shmem file in parallel. To alleviate this
provide a way for pages to be added to the same LRU to be staged so that
they can be added by splicing lists and updating stats once with the lock
held. For now only unevictable pages are supported.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/swap.h |  11 ++++++
 mm/swap.c            | 101 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index e1bbf7a16b27..462045f536a8 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -346,6 +346,17 @@ extern void swap_setup(void);
 
 extern void lru_cache_add_active_or_unevictable(struct page *page,
 						struct vm_area_struct *vma);
+struct lru_splice {
+	struct list_head	splice;
+	struct list_head	*lru_head;
+	struct pglist_data	*pgdat;
+	struct lruvec		*lruvec;
+	enum lru_list		lru;
+	unsigned long		nr_pages[MAX_NR_ZONES];
+	unsigned long		pgculled;
+};
+extern void lru_splice_add_anon(struct page *page, struct lru_splice *splice);
+extern void add_splice_to_lru_list(struct lru_splice *splice);
 
 /* linux/mm/vmscan.c */
 extern unsigned long zone_reclaimable_pages(struct zone *zone);
diff --git a/mm/swap.c b/mm/swap.c
index bf9a79fed62d..848f8b516471 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -187,6 +187,107 @@ int get_kernel_page(unsigned long start, int write, struct page **pages)
 }
 EXPORT_SYMBOL_GPL(get_kernel_page);
 
+/*
+ * Update stats and move accumulated pages from an lru_splice to the lru.
+ */
+void add_splice_to_lru_list(struct lru_splice *splice)
+{
+	struct pglist_data *pgdat = splice->pgdat;
+	struct lruvec *lruvec = splice->lruvec;
+	enum lru_list lru = splice->lru;
+	unsigned long flags = 0;
+	int zid;
+
+	spin_lock_irqsave(&pgdat->lru_lock, flags);
+	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
+		if (splice->nr_pages[zid])
+			update_lru_size(lruvec, lru, zid, splice->nr_pages[zid]);
+	}
+	count_vm_events(UNEVICTABLE_PGCULLED, splice->pgculled);
+	list_splice(&splice->splice, splice->lru_head);
+	spin_unlock_irqrestore(&pgdat->lru_lock, flags);
+
+	splice->lru_head = NULL;
+	splice->pgculled = 0;
+}
+
+static void add_page_to_lru_splice(struct page *page,
+				   struct lru_splice *splice,
+				   struct lruvec *lruvec, enum lru_list lru)
+{
+	int zid;
+
+	if (splice->lru_head == &lruvec->lists[lru]) {
+		list_add(&page->lru, &splice->splice);
+		splice->nr_pages[page_zonenum(page)] += hpage_nr_pages(page);
+		return;
+	}
+
+	INIT_LIST_HEAD(&splice->splice);
+	splice->lruvec = lruvec;
+	splice->lru_head = &lruvec->lists[lru];
+	splice->lru = lru;
+	list_add(&page->lru, &splice->splice);
+	for (zid = 0; zid < MAX_NR_ZONES; zid++)
+		splice->nr_pages[zid] = 0;
+	splice->nr_pages[page_zonenum(page)] = hpage_nr_pages(page);
+
+}
+
+/*
+ * Similar in functionality to __pagevec_lru_add_fn() but here the page is
+ * being added to an lru_splice and the LRU lock is not held.
+ */
+static void page_lru_splice_add(struct page *page, struct lruvec *lruvec, struct lru_splice *splice)
+{
+	enum lru_list lru;
+	int was_unevictable = TestClearPageUnevictable(page);
+
+	VM_BUG_ON_PAGE(PageLRU(page), page);
+	/* XXX only supports unevictable pages at the moment */
+	VM_BUG_ON_PAGE(was_unevictable, page);
+
+	SetPageLRU(page);
+	smp_mb();
+
+	lru = LRU_UNEVICTABLE;
+	ClearPageActive(page);
+	SetPageUnevictable(page);
+	if (!was_unevictable)
+		splice->pgculled++;
+
+	add_page_to_lru_splice(page, splice, lruvec, lru);
+	trace_mm_lru_insertion(page, lru);
+}
+
+static void lru_splice_add(struct page *page, struct lru_splice *splice)
+{
+	struct pglist_data *pagepgdat, *pgdat = splice->pgdat;
+	struct lruvec *lruvec;
+
+	pagepgdat = page_pgdat(page);
+
+	if (pagepgdat != pgdat) {
+		if (pgdat)
+			add_splice_to_lru_list(splice);
+		splice->pgdat = pagepgdat;
+	}
+
+	lruvec = mem_cgroup_page_lruvec(page, pagepgdat);
+	page_lru_splice_add(page, lruvec, splice);
+}
+
+void lru_splice_add_anon(struct page *page, struct lru_splice *splice)
+{
+	if (PageActive(page))
+		ClearPageActive(page);
+	get_page(page);
+
+	lru_splice_add(page, splice);
+
+	put_page(page);
+}
+
 static void pagevec_lru_move_fn(struct pagevec *pvec,
 	void (*move_fn)(struct page *page, struct lruvec *lruvec, void *arg),
 	void *arg)
-- 
2.13.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
