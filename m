Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wi0-x229.google.com ([2a00:1450:400c:c05::229])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zqm8s-0000zC-8A
 for kexec@lists.infradead.org; Mon, 26 Oct 2015 18:05:11 +0000
Received: by wicll6 with SMTP id ll6so126692748wic.1
 for <kexec@lists.infradead.org>; Mon, 26 Oct 2015 11:04:48 -0700 (PDT)
From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v2] kexec: determine size of block device
Date: Mon, 26 Oct 2015 19:04:41 +0100
Message-Id: <1445882681-23773-1-git-send-email-andreas.fenkart@dev.digitalstrom.org>
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
 kexec/kexec.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index b9f1816..99f743b 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -26,6 +26,8 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <limits.h>
+#include <sys/ioctl.h>
+#include <sys/mount.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/reboot.h>
@@ -552,6 +554,13 @@ char *slurp_file(const char *filename, off_t *r_size)
 		if (err < 0)
 			die("Can not seek to the begin of file %s: %s\n",
 					filename, strerror(errno));
+	} else if (S_ISBLK(stats.st_mode)) {
+		unsigned long long llu = -1;
+		err = ioctl(fd, BLKGETSIZE64, &llu);
+		if (err < 0)
+			die("Can't retrieve size of block device %s: %s\n",
+				filename, strerror(errno));
+		size = llu;
 	} else {
 		size = stats.st_size;
 	}
-- 
2.6.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
