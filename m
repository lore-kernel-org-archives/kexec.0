Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x230.google.com ([2607:f8b0:400e:c00::230])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bRxJ6-0000ZC-MX
 for kexec@lists.infradead.org; Tue, 26 Jul 2016 08:01:45 +0000
Received: by mail-pf0-x230.google.com with SMTP id h186so72853106pfg.3
 for <kexec@lists.infradead.org>; Tue, 26 Jul 2016 01:01:20 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH 6/6] arm64: kdump: Add support for binary image
Date: Tue, 26 Jul 2016 17:05:25 +0900
Message-Id: <20160726080525.2539-7-takahiro.akashi@linaro.org>
In-Reply-To: <20160726080525.2539-1-takahiro.akashi@linaro.org>
References: <20160726080525.2539-1-takahiro.akashi@linaro.org>
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

This patch adds support to use binary image ie arch/arm64/boot/Image
with kdump.

Signed-off-by: Pratyush Anand <panand@redhat.com>
[takahiro.akashi@linaro.org: a bit reworked]
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 kexec/arch/arm64/kexec-image-arm64.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/arm64/kexec-image-arm64.c b/kexec/arch/arm64/kexec-image-arm64.c
index cad7c73..fe1e145 100644
--- a/kexec/arch/arm64/kexec-image-arm64.c
+++ b/kexec/arch/arm64/kexec-image-arm64.c
@@ -6,7 +6,9 @@
 
 #include <errno.h>
 
+#include "crashdump-arm64.h"
 #include "kexec-arm64.h"
+#include "kexec-syscall.h"
 
 int image_arm64_probe(const char *kernel_buf, off_t kernel_size)
 {
@@ -32,6 +34,7 @@ int image_arm64_load(int argc, char **argv, const char *kernel_buf,
 {
 	const struct arm64_image_header *h;
 	unsigned long image_base;
+	int result;
 
 	h = (const struct arm64_image_header *)(kernel_buf);
 
@@ -47,8 +50,19 @@ int image_arm64_load(int argc, char **argv, const char *kernel_buf,
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
 
-- 
2.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
