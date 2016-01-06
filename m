Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aGxZW-0001DV-2c
 for kexec@lists.infradead.org; Wed, 06 Jan 2016 23:32:54 +0000
From: Azriel Samson <asamson@codeaurora.org>
Subject: [PATCH v2] arm64: Add support for 4level 4K page translations table
Date: Wed,  6 Jan 2016 16:32:28 -0700
Message-Id: <1452123148-17792-1-git-send-email-asamson@codeaurora.org>
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
To: panand@redhat.com, kexec@lists.infradead.org
Cc: timur@codeaurora.org, Azriel Samson <asamson@codeaurora.org>, rruigrok@codeaurora.org, Mansi Patel <mansip@codeaurora.org>, sgoel@codeaurora.org, virajm@codeaurora.org

Add PUD translation for 4 level page tables.

Signed-off-by: Mansi Patel <mansip@codeaurora.org>
Signed-off-by: Azriel Samson <asamson@codeaurora.org>
Signed-off-by: Sameer Goel <sgoel@codeaurora.org>
---
This change targets the arm64_support branch of Pratush Anand's repository at:
https://github.com/pratyushanand/makedumpfile.git

 arch/arm64.c | 46 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/arch/arm64.c b/arch/arm64.c
index 59825fa..1eb050b 100644
--- a/arch/arm64.c
+++ b/arch/arm64.c
@@ -35,15 +35,10 @@ typedef struct {
 	pud_t pud;
 } pmd_t;
 
-#define pud_offset(pgd, vaddr) 	((pud_t *)pgd)
-
 #define pgd_val(x)		((x).pgd)
 #define pud_val(x)		(pgd_val((x).pgd))
 #define pmd_val(x)		(pud_val((x).pud))
 
-#define PUD_SHIFT		PGDIR_SHIFT
-#define PUD_SIZE		(1UL << PUD_SHIFT)
-
 typedef struct {
 	unsigned long pte;
 } pte_t;
@@ -59,6 +54,9 @@ typedef struct {
 #define PMD_SIZE		(1UL << PMD_SHIFT)
 #define PMD_MASK		(~(PMD_SIZE - 1))
 #define PTRS_PER_PMD		PTRS_PER_PTE
+#define PUD_SHIFT		get_pud_shift_arm64()
+#define PUD_SIZE		(1UL << PUD_SHIFT)
+#define PUD_MASK		(~(PUD_SIZE - 1))
 
 #define PAGE_PRESENT		(1 << 0)
 #define SECTIONS_SIZE_BITS	30
@@ -95,6 +93,10 @@ typedef struct {
 #define pud_page_vaddr(pud)		(__va(pud_val(pud) & PHYS_MASK & (int32_t)PAGE_MASK))
 #define pmd_offset_pgtbl_lvl_3(pud, vaddr) ((pmd_t *)pud_page_vaddr((*pud)) + pmd_index(vaddr))
 
+#define PTRS_PER_PUD			PTRS_PER_PTE
+#define pud_index(vaddr)		(((vaddr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
+#define pgd_page_vaddr(pgd)		(__va(pgd_val(pgd) & PHYS_MASK & (int32_t)PAGE_MASK))
+
 /* kernel struct page size can be kernel version dependent, currently
  * keep it constant.
  */
@@ -128,16 +130,34 @@ get_page_shift_arm64(void)
 	return page_shift;
 }
 
+static int
+get_pud_shift_arm64(void)
+{
+        if (pgtable_level == 4)
+                return ((PAGE_SHIFT - 3) * 3 + 3);
+        else
+                return PGDIR_SHIFT;
+}
+
 pmd_t *
-pmd_offset(pud_t *pud, unsigned long vaddr)
+pmd_offset(pud_t *puda, pud_t *pudv, unsigned long vaddr)
 {
 	if (pgtable_level == 2) {
-		return pmd_offset_pgtbl_lvl_2(pud, vaddr);
+		return pmd_offset_pgtbl_lvl_2(puda, vaddr);
 	} else {
-		return pmd_offset_pgtbl_lvl_3(pud, vaddr);
+		return pmd_offset_pgtbl_lvl_3(pudv, vaddr);
 	}
 }
 
+static pud_t *
+pud_offset(pgd_t *pgda, pgd_t *pgdv, unsigned long vaddr)
+{
+        if (pgtable_level == 4)
+                return ((pud_t *)pgd_page_vaddr((*pgdv)) + pud_index(vaddr));
+        else
+                return (pud_t *)(pgda);
+}
+
 static int
 is_vtop_from_page_table_arm64(unsigned long vaddr)
 {
@@ -244,7 +264,7 @@ vtop_arm64(unsigned long vaddr)
 {
 	unsigned long long paddr = NOT_PADDR;
 	pgd_t	*pgda, pgdv;
-	pud_t	pudv;
+	pud_t	*puda, pudv;
 	pmd_t	*pmda, pmdv;
 	pte_t 	*ptea, ptev;
 
@@ -259,9 +279,13 @@ vtop_arm64(unsigned long vaddr)
 		return NOT_PADDR;
 	}
 
-	pudv.pgd = pgdv;
+	puda = pud_offset(pgda, &pgdv, vaddr);
+	if (!readmem(VADDR, (unsigned long long)puda, &pudv, sizeof(pudv))) {
+		ERRMSG("Can't read pud\n");
+		return NOT_PADDR;
+	}
 
-	pmda = pmd_offset(&pudv, vaddr);
+	pmda = pmd_offset(puda, &pudv, vaddr);
 	if (!readmem(VADDR, (unsigned long long)pmda, &pmdv, sizeof(pmdv))) {
 		ERRMSG("Can't read pmd\n");
 		return NOT_PADDR;
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
