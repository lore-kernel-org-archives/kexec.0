Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1byw5F-0000SU-KD
 for kexec@lists.infradead.org; Tue, 25 Oct 2016 07:23:43 +0000
Received: by mail-qk0-f173.google.com with SMTP id w69so14681966qka.4
 for <kexec@lists.infradead.org>; Tue, 25 Oct 2016 00:23:21 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH Makedumpfile 01/10] arm64: cleanup code, comment, blank space,
 blank lines etc
Date: Tue, 25 Oct 2016 12:52:53 +0530
Message-Id: <38dfdb53501a3cb129444abb190d2a78257139de.1477378297.git.panand@redhat.com>
In-Reply-To: <cover.1477378297.git.panand@redhat.com>
References: <cover.1477378297.git.panand@redhat.com>
In-Reply-To: <cover.1477378297.git.panand@redhat.com>
References: <cover.1477378297.git.panand@redhat.com>
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
Cc: Pratyush Anand <panand@redhat.com>, sgoel@codeaurora.org, mansip@codeaurora.org, asamson@codeaurora.org, kexec@lists.infradead.org

Do some code cleanup for blank spaces and lines, static function and
commenting style.
Also, re-organize some #defines to place them in a particular fashion.
Remove, redundant #defines.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/arm64.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/arch/arm64.c b/arch/arm64.c
index f7540262a6ae..4a2a9a9ec45d 100644
--- a/arch/arm64.c
+++ b/arch/arm64.c
@@ -35,25 +35,21 @@ typedef struct {
 	pud_t pud;
 } pmd_t;
 
-#define pud_offset(pgd, vaddr) 	((pud_t *)pgd)
+typedef struct {
+	unsigned long pte;
+} pte_t;
 
 #define pgd_val(x)		((x).pgd)
 #define pud_val(x)		(pgd_val((x).pgd))
 #define pmd_val(x)		(pud_val((x).pud))
-
-#define PUD_SHIFT		PGDIR_SHIFT
-#define PUD_SIZE		(1UL << PUD_SHIFT)
-
-typedef struct {
-	unsigned long pte;
-} pte_t;
 #define pte_val(x)		((x).pte)
 
 #define PAGE_SIZE		(1UL << PAGE_SHIFT)
 #define PAGE_MASK		(~(PAGE_SIZE - 1))
 #define PGDIR_SHIFT		((PAGE_SHIFT - 3) * ARM64_PGTABLE_LEVELS + 3)
+#define PUD_SHIFT		PGDIR_SHIFT
+#define PUD_SIZE		(1UL << PUD_SHIFT)
 #define PTRS_PER_PGD		(1 << (VA_BITS - PGDIR_SHIFT))
-#define PMD_SHIFT		((PAGE_SHIFT - 3) * 2 + 3)
 #define PTRS_PER_PTE		(1 << (PAGE_SHIFT - 3))
 #define PMD_SHIFT		((PAGE_SHIFT - 3) * 2 + 3)
 #define PMD_SIZE		(1UL << PMD_SHIFT)
@@ -62,17 +58,14 @@ typedef struct {
 
 #define PAGE_PRESENT		(1 << 0)
 #define SECTIONS_SIZE_BITS	30
-/*
-
-* Highest possible physical address supported.
-*/
+/* Highest possible physical address supported */
 #define PHYS_MASK_SHIFT		48
 #define PHYS_MASK		((1UL << PHYS_MASK_SHIFT) - 1)
 /*
  * Remove the highest order bits that are not a part of the
  * physical address in a section
  */
-#define PMD_SECTION_MASK        ((1UL << 40) - 1)
+#define PMD_SECTION_MASK	((1UL << 40) - 1)
 
 #define PMD_TYPE_MASK		3
 #define PMD_TYPE_SECT		1
@@ -84,15 +77,13 @@ typedef struct {
 #define pgd_index(vaddr) 		(((vaddr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
 #define pgd_offset(pgdir, vaddr)	((pgd_t *)(pgdir) + pgd_index(vaddr))
 
-#define pte_index(addr) 		(((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
+#define pte_index(vaddr) 		(((vaddr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
 #define pmd_page_vaddr(pmd)		(__va(pmd_val(pmd) & PHYS_MASK & (int32_t)PAGE_MASK))
 #define pte_offset(dir, vaddr) 		((pte_t*)pmd_page_vaddr((*dir)) + pte_index(vaddr))
 
-
-#define pmd_offset_pgtbl_lvl_2(pud, vaddr) ((pmd_t *)pud)
-
 #define pmd_index(vaddr)		(((vaddr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
 #define pud_page_vaddr(pud)		(__va(pud_val(pud) & PHYS_MASK & (int32_t)PAGE_MASK))
+#define pmd_offset_pgtbl_lvl_2(pud, vaddr) ((pmd_t *)pud)
 #define pmd_offset_pgtbl_lvl_3(pud, vaddr) ((pmd_t *)pud_page_vaddr((*pud)) + pmd_index(vaddr))
 
 /* kernel struct page size can be kernel version dependent, currently
@@ -128,7 +119,7 @@ get_page_shift_arm64(void)
 	return page_shift;
 }
 
-pmd_t *
+static pmd_t *
 pmd_offset(pud_t *puda, pud_t *pudv, unsigned long vaddr)
 {
 	if (pgtable_level == 2) {
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
