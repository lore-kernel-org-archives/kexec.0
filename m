Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp15.uk.ibm.com ([195.75.94.111])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZXpr0-0002od-CS
 for kexec@lists.infradead.org; Fri, 04 Sep 2015 12:12:27 +0000
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Fri, 4 Sep 2015 13:12:03 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 829C81B0805F
 for <kexec@lists.infradead.org>; Fri,  4 Sep 2015 13:13:36 +0100 (BST)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t84CC0N040632558
 for <kexec@lists.infradead.org>; Fri, 4 Sep 2015 12:12:00 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t84CC0r5008945
 for <kexec@lists.infradead.org>; Fri, 4 Sep 2015 06:12:00 -0600
Date: Fri, 4 Sep 2015 14:11:59 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [PATCH] kexec: use mmap instead of read for slurp_file()
Message-ID: <20150904141159.182c2f08@holzheu>
In-Reply-To: <20150904094541.GA30724@verge.net.au>
References: <1439914643-26484-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <20150902010721.GE30886@verge.net.au>
 <20150902104839.17674456@holzheu>
 <20150904094541.GA30724@verge.net.au>
Mime-Version: 1.0
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
Cc: kexec@lists.infradead.org, stefan.roscher@de.ibm.com

The slurp_fd() function allocates memory and uses the read() system call.
This results in double memory consumption for image and initrd:

 1) Memory allocated in user space by the kexec tool
 2) Memory allocated in kernel by the kexec() system call

Therefore use mmap() for non-character devices to reduce the runtime
memory consumption of the kexec tool.

The following use case illustrates the usefulness of this patch a bit more:

 1) Boot a 4 GB Linux system
 2) Read kernel and 1,5 GB ramdisk from external source into local tmpfs (ram)
 3) kexec the kernel and ramdisk

 Without this patch for the kexec runtime we need:

 1,5 GB (tmpfs) + 1,5 GB (kexec malloc) + 1,5 GB (kernel memory) = 4,5 GB

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
