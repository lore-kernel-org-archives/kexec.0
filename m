Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZpSkX-0002VA-F7
 for kexec@lists.infradead.org; Fri, 23 Oct 2015 03:10:37 +0000
Date: Fri, 23 Oct 2015 11:10:00 +0800
From: Dave Young <dyoung@redhat.com>
Subject: [PATCH] Revert "kexec: use mmap instead of read for slurp_file()"
Message-ID: <20151023031000.GA15557@dhcp-129-115.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>, kexec@lists.infradead.org

This reverts commit 7ab842d8a004f6cd75a9d7b3528e4a70819ce4ef.

using mmap by default in slurp_file cause segment fault while later
reallocing dtb_buf during my arm kexec test.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 kexec/kexec.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- kexec-tools.orig/kexec/kexec.c
+++ kexec-tools/kexec/kexec.c
@@ -26,7 +26,6 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <limits.h>
-#include <sys/mman.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/reboot.h>
@@ -553,12 +552,11 @@ char *slurp_file(const char *filename, o
 		if (err < 0)
 			die("Can not seek to the begin of file %s: %s\n",
 					filename, strerror(errno));
-		buf = slurp_fd(fd, filename, size, &nread);
 	} else {
-		size = nread = stats.st_size;
-		buf = mmap(NULL, size,
-			   PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+		size = stats.st_size;
 	}
+
+	buf = slurp_fd(fd, filename, size, &nread);
 	if (!buf)
 		die("Cannot read %s", filename);
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
