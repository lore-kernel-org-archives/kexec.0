Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WBB74-0004vp-8Y
 for kexec@lists.infradead.org; Wed, 05 Feb 2014 22:38:34 +0000
Message-ID: <52F2BD4F.10707@suse.com>
Date: Wed, 05 Feb 2014 14:38:07 -0800
From: Tony Jones <tonyj@suse.com>
MIME-Version: 1.0
Subject: PATCH: fix redefinition error for e820entry
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
To: kexec@lists.infradead.org
Cc: Simon Horman <horms@verge.net.au>

At least on our systems, xenctrl.h defines (unguarded) struct e820entry
Move the (guarded) definition in include/x86/x86-linux.h to below.

Signed-off-by: Tony Jones <tonyj@suse.de>
---
 kexec/arch/i386/crashdump-x86.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -41,12 +41,13 @@
 #include "../../crashdump.h"
 #include "kexec-x86.h"
 #include "crashdump-x86.h"
-#include "x86-linux-setup.h"

 #ifdef HAVE_LIBXENCTRL
 #include <xenctrl.h>
 #endif /* HAVE_LIBXENCTRL */

+#include "x86-linux-setup.h"
+
 #include <x86/x86-linux.h>

 extern struct arch_options_t arch_options;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
