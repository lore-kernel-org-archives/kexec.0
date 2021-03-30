Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2130.oracle.com ([141.146.126.79])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRLsq-004vUN-0y
 for kexec@lists.infradead.org; Tue, 30 Mar 2021 21:26:46 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC v2 05/43] mm: PKRAM: support preserving transparent hugepages
Date: Tue, 30 Mar 2021 14:35:40 -0700
Message-Id: <1617140178-8773-6-git-send-email-anthony.yznaga@oracle.com>
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

Support preserving a transparent hugepage by recording the page order and
a flag indicating it is a THP.  Use these values when the page is
restored to reconstruct the THP.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/mm/pkram.c b/mm/pkram.c
index 9c42db66d022..da44a6060c5f 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -21,6 +21,9 @@
 
 #define PKRAM_ENTRY_FLAGS_SHIFT	0x5
 #define PKRAM_ENTRY_FLAGS_MASK	0x7f
+#define PKRAM_ENTRY_ORDER_MASK	0x1f
+
+#define PKRAM_PAGE_TRANS_HUGE	0x1	/* page is a transparent hugepage */
 
 /*
  * Keeps references to data pages saved to PKRAM.
@@ -211,7 +214,11 @@ static void pkram_add_link_entry(struct pkram_data_stream *pds, struct page *pag
 	pkram_entry_t p;
 	short flags = 0;
 
+	if (PageTransHuge(page))
+		flags |= PKRAM_PAGE_TRANS_HUGE;
+
 	p = page_to_phys(page);
+	p |= compound_order(page);
 	p |= ((flags & PKRAM_ENTRY_FLAGS_MASK) << PKRAM_ENTRY_FLAGS_SHIFT);
 	link->entry[pds->entry_idx] = p;
 	pds->entry_idx++;
@@ -516,7 +523,7 @@ static int __pkram_save_page(struct pkram_access *pa, struct page *page,
 
 	pkram_add_link_entry(pds, page);
 
-	pa->pages.next_index++;
+	pa->pages.next_index += compound_nr(page);
 
 	return 0;
 }
@@ -542,19 +549,24 @@ int pkram_save_file_page(struct pkram_access *pa, struct page *page)
 
 	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
 
-	BUG_ON(PageCompound(page));
-
 	return __pkram_save_page(pa, page, page->index);
 }
 
 static struct page *__pkram_prep_load_page(pkram_entry_t p)
 {
 	struct page *page;
+	int order;
 	short flags;
 
 	flags = (p >> PKRAM_ENTRY_FLAGS_SHIFT) & PKRAM_ENTRY_FLAGS_MASK;
 	page = pfn_to_page(PHYS_PFN(p));
 
+	if (flags & PKRAM_PAGE_TRANS_HUGE) {
+		order = p & PKRAM_ENTRY_ORDER_MASK;
+		prep_compound_page(page, order);
+		prep_transhuge_page(page);
+	}
+
 	return page;
 }
 
@@ -588,7 +600,7 @@ static struct page *__pkram_load_page(struct pkram_access *pa, unsigned long *in
 
 	if (index) {
 		*index = pa->pages.next_index;
-		pa->pages.next_index++;
+		pa->pages.next_index += compound_nr(page);
 	}
 
 	/* clear to avoid double free (see pkram_truncate_link()) */
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
