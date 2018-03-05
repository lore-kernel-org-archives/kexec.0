Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1estgU-0002qs-Fn
 for kexec@lists.infradead.org; Mon, 05 Mar 2018 17:14:03 +0000
Received: by mail-pg0-f66.google.com with SMTP id y8so7069926pgr.9
 for <kexec@lists.infradead.org>; Mon, 05 Mar 2018 09:13:48 -0800 (PST)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH v2 2/3] arm64: Add support to read symbols like _stext from
 '/proc/kallsyms'
Date: Mon,  5 Mar 2018 22:42:55 +0530
Message-Id: <1520269976-8850-3-git-send-email-bhsharma@redhat.com>
In-Reply-To: <1520269976-8850-1-git-send-email-bhsharma@redhat.com>
References: <1520269976-8850-1-git-send-email-bhsharma@redhat.com>
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
Cc: bhsharma@redhat.com, bhupesh.linux@gmail.com

On ARM64 platforms the VA_BITS supported by a linux kernel being run
can be selected by setting 'ARM64_VA_BITS_*' (see 'arch/arm64/Kconfig'
for details).

Now, to determine the 'info->page_offset' in arm64 makedumpfile
context ('arch/arm64.c') we need to determine the VA_BITS which was
selected by the underlying linux kernel.

There can be several ways to determine the VA_BITS, out of which
reading the '_stext' symbol and calculating the 'va_bits' using the
same is the simplest yet portable method.

For reading the kernel symbols like '_stext', we can read the
'/proc/kallsyms' file which contains these symbols and
works even in case of KASLR enabled arm64 kernels, as in those cases,
the '_stext' symbol will end up being randomized and hence
cannot be correctly read from the 'vmlinux' file.

Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 arch/arm64.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 74 insertions(+), 4 deletions(-)

diff --git a/arch/arm64.c b/arch/arm64.c
index 25d7a1f4db98..8a71abdabd59 100644
--- a/arch/arm64.c
+++ b/arch/arm64.c
@@ -48,6 +48,12 @@ static unsigned long kimage_voffset;
 #define SZ_64K			(64 * 1024)
 #define SZ_128M			(128 * 1024 * 1024)
 
+#define PAGE_OFFSET_36 ((0xffffffffffffffffUL) << 36)
+#define PAGE_OFFSET_39 ((0xffffffffffffffffUL) << 39)
+#define PAGE_OFFSET_42 ((0xffffffffffffffffUL) << 42)
+#define PAGE_OFFSET_47 ((0xffffffffffffffffUL) << 47)
+#define PAGE_OFFSET_48 ((0xffffffffffffffffUL) << 48)
+
 #define pgd_val(x)		((x).pgd)
 #define pud_val(x)		(pgd_val((x).pgd))
 #define pmd_val(x)		(pud_val((x).pud))
@@ -140,8 +146,6 @@ pud_offset(pgd_t *pgda, pgd_t *pgdv, unsigned long vaddr)
 
 static int calculate_plat_config(void)
 {
-	va_bits = NUMBER(VA_BITS);
-
 	/* derive pgtable_level as per arch/arm64/Kconfig */
 	if ((PAGESIZE() == SZ_16K && va_bits == 36) ||
 			(PAGESIZE() == SZ_64K && va_bits == 42)) {
@@ -177,6 +181,45 @@ get_phys_base_arm64(void)
 	return TRUE;
 }
 
+ulong
+get_stext_symbol(void)
+{
+	int found;
+	FILE *fp;
+	char buf[BUFSIZE];
+	char *kallsyms[MAXARGS];
+	ulong kallsym;
+
+	if (!file_exists("/proc/kallsyms")) {
+		ERRMSG("(%s) does not exist, will not be able to read symbols. %s\n",
+		       "/proc/kallsyms", strerror(errno));
+		return FALSE;
+	}
+
+	if ((fp = fopen("/proc/kallsyms", "r")) == NULL) {
+		ERRMSG("Cannot open (%s) to read symbols. %s\n",
+		       "/proc/kallsyms", strerror(errno));
+		return FALSE;
+	}
+
+	found = FALSE;
+	kallsym = 0;
+
+	while (!found && fgets(buf, BUFSIZE, fp) &&
+	      (parse_line(buf, kallsyms) == 3)) {
+		if (hexadecimal(kallsyms[0], 0) &&
+		    STREQ(kallsyms[2], "_stext")) {
+			kallsym = htol(kallsyms[0], RETURN_ON_ERROR,
+					NULL);
+			found = TRUE;
+			break;
+		}
+	}
+	fclose(fp);
+
+	return(found ? kallsym : FALSE);
+}
+
 int
 get_machdep_info_arm64(void)
 {
@@ -188,12 +231,10 @@ get_machdep_info_arm64(void)
 	kimage_voffset = NUMBER(kimage_voffset);
 	info->max_physmem_bits = PHYS_MASK_SHIFT;
 	info->section_size_bits = SECTIONS_SIZE_BITS;
-	info->page_offset = 0xffffffffffffffffUL << (va_bits - 1);
 
 	DEBUG_MSG("kimage_voffset   : %lx\n", kimage_voffset);
 	DEBUG_MSG("max_physmem_bits : %lx\n", info->max_physmem_bits);
 	DEBUG_MSG("section_size_bits: %lx\n", info->section_size_bits);
-	DEBUG_MSG("page_offset      : %lx\n", info->page_offset);
 
 	return TRUE;
 }
@@ -219,6 +260,35 @@ get_xen_info_arm64(void)
 int
 get_versiondep_info_arm64(void)
 {
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
+	info->page_offset = (0xffffffffffffffffUL) << (va_bits - 1);
+
+	DEBUG_MSG("page_offset=%lx, va_bits=%d\n", info->page_offset,
+			va_bits);
+
 	return TRUE;
 }
 
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
