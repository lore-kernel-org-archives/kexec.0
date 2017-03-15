Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1co5Mt-000087-AU
 for kexec@lists.infradead.org; Wed, 15 Mar 2017 09:37:20 +0000
Received: by mail-pf0-x22f.google.com with SMTP id x63so1236784pfx.2
 for <kexec@lists.infradead.org>; Wed, 15 Mar 2017 02:36:59 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v6 9/9] arm64: kdump: Add support for binary image files
Date: Wed, 15 Mar 2017 18:38:24 +0900
Message-Id: <20170315093824.24566-10-takahiro.akashi@linaro.org>
In-Reply-To: <20170315093824.24566-1-takahiro.akashi@linaro.org>
References: <20170315093824.24566-1-takahiro.akashi@linaro.org>
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
2.11.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
