Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UMcuF-0008CI-TB
 for kexec@lists.infradead.org; Mon, 01 Apr 2013 11:28:13 +0000
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/2 v2] [RFC] get rid of dist
Date: Mon,  1 Apr 2013 13:28:01 +0200
Message-Id: <1364815681-28732-1-git-send-email-richard@nod.at>
In-Reply-To: <1364815385-26722-1-git-send-email-richard@nod.at>
References: <1364815385-26722-1-git-send-email-richard@nod.at>
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
Cc: Richard Weinberger <richard@nod.at>, horms@verge.net.au, zhangyanfei@cn.fujitsu.com

Replace the dist variable by git ls-files.
The following files are now included in the dist tarball too:

bootstrap
doc/mpc85xx.txt
.gitignore
kexec/.gitignore
kexec/libfdt/TODO

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 Makefile.in                    |  8 +++-----
 doc/Makefile                   |  5 -----
 include/Makefile               | 13 -------------
 kdump/Makefile                 |  1 -
 kexec/Makefile                 | 16 ----------------
 kexec/arch/alpha/Makefile      |  3 ---
 kexec/arch/arm/Makefile        |  4 ----
 kexec/arch/cris/Makefile       |  5 -----
 kexec/arch/i386/Makefile       |  5 -----
 kexec/arch/ia64/Makefile       |  6 ------
 kexec/arch/mips/Makefile       |  5 -----
 kexec/arch/ppc/Makefile        |  7 -------
 kexec/arch/ppc64/Makefile      |  5 -----
 kexec/arch/s390/Makefile       |  4 ----
 kexec/arch/sh/Makefile         |  5 -----
 kexec/arch/x86_64/Makefile     |  5 -----
 kexec/libfdt/Makefile.libfdt   |  5 -----
 kexec_test/Makefile            |  3 ---
 purgatory/Makefile             |  3 ---
 purgatory/arch/alpha/Makefile  |  3 ---
 purgatory/arch/arm/Makefile    |  4 ----
 purgatory/arch/i386/Makefile   |  6 ------
 purgatory/arch/ia64/Makefile   |  4 ----
 purgatory/arch/mips/Makefile   |  4 ----
 purgatory/arch/ppc/Makefile    |  4 ----
 purgatory/arch/ppc64/Makefile  |  4 ----
 purgatory/arch/s390/Makefile   |  3 ---
 purgatory/arch/sh/Makefile     |  3 ---
 purgatory/arch/x86_64/Makefile |  5 -----
 util/Makefile                  |  1 -
 util_lib/Makefile              |  2 --
 vmcore-dmesg/Makefile          |  1 -
 32 files changed, 3 insertions(+), 149 deletions(-)

diff --git a/Makefile.in b/Makefile.in
index c1859d1..ae1dd2c 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -119,9 +119,6 @@ all: targets
 # collect objects to be removed in 'make clean'
 clean =
 
-dist =	AUTHORS COPYING INSTALL News TODO Makefile.in configure.ac configure \
-	kexec-tools.spec.in config/
-
 # utility function for converting a list of files (with extension) to
 # file.o (or file.d) format.
 objify = $(addsuffix .o, $(basename $(1)))
@@ -172,7 +169,8 @@ SPEC=$(PACKAGE_NAME).spec
 GENERATED_SRCS:= $(SPEC)
 TARBALL=$(PACKAGE_NAME)-$(PACKAGE_VERSION).tar
 TARBALL.gz=$(TARBALL).gz
-SRCS:= $(dist)
+SRCS:= $(shell git ls-files) configure include/config.h include/config.h.in \
+	kexec/purgatory.c kexec-tools.spec
 PSRCS:=$(foreach s, $(SRCS), $(PACKAGE_NAME)-$(PACKAGE_VERSION)/$(s))
 PGSRCS:=$(foreach s, $(GENERATED_SRCS), $(PACKAGE_NAME)-$(PACKAGE_VERSION)/$(s))
 
@@ -201,7 +199,7 @@ $(TARBALL): $(SRCS) $(GENERATED_SRCS)
 	$(LN) -sf . $(PACKAGE_NAME)-$(PACKAGE_VERSION)
 	$(TAR) -rf $@ $(PGSRCS)
 	$(RM) -f $(PACKAGE_NAME)-$(PACKAGE_VERSION)
-	@echo $(dist)
+	@echo $(SRCS)
 
 $(TARBALL.gz): $(TARBALL)
 	gzip -c < $^ > $@
diff --git a/doc/Makefile b/doc/Makefile
index 3442e09..e69de29 100644
--- a/doc/Makefile
+++ b/doc/Makefile
@@ -1,5 +0,0 @@
-dist += doc/Makefile			\
-	doc/linux-i386-boot.txt		\
-	doc/linux-i386-zero-page.txt	\
-	doc/multiboot.html		\
-	doc/nbi-spec.txt
diff --git a/include/Makefile b/include/Makefile
index c26b503..e69de29 100644
--- a/include/Makefile
+++ b/include/Makefile
@@ -1,13 +0,0 @@
-dist += include/Makefile		\
-	include/config.h		\
-	include/config.h.in		\
-	include/kexec-uImage.h		\
-	include/x86/x86-linux.h		\
-	include/x86/mb_info.h		\
-	include/x86/mb_header.h		\
-	include/elf.h			\
-	include/image.h			\
-	include/unused.h		\
-	include/boot/linuxbios_tables.h	\
-	include/boot/beoboot.h		\
-	include/boot/elf_boot.h
diff --git a/kdump/Makefile b/kdump/Makefile
index 307d59d..1ad36b2 100644
--- a/kdump/Makefile
+++ b/kdump/Makefile
@@ -10,7 +10,6 @@ KDUMP_DEPS = $(call depify, $(KDUMP_OBJS))
 KDUMP = $(SBINDIR)/kdump
 KDUMP_MANPAGE = $(MANDIR)/man8/kdump.8
 
-dist += kdump/Makefile $(KDUMP_SRCS) kdump/kdump.8
 clean += $(KDUMP_OBJS) $(KDUMP_DEPS) $(KDUMP) $(KDUMP_MANPAGE)
 
 -include $(KDUMP_DEPS)
diff --git a/kexec/Makefile b/kexec/Makefile
index 8a6138d..dced4eb 100644
--- a/kexec/Makefile
+++ b/kexec/Makefile
@@ -28,43 +28,27 @@ KEXEC_SRCS_base += kexec/zlib.c
 
 KEXEC_GENERATED_SRCS += $(PURGATORY_HEX_C)
 
-dist += kexec/Makefile $(KEXEC_GENERATED_SRCS)			\
-	$(KEXEC_SRCS_base) kexec/crashdump-elf.c		\
-	kexec/crashdump.h kexec/firmware_memmap.h		\
-	kexec/kexec-elf-boot.h					\
-	kexec/kexec-elf.h kexec/kexec-sha256.h			\
-	kexec/kexec-zlib.h kexec/kexec-lzma.h			\
-	kexec/kexec-syscall.h kexec/kexec.h kexec/kexec.8
-
-dist				+= kexec/proc_iomem.c
 $(ARCH)_PROC_IOMEM		=  kexec/proc_iomem.c
 KEXEC_SRCS			+= $($(ARCH)_PROC_IOMEM)
 
-dist				+= kexec/virt_to_phys.c
 $(ARCH)_VIRT_TO_PHYS		=  kexec/virt_to_phys.c
 KEXEC_SRCS			+= $($(ARCH)_VIRT_TO_PHYS)
 
-dist				+= kexec/phys_to_virt.c
 $(ARCH)_PHYS_TO_VIRT		=  kexec/phys_to_virt.c
 KEXEC_SRCS			+= $($(ARCH)_PHYS_TO_VIRT)
 
-dist				+= kexec/add_segment.c
 $(ARCH)_ADD_SEGMENT		=  kexec/add_segment.c
 KEXEC_SRCS			+= $($(ARCH)_ADD_SEGMENT)
 
-dist				+= kexec/add_buffer.c
 $(ARCH)_ADD_BUFFER		=  kexec/add_buffer.c
 KEXEC_SRCS			+= $($(ARCH)_ADD_BUFFER)
 
-dist				+=  kexec/arch_reuse_initrd.c
 $(ARCH)_ARCH_REUSE_INITRD	=  kexec/arch_reuse_initrd.c
 KEXEC_SRCS			+= $($(ARCH)_ARCH_REUSE_INITRD)
 
-dist				+= kexec/kexec-uImage.c
 $(ARCH)_UIMAGE			=
 KEXEC_SRCS			+= $($(ARCH)_UIMAGE)
 
-dist				+= kexec/fs2dt.c kexec/fs2dt.h
 $(ARCH)_FS2DT			=
 KEXEC_SRCS			+= $($(ARCH)_FS2DT)
 
diff --git a/kexec/arch/alpha/Makefile b/kexec/arch/alpha/Makefile
index 4575d61..7b1642d 100644
--- a/kexec/arch/alpha/Makefile
+++ b/kexec/arch/alpha/Makefile
@@ -1,4 +1 @@
 alpha_KEXEC_SRCS=
-dist += kexec/arch/alpha/Makefile kexec/arch/alpha/include/arch/options.h
-        $(alpha_KEXEC_SRCS)
-
diff --git a/kexec/arch/arm/Makefile b/kexec/arch/arm/Makefile
index 682db78..d5efc05 100644
--- a/kexec/arch/arm/Makefile
+++ b/kexec/arch/arm/Makefile
@@ -22,7 +22,3 @@ arm_KEXEC_SRCS += $(libfdt_SRCS)
 
 arm_UIMAGE = kexec/kexec-uImage.c
 arm_PHYS_TO_VIRT = kexec/arch/arm/phys_to_virt.c
-
-dist += kexec/arch/arm/Makefile $(arm_KEXEC_SRCS) $(arm_PHYS_TO_VIRT)	\
-	kexec/arch/arm/crashdump-arm.h kexec/arch/arm/kexec-arm.h	\
-	kexec/arch/arm/include/arch/options.h
diff --git a/kexec/arch/cris/Makefile b/kexec/arch/cris/Makefile
index 4982f3e..1e48645 100644
--- a/kexec/arch/cris/Makefile
+++ b/kexec/arch/cris/Makefile
@@ -6,8 +6,3 @@ cris_KEXEC_SRCS += kexec/arch/cris/kexec-elf-rel-cris.c
 cris_ADD_BUFFER =
 cris_ADD_SEGMENT =
 cris_VIRT_TO_PHYS =
-
-dist += kexec/arch/cris/Makefile $(cris_KEXEC_SRCS)			\
-	kexec/arch/cris/kexec-cris.h					\
-	kexec/arch/cris/include/arch/options.h
-
diff --git a/kexec/arch/i386/Makefile b/kexec/arch/i386/Makefile
index d52a2f5..19ba745 100644
--- a/kexec/arch/i386/Makefile
+++ b/kexec/arch/i386/Makefile
@@ -11,8 +11,3 @@ i386_KEXEC_SRCS += kexec/arch/i386/kexec-beoboot-x86.c
 i386_KEXEC_SRCS += kexec/arch/i386/kexec-nbi.c
 i386_KEXEC_SRCS += kexec/arch/i386/x86-linux-setup.c
 i386_KEXEC_SRCS += kexec/arch/i386/crashdump-x86.c
-
-dist += kexec/arch/i386/Makefile $(i386_KEXEC_SRCS)			\
-	kexec/arch/i386/kexec-x86.h kexec/arch/i386/crashdump-x86.h	\
-	kexec/arch/i386/x86-linux-setup.h				\
-	kexec/arch/i386/include/arch/options.h
diff --git a/kexec/arch/ia64/Makefile b/kexec/arch/ia64/Makefile
index f5b212b..44addfd 100644
--- a/kexec/arch/ia64/Makefile
+++ b/kexec/arch/ia64/Makefile
@@ -8,9 +8,3 @@ ia64_KEXEC_SRCS += kexec/arch/ia64/kexec-elf-rel-ia64.c
 ia64_KEXEC_SRCS += kexec/arch/ia64/crashdump-ia64.c
 
 ia64_PROC_IOMEM =
-
-dist += kexec/arch/ia64/Makefile $(ia64_KEXEC_SRCS)			\
-	kexec/arch/ia64/kexec-ia64.h kexec/arch/ia64/crashdump-ia64.h	\
-	kexec/arch/ia64/include/arch/options.h
-
-
diff --git a/kexec/arch/mips/Makefile b/kexec/arch/mips/Makefile
index 03bdb9a..05ce920 100644
--- a/kexec/arch/mips/Makefile
+++ b/kexec/arch/mips/Makefile
@@ -9,8 +9,3 @@ mips_KEXEC_SRCS += kexec/arch/mips/crashdump-mips.c
 mips_ADD_BUFFER =
 mips_ADD_SEGMENT =
 mips_VIRT_TO_PHYS =
-
-dist += kexec/arch/mips/Makefile $(mips_KEXEC_SRCS)			\
-	kexec/arch/mips/kexec-mips.h					\
-	kexec/arch/mips/crashdump-mips.h				\
-	kexec/arch/mips/include/arch/options.h
diff --git a/kexec/arch/ppc/Makefile b/kexec/arch/ppc/Makefile
index 71871f1..4a6628d 100644
--- a/kexec/arch/ppc/Makefile
+++ b/kexec/arch/ppc/Makefile
@@ -25,10 +25,3 @@ ppc_CPPFLAGS = -I$(srcdir)/kexec/libfdt
 ppc_KEXEC_SRCS += $(libfdt_SRCS) $(ppc_libfdt_SRCS)
 
 ppc_ASFLAGS = -Wa,--noexecstack
-
-dist += kexec/arch/ppc/Makefile $(ppc_KEXEC_SRCS)			\
-	kexec/arch/ppc/crashdump-powerpc.h kexec/arch/ppc/fixup_dtb.h	\
-	kexec/arch/ppc/kexec-ppc.h kexec/arch/ppc/ops.h			\
-	kexec/arch/ppc/ppc_asm.h					\
-	kexec/arch/ppc/include/page.h kexec/arch/ppc/include/types.h	\
-	kexec/arch/ppc/include/arch/options.h
diff --git a/kexec/arch/ppc64/Makefile b/kexec/arch/ppc64/Makefile
index 7ed0aa9..883a684 100644
--- a/kexec/arch/ppc64/Makefile
+++ b/kexec/arch/ppc64/Makefile
@@ -9,8 +9,3 @@ ppc64_KEXEC_SRCS += kexec/arch/ppc64/kexec-ppc64.c
 ppc64_KEXEC_SRCS += kexec/arch/ppc64/crashdump-ppc64.c
 
 ppc64_ARCH_REUSE_INITRD =
-
-dist += kexec/arch/ppc64/Makefile $(ppc64_KEXEC_SRCS)			\
-	kexec/arch/ppc64/kexec-ppc64.h kexec/arch/ppc64/crashdump-ppc64.h \
-	kexec/arch/ppc64/include/arch/options.h
-
diff --git a/kexec/arch/s390/Makefile b/kexec/arch/s390/Makefile
index fab3e68..6d02a31 100644
--- a/kexec/arch/s390/Makefile
+++ b/kexec/arch/s390/Makefile
@@ -5,7 +5,3 @@ s390_KEXEC_SRCS =  kexec/arch/s390/kexec-s390.c
 s390_KEXEC_SRCS += kexec/arch/s390/kexec-image.c
 s390_KEXEC_SRCS += kexec/arch/s390/kexec-elf-rel-s390.c
 s390_KEXEC_SRCS += kexec/arch/s390/crashdump-s390.c
-
-dist += kexec/arch/s390/Makefile $(s390_KEXEC_SRCS)			\
-	kexec/arch/s390/kexec-s390.h					\
-	kexec/arch/s390/include/arch/options.h
diff --git a/kexec/arch/sh/Makefile b/kexec/arch/sh/Makefile
index 7cf40ae..dfd308a 100644
--- a/kexec/arch/sh/Makefile
+++ b/kexec/arch/sh/Makefile
@@ -15,8 +15,3 @@ sh_UIMAGE = kexec/kexec-uImage.c
 sh_ADD_BUFFER =
 sh_ADD_SEGMENT =
 sh_VIRT_TO_PHYS =
-
-dist += kexec/arch/sh/Makefile $(sh_KEXEC_SRCS)				\
-	kexec/arch/sh/kexec-sh.h					\
-	kexec/arch/sh/crashdump-sh.h					\
-	kexec/arch/sh/include/arch/options.h
diff --git a/kexec/arch/x86_64/Makefile b/kexec/arch/x86_64/Makefile
index 1cf10f9..913426d 100644
--- a/kexec/arch/x86_64/Makefile
+++ b/kexec/arch/x86_64/Makefile
@@ -16,8 +16,3 @@ x86_64_KEXEC_SRCS_native += kexec/arch/x86_64/kexec-elf-rel-x86_64.c
 x86_64_KEXEC_SRCS_native += kexec/arch/x86_64/kexec-bzImage64.c
 
 x86_64_KEXEC_SRCS += $(x86_64_KEXEC_SRCS_native)
-
-# Don't add sources in i386/ to dist, as i386/Makefile adds them
-dist += kexec/arch/x86_64/Makefile $(x86_64_KEXEC_SRCS_native) \
-	kexec/arch/x86_64/kexec-x86_64.h \
-	kexec/arch/x86_64/include/arch/options.h
diff --git a/kexec/libfdt/Makefile.libfdt b/kexec/libfdt/Makefile.libfdt
index 9a2b4f7..6c42acf 100644
--- a/kexec/libfdt/Makefile.libfdt
+++ b/kexec/libfdt/Makefile.libfdt
@@ -6,8 +6,3 @@
 LIBFDT_INCLUDES = fdt.h libfdt.h
 LIBFDT_SRCS = fdt.c fdt_ro.c fdt_wip.c fdt_sw.c fdt_rw.c fdt_strerror.c
 LIBFDT_OBJS = $(LIBFDT_SRCS:%.c=%.o)
-
-dist += kexec/libfdt/Makefile.libfdt			\
-	kexec/libfdt/fdt.h kexec/libfdt/libfdt.h	\
-	kexec/libfdt/libfdt_env.h			\
-	kexec/libfdt/libfdt_internal.h
diff --git a/kexec_test/Makefile b/kexec_test/Makefile
index fec6210..38fb1b6 100644
--- a/kexec_test/Makefile
+++ b/kexec_test/Makefile
@@ -4,9 +4,6 @@
 RELOC:=0x10000
 KEXEC_TEST_SRCS:= kexec_test/kexec_test16.S kexec_test/kexec_test.S
 
-dist += kexec_test/Makefile $(KEXEC_TEST_SRCS)				\
-	kexec_test/x86-setup-legacy-pic.S
-
 BUILD_KEXEC_TEST = no
 ifeq ($(ARCH),i386)
 BUILD_KEXEC_TEST = yes
diff --git a/purgatory/Makefile b/purgatory/Makefile
index e39adec..730392c 100644
--- a/purgatory/Makefile
+++ b/purgatory/Makefile
@@ -13,9 +13,6 @@ PURGATORY_SRCS += purgatory/purgatory.c
 PURGATORY_SRCS += purgatory/printf.c
 PURGATORY_SRCS += purgatory/string.c
 
-dist += purgatory/Makefile $(PURGATORY_SRCS)				\
-	purgatory/include/purgatory.h purgatory/include/string.h
-
 include $(srcdir)/purgatory/arch/alpha/Makefile
 include $(srcdir)/purgatory/arch/arm/Makefile
 include $(srcdir)/purgatory/arch/i386/Makefile
diff --git a/purgatory/arch/alpha/Makefile b/purgatory/arch/alpha/Makefile
index c58693f..fb014d3 100644
--- a/purgatory/arch/alpha/Makefile
+++ b/purgatory/arch/alpha/Makefile
@@ -3,6 +3,3 @@
 #
 
 alpha_PURGATORY_SRCS =
-
-dist += purgatory/arch/alpha/Makefile $(alpha_PURGATORY_SRCS)
-
diff --git a/purgatory/arch/arm/Makefile b/purgatory/arch/arm/Makefile
index 690377e..5d12a3c 100644
--- a/purgatory/arch/arm/Makefile
+++ b/purgatory/arch/arm/Makefile
@@ -3,7 +3,3 @@
 #
 
 arm_PURGATORY_SRCS =
-
-dist += purgatory/arch/arm/Makefile $(arm_PURGATORY_SRCS)
-
-
diff --git a/purgatory/arch/i386/Makefile b/purgatory/arch/i386/Makefile
index 1532219..9a35485 100644
--- a/purgatory/arch/i386/Makefile
+++ b/purgatory/arch/i386/Makefile
@@ -13,9 +13,3 @@ i386_PURGATORY_SRCS += purgatory/arch/i386/console-x86.c
 i386_PURGATORY_SRCS += purgatory/arch/i386/vga.c
 i386_PURGATORY_SRCS += purgatory/arch/i386/pic.c
 i386_PURGATORY_SRCS += purgatory/arch/i386/crashdump_backup.c
-
-dist += purgatory/arch/i386/Makefile $(i386_PURGATORY_SRCS)	\
-	purgatory/arch/i386/purgatory-x86.h			\
-	purgatory/arch/i386/include/arch/io.h			\
-	purgatory/arch/i386/include/arch/debug.h
-
diff --git a/purgatory/arch/ia64/Makefile b/purgatory/arch/ia64/Makefile
index 32c3d97..432921c 100644
--- a/purgatory/arch/ia64/Makefile
+++ b/purgatory/arch/ia64/Makefile
@@ -7,7 +7,3 @@ ia64_PURGATORY_SRCS += purgatory/arch/ia64/console-ia64.c
 ia64_PURGATORY_SRCS += purgatory/arch/ia64/vga.c
 
 ia64_PURGATORY_EXTRA_CFLAGS = -ffixed-r28
-
-dist += purgatory/arch/ia64/Makefile $(ia64_PURGATORY_SRCS)	\
-	purgatory/arch/ia64/io.h purgatory/arch/ia64/purgatory-ia64.h
-
diff --git a/purgatory/arch/mips/Makefile b/purgatory/arch/mips/Makefile
index 87888f3..0fcc068 100644
--- a/purgatory/arch/mips/Makefile
+++ b/purgatory/arch/mips/Makefile
@@ -4,7 +4,3 @@
 
 mips_PURGATORY_SRCS+= purgatory/arch/mips/purgatory-mips.c
 mips_PURGATORY_SRCS+= purgatory/arch/mips/console-mips.c
-
-dist += purgatory/arch/mips/Makefile $(mips_PURGATORY_SRCS)		\
-	purgatory/arch/mips/purgatory-mips.h
-
diff --git a/purgatory/arch/ppc/Makefile b/purgatory/arch/ppc/Makefile
index c85c58a..8c6c241 100644
--- a/purgatory/arch/ppc/Makefile
+++ b/purgatory/arch/ppc/Makefile
@@ -8,7 +8,3 @@ ppc_PURGATORY_SRCS += purgatory/arch/ppc/purgatory-ppc.c
 ppc_PURGATORY_SRCS += purgatory/arch/ppc/console-ppc.c
 
 ppc_PURGATORY_EXTRA_CFLAGS += -msoft-float
-
-dist += purgatory/arch/ppc/Makefile $(ppc_PURGATORY_SRCS)		\
-	purgatory/arch/ppc/purgatory-ppc.h purgatory/arch/ppc/ppc_asm.h
-
diff --git a/purgatory/arch/ppc64/Makefile b/purgatory/arch/ppc64/Makefile
index 67f41ae..55d6f82 100644
--- a/purgatory/arch/ppc64/Makefile
+++ b/purgatory/arch/ppc64/Makefile
@@ -12,7 +12,3 @@ ppc64_PURGATORY_SRCS += purgatory/arch/ppc64/misc.S
 ppc64_PURGATORY_EXTRA_CFLAGS += -m64 -mcall-aixdesc -msoft-float
 ppc64_PURGATORY_EXTRA_ASFLAGS += -m64 -mcall-aixdesc
 ppc64_PURGATORY_EXTRA_LDFLAGS += -melf64ppc
-
-dist += purgatory/arch/ppc64/Makefile $(ppc64_PURGATORY_SRCS)		\
-	purgatory/arch/ppc64/hvCall.h					\
-	purgatory/arch/ppc64/purgatory-ppc64.h
diff --git a/purgatory/arch/s390/Makefile b/purgatory/arch/s390/Makefile
index 09749bd..2280cf2 100644
--- a/purgatory/arch/s390/Makefile
+++ b/purgatory/arch/s390/Makefile
@@ -6,6 +6,3 @@ s390_PURGATORY_EXTRA_CFLAGS += -fno-stack-protector
 s390_PURGATORY_SRCS += purgatory/arch/s390/console-s390.c
 s390_PURGATORY_SRCS += purgatory/arch/s390/setup-s390.S
 s390_PURGATORY_SRCS += purgatory/arch/s390/purgatory-s390.c
-
-dist += purgatory/arch/s390/Makefile $(s390_PURGATORY_SRCS)
-
diff --git a/purgatory/arch/sh/Makefile b/purgatory/arch/sh/Makefile
index 33ad4db..493fec4 100644
--- a/purgatory/arch/sh/Makefile
+++ b/purgatory/arch/sh/Makefile
@@ -3,6 +3,3 @@
 #
 
 sh_PURGATORY_SRCS =
-
-dist += purgatory/arch/sh/Makefile $(sh_PURGATORY_SRCS)
-
diff --git a/purgatory/arch/x86_64/Makefile b/purgatory/arch/x86_64/Makefile
index 7300937..92c9c67 100644
--- a/purgatory/arch/x86_64/Makefile
+++ b/purgatory/arch/x86_64/Makefile
@@ -10,11 +10,6 @@ x86_64_PURGATORY_SRCS_native += purgatory/arch/x86_64/purgatory-x86_64.c
 
 x86_64_PURGATORY_SRCS += $(x86_64_PURGATORY_SRCS_native)
 
-dist += purgatory/arch/x86_64/Makefile $(x86_64_PURGATORY_SRCS_native) 	\
-	purgatory/arch/x86_64/include/arch/io.h				\
-	purgatory/arch/x86_64/include/arch/debug.h			\
-	purgatory/arch/x86_64/purgatory-x86_64.h
-
 # Don't add sources in i386/ to dist, as i386/Makefile adds them
 x86_64_PURGATORY_SRCS += purgatory/arch/i386/entry32-16.S
 x86_64_PURGATORY_SRCS += purgatory/arch/i386/entry32-16-debug.S
diff --git a/util/Makefile b/util/Makefile
index 948ee63..b7fd5a0 100644
--- a/util/Makefile
+++ b/util/Makefile
@@ -8,5 +8,4 @@ $(BIN_TO_HEX): CC=$(BUILD_CC)
 $(BIN_TO_HEX): CFLAGS=$(BUILD_CFLAGS)
 $(BIN_TO_HEX): LDFLAGS=
 
-dist += util/Makefile util/bin-to-hex.c
 clean += util/bin-to-hex.o $(BIN_TO_HEX)
diff --git a/util_lib/Makefile b/util_lib/Makefile
index 54ccdc5..5b4bd22 100644
--- a/util_lib/Makefile
+++ b/util_lib/Makefile
@@ -10,8 +10,6 @@ UTIL_LIB = libutil.a
 
 -include $(UTIL_LIB_DEPS)
 
-dist  += util_lib/Makefile $(UTIL_LIB_SRCS)				\
-	util_lib/include/sha256.h util_lib/include/ip_checksum.h
 clean += $(UTIL_LIB_OBJS) $(UTIL_LIB_DEPS) $(UTIL_LIB)
 
 $(UTIL_LIB): CPPFLAGS += -I$(srcdir)/util_lib/include
diff --git a/vmcore-dmesg/Makefile b/vmcore-dmesg/Makefile
index 42c218a..b13cc5f 100644
--- a/vmcore-dmesg/Makefile
+++ b/vmcore-dmesg/Makefile
@@ -10,7 +10,6 @@ VMCORE_DMESG_DEPS = $(call depify, $(VMCORE_DMESG_OBJS))
 VMCORE_DMESG = $(SBINDIR)/vmcore-dmesg
 VMCORE_DMESG_MANPAGE = $(MANDIR)/man8/vmcore-dmesg.8
 
-dist += vmcore-dmesg/Makefile $(VMCORE_DMESG_SRCS) vmcore-dmesg/vmcore-dmesg.8
 clean += $(VMCORE_DMESG_OBJS) $(VMCORE_DMESG_DEPS) $(VMCORE_DMESG) $(VMCORE_DMESG_MANPAGE)
 
 -include $(VMCORE_DMESG_DEPS)
-- 
1.8.1.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
