Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WYB3r-0007ox-W9
 for kexec@lists.infradead.org; Thu, 10 Apr 2014 09:14:21 +0000
From: WANG Chao <chaowang@redhat.com>
Subject: [PATCH v5 08/10] x86: add --pass-memmap-cmdline option
Date: Thu, 10 Apr 2014 17:13:03 +0800
Message-Id: <1397121186-9353-11-git-send-email-chaowang@redhat.com>
In-Reply-To: <1397121186-9353-1-git-send-email-chaowang@redhat.com>
References: <1397121186-9353-1-git-send-email-chaowang@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: horms@verge.net.au, vgoyal@redhat.com, ebiederm@xmission.com, hpa@zytor.com, trenn@suse.de, dyoung@redhat.com, linn@hp.com
Cc: kexec@lists.infradead.org

--pass-memmap-cmdline is used for pass memmap=exactmap cmdline for 2nd
kernel. Later we will use this option to disable passing E820 memmap
method but use the old exactmap method.

Signed-off-by: WANG Chao <chaowang@redhat.com>
Tested-by: Linn Crosetto <linn@hp.com>
---
 kexec/arch/i386/include/arch/options.h | 2 ++
 kexec/arch/i386/kexec-x86.c            | 4 ++++
 kexec/arch/i386/kexec-x86.h            | 1 +
 kexec/arch/x86_64/kexec-x86_64.c       | 5 +++++
 4 files changed, 12 insertions(+)

diff --git a/kexec/arch/i386/include/arch/options.h b/kexec/arch/i386/include/arch/options.h
index aaac731..e5300b5 100644
--- a/kexec/arch/i386/include/arch/options.h
+++ b/kexec/arch/i386/include/arch/options.h
@@ -30,6 +30,7 @@
 #define OPT_VGA 		(OPT_ARCH_MAX+8)
 #define OPT_REAL_MODE		(OPT_ARCH_MAX+9)
 #define OPT_ENTRY_32BIT		(OPT_ARCH_MAX+10)
+#define OPT_PASS_MEMMAP_CMDLINE	(OPT_ARCH_MAX+11)
 
 /* Options relevant to the architecture (excluding loader-specific ones): */
 #define KEXEC_ARCH_OPTIONS \
@@ -41,6 +42,7 @@
 	{ "console-serial", 0, 0, OPT_CONSOLE_SERIAL }, \
 	{ "elf32-core-headers", 0, 0, OPT_ELF32_CORE }, \
 	{ "elf64-core-headers", 0, 0, OPT_ELF64_CORE }, \
+	{ "pass-memmap-cmdline", 0, 0, OPT_PASS_MEMMAP_CMDLINE }, \
 
 #define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR ""
 
diff --git a/kexec/arch/i386/kexec-x86.c b/kexec/arch/i386/kexec-x86.c
index 014ecd5..0b58dff 100644
--- a/kexec/arch/i386/kexec-x86.c
+++ b/kexec/arch/i386/kexec-x86.c
@@ -54,6 +54,7 @@ void arch_usage(void)
 		"     --console-serial          Enable the serial console\n"
 		"     --elf32-core-headers      Prepare core headers in ELF32 format\n"
 		"     --elf64-core-headers      Prepare core headers in ELF64 format\n"
+		"     --pass--memmap-cmdline    Pass memory map via command line in kexec on panic case\n"
 		);
 }
 
@@ -64,6 +65,7 @@ struct arch_options_t arch_options = {
 	.console_vga = 0,
 	.console_serial = 0,
 	.core_header_type = CORE_TYPE_UNDEF,
+	.pass_memmap_cmdline = 0,
 };
 
 int arch_process_options(int argc, char **argv)
@@ -133,6 +135,8 @@ int arch_process_options(int argc, char **argv)
 		case OPT_ELF64_CORE:
 			arch_options.core_header_type = CORE_TYPE_ELF64;
 			break;
+		case OPT_PASS_MEMMAP_CMDLINE:
+			arch_options.pass_memmap_cmdline = 1;
 		}
 	}
 	/* Reset getopt for the next pass; called in other source modules */
diff --git a/kexec/arch/i386/kexec-x86.h b/kexec/arch/i386/kexec-x86.h
index 5aa2a46..e8c9188 100644
--- a/kexec/arch/i386/kexec-x86.h
+++ b/kexec/arch/i386/kexec-x86.h
@@ -50,6 +50,7 @@ struct arch_options_t {
 	uint8_t  	console_vga;
 	uint8_t  	console_serial;
 	enum coretype	core_header_type;
+	uint8_t  	pass_memmap_cmdline;
 };
 
 int multiboot_x86_probe(const char *buf, off_t len);
diff --git a/kexec/arch/x86_64/kexec-x86_64.c b/kexec/arch/x86_64/kexec-x86_64.c
index 5c23e01..f70851d 100644
--- a/kexec/arch/x86_64/kexec-x86_64.c
+++ b/kexec/arch/x86_64/kexec-x86_64.c
@@ -53,6 +53,7 @@ void arch_usage(void)
 		"     --serial-baud=<baud_rate> Specify the serial port baud rate\n"
 		"     --console-vga             Enable the vga console\n"
 		"     --console-serial          Enable the serial console\n"
+		"     --pass-memmap-cmdline     Pass memory map via command line in kexec on panic case\n"
 		);
 }
 
@@ -63,6 +64,7 @@ struct arch_options_t arch_options = {
 	.console_vga = 0,
 	.console_serial = 0,
 	.core_header_type = CORE_TYPE_ELF64,
+	.pass_memmap_cmdline = 0,
 };
 
 int arch_process_options(int argc, char **argv)
@@ -126,6 +128,9 @@ int arch_process_options(int argc, char **argv)
 			}
 			arch_options.serial_baud = value;
 			break;
+		case OPT_PASS_MEMMAP_CMDLINE:
+			arch_options.pass_memmap_cmdline = 1;
+			break;
 		}
 	}
 	/* Reset getopt for the next pass; called in other source modules */
-- 
1.8.5.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
