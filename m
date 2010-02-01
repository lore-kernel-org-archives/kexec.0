Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NbvAI-00054K-Md
	for kexec@lists.infradead.org; Mon, 01 Feb 2010 12:14:11 +0000
Received: from yukiko.kent.sydney.vergenet.net
	(203-206-13-190.dyn.iinet.net.au [203.206.13.190])
	by kirsty.vergenet.net (Postfix) with ESMTP id 2EC3524051
	for <kexec@lists.infradead.org>; Mon,  1 Feb 2010 23:14:01 +1100 (EST)
Message-Id: <20100201121320.507152091@vergenet.net>
Date: Mon, 01 Feb 2010 23:11:57 +1100
From: Simon Horman <horms@verge.net.au>
Subject: [patch 01/27] Mark unused parameters
References: <20100201121156.252909695@vergenet.net>
Content-Disposition: inline; filename=mark-unsued-parameters.patch
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
To: Kexec Mailing List <kexec@lists.infradead.org>

Signed-off-by: Simon Horman <horms@verge.net.au>

Index: kexec-tools/kexec/kexec.h
===================================================================
--- kexec-tools.orig/kexec/kexec.h	2010-02-01 23:07:15.000000000 +1100
+++ kexec-tools/kexec/kexec.h	2010-02-01 23:07:16.000000000 +1100
@@ -13,6 +13,7 @@
 #define _GNU_SOURCE
 
 #include "kexec-elf.h"
+#include "unused.h"
 
 #ifndef BYTE_ORDER
 #error BYTE_ORDER not defined
@@ -258,7 +259,7 @@ extern int add_backup_segments(struct ke
 #define dbgprintf(_args...) do {printf(_args);} while(0)
 #else
 static inline int __attribute__ ((format (printf, 1, 2)))
-	dbgprintf(const char *fmt, ...) {return 0;}
+	dbgprintf(const char *UNUSED(fmt), ...) {return 0;}
 #endif
 
 char *concat_cmdline(const char *base, const char *append);
Index: kexec-tools/include/unused.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kexec-tools/include/unused.h	2010-02-01 23:07:16.000000000 +1100
@@ -0,0 +1,15 @@
+#ifndef UNUSED_H
+#define UNUSED_H
+
+/* http://sourcefrog.net/weblog/software/languages/C/unused.html */
+
+#ifdef UNUSED
+#elif defined(__GNUC__)
+# define UNUSED(x) UNUSED_ ## x __attribute__((unused))
+#elif defined(__LCLINT__)
+# define UNUSED(x) /*@unused@*/ x
+#else
+# define UNUSED(x) x
+#endif
+
+#endif
Index: kexec-tools/kexec/arch/i386/kexec-beoboot-x86.c
===================================================================
--- kexec-tools.orig/kexec/arch/i386/kexec-beoboot-x86.c	2010-02-01 23:07:08.000000000 +1100
+++ kexec-tools/kexec/arch/i386/kexec-beoboot-x86.c	2010-02-01 23:07:16.000000000 +1100
@@ -75,7 +75,7 @@ void beoboot_usage(void)
 #define KERN32_BASE  0x100000 /* 1MB */
 #define INITRD_BASE 0x1000000 /* 16MB */
 
-int beoboot_load(int argc, char **argv, const char *buf, off_t len,
+int beoboot_load(int argc, char **argv, const char *buf, off_t UNUSED(len),
 	struct kexec_info *info)
 {
 	struct beoboot_header bb_header;
Index: kexec-tools/kexec/arch/i386/kexec-nbi.c
===================================================================
--- kexec-tools.orig/kexec/arch/i386/kexec-nbi.c	2010-02-01 23:07:08.000000000 +1100
+++ kexec-tools/kexec/arch/i386/kexec-nbi.c	2010-02-01 23:07:16.000000000 +1100
@@ -150,7 +150,7 @@ void nbi_usage(void)
 		);
 }
 
-int nbi_load(int argc, char **argv, const char *buf, off_t len, 
+int nbi_load(int argc, char **argv, const char *buf, off_t UNUSED(len),
 	struct kexec_info *info)
 {
 	struct imgheader hdr;
Index: kexec-tools/kexec/crashdump-xen.c
===================================================================
--- kexec-tools.orig/kexec/crashdump-xen.c	2010-02-01 23:07:08.000000000 +1100
+++ kexec-tools/kexec/crashdump-xen.c	2010-02-01 23:07:16.000000000 +1100
@@ -72,8 +72,8 @@ unsigned long xen_architecture(struct cr
 	return machine;
 }
 
-static int xen_crash_note_callback(void *data, int nr,
-				   char *str,
+static int xen_crash_note_callback(void *UNUSED(data), int nr,
+				   char *UNUSED(str),
 				   unsigned long base,
 				   unsigned long length)
 {
Index: kexec-tools/kexec/virt_to_phys.c
===================================================================
--- kexec-tools.orig/kexec/virt_to_phys.c	2010-02-01 23:07:08.000000000 +1100
+++ kexec-tools/kexec/virt_to_phys.c	2010-02-01 23:07:16.000000000 +1100
@@ -1,7 +1,7 @@
 #include "kexec.h"
 #include <stdlib.h>
 
-unsigned long virt_to_phys(unsigned long addr)
+unsigned long virt_to_phys(unsigned long UNUSED(addr))
 {
 	abort();
 }
Index: kexec-tools/kexec/arch/i386/kexec-elf-rel-x86.c
===================================================================
--- kexec-tools.orig/kexec/arch/i386/kexec-elf-rel-x86.c	2010-02-01 23:07:08.000000000 +1100
+++ kexec-tools/kexec/arch/i386/kexec-elf-rel-x86.c	2010-02-01 23:07:16.000000000 +1100
@@ -18,7 +18,7 @@ int machine_verify_elf_rel(struct mem_eh
 	return 1;
 }
 
-void machine_apply_elf_rel(struct mem_ehdr *ehdr, unsigned long r_type,
+void machine_apply_elf_rel(struct mem_ehdr *UNUSED(ehdr), unsigned long r_type,
 	void *location, unsigned long address, unsigned long value)
 {
 	switch(r_type) {
Index: kexec-tools/kexec/lzma.c
===================================================================
--- kexec-tools.orig/kexec/lzma.c	2010-02-01 23:07:08.000000000 +1100
+++ kexec-tools/kexec/lzma.c	2010-02-01 23:07:16.000000000 +1100
@@ -3,6 +3,7 @@
 
 #include "kexec-lzma.h"
 #include "config.h"
+#include "kexec.h"
 
 #ifdef HAVE_LIBLZMA
 #define _GNU_SOURCE
@@ -16,8 +17,6 @@
 #include <ctype.h>
 #include <lzma.h>
 
-#include "kexec.h"
-
 #define kBufferSize (1 << 15)
 
 typedef struct lzfile {
@@ -197,7 +196,7 @@ char *lzma_decompress_file(const char *f
 	return buf;
 }
 #else
-char *lzma_decompress_file(const char *filename, off_t *r_size)
+char *lzma_decompress_file(const char *UNUSED(filename), off_t *UNUSED(r_size))
 {
 	return NULL;
 }
Index: kexec-tools/kexec/zlib.c
===================================================================
--- kexec-tools.orig/kexec/zlib.c	2010-02-01 23:07:08.000000000 +1100
+++ kexec-tools/kexec/zlib.c	2010-02-01 23:07:16.000000000 +1100
@@ -1,4 +1,6 @@
 #include "kexec-zlib.h"
+#include "kexec.h"
+
 #ifdef HAVE_LIBZ
 #define _GNU_SOURCE
 #include <stdio.h>
@@ -13,8 +15,6 @@
 #include <ctype.h>
 #include <zlib.h>
 
-#include "kexec.h"
-
 char *zlib_decompress_file(const char *filename, off_t *r_size)
 {
 	gzFile fp;
@@ -71,7 +71,7 @@ char *zlib_decompress_file(const char *f
 	return buf;
 }
 #else
-char *zlib_decompress_file(const char *filename, off_t *r_size)
+char *zlib_decompress_file(const char *UNUSED(filename), off_t *UNUSED(r_size))
 {
 	return NULL;
 }
Index: kexec-tools/kexec/arch/x86_64/kexec-x86_64.c
===================================================================
--- kexec-tools.orig/kexec/arch/x86_64/kexec-x86_64.c	2010-02-01 23:07:08.000000000 +1100
+++ kexec-tools/kexec/arch/x86_64/kexec-x86_64.c	2010-02-01 23:07:16.000000000 +1100
@@ -148,7 +148,7 @@ const struct arch_map_entry arches[] = {
 	{ 0 },
 };
 
-int arch_compat_trampoline(struct kexec_info *info)
+int arch_compat_trampoline(struct kexec_info *UNUSED(info))
 {
 	return 0;
 }
Index: kexec-tools/kexec/arch/x86_64/kexec-elf-rel-x86_64.c
===================================================================
--- kexec-tools.orig/kexec/arch/x86_64/kexec-elf-rel-x86_64.c	2010-02-01 23:07:08.000000000 +1100
+++ kexec-tools/kexec/arch/x86_64/kexec-elf-rel-x86_64.c	2010-02-01 23:07:16.000000000 +1100
@@ -57,7 +57,7 @@ static const char *reloc_name(unsigned l
 	return name;
 }
 
-void machine_apply_elf_rel(struct mem_ehdr *ehdr, unsigned long r_type, 
+void machine_apply_elf_rel(struct mem_ehdr *UNUSED(ehdr), unsigned long r_type,
 	void *location, unsigned long address, unsigned long value)
 {
 #ifdef DEBUG
Index: kexec-tools/kexec/arch/ppc/kexec-ppc.c
===================================================================
--- kexec-tools.orig/kexec/arch/ppc/kexec-ppc.c	2010-02-01 23:07:08.000000000 +1100
+++ kexec-tools/kexec/arch/ppc/kexec-ppc.c	2010-02-01 23:07:16.000000000 +1100
@@ -23,8 +23,8 @@
 static struct memory_range memory_range[MAX_MEMORY_RANGES];
 
 /* Return a sorted list of memory ranges. */
-int get_memory_ranges(struct memory_range **range, int *ranges,
-					unsigned long kexec_flags)
+int get_memory_ranges(struct memory_range **UNUSED(range), int *UNUSED(ranges),
+		      unsigned long UNUSED(kexec_flags))
 {
 #ifdef WITH_GAMECUBE
 	int memory_ranges = 0;
@@ -83,12 +83,12 @@ const struct arch_map_entry arches[] = {
 	{ 0 },
 };
 
-int arch_compat_trampoline(struct kexec_info *info)
+int arch_compat_trampoline(struct kexec_info *UNUSED(info))
 {
 	return 0;
 }
 
-void arch_update_purgatory(struct kexec_info *info)
+void arch_update_purgatory(struct kexec_info *UNUSED(info))
 {
 }
 
Index: kexec-tools/kexec/arch/ppc/kexec-dol-ppc.c
===================================================================
--- kexec-tools.orig/kexec/arch/ppc/kexec-dol-ppc.c	2010-02-01 23:07:08.000000000 +1100
+++ kexec-tools/kexec/arch/ppc/kexec-dol-ppc.c	2010-02-01 23:07:16.000000000 +1100
@@ -316,7 +316,7 @@ void dol_ppc_usage(void)
 
 }
 
-int dol_ppc_load(int argc, char **argv, const char *buf, off_t len,
+int dol_ppc_load(int argc, char **argv, const char *buf, off_t UNUSED(len),
 	struct kexec_info *info)
 {
 	dol_header header, *h;
Index: kexec-tools/kexec/arch/ppc/kexec-elf-rel-ppc.c
===================================================================
--- kexec-tools.orig/kexec/arch/ppc/kexec-elf-rel-ppc.c	2010-02-01 23:07:08.000000000 +1100
+++ kexec-tools/kexec/arch/ppc/kexec-elf-rel-ppc.c	2010-02-01 23:07:16.000000000 +1100
@@ -17,7 +17,7 @@ int machine_verify_elf_rel(struct mem_eh
 	return 1;
 }
 
-void machine_apply_elf_rel(struct mem_ehdr *ehdr, unsigned long r_type,
+void machine_apply_elf_rel(struct mem_ehdr *UNUSED(ehdr), unsigned long r_type,
 	void *location, unsigned long address, unsigned long value)
 {
 	switch(r_type) {
Index: kexec-tools/purgatory/arch/ppc/console-ppc.c
===================================================================
--- kexec-tools.orig/purgatory/arch/ppc/console-ppc.c	2010-02-01 23:07:08.000000000 +1100
+++ kexec-tools/purgatory/arch/ppc/console-ppc.c	2010-02-01 23:07:16.000000000 +1100
@@ -1,5 +1,7 @@
 #include <purgatory.h>
-void putchar(int ch)
+#include "unused.h"
+
+void putchar(int UNUSED(ch))
 {
 	/* Nothing for now */
 }
Index: kexec-tools/purgatory/Makefile
===================================================================
--- kexec-tools.orig/purgatory/Makefile	2010-02-01 23:07:08.000000000 +1100
+++ kexec-tools/purgatory/Makefile	2010-02-01 23:07:16.000000000 +1100
@@ -53,6 +53,7 @@ $(PURGATORY): CPPFLAGS=$($(ARCH)_PURGATO
 			-I$(srcdir)/purgatory/include \
 			-I$(srcdir)/purgatory/arch/$(ARCH)/include \
 			-I$(srcdir)/util_lib/include \
+			-I$(srcdir)/include \
 			-I$(shell $(CC) -print-file-name=include)
 $(PURGATORY): LDFLAGS=$($(ARCH)_PURGATORY_EXTRA_CFLAGS)\
 			--no-undefined -nostartfiles -nostdlib -nodefaultlibs \
Index: kexec-tools/kexec/arch/ppc64/kexec-zImage-ppc64.c
===================================================================
--- kexec-tools.orig/kexec/arch/ppc64/kexec-zImage-ppc64.c	2010-02-01 23:07:08.000000000 +1100
+++ kexec-tools/kexec/arch/ppc64/kexec-zImage-ppc64.c	2010-02-01 23:07:16.000000000 +1100
@@ -63,8 +63,9 @@ int zImage_ppc64_probe(FILE *file)
 		elf.e_machine         == EM_PPC);
 }
 
-int zImage_ppc64_load(FILE *file, int argc, char **argv, void **ret_entry,
-	struct kexec_segment **ret_segments, int *ret_nr_segments)
+int zImage_ppc64_load(FILE *file, int UNUSED(argc), char **UNUSED(argv),
+		      void **ret_entry, struct kexec_segment **ret_segments,
+		      int *ret_nr_segments)
 {
 	Elf32_Ehdr elf;
 	Elf32_Phdr *p, *ph;
Index: kexec-tools/kexec/arch/ppc64/kexec-ppc64.c
===================================================================
--- kexec-tools.orig/kexec/arch/ppc64/kexec-ppc64.c	2010-02-01 23:07:08.000000000 +1100
+++ kexec-tools/kexec/arch/ppc64/kexec-ppc64.c	2010-02-01 23:07:16.000000000 +1100
@@ -804,11 +804,11 @@ const struct arch_map_entry arches[] = {
 	{ 0 },
 };
 
-int arch_compat_trampoline(struct kexec_info *info)
+int arch_compat_trampoline(struct kexec_info *UNUSED(info))
 {
 	return 0;
 }
 
-void arch_update_purgatory(struct kexec_info *info)
+void arch_update_purgatory(struct kexec_info *UNUSED(info))
 {
 }
Index: kexec-tools/kexec/arch/ia64/kexec-ia64.c
===================================================================
--- kexec-tools.orig/kexec/arch/ia64/kexec-ia64.c	2010-02-01 23:07:08.000000000 +1100
+++ kexec-tools/kexec/arch/ia64/kexec-ia64.c	2010-02-01 23:07:16.000000000 +1100
@@ -211,7 +211,7 @@ const struct arch_map_entry arches[] = {
 	{ 0 },
 };
 
-int arch_compat_trampoline(struct kexec_info *info)
+int arch_compat_trampoline(struct kexec_info *UNUSED(info))
 {
 	return 0;
 }
@@ -255,7 +255,7 @@ int update_loaded_segments(struct kexec_
 	return -1;
 }
 
-void arch_update_purgatory(struct kexec_info *info)
+void arch_update_purgatory(struct kexec_info *UNUSED(info))
 {
 }
 
Index: kexec-tools/kexec/kexec-iomem.c
===================================================================
--- kexec-tools.orig/kexec/kexec-iomem.c	2010-02-01 23:07:08.000000000 +1100
+++ kexec-tools/kexec/kexec-iomem.c	2010-02-01 23:07:16.000000000 +1100
@@ -64,7 +64,7 @@ int kexec_iomem_for_each_line(char *matc
 }
 
 static int kexec_iomem_single_callback(void *data, int nr,
-				       char *str,
+				       char *UNUSED(str),
 				       unsigned long base,
 				       unsigned long length)
 {
Index: kexec-tools/kexec/arch/s390/kexec-s390.c
===================================================================
--- kexec-tools.orig/kexec/arch/s390/kexec-s390.c	2010-02-01 23:07:08.000000000 +1100
+++ kexec-tools/kexec/arch/s390/kexec-s390.c	2010-02-01 23:07:16.000000000 +1100
@@ -36,7 +36,8 @@ static struct memory_range memory_range[
  *  - (-1) if something went wrong.
  */
 
-int get_memory_ranges(struct memory_range **range, int *ranges, unsigned long flags)
+int get_memory_ranges(struct memory_range **range, int *ranges,
+		      unsigned long UNUSED(flags))
 {
 	char sys_ram[] = "System RAM\n";
 	char *iomem = proc_iomem();
@@ -89,7 +90,7 @@ void arch_usage(void)
 {
 }
 
-int arch_process_options(int argc, char **argv)
+int arch_process_options(int UNUSED(argc), char **UNUSED(argv))
 {
 	return 0;
 }
@@ -100,12 +101,12 @@ const struct arch_map_entry arches[] = {
 	{ 0 },
 };
 
-int arch_compat_trampoline(struct kexec_info *info)
+int arch_compat_trampoline(struct kexec_info *UNUSED(info))
 {
 	return 0;
 }
 
-void arch_update_purgatory(struct kexec_info *info)
+void arch_update_purgatory(struct kexec_info *UNUSED(info))
 {
 }
 
Index: kexec-tools/kexec/arch/s390/kexec-elf-rel-s390.c
===================================================================
--- kexec-tools.orig/kexec/arch/s390/kexec-elf-rel-s390.c	2010-02-01 23:07:08.000000000 +1100
+++ kexec-tools/kexec/arch/s390/kexec-elf-rel-s390.c	2010-02-01 23:07:16.000000000 +1100
@@ -12,12 +12,15 @@
 #include "../../kexec.h"
 #include "../../kexec-elf.h"
 
-int machine_verify_elf_rel(struct mem_ehdr *ehdr)
+int machine_verify_elf_rel(struct mem_ehdr *UNUSED(ehdr))
 {
 	return 0;
 }
 
-void machine_apply_elf_rel(struct mem_ehdr *ehdr, unsigned long r_type,
-	void *location, unsigned long address, unsigned long value)
+void machine_apply_elf_rel(struct mem_ehdr *UNUSED(ehdr),
+			   unsigned long UNUSED(r_type),
+			   void *UNUSED(location),
+			   unsigned long UNUSED(address),
+			   unsigned long UNUSED(value))
 {
 }
Index: kexec-tools/kexec/arch/sh/kexec-sh.c
===================================================================
--- kexec-tools.orig/kexec/arch/sh/kexec-sh.c	2010-02-01 23:07:08.000000000 +1100
+++ kexec-tools/kexec/arch/sh/kexec-sh.c	2010-02-01 23:07:16.000000000 +1100
@@ -22,8 +22,8 @@
 #define MAX_MEMORY_RANGES 64
 static struct memory_range memory_range[MAX_MEMORY_RANGES];
 
-static int kexec_sh_memory_range_callback(void *data, int nr,
-					  char *str,
+static int kexec_sh_memory_range_callback(void *UNUSED(data), int nr,
+					  char *UNUSED(str),
 					  unsigned long base,
 					  unsigned long length)
 {
@@ -138,12 +138,12 @@ const struct arch_map_entry arches[] = {
 	{ 0 },
 };
 
-int arch_compat_trampoline(struct kexec_info *info)
+int arch_compat_trampoline(struct kexec_info *UNUSED(info))
 {
 	return 0;
 }
 
-void arch_update_purgatory(struct kexec_info *info)
+void arch_update_purgatory(struct kexec_info *UNUSED(info))
 {
 }
 
Index: kexec-tools/kexec/arch/sh/kexec-netbsd-sh.c
===================================================================
--- kexec-tools.orig/kexec/arch/sh/kexec-netbsd-sh.c	2010-02-01 23:07:08.000000000 +1100
+++ kexec-tools/kexec/arch/sh/kexec-netbsd-sh.c	2010-02-01 23:07:16.000000000 +1100
@@ -33,7 +33,7 @@ const extern unsigned char netbsd_booter
  *
  * Make sure that the file image has a reasonable chance of working.
  */
-int netbsd_sh_probe(const char *buf, off_t len)
+int netbsd_sh_probe(const char *buf, off_t UNUSED(len))
 {
 	Elf32_Ehdr *ehdr;
 
@@ -54,7 +54,7 @@ void netbsd_sh_usage(void)
 		" --miniroot=FILE      NetBSD miniroot ramdisk.\n\n");
 }
 
-int netbsd_sh_load(int argc, char **argv, const char *buf, off_t len,
+int netbsd_sh_load(int argc, char **argv, const char *buf, off_t UNUSED(len),
 	struct kexec_info *info)
 {
 	const char *howto, *miniroot;
Index: kexec-tools/kexec/arch/sh/kexec-elf-rel-sh.c
===================================================================
--- kexec-tools.orig/kexec/arch/sh/kexec-elf-rel-sh.c	2010-02-01 23:07:08.000000000 +1100
+++ kexec-tools/kexec/arch/sh/kexec-elf-rel-sh.c	2010-02-01 23:07:16.000000000 +1100
@@ -28,8 +28,8 @@ int machine_verify_elf_rel(struct mem_eh
 	return 1;
 }
 
-void machine_apply_elf_rel(struct mem_ehdr *ehdr, unsigned long r_type,
-	void *orig_loc, unsigned long address, unsigned long relocation)
+void machine_apply_elf_rel(struct mem_ehdr *UNUSED(ehdr), unsigned long r_type,
+	void *orig_loc, unsigned long UNUSED(address), unsigned long relocation)
 {
 	uint32_t *location = orig_loc;
 	uint32_t value;
Index: kexec-tools/kexec/arch/sh/crashdump-sh.c
===================================================================
--- kexec-tools.orig/kexec/arch/sh/crashdump-sh.c	2010-02-01 23:07:08.000000000 +1100
+++ kexec-tools/kexec/arch/sh/crashdump-sh.c	2010-02-01 23:07:16.000000000 +1100
@@ -34,7 +34,7 @@ static struct memory_range crash_memory_
 uint64_t saved_max_mem;
 
 static int crash_sh_range_nr;
-static int crash_sh_memory_range_callback(void *data, int nr,
+static int crash_sh_memory_range_callback(void *UNUSED(data), int UNUSED(nr),
 					  char *str,
 					  unsigned long base,
 					  unsigned long length)
Index: kexec-tools/kexec/arch/s390/kexec-image.c
===================================================================
--- kexec-tools.orig/kexec/arch/s390/kexec-image.c	2010-02-01 23:07:08.000000000 +1100
+++ kexec-tools/kexec/arch/s390/kexec-image.c	2010-02-01 23:07:16.000000000 +1100
@@ -119,7 +119,7 @@ image_s390_load(int argc, char **argv, c
 }
 
 int 
-image_s390_probe(const char *kernel_buf, off_t kernel_size)
+image_s390_probe(const char *UNUSED(kernel_buf), off_t UNUSED(kernel_size))
 {
 	/*
 	 * Can't reliably tell if an image is valid,
Index: kexec-tools/kexec/arch/arm/kexec-elf-rel-arm.c
===================================================================
--- kexec-tools.orig/kexec/arch/arm/kexec-elf-rel-arm.c	2010-02-01 23:07:08.000000000 +1100
+++ kexec-tools/kexec/arch/arm/kexec-elf-rel-arm.c	2010-02-01 23:07:16.000000000 +1100
@@ -18,7 +18,7 @@ int machine_verify_elf_rel(struct mem_eh
 	return 1;
 }
 
-void machine_apply_elf_rel(struct mem_ehdr *ehdr, unsigned long r_type,
+void machine_apply_elf_rel(struct mem_ehdr *UNUSED(ehdr), unsigned long r_type,
 	void *location, unsigned long address, unsigned long value)
 {
 	switch(r_type) {
Index: kexec-tools/kexec/arch/arm/kexec-zImage-arm.c
===================================================================
--- kexec-tools.orig/kexec/arch/arm/kexec-zImage-arm.c	2010-02-01 23:07:08.000000000 +1100
+++ kexec-tools/kexec/arch/arm/kexec-zImage-arm.c	2010-02-01 23:07:16.000000000 +1100
@@ -78,7 +78,7 @@ struct tag {
 #define byte_size(t)    ((t)->hdr.size << 2)
 #define tag_size(type)  ((sizeof(struct tag_header) + sizeof(struct type) + 3) >> 2)
 
-int zImage_arm_probe(const char *buf, off_t len)
+int zImage_arm_probe(const char *UNUSED(buf), off_t UNUSED(len))
 {
 	/* 
 	 * Only zImage loading is supported. Do not check if
Index: kexec-tools/kexec/arch/arm/kexec-arm.c
===================================================================
--- kexec-tools.orig/kexec/arch/arm/kexec-arm.c	2010-02-01 23:07:08.000000000 +1100
+++ kexec-tools/kexec/arch/arm/kexec-arm.c	2010-02-01 23:07:16.000000000 +1100
@@ -23,7 +23,7 @@ static struct memory_range memory_range[
 
 /* Return a sorted list of available memory ranges. */
 int get_memory_ranges(struct memory_range **range, int *ranges,
-		unsigned long kexec_flags)
+		unsigned long UNUSED(kexec_flags))
 {
 	const char *iomem = proc_iomem();
 	int memory_ranges = 0;
@@ -116,12 +116,12 @@ const struct arch_map_entry arches[] = {
 	{ 0 },
 };
 
-int arch_compat_trampoline(struct kexec_info *info)
+int arch_compat_trampoline(struct kexec_info *UNUSED(info))
 {
 	return 0;
 }
 
-void arch_update_purgatory(struct kexec_info *info)
+void arch_update_purgatory(struct kexec_info *UNUSED(info))
 {
 }
 
Index: kexec-tools/kexec/arch/mips/kexec-mips.c
===================================================================
--- kexec-tools.orig/kexec/arch/mips/kexec-mips.c	2010-02-01 23:07:08.000000000 +1100
+++ kexec-tools/kexec/arch/mips/kexec-mips.c	2010-02-01 23:07:16.000000000 +1100
@@ -26,7 +26,8 @@
 static struct memory_range memory_range[MAX_MEMORY_RANGES];
 
 /* Return a sorted list of memory ranges. */
-int get_memory_ranges(struct memory_range **range, int *ranges, unsigned long kexec_flags)
+int get_memory_ranges(struct memory_range **range, int *ranges,
+		      unsigned long UNUSED(kexec_flags))
 {
 	int memory_ranges = 0;
 
@@ -129,12 +130,12 @@ const struct arch_map_entry arches[] = {
 	{ 0 },
 };
 
-int arch_compat_trampoline(struct kexec_info *info)
+int arch_compat_trampoline(struct kexec_info *UNUSED(info))
 {
 	return 0;
 }
 
-void arch_update_purgatory(struct kexec_info *info)
+void arch_update_purgatory(struct kexec_info *UNUSED(info))
 {
 }
 
Index: kexec-tools/purgatory/arch/mips/console-mips.c
===================================================================
--- kexec-tools.orig/purgatory/arch/mips/console-mips.c	2010-02-01 23:07:08.000000000 +1100
+++ kexec-tools/purgatory/arch/mips/console-mips.c	2010-02-01 23:07:16.000000000 +1100
@@ -1,5 +1,7 @@
 #include <purgatory.h>
-void putchar(int ch)
+#include "unused.h"
+
+void putchar(int UNUSED(ch))
 {
 	/* Nothing for now */
 }
Index: kexec-tools/kexec/arch/cris/kexec-cris.c
===================================================================
--- kexec-tools.orig/kexec/arch/cris/kexec-cris.c	2010-02-01 23:07:08.000000000 +1100
+++ kexec-tools/kexec/arch/cris/kexec-cris.c	2010-02-01 23:07:16.000000000 +1100
@@ -23,7 +23,8 @@
 static struct memory_range memory_range[MAX_MEMORY_RANGES];
 
 /* Return a sorted list of memory ranges. */
-int get_memory_ranges(struct memory_range **range, int *ranges, unsigned long kexec_flags)
+int get_memory_ranges(struct memory_range **range, int *ranges,
+		      unsigned long UNUSED(kexec_flags))
 {
 	int memory_ranges = 0;
 
@@ -79,12 +80,12 @@ const struct arch_map_entry arches[] = {
 	{ 0 },
 };
 
-int arch_compat_trampoline(struct kexec_info *info)
+int arch_compat_trampoline(struct kexec_info *UNUSED(info))
 {
 	return 0;
 }
 
-void arch_update_purgatory(struct kexec_info *info)
+void arch_update_purgatory(struct kexec_info *UNUSED(info))
 {
 }
 
Index: kexec-tools/kexec/arch/mips/kexec-elf-rel-mips.c
===================================================================
--- kexec-tools.orig/kexec/arch/mips/kexec-elf-rel-mips.c	2010-02-01 23:07:08.000000000 +1100
+++ kexec-tools/kexec/arch/mips/kexec-elf-rel-mips.c	2010-02-01 23:07:16.000000000 +1100
@@ -29,8 +29,10 @@ int machine_verify_elf_rel(struct mem_eh
 	return 1;
 }
 
-void machine_apply_elf_rel(struct mem_ehdr *ehdr, unsigned long r_type,
-	void *location, unsigned long address, unsigned long value)
+void machine_apply_elf_rel(struct mem_ehdr *UNUSED(ehdr), unsigned long r_type,
+			   void *UNUSED(location),
+			   unsigned long UNUSED(address),
+			   unsigned long UNUSED(value))
 {
 	switch(r_type) {
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
