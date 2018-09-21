Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g3Bge-0008Oo-5P
 for kexec@lists.infradead.org; Fri, 21 Sep 2018 03:00:57 +0000
From: zhong jiang <zhongjiang@huawei.com>
Subject: [PATCHv2] kernel: kexec_file: remove some duplicated include file
Date: Fri, 21 Sep 2018 10:48:18 +0800
Message-ID: <1537498098-19171-1-git-send-email-zhongjiang@huawei.com>
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
To: bhe@redhat.com
Cc: kexec@lists.infradead.org, ebiederm@xmission.com, linux-kernel@vger.kernel.org

We include kexec.h and slab.h twice in kexec_file.c. It's unnecessary.
hence just remove them.

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
