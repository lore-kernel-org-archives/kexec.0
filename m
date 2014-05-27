Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WpAJR-0003Cu-F5
 for kexec@lists.infradead.org; Tue, 27 May 2014 05:52:38 +0000
Date: Tue, 27 May 2014 13:52:08 +0800
From: Dave Young <dyoung@redhat.com>
Subject: [PATCH 1/2 resend] kexec-tools: add noefi arch cmdline option
Message-ID: <20140526084856.GA19920@dhcp-16-198.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
To: kexec@lists.infradead.org, horms@verge.net.au, vgoyal@redhat.com

For kernel boot with efi=old_map or some quirked machines like SGI UV
they use old ioremap instead of 1:1 mapping. But kexec efi support
depends on the 1:1 mapping thus we need to switch to use the old way

There's a kernel patch for exporting the efi flags so we can check the memory
mapping method. But user may want to explictly disable efi boot for unknown
reasons.

So here add a new arch option '--noefi' for this case.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
I will send out the patch to detect memmap method after the kernel patch
got accepted.
 kexec/arch/i386/crashdump-x86.c        |    2 +-
 kexec/arch/i386/include/arch/options.h |    1 +
 kexec/arch/i386/kexec-x86.c            |    6 ++++++
 kexec/arch/i386/kexec-x86.h            |    1 +
 kexec/arch/i386/x86-linux-setup.c      |    2 +-
 kexec/arch/x86_64/kexec-x86_64.c       |    5 +++++
 6 files changed, 15 insertions(+), 2 deletions(-)

Index: kexec-tools/kexec/arch/i386/include/arch/options.h
===================================================================
--- kexec-tools.orig/kexec/arch/i386/include/arch/options.h
+++ kexec-tools/kexec/arch/i386/include/arch/options.h
@@ -31,6 +31,7 @@
 #define OPT_REAL_MODE		(OPT_ARCH_MAX+9)
 #define OPT_ENTRY_32BIT		(OPT_ARCH_MAX+10)
 #define OPT_PASS_MEMMAP_CMDLINE	(OPT_ARCH_MAX+11)
+#define OPT_NOEFI		(OPT_ARCH_MAX+12)
 
 /* Options relevant to the architecture (excluding loader-specific ones): */
 #define KEXEC_ARCH_OPTIONS \
@@ -43,6 +44,7 @@
 	{ "elf32-core-headers", 0, 0, OPT_ELF32_CORE }, \
 	{ "elf64-core-headers", 0, 0, OPT_ELF64_CORE }, \
 	{ "pass-memmap-cmdline", 0, 0, OPT_PASS_MEMMAP_CMDLINE }, \
+	{ "noefi", 0, 0, OPT_NOEFI}, \
 
 #define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR ""
 
Index: kexec-tools/kexec/arch/i386/kexec-x86.c
===================================================================
--- kexec-tools.orig/kexec/arch/i386/kexec-x86.c
+++ kexec-tools/kexec/arch/i386/kexec-x86.c
@@ -55,6 +55,7 @@ void arch_usage(void)
 		"     --elf32-core-headers      Prepare core headers in ELF32 format\n"
 		"     --elf64-core-headers      Prepare core headers in ELF64 format\n"
 		"     --pass--memmap-cmdline    Pass memory map via command line in kexec on panic case\n"
+		"     --noefi                   Disable efi support\n"
 		);
 }
 
@@ -66,6 +67,7 @@ struct arch_options_t arch_options = {
 	.console_serial = 0,
 	.core_header_type = CORE_TYPE_UNDEF,
 	.pass_memmap_cmdline = 0,
+	.noefi = 0,
 };
 
 int arch_process_options(int argc, char **argv)
@@ -137,6 +139,10 @@ int arch_process_options(int argc, char 
 			break;
 		case OPT_PASS_MEMMAP_CMDLINE:
 			arch_options.pass_memmap_cmdline = 1;
+			break;
+		case OPT_NOEFI:
+			arch_options.noefi = 1;
+			break;
 		}
 	}
 	/* Reset getopt for the next pass; called in other source modules */
Index: kexec-tools/kexec/arch/i386/kexec-x86.h
===================================================================
--- kexec-tools.orig/kexec/arch/i386/kexec-x86.h
+++ kexec-tools/kexec/arch/i386/kexec-x86.h
@@ -51,6 +51,7 @@ struct arch_options_t {
 	uint8_t  	console_serial;
 	enum coretype	core_header_type;
 	uint8_t  	pass_memmap_cmdline;
+	uint8_t		noefi;
 };
 
 int multiboot_x86_probe(const char *buf, off_t len);
Index: kexec-tools/kexec/arch/x86_64/kexec-x86_64.c
===================================================================
--- kexec-tools.orig/kexec/arch/x86_64/kexec-x86_64.c
+++ kexec-tools/kexec/arch/x86_64/kexec-x86_64.c
@@ -54,6 +54,7 @@ void arch_usage(void)
 		"     --console-vga             Enable the vga console\n"
 		"     --console-serial          Enable the serial console\n"
 		"     --pass-memmap-cmdline     Pass memory map via command line in kexec on panic case\n"
+		"     --noefi                   Disable efi support\n"
 		);
 }
 
@@ -65,6 +66,7 @@ struct arch_options_t arch_options = {
 	.console_serial = 0,
 	.core_header_type = CORE_TYPE_ELF64,
 	.pass_memmap_cmdline = 0,
+	.noefi = 0,
 };
 
 int arch_process_options(int argc, char **argv)
@@ -131,6 +133,9 @@ int arch_process_options(int argc, char 
 		case OPT_PASS_MEMMAP_CMDLINE:
 			arch_options.pass_memmap_cmdline = 1;
 			break;
+		case OPT_NOEFI:
+			arch_options.noefi = 1;
+			break;
 		}
 	}
 	/* Reset getopt for the next pass; called in other source modules */
Index: kexec-tools/kexec/arch/i386/x86-linux-setup.c
===================================================================
--- kexec-tools.orig/kexec/arch/i386/x86-linux-setup.c
+++ kexec-tools/kexec/arch/i386/x86-linux-setup.c
@@ -822,7 +822,7 @@ void setup_linux_system_parameters(struc
 {
 	/* get subarch from running kernel */
 	setup_subarch(real_mode);
-	if (bzImage_support_efi_boot)
+	if (bzImage_support_efi_boot && !arch_options.noefi)
 		setup_efi_info(info, real_mode);
 	
 	/* Default screen size */
Index: kexec-tools/kexec/arch/i386/crashdump-x86.c
===================================================================
--- kexec-tools.orig/kexec/arch/i386/crashdump-x86.c
+++ kexec-tools/kexec/arch/i386/crashdump-x86.c
@@ -974,7 +974,7 @@ int load_crashdump_segments(struct kexec
 	dbgprintf("Created elf header segment at 0x%lx\n", elfcorehdr);
 	if (delete_memmap(memmap_p, &nr_memmap, elfcorehdr, memsz) < 0)
 		return -1;
-	if (!bzImage_support_efi_boot)
+	if (!bzImage_support_efi_boot || arch_options.noefi)
 		cmdline_add_efi(mod_cmdline);
 	cmdline_add_elfcorehdr(mod_cmdline, elfcorehdr);
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
