Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W2lkA-00088F-B3
 for kexec@lists.infradead.org; Mon, 13 Jan 2014 17:56:10 +0000
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <ldufour@linux.vnet.ibm.com>;
 Mon, 13 Jan 2014 17:55:40 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2E6AE1B0805F
 for <kexec@lists.infradead.org>; Mon, 13 Jan 2014 17:54:59 +0000 (GMT)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0DHtPWv57278716
 for <kexec@lists.infradead.org>; Mon, 13 Jan 2014 17:55:25 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0DHtba1016292
 for <kexec@lists.infradead.org>; Mon, 13 Jan 2014 12:55:37 -0500
Subject: [PATCH] ppc64/kexec/purgatory Fix RTAS calls in Little Endian mode.
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Mon, 13 Jan 2014 18:55:36 +0100
Message-ID: <20140113175536.14913.16060.stgit@nimbus>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: horms@verge.net.au, kexec@lists.infradead.org

RTAS is expecting parameters in Big Endian order so we have to byte swap
them in LE mode.

In the purgatory RTAS calls are only made for debug output.

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 purgatory/arch/ppc64/console-ppc64.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/purgatory/arch/ppc64/console-ppc64.c b/purgatory/arch/ppc64/console-ppc64.c
index 78a233b..b80183c 100644
--- a/purgatory/arch/ppc64/console-ppc64.c
+++ b/purgatory/arch/ppc64/console-ppc64.c
@@ -21,6 +21,9 @@
 
 #include <purgatory.h>
 #include "hvCall.h"
+#include <byteswap.h>
+#include <endian.h>
+#include <asm/byteorder.h>
 
 extern int debug;
 
@@ -36,6 +39,7 @@ void putchar(int c)
 		putchar('\r');
 
 	buff[0] = c;
-	plpar_hcall_norets(H_PUT_TERM_CHAR, 0, 1, lbuf[0], lbuf[1]);
+	plpar_hcall_norets(H_PUT_TERM_CHAR, 0, 1,
+			   __cpu_to_be64(lbuf[0]), __cpu_to_be64(lbuf[1]));
 	return;
 }


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
