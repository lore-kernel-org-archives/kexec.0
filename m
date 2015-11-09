Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zviyu-0004xn-6e
 for kexec@lists.infradead.org; Mon, 09 Nov 2015 09:43:21 +0000
Received: by wmec201 with SMTP id c201so70360661wme.0
 for <kexec@lists.infradead.org>; Mon, 09 Nov 2015 01:42:58 -0800 (PST)
From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v3] kexec: determine size of block device
Date: Mon,  9 Nov 2015 10:42:56 +0100
Message-Id: <1447062176-13234-1-git-send-email-andreas.fenkart@dev.digitalstrom.org>
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
 kexec/kexec.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index ca1e81d..cf6e03d 100644
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
@@ -555,6 +557,12 @@ static char *slurp_file_generic(const char *filename, off_t *r_size,
 			die("Can not seek to the begin of file %s: %s\n",
 					filename, strerror(errno));
 		buf = slurp_fd(fd, filename, size, &nread);
+	} else if (S_ISBLK(stats.st_mode)) {
+		err = ioctl(fd, BLKGETSIZE64, &size);
+		if (err < 0)
+			die("Can't retrieve size of block device %s: %s\n",
+				filename, strerror(errno));
+		buf = slurp_fd(fd, filename, size, &nread);
 	} else {
 		size = stats.st_size;
 		if (use_mmap) {
-- 
2.6.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
