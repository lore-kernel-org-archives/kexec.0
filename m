Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UgFYF-0001Rr-BG
 for kexec@lists.infradead.org; Sat, 25 May 2013 14:34:32 +0000
Received: by mail-pa0-f47.google.com with SMTP id kl12so1885326pab.6
 for <kexec@lists.infradead.org>; Sat, 25 May 2013 07:34:10 -0700 (PDT)
Message-ID: <51A0CBD9.5040808@gmail.com>
Date: Sat, 25 May 2013 22:34:01 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 2/2] kexec/s390: cleanup: Remove non-existent header file
 include
References: <51A0CB91.3090607@gmail.com>
In-Reply-To: <51A0CB91.3090607@gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

There is no elf.h in this directory, so remove the useless
include.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/arch/s390/kexec-image.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/kexec/arch/s390/kexec-image.c b/kexec/arch/s390/kexec-image.c
index d3af800..e49b75b 100644
--- a/kexec/arch/s390/kexec-image.c
+++ b/kexec/arch/s390/kexec-image.c
@@ -21,7 +21,6 @@
 #include "../../kexec-syscall.h"
 #include "../../kexec/crashdump.h"
 #include "kexec-s390.h"
-#include "elf.h"
 #include <arch/options.h>
 
 static uint64_t crash_base, crash_end;
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
