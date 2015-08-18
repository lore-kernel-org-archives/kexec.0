Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp14.uk.ibm.com ([195.75.94.110])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZRjaM-0008UT-EQ
 for kexec@lists.infradead.org; Tue, 18 Aug 2015 16:18:03 +0000
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Tue, 18 Aug 2015 17:17:33 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6C81A17D805A
 for <kexec@lists.infradead.org>; Tue, 18 Aug 2015 17:19:03 +0100 (BST)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
 [9.149.37.228])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7IGHRo222937842
 for <kexec@lists.infradead.org>; Tue, 18 Aug 2015 16:17:27 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7IGHR9S022101
 for <kexec@lists.infradead.org>; Tue, 18 Aug 2015 10:17:27 -0600
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [RFC PATCH] kexec: use mmap instead of read for slurp_file()
Date: Tue, 18 Aug 2015 18:17:23 +0200
Message-Id: <1439914643-26484-1-git-send-email-holzheu@linux.vnet.ibm.com>
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
To: Simon Horman <horms@verge.net.au>
Cc: stefan.roscher@de.ibm.com, kexec@lists.infradead.org

The slurp_fd() function allocates memory and uses the read() system call.
This results in double memory consumption for image and initrd:

 1) Memory allocated in user space by the kexec tool
 2) Memory allocated in kernel by the kexec() system call

Therefore use mmap() for non-character devices to reduce the memory
consumption of the kexec tool.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 kexec/kexec.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 8ce6885..fecf061 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -26,6 +26,7 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <limits.h>
+#include <sys/mman.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/reboot.h>
@@ -552,11 +553,12 @@ char *slurp_file(const char *filename, off_t *r_size)
 		if (err < 0)
 			die("Can not seek to the begin of file %s: %s\n",
 					filename, strerror(errno));
+		buf = slurp_fd(fd, filename, size, &nread);
 	} else {
-		size = stats.st_size;
+		size = nread = stats.st_size;
+		buf = mmap(NULL, size,
+			   PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
 	}
-
-	buf = slurp_fd(fd, filename, size, &nread);
 	if (!buf)
 		die("Cannot read %s", filename);
 
-- 
2.3.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
