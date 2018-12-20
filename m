Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZwQ3-0006j6-Gu
 for kexec@lists.infradead.org; Thu, 20 Dec 2018 11:23:13 +0000
Received: by mail-pg1-f195.google.com with SMTP id t13so731529pgr.11
 for <kexec@lists.infradead.org>; Thu, 20 Dec 2018 03:23:09 -0800 (PST)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH v2 2/2] arm64: Add support to read PHYS_OFFSET from 'kcore' -
 pt_note or pt_load (if available)
Date: Thu, 20 Dec 2018 16:52:52 +0530
Message-Id: <1545304972-32333-3-git-send-email-bhsharma@redhat.com>
In-Reply-To: <1545304972-32333-1-git-send-email-bhsharma@redhat.com>
References: <1545304972-32333-1-git-send-email-bhsharma@redhat.com>
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
Cc: Vadim.Lomovtsev@cavium.com, yanjiang.jin@hxt-semitech.com, bhsharma@redhat.com, takahiro.akashi@linaro.org, horms@verge.net.au, bhupesh.linux@gmail.com

On certain arm64 platforms, it has been noticed that due
to a hole at the start of physical ram exposed to kernel
(i.e. it doesn't start from address 0), the kernel still
calculates the 'memstart_addr' kernel variable as 0.

Whereas the SYSTEM_RAM or IOMEM_RESERVED range in '/proc/iomem'
would carry a first entry whose start address is non-zero
(as the physical ram exposed to the kernel starts from a
non-zero address).

In such cases, if we rely on '/proc/iomem' entries to
calculate the phys_offset, then we will have mismatch
between the user-space and kernel space 'PHYS_OFFSET'
value. The present 'kexec-tools' code does the same
in 'get_memory_ranges_iomem_cb()' function when it makes
a call to 'set_phys_offset()'. This can cause the vmcore
generated via 'kexec-tools' to miss the last few bytes as
the first '/proc/iomem' starts from a non-zero address.

Please see [0] for the original bug-report from Yanjiang Jin.

The same can be fixed in the following manner:

1. For newer kernel (>= 4.19, with commit 23c85094fe1895caefdd
["proc/kcore: add vmcoreinfo note to /proc/kcore"] available),
'kcore' contains a new PT_NOTE which carries the VMCOREINFO
information.

If the same is available, one should prefer the same to
retrieve 'PHYS_OFFSET' value exported by the kernel as this
is now the standard interface exposed by kernel for sharing
machine specific details with the user-land as per
the arm64 kernel maintainers (see [1]) .

2. For older kernels, we can try and determine the PHYS_OFFSET
value from PT_LOAD segments inside 'kcore' via some jugglery
of the correct virtual and physical address combinations.

As a fallback, we still support getting the PHYS_OFFSET values
from '/proc/iomem', to maintain backward compatibility.

Testing:
-------
- Tested on my apm-mustang and qualcomm amberwing board with upstream
  kernel (4.20.0-rc7) for both KASLR and non-KASLR boot cases.

References:
-----------
[0] https://www.spinics.net/lists/kexec/msg20618.html
[1] https://www.mail-archive.com/kexec@lists.infradead.org/msg20300.html

Reported-by: Yanjiang Jin <yanjiang.jin@hxt-semitech.com>
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 kexec/arch/arm64/kexec-arm64.c | 194 ++++++++++++++++++++++++++++++++++++++++-
 kexec/arch/arm64/kexec-arm64.h |  15 ++--
 2 files changed, 200 insertions(+), 9 deletions(-)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index b143e861f7d9..34241afea6e1 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -14,6 +14,7 @@
 #include <sys/stat.h>
 #include <linux/elf-em.h>
 #include <elf.h>
+#include <elf_info.h>
 
 #include <unistd.h>
 #include <syscall.h>
@@ -38,6 +39,21 @@
 #define PROP_ELFCOREHDR "linux,elfcorehdr"
 #define PROP_USABLE_MEM_RANGE "linux,usable-memory-range"
 
+#define PAGE_OFFSET_36 ((0xffffffffffffffffUL) << 36)
+#define PAGE_OFFSET_39 ((0xffffffffffffffffUL) << 39)
+#define PAGE_OFFSET_42 ((0xffffffffffffffffUL) << 42)
+#define PAGE_OFFSET_47 ((0xffffffffffffffffUL) << 47)
+#define PAGE_OFFSET_48 ((0xffffffffffffffffUL) << 48)
+
+/* Global flag which indicates that we have tried reading
+ * PHYS_OFFSET from 'kcore' already.
+ */
+static bool try_read_phys_offset_from_kcore = false;
+
+/* Machine specific details. */
+static int va_bits;
+static unsigned long page_offset;
+
 /* Global varables the core kexec routines expect. */
 
 unsigned char reuse_initrd;
@@ -750,6 +766,126 @@ void add_segment(struct kexec_info *info, const void *buf, size_t bufsz,
 	add_segment_phys_virt(info, buf, bufsz, base, memsz, 1);
 }
 
+static inline void set_phys_offset(uint64_t v, char *set_method)
+{
+	if (arm64_mem.phys_offset == arm64_mem_ngv
+		|| v < arm64_mem.phys_offset) {
+		arm64_mem.phys_offset = v;
+		dbgprintf("%s: phys_offset : %016lx (method : %s)\n",
+				__func__, arm64_mem.phys_offset,
+				set_method);
+	}
+}
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
+	/* Derive va_bits as per arch/arm64/Kconfig */
+	if ((stext_sym_addr & PAGE_OFFSET_36) == PAGE_OFFSET_36) {
+		va_bits = 36;
+	} else if ((stext_sym_addr & PAGE_OFFSET_39) == PAGE_OFFSET_39) {
+		va_bits = 39;
+	} else if ((stext_sym_addr & PAGE_OFFSET_42) == PAGE_OFFSET_42) {
+		va_bits = 42;
+	} else if ((stext_sym_addr & PAGE_OFFSET_47) == PAGE_OFFSET_47) {
+		va_bits = 47;
+	} else if ((stext_sym_addr & PAGE_OFFSET_48) == PAGE_OFFSET_48) {
+		va_bits = 48;
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
+/**
+ * get_page_offset - Helper for getting PAGE_OFFSET
+ */
+
+static int get_page_offset(void)
+{
+	int ret;
+
+	ret = get_va_bits();
+	if (ret < 0)
+		return ret;
+
+	page_offset = (0xffffffffffffffffUL) << (va_bits - 1);
+	dbgprintf("page_offset : %lx\n", page_offset);
+
+	return 0;
+}
+
+/**
+ * get_phys_offset_from_vmcoreinfo_pt_note - Helper for getting PHYS_OFFSET
+ * from VMCOREINFO note inside 'kcore'.
+ */
+
+static int get_phys_offset_from_vmcoreinfo_pt_note(unsigned long *phys_offset)
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
+	unsigned long long phys_start;
+	unsigned long long virt_start;
+
+	ret = get_page_offset();
+	if (ret < 0)
+		return ret;
+
+	if ((fd = open("/proc/kcore", O_RDONLY)) < 0) {
+		fprintf(stderr, "Can't open (%s).\n", "/proc/kcore");
+		return EFAILED;
+	}
+
+	read_elf_kcore(fd);
+
+	for (i = 0; get_pt_load(i,
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
 /**
  * get_memory_ranges_iomem_cb - Helper for get_memory_ranges_iomem.
  */
@@ -757,11 +893,45 @@ void add_segment(struct kexec_info *info, const void *buf, size_t bufsz,
 static int get_memory_ranges_iomem_cb(void *data, int nr, char *str,
 	unsigned long long base, unsigned long long length)
 {
+	int ret;
+	unsigned long phys_offset = UINT64_MAX;
 	struct memory_range *r;
 
 	if (nr >= KEXEC_SEGMENT_MAX)
 		return -1;
 
+	if (!try_read_phys_offset_from_kcore) {
+		/* Since kernel version 4.19, 'kcore' contains
+		 * a new PT_NOTE which carries the VMCOREINFO
+		 * information.
+		 * If the same is available, one should prefer the
+		 * same to retrieve 'PHYS_OFFSET' value exported by
+		 * the kernel as this is now the standard interface
+		 * exposed by kernel for sharing machine specific
+		 * details with the userland.
+		 */
+		ret = get_phys_offset_from_vmcoreinfo_pt_note(&phys_offset);
+		if (!ret) {
+			if (phys_offset != UINT64_MAX)
+				set_phys_offset(phys_offset,
+						"vmcoreinfo pt_note");
+		} else {
+			/* If we are running on a older kernel,
+			 * try to retrieve the 'PHYS_OFFSET' value
+			 * exported by the kernel in the 'kcore'
+			 * file by reading the PT_LOADs and determining
+			 * the correct combination.
+			 */
+			ret = get_phys_base_from_pt_load(&phys_offset);
+			if (!ret)
+				if (phys_offset != UINT64_MAX)
+					set_phys_offset(phys_offset,
+							"pt_load");
+		}
+
+		try_read_phys_offset_from_kcore = true;
+	}
+
 	r = (struct memory_range *)data + nr;
 
 	if (!strncmp(str, SYSTEM_RAM, strlen(SYSTEM_RAM)))
@@ -774,7 +944,26 @@ static int get_memory_ranges_iomem_cb(void *data, int nr, char *str,
 	r->start = base;
 	r->end = base + length - 1;
 
-	set_phys_offset(r->start);
+	/* As a fallback option, we can try determining the PHYS_OFFSET
+	 * value from the '/proc/iomem' entries as well.
+	 *
+	 * But note that this can be flaky, as on certain arm64
+	 * platforms, it has been noticed that due to a hole at the
+	 * start of physical ram exposed to kernel
+	 * (i.e. it doesn't start from address 0), the kernel still
+	 * calculates the 'memstart_addr' kernel variable as 0.
+	 *
+	 * Whereas the SYSTEM_RAM or IOMEM_RESERVED range in
+	 * '/proc/iomem' would carry a first entry whose start address
+	 * is non-zero (as the physical ram exposed to the kernel
+	 * starts from a non-zero address).
+	 *
+	 * In such cases, if we rely on '/proc/iomem' entries to
+	 * calculate the phys_offset, then we will have mismatch
+	 * between the user-space and kernel space 'PHYS_OFFSET'
+	 * value.
+	 */
+	set_phys_offset(r->start, "iomem");
 
 	dbgprintf("%s: %016llx - %016llx : %s", __func__, r->start,
 		r->end, str);
@@ -783,7 +972,8 @@ static int get_memory_ranges_iomem_cb(void *data, int nr, char *str,
 }
 
 /**
- * get_memory_ranges_iomem - Try to get the memory ranges from /proc/iomem.
+ * get_memory_ranges_iomem - Try to get the memory ranges from
+ * /proc/iomem.
  */
 
 static int get_memory_ranges_iomem(struct memory_range *array,
diff --git a/kexec/arch/arm64/kexec-arm64.h b/kexec/arch/arm64/kexec-arm64.h
index 22e4b69d832c..cc3419f4c10f 100644
--- a/kexec/arch/arm64/kexec-arm64.h
+++ b/kexec/arch/arm64/kexec-arm64.h
@@ -21,6 +21,14 @@
 #define MiB(x) (KiB(x) * 1024UL)
 #define GiB(x) (MiB(x) * 1024UL)
 
+#define ULONGLONG_MAX	(~0ULL)
+
+/*
+ * Incorrect address
+ */
+#define NOT_KV_ADDR	(0x0)
+#define NOT_PADDR	(ULONGLONG_MAX)
+
 int elf_arm64_probe(const char *kernel_buf, off_t kernel_size);
 int elf_arm64_load(int argc, char **argv, const char *kernel_buf,
 	off_t kernel_size, struct kexec_info *info);
@@ -60,13 +68,6 @@ static inline void reset_vp_offset(void)
 	arm64_mem.vp_offset = arm64_mem_ngv;
 }
 
-static inline void set_phys_offset(uint64_t v)
-{
-	if (arm64_mem.phys_offset == arm64_mem_ngv
-		|| v < arm64_mem.phys_offset)
-		arm64_mem.phys_offset = v;
-}
-
 int arm64_process_image_header(const struct arm64_image_header *h);
 unsigned long arm64_locate_kernel_segment(struct kexec_info *info);
 int arm64_load_other_segments(struct kexec_info *info,
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
