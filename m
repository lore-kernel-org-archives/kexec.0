Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NheBH-0001K7-09
	for kexec@lists.infradead.org; Wed, 17 Feb 2010 07:18:48 +0000
Date: Wed, 17 Feb 2010 18:18:39 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: FYI: x86_64 bug when using gdb with vmcore
Message-ID: <20100217071839.GB27742@verge.net.au>
References: <539140123.1108061265388145735.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
	<773792816.1109361265388798774.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <773792816.1109361265388798774.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
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
To: Dave Anderson <anderson@redhat.com>
Cc: kexec@lists.infradead.org

On Fri, Feb 05, 2010 at 11:53:18AM -0500, Dave Anderson wrote:
> 
> The kexec/arch/x86_64/crashdump-x86_64.h file contains a
> stale PAGE_OFFSET value.  In 2.6.27 it was changed from
> 0xffff810000000000UL to 0xffff880000000000UL.  This is
> only a problem when using gdb with the vmlinux/vmcore
> pair, because gdb relies upon the PT_LOAD segment's p_vaddr
> values in the ELF header to be correct.
> 
> Anyway, in the RHEL6 kexec-tools, this simple patch 
> was made:
> 
> -#define PAGE_OFFSET            0xffff810000000000UL
> +#define PAGE_OFFSET            0xffff880000000000UL
> 
> which is OK since the RHEL6 version of kexec-tools
> will only be used with RHEL6 kernels.  
> 
> But for backwards compatibility, the better way to do 
> it would be to check the utsname of the running kernel, 
> and use the right value.
> 
> But again, this is only required for gdb usage.  The 
> crash utility (and makedumpfile) make kernel version checks 
> to determine which x86_64 PAGE_OFFSET value is applicable,
> and don't rely on the ELF header p_vaddr values for
> the unity-mapped regions.  

Hi Dave,

Something like this?

----------------------------------------------------------------------

x86_64: use correct PAGE_OFFSET

This fixes a bug when using gdb with vmcore
as explained by Dave Anderson:

The kexec/arch/x86_64/crashdump-x86_64.h file contains a
stale PAGE_OFFSET value.  In 2.6.27 it was changed from
0xffff810000000000UL to 0xffff880000000000UL.  This is
only a problem when using gdb with the vmlinux/vmcore
pair, because gdb relies upon the PT_LOAD segment's p_vaddr
values in the ELF header to be correct.

Cc: Dave Anderson <anderson@redhat.com>
Signed-off-by: Simon Horman <horms@verge.net.au>

Index: kexec-tools/kexec/arch/x86_64/crashdump-x86_64.c
===================================================================
--- kexec-tools.orig/kexec/arch/x86_64/crashdump-x86_64.c	2010-02-17 16:04:18.000000000 +1100
+++ kexec-tools/kexec/arch/x86_64/crashdump-x86_64.c	2010-02-17 16:18:42.000000000 +1100
@@ -36,15 +36,6 @@
 #include "crashdump-x86_64.h"
 #include <x86/x86-linux.h>
 
-static struct crash_elf_info elf_info =
-{
-	class: ELFCLASS64,
-	data: ELFDATA2LSB,
-	machine: EM_X86_64,
-	backup_src_start: BACKUP_SRC_START,
-	backup_src_end: BACKUP_SRC_END,
-	page_offset: PAGE_OFFSET,
-};
 
 /* Forward Declaration. */
 static int exclude_region(int *nr_ranges, uint64_t start, uint64_t end);
@@ -604,6 +595,16 @@ int load_crashdump_segments(struct kexec
 	int nr_ranges, align = 1024, i;
 	struct memory_range *mem_range, *memmap_p;
 
+	struct crash_elf_info elf_info =
+	{
+		class: ELFCLASS64,
+		data: ELFDATA2LSB,
+		machine: EM_X86_64,
+		backup_src_start: BACKUP_SRC_START,
+		backup_src_end: BACKUP_SRC_END,
+		page_offset: page_offset,
+	};
+
 	if (get_kernel_paddr(info))
 		return -1;
 
Index: kexec-tools/kexec/arch/x86_64/crashdump-x86_64.h
===================================================================
--- kexec-tools.orig/kexec/arch/x86_64/crashdump-x86_64.h	2010-02-17 16:04:18.000000000 +1100
+++ kexec-tools/kexec/arch/x86_64/crashdump-x86_64.h	2010-02-17 17:41:10.000000000 +1100
@@ -1,12 +1,16 @@
 #ifndef CRASHDUMP_X86_64_H
 #define CRASHDUMP_X86_64_H
 
+#include "../../kexec.h"
+
 int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline,
 				unsigned long max_addr, unsigned long min_base);
 
 #define __START_KERNEL_map      0xffffffff80000000UL
-#define PAGE_OFFSET		0xffff810000000000UL
-#define __pa(x)                 (((unsigned long)(x)>=__START_KERNEL_map)?(unsigned long)(x) - (unsigned long)__START_KERNEL_map:(unsigned long)(x) - PAGE_OFFSET)
+
+extern unsigned long page_offset;
+
+#define __pa(x)                 (((unsigned long)(x)>=__START_KERNEL_map)?(unsigned long)(x) - (unsigned long)__START_KERNEL_map:(unsigned long)(x) - page_offset)
 
 #define MAXMEM           0x3fffffffffffUL
 
Index: kexec-tools/kexec/kexec.c
===================================================================
--- kexec-tools.orig/kexec/kexec.c	2010-02-17 16:04:18.000000000 +1100
+++ kexec-tools/kexec/kexec.c	2010-02-17 16:11:06.000000000 +1100
@@ -1041,6 +1041,8 @@ int main(int argc, char *argv[])
 	};
 	static const char short_options[] = KEXEC_OPT_STR;
 
+	arch_init();
+
 	opterr = 0; /* Don't complain about unrecognized options here */
 	while ((opt = getopt_long(argc, argv, short_options,
 				  options, 0)) != -1) {
Index: kexec-tools/kexec/Makefile
===================================================================
--- kexec-tools.orig/kexec/Makefile	2010-02-17 16:06:32.000000000 +1100
+++ kexec-tools/kexec/Makefile	2010-02-17 16:11:11.000000000 +1100
@@ -44,6 +44,8 @@ $(ARCH)_ADD_BUFFER		= kexec/add_buffer.c
 KEXEC_SRCS += $($(ARCH)_ADD_BUFFER)
 $(ARCH)_ARCH_REUSE_INITRD	= kexec/arch_reuse_initrd.c
 KEXEC_SRCS += $($(ARCH)_ARCH_REUSE_INITRD)
+$(ARCH)_ARCH_INIT		= kexec/arch_init.c
+KEXEC_SRCS += $($(ARCH)_ARCH_INIT)
 
 include $(srcdir)/kexec/arch/alpha/Makefile
 include $(srcdir)/kexec/arch/arm/Makefile
Index: kexec-tools/kexec/arch/x86_64/Makefile
===================================================================
--- kexec-tools.orig/kexec/arch/x86_64/Makefile	2010-02-17 17:33:59.000000000 +1100
+++ kexec-tools/kexec/arch/x86_64/Makefile	2010-02-17 17:36:22.000000000 +1100
@@ -13,6 +13,8 @@ x86_64_KEXEC_SRCS += kexec/arch/x86_64/k
 x86_64_KEXEC_SRCS += kexec/arch/x86_64/kexec-elf-x86_64.c
 x86_64_KEXEC_SRCS += kexec/arch/x86_64/kexec-elf-rel-x86_64.c
 
+x86_64_ARCH_INIT = kexec/arch/x86_64/arch_init.c
+
 dist += kexec/arch/x86_64/Makefile $(x86_64_KEXEC_SRCS)			\
 	kexec/arch/x86_64/kexec-x86_64.h kexec/arch/x86_64/crashdump-x86_64.h \
 	kexec/arch/x86_64/include/arch/options.h
Index: kexec-tools/kexec/arch/x86_64/arch_init.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kexec-tools/kexec/arch/x86_64/arch_init.c	2010-02-17 18:06:52.000000000 +1100
@@ -0,0 +1,83 @@
+#include <errno.h>
+#include <string.h>
+#include <sys/utsname.h>
+#include <stdlib.h>
+#include <limits.h>
+#include <stdio.h>
+
+#include "crashdump-x86_64.h"
+
+#define KERNEL_VERSION(major, minor, patch) \
+	(((major) << 16) | ((minor) << 8) | patch)
+
+long kernel_version(void)
+{
+	struct utsname utsname;
+	unsigned long major, minor, patch;
+	char *p;
+
+	if (uname(&utsname) < 0) {
+		fprintf(stderr, "uname failed: %s\n", strerror(errno));
+		return -1;
+	}
+
+	p = utsname.release;
+	major = strtoul(p, &p, 10);
+	if (major == ULONG_MAX) {
+		fprintf(stderr, "strtoul failed: %s\n", strerror(errno));
+		return -1;
+	}
+
+	if (*p++ != '.') {
+		fprintf(stderr, "Unsupported utsname.release: %s\n",
+			utsname.release);
+		return -1;
+	}
+
+	minor = strtoul(p, &p, 10);
+	if (major == ULONG_MAX) {
+		fprintf(stderr, "strtoul failed: %s\n", strerror(errno));
+		return -1;
+	}
+
+	if (*p++ != '.') {
+		fprintf(stderr, "Unsupported utsname.release: %s\n",
+			utsname.release);
+		return -1;
+	}
+
+	patch = strtoul(p, &p, 10);
+	if (major == ULONG_MAX) {
+		fprintf(stderr, "strtoul failed: %s\n", strerror(errno));
+		return -1;
+	}
+
+	if (major >= 256 || minor >= 256 || patch >= 256) {
+		fprintf(stderr, "Unsupported utsname.release: %s\n",
+			utsname.release);
+		return -1;
+	}
+
+	return KERNEL_VERSION(major, minor, patch);
+}
+
+#define PAGE_OFFSET_PRE_2_6_27	0xffff810000000000UL
+#define PAGE_OFFSET		0xffff880000000000UL
+
+unsigned long page_offset;
+
+int arch_init(void)
+{
+	int kv;
+
+	kv = kernel_version();
+	if (kv < 0)
+		return -1;
+
+	if (kv < KERNEL_VERSION(2, 4, 27))
+		page_offset = PAGE_OFFSET_PRE_2_6_27;
+	else
+		page_offset = PAGE_OFFSET;
+
+	return 0;
+}
Index: kexec-tools/kexec/arch_init.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kexec-tools/kexec/arch_init.c	2010-02-17 16:12:14.000000000 +1100
@@ -0,0 +1,4 @@
+int arch_init(void)
+{
+	return 0;
+}
Index: kexec-tools/kexec/kexec.h
===================================================================
--- kexec-tools.orig/kexec/kexec.h	2010-02-17 16:12:44.000000000 +1100
+++ kexec-tools/kexec/kexec.h	2010-02-17 16:13:03.000000000 +1100
@@ -249,6 +249,8 @@ int kexec_iomem_for_each_line(char *matc
 int parse_iomem_single(char *str, uint64_t *start, uint64_t *end);
 const char * proc_iomem(void);
 
+int arch_init(void);
+
 extern int add_backup_segments(struct kexec_info *info,
 			       unsigned long backup_base,
 			       unsigned long backup_size);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
