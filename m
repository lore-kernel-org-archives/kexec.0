Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g2rSI-00053d-VI
 for kexec@lists.infradead.org; Thu, 20 Sep 2018 05:24:48 +0000
From: zhong jiang <zhongjiang@huawei.com>
Subject: [PATCH] kernel: kexec_file: remove some duplicated include file
Date: Thu, 20 Sep 2018 13:12:03 +0800
Message-ID: <1537420323-30658-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: ebiederm@xmission.com
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

kexec.h and slab.h have duplicated include. hence just remove
redundant file.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 kernel/kexec_file.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index c6a3b68..35cf0ad 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -25,8 +25,6 @@
 #include <linux/elf.h>
 #include <linux/elfcore.h>
 #include <linux/kernel.h>
-#include <linux/kexec.h>
-#include <linux/slab.h>
 #include <linux/syscalls.h>
 #include <linux/vmalloc.h>
 #include "kexec_internal.h"
-- 
1.7.12.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
