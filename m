Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h2w9U-0008Eu-6C
 for kexec@lists.infradead.org; Sun, 10 Mar 2019 10:57:58 +0000
Received: by mail-pf1-f195.google.com with SMTP id v21so1526956pfm.12
 for <kexec@lists.infradead.org>; Sun, 10 Mar 2019 03:57:56 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH v3 3/3] makedumpfile/arm64: Add support for ARMv8.2-LVA
 (52-bit user-space VA support)
Date: Sun, 10 Mar 2019 16:27:35 +0530
Message-Id: <1552215455-12696-4-git-send-email-bhsharma@redhat.com>
In-Reply-To: <1552215455-12696-1-git-send-email-bhsharma@redhat.com>
References: <1552215455-12696-1-git-send-email-bhsharma@redhat.com>
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
To: kexec@lists.infradead.org
Cc: bhupesh.linux@gmail.com, bhsharma@redhat.com, k-hagio@ab.jp.nec.com

With ARMv8.2-LVA architecture extension availability, arm64 hardware
which supports this extension can support upto 52-bit virtual
addresses. It is specially useful for having a 52-bit user-space virtual
address space while the kernel can still retain 48-bit virtual
addresses.

Since at the moment we enable the support of this extension in the
kernel via a CONFIG flag (CONFIG_ARM64_USER_VA_BITS_52), so there are
no clear mechanisms in user-space to determine this CONFIG
flag value and use it to determine the user-space VA address range
values.

'makedumpfile' can instead use 'MAX_USER_VA_BITS' value to
determine the maximum virtual physical address supported by user-space.
If 'MAX_USER_VA_BITS' value is greater than 'VA_BITS' than we are
running a use-case where user-space is 52-bit and underlying kernel is
still 48-bit. The increased 'PTRS_PER_PGD' value for such cases can then
be calculated as is done by the underlying kernel (see kernel file
'arch/arm64/include/asm/pgtable-hwdef.h' for details):

  #define PTRS_PER_PGD          (1 << (MAX_USER_VA_BITS - PGDIR_SHIFT))

I have sent a kernel patch upstream to add 'MAX_USER_VA_BITS' to
vmcoreinfo for arm64 (see [0]).

This patch is in accordance with ARMv8 Architecture Reference Manual
version D.a

[0].
http://lists.infradead.org/pipermail/kexec/2019-February/022411.html

Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 arch/arm64.c   | 106 +++++++++++++++++++++++++++++++++++++++++----------------
 makedumpfile.c |   2 ++
 makedumpfile.h |   1 +
 3 files changed, 79 insertions(+), 30 deletions(-)

diff --git a/arch/arm64.c b/arch/arm64.c
index 6ed09fab5ba2..d23128df31f1 100644
--- a/arch/arm64.c
+++ b/arch/arm64.c
@@ -47,6 +47,7 @@ typedef struct {
 static int lpa_52_bit_support_available;
 static int pgtable_level;
 static int va_bits;
+static int ptrs_per_pgd;
 static unsigned long kimage_voffset;
 
 #define SZ_4K			4096
@@ -107,7 +108,6 @@ typedef unsigned long pgdval_t;
 #define PGDIR_SHIFT		ARM64_HW_PGTABLE_LEVEL_SHIFT(4 - (pgtable_level))
 #define PGDIR_SIZE		(_AC(1, UL) << PGDIR_SHIFT)
 #define PGDIR_MASK		(~(PGDIR_SIZE-1))
-#define PTRS_PER_PGD		(1 << ((va_bits) - PGDIR_SHIFT))
 
 /*
  * Section address mask and size definitions.
@@ -166,7 +166,7 @@ __pte_to_phys(pte_t pte)
 }
 
 /* Find an entry in a page-table-directory */
-#define pgd_index(vaddr) 		(((vaddr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
+#define pgd_index(vaddr) 		(((vaddr) >> PGDIR_SHIFT) & (ptrs_per_pgd - 1))
 
 static inline pte_t
 pgd_pte(pgd_t pgd)
@@ -386,6 +386,46 @@ get_stext_symbol(void)
 	return(found ? kallsym : FALSE);
 }
 
+static int
+get_va_bits_from_stext_arm64(void)
+{
+	ulong _stext;
+
+	_stext = get_stext_symbol();
+	if (!_stext) {
+		ERRMSG("Can't get the symbol of _stext.\n");
+		return FALSE;
+	}
+
+	/* Derive va_bits as per arch/arm64/Kconfig */
+	if ((_stext & PAGE_OFFSET_36) == PAGE_OFFSET_36) {
+		va_bits = 36;
+	} else if ((_stext & PAGE_OFFSET_39) == PAGE_OFFSET_39) {
+		va_bits = 39;
+	} else if ((_stext & PAGE_OFFSET_42) == PAGE_OFFSET_42) {
+		va_bits = 42;
+	} else if ((_stext & PAGE_OFFSET_47) == PAGE_OFFSET_47) {
+		va_bits = 47;
+	} else if ((_stext & PAGE_OFFSET_48) == PAGE_OFFSET_48) {
+		va_bits = 48;
+	} else {
+		ERRMSG("Cannot find a proper _stext for calculating VA_BITS\n");
+		return FALSE;
+	}
+
+	DEBUG_MSG("va_bits      : %d (_stext)\n", va_bits);
+
+	return TRUE;
+}
+
+static void
+get_page_offset_arm64(void)
+{
+	info->page_offset = (0xffffffffffffffffUL) << (va_bits - 1);
+
+	DEBUG_MSG("page_offset  : %lx\n", info->page_offset);
+}
+
 int
 get_machdep_info_arm64(void)
 {
@@ -400,8 +440,37 @@ get_machdep_info_arm64(void)
 	/* Check if va_bits is still not initialized. If still 0, call
 	 * get_versiondep_info() to initialize the same.
 	 */
+	if (NUMBER(VA_BITS) != NOT_FOUND_NUMBER) {
+		va_bits = NUMBER(VA_BITS);
+		DEBUG_MSG("va_bits    : %d (vmcoreinfo)\n",
+				va_bits);
+	}
+
+	/* Check if va_bits is still not initialized. If still 0, call
+	 * get_versiondep_info() to initialize the same from _stext
+	 * symbol.
+	 */
 	if (!va_bits)
-		get_versiondep_info_arm64();
+		if (get_va_bits_from_stext_arm64() == FALSE)
+			return FALSE;
+
+	get_page_offset_arm64();
+
+	if (NUMBER(PTRS_PER_PGD) != NOT_FOUND_NUMBER) {
+		ptrs_per_pgd = NUMBER(PTRS_PER_PGD);
+		DEBUG_MSG("ptrs_per_pgd : %d (vmcoreinfo)\n",
+				ptrs_per_pgd);
+	}
+
+	/* Check if ptrs_per_pgd is still not initialized.
+	 * If still 0, its not available in vmcoreinfo and its
+	 * safe to initialize it with va_bits.
+	 */
+	if (!ptrs_per_pgd) {
+		ptrs_per_pgd = (1 << ((va_bits) - PGDIR_SHIFT));
+		DEBUG_MSG("ptrs_per_pgd : %d (default)\n",
+				ptrs_per_pgd);
+	}
 
 	if (!calculate_plat_config()) {
 		ERRMSG("Can't determine platform config values\n");
@@ -439,34 +508,11 @@ get_xen_info_arm64(void)
 int
 get_versiondep_info_arm64(void)
 {
-	ulong _stext;
-
-	_stext = get_stext_symbol();
-	if (!_stext) {
-		ERRMSG("Can't get the symbol of _stext.\n");
-		return FALSE;
-	}
-
-	/* Derive va_bits as per arch/arm64/Kconfig */
-	if ((_stext & PAGE_OFFSET_36) == PAGE_OFFSET_36) {
-		va_bits = 36;
-	} else if ((_stext & PAGE_OFFSET_39) == PAGE_OFFSET_39) {
-		va_bits = 39;
-	} else if ((_stext & PAGE_OFFSET_42) == PAGE_OFFSET_42) {
-		va_bits = 42;
-	} else if ((_stext & PAGE_OFFSET_47) == PAGE_OFFSET_47) {
-		va_bits = 47;
-	} else if ((_stext & PAGE_OFFSET_48) == PAGE_OFFSET_48) {
-		va_bits = 48;
-	} else {
-		ERRMSG("Cannot find a proper _stext for calculating VA_BITS\n");
-		return FALSE;
-	}
-
-	info->page_offset = (0xffffffffffffffffUL) << (va_bits - 1);
+	if (!va_bits)
+		if (get_va_bits_from_stext_arm64() == FALSE)
+			return FALSE;
 
-	DEBUG_MSG("va_bits      : %d\n", va_bits);
-	DEBUG_MSG("page_offset  : %lx\n", info->page_offset);
+	get_page_offset_arm64();
 
 	return TRUE;
 }
diff --git a/makedumpfile.c b/makedumpfile.c
index b7c1c01251bf..3ddb99a1e988 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2291,6 +2291,7 @@ write_vmcoreinfo_data(void)
 
 	WRITE_NUMBER("HUGETLB_PAGE_DTOR", HUGETLB_PAGE_DTOR);
 #ifdef __aarch64__
+	WRITE_NUMBER("PTRS_PER_PGD", PTRS_PER_PGD);
 	WRITE_NUMBER("VA_BITS", VA_BITS);
 	WRITE_NUMBER_UNSIGNED("PHYS_OFFSET", PHYS_OFFSET);
 	WRITE_NUMBER_UNSIGNED("kimage_voffset", kimage_voffset);
@@ -2694,6 +2695,7 @@ read_vmcoreinfo(void)
 	READ_NUMBER("PAGE_BUDDY_MAPCOUNT_VALUE", PAGE_BUDDY_MAPCOUNT_VALUE);
 	READ_NUMBER("phys_base", phys_base);
 #ifdef __aarch64__
+	READ_NUMBER("PTRS_PER_PGD", PTRS_PER_PGD);
 	READ_NUMBER("VA_BITS", VA_BITS);
 	READ_NUMBER_UNSIGNED("PHYS_OFFSET", PHYS_OFFSET);
 	READ_NUMBER_UNSIGNED("kimage_voffset", kimage_voffset);
diff --git a/makedumpfile.h b/makedumpfile.h
index d49f1f1fc1a9..a9f88721f141 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1933,6 +1933,7 @@ struct number_table {
 	long    HUGETLB_PAGE_DTOR;
 	long	phys_base;
 #ifdef __aarch64__
+	long 	PTRS_PER_PGD;
 	long 	VA_BITS;
 	unsigned long	PHYS_OFFSET;
 	unsigned long	kimage_voffset;
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
