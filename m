Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp07.in.ibm.com ([122.248.162.7])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RnST7-0006t4-B3
 for kexec@lists.infradead.org; Wed, 18 Jan 2012 10:10:15 +0000
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <suzuki@in.ibm.com>;
 Wed, 18 Jan 2012 15:40:08 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q0IAA4ei4268126
 for <kexec@lists.infradead.org>; Wed, 18 Jan 2012 15:40:04 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q0IAA3CN010134
 for <kexec@lists.infradead.org>; Wed, 18 Jan 2012 21:10:04 +1100
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH v1 3/3] [makedumpfile] Add support for PPC32
Date: Wed, 18 Jan 2012 15:40:03 +0530
Message-ID: <20120118100949.29422.17463.stgit@suzukikp.in.ibm.com>
In-Reply-To: <20120118100510.29422.93587.stgit@suzukikp.in.ibm.com>
References: <20120118100510.29422.93587.stgit@suzukikp.in.ibm.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: tachibana@mxm.nes.nec.co.jp, usui@mxm.nes.nec.co.jp
Cc: kexec@lists.infradead.org

Mostly a copy of ppc64 with renaming to _ppc variants.

Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
---

 Makefile       |   11 ++++--
 arch/ppc.c     |  101 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 makedumpfile.c |    4 +-
 makedumpfile.h |   24 ++++++++++++-
 4 files changed, 133 insertions(+), 7 deletions(-)
 create mode 100644 arch/ppc.c

diff --git a/Makefile b/Makefile
index 04e267f..677cc8c 100644
--- a/Makefile
+++ b/Makefile
@@ -24,7 +24,7 @@ endif
 ARCH := $(shell echo ${TARGET}  | sed -e s/i.86/x86/ -e s/sun4u/sparc64/ \
 			       -e s/arm.*/arm/ -e s/sa110/arm/ \
 			       -e s/s390x/s390/ -e s/parisc64/parisc/ \
-			       -e s/ppc64/powerpc64/ )
+			       -e s/ppc64/powerpc64/ -e s/ppc/powerpc32/)
 
 CFLAGS += -D__$(ARCH)__
 CFLAGS_ARCH += -D__$(ARCH)__
@@ -34,11 +34,16 @@ CFLAGS += -m64
 CFLAGS_ARCH += -m64
 endif
 
+ifeq ($(ARCH), powerpc32)
+CFLAGS += -m32
+CFLAGS_ARCH += -m32
+endif
+
 SRC	= makedumpfile.c makedumpfile.h diskdump_mod.h sadump_mod.h sadump_info.h
 SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c
 OBJ_PART = print_info.o dwarf_info.o elf_info.o erase_info.o sadump_info.o
-SRC_ARCH = arch/arm.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c arch/s390x.c
-OBJ_ARCH = arch/arm.o arch/x86.o arch/x86_64.o arch/ia64.o arch/ppc64.o arch/s390x.o
+SRC_ARCH = arch/arm.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c arch/s390x.c arch/ppc.c
+OBJ_ARCH = arch/arm.o arch/x86.o arch/x86_64.o arch/ia64.o arch/ppc64.o arch/s390x.o arch/ppc.o
 
 all: makedumpfile
 
diff --git a/arch/ppc.c b/arch/ppc.c
new file mode 100644
index 0000000..2bc8d5f
--- /dev/null
+++ b/arch/ppc.c
@@ -0,0 +1,101 @@
+/*
+ * ppc.c
+ *
+ * Created by: Suzuki K. Poulose <suzuki@in.ibm.com>
+ *  - Based on ppc64 implementation
+ * Copyright (C) IBM Corporation, 2012. All rights reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation (version 2 of the License).
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifdef __powerpc32__
+
+#include "../print_info.h"
+#include "../elf_info.h"
+#include "../makedumpfile.h"
+
+int
+get_machdep_info_ppc(void)
+{
+	unsigned long vmlist, vmalloc_start;
+
+	info->section_size_bits = _SECTION_SIZE_BITS;
+	info->max_physmem_bits  = _MAX_PHYSMEM_BITS;
+	info->page_offset = __PAGE_OFFSET;
+
+	if (SYMBOL(_stext) != NOT_FOUND_SYMBOL)
+		info->kernel_start = SYMBOL(_stext);
+	else {
+		ERRMSG("Can't get the symbol of _stext.\n");
+		return FALSE;
+	}
+		
+	DEBUG_MSG("kernel_start : %lx\n", info->kernel_start);
+
+	/*
+	 * For the compatibility, makedumpfile should run without the symbol
+	 * vmlist and the offset of vm_struct.addr if they are not necessary.
+	 */
+	if ((SYMBOL(vmlist) == NOT_FOUND_SYMBOL)
+	    || (OFFSET(vm_struct.addr) == NOT_FOUND_STRUCTURE)) {
+		return TRUE;
+	}
+	if (!readmem(VADDR, SYMBOL(vmlist), &vmlist, sizeof(vmlist))) {
+		ERRMSG("Can't get vmlist.\n");
+		return FALSE;
+	}
+	if (!readmem(VADDR, vmlist + OFFSET(vm_struct.addr), &vmalloc_start,
+	    sizeof(vmalloc_start))) {
+		ERRMSG("Can't get vmalloc_start.\n");
+		return FALSE;
+	}
+	info->vmalloc_start = vmalloc_start;
+	DEBUG_MSG("vmalloc_start: %lx\n", vmalloc_start);
+
+	return TRUE;
+}
+
+int
+is_vmalloc_addr_ppc(unsigned long vaddr)
+{
+	return (info->vmalloc_start && vaddr >= info->vmalloc_start);
+}
+
+unsigned long long
+vaddr_to_paddr_ppc(unsigned long vaddr)
+{
+	unsigned long *pgd, *pmd;
+	unsigned long long pte;
+	unsigned long long paddr;
+
+	paddr = vaddr_to_paddr_general(vaddr);
+	if (paddr != NOT_PADDR)
+		return paddr;
+
+	if ((SYMBOL(vmlist) == NOT_FOUND_SYMBOL)
+	    || (OFFSET(vm_struct.addr) == NOT_FOUND_STRUCTURE)) {
+		ERRMSG("Can't get necessary information for vmalloc translation.\n");
+		return NOT_PADDR;
+	}
+	if (!is_vmalloc_addr_ppc(vaddr))
+		return (vaddr - info->kernel_start);
+
+	/*
+	 * TODO: Support vmalloc translation.
+	 */
+	ERRMSG("This makedumpfile does not support vmalloc translation.\n");
+	return NOT_PADDR;
+}
+
+#endif /* powerpc32 */
diff --git a/makedumpfile.c b/makedumpfile.c
index 101f8b5..cefb7cf 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5691,9 +5691,9 @@ initial_xen(void)
 	off_t offset;
 	unsigned long size;
 
-#ifdef __powerpc64__
+#if defined(__powerpc64__) || defined(__powerpc32__)
 	MSG("\n");
-	MSG("ppc64 xen is not supported.\n");
+	MSG("xen is not supported on powerpc.\n");
 	return FALSE;
 #else
 	if(!info->flag_elf_dumpfile) {
diff --git a/makedumpfile.h b/makedumpfile.h
index efa325f..1329271 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -530,6 +530,17 @@ do { \
 #define _MAX_PHYSMEM_BITS	(44)
 #endif
 
+#ifdef __powerpc32__
+
+#define __PAGE_OFFSET		(0xc0000000)
+#define KERNELBASE		PAGE_OFFSET
+#define VMALL_START     	(info->vmalloc_start)
+#define KVBASE			(SYMBOL(_stext))
+#define _SECTION_SIZE_BITS	(24)
+#define _MAX_PHYSMEM_BITS	(44)
+
+#endif
+
 #ifdef __s390x__
 #define __PAGE_OFFSET		(info->page_size - 1)
 #define KERNELBASE		(0)
@@ -667,6 +678,15 @@ unsigned long long vaddr_to_paddr_ppc64(unsigned long vaddr);
 #define vaddr_to_paddr(X)	vaddr_to_paddr_ppc64(X)
 #endif          /* powerpc64 */
 
+#ifdef __powerpc32__ /* powerpc32 */
+int get_machdep_info_ppc(void);
+unsigned long long vaddr_to_paddr_ppc(unsigned long vaddr);
+#define get_phys_base()		TRUE
+#define get_machdep_info()	get_machdep_info_ppc()
+#define get_versiondep_info()	TRUE
+#define vaddr_to_paddr(X)	vaddr_to_paddr_ppc(X)
+#endif          /* powerpc */
+
 #ifdef __s390x__ /* s390x */
 int get_machdep_info_s390x(void);
 unsigned long long vaddr_to_paddr_s390x(unsigned long vaddr);
@@ -1332,10 +1352,10 @@ int get_xen_info_ia64(void);
 
 #endif	/* __ia64 */
 
-#ifdef __powerpc64__ /* powerpc64 */
+#if defined(__powerpc64__) || defined(__powerpc32__) /* powerpcXX */
 #define kvtop_xen(X)	FALSE
 #define get_xen_info_arch(X) FALSE
-#endif	/* powerpc64 */
+#endif	/* powerpcXX */
 
 #ifdef __s390x__ /* s390x */
 #define kvtop_xen(X)	FALSE


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
