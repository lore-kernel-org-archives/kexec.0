Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VnYpt-0005Bv-9d
 for kexec@lists.infradead.org; Mon, 02 Dec 2013 19:07:14 +0000
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH 2/2] kexec-tools/xen: Remove redundant include
Date: Mon,  2 Dec 2013 20:06:25 +0100
Message-Id: <1386011185-29350-3-git-send-email-daniel.kiper@oracle.com>
In-Reply-To: <1386011185-29350-1-git-send-email-daniel.kiper@oracle.com>
References: <1386011185-29350-1-git-send-email-daniel.kiper@oracle.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: andrew.cooper3@citrix.com, david.vrabel@citrix.com, horms@verge.net.au, kexec@lists.infradead.org, xen-devel@lists.xen.org
Cc: Daniel Kiper <daniel.kiper@oracle.com>

Remove redundant include of stdlib.h introduced by
commit d01680c28ba7bf1e02f74aa5841247a45738f5d4
(kexec/xen: Correct some compile errors).

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 kexec/kexec-xen.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/kexec/kexec-xen.c b/kexec/kexec-xen.c
index e885246..cac313d 100644
--- a/kexec/kexec-xen.c
+++ b/kexec/kexec-xen.c
@@ -2,7 +2,6 @@
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
-#include <stdlib.h>
 #include <elf.h>
 #include "kexec.h"
 #include "kexec-syscall.h"
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
