Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay1.sgi.com ([192.48.179.29] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1UA2LT-0005pm-1R
 for kexec@lists.infradead.org; Mon, 25 Feb 2013 18:00:11 +0000
Received: from estes.americas.sgi.com (estes.americas.sgi.com [128.162.236.10])
 by relay1.corp.sgi.com (Postfix) with ESMTP id 45DF78F8049
 for <kexec@lists.infradead.org>; Mon, 25 Feb 2013 10:00:07 -0800 (PST)
Received: from eag09.americas.sgi.com (eag09.americas.sgi.com [128.162.232.15])
 by estes.americas.sgi.com (Postfix) with ESMTP id 1AE867001DB4
 for <kexec@lists.infradead.org>; Mon, 25 Feb 2013 12:00:07 -0600 (CST)
Received: from cpw by eag09.americas.sgi.com with local (Exim 4.69)
 (envelope-from <cpw@sgi.com>) id 1UA2LP-0007z2-2z
 for kexec@lists.infradead.org; Mon, 25 Feb 2013 12:00:07 -0600
Subject: [PATCH] kexec x86: drop truncation warning for crash kernel
Message-Id: <E1UA2LP-0007z2-2z@eag09.americas.sgi.com>
From: Cliff Wickman <cpw@sgi.com>
Date: Mon, 25 Feb 2013 12:00:07 -0600
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

From: Cliff Wickman <cpw@sgi.com>

On kexec set-up of a crash kernel on a very large memory machine we
sometimes see the worrisome warning:
  Too many memory ranges, truncating...
meaning that the total count of e820 ram, reserved and ACPI spaces is over 128.

Per the comment in do_bzImage_load():
                /* If using bzImage for capture kernel, then we will not be
                 * executing real mode code. setup segment can be loaded
                 * anywhere as we will be just reading command line.
                 */
So if I understand, the e820 table built here and added to the 'real_mode'
area is not going to be used.
So the warning message can be omitted.

Signed-off-by: Cliff Wickman <cpw@sgi.com>
---
 kexec/arch/i386/x86-linux-setup.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

Index: kexec-tools-2.0.4-rc1/kexec/arch/i386/x86-linux-setup.c
===================================================================
--- kexec-tools-2.0.4-rc1.orig/kexec/arch/i386/x86-linux-setup.c
+++ kexec-tools-2.0.4-rc1/kexec/arch/i386/x86-linux-setup.c
@@ -34,6 +34,7 @@
 #include "../../kexec.h"
 #include "kexec-x86.h"
 #include "x86-linux-setup.h"
+#include "../../kexec/kexec-syscall.h"
 
 void init_linux_parameters(struct x86_linux_param_header *real_mode)
 {
@@ -491,7 +492,13 @@ void setup_linux_system_parameters(struc
 		die("Cannot get memory information\n");
 	}
 	if (ranges > E820MAX) {
-		fprintf(stderr, "Too many memory ranges, truncating...\n");
+		if (!(kexec_flags & KEXEC_ON_CRASH))
+			/*
+			 * this e820 not used for capture kernel, see
+			 * do_bzImage_load()
+			 */
+			fprintf(stderr,
+				"Too many memory ranges, truncating...\n");
 		ranges = E820MAX;
 	}
 	real_mode->e820_map_nr = ranges;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
