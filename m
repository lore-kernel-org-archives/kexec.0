Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a5Fjg-0002cZ-Ix
 for kexec@lists.infradead.org; Sat, 05 Dec 2015 16:31:01 +0000
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH 1/4] ARM64: Refactor code to support multiple page level
Date: Sat,  5 Dec 2015 22:00:00 +0530
Message-Id: <dfccf238d235acdf994f545e2d99136ac13cd96b.1449332470.git.panand@redhat.com>
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

This patch refactor existing code, so that multiple page level can be
supported. No functional change. Platform dependent values like page
table level, page shift and VA bits are still hard coded as 2, 16 and
42, to support 2 level 64K pages.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/arm64.c   | 44 +++++++++++++++++++++++++++++++++++++++++---
 makedumpfile.h | 26 ++++----------------------
 2 files changed, 45 insertions(+), 25 deletions(-)

diff --git a/arch/arm64.c b/arch/arm64.c
index 06daf646e35d..643c21f8feb1 100644
--- a/arch/arm64.c
+++ b/arch/arm64.c
@@ -23,7 +23,6 @@
 #include "../makedumpfile.h"
 #include "../print_info.h"
 
-#if CONFIG_ARM64_PGTABLE_LEVELS == 2
 typedef struct {
 	unsigned long pgd;
 } pgd_t;
@@ -45,8 +44,6 @@ typedef struct {
 #define PUD_SHIFT		PGDIR_SHIFT
 #define PUD_SIZE		(1UL << PUD_SHIFT)
 
-#endif
-
 typedef struct {
 	unsigned long pte;
 } pte_t;
@@ -96,6 +93,41 @@ typedef struct {
 #define MODULES_END			PAGE_OFFSET
 #define MODULES_VADDR			(MODULES_END - 0x4000000)
 
+static int pgtable_level;
+static int va_bits;
+static int page_shift;
+
+int
+get_pgtable_level_arm64(void)
+{
+	return pgtable_level;
+}
+
+int
+get_va_bits_arm64(void)
+{
+	return va_bits;
+}
+
+int
+get_page_shift_arm64(void)
+{
+	return page_shift;
+}
+
+static int calculate_plat_config(void)
+{
+	/*
+	 * TODO: Keep it fixed for page level 2, size 64K and VA bits as
+	 * 42, as of now. Will calculate them from symbol address values
+	 * latter.
+	 */
+	pgtable_level = 2;
+	va_bits = 42;
+	page_shift = 16;
+
+	return TRUE;
+}
 
 static int
 is_vtop_from_page_table_arm64(unsigned long vaddr)
@@ -114,6 +146,12 @@ get_phys_base_arm64(void)
 	unsigned long phys_base = ULONG_MAX;
 	unsigned long long phys_start;
 	int i;
+
+	if (!calculate_plat_config()) {
+		ERRMSG("Can't determine platform config values\n");
+		return FALSE;
+	}
+
 	/*
 	 * We resolve phys_base from PT_LOAD segments. LMA contains physical
 	 * address of the segment, and we use the lowest start as
diff --git a/makedumpfile.h b/makedumpfile.h
index e333ae8a37a2..abe6a9897095 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -503,28 +503,10 @@ do { \
 #define PMASK			(0x7ffffffffffff000UL)
 
 #ifdef __aarch64__
-#define CONFIG_ARM64_PGTABLE_LEVELS	2
-#define CONFIG_ARM64_VA_BITS		42
-#define CONFIG_ARM64_64K_PAGES		1
-
-/* Currently we only suport following defines based on above
- * config definitions.
- * TODOs: We need to find a way to get above defines dynamically and
- * then to support following definitions based on that
- */
-
-#if CONFIG_ARM64_PGTABLE_LEVELS == 2
-#define ARM64_PGTABLE_LEVELS	2
-#endif
-
-#if CONFIG_ARM64_VA_BITS == 42
-#define VA_BITS			42
-#endif
-
-#ifdef CONFIG_ARM64_64K_PAGES
-#define PAGE_SHIFT		16
-#endif
-
+int get_va_bits_arm64(void);
+#define ARM64_PGTABLE_LEVELS	get_pgtable_level_arm64()
+#define VA_BITS			get_va_bits_arm64()
+#define PAGE_SHIFT		get_page_shift_arm64()
 #define KVBASE_MASK		(0xffffffffffffffffUL << (VA_BITS - 1))
 #define KVBASE			(SYMBOL(_stext) & KVBASE_MASK)
 #endif /* aarch64 */
-- 
2.5.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
