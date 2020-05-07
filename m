Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2120.oracle.com ([141.146.126.78])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWUfV-0007YO-BY
 for kexec@lists.infradead.org; Thu, 07 May 2020 00:45:52 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC 05/43] mm: PKRAM: support preserving transparent hugepages
Date: Wed,  6 May 2020 17:41:31 -0700
Message-Id: <1588812129-8596-6-git-send-email-anthony.yznaga@oracle.com>
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

Support preserving a transparent hugepage by recording the page order and
a flag indicating it is a THP.  Use these values when the page is
restored to reconstruct the THP.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |  2 ++
 mm/pkram.c            | 20 ++++++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index f338d1c2aeb6..584cadb662b4 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -33,6 +33,8 @@ int pkram_prepare_load_obj(struct pkram_stream *ps);
 void pkram_finish_load(struct pkram_stream *ps);
 void pkram_finish_load_obj(struct pkram_stream *ps);
 
+#define PKRAM_PAGE_TRANS_HUGE	0x1	/* page is a transparent hugepage */
+
 int pkram_save_page(struct pkram_stream *ps, struct page *page, short flags);
 struct page *pkram_load_page(struct pkram_stream *ps, unsigned long *index,
 			     short *flags);
diff --git a/mm/pkram.c b/mm/pkram.c
index ab3053ca3539..9164060e36f5 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -21,6 +21,7 @@ typedef __u64 pkram_entry_t;
 
 #define PKRAM_ENTRY_FLAGS_SHIFT	0x5
 #define PKRAM_ENTRY_FLAGS_MASK	0x7f
+#define PKRAM_ENTRY_ORDER_MASK	0x1f
 
 /*
  * Keeps references to data pages saved to PKRAM.
@@ -434,6 +435,7 @@ static int __pkram_save_page(struct pkram_stream *ps,
 	struct pkram_link *link = ps->link;
 	struct pkram_obj *obj = ps->obj;
 	pkram_entry_t p;
+	int order;
 
 	if (!link || ps->entry_idx >= PKRAM_LINK_ENTRIES_MAX ||
 	    index != ps->next_index) {
@@ -452,10 +454,15 @@ static int __pkram_save_page(struct pkram_stream *ps,
 		ps->next_index = link->index = index;
 	}
 
-	ps->next_index++;
+	if (PageTransHuge(page))
+		flags |= PKRAM_PAGE_TRANS_HUGE;
+
+	order = compound_order(page);
+	ps->next_index += (1 << order);
 
 	get_page(page);
 	p = page_to_phys(page);
+	p |= order;
 	p |= ((flags & PKRAM_ENTRY_FLAGS_MASK) << PKRAM_ENTRY_FLAGS_SHIFT);
 	link->entry[ps->entry_idx] = p;
 	ps->entry_idx++;
@@ -485,8 +492,6 @@ int pkram_save_page(struct pkram_stream *ps, struct page *page, short flags)
 
 	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
 
-	BUG_ON(PageCompound(page));
-
 	return __pkram_save_page(ps, page, flags, page->index);
 }
 
@@ -499,6 +504,7 @@ static struct page *__pkram_load_page(struct pkram_stream *ps, unsigned long *in
 	struct pkram_link *link = ps->link;
 	struct page *page;
 	pkram_entry_t p;
+	int order;
 	short flgs;
 
 	if (!link) {
@@ -517,14 +523,20 @@ static struct page *__pkram_load_page(struct pkram_stream *ps, unsigned long *in
 	BUG_ON(!p);
 
 	flgs = (p >> PKRAM_ENTRY_FLAGS_SHIFT) & PKRAM_ENTRY_FLAGS_MASK;
+	order = p & PKRAM_ENTRY_ORDER_MASK;
 	page = pfn_to_page(PHYS_PFN(p));
 
+	if (flgs & PKRAM_PAGE_TRANS_HUGE) {
+		prep_compound_page(page, order);
+		prep_transhuge_page(page);
+	}
+
 	if (flags)
 		*flags = flgs;
 	if (index)
 		*index = ps->next_index;
 
-	ps->next_index++;
+	ps->next_index += (1 << order);
 
 	/* clear to avoid double free (see pkram_truncate_link()) */
 	link->entry[ps->entry_idx] = 0;
-- 
2.13.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
