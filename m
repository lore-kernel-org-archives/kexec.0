Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2120.oracle.com ([156.151.31.85])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRLsv-004vXE-IN
 for kexec@lists.infradead.org; Tue, 30 Mar 2021 21:26:52 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC v2 09/43] PKRAM: track preserved pages in a physical mapping
 pagetable
Date: Tue, 30 Mar 2021 14:35:44 -0700
Message-Id: <1617140178-8773-10-git-send-email-anthony.yznaga@oracle.com>
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

Later patches in this series will need a way to efficiently identify
physically contiguous ranges of preserved pages independent of their
virtual addresses. To facilitate this all pages to be preserved across
kexec are added to a pseudo identity mapping pagetable.

The pagetable makes use of the existing architecture definitions for
building a memory mapping pagetable except that a bitmap is used to
represent the presence or absence of preserved pages at the PTE level.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/Makefile          |   2 +-
 mm/pkram.c           |  30 +++-
 mm/pkram_pagetable.c | 376 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 404 insertions(+), 4 deletions(-)
 create mode 100644 mm/pkram_pagetable.c

diff --git a/mm/Makefile b/mm/Makefile
index ab3a724769b5..f5c0dd0a3707 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -120,4 +120,4 @@ obj-$(CONFIG_MEMFD_CREATE) += memfd.o
 obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
 obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
 obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
-obj-$(CONFIG_PKRAM) += pkram.o
+obj-$(CONFIG_PKRAM) += pkram.o pkram_pagetable.o
diff --git a/mm/pkram.c b/mm/pkram.c
index 2809371a9aec..a9e6cd8ca084 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -103,6 +103,9 @@ struct pkram_super_block {
 static unsigned long pkram_sb_pfn __initdata;
 static struct pkram_super_block *pkram_sb;
 
+extern int pkram_add_identity_map(struct page *page);
+extern void pkram_remove_identity_map(struct page *page);
+
 /*
  * For convenience sake PKRAM nodes are kept in an auxiliary doubly-linked list
  * connected through the lru field of the page struct.
@@ -121,11 +124,24 @@ static int __init parse_pkram_sb_pfn(char *arg)
 
 static inline struct page *pkram_alloc_page(gfp_t gfp_mask)
 {
-	return alloc_page(gfp_mask);
+	struct page *page;
+	int err;
+
+	page = alloc_page(gfp_mask);
+	if (page) {
+		err = pkram_add_identity_map(page);
+		if (err) {
+			__free_page(page);
+			page = NULL;
+		}
+	}
+
+	return page;
 }
 
 static inline void pkram_free_page(void *addr)
 {
+	pkram_remove_identity_map(virt_to_page(addr));
 	free_page((unsigned long)addr);
 }
 
@@ -163,6 +179,7 @@ static void pkram_truncate_link(struct pkram_link *link)
 		if (!p)
 			continue;
 		page = pfn_to_page(PHYS_PFN(p));
+		pkram_remove_identity_map(page);
 		put_page(page);
 	}
 }
@@ -615,10 +632,15 @@ static int __pkram_save_page(struct pkram_access *pa, struct page *page,
 int pkram_save_file_page(struct pkram_access *pa, struct page *page)
 {
 	struct pkram_node *node = pa->ps->node;
+	int err;
 
 	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
 
-	return __pkram_save_page(pa, page, page->index);
+	err = __pkram_save_page(pa, page, page->index);
+	if (!err)
+		err = pkram_add_identity_map(page);
+
+	return err;
 }
 
 static int __pkram_bytes_save_page(struct pkram_access *pa, struct page *page)
@@ -652,6 +674,8 @@ static struct page *__pkram_prep_load_page(pkram_entry_t p)
 		prep_transhuge_page(page);
 	}
 
+	pkram_remove_identity_map(page);
+
 	return page;
 }
 
@@ -898,7 +922,7 @@ static int __init pkram_init_sb(void)
 	if (!pkram_sb) {
 		struct page *page;
 
-		page = pkram_alloc_page(GFP_KERNEL | __GFP_ZERO);
+		page = alloc_page(GFP_KERNEL | __GFP_ZERO);
 		if (!page) {
 			pr_err("PKRAM: Failed to allocate super block\n");
 			return 0;
diff --git a/mm/pkram_pagetable.c b/mm/pkram_pagetable.c
new file mode 100644
index 000000000000..9c5443bd7686
--- /dev/null
+++ b/mm/pkram_pagetable.c
@@ -0,0 +1,376 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bitops.h>
+//#include <asm/pgtable.h>
+#include <linux/mm.h>
+
+static pgd_t *pkram_pgd;
+static DEFINE_SPINLOCK(pkram_pgd_lock);
+
+#define set_p4d(p4dp, p4d)	WRITE_ONCE(*(p4dp), (p4d))
+
+#define PKRAM_PTE_BM_BYTES	(PTRS_PER_PTE / BITS_PER_BYTE)
+#define PKRAM_PTE_BM_MASK	(PAGE_SIZE / PKRAM_PTE_BM_BYTES - 1)
+
+static pmd_t make_bitmap_pmd(unsigned long *bitmap)
+{
+	unsigned long val;
+
+	val = __pa(ALIGN_DOWN((unsigned long)bitmap, PAGE_SIZE));
+	val |= (((unsigned long)bitmap & ~PAGE_MASK) / PKRAM_PTE_BM_BYTES);
+
+	return __pmd(val);
+}
+
+static unsigned long *get_bitmap_addr(pmd_t pmd)
+{
+	unsigned long val, off;
+
+	val = pmd_val(pmd);
+	off = (val & PKRAM_PTE_BM_MASK) * PKRAM_PTE_BM_BYTES;
+
+	val = (val & PAGE_MASK) + off;
+
+	return __va(val);
+}
+
+int pkram_add_identity_map(struct page *page)
+{
+	unsigned long paddr;
+	unsigned long *bitmap;
+	unsigned int index;
+	struct page *pg;
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	if (!pkram_pgd) {
+		spin_lock(&pkram_pgd_lock);
+		if (!pkram_pgd) {
+			pg = alloc_page(GFP_ATOMIC|__GFP_ZERO);
+			if (!pg)
+				goto nomem;
+			pkram_pgd = page_address(pg);
+		}
+		spin_unlock(&pkram_pgd_lock);
+	}
+
+	paddr = __pa(page_address(page));
+	pgd = pkram_pgd;
+	pgd += pgd_index(paddr);
+	if (pgd_none(*pgd)) {
+		spin_lock(&pkram_pgd_lock);
+		if (pgd_none(*pgd)) {
+			pg = alloc_page(GFP_ATOMIC|__GFP_ZERO);
+			if (!pg)
+				goto nomem;
+			p4d = page_address(pg);
+			set_pgd(pgd, __pgd(__pa(p4d)));
+		}
+		spin_unlock(&pkram_pgd_lock);
+	}
+	p4d = p4d_offset(pgd, paddr);
+	if (p4d_none(*p4d)) {
+		spin_lock(&pkram_pgd_lock);
+		if (p4d_none(*p4d)) {
+			pg = alloc_page(GFP_ATOMIC|__GFP_ZERO);
+			if (!pg)
+				goto nomem;
+			pud = page_address(pg);
+			set_p4d(p4d, __p4d(__pa(pud)));
+		}
+		spin_unlock(&pkram_pgd_lock);
+	}
+	pud = pud_offset(p4d, paddr);
+	if (pud_none(*pud)) {
+		spin_lock(&pkram_pgd_lock);
+		if (pud_none(*pud)) {
+			pg = alloc_page(GFP_ATOMIC|__GFP_ZERO);
+			if (!pg)
+				goto nomem;
+			pmd = page_address(pg);
+			set_pud(pud, __pud(__pa(pmd)));
+		}
+		spin_unlock(&pkram_pgd_lock);
+	}
+	pmd = pmd_offset(pud, paddr);
+	if (pmd_none(*pmd)) {
+		spin_lock(&pkram_pgd_lock);
+		if (pmd_none(*pmd)) {
+			if (PageTransHuge(page)) {
+				set_pmd(pmd, pmd_mkhuge(*pmd));
+				spin_unlock(&pkram_pgd_lock);
+				goto done;
+			}
+			bitmap = bitmap_zalloc(PTRS_PER_PTE, GFP_ATOMIC);
+			if (!bitmap)
+				goto nomem;
+			set_pmd(pmd, make_bitmap_pmd(bitmap));
+		} else {
+			BUG_ON(pmd_large(*pmd));
+			bitmap = get_bitmap_addr(*pmd);
+		}
+		spin_unlock(&pkram_pgd_lock);
+	} else {
+		BUG_ON(pmd_large(*pmd));
+		bitmap = get_bitmap_addr(*pmd);
+	}
+
+	index = pte_index(paddr);
+	BUG_ON(test_bit(index, bitmap));
+	set_bit(index, bitmap);
+	smp_mb__after_atomic();
+	if (bitmap_full(bitmap, PTRS_PER_PTE))
+		set_pmd(pmd, pmd_mkhuge(*pmd));
+done:
+	return 0;
+nomem:
+	return -ENOMEM;
+}
+
+void pkram_remove_identity_map(struct page *page)
+{
+	unsigned long *bitmap;
+	unsigned long paddr;
+	unsigned int index;
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	/*
+	 * pkram_pgd will be null when freeing metadata pages after a reboot
+	 */
+	if (!pkram_pgd)
+		return;
+
+	paddr = __pa(page_address(page));
+	pgd = pkram_pgd;
+	pgd += pgd_index(paddr);
+	if (pgd_none(*pgd)) {
+		WARN_ONCE(1, "PKRAM: %s: no pgd for 0x%lx\n", __func__, paddr);
+		return;
+	}
+	p4d = p4d_offset(pgd, paddr);
+	if (p4d_none(*p4d)) {
+		WARN_ONCE(1, "PKRAM: %s: no p4d for 0x%lx\n", __func__, paddr);
+		return;
+	}
+	pud = pud_offset(p4d, paddr);
+	if (pud_none(*pud)) {
+		WARN_ONCE(1, "PKRAM: %s: no pud for 0x%lx\n", __func__, paddr);
+		return;
+	}
+	pmd = pmd_offset(pud, paddr);
+	if (pmd_none(*pmd)) {
+		WARN_ONCE(1, "PKRAM: %s: no pmd for 0x%lx\n", __func__, paddr);
+		return;
+	}
+	if (PageTransHuge(page)) {
+		BUG_ON(!pmd_large(*pmd));
+		pmd_clear(pmd);
+		return;
+	}
+
+	if (pmd_large(*pmd)) {
+		spin_lock(&pkram_pgd_lock);
+		if (pmd_large(*pmd))
+			set_pmd(pmd, __pmd(pte_val(pte_clrhuge(*(pte_t *)pmd))));
+		spin_unlock(&pkram_pgd_lock);
+	}
+
+	bitmap = get_bitmap_addr(*pmd);
+	index = pte_index(paddr);
+	clear_bit(index, bitmap);
+	smp_mb__after_atomic();
+
+	spin_lock(&pkram_pgd_lock);
+	if (!pmd_none(*pmd) && bitmap_empty(bitmap, PTRS_PER_PTE)) {
+		pmd_clear(pmd);
+		spin_unlock(&pkram_pgd_lock);
+		bitmap_free(bitmap);
+	} else {
+		spin_unlock(&pkram_pgd_lock);
+	}
+}
+
+struct pkram_pg_state {
+	int (*range_cb)(unsigned long base, unsigned long size, void *private);
+	unsigned long start_addr;
+	unsigned long curr_addr;
+	unsigned long min_addr;
+	unsigned long max_addr;
+	void *private;
+	bool tracking;
+};
+
+#define pgd_none(a)  (pgtable_l5_enabled() ? pgd_none(a) : p4d_none(__p4d(pgd_val(a))))
+
+static int note_page(struct pkram_pg_state *st, unsigned long addr, bool present)
+{
+	if (!st->tracking && present) {
+		if (addr >= st->max_addr)
+			return 1;
+		/*
+		 * addr can be < min_addr if the page straddles the
+		 * boundary
+		 */
+		st->start_addr = max(addr, st->min_addr);
+		st->tracking = true;
+	} else if (st->tracking) {
+		unsigned long base, size;
+		int ret;
+
+		/* Continue tracking if upper bound has not been reached */
+		if (present && addr < st->max_addr)
+			return 0;
+
+		addr = min(addr, st->max_addr);
+
+		base = st->start_addr;
+		size = addr - st->start_addr;
+		st->tracking = false;
+
+		ret = st->range_cb(base, size, st->private);
+
+		if (addr == st->max_addr)
+			return 1;
+		else
+			return ret;
+	}
+
+	return 0;
+}
+
+static int walk_pte_level(struct pkram_pg_state *st, pmd_t addr, unsigned long P)
+{
+	unsigned long *bitmap;
+	int present;
+	int i, ret;
+
+	bitmap = get_bitmap_addr(addr);
+	for (i = 0; i < PTRS_PER_PTE; i++) {
+		unsigned long curr_addr = P + i * PAGE_SIZE;
+
+		if (curr_addr < st->min_addr)
+			continue;
+		present = test_bit(i, bitmap);
+		ret = note_page(st, curr_addr, present);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static int walk_pmd_level(struct pkram_pg_state *st, pud_t addr, unsigned long P)
+{
+	pmd_t *start;
+	int i, ret;
+
+	start = (pmd_t *)pud_page_vaddr(addr);
+	for (i = 0; i < PTRS_PER_PMD; i++, start++) {
+		unsigned long curr_addr = P + i * PMD_SIZE;
+
+		if (curr_addr + PMD_SIZE <= st->min_addr)
+			continue;
+		if (!pmd_none(*start)) {
+			if (pmd_large(*start))
+				ret = note_page(st, curr_addr, true);
+			else
+				ret = walk_pte_level(st, *start, curr_addr);
+		} else
+			ret = note_page(st, curr_addr, false);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static int walk_pud_level(struct pkram_pg_state *st, p4d_t addr, unsigned long P)
+{
+	pud_t *start;
+	int i, ret;
+
+	start = (pud_t *)p4d_page_vaddr(addr);
+	for (i = 0; i < PTRS_PER_PUD; i++, start++) {
+		unsigned long curr_addr = P + i * PUD_SIZE;
+
+		if (curr_addr + PUD_SIZE <= st->min_addr)
+			continue;
+		if (!pud_none(*start)) {
+			if (pud_large(*start))
+				ret = note_page(st, curr_addr, true);
+			else
+				ret = walk_pmd_level(st, *start, curr_addr);
+		} else
+			ret = note_page(st, curr_addr, false);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static int walk_p4d_level(struct pkram_pg_state *st, pgd_t addr, unsigned long P)
+{
+	p4d_t *start;
+	int i, ret;
+
+	if (PTRS_PER_P4D == 1)
+		return walk_pud_level(st, __p4d(pgd_val(addr)), P);
+
+	start = (p4d_t *)pgd_page_vaddr(addr);
+	for (i = 0; i < PTRS_PER_P4D; i++, start++) {
+		unsigned long curr_addr = P + i * P4D_SIZE;
+
+		if (curr_addr + P4D_SIZE <= st->min_addr)
+			continue;
+		if (!p4d_none(*start)) {
+			if (p4d_large(*start))
+				ret = note_page(st, curr_addr, true);
+			else
+				ret = walk_pud_level(st, *start, curr_addr);
+		} else
+			ret = note_page(st, curr_addr, false);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+void pkram_walk_pgt(struct pkram_pg_state *st, pgd_t *pgd)
+{
+	pgd_t *start = pgd;
+	int i, ret = 0;
+
+	for (i = 0; i < PTRS_PER_PGD; i++, start++) {
+		unsigned long curr_addr = i * PGDIR_SIZE;
+
+		if (curr_addr + PGDIR_SIZE <= st->min_addr)
+			continue;
+		if (!pgd_none(*start))
+			ret = walk_p4d_level(st, *start, curr_addr);
+		else
+			ret = note_page(st, curr_addr, false);
+		if (ret)
+			break;
+	}
+}
+
+void pkram_find_preserved(unsigned long start, unsigned long end, void *private, int (*callback)(unsigned long base, unsigned long size, void *private))
+{
+	struct pkram_pg_state st = {
+		.range_cb = callback,
+		.min_addr = start,
+		.max_addr = end,
+		.private = private,
+	};
+
+	if (!pkram_pgd)
+		return;
+
+	pkram_walk_pgt(&st, pkram_pgd);
+}
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
