Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YktkS-0006r6-5H
 for kexec@lists.infradead.org; Wed, 22 Apr 2015 12:27:24 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
 (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t3MCR6JB008241
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <kexec@lists.infradead.org>; Wed, 22 Apr 2015 08:27:06 -0400
Received: from localhost (vpn-48-34.rdu2.redhat.com [10.10.48.34])
 by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 t3MCR0db025525
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <kexec@lists.infradead.org>; Wed, 22 Apr 2015 08:27:05 -0400
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH] arm64: kdump: Add support for binary image
Date: Wed, 22 Apr 2015 17:56:49 +0530
Message-Id: <ebcfa1d19964bf7342eca03cdd40830d3f7c8eb8.1429705020.git.panand@redhat.com>
In-Reply-To: <770bae1ed7d53e74874f99343070b4c5a69cb9a2.1429704995.git.panand@redhat.com>
References: <770bae1ed7d53e74874f99343070b4c5a69cb9a2.1429704995.git.panand@redhat.com>
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
To: kexec@lists.infradead.org

This patch adds support to use binary image ie arch/arm64/boot/Image
with kdump.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 kexec/arch/arm64/kexec-image-arm64.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/kexec/arch/arm64/kexec-image-arm64.c b/kexec/arch/arm64/kexec-image-arm64.c
index a52ef8ea7309..1f5395bdfabf 100644
--- a/kexec/arch/arm64/kexec-image-arm64.c
+++ b/kexec/arch/arm64/kexec-image-arm64.c
@@ -10,6 +10,7 @@
 #include <libfdt.h>
 #include <stdlib.h>
 
+#include "crashdump-arm64.h"
 #include "dt-ops.h"
 #include "image-header.h"
 #include "kexec-arm64.h"
@@ -96,13 +97,23 @@ int image_arm64_load(int argc, char **argv, const char *kernel_buf,
 
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
@@ -111,7 +122,8 @@ int image_arm64_load(int argc, char **argv, const char *kernel_buf,
 
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
