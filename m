Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KFdPW-0002bj-5R
	for kexec@lists.infradead.org; Sun, 06 Jul 2008 23:12:51 +0000
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH 1/5] Remove trailing whitespace
Date: Mon,  7 Jul 2008 01:13:24 +0200
Message-Id: <1215386008-16271-2-git-send-email-bwalle@suse.de>
In-Reply-To: <1215386008-16271-1-git-send-email-bwalle@suse.de>
References: <1215386008-16271-1-git-send-email-bwalle@suse.de>
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
Cc: Bernhard Walle <bwalle@suse.de>, Bernhard Walle <bernhard.walle@gmx.de>, vgoyal@redhat.com

From: Bernhard Walle <bernhard.walle@gmx.de>

This patch just removes trailing whitespace from kexec/arch/i386/kexec-x86.c
before modifying something.


Signed-off-by: Bernhard Walle <bwalle@suse.de>
---
 kexec/arch/i386/kexec-x86.c      |   28 ++++++++++++++--------------
 kexec/arch/x86_64/kexec-x86_64.c |   26 +++++++++++++-------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/kexec/arch/i386/kexec-x86.c b/kexec/arch/i386/kexec-x86.c
index 89ccb0b..31e4752 100644
--- a/kexec/arch/i386/kexec-x86.c
+++ b/kexec/arch/i386/kexec-x86.c
@@ -44,7 +44,7 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 	FILE *fp;
 	fp = fopen(iomem, "r");
 	if (!fp) {
-		fprintf(stderr, "Cannot open %s: %s\n", 
+		fprintf(stderr, "Cannot open %s: %s\n",
 			iomem, strerror(errno));
 		return -1;
 	}
@@ -58,7 +58,7 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 			break;
 		count = sscanf(line, "%Lx-%Lx : %n",
 			&start, &end, &consumed);
-		if (count != 2) 
+		if (count != 2)
 			continue;
 		str = line + consumed;
 		end = end + 1;
@@ -68,7 +68,7 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 #endif
 		if (memcmp(str, "System RAM\n", 11) == 0) {
 			type = RANGE_RAM;
-		} 
+		}
 		else if (memcmp(str, "reserved\n", 9) == 0) {
 			type = RANGE_RESERVED;
 		}
@@ -115,7 +115,7 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 }
 
 struct file_type file_type[] = {
-	{ "multiboot-x86", multiboot_x86_probe, multiboot_x86_load, 
+	{ "multiboot-x86", multiboot_x86_probe, multiboot_x86_load,
 	  multiboot_x86_usage },
 	{ "elf-x86", elf_x86_probe, elf_x86_load, elf_x86_usage },
 	{ "bzImage", bzImage_probe, bzImage_load, bzImage_usage },
@@ -187,24 +187,24 @@ int arch_process_options(int argc, char **argv)
 				}
 			}
 			if (value >= 65536) {
-				fprintf(stderr, "Bad serial port base '%s'\n", 
+				fprintf(stderr, "Bad serial port base '%s'\n",
 					optarg);
 				usage();
 				return -1;
-				
+
 			}
 			arch_options.serial_base = value;
 			break;
 		case OPT_SERIAL_BAUD:
 			value = strtoul(optarg, &end, 0);
-			if ((value > 115200) || ((115200 %value) != 0) || 
-				(value < 9600) || (*end)) 
+			if ((value > 115200) || ((115200 %value) != 0) ||
+				(value < 9600) || (*end))
 			{
 				fprintf(stderr, "Bad serial port baud rate '%s'\n",
 					optarg);
 				usage();
 				return -1;
-				
+
 			}
 			arch_options.serial_baud = value;
 			break;
@@ -239,13 +239,13 @@ int arch_compat_trampoline(struct kexec_info *info)
 	if ((info->kexec_flags & KEXEC_ARCH_MASK) == KEXEC_ARCH_X86_64)
 	{
 		if (!info->rhdr.e_shdr) {
-			fprintf(stderr, 
+			fprintf(stderr,
 				"A trampoline is required for cross architecture support\n");
 			return -1;
 		}
 		elf_rel_set_symbol(&info->rhdr, "compat_x86_64_entry32",
 			&info->entry, sizeof(info->entry));
-		
+
 		info->entry = (void *)elf_rel_get_addr(&info->rhdr, "compat_x86_64");
 	}
 	return 0;
@@ -259,11 +259,11 @@ void arch_update_purgatory(struct kexec_info *info)
 		&arch_options.reset_vga, sizeof(arch_options.reset_vga));
 	elf_rel_set_symbol(&info->rhdr, "serial_base",
 		&arch_options.serial_base, sizeof(arch_options.serial_base));
-	elf_rel_set_symbol(&info->rhdr, "serial_baud", 
+	elf_rel_set_symbol(&info->rhdr, "serial_baud",
 		&arch_options.serial_baud, sizeof(arch_options.serial_baud));
-	elf_rel_set_symbol(&info->rhdr, "console_vga", 
+	elf_rel_set_symbol(&info->rhdr, "console_vga",
 		&arch_options.console_vga, sizeof(arch_options.console_vga));
-	elf_rel_set_symbol(&info->rhdr, "console_serial", 
+	elf_rel_set_symbol(&info->rhdr, "console_serial",
 		&arch_options.console_serial, sizeof(arch_options.console_serial));
 	if (info->kexec_flags & KEXEC_ON_CRASH) {
 		panic_kernel = 1;
diff --git a/kexec/arch/x86_64/kexec-x86_64.c b/kexec/arch/x86_64/kexec-x86_64.c
index 5fef6ef..d0b3e90 100644
--- a/kexec/arch/x86_64/kexec-x86_64.c
+++ b/kexec/arch/x86_64/kexec-x86_64.c
@@ -45,7 +45,7 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 	FILE *fp;
 	fp = fopen(iomem, "r");
 	if (!fp) {
-		fprintf(stderr, "Cannot open %s: %s\n", 
+		fprintf(stderr, "Cannot open %s: %s\n",
 			iomem, strerror(errno));
 		return -1;
 	}
@@ -59,7 +59,7 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 			break;
 		count = sscanf(line, "%Lx-%Lx : %n",
 			&start, &end, &consumed);
-		if (count != 2) 
+		if (count != 2)
 			continue;
 		str = line + consumed;
 		end = end + 1;
@@ -69,7 +69,7 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 #endif
 		if (memcmp(str, "System RAM\n", 11) == 0) {
 			type = RANGE_RAM;
-		} 
+		}
 		else if (memcmp(str, "reserved\n", 9) == 0) {
 			type = RANGE_RESERVED;
 		}
@@ -117,7 +117,7 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 
 struct file_type file_type[] = {
 	{ "elf-x86_64", elf_x86_64_probe, elf_x86_64_load, elf_x86_64_usage },
-	{ "multiboot-x86", multiboot_x86_probe, multiboot_x86_load, 
+	{ "multiboot-x86", multiboot_x86_probe, multiboot_x86_load,
 	  multiboot_x86_usage },
 	{ "elf-x86", elf_x86_probe, elf_x86_load, elf_x86_usage },
 	{ "bzImage", bzImage_probe, bzImage_load, bzImage_usage },
@@ -194,24 +194,24 @@ int arch_process_options(int argc, char **argv)
 				}
 			}
 			if (value >= 65536) {
-				fprintf(stderr, "Bad serial port base '%s'\n", 
+				fprintf(stderr, "Bad serial port base '%s'\n",
 					optarg);
 				usage();
 				return -1;
-				
+
 			}
 			arch_options.serial_base = value;
 			break;
 		case OPT_SERIAL_BAUD:
 			value = strtoul(optarg, &end, 0);
-			if ((value > 115200) || ((115200 %value) != 0) || 
-				(value < 9600) || (*end)) 
+			if ((value > 115200) || ((115200 %value) != 0) ||
+				(value < 9600) || (*end))
 			{
 				fprintf(stderr, "Bad serial port baud rate '%s'\n",
 					optarg);
 				usage();
 				return -1;
-				
+
 			}
 			arch_options.serial_baud = value;
 			break;
@@ -242,13 +242,13 @@ void arch_update_purgatory(struct kexec_info *info)
 
 	elf_rel_set_symbol(&info->rhdr, "reset_vga",
 		&arch_options.reset_vga, sizeof(arch_options.reset_vga));
-	elf_rel_set_symbol(&info->rhdr, "serial_base", 
+	elf_rel_set_symbol(&info->rhdr, "serial_base",
 		&arch_options.serial_base, sizeof(arch_options.serial_base));
-	elf_rel_set_symbol(&info->rhdr, "serial_baud", 
+	elf_rel_set_symbol(&info->rhdr, "serial_baud",
 		&arch_options.serial_baud, sizeof(arch_options.serial_baud));
-	elf_rel_set_symbol(&info->rhdr, "console_vga", 
+	elf_rel_set_symbol(&info->rhdr, "console_vga",
 		&arch_options.console_vga, sizeof(arch_options.console_vga));
-	elf_rel_set_symbol(&info->rhdr, "console_serial", 
+	elf_rel_set_symbol(&info->rhdr, "console_serial",
 		&arch_options.console_serial, sizeof(arch_options.console_serial));
 
 	if (info->kexec_flags & KEXEC_ON_CRASH) {
-- 
1.5.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
