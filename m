Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-we0-x22b.google.com ([2a00:1450:400c:c03::22b])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WuRkL-00079C-HG
 for kexec@lists.infradead.org; Tue, 10 Jun 2014 19:30:14 +0000
Received: by mail-we0-f171.google.com with SMTP id q58so4326490wes.2
 for <kexec@lists.infradead.org>; Tue, 10 Jun 2014 12:29:51 -0700 (PDT)
From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH] vmcore-dmesg: don't enforce largefile handling
Date: Tue, 10 Jun 2014 21:29:29 +0200
Message-Id: <1402428569-3669-1-git-send-email-yegorslists@googlemail.com>
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
Cc: Peter Korsgaard <jacmet@sunsite.dk>, Yegor Yefremov <yegorslists@googlemail.com>

Breaks build on !largefile toolchains.

Instead simply use whatever mode is selected by toolchain / CFLAGS.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 vmcore-dmesg/vmcore-dmesg.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/vmcore-dmesg/vmcore-dmesg.c b/vmcore-dmesg/vmcore-dmesg.c
index f47ee11..9bb1cc2 100644
--- a/vmcore-dmesg/vmcore-dmesg.c
+++ b/vmcore-dmesg/vmcore-dmesg.c
@@ -1,6 +1,4 @@
 #define _XOPEN_SOURCE 600
-#define _LARGEFILE_SOURCE 1
-#define _FILE_OFFSET_BITS 64
 #include <endian.h>
 #include <byteswap.h>
 #include <stdio.h>
-- 
1.8.3.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
