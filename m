Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2120.oracle.com ([141.146.126.78])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWUeV-00007x-0T
 for kexec@lists.infradead.org; Thu, 07 May 2020 00:44:41 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC 21/43] x86/KASLR: PKRAM: support physical kaslr
Date: Wed,  6 May 2020 17:41:47 -0700
Message-Id: <1588812129-8596-22-git-send-email-anthony.yznaga@oracle.com>
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

Avoid regions of memory that contain preserved pages when computing
slots used to select where to put the decompressed kernel.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 arch/x86/boot/compressed/Makefile |   3 +
 arch/x86/boot/compressed/kaslr.c  |  67 ++++++----
 arch/x86/boot/compressed/misc.h   |  19 +++
 arch/x86/boot/compressed/pkram.c  | 252 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 320 insertions(+), 21 deletions(-)
 create mode 100644 arch/x86/boot/compressed/pkram.c

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 5f7c262bcc99..ba0d76c53574 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -84,6 +84,9 @@ ifdef CONFIG_X86_64
 	vmlinux-objs-$(CONFIG_RANDOMIZE_BASE) += $(obj)/kaslr_64.o
 	vmlinux-objs-y += $(obj)/mem_encrypt.o
 	vmlinux-objs-y += $(obj)/pgtable_64.o
+ifdef CONFIG_RANDOMIZE_BASE
+	vmlinux-objs-$(CONFIG_PKRAM) += $(obj)/pkram.o
+endif
 endif
 
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index d7408af55738..3f0a6fb15ac2 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -613,31 +613,16 @@ static unsigned long slots_fetch_random(void)
 	return 0;
 }
 
-static void __process_mem_region(struct mem_vector *entry,
-				 unsigned long minimum,
-				 unsigned long image_size)
+void ___process_mem_region(struct mem_vector *entry,
+			   unsigned long minimum,
+			   unsigned long image_size)
 {
 	struct mem_vector region, overlap;
-	unsigned long start_orig, end;
+	unsigned long start_orig;
 	struct mem_vector cur_entry;
 
-	/* On 32-bit, ignore entries entirely above our maximum. */
-	if (IS_ENABLED(CONFIG_X86_32) && entry->start >= KERNEL_IMAGE_SIZE)
-		return;
-
-	/* Ignore entries entirely below our minimum. */
-	if (entry->start + entry->size < minimum)
-		return;
-
-	/* Ignore entries above memory limit */
-	end = min(entry->size + entry->start, mem_limit);
-	if (entry->start >= end)
-		return;
-	cur_entry.start = entry->start;
-	cur_entry.size = end - entry->start;
-
-	region.start = cur_entry.start;
-	region.size = cur_entry.size;
+	region.start = cur_entry.start = entry->start;
+	region.size = cur_entry.size = entry->size;
 
 	/* Give up if slot area array is full. */
 	while (slot_area_index < MAX_SLOT_AREA) {
@@ -691,6 +676,39 @@ static void __process_mem_region(struct mem_vector *entry,
 	}
 }
 
+static void __process_mem_region(struct mem_vector *entry,
+				 unsigned long minimum,
+				 unsigned long image_size)
+{
+	struct mem_vector region, overlap;
+	unsigned long start_orig, end;
+	struct mem_vector cur_entry;
+
+	/* On 32-bit, ignore entries entirely above our maximum. */
+	if (IS_ENABLED(CONFIG_X86_32) && entry->start >= KERNEL_IMAGE_SIZE)
+		return;
+
+	/* Ignore entries entirely below our minimum. */
+	if (entry->start + entry->size < minimum)
+		return;
+
+	/* Ignore entries above memory limit */
+	end = min(entry->size + entry->start, mem_limit);
+	if (entry->start >= end)
+		return;
+	cur_entry.start = entry->start;
+	cur_entry.size = end - entry->start;
+
+	/* Return if region can't contain decompressed kernel */
+	if (cur_entry.size < image_size)
+		return;
+
+	if (pkram_enabled())
+		return pkram_process_mem_region(&cur_entry, minimum, image_size);
+	else
+		return ___process_mem_region(&cur_entry, minimum, image_size);
+}
+
 static bool process_mem_region(struct mem_vector *region,
 			       unsigned long long minimum,
 			       unsigned long long image_size)
@@ -902,6 +920,8 @@ void choose_random_location(unsigned long input,
 		return;
 	}
 
+	pkram_init();
+
 #ifdef CONFIG_X86_5LEVEL
 	if (__read_cr4() & X86_CR4_LA57) {
 		__pgtable_l5_enabled = 1;
@@ -952,3 +972,8 @@ void choose_random_location(unsigned long input,
 		random_addr = find_random_virt_addr(LOAD_PHYSICAL_ADDR, output_size);
 	*virt_addr = random_addr;
 }
+
+int slot_areas_full(void)
+{
+	return slot_area_index == MAX_SLOT_AREA;
+}
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 726e264410ff..ca1a8ae5ebe9 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -117,6 +117,25 @@ static inline void console_init(void)
 { }
 #endif
 
+void ___process_mem_region(struct mem_vector *entry,
+			   unsigned long minimum,
+			   unsigned long image_size);
+
+#ifdef CONFIG_PKRAM
+void pkram_init(void);
+int pkram_enabled(void);
+void pkram_process_mem_region(struct mem_vector *entry,
+			      unsigned long minimum,
+			      unsigned long image_size);
+#else
+static inline void pkram_init(void) { }
+static inline int pkram_enabled(void) { return 0; }
+static inline void pkram_process_mem_region(struct mem_vector *entry,
+					    unsigned long minimum,
+					    unsigned long image_size)
+{ ___process_mem_region(entry, minimum, image_size); }
+#endif
+
 void set_sev_encryption_mask(void);
 
 /* acpi.c */
diff --git a/arch/x86/boot/compressed/pkram.c b/arch/x86/boot/compressed/pkram.c
new file mode 100644
index 000000000000..5fc1e26909de
--- /dev/null
+++ b/arch/x86/boot/compressed/pkram.c
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: GPL-2.0
+#define __pa(x)  ((unsigned long)(x))
+#define __va(x)  ((void *)((unsigned long)(x)))
+
+#include "misc.h"
+#include <asm/pgtable.h>
+
+struct pkram_super_block {
+	__u64   node_pfn;
+	__u64   pgd_pfn;
+};
+
+static unsigned long long pkram_sb_pfn;
+static struct pkram_super_block *pkram_sb;
+static pgd_t *pkram_pgd;
+
+struct pg_state {
+	int (*range_cb)(struct pg_state *state, unsigned long base,
+			unsigned long size);
+	unsigned long curr_addr;
+	unsigned long start_addr;
+	unsigned long min_addr;
+	unsigned long max_addr;
+	unsigned long min_size;
+	unsigned long minimum;
+	bool tracking;
+	bool find_holes;
+};
+
+int pkram_enabled(void)
+{
+	return pkram_pgd ? 1 : 0;
+}
+
+void pkram_init(void)
+{
+	char arg[32];
+
+	if (cmdline_find_option("pkram", arg, sizeof(arg)) > 0) {
+		if (kstrtoull(arg, 16, &pkram_sb_pfn) != 0)
+			return;
+	} else
+		return;
+
+	pkram_sb = (struct pkram_super_block *)(pkram_sb_pfn << PAGE_SHIFT);
+
+	if (pkram_sb)
+		pkram_pgd = (pgd_t *)(pkram_sb->pgd_pfn << PAGE_SHIFT);
+}
+
+static int note_page(struct pg_state *st, int present)
+{
+	unsigned long curr_addr = st->curr_addr;
+	bool track_page = present ^ st->find_holes;
+
+	if (!st->tracking && track_page) {
+		if (curr_addr >= st->max_addr)
+			return 1;
+		/*
+		 * curr_addr can be < min_addr if the page straddles the
+		 * boundary
+		 */
+		st->start_addr = max(curr_addr, st->min_addr);
+		st->tracking = true;
+	} else if (st->tracking) {
+		unsigned long base, size;
+		int ret;
+
+		/* Continue tracking if upper bound has not been reached */
+		if (track_page && curr_addr < st->max_addr)
+			return 0;
+
+		curr_addr = min(curr_addr, st->max_addr);
+
+		base = st->start_addr;
+		size = curr_addr - st->start_addr;
+		st->tracking = false;
+
+		ret = st->range_cb(st, base, size);
+
+		if (curr_addr == st->max_addr)
+			return 1;
+		else
+			return ret;
+	}
+
+	return 0;
+}
+
+static int walk_pte_level(struct pg_state *st, pmd_t addr, unsigned long P)
+{
+	unsigned long *bitmap;
+	int present;
+	int i, ret;
+
+	bitmap = __va(pmd_val(addr));
+	for (i = 0; i < PTRS_PER_PTE; i++) {
+		unsigned long curr_addr = P + i * PAGE_SIZE;
+
+		if (curr_addr < st->min_addr)
+			continue;
+		st->curr_addr = curr_addr;
+		present = test_bit(i, bitmap);
+		ret = note_page(st, present);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static int walk_pmd_level(struct pg_state *st, pud_t addr, unsigned long P)
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
+		st->curr_addr = curr_addr;
+		if (!pmd_none(*start)) {
+			if (pmd_large(*start))
+				ret = note_page(st, true);
+			else
+				ret = walk_pte_level(st, *start, curr_addr);
+		} else
+			ret = note_page(st, false);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static int walk_pud_level(struct pg_state *st, p4d_t addr, unsigned long P)
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
+		st->curr_addr = curr_addr;
+		if (!pud_none(*start)) {
+			if (pud_large(*start))
+				ret = note_page(st, true);
+			else
+				ret = walk_pmd_level(st, *start, curr_addr);
+		} else
+			ret = note_page(st, false);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static int walk_p4d_level(struct pg_state *st, pgd_t addr, unsigned long P)
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
+		st->curr_addr = curr_addr;
+		if (!p4d_none(*start)) {
+			if (p4d_large(*start))
+				ret = note_page(st, true);
+			else
+				ret = walk_pud_level(st, *start, curr_addr);
+		} else
+			ret = note_page(st, false);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+#define pgd_large(a) (pgtable_l5_enabled() ? pgd_large(a) : p4d_large(__p4d(pgd_val(a))))
+#define pgd_none(a)  (pgtable_l5_enabled() ? pgd_none(a) : p4d_none(__p4d(pgd_val(a))))
+
+static int walk_pgd_level(struct pg_state *st, pgd_t *pgd)
+{
+	pgd_t *start = pgd;
+	int i, ret = 0;
+
+	for (i = 0; i < PTRS_PER_PGD; i++, start++) {
+		unsigned long curr_addr = i * PGDIR_SIZE;
+
+		if (curr_addr + PGDIR_SIZE <= st->min_addr)
+			continue;
+		st->curr_addr = curr_addr;
+		if (!pgd_none(*start))
+			ret = walk_p4d_level(st, *start, curr_addr);
+		else
+			ret = note_page(st, false);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+extern int slot_areas_full(void);
+
+static int pkram_process_mem_region_cb(struct pg_state *st, unsigned long base, unsigned long size)
+{
+	struct mem_vector region = {
+		.start = base,
+		.size = size,
+	};
+
+	if (size < st->min_size)
+		return 0;
+
+	___process_mem_region(&region, st->minimum, st->min_size);
+
+	if (slot_areas_full())
+		return 1;
+
+	return 0;
+}
+
+void pkram_process_mem_region(struct mem_vector *entry,
+			     unsigned long minimum,
+			     unsigned long image_size)
+{
+	struct pg_state st = {
+		.range_cb = pkram_process_mem_region_cb,
+		.min_addr = max((unsigned long)entry->start, minimum),
+		.max_addr = entry->start + entry->size,
+		.min_size = image_size,
+		.minimum = minimum,
+		.find_holes = true,
+	};
+
+	walk_pgd_level(&st, pkram_pgd);
+}
-- 
2.13.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
