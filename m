Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aXpAn-0001pj-EH
 for kexec@lists.infradead.org; Mon, 22 Feb 2016 12:01:12 +0000
Subject: [RFC v2 PATCH 6/7] purgatory/x86: Add an option to output IP
 registers to console in panic case
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Date: Mon, 22 Feb 2016 20:56:29 +0900
Message-ID: <20160222115629.4231.73890.stgit@softrs>
In-Reply-To: <20160222115617.4231.50041.stgit@softrs>
References: <20160222115617.4231.50041.stgit@softrs>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, Corey Minyard <minyard@acm.org>

This patch adds --output-cpu-ip option which outpus the values of IP
registers to VGA/serial console.  To take effect, you need to specify
both or one of --console-vga and --console-serial options, too.

The values of IP registers are taken from the ELF core header
prepared by the first kernel.  To do this, the address of the header
is passed to the purgatory through elfcorehdr variable.

Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
---
 kexec/arch/i386/crashdump-x86.c              |   10 ++--
 kexec/arch/i386/include/arch/options.h       |    4 +-
 kexec/arch/i386/kexec-x86.h                  |    1 
 kexec/arch/x86_64/kexec-x86_64.c             |   15 ++++++
 kexec/kexec.h                                |    1 
 purgatory/Makefile                           |    1 
 purgatory/arch/i386/purgatory-x86.h          |    1 
 purgatory/arch/x86_64/Makefile               |    1 
 purgatory/arch/x86_64/purgatory-elf-x86_64.c |   49 ++++++++++++++++++++
 purgatory/arch/x86_64/purgatory-x86_64.c     |    5 ++
 purgatory/include/purgatory-elf.h            |   13 +++++
 purgatory/purgatory-elf-core.c               |   64 ++++++++++++++++++++++++++
 12 files changed, 159 insertions(+), 6 deletions(-)
 create mode 100644 purgatory/arch/x86_64/purgatory-elf-x86_64.c
 create mode 100644 purgatory/include/purgatory-elf.h
 create mode 100644 purgatory/purgatory-elf-core.c

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index bbc0f35..d843b0c 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -867,7 +867,7 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 				unsigned long max_addr, unsigned long min_base)
 {
 	void *tmp;
-	unsigned long sz, bufsz, memsz, elfcorehdr;
+	unsigned long sz, bufsz, memsz;
 	int nr_ranges = 0, nr_memmap = 0, align = 1024, i;
 	struct memory_range *mem_range, *memmap_p;
 	struct crash_elf_info elf_info;
@@ -990,15 +990,15 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	} else {
 		memsz = bufsz;
 	}
-	elfcorehdr = add_buffer(info, tmp, bufsz, memsz, align, min_base,
+	info->elfcorehdr = add_buffer(info, tmp, bufsz, memsz, align, min_base,
 							max_addr, -1);
-	dbgprintf("Created elf header segment at 0x%lx\n", elfcorehdr);
-	if (delete_memmap(memmap_p, &nr_memmap, elfcorehdr, memsz) < 0)
+	dbgprintf("Created elf header segment at 0x%lx\n", info->elfcorehdr);
+	if (delete_memmap(memmap_p, &nr_memmap, info->elfcorehdr, memsz) < 0)
 		return -1;
 	if (!bzImage_support_efi_boot || arch_options.noefi ||
 	    !sysfs_efi_runtime_map_exist())
 		cmdline_add_efi(mod_cmdline);
-	cmdline_add_elfcorehdr(mod_cmdline, elfcorehdr);
+	cmdline_add_elfcorehdr(mod_cmdline, info->elfcorehdr);
 
 	/* Inform second kernel about the presence of ACPI tables. */
 	for (i = 0; i < CRASH_MAX_MEMORY_RANGES; i++) {
diff --git a/kexec/arch/i386/include/arch/options.h b/kexec/arch/i386/include/arch/options.h
index c113a83..46339e6 100644
--- a/kexec/arch/i386/include/arch/options.h
+++ b/kexec/arch/i386/include/arch/options.h
@@ -17,7 +17,8 @@
 #define OPT_CONSOLE_SERIAL (OPT_MAX+4)
 #define OPT_ELF32_CORE     (OPT_MAX+5)
 #define OPT_ELF64_CORE     (OPT_MAX+6)
-#define OPT_ARCH_MAX       (OPT_MAX+7)
+#define OPT_OUTPUT_CPU_IP  (OPT_MAX+7)
+#define OPT_ARCH_MAX       (OPT_MAX+8)
 
 #define OPT_APPEND		(OPT_ARCH_MAX+0)
 #define OPT_REUSE_CMDLINE	(OPT_ARCH_MAX+1)
@@ -45,6 +46,7 @@
 	{ "elf64-core-headers", 0, 0, OPT_ELF64_CORE }, \
 	{ "pass-memmap-cmdline", 0, 0, OPT_PASS_MEMMAP_CMDLINE }, \
 	{ "noefi", 0, 0, OPT_NOEFI}, \
+	{ "output-cpu-ip", 0, 0, OPT_OUTPUT_CPU_IP }, \
 
 #define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR ""
 
diff --git a/kexec/arch/i386/kexec-x86.h b/kexec/arch/i386/kexec-x86.h
index 33df352..7d9facf 100644
--- a/kexec/arch/i386/kexec-x86.h
+++ b/kexec/arch/i386/kexec-x86.h
@@ -52,6 +52,7 @@ struct arch_options_t {
 	enum coretype	core_header_type;
 	uint8_t  	pass_memmap_cmdline;
 	uint8_t		noefi;
+	uint8_t		output_cpu_ip;
 };
 
 int multiboot_x86_probe(const char *buf, off_t len);
diff --git a/kexec/arch/x86_64/kexec-x86_64.c b/kexec/arch/x86_64/kexec-x86_64.c
index 041b007..0ba2e45 100644
--- a/kexec/arch/x86_64/kexec-x86_64.c
+++ b/kexec/arch/x86_64/kexec-x86_64.c
@@ -55,6 +55,8 @@ void arch_usage(void)
 		"     --console-serial          Enable the serial console\n"
 		"     --pass-memmap-cmdline     Pass memory map via command line in kexec on panic case\n"
 		"     --noefi                   Disable efi support\n"
+		"     --output-cpu-ip           Output RIP for each CPU in kexec on panic\n"
+		"                               case. You should use with --console-* options\n"
 		);
 }
 
@@ -67,6 +69,7 @@ struct arch_options_t arch_options = {
 	.core_header_type = CORE_TYPE_ELF64,
 	.pass_memmap_cmdline = 0,
 	.noefi = 0,
+	.output_cpu_ip = 0,
 };
 
 int arch_process_options(int argc, char **argv)
@@ -136,8 +139,15 @@ int arch_process_options(int argc, char **argv)
 		case OPT_NOEFI:
 			arch_options.noefi = 1;
 			break;
+		case OPT_OUTPUT_CPU_IP:
+			arch_options.output_cpu_ip = 1;
+			break;
 		}
 	}
+
+	if ((arch_options.console_vga | arch_options.console_serial) == 0)
+		arch_options.output_cpu_ip = 0;
+
 	/* Reset getopt for the next pass; called in other source modules */
 	opterr = 1;
 	optind = 1;
@@ -177,6 +187,11 @@ void arch_update_purgatory(struct kexec_info *info)
 		panic_kernel = 1;
 		elf_rel_set_symbol(&info->rhdr, "backup_start",
 					&info->backup_start, sizeof(info->backup_start));
+		elf_rel_set_symbol(&info->rhdr, "elfcorehdr",
+				   &info->elfcorehdr, sizeof(info->elfcorehdr));
+		elf_rel_set_symbol(&info->rhdr, "output_cpu_ip",
+				   &arch_options.output_cpu_ip,
+				   sizeof(arch_options.output_cpu_ip));
 	}
 	elf_rel_set_symbol(&info->rhdr, "panic_kernel",
 				&panic_kernel, sizeof(panic_kernel));
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 2faab91..9105c63 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -158,6 +158,7 @@ struct kexec_info {
 	unsigned long kexec_flags;
 	unsigned long backup_src_start;
 	unsigned long backup_src_size;
+	unsigned long elfcorehdr;
 	/* Set to 1 if we are using kexec file syscall */
 	unsigned long file_mode :1;
 
diff --git a/purgatory/Makefile b/purgatory/Makefile
index 80caeab..cc9b383 100644
--- a/purgatory/Makefile
+++ b/purgatory/Makefile
@@ -14,6 +14,7 @@ PURGATORY_SRCS += purgatory/purgatory.c
 PURGATORY_SRCS += purgatory/printf.c
 PURGATORY_SRCS += purgatory/string.c
 PURGATORY_SRCS += purgatory/time.c
+PURGATORY_SRCS += purgatory/purgatory-elf-core.c
 PURGATORY_MAP = purgatory/purgatory.map
 
 dist += purgatory/Makefile $(PURGATORY_SRCS)				\
diff --git a/purgatory/arch/i386/purgatory-x86.h b/purgatory/arch/i386/purgatory-x86.h
index 02039c9..16dfafd 100644
--- a/purgatory/arch/i386/purgatory-x86.h
+++ b/purgatory/arch/i386/purgatory-x86.h
@@ -5,5 +5,6 @@ void x86_reset_vga(void);
 void x86_setup_legacy_pic(void);
 void x86_setup_legacy_timer(void);
 void crashdump_backup_memory(void);
+void print_ip(void);
 
 #endif /* PURGATORY_X86_H */
diff --git a/purgatory/arch/x86_64/Makefile b/purgatory/arch/x86_64/Makefile
index bca1f71..e34f6a5 100644
--- a/purgatory/arch/x86_64/Makefile
+++ b/purgatory/arch/x86_64/Makefile
@@ -7,6 +7,7 @@ x86_64_PURGATORY_SRCS_native += purgatory/arch/x86_64/entry64.S
 x86_64_PURGATORY_SRCS_native += purgatory/arch/x86_64/setup-x86_64.S
 x86_64_PURGATORY_SRCS_native += purgatory/arch/x86_64/stack.S
 x86_64_PURGATORY_SRCS_native += purgatory/arch/x86_64/purgatory-x86_64.c
+x86_64_PURGATORY_SRCS_native += purgatory/arch/x86_64/purgatory-elf-x86_64.c
 
 x86_64_PURGATORY_SRCS += $(x86_64_PURGATORY_SRCS_native)
 
diff --git a/purgatory/arch/x86_64/purgatory-elf-x86_64.c b/purgatory/arch/x86_64/purgatory-elf-x86_64.c
new file mode 100644
index 0000000..513974b
--- /dev/null
+++ b/purgatory/arch/x86_64/purgatory-elf-x86_64.c
@@ -0,0 +1,49 @@
+#include <string.h>
+#include <sys/procfs.h>
+#include <elf.h>
+#include <purgatory.h>
+#include <purgatory-elf.h>
+
+static int is_valid_crash_note(Elf64_Phdr *phdr)
+{
+	Elf64_Nhdr *nhdr = (Elf64_Nhdr *)phdr->p_paddr;
+	char *buf;
+
+	if (phdr->p_filesz < sizeof(struct elf_prstatus))
+		return 0;
+
+	if (nhdr->n_namesz != 5 ||
+	    nhdr->n_descsz != sizeof(struct elf_prstatus) ||
+	    nhdr->n_type != NT_PRSTATUS)
+		return 0;
+
+	buf = (char *)nhdr;
+	buf += _ALIGN(sizeof(*nhdr), 4);
+
+	/* Check the name of this note including null terminator */
+	if (memcmp(buf, "CORE", 5) != 0)
+		return 0;
+
+	return 1;
+}
+
+static unsigned long get_ip_from_crash_note(Elf64_Phdr *phdr)
+{
+	struct elf_prstatus *prstatus;
+
+	prstatus = (struct elf_prstatus *)get_note_contents(phdr);
+
+	/* RIP is in pr_reg[16] for x86_64 */
+	return prstatus->pr_reg[16];
+}
+
+static void fn_print_ip(Elf64_Phdr *phdr)
+{
+	if (is_valid_crash_note(phdr))
+		printf("RIP: %lx\n", get_ip_from_crash_note(phdr));
+}
+
+void print_ip(void)
+{
+	process_elf_notes(fn_print_ip);
+}
diff --git a/purgatory/arch/x86_64/purgatory-x86_64.c b/purgatory/arch/x86_64/purgatory-x86_64.c
index fb238a3..cfc9d97 100644
--- a/purgatory/arch/x86_64/purgatory-x86_64.c
+++ b/purgatory/arch/x86_64/purgatory-x86_64.c
@@ -1,11 +1,13 @@
 #include <stdint.h>
 #include <stddef.h>
 #include <purgatory.h>
+#include <purgatory-elf.h>
 #include "purgatory-x86_64.h"
 
 uint8_t reset_vga = 0;
 uint8_t legacy_pic = 0;
 uint8_t panic_kernel = 0;
+uint8_t output_cpu_ip = 0;
 unsigned long jump_back_entry = 0;
 char *cmdline_end = NULL;
 
@@ -41,6 +43,9 @@ void post_verification_setup_arch(void)
 
 		if (ipmi_wdt)
 			ipmi_wdt_start_stop();
+
+		if (output_cpu_ip && have_valid_elf_header())
+			print_ip();
 	}
 
 	if (jump_back_entry) x86_setup_jump_back_entry();
diff --git a/purgatory/include/purgatory-elf.h b/purgatory/include/purgatory-elf.h
new file mode 100644
index 0000000..5d35c14
--- /dev/null
+++ b/purgatory/include/purgatory-elf.h
@@ -0,0 +1,13 @@
+#ifndef PURGATORY_ELF_H
+#define PURGATORY_ELF_H
+
+#include <elf.h>
+
+#define _ALIGN_MASK(addr, mask)	(((addr) + (mask)) & ~(mask))
+#define _ALIGN(addr, size)	_ALIGN_MASK((addr), (typeof(addr))(size) - 1)
+
+extern int have_valid_elf_header(void);
+extern char *get_note_contents(Elf64_Phdr *phdr);
+extern void process_elf_notes(void (*fn)(Elf64_Phdr *));
+
+#endif /* PURGATORY_ELF_H */
diff --git a/purgatory/purgatory-elf-core.c b/purgatory/purgatory-elf-core.c
new file mode 100644
index 0000000..8a2dc06
--- /dev/null
+++ b/purgatory/purgatory-elf-core.c
@@ -0,0 +1,64 @@
+#include <string.h>
+#include <sys/procfs.h>
+#include <elf.h>
+#include <purgatory.h>
+#include <purgatory-elf.h>
+
+unsigned long elfcorehdr = 0;
+
+/* TODO for non-RFC version: Make this independent of architectures */
+
+/*
+ * Check the ELF header and return the address of the first program header.
+ * Return NULL if the given ELF header doesn't have expected values.
+ */
+int have_valid_elf_header(void)
+{
+	Elf64_Ehdr *ehdr = (Elf64_Ehdr *)elfcorehdr;
+
+	if (ehdr == NULL)
+		return 0;
+
+	if (memcmp(ehdr->e_ident, ELFMAG, SELFMAG) != 0)
+		return 0;
+
+	if (ehdr->e_ident[EI_CLASS] != ELFCLASS64 ||
+	    ehdr->e_ident[EI_DATA] != ELFDATA2LSB ||
+	    ehdr->e_ident[EI_VERSION] != EV_CURRENT)
+		return 0;
+
+	if (ehdr->e_type != ET_CORE ||
+	    ehdr->e_machine != EM_X86_64 ||
+	    ehdr->e_version != EV_CURRENT)
+		return 0;
+
+	return 1;
+}
+
+char *get_note_contents(Elf64_Phdr *phdr)
+{
+	Elf64_Nhdr *nhdr = (Elf64_Nhdr *)phdr->p_paddr;
+	char *buf;
+
+	buf = (char *)nhdr;
+	buf += _ALIGN(sizeof(*nhdr), 4);
+	buf += _ALIGN(nhdr->n_namesz, 4);
+
+	return buf;
+}
+
+void process_elf_notes(void (*fn)(Elf64_Phdr *))
+{
+	Elf64_Ehdr *ehdr = (Elf64_Ehdr *)elfcorehdr;
+	Elf64_Phdr *phdr;
+	int i;
+
+	phdr = (void *)((unsigned long)ehdr + ehdr->e_phoff);
+
+	for (i = 0; i < ehdr->e_phnum; phdr++, i++) {
+		if (phdr->p_type != PT_NOTE)
+			continue;
+
+		fn(phdr);
+	}
+}



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
