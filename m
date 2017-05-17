Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x229.google.com ([2607:f8b0:400e:c00::229])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dArpY-0000n3-RF
 for kexec@lists.infradead.org; Wed, 17 May 2017 05:49:06 +0000
Received: by mail-pf0-x229.google.com with SMTP id 9so1837618pfj.1
 for <kexec@lists.infradead.org>; Tue, 16 May 2017 22:48:48 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v7 10/10] arm64: kdump: Add support for binary image files
Date: Wed, 17 May 2017 14:51:50 +0900
Message-Id: <20170517055150.12601-11-takahiro.akashi@linaro.org>
In-Reply-To: <20170517055150.12601-1-takahiro.akashi@linaro.org>
References: <20170517055150.12601-1-takahiro.akashi@linaro.org>
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

Signed-off-by: Pratyush Anand <panand@redhat.com>
[takahiro.akashi@linaro.org: a bit reworked]
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 kexec/arch/arm64/kexec-image-arm64.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kexec/arch/arm64/kexec-image-arm64.c b/kexec/arch/arm64/kexec-image-arm64.c
index e5f2a9b..e1b1e54 100644
--- a/kexec/arch/arm64/kexec-image-arm64.c
+++ b/kexec/arch/arm64/kexec-image-arm64.c
@@ -4,7 +4,9 @@
 
 #define _GNU_SOURCE
 
+#include "crashdump-arm64.h"
 #include "kexec-arm64.h"
+#include "kexec-syscall.h"
 #include <limits.h>
 
 int image_arm64_probe(const char *kernel_buf, off_t kernel_size)
@@ -58,11 +60,22 @@ int image_arm64_load(int argc, char **argv, const char *kernel_buf,
 	dbgprintf("%s: PE format:      %s\n", __func__,
 		(arm64_header_check_pe_sig(header) ? "yes" : "no"));
 
+	/* create and initialize elf core header segment */
+	if (info->kexec_flags & KEXEC_ON_CRASH) {
+		result = load_crashdump_segments(info);
+		if (result) {
+			dbgprintf("%s: Creating eflcorehdr failed.\n",
+								__func__);
+			goto exit;
+		}
+	}
+
 	/* load the kernel */
 	add_segment_phys_virt(info, kernel_buf, kernel_size,
 			kernel_segment + arm64_mem.text_offset,
 			arm64_mem.image_size, 0);
 
+	/* load additional data */
 	result = arm64_load_other_segments(info, kernel_segment
 		+ arm64_mem.text_offset);
 
-- 
2.11.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
