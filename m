Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from vostochny.stro.at ([78.47.22.85])
 by casper.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SWrnI-0001Qz-G7
 for kexec@lists.infradead.org; Tue, 22 May 2012 16:18:46 +0000
From: maximilian attems <max@stro.at>
Subject: [PATCH] kexec: simply pass LINUX_REBOOT_CMD_KEXEC to reboot
Date: Tue, 22 May 2012 18:09:58 +0200
Message-Id: <1337702998-15080-1-git-send-email-max@stro.at>
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
To: Simon Horman <horms@verge.net.au>
Cc: maximilian attems <max@stro.at>, klibc@zytor.com, kexec@lists.infradead.org

While trying to port kexec cleanly to klibc,
came across this syscall usage for reboot(2).
Calling reboot directly simplifies the code.

Signed-off-by: maximilian attems <max@stro.at>
---
 kexec/kexec-syscall.h |   20 --------------------
 kexec/kexec.c         |    4 +++-
 2 files changed, 3 insertions(+), 21 deletions(-)

The next TODO item is to add proper syscall kexec_load() to glibc.
Funnily here klibc has an head start! -maks

diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
index f4df45c..415fbd7 100644
--- a/kexec/kexec-syscall.h
+++ b/kexec/kexec-syscall.h
@@ -5,22 +5,6 @@
 #include <sys/syscall.h>
 #include <unistd.h>
 
-#define	LINUX_REBOOT_MAGIC1	0xfee1dead
-#define	LINUX_REBOOT_MAGIC2	672274793
-#define	LINUX_REBOOT_MAGIC2A	85072278
-#define	LINUX_REBOOT_MAGIC2B	369367448
-
-#define	LINUX_REBOOT_CMD_RESTART	0x01234567
-#define	LINUX_REBOOT_CMD_HALT		0xCDEF0123
-#define	LINUX_REBOOT_CMD_CAD_ON		0x89ABCDEF
-#define	LINUX_REBOOT_CMD_CAD_OFF	0x00000000
-#define	LINUX_REBOOT_CMD_POWER_OFF	0x4321FEDC
-#define	LINUX_REBOOT_CMD_RESTART2	0xA1B2C3D4
-#define LINUX_REBOOT_CMD_EXEC_KERNEL    0x18273645
-#define LINUX_REBOOT_CMD_KEXEC_OLD	0x81726354
-#define LINUX_REBOOT_CMD_KEXEC_OLD2	0x18263645
-#define LINUX_REBOOT_CMD_KEXEC		0x45584543
-
 #ifndef __NR_kexec_load
 #ifdef __i386__
 #define __NR_kexec_load		283
@@ -70,10 +54,6 @@ static inline long kexec_load(void *entry, unsigned long nr_segments,
 	return (long) syscall(__NR_kexec_load, entry, nr_segments, segments, flags);
 }
 
-static inline long kexec_reboot(void)
-{
-	return (long) syscall(__NR_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, LINUX_REBOOT_CMD_KEXEC, 0);
-}
 
 
 #define KEXEC_ON_CRASH		0x00000001
diff --git a/kexec/kexec.c b/kexec/kexec.c
index d2d05a8..ee23b5e 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -28,6 +28,8 @@
 #include <limits.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/reboot.h>
+#include <linux/reboot.h>
 #include <unistd.h>
 #include <fcntl.h>
 #ifndef _O_BINARY
@@ -822,7 +824,7 @@ static int my_shutdown(void)
  */
 static int my_exec(void)
 {
-	kexec_reboot();
+	reboot(LINUX_REBOOT_CMD_KEXEC);
 	/* I have failed if I make it here */
 	fprintf(stderr, "kexec failed: %s\n", 
 		strerror(errno));
-- 
1.7.10


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
