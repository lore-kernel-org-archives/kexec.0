Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x22b.google.com ([2607:f8b0:400e:c03::22b])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bWwHH-0000HN-B7
 for kexec@lists.infradead.org; Tue, 09 Aug 2016 01:56:33 +0000
Received: by mail-pa0-x22b.google.com with SMTP id iw10so172493pac.2
 for <kexec@lists.infradead.org>; Mon, 08 Aug 2016 18:56:03 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 7/7] arm64: kdump: Add support for binary image files
Date: Tue,  9 Aug 2016 11:00:32 +0900
Message-Id: <20160809020032.28654-8-takahiro.akashi@linaro.org>
In-Reply-To: <20160809020032.28654-1-takahiro.akashi@linaro.org>
References: <20160809020032.28654-1-takahiro.akashi@linaro.org>
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
To: horms@verge.net.au
Cc: geoff@infradead.org, panand@redhat.com, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>

From: Pratyush Anand <panand@redhat.com>

This patch adds support to use binary image ie arch/arm64/boot/Image with
kdump.

Binary image does not have sufficient knowledge to extract page offset
information, which is needed by kexec tool (specially vmcore-dmesg). Use a
new command parameter --page-offset, so that user can provide page offset
information for linear mapping.

Signed-off-by: Pratyush Anand <panand@redhat.com>
[takahiro.akashi@linaro.org: a bit reworked]
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 kexec/arch/arm64/include/arch/options.h |  8 +++--
 kexec/arch/arm64/kexec-arm64.c          |  5 +++
 kexec/arch/arm64/kexec-image-arm64.c    | 60 +++++++++++++++++++++++++++++----
 3 files changed, 65 insertions(+), 8 deletions(-)

diff --git a/kexec/arch/arm64/include/arch/options.h b/kexec/arch/arm64/include/arch/options.h
index a17d933..3283985 100644
--- a/kexec/arch/arm64/include/arch/options.h
+++ b/kexec/arch/arm64/include/arch/options.h
@@ -5,7 +5,8 @@
 #define OPT_DTB			((OPT_MAX)+1)
 #define OPT_INITRD		((OPT_MAX)+2)
 #define OPT_REUSE_CMDLINE	((OPT_MAX)+3)
-#define OPT_ARCH_MAX		((OPT_MAX)+4)
+#define OPT_PAGE_OFFSET		((OPT_MAX)+4)
+#define OPT_ARCH_MAX		((OPT_MAX)+5)
 
 #define KEXEC_ARCH_OPTIONS \
 	KEXEC_OPTIONS \
@@ -15,6 +16,7 @@
 	{ "initrd",        1, NULL, OPT_INITRD }, \
 	{ "ramdisk",       1, NULL, OPT_INITRD }, \
 	{ "reuse-cmdline", 0, NULL, OPT_REUSE_CMDLINE }, \
+	{ "page-offset",   1, NULL, OPT_PAGE_OFFSET }, \
 
 #define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR /* Only accept long arch options. */
 #define KEXEC_ALL_OPTIONS KEXEC_ARCH_OPTIONS
@@ -26,12 +28,14 @@ static const char arm64_opts_usage[] __attribute__ ((unused)) =
 "     --dtb=FILE            Use FILE as the device tree blob.\n"
 "     --initrd=FILE         Use FILE as the kernel initial ramdisk.\n"
 "     --ramdisk=FILE        Use FILE as the kernel initial ramdisk.\n"
-"     --reuse-cmdline       Use kernel command line from running system.\n";
+"     --reuse-cmdline       Use kernel command line from running system.\n"
+"     --page-offset=OFFSET  Use OFFSET as current kernel's page_offset value.\n";
 
 struct arm64_opts {
 	const char *command_line;
 	const char *dtb;
 	const char *initrd;
+	uint64_t page_offset;
 };
 
 extern struct arm64_opts arm64_opts;
diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 83ad966..959f4bb 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -126,6 +126,9 @@ int arch_process_options(int argc, char **argv)
 		case OPT_INITRD:
 			arm64_opts.initrd = optarg;
 			break;
+		case OPT_PAGE_OFFSET:
+			arm64_opts.page_offset = strtoull(optarg, NULL, 0);
+			break;
 		default:
 			break; /* Ignore core and unknown options. */
 		}
@@ -138,6 +141,8 @@ int arch_process_options(int argc, char **argv)
 	dbgprintf("%s:%d: initrd: %s\n", __func__, __LINE__,
 		arm64_opts.initrd);
 	dbgprintf("%s:%d: dtb: %s\n", __func__, __LINE__, arm64_opts.dtb);
+	dbgprintf("%s:%d: page_offset: %016lx\n", __func__, __LINE__,
+						arm64_opts.page_offset);
 
 	return 0;
 }
diff --git a/kexec/arch/arm64/kexec-image-arm64.c b/kexec/arch/arm64/kexec-image-arm64.c
index cad7c73..90e8a87 100644
--- a/kexec/arch/arm64/kexec-image-arm64.c
+++ b/kexec/arch/arm64/kexec-image-arm64.c
@@ -4,9 +4,15 @@
 
 #define _GNU_SOURCE
 
-#include <errno.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <arch/options.h>
 
+#include "../../kexec.h"
+#include "../../crashdump.h"
+#include "crashdump-arm64.h"
 #include "kexec-arm64.h"
+#include "kexec-syscall.h"
 
 int image_arm64_probe(const char *kernel_buf, off_t kernel_size)
 {
@@ -27,16 +33,44 @@ int image_arm64_probe(const char *kernel_buf, off_t kernel_size)
 	return 0;
 }
 
+static uint64_t get_kernel_page_offset(void)
+{
+	uint64_t text_page_offset;
+
+	/* 2MB-aligned */
+	text_page_offset = get_kernel_sym("_text") & (UINT64_MAX << 21);
+
+	if (arm64_opts.page_offset) {
+		if (text_page_offset != arm64_opts.page_offset)
+			dbgprintf("%s: User page offset %lx did not match with text page offset %lx\n", __func__,
+				arm64_opts.page_offset, text_page_offset);
+		return arm64_opts.page_offset;
+	} else if (text_page_offset) {
+		dbgprintf("%s: text page offset is %lx\n", __func__,
+						text_page_offset);
+		return text_page_offset;
+	} else {
+		return UINT64_MAX;
+	}
+}
+
 int image_arm64_load(int argc, char **argv, const char *kernel_buf,
 	off_t kernel_size, struct kexec_info *info)
 {
 	const struct arm64_image_header *h;
-	unsigned long image_base;
+	uint64_t image_base;
+	int result;
 
 	h = (const struct arm64_image_header *)(kernel_buf);
 
 	if (arm64_process_image_header(h))
-		return -EINVAL;
+		return -1;
+
+	arm64_mem.page_offset = get_kernel_page_offset();
+	if (arm64_mem.page_offset == UINT64_MAX) {
+		fprintf(stderr, "kexec: page_offset is not specified\n");
+		return -1;
+	}
 
 	dbgprintf("%s: text_offset:   %016lx\n", __func__,
 		arm64_mem.text_offset);
@@ -44,11 +78,24 @@ int image_arm64_load(int argc, char **argv, const char *kernel_buf,
 		arm64_mem.image_size);
 	dbgprintf("%s: phys_offset:   %016lx\n", __func__,
 		arm64_mem.phys_offset);
+	dbgprintf("%s: page_offset:   %016lx\n", __func__,
+		arm64_mem.page_offset);
 	dbgprintf("%s: PE format:     %s\n", __func__,
 		(arm64_header_check_pe_sig(h) ? "yes" : "no"));
 
-	image_base = get_phys_offset() + arm64_mem.text_offset;
-	
+	if (info->kexec_flags & KEXEC_ON_CRASH) {
+		result = load_crashdump_segments(info);
+
+		if (result) {
+			fprintf(stderr,
+				"kexec: load crashdump segments failed.\n");
+			return -1;
+		}
+		image_base = crash_reserved_mem.start + arm64_mem.text_offset;
+	} else {
+		image_base = get_phys_offset() + arm64_mem.text_offset;
+	}
+
 	add_segment_phys_virt(info, kernel_buf, kernel_size, image_base,
 		arm64_mem.image_size, 0);
 
@@ -59,5 +106,6 @@ void image_arm64_usage(void)
 {
 	printf(
 "     An ARM64 binary image, compressed or not, big or little endian.\n"
-"     Typically an Image, Image.gz or Image.lzma file.\n\n");
+"     Typically an Image, Image.gz or Image.lzma file.\n"
+"     --page-offset         Kernel page-offset for binary image load.\n\n");
 }
-- 
2.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
