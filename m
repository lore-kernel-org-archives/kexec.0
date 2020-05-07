Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWUfX-0003qB-Mi
 for kexec@lists.infradead.org; Thu, 07 May 2020 00:45:54 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC 10/43] PKRAM: add code for walking the preserved pages pagetable
Date: Wed,  6 May 2020 17:41:36 -0700
Message-Id: <1588812129-8596-11-git-send-email-anthony.yznaga@oracle.com>
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

Add the ability to walk the pkram pagetable from high to low addresses
and execute a callback for each contiguous range of preserved or not
preserved memory found.  The reason for walking high to low is to align
with high to low memblock allocation when finding holes that memblocks
can safely be allocated from as will be seen in a later patch.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |  15 +++++
 mm/Makefile           |   2 +-
 mm/pkram_pagetable.c  | 169 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 185 insertions(+), 1 deletion(-)
 create mode 100644 mm/pkram_pagetable.c

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index a58dd2ea835a..b6fa973d37cc 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -25,6 +25,21 @@ struct pkram_stream {
 
 #define PKRAM_NAME_MAX		256	/* including nul */
 
+struct pkram_pg_state {
+	int (*range_cb)(struct pkram_pg_state *state, unsigned long base,
+			unsigned long size);
+	unsigned long curr_addr;
+	unsigned long end_addr;
+	unsigned long min_addr;
+	unsigned long max_addr;
+	unsigned long min_size;
+	bool tracking;
+	bool find_holes;
+	unsigned long retval;
+};
+
+void pkram_walk_pgt_rev(struct pkram_pg_state *st, pgd_t *pgd);
+
 int pkram_prepare_save(struct pkram_stream *ps, const char *name,
 		       gfp_t gfp_mask);
 int pkram_prepare_save_obj(struct pkram_stream *ps);
diff --git a/mm/Makefile b/mm/Makefile
index 59cd381194af..c4ad1c56e237 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -112,4 +112,4 @@ obj-$(CONFIG_MEMFD_CREATE) += memfd.o
 obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
 obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
 obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
-obj-$(CONFIG_PKRAM) += pkram.o
+obj-$(CONFIG_PKRAM) += pkram.o pkram_pagetable.o
diff --git a/mm/pkram_pagetable.c b/mm/pkram_pagetable.c
new file mode 100644
index 000000000000..d31aa36207ba
--- /dev/null
+++ b/mm/pkram_pagetable.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bitops.h>
+#include <asm/pgtable.h>
+#include <linux/pkram.h>
+
+#define pgd_none(a)  (pgtable_l5_enabled() ? pgd_none(a) : p4d_none(__p4d(pgd_val(a))))
+
+static int note_page_rev(struct pkram_pg_state *st, unsigned long curr_size, bool present)
+{
+	unsigned long curr_addr = st->curr_addr;
+	bool track_page = present ^ st->find_holes;
+
+	if (!st->tracking && track_page) {
+		unsigned long end_addr = curr_addr + curr_size;
+
+		if (end_addr <= st->min_addr)
+			return 1;
+
+		st->end_addr = min(end_addr, st->max_addr);
+		st->tracking = true;
+	} else if (st->tracking) {
+		unsigned long base, size;
+
+		/* Continue tracking if lower bound has not been reached */
+		if (track_page && curr_addr && curr_addr >= st->min_addr)
+			return 0;
+
+		if (!track_page)
+			base = max(curr_addr + curr_size, st->min_addr);
+		else
+			base = st->min_addr;
+
+		size = st->end_addr - base;
+		st->tracking = false;
+
+		return st->range_cb(st, base, size);
+	}
+
+	return 0;
+}
+
+static int walk_pte_level_rev(struct pkram_pg_state *st, pmd_t addr, unsigned long P)
+{
+	unsigned long *bitmap;
+	int present;
+	int i, ret;
+
+	bitmap = __va(pmd_val(addr));
+	for (i = PTRS_PER_PTE - 1; i >= 0; i--) {
+		unsigned long curr_addr = P + i * PAGE_SIZE;
+
+		if (curr_addr >= st->max_addr)
+			continue;
+		st->curr_addr = curr_addr;
+
+		present = test_bit(i, bitmap);
+		ret = note_page_rev(st, PAGE_SIZE, present);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static int walk_pmd_level_rev(struct pkram_pg_state *st, pud_t addr, unsigned long P)
+{
+	pmd_t *start;
+	int i, ret;
+
+	start = (pmd_t *)pud_page_vaddr(addr) + PTRS_PER_PMD - 1;
+	for (i = PTRS_PER_PMD - 1; i >= 0; i--, start--) {
+		unsigned long curr_addr = P + i * PMD_SIZE;
+
+		if (curr_addr >= st->max_addr)
+			continue;
+		st->curr_addr = curr_addr;
+
+		if (!pmd_none(*start)) {
+			if (pmd_large(*start))
+				ret = note_page_rev(st, PMD_SIZE, true);
+			else
+				ret = walk_pte_level_rev(st, *start, curr_addr);
+		} else
+			ret = note_page_rev(st, PMD_SIZE, false);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static int walk_pud_level_rev(struct pkram_pg_state *st, p4d_t addr, unsigned long P)
+{
+	pud_t *start;
+	int i, ret;
+
+	start = (pud_t *)p4d_page_vaddr(addr) + PTRS_PER_PUD - 1;
+	for (i = PTRS_PER_PUD - 1; i >= 0 ; i--, start--) {
+		unsigned long curr_addr = P + i * PUD_SIZE;
+
+		if (curr_addr >= st->max_addr)
+			continue;
+		st->curr_addr = curr_addr;
+
+		if (!pud_none(*start)) {
+			if (pud_large(*start))
+				ret = note_page_rev(st, PUD_SIZE, true);
+			else
+				ret = walk_pmd_level_rev(st, *start, curr_addr);
+		} else
+			ret = note_page_rev(st, PUD_SIZE, false);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static int walk_p4d_level_rev(struct pkram_pg_state *st, pgd_t addr, unsigned long P)
+{
+	p4d_t *start;
+	int i, ret;
+
+	if (PTRS_PER_P4D == 1)
+		return walk_pud_level_rev(st, __p4d(pgd_val(addr)), P);
+
+	start = (p4d_t *)pgd_page_vaddr(addr) + PTRS_PER_P4D - 1;
+	for (i = PTRS_PER_P4D - 1; i >= 0; i--, start--) {
+		unsigned long curr_addr = P + i * P4D_SIZE;
+
+		if (curr_addr >= st->max_addr)
+			continue;
+		st->curr_addr = curr_addr;
+
+		if (!p4d_none(*start)) {
+			if (p4d_large(*start))
+				ret = note_page_rev(st, P4D_SIZE, true);
+			else
+				ret = walk_pud_level_rev(st, *start, curr_addr);
+		} else
+			ret = note_page_rev(st, P4D_SIZE, false);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+void pkram_walk_pgt_rev(struct pkram_pg_state *st, pgd_t *pgd)
+{
+	pgd_t *start;
+	int i, ret;
+
+	start = pgd + PTRS_PER_PGD - 1;
+	for (i = PTRS_PER_PGD - 1; i >= 0; i--, start--) {
+		unsigned long curr_addr = i * PGDIR_SIZE;
+
+		if (curr_addr >= st->max_addr)
+			continue;
+		st->curr_addr = curr_addr;
+
+		if (!pgd_none(*start))
+			ret = walk_p4d_level_rev(st, *start, curr_addr);
+		else
+			ret = note_page_rev(st, PGDIR_SIZE, false);
+		if (ret)
+			break;
+	}
+}
-- 
2.13.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
