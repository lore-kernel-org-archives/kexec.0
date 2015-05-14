Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ysm82-0003Rn-BK
 for kexec@lists.infradead.org; Thu, 14 May 2015 05:56:19 +0000
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH V2 10/11] arm64: kdump: Add support for binary image
Date: Thu, 14 May 2015 11:25:38 +0530
Message-Id: <f174260962e17c5ee67a298c0a911900367c6ae0.1431582203.git.panand@redhat.com>
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

This patch adds support to use binary image ie arch/arm64/boot/Image
with kdump.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 kexec/arch/arm64/kexec-image-arm64.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/kexec/arch/arm64/kexec-image-arm64.c b/kexec/arch/arm64/kexec-image-arm64.c
index c577b96d5e31..6f8a6590639a 100644
--- a/kexec/arch/arm64/kexec-image-arm64.c
+++ b/kexec/arch/arm64/kexec-image-arm64.c
@@ -10,6 +10,7 @@
 #include <libfdt.h>
 #include <stdlib.h>
 
+#include "crashdump-arm64.h"
 #include "dt-ops.h"
 #include "image-header.h"
 #include "kexec-arm64.h"
@@ -97,13 +98,23 @@ int image_arm64_load(int argc, char **argv, const char *kernel_buf,
 
 	arm64_mem.page_offset = get_kernel_page_offset();
 
-	result = parse_iomem_single("Kernel code\n", &start, NULL);
+	if (info->kexec_flags & KEXEC_ON_CRASH) {
+		result = load_crashdump_segments(info, &header_option);
 
-	if (result) {
-		fprintf(stderr, "kexec: Could not get kernel code address.\n");
-		return -1;
+		if (result) {
+			fprintf(stderr, "kexec: load crashdump segments failed.\n");
+			return -1;
+		}
+		start = crash_reserved_mem.start;
+	} else {
+		result = parse_iomem_single("Kernel code\n", &start, NULL);
+
+		if (result) {
+			fprintf(stderr, "kexec: Could not get kernel code address.\n");
+			return -1;
+		}
+		start -= arm64_mem.text_offset;
 	}
-	start -= arm64_mem.text_offset;
 
 	/* Add kernel */
 	add_segment_phys_virt(info, kernel_buf, kernel_size,
@@ -112,7 +123,8 @@ int image_arm64_load(int argc, char **argv, const char *kernel_buf,
 
 	info->entry = (void *)start + arm64_mem.text_offset;
 
-	result = arm64_load_other_segments(info, (unsigned long)info->entry);
+	result = arm64_load_other_segments(info, (unsigned long)info->entry,
+		header_option);
 
 	if (header_option)
 		free(header_option);
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
