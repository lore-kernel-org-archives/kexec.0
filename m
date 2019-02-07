Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grpjM-0008GP-Mg
 for kexec@lists.infradead.org; Thu, 07 Feb 2019 19:53:07 +0000
Received: by mail-pl1-f193.google.com with SMTP id o6so413329pls.13
 for <kexec@lists.infradead.org>; Thu, 07 Feb 2019 11:53:04 -0800 (PST)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH] makedumpfile/arm64: Add support for ARMv8.2-LVA (52-bit
 user-space VA support)
Date: Fri,  8 Feb 2019 01:22:57 +0530
Message-Id: <1549569177-7116-1-git-send-email-bhsharma@redhat.com>
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

Since at the moment we enable the support of this extensions in the
kernel via a CONFIG flags (CONFIG_ARM64_USER_VA_BITS_52), so there are
no clear mechanisms in user-space to determine this CONFIG
flag value and use it to determine the PA address range values.

'makedumpfile' can instead use 'MAX_USER_VA_BITS' value to
determine the maximum virtual physical address supported by user-space.
If 'MAX_USER_VA_BITS' value is greater than 'VA_BITS' than we might be
running a use-case where user-space is 52-bit and underlying kernel is
still 48-bit. The increased 'PTRS_PER_PGD' value for such cases can then
be calculated as is done by the underlying kernel (see kernel file
'arch/arm64/include/asm/pgtable-hwdef.h' for details):

I have sent a kernel patch upstream to add 'MAX_USER_VA_BITS' to
vmcoreinfo for arm64 (see [0]).

This patch is in accordance with ARMv8 Architecture Reference Manual
version D.a

[0].
http://lists.infradead.org/pipermail/kexec/2019-February/022411.html

Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 arch/arm64.c   | 105 +++++++++++++++++++++++++++++++++++++++++----------------
 makedumpfile.c |   2 ++
 makedumpfile.h |   1 +
 3 files changed, 79 insertions(+), 29 deletions(-)

diff --git a/arch/arm64.c b/arch/arm64.c
index a1db7dc63107..b522e93f4e80 100644
--- a/arch/arm64.c
+++ b/arch/arm64.c
@@ -47,6 +47,7 @@ typedef struct {
 static int lpa_52_bit_support_available;
 static int pgtable_level;
 static int va_bits;
+static int max_user_va_bits;
 static unsigned long kimage_voffset;
 
 #define SZ_4K			4096
@@ -145,7 +146,7 @@ get_page_table_level_arm64(void)
 #define PGDIR_SHIFT		ARM64_HW_PGTABLE_LEVEL_SHIFT(4 - (get_page_table_level_arm64()))
 #define PGDIR_SIZE		(_AC(1, UL) << PGDIR_SHIFT)
 #define PGDIR_MASK		(~(PGDIR_SIZE-1))
-#define PTRS_PER_PGD		(1 << ((va_bits) - PGDIR_SHIFT))
+#define PTRS_PER_PGD		(1 << ((max_user_va_bits) - PGDIR_SHIFT))
 
 /*
  * Section address mask and size definitions.
@@ -478,6 +479,46 @@ get_stext_symbol(void)
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
+	DEBUG_MSG("va_bits      : %d\n", va_bits);
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
@@ -493,8 +534,37 @@ get_machdep_info_arm64(void)
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
+		if (get_va_bits_from_stext_arm64() == ERROR)
+			return ERROR;
+
+	get_page_offset_arm64();
+
+	if (NUMBER(MAX_USER_VA_BITS) != NOT_FOUND_NUMBER) {
+		max_user_va_bits = NUMBER(MAX_USER_VA_BITS);
+		DEBUG_MSG("max_user_va_bits : %d (vmcoreinfo)\n",
+				max_user_va_bits);
+	}
+
+	/* Check if max_user_va_bits is still not initialized.
+	 * If still 0, its not available in vmcoreinfo and its
+	 * safe to initialize it with va_bits.
+	 */
+	if (!max_user_va_bits) {
+		max_user_va_bits = va_bits;
+		DEBUG_MSG("max_user_va_bits : %d (default = va_bits)\n",
+				max_user_va_bits);
+	}
 
 	if (!calculate_plat_config()) {
 		ERRMSG("Can't determine platform config values\n");
@@ -533,34 +603,11 @@ get_xen_info_arm64(void)
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
+		if (get_va_bits_from_stext_arm64() == ERROR)
+			return ERROR;
 
-	DEBUG_MSG("va_bits      : %d\n", va_bits);
-	DEBUG_MSG("page_offset  : %lx\n", info->page_offset);
+	get_page_offset_arm64();
 
 	return TRUE;
 }
diff --git a/makedumpfile.c b/makedumpfile.c
index b7c1c01251bf..ccf7eb4408ba 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2291,6 +2291,7 @@ write_vmcoreinfo_data(void)
 
 	WRITE_NUMBER("HUGETLB_PAGE_DTOR", HUGETLB_PAGE_DTOR);
 #ifdef __aarch64__
+	WRITE_NUMBER("MAX_USER_VA_BITS", MAX_USER_VA_BITS);
 	WRITE_NUMBER("VA_BITS", VA_BITS);
 	WRITE_NUMBER_UNSIGNED("PHYS_OFFSET", PHYS_OFFSET);
 	WRITE_NUMBER_UNSIGNED("kimage_voffset", kimage_voffset);
@@ -2694,6 +2695,7 @@ read_vmcoreinfo(void)
 	READ_NUMBER("PAGE_BUDDY_MAPCOUNT_VALUE", PAGE_BUDDY_MAPCOUNT_VALUE);
 	READ_NUMBER("phys_base", phys_base);
 #ifdef __aarch64__
+	READ_NUMBER("MAX_USER_VA_BITS", MAX_USER_VA_BITS);
 	READ_NUMBER("VA_BITS", VA_BITS);
 	READ_NUMBER_UNSIGNED("PHYS_OFFSET", PHYS_OFFSET);
 	READ_NUMBER_UNSIGNED("kimage_voffset", kimage_voffset);
diff --git a/makedumpfile.h b/makedumpfile.h
index d49f1f1fc1a9..3fa810e0bb40 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1933,6 +1933,7 @@ struct number_table {
 	long    HUGETLB_PAGE_DTOR;
 	long	phys_base;
 #ifdef __aarch64__
+	long 	MAX_USER_VA_BITS;
 	long 	VA_BITS;
 	unsigned long	PHYS_OFFSET;
 	unsigned long	kimage_voffset;
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
