Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lh96f-00BBiX-CK
 for kexec@lists.infradead.org; Thu, 13 May 2021 11:02:18 +0000
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] crash_dump: Fix duplicate included linux/pgtable.h
Date: Thu, 13 May 2021 19:02:03 +0800
Message-Id: <1620903723-67394-1-git-send-email-jiapeng.chong@linux.alibaba.com>
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
To: dyoung@redhat.com
Cc: bhe@redhat.com, vgoyal@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Clean up the following includecheck warning:

./include/linux/crash_dump.h: linux/pgtable.h is included more than
once.

No functional change.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 include/linux/crash_dump.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index a5192b7..be79a45 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -5,7 +5,6 @@
 #include <linux/kexec.h>
 #include <linux/proc_fs.h>
 #include <linux/elf.h>
-#include <linux/pgtable.h>
 #include <uapi/linux/vmcore.h>
 
 #include <linux/pgtable.h> /* for pgprot_t */
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
