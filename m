Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KnhbI-00070t-J6
	for kexec@lists.infradead.org; Wed, 08 Oct 2008 22:33:49 +0000
Received: from yukiko.kent.sydney.vergenet.net
	(124-170-201-186.dyn.iinet.net.au [124.170.201.186])
	by kirsty.vergenet.net (Postfix) with ESMTP id 85234240A3
	for <kexec@lists.infradead.org>; Thu,  9 Oct 2008 09:33:47 +1100 (EST)
Date: Thu, 9 Oct 2008 09:33:47 +1100
From: Simon Horman <horms@verge.net.au>
Subject: [patch] Include all source files exactly once
Message-ID: <20081008223345.GK16178@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

This patch fixes two problems.

1. It ensures that the following files are always included in the
   tarball, regardless of what architecture it is built on
	kexec/proc_iomem.c
	kexec/virt_to_phys.c
	kexec/add_segment.c
	kexec/add_buffer.c
	kexec/arch_reuse_initrd.c

2. It ensures that archetecture specific files are only
   included in the tarball once.

Signed-off-by: Simon Horman <horms@verge.net.au>

--- 
This patch applies on top of Sebastian Siewior's
"powerpc: dtb and purgatory support for ppc32" patch.

Index: kexec-tools/kexec/Makefile
===================================================================
--- kexec-tools.orig/kexec/Makefile	2008-10-08 16:34:16.000000000 +1100
+++ kexec-tools/kexec/Makefile	2008-10-08 16:58:41.000000000 +1100
@@ -7,41 +7,42 @@ $(PURGATORY_HEX_C): $(PURGATORY) $(BIN_T
 	$(MKDIR) -p $(@D)
 	$(BIN_TO_HEX) purgatory < $(PURGATORY) > $@
 
-KEXEC_SRCS =
-KEXEC_GENERATED_SRCS =
+BASE_KEXEC_SRCS =  kexec/kexec.c
+BASE_KEXEC_SRCS += kexec/ifdown.c
+BASE_KEXEC_SRCS += kexec/kexec-elf.c
+BASE_KEXEC_SRCS += kexec/kexec-elf-exec.c
+BASE_KEXEC_SRCS += kexec/kexec-elf-core.c
+BASE_KEXEC_SRCS += kexec/kexec-elf-rel.c
+BASE_KEXEC_SRCS += kexec/kexec-elf-boot.c
+BASE_KEXEC_SRCS += kexec/kexec-iomem.c
+BASE_KEXEC_SRCS += kexec/firmware_memmap.c
+BASE_KEXEC_SRCS += kexec/crashdump.c
+BASE_KEXEC_SRCS += kexec/crashdump-xen.c
+BASE_KEXEC_SRCS += kexec/phys_arch.c
 
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
+KEXEC_GENERATED_SRCS = $(PURGATORY_HEX_C)
 
-KEXEC_GENERATED_SRCS += $(PURGATORY_HEX_C)
-
-dist += kexec/Makefile $(KEXEC_SRCS) $(KEXEC_GENERATED_SRCS)	\
+dist += kexec/Makefile $(BASE_KEXEC_SRCS) $(KEXEC_GENERATED_SRCS)	\
 	kexec/crashdump-elf.c					\
 	kexec/crashdump.h kexec/firmware_memmap.h		\
 	kexec/kexec-elf-boot.h					\
 	kexec/kexec-elf.h kexec/kexec-sha256.h			\
-	kexec/kexec-syscall.h kexec/kexec.h kexec/kexec.8
+	kexec/kexec-syscall.h kexec/kexec.h kexec/kexec.8	\
+	kexec/proc_iomem.c kexec/virt_to_phys.c			\
+	kexec/add_segment.c kexec/add_buffer.c			\
+	kexec/arch_reuse_initrd.c
 
+$(ARCH)_foreign_KEXEC_SRCS =
 $(ARCH)_PROC_IOMEM		= kexec/proc_iomem.c
-KEXEC_SRCS += $($(ARCH)_PROC_IOMEM)
+$(ARCH)_foreign_KEXEC_SRCS += $($(ARCH)_PROC_IOMEM)
 $(ARCH)_VIRT_TO_PHYS		= kexec/virt_to_phys.c
-KEXEC_SRCS += $($(ARCH)_VIRT_TO_PHYS)
+$(ARCH)_foreign_KEXEC_SRCS += $($(ARCH)_VIRT_TO_PHYS)
 $(ARCH)_ADD_SEGMENT		= kexec/add_segment.c
-KEXEC_SRCS += $($(ARCH)_ADD_SEGMENT)
+$(ARCH)_foreign_KEXEC_SRCS += $($(ARCH)_ADD_SEGMENT)
 $(ARCH)_ADD_BUFFER		= kexec/add_buffer.c
-KEXEC_SRCS += $($(ARCH)_ADD_BUFFER)
+$(ARCH)_foreign_KEXEC_SRCS += $($(ARCH)_ADD_BUFFER)
 $(ARCH)_ARCH_REUSE_INITRD	= kexec/arch_reuse_initrd.c
-KEXEC_SRCS += $($(ARCH)_ARCH_REUSE_INITRD)
+$(ARCH)_foreign_KEXEC_SRCS += $($(ARCH)_ARCH_REUSE_INITRD)
 
 include $(srcdir)/kexec/arch/alpha/Makefile
 include $(srcdir)/kexec/arch/arm/Makefile
@@ -55,7 +56,8 @@ include $(srcdir)/kexec/arch/s390/Makefi
 include $(srcdir)/kexec/arch/sh/Makefile
 include $(srcdir)/kexec/arch/x86_64/Makefile
 
-KEXEC_SRCS += $($(ARCH)_KEXEC_SRCS)
+KEXEC_SRCS += $($(ARCH)_KEXEC_SRCS) $($(ARCH)_foreign_KEXEC_SRCS) \
+	      $(BASE_KEXEC_SRCS)
 
 KEXEC_OBJS = $(call objify, $(KEXEC_SRCS) $(KEXEC_GENERATED_SRCS))
 KEXEC_DEPS = $(call depify, $(KEXEC_OBJS))
Index: kexec-tools/kexec/arch/ppc/Makefile
===================================================================
--- kexec-tools.orig/kexec/arch/ppc/Makefile	2008-10-08 16:34:16.000000000 +1100
+++ kexec-tools/kexec/arch/ppc/Makefile	2008-10-08 16:56:53.000000000 +1100
@@ -7,7 +7,8 @@ ppc_KEXEC_SRCS += kexec/arch/ppc/kexec-e
 ppc_KEXEC_SRCS += kexec/arch/ppc/kexec-dol-ppc.c
 ppc_KEXEC_SRCS += kexec/arch/ppc/ppc-setup-simple.S
 ppc_KEXEC_SRCS += kexec/arch/ppc/ppc-setup-dol.S
-ppc_KEXEC_SRCS += kexec/arch/ppc64/fs2dt.c
+
+ppc_foreign_KEXEC_SRCS += kexec/arch/ppc64/fs2dt.c
 
 dist += kexec/arch/ppc/Makefile $(ppc_KEXEC_SRCS)			\
 	kexec/arch/ppc/kexec-ppc.h kexec/arch/ppc/ppc_asm.h		\
Index: kexec-tools/kexec/arch/x86_64/Makefile
===================================================================
--- kexec-tools.orig/kexec/arch/x86_64/Makefile	2008-10-08 16:34:16.000000000 +1100
+++ kexec-tools/kexec/arch/x86_64/Makefile	2008-10-08 16:58:20.000000000 +1100
@@ -1,14 +1,15 @@
 #
 # kexec x86_64 (linux booting linux)
 #
-x86_64_KEXEC_SRCS =  kexec/arch/i386/kexec-elf-x86.c
-x86_64_KEXEC_SRCS += kexec/arch/i386/kexec-bzImage.c
-x86_64_KEXEC_SRCS += kexec/arch/i386/kexec-multiboot-x86.c
-x86_64_KEXEC_SRCS += kexec/arch/i386/kexec-beoboot-x86.c
-x86_64_KEXEC_SRCS += kexec/arch/i386/kexec-nbi.c
-x86_64_KEXEC_SRCS += kexec/arch/i386/x86-linux-setup.c
-x86_64_KEXEC_SRCS += kexec/arch/i386/kexec-x86-common.c
-x86_64_KEXEC_SRCS += kexec/arch/x86_64/crashdump-x86_64.c
+x86_64_foreign_KEXEC_SRCS += kexec/arch/i386/kexec-elf-x86.c
+x86_64_foreign_KEXEC_SRCS += kexec/arch/i386/kexec-bzImage.c
+x86_64_foreign_KEXEC_SRCS += kexec/arch/i386/kexec-multiboot-x86.c
+x86_64_foreign_KEXEC_SRCS += kexec/arch/i386/kexec-beoboot-x86.c
+x86_64_foreign_KEXEC_SRCS += kexec/arch/i386/kexec-nbi.c
+x86_64_foreign_KEXEC_SRCS += kexec/arch/i386/x86-linux-setup.c
+x86_64_foreign_KEXEC_SRCS += kexec/arch/i386/kexec-x86-common.c
+
+x86_64_KEXEC_SRCS =  kexec/arch/x86_64/crashdump-x86_64.c
 x86_64_KEXEC_SRCS += kexec/arch/x86_64/kexec-x86_64.c
 x86_64_KEXEC_SRCS += kexec/arch/x86_64/kexec-elf-x86_64.c
 x86_64_KEXEC_SRCS += kexec/arch/x86_64/kexec-elf-rel-x86_64.c
Index: kexec-tools/purgatory/Makefile
===================================================================
--- kexec-tools.orig/purgatory/Makefile	2008-10-08 16:34:16.000000000 +1100
+++ kexec-tools/purgatory/Makefile	2008-10-08 16:40:58.000000000 +1100
@@ -8,12 +8,11 @@
 # or headers.
 
 PURGATORY = purgatory/purgatory.ro
-PURGATORY_SRCS =
-PURGATORY_SRCS += purgatory/purgatory.c
-PURGATORY_SRCS += purgatory/printf.c
-PURGATORY_SRCS += purgatory/string.c
+BASE_PURGATORY_SRCS =  purgatory/purgatory.c
+BASE_PURGATORY_SRCS += purgatory/printf.c
+BASE_PURGATORY_SRCS += purgatory/string.c
 
-dist += purgatory/Makefile $(PURGATORY_SRCS)				\
+dist += purgatory/Makefile $(BASE_PURGATORY_SRCS)			\
 	purgatory/include/purgatory.h purgatory/include/string.h
 
 include $(srcdir)/purgatory/arch/alpha/Makefile
@@ -27,7 +26,7 @@ include $(srcdir)/purgatory/arch/s390/Ma
 include $(srcdir)/purgatory/arch/sh/Makefile
 include $(srcdir)/purgatory/arch/x86_64/Makefile
 
-PURGATORY_SRCS+=$($(ARCH)_PURGATORY_SRCS)
+PURGATORY_SRCS = $(BASE_PURGATORY_SRCS) $($(ARCH)_PURGATORY_SRCS)
 
 PURGATORY_OBJS = $(call objify, $(PURGATORY_SRCS)) purgatory/sha256.o
 PURGATORY_DEPS = $(call depify, $(PURGATORY_OBJS))

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
