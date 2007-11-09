Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37])
	by bombadil.infradead.org with esmtp (Exim 4.66 #1 (Red Hat Linux))
	id 1IqQGc-0000Jy-LE
	for kexec@lists.infradead.org; Fri, 09 Nov 2007 04:35:17 -0500
From: Akio Takebe <takebe_akio@jp.fujitsu.com>
Subject: [Patch] Fix PA() in purgatory-ia64.c
Date: Fri, 09 Nov 2007 18:34:11 +0900
MIME-Version: 1.0
Message-Id: <3FC822B3AF3FCDtakebe_akio@jp.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, xen-ia64-devel <xen-ia64-devel@lists.xensource.com>
Cc: Simon Horman <horms@verge.net.au>

Hi,

I met the issue that kdump didn't work on Xen/HVM guest.
I investigated the cause, found that PA() in purgatory-ia64.c
is used in Physical mode.

The PA() currently use PAGE_OFFSET fixed size(0xe000000000000000UL).
So the PA() don't work properly if it is called in Physcal mode.

 inline unsigned long PA(unsigned long addr)
 {
        return addr - PAGE_OFFSET;
 }

I make the patch to fix this issue.
How about this?

Signed-off-by: Akio Takebe <takebe_akio@jp.fujitsu.com>

Best Regards,

Akio Takebe

---
--- kexec-tools-testing-20071030.orig/purgatory/arch/ia64/purgatory-ia64.c	2007-10-17 12:16:16.000000000 +0900
+++ kexec-tools-testing-20071030/purgatory/arch/ia64/purgatory-ia64.c	2007-11-09 18:20:27.000000000 +0900
@@ -21,7 +21,7 @@
 #include <string.h>
 #include "purgatory-ia64.h"
 
-#define PAGE_OFFSET             0xe000000000000000UL
+#define RGN_MASK                0xf000000000000000UL
 
 #define EFI_PAGE_SHIFT          12
 #define EFI_PAGE_SIZE		(1UL<<EFI_PAGE_SHIFT)
@@ -147,7 +147,7 @@ setup_arch(void)
 
 inline unsigned long PA(unsigned long addr)
 {
-	return addr - PAGE_OFFSET;
+	return addr|~RGN_MASK;
 }
 
 void


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
