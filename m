Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ysm7v-0003Qc-5L
 for kexec@lists.infradead.org; Thu, 14 May 2015 05:56:14 +0000
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH V2 01/11] arm64: Kexec: Add support for binary image
Date: Thu, 14 May 2015 11:25:37 +0530
Message-Id: <4b599a3d32de82a5c14b91e3cabc4b4cf1298c7c.1431582203.git.panand@redhat.com>
In-Reply-To: <cover.1431582203.git.panand@redhat.com>
References: <cover.1431582203.git.panand@redhat.com>
In-Reply-To: <cover.1431582203.git.panand@redhat.com>
References: <cover.1431582203.git.panand@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: geoff@infradead.org
Cc: Pratyush Anand <panand@redhat.com>, takahiro.akashi@linaro.org, kexec@lists.infradead.org

This patch adds support to use binary image ie arch/arm64/boot/Image.

Binary image does not have sufficient knowledge to extract page offset
information, which is needed by kexec tool. Use a new command parameter
--page-offset, so that user can provide page offset information for
linear mapping.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 kexec/arch/arm64/include/arch/options.h |  9 ++--
 kexec/arch/arm64/kexec-arm64.c          |  3 ++
 kexec/arch/arm64/kexec-arm64.h          |  2 +
 kexec/arch/arm64/kexec-image-arm64.c    | 86 +++++++++++++++++++++++++++++++--
 4 files changed, 93 insertions(+), 7 deletions(-)

diff --git a/kexec/arch/arm64/include/arch/options.h b/kexec/arch/arm64/include/arch/options.h
index afe3e9827ff3..fa4ad2c68642 100644
--- a/kexec/arch/arm64/include/arch/options.h
+++ b/kexec/arch/arm64/include/arch/options.h
@@ -5,9 +5,10 @@
 #define OPT_DTB		((OPT_MAX)+1)
 #define OPT_INITRD	((OPT_MAX)+2)
 #define OPT_LITE	((OPT_MAX)+3)
-#define OPT_PORT	((OPT_MAX)+4)
-#define OPT_REUSE_CMDLINE	((OPT_MAX+5))
-#define OPT_ARCH_MAX	((OPT_MAX)+6)
+#define OPT_PAGE_OFFSET	((OPT_MAX)+4)
+#define OPT_PORT	((OPT_MAX)+5)
+#define OPT_REUSE_CMDLINE	((OPT_MAX+6))
+#define OPT_ARCH_MAX	((OPT_MAX)+7)
 
 #define KEXEC_ARCH_OPTIONS \
 	KEXEC_OPTIONS \
@@ -16,6 +17,7 @@
 	{ "dtb",          1, NULL, OPT_DTB }, \
 	{ "initrd",       1, NULL, OPT_INITRD }, \
 	{ "lite",         0, NULL, OPT_LITE }, \
+	{ "page-offset",  1, NULL, OPT_PAGE_OFFSET }, \
 	{ "port",         1, NULL, OPT_PORT }, \
 	{ "ramdisk",      1, NULL, OPT_INITRD }, \
 	{ "reuse-cmdline", 0, NULL, OPT_REUSE_CMDLINE }, \
@@ -38,6 +40,7 @@ struct arm64_opts {
 	const char *command_line;
 	const char *dtb;
 	const char *initrd;
+	uint64_t page_offset;
 	uint64_t port;
 	int lite;
 };
diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 6398e55fe575..86408598a465 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -100,6 +100,9 @@ int arch_process_options(int argc, char **argv)
 		case OPT_PORT:
 			arm64_opts.port = strtoull(optarg, NULL, 0);
 			break;
+		case OPT_PAGE_OFFSET:
+			arm64_opts.page_offset = strtoull(optarg, NULL, 0);
+			break;
 		default:
 			break; /* Ignore core and unknown options. */
 		}
diff --git a/kexec/arch/arm64/kexec-arm64.h b/kexec/arch/arm64/kexec-arm64.h
index 057acf313b49..7f0ca13fec11 100644
--- a/kexec/arch/arm64/kexec-arm64.h
+++ b/kexec/arch/arm64/kexec-arm64.h
@@ -17,6 +17,8 @@
 #define BOOT_BLOCK_LAST_COMP_VERSION 16
 #define COMMAND_LINE_SIZE 512
 
+#define ARM64_DEFAULT_PAGE_OFFSET 0xfffffe0000000000
+
 int elf_arm64_probe(const char *kernel_buf, off_t kernel_size);
 int elf_arm64_load(int argc, char **argv, const char *kernel_buf,
 	off_t kernel_size, struct kexec_info *info);
diff --git a/kexec/arch/arm64/kexec-image-arm64.c b/kexec/arch/arm64/kexec-image-arm64.c
index b025dc6c0185..c577b96d5e31 100644
--- a/kexec/arch/arm64/kexec-image-arm64.c
+++ b/kexec/arch/arm64/kexec-image-arm64.c
@@ -8,6 +8,7 @@
 #include <errno.h>
 #include <getopt.h>
 #include <libfdt.h>
+#include <stdlib.h>
 
 #include "dt-ops.h"
 #include "image-header.h"
@@ -31,20 +32,97 @@ int image_arm64_probe(const char *kernel_buf, off_t kernel_size)
 	dbgprintf("%s: PE format: %s\n", __func__,
 		(arm64_header_check_pe_sig(h) ? "yes" : "no"));
 
-	fprintf(stderr, "kexec: arm64 binary Image files are currently NOT SUPPORTED.\n");
+	return 0;
+}
+
+static unsigned long long get_kernel_text_sym(void)
+{
+	const char *kallsyms = "/proc/kallsyms";
+	const char *text = "_text";
+	char sym[128];
+	char line[128];
+	FILE *fp;
+	unsigned long long vaddr;
+	char type;
 
-	return -1;
+	fp = fopen(kallsyms, "r");	if (!fp) {
+		fprintf(stderr, "Cannot open %s\n", kallsyms);
+		return 0;
+	}
+
+	while(fgets(line, sizeof(line), fp) != NULL) {
+		if (sscanf(line, "%Lx %c %s", &vaddr, &type, sym) != 3)
+			continue;
+		if (strcmp(sym, text) == 0) {
+			dbgprintf("kernel symbol %s vaddr = %16llx\n", text, vaddr);
+			return vaddr;
+		}
+	}
+
+	fprintf(stderr, "Cannot get kernel %s symbol address\n", text);
+	return 0;
+}
+
+static unsigned long long get_kernel_page_offset(void)
+{
+	unsigned long long text_sym_addr = get_kernel_text_sym();
+	unsigned long long text_page_offset =
+		text_sym_addr & 0xFFFFFFFFFFE00000;
+
+	if(arm64_opts.page_offset) {
+		if (text_page_offset != arm64_opts.page_offset)
+			dbgprintf("User page offset %lx did not match with text page offset %llx\n",
+					arm64_opts.page_offset, text_page_offset); 
+		return arm64_opts.page_offset;
+	} else if(text_page_offset) {
+		dbgprintf("text page offset is %llx\n", text_page_offset);
+		return text_page_offset;
+	} else {
+		return ARM64_DEFAULT_PAGE_OFFSET;
+	}
 }
 
 int image_arm64_load(int argc, char **argv, const char *kernel_buf,
 	off_t kernel_size, struct kexec_info *info)
 {
-	return -ENOSYS;
+	int result;
+	uint64_t start;
+	const struct arm64_image_header *h;
+	char *header_option = NULL;
+
+	h = (const struct arm64_image_header *)(kernel_buf);
+
+	arm64_mem.text_offset = le64_to_cpu(h->text_offset);
+	arm64_mem.image_size = le64_to_cpu(h->image_size);
+
+	arm64_mem.page_offset = get_kernel_page_offset();
+
+	result = parse_iomem_single("Kernel code\n", &start, NULL);
+
+	if (result) {
+		fprintf(stderr, "kexec: Could not get kernel code address.\n");
+		return -1;
+	}
+	start -= arm64_mem.text_offset;
+
+	/* Add kernel */
+	add_segment_phys_virt(info, kernel_buf, kernel_size,
+			start + arm64_mem.text_offset,
+			kernel_size, 0);
+
+	info->entry = (void *)start + arm64_mem.text_offset;
+
+	result = arm64_load_other_segments(info, (unsigned long)info->entry);
+
+	if (header_option)
+		free(header_option);
+
+	return result;
 }
 
 void image_arm64_usage(void)
 {
 	printf(
 "     An arm64 binary Image file, big or little endian.\n"
-"     This file type is currently NOT SUPPORTED.\n\n");
+"     --page-offset         Kernel page-offset for binary image load.\n");
 }
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
