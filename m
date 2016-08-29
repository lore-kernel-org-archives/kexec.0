Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x22c.google.com ([2607:f8b0:400e:c00::22c])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1beHqU-0006Ns-6N
 for kexec@lists.infradead.org; Mon, 29 Aug 2016 08:23:07 +0000
Received: by mail-pf0-x22c.google.com with SMTP id h186so49673427pfg.3
 for <kexec@lists.infradead.org>; Mon, 29 Aug 2016 01:22:45 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH 2/2] fixup! arm64: Add support for binary image files
Date: Mon, 29 Aug 2016 17:28:41 +0900
Message-Id: <20160829082841.3750-3-takahiro.akashi@linaro.org>
In-Reply-To: <20160829082841.3750-1-takahiro.akashi@linaro.org>
References: <20160829082841.3750-1-takahiro.akashi@linaro.org>
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
To: horms@verge.net.au, geoff@infradead.org
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, kexec@lists.infradead.org

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 kexec/arch/arm64/kexec-image-arm64.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/kexec/arch/arm64/kexec-image-arm64.c b/kexec/arch/arm64/kexec-image-arm64.c
index b77b63e..77cff59 100644
--- a/kexec/arch/arm64/kexec-image-arm64.c
+++ b/kexec/arch/arm64/kexec-image-arm64.c
@@ -3,7 +3,9 @@
  */
 
 #define _GNU_SOURCE
+
 #include "kexec-arm64.h"
+#include <limits.h>
 
 int image_arm64_probe(const char *kernel_buf, off_t kernel_size)
 {
@@ -29,27 +31,44 @@ int image_arm64_load(int argc, char **argv, const char *kernel_buf,
 {
 	const struct arm64_image_header *h;
 	unsigned long image_base;
+	int result;
 
 	h = (const struct arm64_image_header *)(kernel_buf);
 
 	if (arm64_process_image_header(h))
 		return -1;
 
+        image_base = arm64_locate_kernel_segment(info);
+        if (image_base == ULONG_MAX) {
+                dbgprintf("%s: Kernel segment is not allocated\n", __func__);
+                result = -EFAILED;
+                goto exit;
+        }
+
+	dbgprintf("%s: image_base:    %016lx\n", __func__, image_base);
 	dbgprintf("%s: text_offset:   %016lx\n", __func__,
 		arm64_mem.text_offset);
 	dbgprintf("%s: image_size:    %016lx\n", __func__,
 		arm64_mem.image_size);
 	dbgprintf("%s: phys_offset:   %016lx\n", __func__,
 		arm64_mem.phys_offset);
+	dbgprintf("%s: vp_offset:     %016lx\n", __func__,
+		arm64_mem.vp_offset);
 	dbgprintf("%s: PE format:     %s\n", __func__,
 		(arm64_header_check_pe_sig(h) ? "yes" : "no"));
 
-	image_base = get_phys_offset() + arm64_mem.text_offset;
-	
-	add_segment_phys_virt(info, kernel_buf, kernel_size, image_base,
-		arm64_mem.image_size, 0);
+	/* load the kernel */
+	add_segment_phys_virt(info, kernel_buf, kernel_size,
+			image_base + arm64_mem.text_offset,
+			arm64_mem.image_size, 0);
+
+	result = arm64_load_other_segments(info,
+			image_base + arm64_mem.text_offset);
 
-	return arm64_load_other_segments(info, image_base);
+exit:
+        if (result)
+                fprintf(stderr, "kexec: load failed.\n");
+        return result;
 }
 
 void image_arm64_usage(void)
-- 
2.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
