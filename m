Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5vJg-0001jh-Gs
 for kexec@lists.infradead.org; Sat, 30 Jan 2021 18:49:53 +0000
Received: by mail-pf1-x42b.google.com with SMTP id w18so8738728pfu.9
 for <kexec@lists.infradead.org>; Sat, 30 Jan 2021 10:49:49 -0800 (PST)
From: Jiang Wang <jiang.wang@bytedance.com>
Subject: [PATCH] makedumpfile: Fix a compile error on Debian with pthread
Date: Sat, 30 Jan 2021 18:49:20 +0000
Message-Id: <20210130184920.1385887-1-jiang.wang@bytedance.com>
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
Cc: k-hagio-ab@nec.com, "jiang.wang" <jiang.wang@bytedance.com>

From: "jiang.wang" <jiang.wang@bytedance.com>

On Debian 10, make reports errors about undefined reference to
`pthread_rwlock_tryrdlock'. To fix it, put ldw before lpthread
in the Makefile.

Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index cb6bd42..010d447 100644
--- a/Makefile
+++ b/Makefile
@@ -68,7 +68,7 @@ endif
 CFLAGS += -DUSESNAPPY
 endif
 
-LIBS := -lpthread $(LIBS)
+LIBS := $(LIBS) -lpthread
 
 try-run = $(shell set -e;		\
 	TMP=".$$$$.tmp";		\
-- 
2.11.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
