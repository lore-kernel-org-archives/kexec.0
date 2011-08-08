Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from vostochny.stro.at ([78.47.22.85])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QqUv7-00005N-8L
	for kexec@lists.infradead.org; Mon, 08 Aug 2011 18:51:26 +0000
From: maximilian attems <max@stro.at>
Subject: [PATCH] kexec-tools: include minor klibc porting
Date: Mon,  8 Aug 2011 20:43:08 +0200
Message-Id: <1312828988-3203-1-git-send-email-max@stro.at>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Simon Horman <horms@verge.net.au>, maximilian attems <max@stro.at>

These 2 "uncommon" include pathes are the first stumbling blocks
to build kexec-tools against klibc.

Of course more is needed, but this is a first step.
On the klibc step there is still stuff needed, but
it is already possible with hacks as Oppenembedded shows.

Signed-off-by: maximilian attems <max@stro.at>
---
 kexec/ifdown.c        |    2 +-
 kexec/kexec-syscall.h |    1 -
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/kexec/ifdown.c b/kexec/ifdown.c
index bc7f12f..46b7bef 100644
--- a/kexec/ifdown.c
+++ b/kexec/ifdown.c
@@ -10,11 +10,11 @@ char *v_ifdown = "@(#)ifdown.c  1.11  02-Jun-1998  miquels@cistron.nl";
 #include <unistd.h>
 #include <time.h>
 #include <string.h>
+#include <errno.h>
 
 #include <sys/ioctl.h>
 #include <sys/socket.h>
 #include <sys/time.h>
-#include <sys/errno.h>
 
 #include <net/if.h>
 #include <netinet/in.h>
diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
index b082f40..f4df45c 100644
--- a/kexec/kexec-syscall.h
+++ b/kexec/kexec-syscall.h
@@ -2,7 +2,6 @@
 #define KEXEC_SYSCALL_H
 
 #define __LIBRARY__
-#include <syscall.h>
 #include <sys/syscall.h>
 #include <unistd.h>
 
-- 
1.7.5.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
