Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cVwaB-0001Gi-JA
 for kexec@lists.infradead.org; Tue, 24 Jan 2017 08:36:05 +0000
Received: by mail-pf0-f175.google.com with SMTP id 189so48736036pfu.3
 for <kexec@lists.infradead.org>; Tue, 24 Jan 2017 00:35:42 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v5 9/9] arm64: kdump: Add support for binary image files
Date: Tue, 24 Jan 2017 17:33:31 +0900
Message-Id: <20170124083331.3468-10-takahiro.akashi@linaro.org>
In-Reply-To: <20170124083331.3468-1-takahiro.akashi@linaro.org>
References: <20170124083331.3468-1-takahiro.akashi@linaro.org>
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
 kexec/arch/arm64/kexec-image-arm64.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kexec/arch/arm64/kexec-image-arm64.c b/kexec/arch/arm64/kexec-image-arm64.c
index 960ed96..982e431 100644
--- a/kexec/arch/arm64/kexec-image-arm64.c
+++ b/kexec/arch/arm64/kexec-image-arm64.c
@@ -4,7 +4,9 @@
 
 #define _GNU_SOURCE
 
+#include "crashdump-arm64.h"
 #include "kexec-arm64.h"
+#include "kexec-syscall.h"
 #include <limits.h>
 
 int image_arm64_probe(const char *kernel_buf, off_t kernel_size)
@@ -58,6 +60,16 @@ int image_arm64_load(int argc, char **argv, const char *kernel_buf,
 	dbgprintf("%s: PE format:      %s\n", __func__,
 		(arm64_header_check_pe_sig(header) ? "yes" : "no"));
 
+	if (info->kexec_flags & KEXEC_ON_CRASH) {
+		/* create and initialize elf core header segment */
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
-- 
2.11.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
