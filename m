Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns1.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K3JSd-0000dO-Bw
	for kexec@lists.infradead.org; Mon, 02 Jun 2008 23:29:11 +0000
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 59E95414A0
	for <kexec@lists.infradead.org>; Tue,  3 Jun 2008 01:29:05 +0200 (CEST)
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] Implement support for mem command line parameter
Date: Tue,  3 Jun 2008 01:29:44 +0200
Message-Id: <1212449384-22819-1-git-send-email-bwalle@suse.de>
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
Cc: Bernhard Walle <bwalle@suse.de>

When the kernel is booted with the "mem" kernel command line (see
Documentation/kernel-parameters.txt of kernel source tree), the /proc/iomem
is not modified. Instead, it shows the whole memory space as "System RAM".
I consider that as correct because the file is named "iomem", and for I/O,
the behaviour makes sense.

However, when the kernel is booted with the "mem" parameter, the user expects
the crashdump to be as small as the system memory, not containing the whole
unused system RAM. To implement this, there are several options:

 1. Modify /proc/iomem.
 2. Add a new /proc/iomem_used or something like that, i.e. a new kernel
    interface.
 3. Parse /proc/meminfo to read the system RAM.
 4. Parse /proc/cmdline to read the command line.

I choosed the 4th possibility because of several reasons.

 - The /proc/iomem interface should be stable and not modified. That may break
   other stuff we don't know. It may also be difficult to convince kernel
   maintainers.
 - We should not add yet another interface between kernel and userspace for
   a feature 99 % of the people don't need and don't even know about.

The semantics of mem is different on different architectures. i386 and x86_64
(x86) treat the limit specified on the command line as physical address limit
while IA64 count the real memory. That is because of different practises of
memory mapping on PC architecture vs. "new" architectures.

However, on x86 (which that implementation covers) it's most easy to read
the /proc/cmdline and the mem parameter. That parameter should be very stable
since bootloaders need to parse it, so no fancy features are likely to be
added in future. So we can use that.

The new function limit_system_memory() now reads the memory map kexec built for
ELF core headers and limits it to (for mem=X) X bytes physical address space.
All other memory map entries are moved so that no ACPI or otherwise reserved
ranges behind that limit are lost.

Also, the mem parameter is removed when --reuse-cmdline is used in that case.
If no mem parameter is specified, that implementation should do nothing.

Signed-off-by: Bernhard Walle <bwalle@suse.de>
---
 kexec/arch/i386/Makefile               |    1 +
 kexec/arch/i386/crashdump-x86-common.c |   77 +++++++++++++++++++++++++++++
 kexec/arch/i386/crashdump-x86.c        |    3 +
 kexec/arch/i386/kexec-bzImage.c        |    2 +-
 kexec/arch/i386/kexec-elf-x86.c        |    2 +-
 kexec/arch/i386/kexec-multiboot-x86.c  |    2 +-
 kexec/arch/i386/kexec-x86.h            |    3 +
 kexec/arch/x86_64/Makefile             |    1 +
 kexec/arch/x86_64/crashdump-x86_64.c   |    3 +
 kexec/arch/x86_64/kexec-elf-x86_64.c   |    2 +-
 kexec/kexec.c                          |   84 +++++++++++++++++++++++++++++--
 kexec/kexec.h                          |    3 +-
 12 files changed, 172 insertions(+), 11 deletions(-)
 create mode 100644 kexec/arch/i386/crashdump-x86-common.c

diff --git a/kexec/arch/i386/Makefile b/kexec/arch/i386/Makefile
index f2d9636..d166730 100644
--- a/kexec/arch/i386/Makefile
+++ b/kexec/arch/i386/Makefile
@@ -10,6 +10,7 @@ i386_KEXEC_SRCS += kexec/arch/i386/kexec-beoboot-x86.c
 i386_KEXEC_SRCS += kexec/arch/i386/kexec-nbi.c
 i386_KEXEC_SRCS += kexec/arch/i386/x86-linux-setup.c
 i386_KEXEC_SRCS += kexec/arch/i386/crashdump-x86.c
+i386_KEXEC_SRCS += kexec/arch/i386/crashdump-x86-common.c
 
 dist += kexec/arch/i386/Makefile $(i386_KEXEC_SRCS)			\
 	kexec/arch/i386/kexec-x86.h kexec/arch/i386/crashdump-x86.h	\
diff --git a/kexec/arch/i386/crashdump-x86-common.c b/kexec/arch/i386/crashdump-x86-common.c
new file mode 100644
index 0000000..146856e
--- /dev/null
+++ b/kexec/arch/i386/crashdump-x86-common.c
@@ -0,0 +1,77 @@
+/*
+ * kexec: Linux boots Linux
+ *
+ * Created by: Bernhard Walle (bwalle@suse.de)
+ * Copyright (c) 2008 SUSE LINUX Products GmbH
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
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <limits.h>
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include "../../kexec.h"
+#include <x86/x86-linux.h>
+
+/*
+ * Takes a memory map as parameter and limits the memory ranges to have
+ * a maximal physical address of the system memory limit of the kernel
+ * command line. That's the semantics of the 'mem=' parameter on x86.
+ *
+ * Other architectures need a different implementation because they have
+ * a different semantics of the mem= parameter. For example, IA64 counts
+ * the memory and doesn't take it as physical address.
+ *
+ * However, using the mem parameter is most common on x86 since it is possibe
+ * to work around some bugs ...
+ */
+void limit_system_memory(struct memory_range *mem_ranges, int *num_ranges)
+{
+	unsigned long long limit = get_memory_limit();
+	int i;
+
+	if (!mem_ranges || !num_ranges) {
+		fprintf(stderr, "Called limit_system_memory with invalid "
+			"parameters.");
+		return;
+	}
+
+	if (limit == ULLONG_MAX)
+		return;
+
+	for (i = 0; i < *num_ranges; i++) {
+		struct memory_range *range = &mem_ranges[i];
+
+		if (range->type != RANGE_RAM)
+			continue;
+
+		if (range->start >= limit) {
+			/* just move */
+			memmove(mem_ranges + sizeof(struct memory_range) * i,
+				mem_ranges + sizeof(struct memory_range) * (i+1),
+				*num_ranges - (i+1));
+			(*num_ranges)--;
+
+		} else if (range->end >= limit) {
+			/* adjust and let the next run move */
+			range->end -= range->end - limit;
+		}
+	}
+}
+
diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 7717219..cb0d562 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -128,6 +128,9 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 		}
 	}
 	fclose(fp);
+
+	limit_system_memory(crash_memory_range, &memory_ranges);
+
 	if (exclude_crash_reserve_region(&memory_ranges) < 0)
 		return -1;
 	*range = crash_memory_range;
diff --git a/kexec/arch/i386/kexec-bzImage.c b/kexec/arch/i386/kexec-bzImage.c
index 1f40076..9a4b0a4 100644
--- a/kexec/arch/i386/kexec-bzImage.c
+++ b/kexec/arch/i386/kexec-bzImage.c
@@ -378,7 +378,7 @@ int bzImage_load(int argc, char **argv, const char *buf, off_t len,
 			command_line = optarg;
 			break;
 		case OPT_REUSE_CMDLINE:
-			command_line = get_command_line();
+			command_line = get_command_line(1);
 			break;
 		case OPT_RAMDISK:
 			ramdisk = optarg;
diff --git a/kexec/arch/i386/kexec-elf-x86.c b/kexec/arch/i386/kexec-elf-x86.c
index ddd4a10..4961cee 100644
--- a/kexec/arch/i386/kexec-elf-x86.c
+++ b/kexec/arch/i386/kexec-elf-x86.c
@@ -142,7 +142,7 @@ int elf_x86_load(int argc, char **argv, const char *buf, off_t len,
 			command_line = optarg;
 			break;
 		case OPT_REUSE_CMDLINE:
-			command_line = get_command_line();
+			command_line = get_command_line(1);
 			break;
 		case OPT_RAMDISK:
 			ramdisk = optarg;
diff --git a/kexec/arch/i386/kexec-multiboot-x86.c b/kexec/arch/i386/kexec-multiboot-x86.c
index 9b41698..ed4d659 100644
--- a/kexec/arch/i386/kexec-multiboot-x86.c
+++ b/kexec/arch/i386/kexec-multiboot-x86.c
@@ -198,7 +198,7 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
 			command_line = optarg;
 			break;
 		case OPT_REUSE_CMDLINE:
-			command_line = get_command_line();
+			command_line = get_command_line(1);
 			break;
 		case OPT_MOD:
 			modules++;
diff --git a/kexec/arch/i386/kexec-x86.h b/kexec/arch/i386/kexec-x86.h
index 36ed9d5..62e2bc1 100644
--- a/kexec/arch/i386/kexec-x86.h
+++ b/kexec/arch/i386/kexec-x86.h
@@ -81,4 +81,7 @@ int nbi_probe(const char *buf, off_t len);
 int nbi_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info);
 void nbi_usage(void);
+
+void limit_system_memory(struct memory_range *mem_ranges, int *num_ranges);
+
 #endif /* KEXEC_X86_H */
diff --git a/kexec/arch/x86_64/Makefile b/kexec/arch/x86_64/Makefile
index c59c41f..f2f5541 100644
--- a/kexec/arch/x86_64/Makefile
+++ b/kexec/arch/x86_64/Makefile
@@ -7,6 +7,7 @@ x86_64_KEXEC_SRCS += kexec/arch/i386/kexec-multiboot-x86.c
 x86_64_KEXEC_SRCS += kexec/arch/i386/kexec-beoboot-x86.c
 x86_64_KEXEC_SRCS += kexec/arch/i386/kexec-nbi.c
 x86_64_KEXEC_SRCS += kexec/arch/i386/x86-linux-setup.c
+x86_64_KEXEC_SRCS += kexec/arch/i386/crashdump-x86-common.c
 x86_64_KEXEC_SRCS += kexec/arch/x86_64/crashdump-x86_64.c
 x86_64_KEXEC_SRCS += kexec/arch/x86_64/kexec-x86_64.c
 x86_64_KEXEC_SRCS += kexec/arch/x86_64/kexec-elf-x86_64.c
diff --git a/kexec/arch/x86_64/crashdump-x86_64.c b/kexec/arch/x86_64/crashdump-x86_64.c
index 639ba48..631b9fd 100644
--- a/kexec/arch/x86_64/crashdump-x86_64.c
+++ b/kexec/arch/x86_64/crashdump-x86_64.c
@@ -233,6 +233,9 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 		memory_ranges++;
 	}
 	fclose(fp);
+
+	limit_system_memory(crash_memory_range, &memory_ranges);
+
 	if (exclude_crash_reserve_region(&memory_ranges) < 0)
 		return -1;
 	*range = crash_memory_range;
diff --git a/kexec/arch/x86_64/kexec-elf-x86_64.c b/kexec/arch/x86_64/kexec-elf-x86_64.c
index 1bb054a..a90eefa 100644
--- a/kexec/arch/x86_64/kexec-elf-x86_64.c
+++ b/kexec/arch/x86_64/kexec-elf-x86_64.c
@@ -142,7 +142,7 @@ int elf_x86_64_load(int argc, char **argv, const char *buf, off_t len,
 			command_line = optarg;
 			break;
 		case OPT_REUSE_CMDLINE:
-			command_line = get_command_line();
+			command_line = get_command_line(1);
 			break;
 		case OPT_RAMDISK:
 			ramdisk = optarg;
diff --git a/kexec/kexec.c b/kexec/kexec.c
index 1550d68..0a8ed32 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -24,6 +24,7 @@
 #include <stdarg.h>
 #include <string.h>
 #include <stdlib.h>
+#include <limits.h>
 #include <errno.h>
 #include <limits.h>
 #include <sys/types.h>
@@ -853,7 +854,7 @@ static void remove_parameter(char *line, const char *param_name)
  *
  * The function returns dynamically allocated memory.
  */
-char *get_command_line(void)
+char *get_command_line(int filtered)
 {
 	FILE *fp;
 	size_t len;
@@ -869,19 +870,90 @@ char *get_command_line(void)
 		/* strip newline */
 		*(line + strlen(line) - 1) = 0;
 
-		remove_parameter(line, "crashkernel");
-		if (kexec_flags & KEXEC_ON_CRASH)
-			remove_parameter(line, "BOOT_IMAGE");
+		if (filtered) {
+			remove_parameter(line, "crashkernel");
+			if (kexec_flags & KEXEC_ON_CRASH) {
+				remove_parameter(line, "BOOT_IMAGE");
+				remove_parameter(line, "mem");
+			}
+		}
 	} else
 		line = strdup("");
 
 	return line;
 }
 
+/*
+ * Returns the memory limit of the kernel command line. If the user specifies
+ * mem= on kernel command line, kdump should not add ELF core headers for ranges
+ * that are not used. The semantics of mem= depends on the architecture (e.g.
+ * x86 uses that as physical base address, ia64 uses that value to actually
+ * count memory. Therefore, we do only the parsing here and the filtering is
+ * done in the architecture specific code of crashdump_*.
+ *
+ * Because bootloaders must parse mem=, that parameter should be relatively stable
+ * and we can rely on it here.
+ *
+ * The memory limit in bytes is returned here. If there's no limit, then ULLONG_MAX
+ * is returned.
+ */
+unsigned long long get_memory_limit(void)
+{
+	char *line = get_command_line(0);
+	char *memstart;
+	char *p = line;
+	int found = 0;
+	unsigned long long memory;
+
+	while (!found) {
+		char *end;
+
+		memstart = strstr(p, "mem=");
+		p = memstart + strlen("mem=");
+		if (!memstart) {
+			return ULLONG_MAX;
+		}
+
+		if (strncmp(p, "nopentium", strlen("nopentium")) == 0) {
+			continue;
+		}
+
+		memory = strtoull(p, &end, 0);
+
+		switch (*end) {
+			case ' ':
+			case 0:
+				found = 1;
+				break;
+
+			case 't':
+			case 'T':
+				memory *= 1024;
+			case 'g':
+			case 'G':
+				memory *= 1024;
+			case 'm':
+			case 'M':
+				memory *= 1024;
+			case 'k':
+			case 'K':
+				memory *= 1024;
+				found = 1;
+				break;
+
+			default:
+				found = 0;
+				memory = ULLONG_MAX;
+		}
+	}
+
+	return memory;
+}
+
 /* check we retained the initrd */
 void check_reuse_initrd(void)
 {
-	char *line = get_command_line();
+	char *line = get_command_line(0);
 
 	if (strstr(line, "retain_initrd") == NULL)
 		die("unrecoverable error: current boot didn't "
@@ -1043,4 +1115,4 @@ int main(int argc, char *argv[])
 	fflush(stdout);
 	fflush(stderr);
 	return result;
-} 
+}
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 7db8227..2e225fb 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -230,7 +230,8 @@ int arch_process_options(int argc, char **argv);
 int arch_compat_trampoline(struct kexec_info *info);
 void arch_update_purgatory(struct kexec_info *info);
 int is_crashkernel_mem_reserved(void);
-char *get_command_line(void);
+char *get_command_line(int filtered);
+unsigned long long get_memory_limit(void);
 
 int kexec_iomem_for_each_line(char *match,
 			      int (*callback)(void *data,
-- 
1.5.4.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
