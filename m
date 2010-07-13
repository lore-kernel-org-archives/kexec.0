From: Simon Horman <horms@verge.net.au>
Date: Tue, 13 Jul 2010 11:32:16 +0900
Subject: [PATCH] build: Include missing files in tarball
Message-ID: <mailman.72.1278989906.27306.kexec@lists.infradead.org>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 include/Makefile                      |    1 +
 kexec/arch/arm/Makefile               |    4 ++--
 kexec/arch/ppc/Makefile               |    5 ++++-
 kexec/arch/ppc/libfdt/Makefile.libfdt |    5 +++++
 kexec/arch/x86_64/Makefile            |    2 +-
 purgatory/arch/ppc64/Makefile         |    1 +
 6 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/Makefile b/include/Makefile
index 12c1030..c26b503 100644
--- a/include/Makefile
+++ b/include/Makefile
@@ -1,6 +1,7 @@
 dist += include/Makefile		\
 	include/config.h		\
 	include/config.h.in		\
+	include/kexec-uImage.h		\
 	include/x86/x86-linux.h		\
 	include/x86/mb_info.h		\
 	include/x86/mb_header.h		\
diff --git a/kexec/arch/arm/Makefile b/kexec/arch/arm/Makefile
index 7419621..3d07e59 100644
--- a/kexec/arch/arm/Makefile
+++ b/kexec/arch/arm/Makefile
@@ -10,6 +10,6 @@ arm_KEXEC_SRCS+= kexec/kexec-uImage.c
 
 arm_PHYS_TO_VIRT = kexec/arch/arm/phys_to_virt.c
 
-dist += kexec/arch/arm/Makefile $(arm_KEXEC_SRCS)			\
-	kexec/arch/arm/kexec-arm.h					\
+dist += kexec/arch/arm/Makefile $(arm_KEXEC_SRCS) $(arm_PHYS_TO_VIRT)	\
+	kexec/arch/arm/crashdump-arm.h kexec/arch/arm/kexec-arm.h	\
 	kexec/arch/arm/include/arch/options.h
diff --git a/kexec/arch/ppc/Makefile b/kexec/arch/ppc/Makefile
index 5988213..d4f04ec 100644
--- a/kexec/arch/ppc/Makefile
+++ b/kexec/arch/ppc/Makefile
@@ -23,5 +23,8 @@ CPPFLAGS+=-I$(srcdir)/kexec/arch/$(ARCH)/libfdt
 ppc_KEXEC_SRCS += $(libfdt_SRCS)
 
 dist += kexec/arch/ppc/Makefile $(ppc_KEXEC_SRCS)			\
-	kexec/arch/ppc/kexec-ppc.h kexec/arch/ppc/ppc_asm.h		\
+	kexec/arch/ppc/crashdump-powerpc.h kexec/arch/ppc/fixup_dtb.h	\
+	kexec/arch/ppc/kexec-ppc.h kexec/arch/ppc/ops.h			\
+	kexec/arch/ppc/ppc_asm.h					\
+	kexec/arch/ppc/include/page.h kexec/arch/ppc/include/types.h	\
 	kexec/arch/ppc/include/arch/options.h
diff --git a/kexec/arch/ppc/libfdt/Makefile.libfdt b/kexec/arch/ppc/libfdt/Makefile.libfdt
index 6c42acf..1d1b295 100644
--- a/kexec/arch/ppc/libfdt/Makefile.libfdt
+++ b/kexec/arch/ppc/libfdt/Makefile.libfdt
@@ -6,3 +6,8 @@
 LIBFDT_INCLUDES = fdt.h libfdt.h
 LIBFDT_SRCS = fdt.c fdt_ro.c fdt_wip.c fdt_sw.c fdt_rw.c fdt_strerror.c
 LIBFDT_OBJS = $(LIBFDT_SRCS:%.c=%.o)
+
+dist += kexec/arch/ppc/libfdt/Makefile.libfdt				\
+	kexec/arch/ppc/libfdt/fdt.h kexec/arch/ppc/libfdt/libfdt.h	\
+	kexec/arch/ppc/libfdt/libfdt_env.h				\
+	kexec/arch/ppc/libfdt/libfdt_internal.h
diff --git a/kexec/arch/x86_64/Makefile b/kexec/arch/x86_64/Makefile
index e6a8d35..0f35a46 100644
--- a/kexec/arch/x86_64/Makefile
+++ b/kexec/arch/x86_64/Makefile
@@ -15,6 +15,6 @@ x86_64_KEXEC_SRCS += kexec/arch/x86_64/kexec-elf-rel-x86_64.c
 
 x86_64_ARCH_INIT = kexec/arch/x86_64/arch_init.c
 
-dist += kexec/arch/x86_64/Makefile $(x86_64_KEXEC_SRCS)			\
+dist += kexec/arch/x86_64/Makefile $(x86_64_KEXEC_SRCS) $(x86_64_ARCH_INIT) \
 	kexec/arch/x86_64/kexec-x86_64.h kexec/arch/x86_64/crashdump-x86_64.h \
 	kexec/arch/x86_64/include/arch/options.h
diff --git a/purgatory/arch/ppc64/Makefile b/purgatory/arch/ppc64/Makefile
index 40a9e99..dc9c12e 100644
--- a/purgatory/arch/ppc64/Makefile
+++ b/purgatory/arch/ppc64/Makefile
@@ -13,4 +13,5 @@ ppc64_PURGATORY_EXTRA_ASFLAGS += -m64 -mcall-aixdesc
 ppc64_PURGATORY_EXTRA_LDFLAGS += -melf64ppc
 
 dist += purgatory/arch/ppc64/Makefile $(ppc64_PURGATORY_SRCS)		\
+	purgatory/arch/ppc64/hvCall.h					\
 	purgatory/arch/ppc64/purgatory-ppc64.h
-- 
1.7.1


