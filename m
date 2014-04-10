Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WYB46-0007rn-W6
 for kexec@lists.infradead.org; Thu, 10 Apr 2014 09:14:35 +0000
From: WANG Chao <chaowang@redhat.com>
Subject: [PATCH v5 09/10] x86: Pass memory range via E820 for kdump
Date: Thu, 10 Apr 2014 17:13:06 +0800
Message-Id: <1397121186-9353-14-git-send-email-chaowang@redhat.com>
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

command line size is restricted by kernel, sometimes memmap=exactmap has
too many memory ranges to pass to cmdline. And also memmap=exactmap and
kASLR doesn't work together.

A better approach, to pass the memory ranges for crash kernel to boot
into, is filling the memory ranges into E820.

boot_params only got 128 slots for E820 map to fit in, when the number of
memory map exceeds 128, use setup_data to pass the rest as extended E820
memory map.

kexec boot could also benefit from setup_data in case E820 memory map
exceeds 128.

Now this new approach becomes default instead of memmap=exactmap.
saved_max_pfn users can specify --pass-memmap-cmdline to use the
exactmap approach.

Signed-off-by: WANG Chao <chaowang@redhat.com>
Tested-by: Linn Crosetto <linn@hp.com>
Reviewed-by: Linn Crosetto <linn@hp.com>
Signed-off-by: WANG Chao <chaowang@redhat.com>
---
 kexec/arch/i386/crashdump-x86.c   |   6 +-
 kexec/arch/i386/x86-linux-setup.c | 149 +++++++++++++++++++++++++-------------
 kexec/arch/i386/x86-linux-setup.h |   1 +
 3 files changed, 103 insertions(+), 53 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 2a6871d..2c0dbe3 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -979,7 +979,8 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	dbgprintf("Created elf header segment at 0x%lx\n", elfcorehdr);
 	if (delete_memmap(memmap_p, &nr_memmap_p, elfcorehdr, memsz) < 0)
 		return -1;
-	cmdline_add_memmap(mod_cmdline, memmap_p);
+	if (arch_options.pass_memmap_cmdline)
+		cmdline_add_memmap(mod_cmdline, memmap_p);
 	if (!bzImage_support_efi_boot)
 		cmdline_add_efi(mod_cmdline);
 	cmdline_add_elfcorehdr(mod_cmdline, elfcorehdr);
@@ -995,7 +996,8 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 		type = mem_range[i].type;
 		size = end - start;
 		add_memmap(memmap_p, &nr_memmap_p, start, size, type);
-		cmdline_add_memmap_acpi(mod_cmdline, start, end);
+		if (arch_options.pass_memmap_cmdline)
+			cmdline_add_memmap_acpi(mod_cmdline, start, end);
 	}
 
 	/* Store 2nd kernel boot memory ranges for later reference in
diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
index 8ed36cc..2f9bb97 100644
--- a/kexec/arch/i386/x86-linux-setup.c
+++ b/kexec/arch/i386/x86-linux-setup.c
@@ -36,8 +36,6 @@
 #include "x86-linux-setup.h"
 #include "../../kexec/kexec-syscall.h"
 
-#define SETUP_EFI	4
-
 void init_linux_parameters(struct x86_linux_param_header *real_mode)
 {
 	/* Fill in the values that are usually provided by the kernel. */
@@ -502,6 +500,11 @@ struct efi_setup_data {
 struct setup_data {
 	uint64_t next;
 	uint32_t type;
+#define SETUP_NONE	0
+#define SETUP_E820_EXT	1
+#define SETUP_DTB	2
+#define SETUP_PCI	3
+#define SETUP_EFI	4
 	uint32_t len;
 	uint8_t data[0];
 } __attribute__((packed));
@@ -684,6 +687,98 @@ out:
 	return ret;
 }
 
+static void add_e820_map_from_mr(struct x86_linux_param_header *real_mode,
+			struct e820entry *e820, struct memory_range *range, int nr_range)
+{
+	int i;
+
+	for (i = 0; i < nr_range; i++) {
+		e820[i].addr = range[i].start;
+		e820[i].size = range[i].end - range[i].start;
+		switch (range[i].type) {
+			case RANGE_RAM:
+				e820[i].type = E820_RAM;
+				break;
+			case RANGE_ACPI:
+				e820[i].type = E820_ACPI;
+				break;
+			case RANGE_ACPI_NVS:
+				e820[i].type = E820_NVS;
+				break;
+			default:
+			case RANGE_RESERVED:
+				e820[i].type = E820_RESERVED;
+				break;
+		}
+		dbgprintf("%016lx-%016lx (%d)\n",
+				e820[i].addr,
+				e820[i].addr + e820[i].size - 1,
+				e820[i].type);
+
+		if (range[i].type != RANGE_RAM)
+			continue;
+		if ((range[i].start <= 0x100000) && range[i].end > 0x100000) {
+			unsigned long long mem_k = (range[i].end >> 10) - (0x100000 >> 10);
+			real_mode->ext_mem_k = mem_k;
+			real_mode->alt_mem_k = mem_k;
+			if (mem_k > 0xfc00) {
+				real_mode->ext_mem_k = 0xfc00; /* 64M */
+			}
+			if (mem_k > 0xffffffff) {
+				real_mode->alt_mem_k = 0xffffffff;
+			}
+		}
+	}
+}
+
+static void setup_e820_ext(struct kexec_info *info, struct x86_linux_param_header *real_mode,
+			   struct memory_range *range, int nr_range)
+{
+	struct setup_data *sd;
+	struct e820entry *e820;
+	int nr_range_ext;
+
+	nr_range_ext = nr_range - E820MAX;
+	sd = xmalloc(sizeof(struct setup_data) + nr_range_ext * sizeof(struct e820entry));
+	sd->next = 0;
+	sd->len = nr_range_ext * sizeof(struct e820entry);
+	sd->type = SETUP_E820_EXT;
+
+	e820 = (struct e820entry *) sd->data;
+	dbgprintf("Extended E820 via setup_data:\n");
+	add_e820_map_from_mr(real_mode, e820, range + E820MAX, nr_range_ext);
+	add_setup_data(info, real_mode, sd);
+}
+
+static void setup_e820(struct kexec_info *info, struct x86_linux_param_header *real_mode)
+{
+	struct memory_range *range;
+	int nr_range, nr_range_saved;
+
+
+	if (info->kexec_flags & KEXEC_ON_CRASH && !arch_options.pass_memmap_cmdline) {
+		range = info->crash_range;
+		nr_range = info->nr_crash_ranges;
+	} else {
+		range = info->memory_range;
+		nr_range = info->memory_ranges;
+	}
+
+	nr_range_saved = nr_range;
+	if (nr_range > E820MAX) {
+		nr_range = E820MAX;
+	}
+
+	real_mode->e820_map_nr = nr_range;
+	dbgprintf("E820 memmap:\n");
+	add_e820_map_from_mr(real_mode, real_mode->e820_map, range, nr_range);
+
+	if (nr_range_saved > E820MAX) {
+		dbgprintf("extra E820 memmap are passed via setup_data\n");
+		setup_e820_ext(info, real_mode, range, nr_range_saved);
+	}
+}
+
 static int
 get_efi_mem_desc_version(struct x86_linux_param_header *real_mode)
 {
@@ -725,10 +820,6 @@ out:
 void setup_linux_system_parameters(struct kexec_info *info,
 				   struct x86_linux_param_header *real_mode)
 {
-	/* Fill in information the BIOS would usually provide */
-	struct memory_range *range;
-	int i, ranges;
-
 	/* get subarch from running kernel */
 	setup_subarch(real_mode);
 	if (bzImage_support_efi_boot)
@@ -769,51 +860,7 @@ void setup_linux_system_parameters(struct kexec_info *info,
 	/* another safe default */
 	real_mode->aux_device_info = 0;
 
-	range = info->memory_range;
-	ranges = info->memory_ranges;
-	if (ranges > E820MAX) {
-		if (!(info->kexec_flags & KEXEC_ON_CRASH))
-			/*
-			 * this e820 not used for capture kernel, see
-			 * do_bzImage_load()
-			 */
-			fprintf(stderr,
-				"Too many memory ranges, truncating...\n");
-		ranges = E820MAX;
-	}
-	real_mode->e820_map_nr = ranges;
-	for(i = 0; i < ranges; i++) {
-		real_mode->e820_map[i].addr = range[i].start;
-		real_mode->e820_map[i].size = range[i].end - range[i].start;
-		switch (range[i].type) {
-		case RANGE_RAM:
-			real_mode->e820_map[i].type = E820_RAM; 
-			break;
-		case RANGE_ACPI:
-			real_mode->e820_map[i].type = E820_ACPI; 
-			break;
-		case RANGE_ACPI_NVS:
-			real_mode->e820_map[i].type = E820_NVS;
-			break;
-		default:
-		case RANGE_RESERVED:
-			real_mode->e820_map[i].type = E820_RESERVED; 
-			break;
-		}
-		if (range[i].type != RANGE_RAM)
-			continue;
-		if ((range[i].start <= 0x100000) && range[i].end > 0x100000) {
-			unsigned long long mem_k = (range[i].end >> 10) - (0x100000 >> 10);
-			real_mode->ext_mem_k = mem_k;
-			real_mode->alt_mem_k = mem_k;
-			if (mem_k > 0xfc00) {
-				real_mode->ext_mem_k = 0xfc00; /* 64M */
-			}
-			if (mem_k > 0xffffffff) {
-				real_mode->alt_mem_k = 0xffffffff;
-			}
-		}
-	}
+	setup_e820(info, real_mode);
 
 	/* fill the EDD information */
 	setup_edd_info(real_mode);
diff --git a/kexec/arch/i386/x86-linux-setup.h b/kexec/arch/i386/x86-linux-setup.h
index 6fb84b4..f5d23d3 100644
--- a/kexec/arch/i386/x86-linux-setup.h
+++ b/kexec/arch/i386/x86-linux-setup.h
@@ -30,5 +30,6 @@ void setup_linux_system_parameters(struct kexec_info *info,
 /* command line parameter may be appended by purgatory */
 #define PURGATORY_CMDLINE_SIZE 64
 extern int bzImage_support_efi_boot;
+extern struct arch_options_t arch_options;
 
 #endif /* X86_LINUX_SETUP_H */
-- 
1.8.5.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
