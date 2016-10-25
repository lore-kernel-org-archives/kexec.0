Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt0-f173.google.com ([209.85.216.173])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1byw5S-0000Xs-Pt
 for kexec@lists.infradead.org; Tue, 25 Oct 2016 07:24:00 +0000
Received: by mail-qt0-f173.google.com with SMTP id g32so5050739qta.2
 for <kexec@lists.infradead.org>; Tue, 25 Oct 2016 00:23:32 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH Makedumpfile 04/10] arm64: use already available PAGESIZE()
 and PAGESHIFT() macros
Date: Tue, 25 Oct 2016 12:52:56 +0530
Message-Id: <640af7cb449683947a23261511e4a9fee0765013.1477378297.git.panand@redhat.com>
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

Since PAGESIZE() and PAGESHIFT() macros uses page size value from
VMCOREINFO_PAGESIZE() therefore use them instead of hard coding.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/arm64.c   | 24 +++++++-----------------
 makedumpfile.h |  1 -
 2 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/arch/arm64.c b/arch/arm64.c
index 4a2a9a9ec45d..c73efa1aad54 100644
--- a/arch/arm64.c
+++ b/arch/arm64.c
@@ -44,14 +44,13 @@ typedef struct {
 #define pmd_val(x)		(pud_val((x).pud))
 #define pte_val(x)		((x).pte)
 
-#define PAGE_SIZE		(1UL << PAGE_SHIFT)
-#define PAGE_MASK		(~(PAGE_SIZE - 1))
-#define PGDIR_SHIFT		((PAGE_SHIFT - 3) * ARM64_PGTABLE_LEVELS + 3)
+#define PAGE_MASK		(~(PAGESIZE() - 1))
+#define PGDIR_SHIFT		((PAGESHIFT() - 3) * ARM64_PGTABLE_LEVELS + 3)
 #define PUD_SHIFT		PGDIR_SHIFT
 #define PUD_SIZE		(1UL << PUD_SHIFT)
 #define PTRS_PER_PGD		(1 << (VA_BITS - PGDIR_SHIFT))
-#define PTRS_PER_PTE		(1 << (PAGE_SHIFT - 3))
-#define PMD_SHIFT		((PAGE_SHIFT - 3) * 2 + 3)
+#define PTRS_PER_PTE		(1 << (PAGESHIFT() - 3))
+#define PMD_SHIFT		((PAGESHIFT() - 3) * 2 + 3)
 #define PMD_SIZE		(1UL << PMD_SHIFT)
 #define PMD_MASK		(~(PMD_SIZE - 1))
 #define PTRS_PER_PMD		PTRS_PER_PTE
@@ -77,7 +76,7 @@ typedef struct {
 #define pgd_index(vaddr) 		(((vaddr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
 #define pgd_offset(pgdir, vaddr)	((pgd_t *)(pgdir) + pgd_index(vaddr))
 
-#define pte_index(vaddr) 		(((vaddr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
+#define pte_index(vaddr) 		(((vaddr) >> PAGESHIFT()) & (PTRS_PER_PTE - 1))
 #define pmd_page_vaddr(pmd)		(__va(pmd_val(pmd) & PHYS_MASK & (int32_t)PAGE_MASK))
 #define pte_offset(dir, vaddr) 		((pte_t*)pmd_page_vaddr((*dir)) + pte_index(vaddr))
 
@@ -92,14 +91,13 @@ typedef struct {
 #define KERN_STRUCT_PAGE_SIZE		get_structure_size("page", DWARF_INFO_GET_STRUCT_SIZE)
 
 #define ALIGN(x, a) 			(((x) + (a) - 1) & ~((a) - 1))
-#define PFN_DOWN(x)			((x) >> PAGE_SHIFT)
-#define VMEMMAP_SIZE			ALIGN((1UL << (VA_BITS - PAGE_SHIFT)) * KERN_STRUCT_PAGE_SIZE, PUD_SIZE)
+#define PFN_DOWN(x)			((x) >> PAGESHIFT())
+#define VMEMMAP_SIZE			ALIGN((1UL << (VA_BITS - PAGESHIFT())) * KERN_STRUCT_PAGE_SIZE, PUD_SIZE)
 #define MODULES_END			PAGE_OFFSET
 #define MODULES_VADDR			(MODULES_END - 0x4000000)
 
 static int pgtable_level;
 static int va_bits;
-static int page_shift;
 
 int
 get_pgtable_level_arm64(void)
@@ -113,12 +111,6 @@ get_va_bits_arm64(void)
 	return va_bits;
 }
 
-int
-get_page_shift_arm64(void)
-{
-	return page_shift;
-}
-
 static pmd_t *
 pmd_offset(pud_t *puda, pud_t *pudv, unsigned long vaddr)
 {
@@ -150,11 +142,9 @@ static int calculate_plat_config(void)
 	if ((stext & PAGE_OFFSET_39) == PAGE_OFFSET_39) {
 		pgtable_level = 3;
 		va_bits = 39;
-		page_shift = 12;
 	} else if ((stext & PAGE_OFFSET_42) == PAGE_OFFSET_42) {
 		pgtable_level = 2;
 		va_bits = 42;
-		page_shift = 16;
 	} else {
 		ERRMSG("Kernel Configuration not supported\n");
 		return FALSE;
diff --git a/makedumpfile.h b/makedumpfile.h
index c5e38a5b6e4b..c363c547b448 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -519,7 +519,6 @@ do { \
 int get_va_bits_arm64(void);
 #define ARM64_PGTABLE_LEVELS	get_pgtable_level_arm64()
 #define VA_BITS			get_va_bits_arm64()
-#define PAGE_SHIFT		get_page_shift_arm64()
 #define KVBASE			VMALLOC_START
 #endif /* aarch64 */
 
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
