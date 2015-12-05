Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a5Fjq-0002cc-Au
 for kexec@lists.infradead.org; Sat, 05 Dec 2015 16:31:11 +0000
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH 4/4] arm64: Fix for ARM64 3 level translation tables
Date: Sat,  5 Dec 2015 22:00:03 +0530
Message-Id: <a9085b70501c5c286c708c21f7b4da70cb71a134.1449332470.git.panand@redhat.com>
In-Reply-To: <cover.1449332470.git.panand@redhat.com>
References: <cover.1449332470.git.panand@redhat.com>
In-Reply-To: <cover.1449332470.git.panand@redhat.com>
References: <cover.1449332470.git.panand@redhat.com>
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
To: ats-kumagai@wm.jp.nec.com
Cc: Pratyush Anand <panand@redhat.com>, timur@codeaurora.org, asamson@codeaurora.org, kexec@lists.infradead.org, rruigrok@codeaurora.org, sgoel@codeaurora.org, dyoung@redhat.com

From: Sameer Goel <sgoel@codeaurora.org>

Add the implementation for PMD translation in case of 3 level page tables.
Assign the kernel page size based on the page structure read from the kernel
ELF file.

Signed-off-by: Sameer Goel <sgoel@codeaurora.org>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/arm64.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/arch/arm64.c b/arch/arm64.c
index a94a4ba16dd5..ab20389fa673 100644
--- a/arch/arm64.c
+++ b/arch/arm64.c
@@ -36,7 +36,7 @@ typedef struct {
 } pmd_t;
 
 #define pud_offset(pgd, vaddr) 	((pud_t *)pgd)
-#define pmd_offset(pud, vaddr) 	((pmd_t *)pud)
+
 #define pgd_val(x)		((x).pgd)
 #define pud_val(x)		(pgd_val((x).pgd))
 #define pmd_val(x)		(pud_val((x).pud))
@@ -68,6 +68,11 @@ typedef struct {
 */
 #define PHYS_MASK_SHIFT		48
 #define PHYS_MASK		((1UL << PHYS_MASK_SHIFT) - 1)
+/*
+ * Remove the highest order bits that are not a part of the
+ * physical address in a section
+ */
+#define PMD_SECTION_MASK        ((1UL << 40) - 1)
 
 #define PMD_TYPE_MASK		3
 #define PMD_TYPE_SECT		1
@@ -83,10 +88,18 @@ typedef struct {
 #define pmd_page_vaddr(pmd)		(__va(pmd_val(pmd) & PHYS_MASK & (int32_t)PAGE_MASK))
 #define pte_offset(dir, vaddr) 		((pte_t*)pmd_page_vaddr((*dir)) + pte_index(vaddr))
 
+
+#define pmd_offset_pgtbl_lvl_2(pud, vaddr) ((pmd_t *)pud)
+
+#define pmd_index(vaddr)		(((vaddr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
+#define pud_page_vaddr(pud)		(__va(pud_val(pud) & PHYS_MASK & (int32_t)PAGE_MASK))
+#define pmd_offset_pgtbl_lvl_3(pud, vaddr) ((pmd_t *)pud_page_vaddr((*pud)) + pmd_index(vaddr))
+
 /* kernel struct page size can be kernel version dependent, currently
  * keep it constant.
  */
-#define KERN_STRUCT_PAGE_SIZE		64
+#define KERN_STRUCT_PAGE_SIZE		get_structure_size("page", DWARF_INFO_GET_STRUCT_SIZE)
+
 #define ALIGN(x, a) 			(((x) + (a) - 1) & ~((a) - 1))
 #define PFN_DOWN(x)			((x) >> PAGE_SHIFT)
 #define VMEMMAP_SIZE			ALIGN((1UL << (VA_BITS - PAGE_SHIFT)) * KERN_STRUCT_PAGE_SIZE, PUD_SIZE)
@@ -97,6 +110,15 @@ static int pgtable_level;
 static int va_bits;
 static int page_shift;
 
+pmd_t *
+pmd_offset(pud_t *pud, unsigned long vaddr)
+{
+	if (pgtable_level == 2) {
+		return pmd_offset_pgtbl_lvl_2(pud, vaddr);
+	} else {
+		return pmd_offset_pgtbl_lvl_3(pud, vaddr);
+	}
+}
 int
 get_pgtable_level_arm64(void)
 {
@@ -256,7 +278,7 @@ vtop_arm64(unsigned long vaddr)
 {
 	unsigned long long paddr = NOT_PADDR;
 	pgd_t	*pgda, pgdv;
-	pud_t	*puda;
+	pud_t	*puda, pudv;
 	pmd_t	*pmda, pmdv;
 	pte_t 	*ptea, ptev;
 
@@ -271,8 +293,9 @@ vtop_arm64(unsigned long vaddr)
 		return NOT_PADDR;
 	}
 
-	puda = pud_offset(pgda, vaddr);
-	pmda = pmd_offset(puda, vaddr);
+	pudv.pgd = pgdv;
+
+	pmda = pmd_offset(&pudv, vaddr);
 	if (!readmem(VADDR, (unsigned long long)pmda, &pmdv, sizeof(pmdv))) {
 		ERRMSG("Can't read pmd\n");
 		return NOT_PADDR;
@@ -298,7 +321,8 @@ vtop_arm64(unsigned long vaddr)
 		break;
 	case PMD_TYPE_SECT:
 		/* 1GB section */
-		paddr = (pmd_val(pmdv) & PMD_MASK) + (vaddr & (PMD_SIZE - 1));
+		paddr = (pmd_val(pmdv) & (PMD_MASK & PMD_SECTION_MASK))
+					+ (vaddr & (PMD_SIZE - 1));
 		break;
 	}
 
-- 
2.5.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
