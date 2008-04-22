Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from py-out-1112.google.com ([64.233.166.182])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JoS04-00074m-MH
	for kexec@lists.infradead.org; Tue, 22 Apr 2008 23:34:12 +0000
Received: by py-out-1112.google.com with SMTP id a73so3543921pye.2
	for <kexec@lists.infradead.org>; Tue, 22 Apr 2008 16:34:12 -0700 (PDT)
From: Jamey Sharp <jamey@thetovacompany.com>
Subject: [PATCH 6/9] <sys/mman.h> is not needed by any kexec/ source,
	at least on i386.
Date: Tue, 22 Apr 2008 16:21:09 -0700
Message-Id: <1208906472-18465-7-git-send-email-jamey@thetovacompany.com>
In-Reply-To: <1208906472-18465-1-git-send-email-jamey@thetovacompany.com>
References: <1208906472-18465-1-git-send-email-jamey@thetovacompany.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
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

Other architectures also include sys/mman.h and likely don't need to, but
I can't easily test that.

Signed-off-by: Jamey Sharp <jamey@thetovacompany.com>
---
 kexec/arch/i386/kexec-bzImage.c       |    1 -
 kexec/arch/i386/kexec-elf-x86.c       |    1 -
 kexec/arch/i386/kexec-multiboot-x86.c |    1 -
 kexec/arch/i386/kexec-nbi.c           |    1 -
 kexec/arch/i386/x86-linux-setup.c     |    1 -
 5 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/kexec/arch/i386/kexec-bzImage.c b/kexec/arch/i386/kexec-bzImage.c
index 9ca3cea..d585196 100644
--- a/kexec/arch/i386/kexec-bzImage.c
+++ b/kexec/arch/i386/kexec-bzImage.c
@@ -24,7 +24,6 @@
 #include <errno.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <sys/mman.h>
 #include <fcntl.h>
 #include <unistd.h>
 #include <getopt.h>
diff --git a/kexec/arch/i386/kexec-elf-x86.c b/kexec/arch/i386/kexec-elf-x86.c
index 249dfa6..1e523f9 100644
--- a/kexec/arch/i386/kexec-elf-x86.c
+++ b/kexec/arch/i386/kexec-elf-x86.c
@@ -25,7 +25,6 @@
 #include <limits.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <sys/mman.h>
 #include <fcntl.h>
 #include <unistd.h>
 #include <getopt.h>
diff --git a/kexec/arch/i386/kexec-multiboot-x86.c b/kexec/arch/i386/kexec-multiboot-x86.c
index 1618c82..ec65860 100644
--- a/kexec/arch/i386/kexec-multiboot-x86.c
+++ b/kexec/arch/i386/kexec-multiboot-x86.c
@@ -41,7 +41,6 @@
 #include <limits.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <sys/mman.h>
 #include <fcntl.h>
 #include <unistd.h>
 #include <getopt.h>
diff --git a/kexec/arch/i386/kexec-nbi.c b/kexec/arch/i386/kexec-nbi.c
index e771f89..19ae631 100644
--- a/kexec/arch/i386/kexec-nbi.c
+++ b/kexec/arch/i386/kexec-nbi.c
@@ -24,7 +24,6 @@
 #include <limits.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <sys/mman.h>
 #include <fcntl.h>
 #include <unistd.h>
 #include <getopt.h>
diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
index 97480fd..4b9a5e5 100644
--- a/kexec/arch/i386/x86-linux-setup.c
+++ b/kexec/arch/i386/x86-linux-setup.c
@@ -22,7 +22,6 @@
 #include <limits.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <sys/mman.h>
 #include <fcntl.h>
 #include <sys/ioctl.h>
 #include <linux/fb.h>
-- 
1.5.4.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
