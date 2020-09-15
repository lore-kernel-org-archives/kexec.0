Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIIBR-0006H5-TF
 for kexec@lists.infradead.org; Tue, 15 Sep 2020 21:08:15 +0000
Received: by mail-pj1-f70.google.com with SMTP id fs5so454857pjb.7
 for <kexec@lists.infradead.org>; Tue, 15 Sep 2020 14:08:09 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH] kexec/arm64: Add support for ARMv8.2 (large space addressing)
 52-bit VA extensions
Date: Wed, 16 Sep 2020 02:37:55 +0530
Message-Id: <20200915210755.555316-1-bhsharma@redhat.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: bhsharma@redhat.com, bhupesh.linux@gmail.com, Simon Horman <horms@verge.net.au>

This patch adds support for ARMv8.2 52-bit VA (large space addressing)
extension in kexec-tools.

With ARMv8.2-LVA architecture extension availability, arm64 hardware
which supports this extension can support upto 52-bit virtual
addresses. It is specially useful for having a 52-bit user-space virtual
address space while the kernel can still retain 48-bit/52-bit virtual
addressing.

Since at the moment we enable the support of this extension in the
kernel via a CONFIG flag (CONFIG_ARM64_VA_BITS_52), so there are
no clear mechanisms in user-space to determine this CONFIG
flag value and use it to determine the kernel-space VA address range
values.

'kexec-tools' can instead use 'TCR_EL1.T1SZ' value from vmcoreinfo
which indicates the size offset of the memory region addressed by
TTBR1_EL1 (and hence can be used for determining the
'vabits_actual' value).

Using the vmcoreinfo variable exported by kernel commit
 bbdbc11804ff ("arm64/crash_core: Export TCR_EL1.T1SZ in vmcoreinfo"),
the user-space can use the following computation for determining the
'vabits_actual' value:

   if (TCR_EL1.T1SZ is available in vmcoreinfo)
	vabits_actual = 64 - TCR_EL1.T1SZ;
   else {
        read_id_aa64mmfr2_el1();

        if (hardware supports 52-bit addressing)
	   vabits_actual = 52;
        else
	   vabits_actual = va_bits value calculated via _stext symbol;
   }

I have tested several combinations with both old and latest upstream
kernels with different VA values (39, 42, 48 and 52-bits) on at-least
3 different boards, which include:
1. CPUs which don't support ARMv8.2 features, e.g. qualcomm-amberwing,
   ampere-osprey.
2. Prototype models which support ARMv8.2 extensions (e.g. ARMv8 FVP
   simulation model).

This patch is in accordance with ARMv8 Architecture Reference Manual.

Cc: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 kexec/arch/arm64/Makefile          |   2 +
 kexec/arch/arm64/common-arm64.c    | 332 +++++++++++++++++++++++++++++
 kexec/arch/arm64/common-arm64.h    |   8 +
 kexec/arch/arm64/crashdump-arm64.c |  29 +--
 kexec/arch/arm64/kexec-arm64.c     | 120 +----------
 kexec/kexec.h                      |  10 +
 util_lib/elf_info.c                |  35 +++
 util_lib/include/elf_info.h        |   2 +
 8 files changed, 397 insertions(+), 141 deletions(-)
 create mode 100644 kexec/arch/arm64/common-arm64.c
 create mode 100644 kexec/arch/arm64/common-arm64.h

diff --git a/kexec/arch/arm64/Makefile b/kexec/arch/arm64/Makefile
index d27c8ee1b5e7..4ae21c3b02e6 100644
--- a/kexec/arch/arm64/Makefile
+++ b/kexec/arch/arm64/Makefile
@@ -11,6 +11,7 @@ arm64_MEM_REGIONS = kexec/mem_regions.c
 arm64_CPPFLAGS += -I $(srcdir)/kexec/
 
 arm64_KEXEC_SRCS += \
+	kexec/arch/arm64/common-arm64.c \
 	kexec/arch/arm64/crashdump-arm64.c \
 	kexec/arch/arm64/kexec-arm64.c \
 	kexec/arch/arm64/kexec-elf-arm64.c \
@@ -27,6 +28,7 @@ arm64_PHYS_TO_VIRT =
 
 dist += $(arm64_KEXEC_SRCS) \
 	kexec/arch/arm64/include/arch/options.h \
+	kexec/arch/arm64/common-arm64.h \
 	kexec/arch/arm64/crashdump-arm64.h \
 	kexec/arch/arm64/image-header.h \
 	kexec/arch/arm64/iomem.h \
diff --git a/kexec/arch/arm64/common-arm64.c b/kexec/arch/arm64/common-arm64.c
new file mode 100644
index 000000000000..65942e8914e3
--- /dev/null
+++ b/kexec/arch/arm64/common-arm64.c
@@ -0,0 +1,332 @@
+/*
+ * ARM64 common parts for kexec and crash.
+ */
+
+#define _GNU_SOURCE
+
+#include <assert.h>
+#include <errno.h>
+#include <getopt.h>
+#include <inttypes.h>
+#include <libfdt.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <elf_info.h>
+
+#include <unistd.h>
+#include <syscall.h>
+#include <errno.h>
+#include <asm/hwcap.h>
+#include <sys/auxv.h>
+
+#include "kexec.h"
+#include "kexec-arm64.h"
+#include "common-arm64.h"
+
+#define PAGE_OFFSET_36 ((0xffffffffffffffffUL) << 36)
+#define PAGE_OFFSET_39 ((0xffffffffffffffffUL) << 39)
+#define PAGE_OFFSET_42 ((0xffffffffffffffffUL) << 42)
+#define PAGE_OFFSET_47 ((0xffffffffffffffffUL) << 47)
+#define PAGE_OFFSET_48 ((0xffffffffffffffffUL) << 48)
+
+#define SZ_64K			65536
+
+/* ID_AA64MMFR2_EL1 related helpers: */
+#define ID_AA64MMFR2_LVA_SHIFT	16
+#define ID_AA64MMFR2_LVA_MASK	(0xf << ID_AA64MMFR2_LVA_SHIFT)
+
+/* CPU feature ID registers */
+#define get_cpu_ftr(id) ({							\
+		unsigned long __val;						\
+		asm volatile("mrs %0, " __stringify(id) : "=r" (__val));	\
+		__val;								\
+})
+
+/* Machine specific details. */
+static int va_bits;
+
+/* Global flag which indicates that we have tried reading
+ * TCR_EL1_T1SZ from 'kcore' already.
+ */
+static bool try_read_tcr_el1_t1sz_from_kcore = false;
+
+/**
+ * get_va_bits - Helper for getting VA_BITS
+ */
+
+static int get_va_bits(void)
+{
+	unsigned long long stext_sym_addr = get_kernel_sym("_stext");
+
+	if (stext_sym_addr == 0) {
+		fprintf(stderr, "Can't get the symbol of _stext.\n");
+		return -1;
+	}
+
+	/* Derive va_bits as per arch/arm64/Kconfig. Note that this is a
+	 * best case approximation at the moment, as there can be
+	 * inconsistencies in this calculation (for e.g., for
+	 * 52-bit kernel VA case, the 48th bit is set in
+	 * the _stext symbol).
+	 *
+	 * So, we need to read an architecture system register for a
+	 * accurate value of the virtual addressing supported by
+	 * the underlying kernel.
+	 */
+	if ((stext_sym_addr & PAGE_OFFSET_48) == PAGE_OFFSET_48) {
+		va_bits = 48;
+	} else if ((stext_sym_addr & PAGE_OFFSET_47) == PAGE_OFFSET_47) {
+		va_bits = 47;
+	} else if ((stext_sym_addr & PAGE_OFFSET_42) == PAGE_OFFSET_42) {
+		va_bits = 42;
+	} else if ((stext_sym_addr & PAGE_OFFSET_39) == PAGE_OFFSET_39) {
+		va_bits = 39;
+	} else if ((stext_sym_addr & PAGE_OFFSET_36) == PAGE_OFFSET_36) {
+		va_bits = 36;
+	} else {
+		fprintf(stderr,
+			"Cannot find a proper _stext for calculating VA_BITS\n");
+		return -1;
+	}
+
+	dbgprintf("va_bits : %d\n", va_bits);
+
+	return 0;
+}
+
+/** Note that its important to note that the
+ * ID_AA64MMFR2_EL1 architecture register can be read
+ * only when we give an .arch hint to the gcc/binutils,
+ * so we use the gcc construct '__attribute__ ((target ("arch=armv8.2-a")))'
+ * here which is an .arch directive (see AArch64-Target-selection-directives
+ * documentation from ARM for details). This is required only for
+ * this function to make sure it compiles well with gcc/binutils.
+ */
+
+__attribute__ ((target ("arch=armv8.2-a")))
+static unsigned long read_id_aa64mmfr2_el1(void)
+{
+	return get_cpu_ftr(ID_AA64MMFR2_EL1);
+}
+
+static int get_vabits_actual_from_id_aa64mmfr2_el1(void)
+{
+	int l_vabits_actual;
+	unsigned long val;
+
+	/* Check if ID_AA64MMFR2_EL1 CPU-ID register indicates
+	 * ARMv8.2/LVA support:
+	 * VARange, bits [19:16]
+	 *   From ARMv8.2:
+	 *   Indicates support for a larger virtual address.
+	 *   Defined values are:
+	 *     0b0000 VMSAv8-64 supports 48-bit VAs.
+	 *     0b0001 VMSAv8-64 supports 52-bit VAs when using the 64KB
+	 *            page size. The other translation granules support
+	 *            48-bit VAs.
+	 *
+	 * See ARMv8 ARM for more details.
+	 */
+	if (!(getauxval(AT_HWCAP) & HWCAP_CPUID)) {
+		fprintf(stderr, "arm64 CPUID registers unavailable.\n");
+		return EFAILED;
+	}
+
+	val = read_id_aa64mmfr2_el1();
+	val = (val & ID_AA64MMFR2_LVA_MASK) > ID_AA64MMFR2_LVA_SHIFT;
+
+	if ((val == 0x1) && (getpagesize() == SZ_64K))
+		l_vabits_actual = 52;
+	else
+		l_vabits_actual = 48;
+
+	return l_vabits_actual;
+}
+
+/**
+ * get_vabits_actual - Helper for getting vabits_actual
+ */
+
+static void get_vabits_actual(int *vabits_actual)
+{
+	int l_vabits_actual;
+
+	/* Try to read ID_AA64MMFR2_EL1 CPU-ID register,
+	 * to calculate the vabits_actual.
+	 */
+	l_vabits_actual = get_vabits_actual_from_id_aa64mmfr2_el1();
+	if ((l_vabits_actual == EFAILED) || (l_vabits_actual != 52)) {
+		/* If we cannot read ID_AA64MMFR2_EL1 arch
+		 * register or if this register does not indicate
+		 * support for a larger virtual address, our last
+		 * option is to use the VA_BITS to calculate the
+		 * PAGE_OFFSET value, i.e. vabits_actual = VA_BITS.
+		 */
+		l_vabits_actual = va_bits;
+		dbgprintf("vabits_actual : %d (approximation via va_bits)\n",
+				l_vabits_actual);
+	} else
+		dbgprintf("vabits_actual : %d (via id_aa64mmfr2_el1)\n",
+				l_vabits_actual);
+
+	*vabits_actual = l_vabits_actual;
+}
+
+/**
+ * get_tcr_el1_t1sz_from_vmcoreinfo_pt_note - Helper for getting TCR_EL1_T1SZ
+ * from VMCOREINFO note inside 'kcore'.
+ */
+
+int get_tcr_el1_t1sz_from_vmcoreinfo_pt_note(unsigned long *tcr_t1sz)
+{
+	int fd, ret = 0;
+
+	if ((fd = open("/proc/kcore", O_RDONLY)) < 0) {
+		fprintf(stderr, "Can't open (%s).\n", "/proc/kcore");
+		return EFAILED;
+	}
+
+	ret = read_tcr_el1_t1sz_elf_kcore(fd, tcr_t1sz);
+
+	close(fd);
+	return ret;
+}
+
+/**
+ * get_page_offset_helper - Helper for getting PAGE_OFFSET
+ */
+
+static int get_page_offset_helper(unsigned long *page_offset)
+{
+	int ret;
+	int vabits_actual = INT_MAX;
+	unsigned long tcr_t1sz = UINT64_MAX;
+
+	if (!try_read_tcr_el1_t1sz_from_kcore) {
+		/* Since kernel version 5.5.0, 'kcore' contains
+		 * a new PT_NOTE which carries the VMCOREINFO
+		 * information.
+		 * If the same is available, one should prefer the
+		 * same to retrieve 'TCR_EL1_T1SZ' value exported by
+		 * the kernel as this is now the standard interface
+		 * exposed by kernel for sharing machine specific
+		 * details with the userland.
+		 */
+		ret = get_tcr_el1_t1sz_from_vmcoreinfo_pt_note(&tcr_t1sz);
+		if (!ret) {
+			if (tcr_t1sz != UINT64_MAX) {
+				vabits_actual = 64 - tcr_t1sz;
+				dbgprintf("vabits_actual : %d (via vmcore)\n",
+						vabits_actual);
+			}
+		}
+
+		try_read_tcr_el1_t1sz_from_kcore = true;
+	}
+
+	if (vabits_actual == INT_MAX) {
+		/* If we are running on a older kernel,
+		 * try to retrieve the 'vabits_actual' value
+		 * via other means.
+		 */
+		ret = get_va_bits();
+		if (ret < 0)
+			return ret;
+
+		get_vabits_actual(&vabits_actual);
+	}
+
+	/* If 'vabits_actual' is still uninitialized,
+	 * bail out.
+	 */
+	if (vabits_actual == INT_MAX)
+		return EFAILED;
+
+	/* See arch/arm64/include/asm/memory.h for more details of
+	 * the PAGE_OFFSET calculation.
+	 */
+	if (kernel_version() < KERNEL_VERSION(5, 4, 0))
+		*page_offset = ((0xffffffffffffffffUL) -
+				((1UL) << (vabits_actual - 1)) + 1);
+	else
+		*page_offset = (-(1UL << vabits_actual));
+
+	dbgprintf("page_offset : %lx (via vabits_actual)\n", *page_offset);
+
+	return 0;
+}
+
+/**
+ * get_page_offset - Helper for getting PAGE_OFFSET
+ */
+
+int get_page_offset(unsigned long *page_offset)
+{
+	return get_page_offset_helper(page_offset);
+}
+
+/**
+ * get_phys_offset_from_vmcoreinfo_pt_note - Helper for getting PHYS_OFFSET
+ * from VMCOREINFO note inside 'kcore'.
+ */
+
+int get_phys_offset_from_vmcoreinfo_pt_note(unsigned long *phys_offset)
+{
+	int fd, ret = 0;
+
+	if ((fd = open("/proc/kcore", O_RDONLY)) < 0) {
+		fprintf(stderr, "Can't open (%s).\n", "/proc/kcore");
+		return EFAILED;
+	}
+
+	ret = read_phys_offset_elf_kcore(fd, phys_offset);
+
+	close(fd);
+	return ret;
+}
+
+/**
+ * get_phys_base_from_pt_load - Helper for getting PHYS_OFFSET
+ * from PT_LOADs inside 'kcore'.
+ */
+
+int get_phys_base_from_pt_load(unsigned long *phys_offset)
+{
+	int i, fd, ret;
+	unsigned long page_offset;
+	unsigned long long phys_start;
+	unsigned long long virt_start;
+
+	ret = get_page_offset(&page_offset);
+	if (ret < 0)
+		return ret;
+
+	if ((fd = open("/proc/kcore", O_RDONLY)) < 0) {
+		fprintf(stderr, "Can't open (%s).\n", "/proc/kcore");
+		return EFAILED;
+	}
+
+	read_elf(fd);
+
+	/* Note that the following loop starts with i = 1.
+	 * This is required to make sure that the following logic
+	 * works both for old and newer kernels (with flipped
+	 * VA space, i.e. >= 5.4.0)
+	 */
+	for (i = 1; get_pt_load(i,
+		    &phys_start, NULL, &virt_start, NULL);
+	 	    i++) {
+		if (virt_start != NOT_KV_ADDR
+				&& virt_start >= page_offset
+				&& phys_start != NOT_PADDR)
+			*phys_offset = phys_start -
+				(virt_start & ~page_offset);
+	}
+
+	close(fd);
+	return 0;
+}
+
diff --git a/kexec/arch/arm64/common-arm64.h b/kexec/arch/arm64/common-arm64.h
new file mode 100644
index 000000000000..ab430712a7cb
--- /dev/null
+++ b/kexec/arch/arm64/common-arm64.h
@@ -0,0 +1,8 @@
+#if !defined(COMMON_ARM64_H)
+#define COMMON_ARM64_H
+
+int get_page_offset(unsigned long *page_offset);
+int get_phys_offset_from_vmcoreinfo_pt_note(unsigned long *phys_offset);
+int get_phys_base_from_pt_load(unsigned long *phys_offset);
+
+#endif
diff --git a/kexec/arch/arm64/crashdump-arm64.c b/kexec/arch/arm64/crashdump-arm64.c
index 38d1a0f3000d..ae5c44852782 100644
--- a/kexec/arch/arm64/crashdump-arm64.c
+++ b/kexec/arch/arm64/crashdump-arm64.c
@@ -16,6 +16,7 @@
 #include <linux/elf.h>
 
 #include "kexec.h"
+#include "common-arm64.h"
 #include "crashdump.h"
 #include "crashdump-arm64.h"
 #include "iomem.h"
@@ -46,27 +47,6 @@ static struct crash_elf_info elf_info = {
 	.machine	= EM_AARCH64,
 };
 
-/*
- * Note: The returned value is correct only if !CONFIG_RANDOMIZE_BASE.
- */
-static uint64_t get_kernel_page_offset(void)
-{
-	int i;
-
-	if (elf_info.kern_vaddr_start == UINT64_MAX)
-		return UINT64_MAX;
-
-	/* Current max virtual memory range is 48-bits. */
-	for (i = 48; i > 0; i--)
-		if (!(elf_info.kern_vaddr_start & (1UL << i)))
-			break;
-
-	if (i <= 0)
-		return UINT64_MAX;
-	else
-		return UINT64_MAX << i;
-}
-
 /*
  * iomem_range_callback() - callback called for each iomem region
  * @data: not used
@@ -169,6 +149,7 @@ int load_crashdump_segments(struct kexec_info *info)
 {
 	unsigned long elfcorehdr;
 	unsigned long bufsz;
+	unsigned long page_offset;
 	void *buf;
 	int err;
 
@@ -182,7 +163,11 @@ int load_crashdump_segments(struct kexec_info *info)
 	if (err)
 		return EFAILED;
 
-	elf_info.page_offset = get_kernel_page_offset();
+	err = get_page_offset(&page_offset);
+	if (err)
+		return EFAILED;
+
+	elf_info.page_offset = page_offset;
 	dbgprintf("%s: page_offset:   %016llx\n", __func__,
 			elf_info.page_offset);
 
diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 45ebc54a9b6f..fbbe1946f8d7 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -25,6 +25,7 @@
 
 #include "kexec.h"
 #include "kexec-arm64.h"
+#include "common-arm64.h"
 #include "crashdump.h"
 #include "crashdump-arm64.h"
 #include "dt-ops.h"
@@ -42,21 +43,11 @@
 #define PROP_ELFCOREHDR "linux,elfcorehdr"
 #define PROP_USABLE_MEM_RANGE "linux,usable-memory-range"
 
-#define PAGE_OFFSET_36 ((0xffffffffffffffffUL) << 36)
-#define PAGE_OFFSET_39 ((0xffffffffffffffffUL) << 39)
-#define PAGE_OFFSET_42 ((0xffffffffffffffffUL) << 42)
-#define PAGE_OFFSET_47 ((0xffffffffffffffffUL) << 47)
-#define PAGE_OFFSET_48 ((0xffffffffffffffffUL) << 48)
-
 /* Global flag which indicates that we have tried reading
  * PHYS_OFFSET from 'kcore' already.
  */
 static bool try_read_phys_offset_from_kcore = false;
 
-/* Machine specific details. */
-static int va_bits;
-static unsigned long page_offset;
-
 /* Global varables the core kexec routines expect. */
 
 unsigned char reuse_initrd;
@@ -799,115 +790,6 @@ static inline void set_phys_offset(uint64_t v, char *set_method)
 	}
 }
 
-/**
- * get_va_bits - Helper for getting VA_BITS
- */
-
-static int get_va_bits(void)
-{
-	unsigned long long stext_sym_addr = get_kernel_sym("_stext");
-
-	if (stext_sym_addr == 0) {
-		fprintf(stderr, "Can't get the symbol of _stext.\n");
-		return -1;
-	}
-
-	/* Derive va_bits as per arch/arm64/Kconfig */
-	if ((stext_sym_addr & PAGE_OFFSET_36) == PAGE_OFFSET_36) {
-		va_bits = 36;
-	} else if ((stext_sym_addr & PAGE_OFFSET_39) == PAGE_OFFSET_39) {
-		va_bits = 39;
-	} else if ((stext_sym_addr & PAGE_OFFSET_42) == PAGE_OFFSET_42) {
-		va_bits = 42;
-	} else if ((stext_sym_addr & PAGE_OFFSET_47) == PAGE_OFFSET_47) {
-		va_bits = 47;
-	} else if ((stext_sym_addr & PAGE_OFFSET_48) == PAGE_OFFSET_48) {
-		va_bits = 48;
-	} else {
-		fprintf(stderr,
-			"Cannot find a proper _stext for calculating VA_BITS\n");
-		return -1;
-	}
-
-	dbgprintf("va_bits : %d\n", va_bits);
-
-	return 0;
-}
-
-/**
- * get_page_offset - Helper for getting PAGE_OFFSET
- */
-
-static int get_page_offset(void)
-{
-	int ret;
-
-	ret = get_va_bits();
-	if (ret < 0)
-		return ret;
-
-	page_offset = (0xffffffffffffffffUL) << (va_bits - 1);
-	dbgprintf("page_offset : %lx\n", page_offset);
-
-	return 0;
-}
-
-/**
- * get_phys_offset_from_vmcoreinfo_pt_note - Helper for getting PHYS_OFFSET
- * from VMCOREINFO note inside 'kcore'.
- */
-
-static int get_phys_offset_from_vmcoreinfo_pt_note(unsigned long *phys_offset)
-{
-	int fd, ret = 0;
-
-	if ((fd = open("/proc/kcore", O_RDONLY)) < 0) {
-		fprintf(stderr, "Can't open (%s).\n", "/proc/kcore");
-		return EFAILED;
-	}
-
-	ret = read_phys_offset_elf_kcore(fd, phys_offset);
-
-	close(fd);
-	return ret;
-}
-
-/**
- * get_phys_base_from_pt_load - Helper for getting PHYS_OFFSET
- * from PT_LOADs inside 'kcore'.
- */
-
-int get_phys_base_from_pt_load(unsigned long *phys_offset)
-{
-	int i, fd, ret;
-	unsigned long long phys_start;
-	unsigned long long virt_start;
-
-	ret = get_page_offset();
-	if (ret < 0)
-		return ret;
-
-	if ((fd = open("/proc/kcore", O_RDONLY)) < 0) {
-		fprintf(stderr, "Can't open (%s).\n", "/proc/kcore");
-		return EFAILED;
-	}
-
-	read_elf(fd);
-
-	for (i = 0; get_pt_load(i,
-		    &phys_start, NULL, &virt_start, NULL);
-	 	    i++) {
-		if (virt_start != NOT_KV_ADDR
-				&& virt_start >= page_offset
-				&& phys_start != NOT_PADDR)
-			*phys_offset = phys_start -
-				(virt_start & ~page_offset);
-	}
-
-	close(fd);
-	return 0;
-}
-
 static bool to_be_excluded(char *str)
 {
 	if (!strncmp(str, SYSTEM_RAM, strlen(SYSTEM_RAM)) ||
diff --git a/kexec/kexec.h b/kexec/kexec.h
index f0f347d5e9e0..e1d0264b4dc9 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -122,6 +122,16 @@ do { \
 		fprintf(stderr, __VA_ARGS__); \
 } while(0)
 
+/* Indirect stringification.  Doing two levels allows the parameter to be a
+ * macro itself.  For example, compile with -DFOO=bar, __stringify(FOO)
+ * converts to "bar".
+ *
+ * Copied from linux source: 'include/linux/stringify.h'
+ */
+
+#define __stringify_1(x...)	#x
+#define __stringify(x...)	__stringify_1(x)
+
 struct kexec_segment {
 	const void *buf;
 	size_t bufsz;
diff --git a/util_lib/elf_info.c b/util_lib/elf_info.c
index 7803a948a60e..1ab62a31aa16 100644
--- a/util_lib/elf_info.c
+++ b/util_lib/elf_info.c
@@ -45,6 +45,7 @@ static uint16_t log_offset_len = UINT16_MAX;
 static uint16_t log_offset_text_len = UINT16_MAX;
 
 static uint64_t phys_offset = UINT64_MAX;
+static uint64_t tcr_el1_t1sz = UINT64_MAX;
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define ELFDATANATIVE ELFDATA2LSB
@@ -411,6 +412,20 @@ void scan_vmcoreinfo(char *start, size_t size)
 			}
 		}
 
+		/* Check for TCR_EL1_T1SZ */
+		str = "NUMBER(TCR_EL1_T1SZ)=";
+		if (memcmp(str, pos, strlen(str)) == 0) {
+			tcr_el1_t1sz = strtoul(pos + strlen(str), &endp,
+							10);
+			if (strlen(endp) != 0)
+				tcr_el1_t1sz = strtoul(pos + strlen(str), &endp, 16);
+			if ((tcr_el1_t1sz == LONG_MAX) || strlen(endp) != 0) {
+				fprintf(stderr, "Invalid data %s\n",
+					pos);
+				break;
+			}
+		}
+
 		if (last_line)
 			break;
 	}
@@ -817,3 +832,23 @@ int read_phys_offset_elf_kcore(int fd, unsigned long *phys_off)
 
 	return 2;
 }
+
+int read_tcr_el1_t1sz_elf_kcore(int fd, unsigned long *tcr_t1sz)
+{
+	int ret;
+
+	*tcr_t1sz = UINT64_MAX;
+
+	ret = read_elf(fd);
+	if (!ret) {
+		/* If we have a valid 'tcr_el1_t1sz' by now,
+		 * return it to the caller now.
+		 */
+		if (tcr_el1_t1sz != UINT64_MAX) {
+			*tcr_t1sz = tcr_el1_t1sz;
+			return ret;
+		}
+	}
+
+	return 2;
+}
diff --git a/util_lib/include/elf_info.h b/util_lib/include/elf_info.h
index 4bc9279ba603..3aa24f64c7fb 100644
--- a/util_lib/include/elf_info.h
+++ b/util_lib/include/elf_info.h
@@ -29,6 +29,8 @@ int get_pt_load(int idx,
 	unsigned long long *virt_start,
 	unsigned long long *virt_end);
 int read_phys_offset_elf_kcore(int fd, unsigned long *phys_off);
+int read_tcr_el1_t1sz_elf_kcore(int fd, unsigned long *tcr_t1sz);
+
 int read_elf(int fd);
 void dump_dmesg(int fd, void (*handler)(char*, unsigned int));
 
-- 
2.26.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
