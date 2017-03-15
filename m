Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x22b.google.com ([2607:f8b0:400e:c05::22b])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1co5MV-0008UD-9i
 for kexec@lists.infradead.org; Wed, 15 Mar 2017 09:36:56 +0000
Received: by mail-pg0-x22b.google.com with SMTP id b129so6748122pgc.2
 for <kexec@lists.infradead.org>; Wed, 15 Mar 2017 02:36:34 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v6 3/9] arm64: identify PHYS_OFFSET correctly
Date: Wed, 15 Mar 2017 18:38:18 +0900
Message-Id: <20170315093824.24566-4-takahiro.akashi@linaro.org>
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

Due to the kernel patch, commit e7cd190385d1 ("arm64: mark reserved
memblock regions explicitly in iomem"), the current code will not be able
to identify the correct value of PHYS_OFFSET if some "reserved" memory
region, which is likely to be UEFI runtime services code/data, exists at
an address below the first "System RAM" regions.

This patch fixes this issue.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 kexec/arch/arm64/iomem.h       |  7 +++++++
 kexec/arch/arm64/kexec-arm64.c | 12 ++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)
 create mode 100644 kexec/arch/arm64/iomem.h

diff --git a/kexec/arch/arm64/iomem.h b/kexec/arch/arm64/iomem.h
new file mode 100644
index 0000000..7fd66eb
--- /dev/null
+++ b/kexec/arch/arm64/iomem.h
@@ -0,0 +1,7 @@
+#ifndef IOMEM_H
+#define IOMEM_H
+
+#define SYSTEM_RAM		"System RAM\n"
+#define IOMEM_RESERVED		"reserved\n"
+
+#endif
diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 04fd396..d02b9da 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -21,6 +21,7 @@
 #include "crashdump-arm64.h"
 #include "dt-ops.h"
 #include "fs2dt.h"
+#include "iomem.h"
 #include "kexec-syscall.h"
 #include "arch/options.h"
 
@@ -476,7 +477,14 @@ static int get_memory_ranges_iomem_cb(void *data, int nr, char *str,
 		return -1;
 
 	r = (struct memory_range *)data + nr;
-	r->type = RANGE_RAM;
+
+	if (!strncmp(str, SYSTEM_RAM, strlen(SYSTEM_RAM)))
+		r->type = RANGE_RAM;
+	else if (!strncmp(str, IOMEM_RESERVED, strlen(IOMEM_RESERVED)))
+		r->type = RANGE_RESERVED;
+	else
+		return 1;
+
 	r->start = base;
 	r->end = base + length - 1;
 
@@ -495,7 +503,7 @@ static int get_memory_ranges_iomem_cb(void *data, int nr, char *str,
 static int get_memory_ranges_iomem(struct memory_range *array,
 	unsigned int *count)
 {
-	*count = kexec_iomem_for_each_line("System RAM\n",
+	*count = kexec_iomem_for_each_line(NULL,
 		get_memory_ranges_iomem_cb, array);
 
 	if (!*count) {
-- 
2.11.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
