Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hnQkv-00052Q-Gd
 for kexec@lists.infradead.org; Tue, 16 Jul 2019 16:56:48 +0000
Received: by mail-qt1-x842.google.com with SMTP id d23so20320460qto.2
 for <kexec@lists.infradead.org>; Tue, 16 Jul 2019 09:56:45 -0700 (PDT)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [RFC v1 1/4] arm64, mm: identity mapped page table
Date: Tue, 16 Jul 2019 12:56:38 -0400
Message-Id: <20190716165641.6990-2-pasha.tatashin@soleen.com>
In-Reply-To: <20190716165641.6990-1-pasha.tatashin@soleen.com>
References: <20190716165641.6990-1-pasha.tatashin@soleen.com>
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
To: pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Created identiy mapped page table that maps 1 to 1 virtual to physical
addresses.

Similarly to x86, this table can be used in kasan, hibernate, and kexec.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/ident_map.h | 26 ++++++++
 arch/arm64/mm/Makefile             |  1 +
 arch/arm64/mm/ident_map.c          | 99 ++++++++++++++++++++++++++++++
 3 files changed, 126 insertions(+)
 create mode 100644 arch/arm64/include/asm/ident_map.h
 create mode 100644 arch/arm64/mm/ident_map.c

diff --git a/arch/arm64/include/asm/ident_map.h b/arch/arm64/include/asm/ident_map.h
new file mode 100644
index 000000000000..1bb9fcd27368
--- /dev/null
+++ b/arch/arm64/include/asm/ident_map.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019, Microsoft Corporation.
+ * Pavel Tatashin <patatash@linux.microsoft.com>
+ */
+
+#ifndef _ASM_IDENT_MAP_H
+#define _ASM_IDENT_MAP_H
+
+#include <linux/types.h>
+#include <asm/pgtable.h>
+
+struct ident_map_info {
+	void * (*alloc_pgt_page)(void *);	/* allocate a page  */
+	void *alloc_arg;			/* arg. for alloc_pgt_page */
+	unsigned long page_flags;		/* PMD or PUD flags */
+	unsigned long offset;			/* ident mapping offset */
+	bool pud_pages;				/* PUD level huge pages */
+};
+
+int ident_map_pgd_populate(struct ident_map_info *info,
+			   phys_addr_t pgd_page,
+			   phys_addr_t addr,
+			   phys_addr_t end);
+
+#endif /* _ASM_ARM64_IDENT_MAP_H */
diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
index 849c1df3d214..dfa5a074a360 100644
--- a/arch/arm64/mm/Makefile
+++ b/arch/arm64/mm/Makefile
@@ -5,6 +5,7 @@ obj-y				:= dma-mapping.o extable.o fault.o init.o \
 				   context.o proc.o pageattr.o
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 obj-$(CONFIG_ARM64_PTDUMP_CORE)	+= dump.o
+obj-$(CONFIG_KEXEC_CORE)	+= ident_map.o
 obj-$(CONFIG_ARM64_PTDUMP_DEBUGFS)	+= ptdump_debugfs.o
 obj-$(CONFIG_NUMA)		+= numa.o
 obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o
diff --git a/arch/arm64/mm/ident_map.c b/arch/arm64/mm/ident_map.c
new file mode 100644
index 000000000000..bcfff5e2573b
--- /dev/null
+++ b/arch/arm64/mm/ident_map.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019, Microsoft Corporation.
+ * Pavel Tatashin <patatash@linux.microsoft.com>
+ */
+
+#include <asm/ident_map.h>
+#include <asm/pgalloc.h>
+
+/* Initialize PMD size huge entries in page table */
+static void ident_map_pmd_init(struct ident_map_info *info,
+			       phys_addr_t pmd_page, phys_addr_t addr,
+			       phys_addr_t end)
+{
+	const unsigned long flags = info->page_flags;
+	const unsigned long offset = info->offset;
+	pmd_t *pmdp = (pmd_t *)__va(pmd_page) + pmd_index(addr);
+
+	addr &= PMD_MASK;
+	for (; addr < end; addr += PMD_SIZE, pmdp++) {
+		set_pmd(pmdp, __pmd(__phys_to_pmd_val(addr - offset) | flags));
+	}
+}
+
+/* Initialize PUD size huge entries in page table */
+static void ident_map_pud_init(struct ident_map_info *info,
+			       phys_addr_t pud_page, phys_addr_t addr,
+			       phys_addr_t end)
+{
+	const unsigned long flags = info->page_flags;
+	const unsigned long offset = info->offset;
+	pud_t *pudp = (pud_t *)__va(pud_page) + pud_index(addr);
+
+	addr &= PUD_MASK;
+	for (; addr < end; addr += PUD_SIZE, pudp++) {
+		set_pud(pudp, __pud(__phys_to_pud_val(addr - offset) | flags));
+	}
+}
+
+/* Populate PUD level with PMD entries */
+static int ident_map_pud_populate(struct ident_map_info *info,
+				  phys_addr_t pud_page, phys_addr_t addr,
+				  phys_addr_t end)
+{
+	pud_t *pudp = (pud_t *)__va(pud_page) + pud_index(addr);
+	phys_addr_t pmd_page, next;
+
+	for (; addr < end; addr = next, pudp++) {
+		next = pud_addr_end(addr, end);
+		if (pud_none(*pudp)) {
+			void *pmd = info->alloc_pgt_page(info->alloc_arg);
+
+			if (!pmd)
+				return -ENOMEM;
+
+			clear_page(pmd);
+			__pud_populate(pudp, __pa(pmd), PUD_TYPE_TABLE);
+		}
+		pmd_page = __pud_to_phys(*pudp);
+		ident_map_pmd_init(info, pmd_page, addr, next);
+	}
+
+	return 0;
+}
+
+/* Populate identify mapped page table with physical range[addr, end) */
+int ident_map_pgd_populate(struct ident_map_info *info,
+			   phys_addr_t pgd_page, phys_addr_t addr,
+			   phys_addr_t end)
+{
+	const bool pud_pages = info->pud_pages;
+	pgd_t *pgdp = (pgd_t *)__va(pgd_page) + pgd_index(addr);
+	phys_addr_t pud_page, next;
+
+	for (; addr < end; addr = next, pgdp++) {
+		next = pgd_addr_end(addr, end);
+		if (pgd_none(*pgdp)) {
+			void *pud = info->alloc_pgt_page(info->alloc_arg);
+
+			if (!pud)
+				return -ENOMEM;
+
+			clear_page(pud);
+			__pgd_populate(pgdp, __pa(pud), PUD_TYPE_TABLE);
+		}
+		pud_page = __pgd_to_phys(*pgdp);
+		if (pud_pages) {
+			ident_map_pud_init(info, pud_page, addr, next);
+		} else {
+			int rv = ident_map_pud_populate(info, pud_page, addr,
+				 next);
+
+			if (rv)
+				return rv;
+		}
+	}
+
+	return 0;
+}
-- 
2.22.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
