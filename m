Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JXCrJ-00079Y-26
	for kexec@lists.infradead.org; Thu, 06 Mar 2008 09:57:53 +0000
Message-Id: <20080306094759.186863437@vergenet.net>
References: <20080306094637.669665743@vergenet.net>
Date: Thu, 06 Mar 2008 18:46:42 +0900
From: Simon Horman <horms@verge.net.au>
Subject: [patch 05/12] kexec-tools: mipsel: Remove #ifdef __MIPSEL__ from
	kexec/kexec.c
Content-Disposition: inline; filename=mips-no-add_segment_virt.patch
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, linux-mips@linux-mips.org, Tomasz Chmielewski <mangoo@wpkg.org>
Cc: Francesco Chiechi <francesco.chiechi@colibre.it>

On all architectures except mipsel add_buffer() expects
add_segment() to work with the virtual address passed.
On mipsel it is expected that add_segment() converts
the virtual address to a physical address first.
add_buffer_virt() is porvided on mipsel for the handful
of cases that don't want the address to be converted.

This patch maintains that behaviour, but without the need for #ifdef
__MIPSEL__ from kexec/kexec.c and much duplicated code.

Signed-off-by: Simon Horman <horms@verge.net.au>

---

 kexec/arch/mipsel/kexec-mipsel.c |   26 +++++++
 kexec/kexec.c                    |  137 +++++++++-----------------------------
 kexec/kexec.h                    |    9 ++
 3 files changed, 71 insertions(+), 101 deletions(-)

Index: kexec-tools-testing-mips/kexec/arch/mipsel/kexec-mipsel.c
===================================================================
--- kexec-tools-testing-mips.orig/kexec/arch/mipsel/kexec-mipsel.c	2008-03-06 18:39:25.000000000 +0900
+++ kexec-tools-testing-mips/kexec/arch/mipsel/kexec-mipsel.c	2008-03-06 18:44:54.000000000 +0900
@@ -165,3 +165,29 @@ int is_crashkernel_mem_reserved(void)
 	return 1;
 }
 
+unsigned long virt_to_phys(unsigned long addr)
+{
+	return addr - 0x80000000;
+}
+
+/*
+ * add_segment() should convert base to a physical address on mipsel,
+ * while the default is just to work with base as is */
+void add_segment(struct kexec_info *info, const void *buf, size_t bufsz,
+		 unsigned long base, size_t memsz)
+{
+	add_segment_phys_virt(info, buf, bufsz, base, memsz, 1);
+}
+
+/*
+ * add_buffer() should convert base to a physical address on mipsel,
+ * while the default is just to work with base as is */
+unsigned long add_buffer(struct kexec_info *info, const void *buf,
+			 unsigned long bufsz, unsigned long memsz,
+			 unsigned long buf_align, unsigned long buf_min,
+			 unsigned long buf_max, int buf_end)
+{
+	return add_buffer_phys_virt(info, buf, bufsz, memsz, buf_align,
+				    buf_min, buf_max, buf_end, 1);
+}
+
Index: kexec-tools-testing-mips/kexec/kexec.c
===================================================================
--- kexec-tools-testing-mips.orig/kexec/kexec.c	2008-03-06 18:39:25.000000000 +0900
+++ kexec-tools-testing-mips/kexec/kexec.c	2008-03-06 18:39:34.000000000 +0900
@@ -44,10 +44,6 @@
 #include "kexec-sha256.h"
 #include <arch/options.h>
 
-#ifdef __MIPSEL__
-#define virt_to_phys(X) ((X) - 0x80000000)
-#endif
-
 unsigned long long mem_min = 0;
 unsigned long long mem_max = ULONG_MAX;
 
@@ -289,16 +285,18 @@ unsigned long locate_hole(struct kexec_i
 	return hole_base;
 }
 
-void add_segment(struct kexec_info *info,
+unsigned long __attribute__((weak)) virt_to_phys(unsigned long addr)
+{
+	abort();
+}
+
+void add_segment_phys_virt(struct kexec_info *info,
 	const void *buf, size_t bufsz,
-	unsigned long base, size_t memsz)
+	unsigned long base, size_t memsz, int phys)
 {
 	unsigned long last;
 	size_t size;
 	int pagesize;
-#ifdef __MIPSEL__
-	unsigned long base_phys;
-#endif
 
 	if (bufsz > memsz) {
 		bufsz = memsz;
@@ -312,9 +310,6 @@ void add_segment(struct kexec_info *info
 	pagesize = getpagesize();
 	memsz = (memsz + (pagesize - 1)) & ~(pagesize - 1);
 
-#ifdef __MIPSEL__
-	base_phys=virt_to_phys(base);
-#endif
 	/* Verify base is pagesize aligned.
 	 * Finding a way to cope with this problem
 	 * is important but for now error so at least
@@ -325,29 +320,20 @@ void add_segment(struct kexec_info *info
 		die("Base address: %x is not page aligned\n", base);
 	}
 
-#ifdef __MIPSEL__
-	last = base_phys + memsz -1;
-	if (!valid_memory_range(info, base_phys, last)) {
-		die("Invalid memory segment %p - %p\n",
-			(void *)base_phys, (void *)last);
-	}
-#else
+	if (phys)
+		base = virt_to_phys(base);
+
 	last = base + memsz -1;
 	if (!valid_memory_range(info, base, last)) {
 		die("Invalid memory segment %p - %p\n",
 			(void *)base, (void *)last);
 	}
-#endif
 
 	size = (info->nr_segments + 1) * sizeof(info->segment[0]);
 	info->segment = xrealloc(info->segment, size);
 	info->segment[info->nr_segments].buf   = buf;
 	info->segment[info->nr_segments].bufsz = bufsz;
-#ifdef __MIPSEL__
-	info->segment[info->nr_segments].mem   = (void *)base_phys;
-#else
 	info->segment[info->nr_segments].mem   = (void *)base;
-#endif
 	info->segment[info->nr_segments].memsz = memsz;
 	info->nr_segments++;
 	if (info->nr_segments > KEXEC_MAX_SEGMENTS) {
@@ -356,61 +342,17 @@ void add_segment(struct kexec_info *info
 	}
 }
 
-#ifdef __MIPSEL__
-void add_segment_virt(struct kexec_info *info,
-	const void *buf, size_t bufsz,
-	unsigned long base, size_t memsz)
+void __attribute__((weak)) add_segment(struct kexec_info *info,
+				       const void *buf, size_t bufsz,
+				       unsigned long base, size_t memsz)
 {
-	unsigned long last;
-	size_t size;
-	int pagesize;
-
-	if (bufsz > memsz) {
-		bufsz = memsz;
-	}
-	/* Forget empty segments */
-	if (memsz == 0) {
-		return;
-	}
-
-	/* Round memsz up to a multiple of pagesize */
-	pagesize = getpagesize();
-	memsz = (memsz + (pagesize - 1)) & ~(pagesize - 1);
-
-	/* Verify base is pagesize aligned.
-	 * Finding a way to cope with this problem
-	 * is important but for now error so at least
-	 * we are not surprised by the code doing the wrong
-	 * thing.
-	 */
-	if (base & (pagesize -1)) {
-		die("Base address: %x is not page aligned\n", base);
-	}
-	
-	last = base + memsz -1;
-	if (!valid_memory_range(info, base, last)) {
-		die("Invalid memory segment %p - %p\n",
-			(void *)base, (void *)last);
-	}
-	
-	size = (info->nr_segments + 1) * sizeof(info->segment[0]);
-	info->segment = xrealloc(info->segment, size);
-	info->segment[info->nr_segments].buf   = buf;
-	info->segment[info->nr_segments].bufsz = bufsz;
-	info->segment[info->nr_segments].mem   = (void *)base;
-	info->segment[info->nr_segments].memsz = memsz;
-	info->nr_segments++;
-	if (info->nr_segments > KEXEC_MAX_SEGMENTS) {
-		fprintf(stderr, "Warning: kernel segment limit reached. "
-			"This will likely fail\n");
-	}
+	return add_segment_phys_virt(info, buf, bufsz, base, memsz, 0);
 }
-#endif
 
-unsigned long add_buffer(struct kexec_info *info,
+unsigned long add_buffer_phys_virt(struct kexec_info *info,
 	const void *buf, unsigned long bufsz, unsigned long memsz,
 	unsigned long buf_align, unsigned long buf_min, unsigned long buf_max,
-	int buf_end)
+	int buf_end, int phys)
 {
 	unsigned long base;
 	int result;
@@ -430,38 +372,31 @@ unsigned long add_buffer(struct kexec_in
 		die("locate_hole failed\n");
 	}
 	
-	add_segment(info, buf, bufsz, base, memsz);
+	add_segment_phys_virt(info, buf, bufsz, base, memsz, phys);
 	return base;
 }
 
-#ifdef __MIPSEL__
-unsigned long add_buffer_virt(struct kexec_info *info,
-	const void *buf, unsigned long bufsz, unsigned long memsz,
-	unsigned long buf_align, unsigned long buf_min, unsigned long buf_max,
-	int buf_end)
+unsigned long add_buffer_virt(struct kexec_info *info, const void *buf,
+			      unsigned long bufsz, unsigned long memsz,
+			      unsigned long buf_align, unsigned long buf_min,
+			      unsigned long buf_max, int buf_end)
+{
+	return add_buffer_phys_virt(info, buf, bufsz, memsz, buf_align,
+				    buf_min, buf_max, buf_end, 0);
+}
+
+unsigned long __attribute__((weak)) add_buffer(struct kexec_info *info,
+					       const void *buf,
+					       unsigned long bufsz,
+					       unsigned long memsz,
+					       unsigned long buf_align,
+					       unsigned long buf_min,
+					       unsigned long buf_max,
+					       int buf_end)
 {
-	unsigned long base;
-	int result;
-	int pagesize;
-
-	result = sort_segments(info);
-	if (result < 0) {
-		die("sort_segments failed\n");
-	}
-
-	/* Round memsz up to a multiple of pagesize */
-	pagesize = getpagesize();
-	memsz = (memsz + (pagesize - 1)) & ~(pagesize - 1);
-
-	base = locate_hole(info, memsz, buf_align, buf_min, buf_max, buf_end);
-	if (base == ULONG_MAX) {
-		die("locate_hole failed\n");
-	}
-
-	add_segment_virt(info, buf, bufsz, base, memsz);
-	return base;
+	return add_buffer_virt(info, buf, bufsz, memsz, buf_align,
+			       buf_min, buf_max, buf_end);
 }
-#endif
 
 char *slurp_file(const char *filename, off_t *r_size)
 {
Index: kexec-tools-testing-mips/kexec/kexec.h
===================================================================
--- kexec-tools-testing-mips.orig/kexec/kexec.h	2008-03-06 18:39:25.000000000 +0900
+++ kexec-tools-testing-mips/kexec/kexec.h	2008-03-06 18:45:53.000000000 +0900
@@ -188,12 +188,24 @@ extern void *xrealloc(void *ptr, size_t 
 extern char *slurp_file(const char *filename, off_t *r_size);
 extern char *slurp_file_len(const char *filename, off_t size);
 extern char *slurp_decompress_file(const char *filename, off_t *r_size);
+extern unsigned long virt_to_phys(unsigned long addr);
 extern void add_segment(struct kexec_info *info,
 	const void *buf, size_t bufsz, unsigned long base, size_t memsz);
+extern void add_segment_phys_virt(struct kexec_info *info,
+	const void *buf, size_t bufsz, unsigned long base, size_t memsz,
+	int phys);
 extern unsigned long add_buffer(struct kexec_info *info,
 	const void *buf, unsigned long bufsz, unsigned long memsz,
 	unsigned long buf_align, unsigned long buf_min, unsigned long buf_max,
 	int buf_end);
+extern unsigned long add_buffer_virt(struct kexec_info *info,
+	const void *buf, unsigned long bufsz, unsigned long memsz,
+	unsigned long buf_align, unsigned long buf_min, unsigned long buf_max,
+	int buf_end);
+extern unsigned long add_buffer_phys_virt(struct kexec_info *info,
+	const void *buf, unsigned long bufsz, unsigned long memsz,
+	unsigned long buf_align, unsigned long buf_min, unsigned long buf_max,
+	int buf_end, int phys);
 
 extern unsigned char purgatory[];
 extern size_t purgatory_size;

-- 

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
