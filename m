Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1md0KM-0037Id-BJ
 for kexec@lists.infradead.org; Wed, 20 Oct 2021 01:23:35 +0000
Received: by mail-pg1-x529.google.com with SMTP id s136so17809630pgs.4
 for <kexec@lists.infradead.org>; Tue, 19 Oct 2021 18:23:34 -0700 (PDT)
From: cgel.zte@gmail.com
Subject: [PATCH] crash_dump: remove duplicate include in crash_dump.h
Date: Wed, 20 Oct 2021 01:23:18 +0000
Message-Id: <20211020012318.1035952-1-ye.guojin@zte.com.cn>
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
To: dyoung@redhat.com
Cc: bhe@redhat.com, vgoyal@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ye Guojin <ye.guojin@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>

From: Ye Guojin <ye.guojin@zte.com.cn>

'linux/pgtable.h' included in 'crash_dump.h' is duplicated.
it's also included at line 8.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
---
 include/linux/crash_dump.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 0c547d866f1e..b7b255b23b99 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -8,8 +8,6 @@
 #include <linux/pgtable.h>
 #include <uapi/linux/vmcore.h>
 
-#include <linux/pgtable.h> /* for pgprot_t */
-
 /* For IS_ENABLED(CONFIG_CRASH_DUMP) */
 #define ELFCORE_ADDR_MAX	(-1ULL)
 #define ELFCORE_ADDR_ERR	(-2ULL)
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
