Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x233.google.com ([2607:f8b0:400e:c03::233])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YLAIK-0003vm-Ll
 for kexec@lists.infradead.org; Tue, 10 Feb 2015 12:52:01 +0000
Received: by mail-pa0-f51.google.com with SMTP id eu11so19358164pac.10
 for <kexec@lists.infradead.org>; Tue, 10 Feb 2015 04:51:39 -0800 (PST)
From: Yousong Zhou <yszhou4tech@gmail.com>
Subject: [PATCH 2/4] mips: fix compiler warning on printing 64-bit integer.
Date: Tue, 10 Feb 2015 20:46:12 +0800
Message-Id: <1423572374-20841-2-git-send-email-yszhou4tech@gmail.com>
In-Reply-To: <1423572374-20841-1-git-send-email-yszhou4tech@gmail.com>
References: <1423572374-20841-1-git-send-email-yszhou4tech@gmail.com>
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
Cc: Yousong Zhou <yszhou4tech@gmail.com>, horms@verge.net.au


Signed-off-by: Yousong Zhou <yszhou4tech@gmail.com>
---
 kexec/arch/mips/crashdump-mips.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/mips/crashdump-mips.c b/kexec/arch/mips/crashdump-mips.c
index e7840e0..98c9f7c 100644
--- a/kexec/arch/mips/crashdump-mips.c
+++ b/kexec/arch/mips/crashdump-mips.c
@@ -22,6 +22,7 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <limits.h>
+#include <inttypes.h>
 #include <elf.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -52,7 +53,7 @@ static int get_kernel_paddr(struct crash_elf_info *elf_info)
 
 	if (parse_iomem_single("Kernel code\n", &start, NULL) == 0) {
 		elf_info->kern_paddr_start = start;
-		dbgprintf("kernel load physical addr start = 0x%lx\n", start);
+		dbgprintf("kernel load physical addr start = 0x%" PRIu64 "\n", start);
 		return 0;
 	}
 
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
