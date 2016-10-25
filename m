Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1byw5l-0000is-Gm
 for kexec@lists.infradead.org; Tue, 25 Oct 2016 07:24:17 +0000
Received: by mail-qk0-f171.google.com with SMTP id n189so254689412qke.0
 for <kexec@lists.infradead.org>; Tue, 25 Oct 2016 00:23:52 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH Makedumpfile 09/10] arm64: Add support for 4level 4K page
 translations table
Date: Tue, 25 Oct 2016 12:53:01 +0530
Message-Id: <4f49772bb95a91fb42f962769fd96d07e1eb57ef.1477378297.git.panand@redhat.com>
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

From: Azriel Samson <asamson@codeaurora.org>

Add PUD translation for 4 level page tables.

Signed-off-by: Mansi Patel <mansip@codeaurora.org>
Signed-off-by: Azriel Samson <asamson@codeaurora.org>
Signed-off-by: Sameer Goel <sgoel@codeaurora.org>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/arm64.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/arm64.c b/arch/arm64.c
index da8f43c62380..df58e92536e2 100644
--- a/arch/arm64.c
+++ b/arch/arm64.c
@@ -54,7 +54,9 @@ static int va_bits;
 #define PAGE_MASK		(~(PAGESIZE() - 1))
 #define PGDIR_SHIFT		((PAGESHIFT() - 3) * pgtable_level + 3)
 #define PTRS_PER_PGD		(1 << (va_bits - PGDIR_SHIFT))
+#define PUD_SHIFT		get_pud_shift_arm64()
 #define PTRS_PER_PTE		(1 << (PAGESHIFT() - 3))
+#define PTRS_PER_PUD		PTRS_PER_PTE
 #define PMD_SHIFT		((PAGESHIFT() - 3) * 2 + 3)
 #define PMD_SIZE		(1UL << PMD_SHIFT)
 #define PMD_MASK		(~(PMD_SIZE - 1))
@@ -89,6 +91,18 @@ static int va_bits;
 #define pmd_offset_pgtbl_lvl_2(pud, vaddr) ((pmd_t *)pud)
 #define pmd_offset_pgtbl_lvl_3(pud, vaddr) ((pmd_t *)pud_page_paddr((*pud)) + pmd_index(vaddr))
 
+#define pud_index(vaddr)		(((vaddr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
+#define pgd_page_paddr(pgd)		(pgd_val(pgd) & PHYS_MASK & (int32_t)PAGE_MASK)
+
+static int
+get_pud_shift_arm64(void)
+{
+	if (pgtable_level == 4)
+		return ((PAGESHIFT() - 3) * 3 + 3);
+	else
+		return PGDIR_SHIFT;
+}
+
 static pmd_t *
 pmd_offset(pud_t *puda, pud_t *pudv, unsigned long vaddr)
 {
@@ -99,6 +113,15 @@ pmd_offset(pud_t *puda, pud_t *pudv, unsigned long vaddr)
 	}
 }
 
+static pud_t *
+pud_offset(pgd_t *pgda, pgd_t *pgdv, unsigned long vaddr)
+{
+	if (pgtable_level == 4)
+		return ((pud_t *)pgd_page_paddr((*pgdv)) + pud_index(vaddr));
+	else
+		return (pud_t *)(pgda);
+}
+
 static int calculate_plat_config(void)
 {
 	va_bits = NUMBER(VA_BITS);
@@ -212,8 +235,11 @@ vaddr_to_paddr_arm64(unsigned long vaddr)
 		return NOT_PADDR;
 	}
 
-	pudv.pgd = pgdv;
-	puda = (pud_t *)pgda;
+	puda = pud_offset(pgda, &pgdv, vaddr);
+	if (!readmem(PADDR, (unsigned long long)puda, &pudv, sizeof(pudv))) {
+		ERRMSG("Can't read pud\n");
+		return NOT_PADDR;
+	}
 
 	pmda = pmd_offset(puda, &pudv, vaddr);
 	if (!readmem(PADDR, (unsigned long long)pmda, &pmdv, sizeof(pmdv))) {
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
