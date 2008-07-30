Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from chilli.pcug.org.au ([203.10.76.44] helo=smtps.tip.net.au)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KO4Ge-0008OX-Fl
	for kexec@lists.infradead.org; Wed, 30 Jul 2008 05:30:33 +0000
Date: Wed, 30 Jul 2008 15:30:28 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: linux-next: build failure
Message-Id: <20080730153028.95226354.sfr@canb.auug.org.au>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Cc: Haren Myneni <hbabu@us.ibm.com>, linux-next@vger.kernel.org, kexec@lists.infradead.org, Ankita Garg <ankita@in.ibm.com>, Vivek Goyal <vgoyal@redhat.com>

Hi Ananth,

Today's linux-next build (powerpc allyesconfig) failed like this:

tests/lkdtm.c:182: error: expected ')' before '*' token

I have no idea why this fails now when it did not before.

I applied the following patch.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 30 Jul 2008 15:24:53 +1000
Subject: [PATCH] tests: lkdtm needs ide.h

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 tests/lkdtm.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/tests/lkdtm.c b/tests/lkdtm.c
index 2a40d18..856f060 100644
--- a/tests/lkdtm.c
+++ b/tests/lkdtm.c
@@ -52,6 +52,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/hrtimer.h>
+#include <linux/ide.h>
 #include <scsi/scsi_cmnd.h>
 
 #define NUM_CPOINTS 8
-- 
1.5.6.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
