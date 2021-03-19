Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lNDpz-007NB3-Vs
 for kexec@lists.infradead.org; Fri, 19 Mar 2021 12:02:46 +0000
From: Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH] crash_dump: Fix duplicate included pgtable.h
Date: Fri, 19 Mar 2021 20:03:13 +0800
Message-ID: <1616155393-12188-1-git-send-email-tiantao6@hisilicon.com>
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
To: dyoung@redhat.com, bhe@redhat.com
Cc: kexec@lists.infradead.org

linux/pgtable.h is included more than once, Remove the one that isn't
necessary.

Fixes: ca5999fde0a1 ("mm: introduce include/linux/pgtable.h")
Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 include/linux/crash_dump.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index a5192b7..6bd8a33 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -8,8 +8,6 @@
 #include <linux/pgtable.h>
 #include <uapi/linux/vmcore.h>
 
-#include <linux/pgtable.h> /* for pgprot_t */
-
 #ifdef CONFIG_CRASH_DUMP
 #define ELFCORE_ADDR_MAX	(-1ULL)
 #define ELFCORE_ADDR_ERR	(-2ULL)
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
