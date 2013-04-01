Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UMcpa-0007p8-A2
 for kexec@lists.infradead.org; Mon, 01 Apr 2013 11:23:22 +0000
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/2] purgatory: remove arch/i386/timer.c
Date: Mon,  1 Apr 2013 13:23:04 +0200
Message-Id: <1364815385-26722-1-git-send-email-richard@nod.at>
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
Cc: Richard Weinberger <richard@nod.at>, horms@verge.net.au, zhangyanfei@cn.fujitsu.com

This file is nowhere referenced, let's get rid of it.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 purgatory/arch/i386/timer.c | 9 ---------
 1 file changed, 9 deletions(-)
 delete mode 100644 purgatory/arch/i386/timer.c

diff --git a/purgatory/arch/i386/timer.c b/purgatory/arch/i386/timer.c
deleted file mode 100644
index 7a4bdaa..0000000
--- a/purgatory/arch/i386/timer.c
+++ /dev/null
@@ -1,9 +0,0 @@
-#include <purgatory.h>
-#include "purgatory-x86.h"
-
-
-void x86_setup_legacy_timer(void)
-{
-	/* Load the legacy timer settings into the 8254 pit */
-}
-
-- 
1.8.1.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
