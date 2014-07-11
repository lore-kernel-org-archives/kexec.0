Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X5YCN-0005RT-1X
 for kexec@lists.infradead.org; Fri, 11 Jul 2014 10:37:04 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [PATCH] kexec: Export free_huge_page to VMCOREINFO
Date: Fri, 11 Jul 2014 10:34:57 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE972400F3@BPXM01GP.gisp.nec.co.jp>
Content-Language: ja-JP
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
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

PG_head_mask was added into VMCOREINFO to filter huge pages in
commit:b3acc56bfe1(kexec: save PG_head_mask in VMCOREINFO), but
makedumpfile still need another symbol to filter *hugetlbfs* pages.

If a user hope to filter user pages, makedumpfile tries to exclude
them by checking the condition whether the page is anonymous, but
hugetlbfs pages aren't anonymous while they also be user pages.

We know it's possible to detect them in the same way as PageHuge(),
so we need the start address of free_huge_page():

    int PageHuge(struct page *page)
    {
            if (!PageCompound(page))
                    return 0;

            page = compound_head(page);
            return get_compound_page_dtor(page) == free_huge_page;
    }

For that reason, this patch changes free_huge_page() into public
to export it to VMCOREINFO.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 include/linux/hugetlb.h | 1 +
 kernel/kexec.c          | 2 ++
 mm/hugetlb.c            | 2 +-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 255cd5c..a23c096 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -80,6 +80,7 @@ int dequeue_hwpoisoned_huge_page(struct page *page);
 bool isolate_huge_page(struct page *page, struct list_head *list);
 void putback_active_hugepage(struct page *page);
 bool is_hugepage_active(struct page *page);
+void free_huge_page(struct page *page);
 
 #ifdef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
 pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud);
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 369f41a..23a088f 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -33,6 +33,7 @@
 #include <linux/swap.h>
 #include <linux/syscore_ops.h>
 #include <linux/compiler.h>
+#include <linux/hugetlb.h>
 
 #include <asm/page.h>
 #include <asm/uaccess.h>
@@ -1619,6 +1620,7 @@ static int __init crash_save_vmcoreinfo_init(void)
 #endif
 	VMCOREINFO_NUMBER(PG_head_mask);
 	VMCOREINFO_NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE);
+	VMCOREINFO_SYMBOL(free_huge_page);
 
 	arch_crash_save_vmcoreinfo();
 	update_vmcoreinfo_note();
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2024bbd..d5437eb 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -856,7 +856,7 @@ struct hstate *size_to_hstate(unsigned long size)
 	return NULL;
 }
 
-static void free_huge_page(struct page *page)
+void free_huge_page(struct page *page)
 {
 	/*
 	 * Can't pass hstate in here because it is called from the
-- 
1.9.0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
