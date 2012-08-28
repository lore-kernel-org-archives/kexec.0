Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T6NRT-00029Y-El
 for kexec@lists.infradead.org; Tue, 28 Aug 2012 15:11:01 +0000
Subject: [PATCH] makedumpfile: Support for x86_64 1G pages
From: Petr Tesarik <ptesarik@suse.cz>
Date: Tue, 28 Aug 2012 17:10:50 +0200
MIME-Version: 1.0
Message-Id: <201208281710.51166.ptesarik@suse.cz>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Norbert Trapp <Norbert.Trapp@ts.fujitsu.com>

The PS bit is not recognized in the Page-Directory-Pointer Table (pgdir
in Linux terms), so virtual addresses that map to a 1G page will be
translated incorrectly.

This bug affects both Xen and bare metal. I don't think it can be easily
triggered in practice, because 1G mappings are created only for:

1. direct 1:1 mapping of physical memory, for which we don't walk the page
   tables, but instead subtract the corresponding virtual offset, and
2. 1G hugepages, which are only used for userspace data.

Anyway, if we ever happen to hit a 1G page now, the virtual address will
be translated correctly.

While fixing this, I consolidated the vtop() translation routines and
changed some of the constants. The basic idea is that the format of a page
table entry is defined by the architecture, so we can use hard-coded
constants everywhere.

I also always mask off reserved bits, because they might get defined in
a later revision of the specification.

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>

---
 arch/x86_64.c  |   33 +++++++++++++++++++--------------
 makedumpfile.h |   21 +++++++++++++--------
 2 files changed, 32 insertions(+), 22 deletions(-)

--- a/arch/x86_64.c
+++ b/arch/x86_64.c
@@ -211,7 +211,7 @@ vtop4_x86_64(unsigned long vaddr)
 	/*
 	 * Get PUD.
 	 */
-	pgd_paddr  = pml4 & PHYSICAL_PAGE_MASK;
+	pgd_paddr  = pml4 & ENTRY_MASK;
 	pgd_paddr += pgd_index(vaddr) * sizeof(unsigned long);
 	if (!readmem(PADDR, pgd_paddr, &pgd_pte, sizeof pgd_pte)) {
 		ERRMSG("Can't get pgd_pte (pgd_paddr:%lx).\n", pgd_paddr);
@@ -224,11 +224,14 @@ vtop4_x86_64(unsigned long vaddr)
 		ERRMSG("Can't get a valid pgd_pte.\n");
 		return NOT_PADDR;
 	}
+	if (pgd_pte & _PAGE_PSE)	/* 1GB pages */
+		return (pgd_pte & ENTRY_MASK & PGDIR_MASK) +
+			(vaddr & ~PGDIR_MASK);
 
 	/*
 	 * Get PMD.
 	 */
-	pmd_paddr  = pgd_pte & PHYSICAL_PAGE_MASK;
+	pmd_paddr  = pgd_pte & ENTRY_MASK;
 	pmd_paddr += pmd_index(vaddr) * sizeof(unsigned long);
 	if (!readmem(PADDR, pmd_paddr, &pmd_pte, sizeof pmd_pte)) {
 		ERRMSG("Can't get pmd_pte (pmd_paddr:%lx).\n", pmd_paddr);
@@ -241,14 +244,14 @@ vtop4_x86_64(unsigned long vaddr)
 		ERRMSG("Can't get a valid pmd_pte.\n");
 		return NOT_PADDR;
 	}
-	if (pmd_pte & _PAGE_PSE)
-		return (PAGEBASE(pmd_pte) & PHYSICAL_PAGE_MASK)
-			+ (vaddr & ~_2MB_PAGE_MASK);
+	if (pmd_pte & _PAGE_PSE)	/* 2MB pages */
+		return (pmd_pte & ENTRY_MASK & PMD_MASK) +
+			(vaddr & ~PMD_MASK);
 
 	/*
 	 * Get PTE.
 	 */
-	pte_paddr  = pmd_pte & PHYSICAL_PAGE_MASK;
+	pte_paddr  = pmd_pte & ENTRY_MASK;
 	pte_paddr += pte_index(vaddr) * sizeof(unsigned long);
 	if (!readmem(PADDR, pte_paddr, &pte, sizeof pte)) {
 		ERRMSG("Can't get pte (pte_paddr:%lx).\n", pte_paddr);
@@ -261,7 +264,7 @@ vtop4_x86_64(unsigned long vaddr)
 		ERRMSG("Can't get a valid pte.\n");
 		return NOT_PADDR;
 	}
-	return (PAGEBASE(pte) & PHYSICAL_PAGE_MASK) + PAGEOFFSET(vaddr);
+	return (pte & ENTRY_MASK) + PAGEOFFSET(vaddr);
 }
 
 unsigned long long
@@ -330,6 +333,10 @@ kvtop_xen_x86_64(unsigned long kvaddr)
 	if (!(entry & _PAGE_PRESENT))
 		return NOT_PADDR;
 
+	if (entry & _PAGE_PSE)		/* 1GB pages */
+		return (entry & ENTRY_MASK & PGDIR_MASK) +
+			(kvaddr & ~PGDIR_MASK);
+
 	dirp = entry & ENTRY_MASK;
 	dirp += pmd_index(kvaddr) * sizeof(unsigned long long);
 	if (!readmem(MADDR_XEN, dirp, &entry, sizeof(entry)))
@@ -338,10 +345,10 @@ kvtop_xen_x86_64(unsigned long kvaddr)
 	if (!(entry & _PAGE_PRESENT))
 		return NOT_PADDR;
 
-	if (entry & _PAGE_PSE) {
-		entry = (entry & ENTRY_MASK) + (kvaddr & ((1UL << PMD_SHIFT) - 1));
-		return entry;
-	}
+	if (entry & _PAGE_PSE)		/* 2MB pages */
+		return (entry & ENTRY_MASK & PMD_MASK) +
+			(kvaddr & ~PMD_MASK);
+
 	dirp = entry & ENTRY_MASK;
 	dirp += pte_index(kvaddr) * sizeof(unsigned long long);
 	if (!readmem(MADDR_XEN, dirp, &entry, sizeof(entry)))
@@ -351,9 +358,7 @@ kvtop_xen_x86_64(unsigned long kvaddr)
 		return NOT_PADDR;
 	}
 
-	entry = (entry & ENTRY_MASK) + (kvaddr & ((1UL << PTE_SHIFT) - 1));
-
-	return entry;
+	return (entry & ENTRY_MASK) + PAGEOFFSET(kvaddr);
 }
 
 int get_xen_basic_info_x86_64(void)
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -143,7 +143,6 @@ isAnon(unsigned long mapping)
 #define PAGESHIFT()		(info->page_shift)
 #define PAGEOFFSET(X)		(((unsigned long)(X)) & (PAGESIZE() - 1))
 #define PAGEBASE(X)		(((unsigned long)(X)) & ~(PAGESIZE() - 1))
-#define _2MB_PAGE_MASK		(~((2*1048576)-1))
 
 /*
  * for SPARSEMEM
@@ -494,7 +493,10 @@ do { \
 #define _PAGE_PRESENT		(0x001)
 #define _PAGE_PSE		(0x080)
 
-#define ENTRY_MASK		(~0x8000000000000fffULL)
+/* Physical addresses are up to 52 bits (AMD64).
+ * Mask off bits 52-62 (reserved) and bit 63 (NX).
+ */
+#define ENTRY_MASK		(~0xfff0000000000fffULL)
 
 #endif /* x86 */
 
@@ -527,8 +529,12 @@ do { \
 #define PML4_SHIFT		(39)
 #define PTRS_PER_PML4		(512)
 #define PGDIR_SHIFT		(30)
+#define PGDIR_SIZE		(1UL << PGDIR_SHIFT)
+#define PGDIR_MASK		(~(PGDIR_SIZE - 1))
 #define PTRS_PER_PGD		(512)
 #define PMD_SHIFT		(21)
+#define PMD_SIZE		(1UL << PMD_SHIFT)
+#define PMD_MASK		(~(PMD_SIZE - 1))
 #define PTRS_PER_PMD		(512)
 #define PTRS_PER_PTE		(512)
 #define PTE_SHIFT		(12)
@@ -539,11 +545,7 @@ do { \
 #define pte_index(address)  (((address) >> PTE_SHIFT) & (PTRS_PER_PTE - 1))
 
 #define _PAGE_PRESENT		(0x001)
-#define _PAGE_PSE		(0x080)    /* 2MB page */
-
-#define __PHYSICAL_MASK_SHIFT	(40)
-#define __PHYSICAL_MASK		((1UL << __PHYSICAL_MASK_SHIFT) - 1)
-#define PHYSICAL_PAGE_MASK	(~(PAGESIZE()-1) & (__PHYSICAL_MASK << 
PAGESHIFT()))
+#define _PAGE_PSE		(0x080)    /* 2MB or 1GB page */
 
 #endif /* x86_64 */
 
@@ -1379,7 +1381,10 @@ int get_xen_info_x86(void);
 
 #ifdef __x86_64__
 
-#define ENTRY_MASK		(~0x8000000000000fffULL)
+/* The architectural limit for physical addresses is 52 bits.
+ * Mask off bits 52-62 (available for OS use) and bit 63 (NX).
+ */
+#define ENTRY_MASK		(~0xfff0000000000fffULL)
 #define MAX_X86_64_FRAMES	(info->page_size / sizeof(unsigned long))
 
 #define PAGE_OFFSET_XEN_DOM0  (0xffff880000000000) /* different from linux */



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
