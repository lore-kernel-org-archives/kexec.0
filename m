Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Swm9d-0008H6-6O
 for kexec@lists.infradead.org; Thu, 02 Aug 2012 03:32:54 +0000
From: Simon Horman <horms@verge.net.au>
Subject: [PATCH] build: Avoid duplicate files in tarball
Date: Thu,  2 Aug 2012 12:08:08 +0900
Message-Id: <1343876888-21106-1-git-send-email-horms@verge.net.au>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Simon Horman <horms@verge.net.au>

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 kexec/Makefile             | 75 +++++++++++++++++++++++++++-------------------
 kexec/arch/arm/Makefile    |  2 +-
 kexec/arch/ppc/Makefile    |  3 +-
 kexec/arch/sh/Makefile     |  3 +-
 kexec/arch/x86_64/Makefile | 12 +++++---
 purgatory/Makefile         |  2 --
 6 files changed, 58 insertions(+), 39 deletions(-)

diff --git a/kexec/Makefile b/kexec/Makefile
index 8c815b5..dff8da6 100644
--- a/kexec/Makefile
+++ b/kexec/Makefile
@@ -7,47 +7,62 @@ $(PURGATORY_HEX_C): $(PURGATORY) $(BIN_TO_HEX)
 	$(MKDIR) -p $(@D)
 	$(BIN_TO_HEX) purgatory < $(PURGATORY) > $@
 
-KEXEC_SRCS =
+KEXEC_SRCS = $(KEXEC_SRCS_base)
 KEXEC_GENERATED_SRCS =
 
-KEXEC_SRCS += kexec/kexec.c
-KEXEC_SRCS += kexec/ifdown.c
-KEXEC_SRCS += kexec/kexec-elf.c
-KEXEC_SRCS += kexec/kexec-elf-exec.c
-KEXEC_SRCS += kexec/kexec-elf-core.c
-KEXEC_SRCS += kexec/kexec-elf-rel.c
-KEXEC_SRCS += kexec/kexec-elf-boot.c
-KEXEC_SRCS += kexec/kexec-iomem.c
-KEXEC_SRCS += kexec/firmware_memmap.c
-KEXEC_SRCS += kexec/crashdump.c
-KEXEC_SRCS += kexec/crashdump-xen.c
-KEXEC_SRCS += kexec/phys_arch.c
-KEXEC_SRCS += kexec/kernel_version.c
-KEXEC_SRCS += kexec/lzma.c
-KEXEC_SRCS += kexec/zlib.c
+KEXEC_SRCS_base += kexec/kexec.c
+KEXEC_SRCS_base += kexec/ifdown.c
+KEXEC_SRCS_base += kexec/kexec-elf.c
+KEXEC_SRCS_base += kexec/kexec-elf-exec.c
+KEXEC_SRCS_base += kexec/kexec-elf-core.c
+KEXEC_SRCS_base += kexec/kexec-elf-rel.c
+KEXEC_SRCS_base += kexec/kexec-elf-boot.c
+KEXEC_SRCS_base += kexec/kexec-iomem.c
+KEXEC_SRCS_base += kexec/firmware_memmap.c
+KEXEC_SRCS_base += kexec/crashdump.c
+KEXEC_SRCS_base += kexec/crashdump-xen.c
+KEXEC_SRCS_base += kexec/phys_arch.c
+KEXEC_SRCS_base += kexec/kernel_version.c
+KEXEC_SRCS_base += kexec/lzma.c
+KEXEC_SRCS_base += kexec/zlib.c
 
 KEXEC_GENERATED_SRCS += $(PURGATORY_HEX_C)
 
-dist += kexec/Makefile $(KEXEC_SRCS) $(KEXEC_GENERATED_SRCS)	\
-	kexec/crashdump-elf.c					\
+dist += kexec/Makefile $(KEXEC_GENERATED_SRCS)			\
+	$(KEXEC_SRCS_base) kexec/crashdump-elf.c		\
 	kexec/crashdump.h kexec/firmware_memmap.h		\
 	kexec/kexec-elf-boot.h					\
 	kexec/kexec-elf.h kexec/kexec-sha256.h			\
 	kexec/kexec-zlib.h kexec/kexec-lzma.h			\
 	kexec/kexec-syscall.h kexec/kexec.h kexec/kexec.8
 
-$(ARCH)_PROC_IOMEM		= kexec/proc_iomem.c
-KEXEC_SRCS += $($(ARCH)_PROC_IOMEM)
-$(ARCH)_VIRT_TO_PHYS		= kexec/virt_to_phys.c
-KEXEC_SRCS += $($(ARCH)_VIRT_TO_PHYS)
-$(ARCH)_PHYS_TO_VIRT		= kexec/phys_to_virt.c
-KEXEC_SRCS += $($(ARCH)_PHYS_TO_VIRT)
-$(ARCH)_ADD_SEGMENT		= kexec/add_segment.c
-KEXEC_SRCS += $($(ARCH)_ADD_SEGMENT)
-$(ARCH)_ADD_BUFFER		= kexec/add_buffer.c
-KEXEC_SRCS += $($(ARCH)_ADD_BUFFER)
-$(ARCH)_ARCH_REUSE_INITRD	= kexec/arch_reuse_initrd.c
-KEXEC_SRCS += $($(ARCH)_ARCH_REUSE_INITRD)
+dist				+= kexec/proc_iomem.c
+$(ARCH)_PROC_IOMEM		=  kexec/proc_iomem.c
+KEXEC_SRCS			+= $($(ARCH)_PROC_IOMEM)
+
+dist				+= kexec/virt_to_phys.c
+$(ARCH)_VIRT_TO_PHYS		=  kexec/virt_to_phys.c
+KEXEC_SRCS			+= $($(ARCH)_VIRT_TO_PHYS)
+
+dist				+= kexec/phys_to_virt.c
+$(ARCH)_PHYS_TO_VIRT		=  kexec/phys_to_virt.c
+KEXEC_SRCS			+= $($(ARCH)_PHYS_TO_VIRT)
+
+dist				+= kexec/add_segment.c
+$(ARCH)_ADD_SEGMENT		=  kexec/add_segment.c
+KEXEC_SRCS			+= $($(ARCH)_ADD_SEGMENT)
+
+dist				+= kexec/add_buffer.c
+$(ARCH)_ADD_BUFFER		=  kexec/add_buffer.c
+KEXEC_SRCS			+= $($(ARCH)_ADD_BUFFER)
+
+dist				+=  kexec/arch_reuse_initrd.c
+$(ARCH)_ARCH_REUSE_INITRD	=  kexec/arch_reuse_initrd.c
+KEXEC_SRCS			+= $($(ARCH)_ARCH_REUSE_INITRD)
+
+dist				+= kexec/kexec-uImage.c
+$(ARCH)_UIMAGE			=
+KEXEC_SRCS			+= $($(ARCH)_UIMAGE)
 
 include $(srcdir)/kexec/arch/alpha/Makefile
 include $(srcdir)/kexec/arch/arm/Makefile
diff --git a/kexec/arch/arm/Makefile b/kexec/arch/arm/Makefile
index 3d07e59..288ec33 100644
--- a/kexec/arch/arm/Makefile
+++ b/kexec/arch/arm/Makefile
@@ -6,8 +6,8 @@ arm_KEXEC_SRCS+= kexec/arch/arm/kexec-zImage-arm.c
 arm_KEXEC_SRCS+= kexec/arch/arm/kexec-uImage-arm.c
 arm_KEXEC_SRCS+= kexec/arch/arm/kexec-arm.c
 arm_KEXEC_SRCS+= kexec/arch/arm/crashdump-arm.c
-arm_KEXEC_SRCS+= kexec/kexec-uImage.c
 
+arm_UIMAGE = kexec/kexec-uImage.c
 arm_PHYS_TO_VIRT = kexec/arch/arm/phys_to_virt.c
 
 dist += kexec/arch/arm/Makefile $(arm_KEXEC_SRCS) $(arm_PHYS_TO_VIRT)	\
diff --git a/kexec/arch/ppc/Makefile b/kexec/arch/ppc/Makefile
index 41242a5..e868917 100644
--- a/kexec/arch/ppc/Makefile
+++ b/kexec/arch/ppc/Makefile
@@ -13,7 +13,8 @@ ppc_KEXEC_SRCS += kexec/arch/ppc/ppc-setup-dol.S
 ppc_KEXEC_SRCS += kexec/arch/ppc/fixup_dtb.c
 ppc_KEXEC_SRCS += kexec/arch/ppc/fs2dt.c
 ppc_KEXEC_SRCS += kexec/arch/ppc/crashdump-powerpc.c
-ppc_KEXEC_SRCS += kexec/kexec-uImage.c
+
+ppc_UIMAGE = kexec/kexec-uImage.c
 
 libfdt_SRCS = kexec/arch/ppc/libfdt-wrapper.c
 libfdt_SRCS += $(LIBFDT_SRCS:%=kexec/arch/ppc/libfdt/%)
diff --git a/kexec/arch/sh/Makefile b/kexec/arch/sh/Makefile
index a9f6081..7cf40ae 100644
--- a/kexec/arch/sh/Makefile
+++ b/kexec/arch/sh/Makefile
@@ -9,7 +9,8 @@ sh_KEXEC_SRCS += kexec/arch/sh/kexec-elf-sh.c
 sh_KEXEC_SRCS += kexec/arch/sh/kexec-elf-rel-sh.c
 sh_KEXEC_SRCS += kexec/arch/sh/netbsd_booter.S
 sh_KEXEC_SRCS += kexec/arch/sh/crashdump-sh.c
-sh_KEXEC_SRCS += kexec/kexec-uImage.c
+
+sh_UIMAGE = kexec/kexec-uImage.c
 
 sh_ADD_BUFFER =
 sh_ADD_SEGMENT =
diff --git a/kexec/arch/x86_64/Makefile b/kexec/arch/x86_64/Makefile
index 916babf..405bdf5 100644
--- a/kexec/arch/x86_64/Makefile
+++ b/kexec/arch/x86_64/Makefile
@@ -9,10 +9,14 @@ x86_64_KEXEC_SRCS += kexec/arch/i386/kexec-nbi.c
 x86_64_KEXEC_SRCS += kexec/arch/i386/x86-linux-setup.c
 x86_64_KEXEC_SRCS += kexec/arch/i386/kexec-x86-common.c
 x86_64_KEXEC_SRCS += kexec/arch/i386/crashdump-x86.c
-x86_64_KEXEC_SRCS += kexec/arch/x86_64/kexec-x86_64.c
-x86_64_KEXEC_SRCS += kexec/arch/x86_64/kexec-elf-x86_64.c
-x86_64_KEXEC_SRCS += kexec/arch/x86_64/kexec-elf-rel-x86_64.c
 
-dist += kexec/arch/x86_64/Makefile $(x86_64_KEXEC_SRCS) \
+x86_64_KEXEC_SRCS_native =  kexec/arch/x86_64/kexec-x86_64.c
+x86_64_KEXEC_SRCS_native += kexec/arch/x86_64/kexec-elf-x86_64.c
+x86_64_KEXEC_SRCS_native += kexec/arch/x86_64/kexec-elf-rel-x86_64.c
+
+x86_64_KEXEC_SRCS += $(x86_64_KEXEC_SRCS_native)
+
+# Don't add sources in i386/ to dist, as i386/Makefile adds them
+dist += kexec/arch/x86_64/Makefile $(x86_64_KEXEC_SRCS_native) \
 	kexec/arch/x86_64/kexec-x86_64.h \
 	kexec/arch/x86_64/include/arch/options.h
diff --git a/purgatory/Makefile b/purgatory/Makefile
index ee1679c..711799b 100644
--- a/purgatory/Makefile
+++ b/purgatory/Makefile
@@ -27,8 +27,6 @@ include $(srcdir)/purgatory/arch/s390/Makefile
 include $(srcdir)/purgatory/arch/sh/Makefile
 include $(srcdir)/purgatory/arch/x86_64/Makefile
 
-PURGATORY_SRCS+=$($(ARCH)_PURGATORY_SRCS)
-
 PURGATORY_OBJS = $(call objify, $(PURGATORY_SRCS)) purgatory/sha256.o
 PURGATORY_DEPS = $(call depify, $(PURGATORY_OBJS))
 
-- 
1.7.10.2.484.gcd07cc5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
