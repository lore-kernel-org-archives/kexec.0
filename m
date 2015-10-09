Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wi0-x235.google.com ([2a00:1450:400c:c05::235])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZkXi8-0004I8-Rz
 for kexec@lists.infradead.org; Fri, 09 Oct 2015 13:27:49 +0000
Received: by wiclk2 with SMTP id lk2so70634382wic.0
 for <kexec@lists.infradead.org>; Fri, 09 Oct 2015 06:27:27 -0700 (PDT)
From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH] kexec: determine size of block device
Date: Fri,  9 Oct 2015 15:27:18 +0200
Message-Id: <1444397238-14330-1-git-send-email-andreas.fenkart@dev.digitalstrom.org>
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
Cc: Andreas Fenkart <andreas.fenkart@dev.digitalstrom.org>

starting 'kexec -l /dev/mmcblk0p1' fails since the size of
a block device can not be determined with stat

Signed-off-by: Andreas Fenkart <andreas.fenkart@dev.digitalstrom.org>
---
 kexec/kexec.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index ff024f3..8b8846e 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -26,7 +26,9 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <limits.h>
+#include <sys/ioctl.h>
 #include <sys/mman.h>
+#include <sys/mount.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/reboot.h>
@@ -554,6 +556,14 @@ char *slurp_file(const char *filename, off_t *r_size)
 			die("Can not seek to the begin of file %s: %s\n",
 					filename, strerror(errno));
 		buf = slurp_fd(fd, filename, size, &nread);
+    } else if (S_ISBLK(stats.st_mode)) {
+		/* taken from blockdev */
+		unsigned long long llu = -1;
+		err = ioctl(fd, BLKGETSIZE64, &llu);
+		if (err < 0)
+			die("Can't retrieve size of block device %s: %s\n",
+				filename, strerror(errno));
+		size = llu;
 	} else {
 		size = nread = stats.st_size;
 		buf = mmap(NULL, size,
-- 
2.5.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
