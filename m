Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rv-out-0708.google.com ([209.85.198.243]
	helo=rv-out-0506.google.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JoRzI-0006vd-34
	for kexec@lists.infradead.org; Tue, 22 Apr 2008 23:33:24 +0000
Received: by rv-out-0506.google.com with SMTP id b17so1263444rvf.42
	for <kexec@lists.infradead.org>; Tue, 22 Apr 2008 16:33:23 -0700 (PDT)
From: Jamey Sharp <jamey@thetovacompany.com>
Subject: [PATCH 7/9] Replace weak definitions with source filename overriding.
Date: Tue, 22 Apr 2008 16:21:10 -0700
Message-Id: <1208906472-18465-8-git-send-email-jamey@thetovacompany.com>
In-Reply-To: <1208906472-18465-1-git-send-email-jamey@thetovacompany.com>
References: <1208906472-18465-1-git-send-email-jamey@thetovacompany.com>
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
To: kexec@lists.infradead.org

This reduces the kexec-tools' demands on the capabilities of the
toolchain, and improves standards conformance, without really changing
maintenance complexity.

Signed-off-by: Jamey Sharp <jamey@thetovacompany.com>
---
This is the patch I expect to be controversial, if any of these are. Of
course the reason I wrote it is because the PE file format, unlike ELF,
doesn't support weak symbols. But I also feel that weak symbols were the
wrong choice here. I believe that the result of this patch is code that
is easier to understand, due to being more self-documenting and using
tools that more developers are familiar with.

 kexec/Makefile            |   11 +++++++++++
 kexec/add_buffer.c        |   14 ++++++++++++++
 kexec/add_segment.c       |    8 ++++++++
 kexec/arch/ia64/Makefile  |    2 ++
 kexec/arch/mips/Makefile  |    4 ++++
 kexec/arch/ppc64/Makefile |    2 ++
 kexec/arch_reuse_initrd.c |    6 ++++++
 kexec/kexec-iomem.c       |   13 -------------
 kexec/kexec.c             |   31 -------------------------------
 kexec/kexec.h             |    2 ++
 kexec/proc_iomem.c        |   13 +++++++++++++
 kexec/virt_to_phys.c      |    7 +++++++
 12 files changed, 69 insertions(+), 44 deletions(-)
 create mode 100644 kexec/add_buffer.c
 create mode 100644 kexec/add_segment.c
 create mode 100644 kexec/arch_reuse_initrd.c
 create mode 100644 kexec/proc_iomem.c
 create mode 100644 kexec/virt_to_phys.c

diff --git a/kexec/Makefile b/kexec/Makefile
index cf6f043..98fed4c 100644
--- a/kexec/Makefile
+++ b/kexec/Makefile
@@ -29,6 +29,17 @@ dist += kexec/Makefile $(KEXEC_SRCS) $(KEXEC_GENERATED_SRCS)	\
 	kexec/kexec-elf.h kexec/kexec-sha256.h			\
 	kexec/kexec-syscall.h kexec/kexec.h kexec/kexec.8
 
+$(ARCH)_PROC_IOMEM		= kexec/proc_iomem.c
+KEXEC_SRCS += $($(ARCH)_PROC_IOMEM)
+$(ARCH)_VIRT_TO_PHYS		= kexec/virt_to_phys.c
+KEXEC_SRCS += $($(ARCH)_VIRT_TO_PHYS)
+$(ARCH)_ADD_SEGMENT		= kexec/add_segment.c
+KEXEC_SRCS += $($(ARCH)_ADD_SEGMENT)
+$(ARCH)_ADD_BUFFER		= kexec/add_buffer.c
+KEXEC_SRCS += $($(ARCH)_ADD_BUFFER)
+$(ARCH)_ARCH_REUSE_INITRD	= kexec/arch_reuse_initrd.c
+KEXEC_SRCS += $($(ARCH)_ARCH_REUSE_INITRD)
+
 include $(srcdir)/kexec/arch/alpha/Makefile
 include $(srcdir)/kexec/arch/arm/Makefile
 include $(srcdir)/kexec/arch/i386/Makefile
diff --git a/kexec/add_buffer.c b/kexec/add_buffer.c
new file mode 100644
index 0000000..4d4a55f
--- /dev/null
+++ b/kexec/add_buffer.c
@@ -0,0 +1,14 @@
+#include "kexec.h"
+
+unsigned long add_buffer(struct kexec_info *info,
+			 const void *buf,
+			 unsigned long bufsz,
+			 unsigned long memsz,
+			 unsigned long buf_align,
+			 unsigned long buf_min,
+			 unsigned long buf_max,
+			 int buf_end)
+{
+	return add_buffer_virt(info, buf, bufsz, memsz, buf_align,
+			       buf_min, buf_max, buf_end);
+}
diff --git a/kexec/add_segment.c b/kexec/add_segment.c
new file mode 100644
index 0000000..029c376
--- /dev/null
+++ b/kexec/add_segment.c
@@ -0,0 +1,8 @@
+#include "kexec.h"
+
+void add_segment(struct kexec_info *info,
+		 const void *buf, size_t bufsz,
+		 unsigned long base, size_t memsz)
+{
+	return add_segment_phys_virt(info, buf, bufsz, base, memsz, 0);
+}
diff --git a/kexec/arch/ia64/Makefile b/kexec/arch/ia64/Makefile
index f6b3789..f5b212b 100644
--- a/kexec/arch/ia64/Makefile
+++ b/kexec/arch/ia64/Makefile
@@ -7,6 +7,8 @@ ia64_KEXEC_SRCS += kexec/arch/ia64/kexec-elf-ia64.c
 ia64_KEXEC_SRCS += kexec/arch/ia64/kexec-elf-rel-ia64.c
 ia64_KEXEC_SRCS += kexec/arch/ia64/crashdump-ia64.c
 
+ia64_PROC_IOMEM =
+
 dist += kexec/arch/ia64/Makefile $(ia64_KEXEC_SRCS)			\
 	kexec/arch/ia64/kexec-ia64.h kexec/arch/ia64/crashdump-ia64.h	\
 	kexec/arch/ia64/include/arch/options.h
diff --git a/kexec/arch/mips/Makefile b/kexec/arch/mips/Makefile
index 8cba55e..f94bd89 100644
--- a/kexec/arch/mips/Makefile
+++ b/kexec/arch/mips/Makefile
@@ -6,6 +6,10 @@ mips_KEXEC_SRCS += kexec/arch/mips/kexec-elf-mips.c
 mips_KEXEC_SRCS += kexec/arch/mips/kexec-elf-rel-mips.c
 mips_KEXEC_SRCS += kexec/arch/mips/mips-setup-simple.S
 
+mips_ADD_BUFFER =
+mips_ADD_SEGMENT =
+mips_VIRT_TO_PHYS =
+
 dist += kexec/arch/mips/Makefile $(mips_KEXEC_SRCS)			\
 	kexec/arch/mips/kexec-mips.h					\
 	kexec/arch/mips/include/arch/options.h
diff --git a/kexec/arch/ppc64/Makefile b/kexec/arch/ppc64/Makefile
index 90250f6..7ed0aa9 100644
--- a/kexec/arch/ppc64/Makefile
+++ b/kexec/arch/ppc64/Makefile
@@ -8,6 +8,8 @@ ppc64_KEXEC_SRCS += kexec/arch/ppc64/kexec-elf-ppc64.c
 ppc64_KEXEC_SRCS += kexec/arch/ppc64/kexec-ppc64.c
 ppc64_KEXEC_SRCS += kexec/arch/ppc64/crashdump-ppc64.c
 
+ppc64_ARCH_REUSE_INITRD =
+
 dist += kexec/arch/ppc64/Makefile $(ppc64_KEXEC_SRCS)			\
 	kexec/arch/ppc64/kexec-ppc64.h kexec/arch/ppc64/crashdump-ppc64.h \
 	kexec/arch/ppc64/include/arch/options.h
diff --git a/kexec/arch_reuse_initrd.c b/kexec/arch_reuse_initrd.c
new file mode 100644
index 0000000..477a76d
--- /dev/null
+++ b/kexec/arch_reuse_initrd.c
@@ -0,0 +1,6 @@
+#include "kexec.h"
+
+void arch_reuse_initrd(void)
+{
+	die("--reuseinitrd not implemented on this architecture\n");
+}
diff --git a/kexec/kexec-iomem.c b/kexec/kexec-iomem.c
index 8e4abab..ddc9f13 100644
--- a/kexec/kexec-iomem.c
+++ b/kexec/kexec-iomem.c
@@ -101,16 +101,3 @@ int parse_iomem_single(char *str, uint64_t *start, uint64_t *end)
 
 	return ret;
 }
-
-static const char proc_iomem_str[]= "/proc/iomem";
-
-/*
- * Allow an architecture specific implementation of this
- * function to override the location of a file looking a lot
- * like /proc/iomem
- */
-const char * __attribute__((weak)) proc_iomem(void)
-{
-        return proc_iomem_str;
-}
-
diff --git a/kexec/kexec.c b/kexec/kexec.c
index 20b2ae4..2a71ace 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -285,11 +285,6 @@ unsigned long locate_hole(struct kexec_info *info,
 	return hole_base;
 }
 
-unsigned long __attribute__((weak)) virt_to_phys(unsigned long addr)
-{
-	abort();
-}
-
 void add_segment_phys_virt(struct kexec_info *info,
 	const void *buf, size_t bufsz,
 	unsigned long base, size_t memsz, int phys)
@@ -342,13 +337,6 @@ void add_segment_phys_virt(struct kexec_info *info,
 	}
 }
 
-void __attribute__((weak)) add_segment(struct kexec_info *info,
-				       const void *buf, size_t bufsz,
-				       unsigned long base, size_t memsz)
-{
-	return add_segment_phys_virt(info, buf, bufsz, base, memsz, 0);
-}
-
 unsigned long add_buffer_phys_virt(struct kexec_info *info,
 	const void *buf, unsigned long bufsz, unsigned long memsz,
 	unsigned long buf_align, unsigned long buf_min, unsigned long buf_max,
@@ -385,19 +373,6 @@ unsigned long add_buffer_virt(struct kexec_info *info, const void *buf,
 				    buf_min, buf_max, buf_end, 0);
 }
 
-unsigned long __attribute__((weak)) add_buffer(struct kexec_info *info,
-					       const void *buf,
-					       unsigned long bufsz,
-					       unsigned long memsz,
-					       unsigned long buf_align,
-					       unsigned long buf_min,
-					       unsigned long buf_max,
-					       int buf_end)
-{
-	return add_buffer_virt(info, buf, bufsz, memsz, buf_align,
-			       buf_min, buf_max, buf_end);
-}
-
 char *slurp_file(const char *filename, off_t *r_size)
 {
 	int fd;
@@ -836,12 +811,6 @@ void check_reuse_initrd(void)
 	fclose(fp);
 }
 
-/* Arch hook for reuse_initrd */
-void __attribute__((weak)) arch_reuse_initrd(void)
-{
-	die("--reuseinitrd not implemented on this architecture\n");
-}
-
 int main(int argc, char *argv[])
 {
 	int do_load = 1;
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 9649ec7..2d3a748 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -4,6 +4,7 @@
 #include "config.h"
 
 #include <sys/types.h>
+#include <stdio.h>
 #include <stdint.h>
 #define USE_BSD
 #include <byteswap.h>
@@ -206,6 +207,7 @@ extern unsigned long add_buffer_phys_virt(struct kexec_info *info,
 	const void *buf, unsigned long bufsz, unsigned long memsz,
 	unsigned long buf_align, unsigned long buf_min, unsigned long buf_max,
 	int buf_end, int phys);
+extern void arch_reuse_initrd(void);
 
 extern unsigned char purgatory[];
 extern size_t purgatory_size;
diff --git a/kexec/proc_iomem.c b/kexec/proc_iomem.c
new file mode 100644
index 0000000..85daa85
--- /dev/null
+++ b/kexec/proc_iomem.c
@@ -0,0 +1,13 @@
+#include "kexec.h"
+
+static const char proc_iomem_str[] = "/proc/iomem";
+
+/*
+ * Allow an architecture specific implementation of this
+ * function to override the location of a file looking a lot
+ * like /proc/iomem
+ */
+const char *proc_iomem(void)
+{
+        return proc_iomem_str;
+}
diff --git a/kexec/virt_to_phys.c b/kexec/virt_to_phys.c
new file mode 100644
index 0000000..51ac1df
--- /dev/null
+++ b/kexec/virt_to_phys.c
@@ -0,0 +1,7 @@
+#include "kexec.h"
+#include <stdlib.h>
+
+unsigned long virt_to_phys(unsigned long addr)
+{
+	abort();
+}
-- 
1.5.4.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
