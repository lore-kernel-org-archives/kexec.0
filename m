Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWUdh-0007eY-NR
 for kexec@lists.infradead.org; Thu, 07 May 2020 00:43:51 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC 13/43] mm: PKRAM: free preserved pages pagetable
Date: Wed,  6 May 2020 17:41:39 -0700
Message-Id: <1588812129-8596-14-git-send-email-anthony.yznaga@oracle.com>
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

After the page ranges in the pagetable have been reserved the pagetable
is no longer needed.  Rather than free it during early boot by unreserving
page-sized blocks which can be inefficient when dealing with a large number
of blocks, wait until the page structs have been initialized and free them
as pages.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 arch/x86/mm/init_64.c |  1 +
 include/linux/pkram.h |  3 ++
 mm/pkram.c            | 11 +++++++
 mm/pkram_pagetable.c  | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 97 insertions(+)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index ae569ef6bd7d..72662615977b 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1245,6 +1245,7 @@ void __init mem_init(void)
 	after_bootmem = 1;
 	x86_init.hyper.init_after_bootmem();
 
+	pkram_free_pgt();
 	totalram_pages_add(pkram_reserved_pages);
 	/*
 	 * Must be done after boot memory is put on freelist, because here we
diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index 1b475f6e1598..edc5d8bef9d3 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -39,6 +39,7 @@ struct pkram_pg_state {
 };
 
 void pkram_walk_pgt_rev(struct pkram_pg_state *st, pgd_t *pgd);
+void pkram_free_pgt_walk_pgd(pgd_t *pgd);
 
 int pkram_prepare_save(struct pkram_stream *ps, const char *name,
 		       gfp_t gfp_mask);
@@ -64,9 +65,11 @@ size_t pkram_read(struct pkram_stream *ps, void *buf, size_t count);
 #ifdef CONFIG_PKRAM
 extern unsigned long pkram_reserved_pages;
 void pkram_reserve(void);
+void pkram_free_pgt(void);
 #else
 #define pkram_reserved_pages 0UL
 static inline void pkram_reserve(void) { }
+static inline void pkram_free_pgt(void) { }
 #endif
 
 #endif /* _LINUX_PKRAM_H */
diff --git a/mm/pkram.c b/mm/pkram.c
index 2c323154df76..dd3c89614010 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -1227,3 +1227,14 @@ static int __init pkram_reserve_page_ranges(pgd_t *pgd)
 
 	return err;
 }
+
+void pkram_free_pgt(void)
+{
+	if (!pkram_pgd)
+		return;
+
+	pkram_free_pgt_walk_pgd(pkram_pgd);
+
+	__free_pages_core(virt_to_page(pkram_pgd), 0);
+	pkram_pgd = NULL;
+}
diff --git a/mm/pkram_pagetable.c b/mm/pkram_pagetable.c
index d31aa36207ba..7033e9b1c47f 100644
--- a/mm/pkram_pagetable.c
+++ b/mm/pkram_pagetable.c
@@ -3,6 +3,8 @@
 #include <asm/pgtable.h>
 #include <linux/pkram.h>
 
+#include "internal.h"
+
 #define pgd_none(a)  (pgtable_l5_enabled() ? pgd_none(a) : p4d_none(__p4d(pgd_val(a))))
 
 static int note_page_rev(struct pkram_pg_state *st, unsigned long curr_size, bool present)
@@ -167,3 +169,83 @@ void pkram_walk_pgt_rev(struct pkram_pg_state *st, pgd_t *pgd)
 			break;
 	}
 }
+
+static void pkram_free_pgt_walk_pmd(pud_t addr)
+{
+	unsigned long bitmap_pa;
+	struct page *page;
+	pmd_t *start;
+	int i;
+
+	start = (pmd_t *)pud_page_vaddr(addr);
+	for (i = 0; i < PTRS_PER_PMD; i++, start++) {
+		if (!pmd_none(*start)) {
+			bitmap_pa = pte_val(pte_clrhuge(*(pte_t *)start));
+			if (pmd_large(*start) && !bitmap_pa)
+				continue;
+			page = virt_to_page(__va(bitmap_pa));
+			__free_pages_core(page, 0);
+		}
+	}
+}
+
+static void pkram_free_pgt_walk_pud(p4d_t addr)
+{
+	struct page *page;
+	pud_t *start;
+	int i;
+
+	start = (pud_t *)p4d_page_vaddr(addr);
+	for (i = 0; i < PTRS_PER_PUD; i++, start++) {
+		if (!pud_none(*start)) {
+			if (pud_large(*start)) {
+				WARN_ONCE(1, "PKRAM: unexpected pud hugepage\n");
+				continue;
+			}
+			pkram_free_pgt_walk_pmd(*start);
+			page = virt_to_page(__va(pud_val(*start)));
+			__free_pages_core(page, 0);
+		}
+	}
+}
+
+static void pkram_free_pgt_walk_p4d(pgd_t addr)
+{
+	struct page *page;
+	p4d_t *start;
+	int i;
+
+	if (PTRS_PER_P4D == 1)
+		return pkram_free_pgt_walk_pud(__p4d(pgd_val(addr)));
+
+	start = (p4d_t *)pgd_page_vaddr(addr);
+	for (i = 0; i < PTRS_PER_P4D; i++, start++) {
+		if (!p4d_none(*start)) {
+			if (p4d_large(*start)) {
+				WARN_ONCE(1, "PKRAM: unexpected p4d hugepage\n");
+				continue;
+			}
+			pkram_free_pgt_walk_pud(*start);
+			page = virt_to_page(__va(p4d_val(*start)));
+			__free_pages_core(page, 0);
+		}
+	}
+}
+
+/*
+ * Free the pagetable passed from the previous boot.
+ */
+void pkram_free_pgt_walk_pgd(pgd_t *pgd)
+{
+	pgd_t *start = pgd;
+	struct page *page;
+	int i;
+
+	for (i = 0; i < PTRS_PER_PGD; i++, start++) {
+		if (!pgd_none(*start)) {
+			pkram_free_pgt_walk_p4d(*start);
+			page = virt_to_page(__va(pgd_val(*start)));
+			__free_pages_core(page, 0);
+		}
+	}
+}
-- 
2.13.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
