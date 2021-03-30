Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRLsv-004vXD-CJ
 for kexec@lists.infradead.org; Tue, 30 Mar 2021 21:26:52 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC v2 10/43] PKRAM: pass a list of preserved ranges to the next
 kernel
Date: Tue, 30 Mar 2021 14:35:45 -0700
Message-Id: <1617140178-8773-11-git-send-email-anthony.yznaga@oracle.com>
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

In order to build a new memblock reserved list during boot that
includes ranges preserved by the previous kernel, a list of preserved
ranges is passed to the next kernel via the pkram superblock. The
ranges are stored in ascending order in a linked list of pages. A more
complete memblock list is not prepared to avoid possible conflicts with
changes in a newer kernel and to avoid having to allocate a contiguous
range larger than a page.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 183 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 176 insertions(+), 7 deletions(-)

diff --git a/mm/pkram.c b/mm/pkram.c
index a9e6cd8ca084..4cfa236a4126 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -86,6 +86,20 @@ struct pkram_node {
 #define PKRAM_LOAD		2
 #define PKRAM_ACCMODE_MASK	3
 
+struct pkram_region {
+	phys_addr_t base;
+	phys_addr_t size;
+};
+
+struct pkram_region_list {
+	__u64	prev_pfn;
+	__u64	next_pfn;
+
+	struct pkram_region regions[0];
+};
+
+#define PKRAM_REGIONS_LIST_MAX \
+	((PAGE_SIZE-sizeof(struct pkram_region_list))/sizeof(struct pkram_region))
 /*
  * The PKRAM super block contains data needed to restore the preserved memory
  * structure on boot. The pointer to it (pfn) should be passed via the 'pkram'
@@ -98,13 +112,20 @@ struct pkram_node {
  */
 struct pkram_super_block {
 	__u64	node_pfn;		/* first element of the node list */
+	__u64	region_list_pfn;
+	__u64	nr_regions;
 };
 
+static struct pkram_region_list *pkram_regions_list;
+static int pkram_init_regions_list(void);
+static unsigned long pkram_populate_regions_list(void);
+
 static unsigned long pkram_sb_pfn __initdata;
 static struct pkram_super_block *pkram_sb;
 
 extern int pkram_add_identity_map(struct page *page);
 extern void pkram_remove_identity_map(struct page *page);
+extern void pkram_find_preserved(unsigned long start, unsigned long end, void *private, int (*callback)(unsigned long base, unsigned long size, void *private));
 
 /*
  * For convenience sake PKRAM nodes are kept in an auxiliary doubly-linked list
@@ -862,21 +883,48 @@ static void __pkram_reboot(void)
 	struct page *page;
 	struct pkram_node *node;
 	unsigned long node_pfn = 0;
+	unsigned long rl_pfn = 0;
+	unsigned long nr_regions = 0;
+	int err = 0;
 
-	list_for_each_entry_reverse(page, &pkram_nodes, lru) {
-		node = page_address(page);
-		if (WARN_ON(node->flags & PKRAM_ACCMODE_MASK))
-			continue;
-		node->node_pfn = node_pfn;
-		node_pfn = page_to_pfn(page);
+	if (!list_empty(&pkram_nodes)) {
+		err = pkram_add_identity_map(virt_to_page(pkram_sb));
+		if (err) {
+			pr_err("PKRAM: failed to add super block to pagetable\n");
+			goto done;
+		}
+		list_for_each_entry_reverse(page, &pkram_nodes, lru) {
+			node = page_address(page);
+			if (WARN_ON(node->flags & PKRAM_ACCMODE_MASK))
+				continue;
+			node->node_pfn = node_pfn;
+			node_pfn = page_to_pfn(page);
+		}
+		err = pkram_init_regions_list();
+		if (err) {
+			pr_err("PKRAM: failed to init regions list\n");
+			goto done;
+		}
+		nr_regions = pkram_populate_regions_list();
+		if (IS_ERR_VALUE(nr_regions)) {
+			err = nr_regions;
+			pr_err("PKRAM: failed to populate regions list\n");
+			goto done;
+		}
+		rl_pfn = page_to_pfn(virt_to_page(pkram_regions_list));
 	}
 
+done:
 	/*
 	 * Zero out pkram_sb completely since it may have been passed from
 	 * the previous boot.
 	 */
 	memset(pkram_sb, 0, PAGE_SIZE);
-	pkram_sb->node_pfn = node_pfn;
+	if (!err && node_pfn) {
+		pkram_sb->node_pfn = node_pfn;
+		pkram_sb->region_list_pfn = rl_pfn;
+		pkram_sb->nr_regions = nr_regions;
+	}
 }
 
 static int pkram_reboot(struct notifier_block *notifier,
@@ -952,3 +1000,124 @@ static int __init pkram_init(void)
 	return 0;
 }
 module_init(pkram_init);
+
+static int count_region_cb(unsigned long base, unsigned long size, void *private)
+{
+	unsigned long *nr_regions = (unsigned long *)private;
+
+	(*nr_regions)++;
+	return 0;
+}
+
+static unsigned long pkram_count_regions(void)
+{
+	unsigned long nr_regions = 0;
+
+	pkram_find_preserved(0, PHYS_ADDR_MAX, &nr_regions, count_region_cb);
+
+	return nr_regions;
+}
+
+/*
+ * To faciliate rapidly building a new memblock reserved list during boot
+ * with the addition of preserved memory ranges a regions list is built
+ * before reboot.
+ * The regions list is a linked list of pages with each page containing an
+ * array of preserved memory ranges.  The ranges are stored in each page
+ * and across the list in address order.  A linked list is used rather than
+ * a single contiguous range to mitigate against the possibility that a
+ * larger, contiguous allocation may fail due to fragmentation.
+ *
+ * Since the pages of the regions list must be preserved and the pkram
+ * pagetable is used to determine what ranges are preserved, the list pages
+ * must be allocated and represented in the pkram pagetable before they can
+ * be populated.  Rather than recounting the number of regions after
+ * allocating pages and repeating until a precise number of pages are
+ * are allocated, the number of pages needed is estimated.
+ */
+static int pkram_init_regions_list(void)
+{
+	struct pkram_region_list *rl;
+	unsigned long nr_regions;
+	unsigned long nr_lpages;
+	struct page *page;
+
+	nr_regions = pkram_count_regions();
+
+	nr_lpages = DIV_ROUND_UP(nr_regions, PKRAM_REGIONS_LIST_MAX);
+	nr_regions += nr_lpages;
+	nr_lpages = DIV_ROUND_UP(nr_regions, PKRAM_REGIONS_LIST_MAX);
+
+	for (; nr_lpages; nr_lpages--) {
+		page = pkram_alloc_page(GFP_KERNEL | __GFP_ZERO);
+		if (!page)
+			return -ENOMEM;
+		rl = page_address(page);
+		if (pkram_regions_list) {
+			rl->next_pfn = page_to_pfn(virt_to_page(pkram_regions_list));
+			pkram_regions_list->prev_pfn = page_to_pfn(page);
+		}
+		pkram_regions_list = rl;
+	}
+
+	return 0;
+}
+
+struct pkram_regions_priv {
+	struct pkram_region_list *curr;
+	struct pkram_region_list *last;
+	unsigned long nr_regions;
+	int idx;
+};
+
+static int add_region_cb(unsigned long base, unsigned long size, void *private)
+{
+	struct pkram_regions_priv *priv;
+	struct pkram_region_list *rl;
+	int i;
+
+	priv = (struct pkram_regions_priv *)private;
+	rl = priv->curr;
+	i = priv->idx;
+
+	if (!rl) {
+		WARN_ON(1);
+		return 1;
+	}
+
+	if (!i)
+		priv->last = priv->curr;
+
+	rl->regions[i].base = base;
+	rl->regions[i].size = size;
+
+	priv->nr_regions++;
+	i++;
+	if (i == PKRAM_REGIONS_LIST_MAX) {
+		u64 next_pfn = rl->next_pfn;
+
+		if (next_pfn)
+			priv->curr = pfn_to_kaddr(next_pfn);
+		else
+			priv->curr = NULL;
+
+		i = 0;
+	}
+	priv->idx = i;
+
+	return 0;
+}
+
+static unsigned long pkram_populate_regions_list(void)
+{
+	struct pkram_regions_priv priv = { .curr = pkram_regions_list };
+
+	pkram_find_preserved(0, PHYS_ADDR_MAX, &priv, add_region_cb);
+
+	/*
+	 * Link the first node to the last populated one.
+	 */
+	pkram_regions_list->prev_pfn = page_to_pfn(virt_to_page(priv.last));
+
+	return priv.nr_regions;
+}
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
