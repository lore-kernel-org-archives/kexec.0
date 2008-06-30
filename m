Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KDEke-0004z7-9W
	for kexec@lists.infradead.org; Mon, 30 Jun 2008 08:28:46 +0000
Date: Mon, 30 Jun 2008 18:28:41 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] MIPS: kexec-tools crashdump, 64-bit support, SMP etc.
Message-ID: <20080630082841.GA18232@verge.net.au>
References: <48624310.1070108@ru.mvista.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48624310.1070108@ru.mvista.com>
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
To: msyrchin <msyrchin@ru.mvista.com>
Cc: kexec@lists.infradead.org

On Wed, Jun 25, 2008 at 05:07:28PM +0400, msyrchin wrote:
> This patch updates kexec-toolst for MIPS platform to support kdump, 64-bit
> and SMP. It does the following:
> 
>  - mips-setup-simple.S was removed. Most platforms has their own boot
>   structures and it is more simple to fill them inside kernel (not in
>   trampoline code). Struct 'boot_notes' isn't used now anymore - removed.

As I understand it this will create a compatibility issue and basically
once kexec-tools takes this patch they user will need a kernel with
the corresponding patch included. I wonder if there are enough
mips kexec users out there for this to be a point of concern.

>  - command line is passed now as simple text buffer (is starts with string
>   'kexec' to help kernel to find it). This buffer is located after 
> kernel's bss
>   segment.

Is this in order to facilitate the kernel handling the boot protocol?

>  - 64-bit platforms are now supported.
>  - In function elf_mips_load CKSEG0 mask is removed from PT_LOAD segments
>   addresses. This this changes there is no need in special funtions
>   add_segment_phys_virt, add_buffer_virt and add_buffer_phys_virt.
>  - crashdump support was added.

Great :-)

> kexec/kdump funtionality was tested on several Cavium Octeon
> boards (mips64 SMP).

Below is a list of updates that I made in order to get things
to compile on 32bit mips and mipsel. I haven't set up a mips 64
crosscompile (I usually use crosstool), any tips would be appreciated.
I have not had a chance to confirm that this works on any 32bit systems
beyond the (cross) compile.

---

Changes:

* Various 4-spaces -> tab fixes

* Changes to kexec/arch/mips/Makefile look mostly bogus,
  trimmed down to something that looks a bit more sensible

* Don't remove ehdr from elf_mips_load(), it seems to be needed.
  Fixes the following error when compiling for mips:

  kexec/arch/mips/kexec-elf-mips.c: In function `elf_mips_load':
  kexec/arch/mips/kexec-elf-mips.c:126: error: `ehdr' undeclared (first use
  in this function)

* Don't remove add_buffer() and add_segment() from
  kexec/arch/mips/kexec-mips.c as they seem to be needed.
  Fixes the following errors when compiling for mips:

  kexec/kexec-elf-exec.o(.text+0x1ac): In function `elf_exec_load':
  : undefined reference to `add_segment'
  kexec/kexec-elf-rel.o(.text+0x4ec): In function `elf_rel_load':
  : undefined reference to `add_buffer'
  kexec/kexec-elf-boot.o(.text+0xf4): In function `elf_boot_notes':
  : undefined reference to `add_buffer'
  kexec/arch/mips/kexec-elf-mips.o(.text+0x37c): In function
  `elf_mips_load':
  : undefined reference to `add_buffer'
  kexec/arch/mips/crashdump-mips.o(.text+0x524): In function
  `load_crashdump_segments':
  : undefined reference to `add_buffer'
  kexec/arch/mips/crashdump-mips.o(.text+0x5a8): In function
  `load_crashdump_segments':
  : undefined reference to `add_buffer'


* Removed new trailing whitespace from kexec/arch/mips/crashdump-mips.c and
  kexec/arch/mips/kexec-mips.c

* include kexec-syscall.h in kexec/arch/mips/kexec-elf-mips.c

  kexec/arch/mips/kexec-elf-mips.c:115: error: `KEXEC_ON_CRASH'
  undeclared (first use in this function)

* Cast assignment of virt_to_phys() to info->entry in elf_mips_load()
  to (void *). Fixes the following warning when compiling for mips:

  kexec/arch/mips/kexec-elf-mips.c: In function `elf_mips_load':
  kexec/arch/mips/kexec-elf-mips.c:162: warning: assignment makes
  pointer from integer without a cast

* Cast assignment of virt_to_phys() to info->entry in elf_mips_load()
  to (void *). Fixes the following warning when compiling for mips:

  kexec/arch/mips/kexec-elf-mips.c: In function `elf_mips_load':

kexec/arch/mips/kexec-elf-mips.c:78: warning: 'bss_start' might be used
uninitialized in this function
kexec/arch/mips/kexec-elf-mips.c:80: warning: 'modified_cmdline' might
be used uninitialized in this function

Index: kexec-tools-testing-merge/kexec/arch/mips/kexec-elf-mips.c
===================================================================
--- kexec-tools-testing-merge.orig/kexec/arch/mips/kexec-elf-mips.c	2008-06-30 16:24:47.000000000 +1000
+++ kexec-tools-testing-merge/kexec/arch/mips/kexec-elf-mips.c	2008-06-30 16:36:40.000000000 +1000
@@ -25,51 +25,18 @@
 #include <ip_checksum.h>
 #include "../../kexec.h"
 #include "../../kexec-elf.h"
+#include "../../kexec-syscall.h"
 #include "kexec-mips.h"
 #include <arch/options.h>
+#include "crashdump-mips.h"
 
 static const int probe_debug = 0;
 
 #define BOOTLOADER         "kexec"
 #define MAX_COMMAND_LINE   256
 
-#define UPSZ(X) ((sizeof(X) + 3) & ~3)
-static struct boot_notes {
-	Elf_Bhdr hdr;
-	Elf_Nhdr bl_hdr;
-	unsigned char bl_desc[UPSZ(BOOTLOADER)];
-	Elf_Nhdr blv_hdr;
-	unsigned char blv_desc[UPSZ(BOOTLOADER_VERSION)];
-	Elf_Nhdr cmd_hdr;
-	unsigned char command_line[0];
-} elf_boot_notes = {
-	.hdr = {
-		.b_signature = 0x0E1FB007,
-		.b_size = sizeof(elf_boot_notes),
-		.b_checksum = 0,
-		.b_records = 3,
-	},
-	.bl_hdr = {
-		.n_namesz = 0,
-		.n_descsz = sizeof(BOOTLOADER),
-		.n_type = EBN_BOOTLOADER_NAME,
-	},
-	.bl_desc = BOOTLOADER,
-	.blv_hdr = {
-		.n_namesz = 0,
-		.n_descsz = sizeof(BOOTLOADER_VERSION),
-		.n_type = EBN_BOOTLOADER_VERSION,
-	},
-	.blv_desc = BOOTLOADER_VERSION,
-	.cmd_hdr = {
-		.n_namesz = 0,
-		.n_descsz = 0,
-		.n_type = EBN_COMMAND_LINE,
-	},
-};
-
-
-#define OPT_APPEND	(OPT_ARCH_MAX+0)
+/* 'kexec' in cmdline is used to find cmdline buffer by kernel */
+static char cmdline_buf[256] = "kexec ";
 
 int elf_mips_probe(const char *buf, off_t len)
 {
@@ -108,16 +75,14 @@ int elf_mips_load(int argc, char **argv,
 	struct kexec_info *info)
 {
 	struct mem_ehdr ehdr;
-	char *arg_buf;
-	size_t arg_bytes;
-	unsigned long arg_base;
-	struct boot_notes *notes;
-	size_t note_bytes;
-	const char *command_line;
-	int command_line_len;
-	unsigned char *setup_start;
-	uint32_t setup_size;
+	unsigned long bss_start, bss_size = 0;
+	const char *command_line = NULL;
+	char *modified_cmdline;
+	int modified_cmdline_len;
+	unsigned long cmdline_addr;
+	int result,i;
 	int opt;
+#define OPT_APPEND     (OPT_ARCH_MAX+0)
 	static const struct option options[] = {
 		KEXEC_ARCH_OPTIONS
 		{"command-line", 1, 0, OPT_APPEND},
@@ -144,38 +109,84 @@ int elf_mips_load(int argc, char **argv,
 			break;
 		}
 	}
-	command_line_len = 0;
-	setup_simple_regs.spr9 = 0;
+
+	/* Need to append some command line parameters internally in case of
+	 * taking crash dumps.
+	 */
+	if (info->kexec_flags & KEXEC_ON_CRASH) {
+		modified_cmdline = xmalloc(COMMAND_LINE_SIZE);
+		memset((void *)modified_cmdline, 0, COMMAND_LINE_SIZE);
 	if (command_line) {
-		command_line_len = strlen(command_line) + 1;
-		setup_simple_regs.spr9 = 2;
+			strncpy(modified_cmdline, command_line, COMMAND_LINE_SIZE);
+			modified_cmdline[COMMAND_LINE_SIZE - 1] = '\0';
+		}
+		modified_cmdline_len = strlen(modified_cmdline);
 	}
 
-	/* Load the ELF executable */
-	elf_exec_build_load(info, &ehdr, buf, len, 0);
+	/* Parse the Elf file */
+	result = build_elf_exec_info(buf, len, &ehdr, 0);
+	if (result < 0) {
+		die("ELF exec parse failed\n");
+	}
+
+	/* Read in the PT_LOAD segments and remove CKSEG0 mask from address*/
+	for(i = 0; i < ehdr.e_phnum; i++) {
+		struct mem_phdr *phdr;
+		phdr = &ehdr.e_phdr[i];
+		if (phdr->p_type == PT_LOAD) {
+			phdr->p_paddr = virt_to_phys(phdr->p_paddr);
+		}
+	}
 
-	setup_start = setup_simple_start;
-	setup_size = setup_simple_size;
-	setup_simple_regs.spr8 = ehdr.e_entry;
+	for(i = 0; i < ehdr.e_shnum; i++) {
+		struct mem_shdr *shdr;
+		unsigned char *strtab;
+		strtab = (unsigned char *)ehdr.e_shdr[ehdr.e_shstrndx].sh_data;
+
+		shdr = &ehdr.e_shdr[i];
+		if ( shdr->sh_size &&
+				strcmp((char *)&strtab[shdr->sh_name],
+					".bss") == 0) {
+			bss_start = virt_to_phys(shdr->sh_addr);
+			bss_size = shdr->sh_size;
+			break;
+		}
 
-	note_bytes = sizeof(elf_boot_notes) + ((command_line_len + 3) & ~3);
-	arg_bytes = note_bytes + ((setup_size + 3) & ~3);
+	}
 
-	arg_buf = xmalloc(arg_bytes);
-	arg_base = add_buffer_virt(info,
-		 arg_buf, arg_bytes, arg_bytes, 4, 0, elf_max_addr(&ehdr), 1);
+	/* Load the Elf data */
+	result = elf_exec_load(&ehdr, info);
+	if (result < 0) {
+		die("ELF exec load failed\n");
+	}
+	info->entry = (void *)virt_to_phys(ehdr.e_entry);
 
-	notes = (struct boot_notes *)(arg_buf + ((setup_size + 3) & ~3));
+	if(!bss_size)
+		die("No .bss segment present\n");
 
-	memcpy(arg_buf, setup_start, setup_size);
-	memcpy(notes, &elf_boot_notes, sizeof(elf_boot_notes));
-	memcpy(notes->command_line, command_line, command_line_len);
+	/* Put cmdline right after bss */
+	cmdline_addr = bss_start + bss_size;
 
-	notes->hdr.b_size = note_bytes;
-	notes->cmd_hdr.n_descsz = command_line_len;
-	notes->hdr.b_checksum = compute_ip_checksum(notes, note_bytes);
+	/* If panic kernel is being loaded, additional segments need
+	 * to be created.
+	 */
+	if (info->kexec_flags & KEXEC_ON_CRASH) {
+		result = load_crashdump_segments(info, modified_cmdline,
+						0, 0);
+		if (result < 0)
+			return -1;
+		/* Use new command line. */
+		command_line = modified_cmdline;
+	}
 
-	info->entry = (void *)arg_base;
+	if (command_line)
+	{
+		strncat(cmdline_buf,command_line,
+			sizeof(cmdline_buf) - strlen(cmdline_buf) - 1);
+		add_buffer(info, cmdline_buf, sizeof(cmdline_buf),
+			sizeof(cmdline_buf), sizeof(void*),
+			cmdline_addr, 0x0fffffff, 1);
+	}
 
 	return 0;
 }
Index: kexec-tools-testing-merge/kexec/arch/mips/Makefile
===================================================================
--- kexec-tools-testing-merge.orig/kexec/arch/mips/Makefile	2008-06-30 16:24:47.000000000 +1000
+++ kexec-tools-testing-merge/kexec/arch/mips/Makefile	2008-06-30 16:24:54.000000000 +1000
@@ -4,7 +4,7 @@
 mips_KEXEC_SRCS =  kexec/arch/mips/kexec-mips.c
 mips_KEXEC_SRCS += kexec/arch/mips/kexec-elf-mips.c
 mips_KEXEC_SRCS += kexec/arch/mips/kexec-elf-rel-mips.c
-mips_KEXEC_SRCS += kexec/arch/mips/mips-setup-simple.S
+mips_KEXEC_SRCS += kexec/arch/mips/crashdump-mips.c
 
 mips_ADD_BUFFER =
 mips_ADD_SEGMENT =
Index: kexec-tools-testing-merge/kexec/arch/mips/crashdump-mips.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kexec-tools-testing-merge/kexec/arch/mips/crashdump-mips.c	2008-06-30 16:24:54.000000000 +1000
@@ -0,0 +1,371 @@
+/*
+ * kexec: Linux boots Linux
+ *
+ * 2005 (C) IBM Corporation.
+ * 2008 (C) MontaVista Software, Inc.
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
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <elf.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include "../../kexec.h"
+#include "../../kexec-elf.h"
+#include "../../kexec-syscall.h"
+#include "../../crashdump.h"
+#include "kexec-mips.h"
+#include "crashdump-mips.h"
+
+extern struct arch_options_t arch_options;
+
+/* Stores a sorted list of RAM memory ranges for which to create elf headers.
+ * A separate program header is created for backup region */
+static struct memory_range crash_memory_range[CRASH_MAX_MEMORY_RANGES];
+
+/* Memory region reserved for storing panic kernel and other data. */
+static struct memory_range crash_reserved_mem;
+
+/*
+ * To store the memory size of the first kernel and this value will be
+ * passed to the second kernel as command line (savemaxmem=xM).
+ * The second kernel will be calculated saved_max_pfn based on this
+ * variable.
+ */
+unsigned long long saved_max_mem = 0;
+
+/* Removes crash reserve region from list of memory chunks for whom elf program
+ * headers have to be created. Assuming crash reserve region to be a single
+ * continuous area fully contained inside one of the memory chunks */
+static int exclude_crash_reserve_region(int *nr_ranges)
+{
+    int i, j, tidx = -1;
+    unsigned long long cstart, cend;
+    struct memory_range temp_region;
+
+    /* Crash reserved region. */
+    cstart = crash_reserved_mem.start;
+    cend = crash_reserved_mem.end;
+
+    for (i = 0; i < (*nr_ranges); i++) {
+        unsigned long long mstart, mend;
+        mstart = crash_memory_range[i].start;
+        mend = crash_memory_range[i].end;
+        if (cstart < mend && cend > mstart) {
+            if (cstart != mstart && cend != mend) {
+                /* Split memory region */
+                crash_memory_range[i].end = cstart - 1;
+                temp_region.start = cend + 1;
+                temp_region.end = mend;
+                temp_region.type = RANGE_RAM;
+                tidx = i+1;
+            } else if (cstart != mstart)
+                crash_memory_range[i].end = cstart - 1;
+            else
+                crash_memory_range[i].start = cend + 1;
+        }
+    }
+    /* Insert split memory region, if any. */
+    if (tidx >= 0) {
+        if (*nr_ranges == CRASH_MAX_MEMORY_RANGES) {
+            /* No space to insert another element. */
+            fprintf(stderr, "Error: Number of crash memory ranges"
+                    " excedeed the max limit\n");
+            return -1;
+        }
+        for (j = (*nr_ranges - 1); j >= tidx; j--)
+            crash_memory_range[j+1] = crash_memory_range[j];
+        crash_memory_range[tidx].start = temp_region.start;
+        crash_memory_range[tidx].end = temp_region.end;
+        crash_memory_range[tidx].type = temp_region.type;
+        (*nr_ranges)++;
+    }
+    return 0;
+}
+/* Reads the appropriate file and retrieves the SYSTEM RAM regions for whom to
+ * create Elf headers. Keeping it separate from get_memory_ranges() as
+ * requirements are different in the case of normal kexec and crashdumps.
+ *
+ * Normal kexec needs to look at all of available physical memory irrespective
+ * of the fact how much of it is being used by currently running kernel.
+ * Crashdumps need to have access to memory regions actually being used by
+ * running  kernel. Expecting a different file/data structure than /proc/iomem
+ * to look into down the line. May be something like /proc/kernelmem or may
+ * be zone data structures exported from kernel.
+ */
+static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
+{
+    const char iomem[]= "/proc/iomem";
+    int i, memory_ranges = 0;
+    char line[MAX_LINE];
+    FILE *fp;
+    unsigned long long start, end;
+
+    fp = fopen(iomem, "r");
+    if (!fp) {
+        fprintf(stderr, "Cannot open %s: %s\n",
+            iomem, strerror(errno));
+        return -1;
+    }
+
+    /* Separate segment for backup region */
+    crash_memory_range[0].start = BACKUP_SRC_START;
+    crash_memory_range[0].end = BACKUP_SRC_END;
+    crash_memory_range[0].type = RANGE_RAM;
+    memory_ranges++;
+
+    while(fgets(line, sizeof(line), fp) != 0) {
+        char *str;
+        int type, consumed, count;
+        if (memory_ranges >= CRASH_MAX_MEMORY_RANGES)
+            break;
+        count = sscanf(line, "%Lx-%Lx : %n",
+            &start, &end, &consumed);
+        if (count != 2)
+            continue;
+        str = line + consumed;
+
+        /* Only Dumping memory of type System RAM. */
+        if (memcmp(str, "System RAM\n", 11) == 0) {
+            type = RANGE_RAM;
+        } else if (memcmp(str, "Crash kernel\n", 13) == 0) {
+                /* Reserved memory region. New kernel can
+                 * use this region to boot into. */
+                crash_reserved_mem.start = start;
+                crash_reserved_mem.end = end;
+                crash_reserved_mem.type = RANGE_RAM;
+                continue;
+        } else {
+            continue;
+        }
+
+        if (start == BACKUP_SRC_START && end >= (BACKUP_SRC_END + 1))
+            start = BACKUP_SRC_END + 1;
+
+        crash_memory_range[memory_ranges].start = start;
+        crash_memory_range[memory_ranges].end = end;
+        crash_memory_range[memory_ranges].type = type;
+        memory_ranges++;
+
+        /* Segregate linearly mapped region. */
+        if ((MAXMEM - 1) >= start && (MAXMEM - 1) <= end) {
+            crash_memory_range[memory_ranges-1].end = MAXMEM -1;
+
+            /* Add segregated region. */
+            crash_memory_range[memory_ranges].start = MAXMEM;
+            crash_memory_range[memory_ranges].end = end;
+            crash_memory_range[memory_ranges].type = type;
+            memory_ranges++;
+        }
+    }
+    fclose(fp);
+
+    if (exclude_crash_reserve_region(&memory_ranges) < 0)
+        return -1;
+
+    for (i = 0; i < memory_ranges; i++)
+        if (saved_max_mem < crash_memory_range[i].end)
+            saved_max_mem = crash_memory_range[i].end + 1;
+
+    *range = crash_memory_range;
+    *ranges = memory_ranges;
+    return 0;
+}
+
+/* Converts unsigned long to ascii string. */
+static void ultoa(unsigned long i, char *str)
+{
+    int j = 0, k;
+    char tmp;
+
+    do {
+        str[j++] = i % 10 + '0';
+    } while ((i /=10) > 0);
+    str[j] = '\0';
+
+    /* Reverse the string. */
+    for (j = 0, k = strlen(str) - 1; j < k; j++, k--) {
+        tmp = str[k];
+        str[k] = str[j];
+        str[j] = tmp;
+    }
+}
+
+/* Adds the appropriate mem= options to command line, indicating the
+ * memory region the new kernel can use to boot into. */
+static int cmdline_add_mem(char *cmdline, unsigned long addr, unsigned long size)
+{
+    int cmdlen, len;
+    char str[50], *ptr;
+
+    addr = addr/1024;
+    size = size/1024;
+    ptr = str;
+    strcpy (str, " mem=");
+    ptr += strlen(str);
+    ultoa(size, ptr);
+    strcat (str, "K@");
+    ptr = str + strlen(str);
+    ultoa(addr, ptr);
+    strcat (str, "K");
+    len = strlen(str);
+    cmdlen = strlen(cmdline) + len;
+    if (cmdlen > (COMMAND_LINE_SIZE - 1))
+        die("Command line overflow\n");
+    strcat(cmdline, str);
+
+    return 0;
+}
+
+/* Adds the elfcorehdr= command line parameter to command line. */
+static int cmdline_add_elfcorehdr(char *cmdline, unsigned long addr)
+{
+    int cmdlen, len, align = 1024;
+    char str[30], *ptr;
+
+    /* Passing in elfcorehdr=xxxK format. Saves space required in cmdline.
+     * Ensure 1K alignment*/
+    if (addr%align)
+        return -1;
+    addr = addr/align;
+    ptr = str;
+    strcpy(str, " elfcorehdr=");
+    ptr += strlen(str);
+    ultoa(addr, ptr);
+    strcat(str, "K");
+    len = strlen(str);
+    cmdlen = strlen(cmdline) + len;
+    if (cmdlen > (COMMAND_LINE_SIZE - 1))
+        die("Command line overflow\n");
+    strcat(cmdline, str);
+    return 0;
+}
+
+/* Adds the elfcorehdr= command line parameter to command line. */
+static int cmdline_add_savemaxmem(char *cmdline, unsigned long addr)
+{
+    int cmdlen, len, align = 1024;
+    char str[30], *ptr;
+
+    /* Passing in savemaxmem=xxxM format. Saves space required in cmdline.*/
+    addr = addr/(align*align);
+    ptr = str;
+    strcpy(str, " savemaxmem=");
+    ptr += strlen(str);
+    ultoa(addr, ptr);
+    strcat(str, "M");
+    len = strlen(str);
+    cmdlen = strlen(cmdline) + len;
+    if (cmdlen > (COMMAND_LINE_SIZE - 1))
+        die("Command line overflow\n");
+    strcat(cmdline, str);
+    return 0;
+}
+
+#ifdef __mips64
+static struct crash_elf_info elf_info64 =
+{
+    class: ELFCLASS64,
+    data: ELFDATA2MSB,
+    machine: EM_MIPS,
+    backup_src_start: BACKUP_SRC_START,
+    backup_src_end: BACKUP_SRC_END,
+    page_offset: PAGE_OFFSET,
+    lowmem_limit: MAXMEM,
+};
+#endif
+static struct crash_elf_info elf_info32 =
+{
+    class: ELFCLASS32,
+    data: ELFDATA2MSB,
+    machine: EM_MIPS,
+    backup_src_start: BACKUP_SRC_START,
+    backup_src_end: BACKUP_SRC_END,
+    page_offset: PAGE_OFFSET,
+    lowmem_limit: MAXMEM,
+};
+
+/* Loads additional segments in case of a panic kernel is being loaded.
+ * One segment for backup region, another segment for storing elf headers
+ * for crash memory image.
+ */
+int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
+                unsigned long max_addr, unsigned long min_base)
+{
+    void *tmp;
+    unsigned long sz, elfcorehdr;
+    int nr_ranges, align = 1024;
+    struct memory_range *mem_range;
+
+    if (get_crash_memory_ranges(&mem_range, &nr_ranges) < 0)
+        return -1;
+
+    /* Create a backup region segment to store backup data*/
+    sz = (BACKUP_SRC_SIZE + align - 1) & ~(align - 1);
+    tmp = xmalloc(sz);
+    memset(tmp, 0, sz);
+    info->backup_start = add_buffer(info, tmp, sz, sz, align,
+                crash_reserved_mem.start,
+                crash_reserved_mem.end,-1);
+
+#ifdef __mips64
+    /* Create elf header segment and store crash image data. */
+    if (arch_options.core_header_type == CORE_TYPE_ELF64) {
+        if (crash_create_elf64_headers(info, &elf_info64,
+                           crash_memory_range, nr_ranges,
+                           &tmp, &sz,
+                           ELF_CORE_HEADER_ALIGN) < 0)
+            return -1;
+    }
+    else {
+        if (crash_create_elf32_headers(info, &elf_info32,
+                           crash_memory_range, nr_ranges,
+                           &tmp, &sz,
+                           ELF_CORE_HEADER_ALIGN) < 0)
+            return -1;
+    }
+#else
+    if (crash_create_elf32_headers(info, &elf_info32,
+                   crash_memory_range, nr_ranges,
+                   &tmp, &sz,
+                   ELF_CORE_HEADER_ALIGN) < 0)
+        return -1;
+#endif
+    elfcorehdr = add_buffer(info, tmp, sz, sz, align,
+                crash_reserved_mem.start,
+                crash_reserved_mem.end, -1);
+
+    /*
+     * backup segment is after elfcorehdr, so use elfcorehdr as top of
+     * kernel's available memory
+     */
+    cmdline_add_mem(mod_cmdline, crash_reserved_mem.start,
+        elfcorehdr - crash_reserved_mem.start);
+    cmdline_add_elfcorehdr(mod_cmdline, elfcorehdr);
+    cmdline_add_savemaxmem(mod_cmdline, saved_max_mem);
+    return 0;
+}
+
+int is_crashkernel_mem_reserved(void)
+{
+    uint64_t start, end;
+
+    return parse_iomem_single("Crash kernel\n", &start, &end) == 0 ?
+      (start != end) : 0;
+}
+
Index: kexec-tools-testing-merge/kexec/arch/mips/crashdump-mips.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kexec-tools-testing-merge/kexec/arch/mips/crashdump-mips.h	2008-06-30 16:24:54.000000000 +1000
@@ -0,0 +1,26 @@
+#ifndef CRASHDUMP_MIPS_H
+#define CRASHDUMP_MIPS_H
+
+struct kexec_info;
+int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline,
+                unsigned long max_addr, unsigned long min_base);
+#ifdef __mips64
+#define PAGE_OFFSET    0xa800000000000000ULL
+#else
+#define PAGE_OFFSET    0x80000000
+#endif
+#define __pa(x)        ((unsigned long)(X)& 0x7fffffff)
+
+#define MAXMEM        0x80000000
+
+#define CRASH_MAX_MEMMAP_NR    (KEXEC_MAX_SEGMENTS + 1)
+#define CRASH_MAX_MEMORY_RANGES    (MAX_MEMORY_RANGES + 2)
+
+#define COMMAND_LINE_SIZE    512
+
+/* Backup Region, First 1M of System RAM. */
+#define BACKUP_SRC_START    0x00000000
+#define BACKUP_SRC_END        0x000fffff
+#define BACKUP_SRC_SIZE    (BACKUP_SRC_END - BACKUP_SRC_START + 1)
+
+#endif /* CRASHDUMP_MIPS_H */
Index: kexec-tools-testing-merge/kexec/arch/mips/include/arch/options.h
===================================================================
--- kexec-tools-testing-merge.orig/kexec/arch/mips/include/arch/options.h	2008-06-30 16:24:47.000000000 +1000
+++ kexec-tools-testing-merge/kexec/arch/mips/include/arch/options.h	2008-06-30 16:24:54.000000000 +1000
@@ -2,10 +2,20 @@
 #define KEXEC_ARCH_MIPS_OPTIONS_H
 
 #define OPT_ARCH_MAX   (OPT_MAX+0)
+#define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR ""
 
+#ifdef __mips64
+#define OPT_ELF64_CORE  (OPT_MAX+1)
 #define KEXEC_ARCH_OPTIONS \
-	KEXEC_OPTIONS \
+    KEXEC_OPTIONS \
+    { "elf64-core-headers", 0, 0, OPT_ELF64_CORE }, \
 
 #define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR ""
+#define OPT_ARCH_MAX       (OPT_MAX+2)
+#else
+#define KEXEC_ARCH_OPTIONS \
+    KEXEC_OPTIONS \
 
+#define OPT_ARCH_MAX   (OPT_MAX+0)
+#endif
 #endif /* KEXEC_ARCH_MIPS_OPTIONS_H */
Index: kexec-tools-testing-merge/kexec/arch/mips/kexec-mips.c
===================================================================
--- kexec-tools-testing-merge.orig/kexec/arch/mips/kexec-mips.c	2008-06-30 16:24:47.000000000 +1000
+++ kexec-tools-testing-merge/kexec/arch/mips/kexec-mips.c	2008-06-30 16:34:04.000000000 +1000
@@ -97,8 +97,18 @@ int file_types = sizeof(file_type) / siz
 
 void arch_usage(void)
 {
+#ifdef __mips64
+	fprintf(stderr, "	 --elf32-core-headers Prepare core headers in "
+			"ELF32 format\n");
+#endif
 }
 
+#ifdef __mips64
+struct arch_options_t arch_options = {
+	.core_header_type = CORE_TYPE_ELF64
+};
+#endif
+
 int arch_process_options(int argc, char **argv)
 {
 	static const struct option options[] = {
@@ -113,6 +123,11 @@ int arch_process_options(int argc, char 
 		switch(opt) {
 		default:
 			break;
+#ifdef __mips64
+		case OPT_ELF64_CORE:
+			arch_options.core_header_type = CORE_TYPE_ELF64;
+			break;
+#endif
 		}
 	}
 	/* Reset getopt for the next pass; called in other source modules */
@@ -126,6 +141,10 @@ const struct arch_map_entry arches[] = {
 	 * use KEXEC_ARCH_DEFAULT instead of KEXEC_ARCH_MIPS here.
 	 */
 	{ "mips", KEXEC_ARCH_DEFAULT },
+	   /* Not using KEXEC_ARCH_DEFAULT because that will fail
+	* in the kernel's compat_sys_kexec_load() routine.
+	*/
+	{ "mips64", KEXEC_ARCH_MIPS },
 	{ 0 },
 };
 
@@ -138,18 +157,9 @@ void arch_update_purgatory(struct kexec_
 {
 }
 
-/*
- * Adding a dummy function, so that build on mips will not break.
- * Need to implement the actual checking code
- */
-int is_crashkernel_mem_reserved(void)
-{
-	return 1;
-}
-
 unsigned long virt_to_phys(unsigned long addr)
 {
-	return addr - 0x80000000;
+	return ((addr)& 0x7fffffff);
 }
 
 /*
Index: kexec-tools-testing-merge/kexec/arch/mips/kexec-mips.h
===================================================================
--- kexec-tools-testing-merge.orig/kexec/arch/mips/kexec-mips.h	2008-06-30 16:24:47.000000000 +1000
+++ kexec-tools-testing-merge/kexec/arch/mips/kexec-mips.h	2008-06-30 16:24:54.000000000 +1000
@@ -1,17 +1,16 @@
 #ifndef KEXEC_MIPS_H
 #define KEXEC_MIPS_H
 
-extern unsigned char setup_simple_start[];
-extern uint32_t setup_simple_size;
-
-extern struct {
-	uint32_t spr8;
-	uint32_t spr9;
-} setup_simple_regs;
+#define MAX_MEMORY_RANGES 64
+#define CORE_TYPE_ELF32 1
+#define CORE_TYPE_ELF64 2
 
 int elf_mips_probe(const char *buf, off_t len);
 int elf_mips_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info);
 void elf_mips_usage(void);
 
+struct arch_options_t {
+	int core_header_type;
+};
 #endif /* KEXEC_MIPS_H */
Index: kexec-tools-testing-merge/kexec/arch/mips/mips-setup-simple.S
===================================================================
--- kexec-tools-testing-merge.orig/kexec/arch/mips/mips-setup-simple.S	2008-06-30 16:24:47.000000000 +1000
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,110 +0,0 @@
-/*
- * mips-setup-simple.S - code to execute before kernel to handle command line
- * Copyright (C) 2007 Francesco Chiechi, Alessandro Rubini
- * Copyright (C) 2007 Tvblob s.r.l.
- *
- * derived from Albert Herranz idea (ppc) adding command line support
- * (boot_notes structure)
- *
- * This source code is licensed under the GNU General Public License,
- * Version 2.  See the file COPYING for more details.
- */
-
-/*
- * Only suitable for platforms booting with MMU turned off.
- * -- Albert Herranz
- */
-#include "regdef.h"
-
-/* returns  t0 = relocated address of sym */
-/* modifies t1 t2 */
-/* sym must not be global or this will not work (at least AFAIK up to now) */
-#define RELOC_SYM(sym)                                                 \
-	move    t0,ra;          /* save ra */                           \
-	bal 1f;                                                         \
-1:                                                                     \
-	move    t1,ra;          /* now t1 is 1b (where we are now) */   \
-	move    ra,t0;          /* restore ra */                        \
-	lui     t2,%hi(1b);                                             \
-	ori     t2,t2,%lo(1b);                                          \
-	lui     t0,%hi(sym);                                            \
-	ori     t0,t0,%lo(sym);                                         \
-	sub     t0,t0,t2;       /* t0 = offset between sym and 1b */    \
-	add     t0,t1,t0;       /* t0 = actual address in memory */
-
-	.data
-	.globl setup_simple_start
-setup_simple_start:
-
-	/* should perform here any required setup */
-
-	/* Initialize GOT pointer (verify if needed) */
-	bal     1f
-	nop
-	.word   _GLOBAL_OFFSET_TABLE_
-	1:
-	move    gp, ra
-	lw      t1, 0(ra)
-	move    gp, t1
-
-	/* spr8 relocation */
-	RELOC_SYM(spr8)
-
-	move    t4,t0           // save pointer to kernel start addr
-	lw      t3,0(t0)        // save kernel start address
-
-	/* spr9 relocation */
-	RELOC_SYM(spr9)
-	lw      a0,0(t0)        // load argc
-
-	// this code is to be changed if boot_notes struct changes
-	lw      t2,12(t4)       // t2 is size of boot_notes struct
-	addi    t2,t2,3
-	srl     t2,t2,2
-	sll     v1,t2,2         // v1 = size of boot_notes struct
-				// aligned to word boundary
-
-	addi    t0,t4,0x20      // t0 contains the address of "kexec" string
-	add     v0,t4,v1        // v0 points to last word of boot_notes
-	addi    v0,v0,8         // v0 points to address after boot_notes
-	sw      t0,0(v0)        // store pointer to "kexec" string there
-
-	lw      t2,-8(t0)       // t2 is size of "kexec" string in bytes
-	addi    t2,t2,3
-	srl     t2,t2,2
-	sll     v1,t2,2         // v1 = size of "kexec" string
-				// aligned to word boundary
-	add     t2,t0,v1
-	addi    t0,t2,4         // t0 points to size of version string
-
-	lw      t2,0(t0)        // t2 is size of version string in bytes
-	addi    t2,t2,3
-	srl     t2,t2,2
-	sll     v1,t2,2         // v1 = size of version string
-				// aligned to word boundary
-
-	addi    t0,t0,8         // t0 points to version string
-	add     t0,t0,v1        // t0 points to start of command_line record
-	addi    t0,t0,12        // t0 points command line
-
-	sw      t0,4(v0)        // store pointer to command line
-
-	move    a1,v0           // load argv
-	li      a2,0
-	li      a3,0
-
-	jr      t3
-	nop
-
-	.balign 4
-	.globl setup_simple_regs
-setup_simple_regs:
-spr8:	.long 0x00000000
-spr9:	.long 0x00000000
-
-setup_simple_end:
-
-	.globl setup_simple_size
-setup_simple_size:
-	.long setup_simple_end - setup_simple_start
-

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
