Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1byw5p-0000m9-Ba
 for kexec@lists.infradead.org; Tue, 25 Oct 2016 07:24:21 +0000
Received: by mail-qk0-f178.google.com with SMTP id n189so254690088qke.0
 for <kexec@lists.infradead.org>; Tue, 25 Oct 2016 00:23:56 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH Makedumpfile 10/10] arm64: fix memory layout as per changes in
 v4.6 kernel
Date: Tue, 25 Oct 2016 12:53:02 +0530
Message-Id: <ea2b61be816105c177f31f60c473cf0be4720bfb.1477378297.git.panand@redhat.com>
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

arm64 memory layout has been changed since 4.6 kernel because of KASLR
support patches.

kimage_voffset is needed to calculate "virtual to physical".

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/arm64.c   | 16 ++++++++++++++--
 makedumpfile.c |  2 ++
 makedumpfile.h |  1 +
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm64.c b/arch/arm64.c
index df58e92536e2..958f57f8e203 100644
--- a/arch/arm64.c
+++ b/arch/arm64.c
@@ -41,10 +41,12 @@ typedef struct {
 
 static int pgtable_level;
 static int va_bits;
+static unsigned long kimage_voffset;
 
 #define SZ_4K			(4 * 1024)
 #define SZ_16K			(16 * 1024)
 #define SZ_64K			(64 * 1024)
+#define SZ_128M			(128 * 1024 * 1024)
 
 #define pgd_val(x)		((x).pgd)
 #define pud_val(x)		(pgd_val((x).pgd))
@@ -77,8 +79,6 @@ static int va_bits;
 #define PMD_TYPE_SECT		1
 #define PMD_TYPE_TABLE		3
 
-#define __pa(vaddr) 			((vaddr) - PAGE_OFFSET + info->phys_base)
-
 #define pgd_index(vaddr) 		(((vaddr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
 #define pgd_offset(pgdir, vaddr)	((pgd_t *)(pgdir) + pgd_index(vaddr))
 
@@ -94,6 +94,16 @@ static int va_bits;
 #define pud_index(vaddr)		(((vaddr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
 #define pgd_page_paddr(pgd)		(pgd_val(pgd) & PHYS_MASK & (int32_t)PAGE_MASK)
 
+static unsigned long long
+__pa(unsigned long vaddr)
+{
+	if (kimage_voffset == NOT_FOUND_NUMBER ||
+			(vaddr >= PAGE_OFFSET))
+		return (vaddr - PAGE_OFFSET + info->phys_base);
+	else
+		return (vaddr - kimage_voffset);
+}
+
 static int
 get_pud_shift_arm64(void)
 {
@@ -169,10 +179,12 @@ get_machdep_info_arm64(void)
 		return FALSE;
 	}
 
+	kimage_voffset = NUMBER(kimage_voffset);
 	info->max_physmem_bits = PHYS_MASK_SHIFT;
 	info->section_size_bits = SECTIONS_SIZE_BITS;
 	info->page_offset = 0xffffffffffffffffUL << (va_bits - 1);
 
+	DEBUG_MSG("kimage_voffset   : %lx\n", kimage_voffset);
 	DEBUG_MSG("max_physmem_bits : %lx\n", info->max_physmem_bits);
 	DEBUG_MSG("section_size_bits: %lx\n", info->section_size_bits);
 	DEBUG_MSG("page_offset      : %lx\n", info->page_offset);
diff --git a/makedumpfile.c b/makedumpfile.c
index df413f066348..1fa9a63359c4 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2266,6 +2266,7 @@ write_vmcoreinfo_data(void)
 #ifdef __aarch64__
 	WRITE_NUMBER("VA_BITS", VA_BITS);
 	WRITE_NUMBER_UNSIGNED("PHYS_OFFSET", PHYS_OFFSET);
+	WRITE_NUMBER_UNSIGNED("kimage_voffset", kimage_voffset);
 #endif
 
 	/*
@@ -2652,6 +2653,7 @@ read_vmcoreinfo(void)
 #ifdef __aarch64__
 	READ_NUMBER("VA_BITS", VA_BITS);
 	READ_NUMBER_UNSIGNED("PHYS_OFFSET", PHYS_OFFSET);
+	READ_NUMBER_UNSIGNED("kimage_voffset", kimage_voffset);
 #endif
 
 	READ_NUMBER("HUGETLB_PAGE_DTOR", HUGETLB_PAGE_DTOR);
diff --git a/makedumpfile.h b/makedumpfile.h
index 8ddc2c43cc29..f0154226bcb8 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1737,6 +1737,7 @@ struct number_table {
 #ifdef __aarch64__
 	long 	VA_BITS;
 	unsigned long	PHYS_OFFSET;
+	unsigned long	kimage_voffset;
 #endif
 };
 
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
