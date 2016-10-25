Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1byw5d-0000ez-Ku
 for kexec@lists.infradead.org; Tue, 25 Oct 2016 07:24:12 +0000
Received: by mail-qt0-f178.google.com with SMTP id 23so7255856qtp.5
 for <kexec@lists.infradead.org>; Tue, 25 Oct 2016 00:23:45 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH Makedumpfile 07/10] arm64: use value of VA_BITS and
 PHYS_OFFSET embedded into vmcore
Date: Tue, 25 Oct 2016 12:52:59 +0530
Message-Id: <a1ec87ec550cffcc7b364abc83254f27dde369d0.1477378297.git.panand@redhat.com>
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

ARM64 kdump-v26 patch (4/7) [1] has embedded VA_BITS and PHYS_OFFSET into
vmcore. Therefore this patch does following improvements:

1) Read value of VA_BITS from vmcore, instead of hard coding.
2) Remove calculation of PHYS_OFFSET from PT_LOAD and read it from vmcore
as well.
3) arch/arm64/Kconfig defines page table levels on the basic of page size and
VA bits. Use same definition in makedumpfile as well.
4) Since pgtable_level and va_bits are used only in arm64.c, therefore get rid
of get_pgtable_level_arm64() and get_va_bits_arm64() function.
5) Since va_bits and pgtable_levels are local to arch/arm64.c, therefore
remove #define of ARM64_PGTABLE_LEVELS and VA_BITS from makedumpfile.h

[1] https://www.mail-archive.com/kexec@lists.infradead.org/msg16298.html

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/arm64.c   | 88 +++++++++++++++++-----------------------------------------
 makedumpfile.c |  8 ++++++
 makedumpfile.h |  7 +++--
 3 files changed, 38 insertions(+), 65 deletions(-)

diff --git a/arch/arm64.c b/arch/arm64.c
index a5b1bca43e64..6f61b4c5497f 100644
--- a/arch/arm64.c
+++ b/arch/arm64.c
@@ -39,16 +39,23 @@ typedef struct {
 	unsigned long pte;
 } pte_t;
 
+static int pgtable_level;
+static int va_bits;
+
+#define SZ_4K			(4 * 1024)
+#define SZ_16K			(16 * 1024)
+#define SZ_64K			(64 * 1024)
+
 #define pgd_val(x)		((x).pgd)
 #define pud_val(x)		(pgd_val((x).pgd))
 #define pmd_val(x)		(pud_val((x).pud))
 #define pte_val(x)		((x).pte)
 
 #define PAGE_MASK		(~(PAGESIZE() - 1))
-#define PGDIR_SHIFT		((PAGESHIFT() - 3) * ARM64_PGTABLE_LEVELS + 3)
+#define PGDIR_SHIFT		((PAGESHIFT() - 3) * pgtable_level + 3)
 #define PUD_SHIFT		PGDIR_SHIFT
 #define PUD_SIZE		(1UL << PUD_SHIFT)
-#define PTRS_PER_PGD		(1 << (VA_BITS - PGDIR_SHIFT))
+#define PTRS_PER_PGD		(1 << (va_bits - PGDIR_SHIFT))
 #define PTRS_PER_PTE		(1 << (PAGESHIFT() - 3))
 #define PMD_SHIFT		((PAGESHIFT() - 3) * 2 + 3)
 #define PMD_SIZE		(1UL << PMD_SHIFT)
@@ -92,25 +99,10 @@ typedef struct {
 
 #define ALIGN(x, a) 			(((x) + (a) - 1) & ~((a) - 1))
 #define PFN_DOWN(x)			((x) >> PAGESHIFT())
-#define VMEMMAP_SIZE			ALIGN((1UL << (VA_BITS - PAGESHIFT())) * KERN_STRUCT_PAGE_SIZE, PUD_SIZE)
+#define VMEMMAP_SIZE			ALIGN((1UL << (va_bits - PAGESHIFT())) * KERN_STRUCT_PAGE_SIZE, PUD_SIZE)
 #define MODULES_END			PAGE_OFFSET
 #define MODULES_VADDR			(MODULES_END - 0x4000000)
 
-static int pgtable_level;
-static int va_bits;
-
-int
-get_pgtable_level_arm64(void)
-{
-	return pgtable_level;
-}
-
-int
-get_va_bits_arm64(void)
-{
-	return va_bits;
-}
-
 static pmd_t *
 pmd_offset(pud_t *puda, pud_t *pudv, unsigned long vaddr)
 {
@@ -121,32 +113,23 @@ pmd_offset(pud_t *puda, pud_t *pudv, unsigned long vaddr)
 	}
 }
 
-#define PAGE_OFFSET_39 (0xffffffffffffffffUL << 39)
-#define PAGE_OFFSET_42 (0xffffffffffffffffUL << 42)
 static int calculate_plat_config(void)
 {
-	unsigned long long stext;
-
-	/* Currently we assume that there are only two possible
-	 * configuration supported by kernel.
-	 * 1) Page Table Level:2, Page Size 64K and VA Bits 42
-	 * 1) Page Table Level:3, Page Size 4K and VA Bits 39
-	 * Ideally, we should have some mechanism to decide these values
-	 * from kernel symbols, but we have limited symbols in vmcore,
-	 * and we can not do much. So until some one comes with a better
-	 * way, we use following.
-	 */
-	stext = SYMBOL(_stext);
+	va_bits = NUMBER(VA_BITS);
 
-	/* condition for minimum VA bits must be checked first and so on */
-	if ((stext & PAGE_OFFSET_39) == PAGE_OFFSET_39) {
-		pgtable_level = 3;
-		va_bits = 39;
-	} else if ((stext & PAGE_OFFSET_42) == PAGE_OFFSET_42) {
+	/* derive pgtable_level as per arch/arm64/Kconfig */
+	if ((PAGESIZE() == SZ_16K && va_bits == 36) ||
+			(PAGESIZE() == SZ_64K && va_bits == 42)) {
 		pgtable_level = 2;
-		va_bits = 42;
+	} else if ((PAGESIZE() == SZ_64K && va_bits == 48) ||
+			(PAGESIZE() == SZ_4K && va_bits == 39) ||
+			(PAGESIZE() == SZ_16K && va_bits == 47)) {
+		pgtable_level = 3;
+	} else if ((PAGESIZE() != SZ_64K && va_bits == 48)) {
+		pgtable_level = 4;
 	} else {
-		ERRMSG("Kernel Configuration not supported\n");
+		ERRMSG("PAGE SIZE %#lx and VA Bits %d not supported\n",
+				PAGESIZE(), va_bits);
 		return FALSE;
 	}
 
@@ -167,28 +150,9 @@ is_vtop_from_page_table_arm64(unsigned long vaddr)
 int
 get_phys_base_arm64(void)
 {
-	unsigned long phys_base = ULONG_MAX;
-	unsigned long long phys_start;
-	int i;
-
-	/*
-	 * We resolve phys_base from PT_LOAD segments. LMA contains physical
-	 * address of the segment, and we use the lowest start as
-	 * phys_base.
-	 */
-	for (i = 0; get_pt_load(i, &phys_start, NULL, NULL, NULL); i++) {
-		if (phys_start < phys_base)
-			phys_base = phys_start;
-	}
-
-	if (phys_base == ULONG_MAX) {
-		ERRMSG("Can't determine phys_base\n");
-		return FALSE;
-	}
-
-	info->phys_base = phys_base;
+	info->phys_base = NUMBER(PHYS_OFFSET);
 
-	DEBUG_MSG("phys_base    : %lx\n", phys_base);
+	DEBUG_MSG("phys_base    : %lx\n", info->phys_base);
 
 	return TRUE;
 }
@@ -203,8 +167,8 @@ get_machdep_info_arm64(void)
 
 	info->max_physmem_bits = PHYS_MASK_SHIFT;
 	info->section_size_bits = SECTIONS_SIZE_BITS;
-	info->page_offset = 0xffffffffffffffffUL << (VA_BITS - 1);
-	info->vmalloc_start = 0xffffffffffffffffUL << VA_BITS;
+	info->page_offset = 0xffffffffffffffffUL << (va_bits - 1);
+	info->vmalloc_start = 0xffffffffffffffffUL << va_bits;
 	info->vmalloc_end = PAGE_OFFSET - PUD_SIZE - VMEMMAP_SIZE - 0x10000;
 	info->vmemmap_start = VMALLOC_END + 0x10000;
 	info->vmemmap_end = VMEMMAP_START + VMEMMAP_SIZE;
diff --git a/makedumpfile.c b/makedumpfile.c
index e248db876858..df413f066348 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2263,6 +2263,10 @@ write_vmcoreinfo_data(void)
 	WRITE_NUMBER("KERNEL_IMAGE_SIZE", KERNEL_IMAGE_SIZE);
 
 	WRITE_NUMBER("HUGETLB_PAGE_DTOR", HUGETLB_PAGE_DTOR);
+#ifdef __aarch64__
+	WRITE_NUMBER("VA_BITS", VA_BITS);
+	WRITE_NUMBER_UNSIGNED("PHYS_OFFSET", PHYS_OFFSET);
+#endif
 
 	/*
 	 * write the source file of 1st kernel
@@ -2645,6 +2649,10 @@ read_vmcoreinfo(void)
 
 	READ_NUMBER("PAGE_BUDDY_MAPCOUNT_VALUE", PAGE_BUDDY_MAPCOUNT_VALUE);
 	READ_NUMBER("KERNEL_IMAGE_SIZE", KERNEL_IMAGE_SIZE);
+#ifdef __aarch64__
+	READ_NUMBER("VA_BITS", VA_BITS);
+	READ_NUMBER_UNSIGNED("PHYS_OFFSET", PHYS_OFFSET);
+#endif
 
 	READ_NUMBER("HUGETLB_PAGE_DTOR", HUGETLB_PAGE_DTOR);
 
diff --git a/makedumpfile.h b/makedumpfile.h
index c363c547b448..1a119ac949b6 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -516,9 +516,6 @@ do { \
 #define PMASK			(0x7ffffffffffff000UL)
 
 #ifdef __aarch64__
-int get_va_bits_arm64(void);
-#define ARM64_PGTABLE_LEVELS	get_pgtable_level_arm64()
-#define VA_BITS			get_va_bits_arm64()
 #define KVBASE			VMALLOC_START
 #endif /* aarch64 */
 
@@ -1736,6 +1733,10 @@ struct number_table {
 	long	SECTION_SIZE_BITS;
 	long	MAX_PHYSMEM_BITS;
 	long    HUGETLB_PAGE_DTOR;
+#ifdef __aarch64__
+	long 	VA_BITS;
+	unsigned long	PHYS_OFFSET;
+#endif
 };
 
 struct srcfile_table {
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
