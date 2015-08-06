Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZNJ50-0006Fa-NJ
 for kexec@lists.infradead.org; Thu, 06 Aug 2015 11:11:23 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH] kexec: use _DEFAULT_SOURCE instead to remove compiling warning
Date: Thu,  6 Aug 2015 19:10:55 +0800
Message-Id: <1438859455-25789-1-git-send-email-bhe@redhat.com>
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
Cc: horms@verge.net.au, Baoquan He <bhe@redhat.com>

Now compiling will print warning like below. Change code as it suggested.
 # warning "_BSD_SOURCE and _SVID_SOURCE are deprecated, use _DEFAULT_SOURCE"
   ^

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 kexec/arch/i386/crashdump-x86.c    | 2 +-
 kexec/arch/i386/kexec-x86-common.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index dea42d0..4375103 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -20,7 +20,7 @@
  */
 
 #define _XOPEN_SOURCE	600
-#define _BSD_SOURCE
+#define _DEFAULT_SOURCE
 
 #include <fcntl.h>
 #include <stdio.h>
diff --git a/kexec/arch/i386/kexec-x86-common.c b/kexec/arch/i386/kexec-x86-common.c
index 90534a8..37931e1 100644
--- a/kexec/arch/i386/kexec-x86-common.c
+++ b/kexec/arch/i386/kexec-x86-common.c
@@ -18,7 +18,7 @@
  */
 
 #define _XOPEN_SOURCE	600
-#define _BSD_SOURCE
+#define _DEFAULT_SOURCE
 
 #include <fcntl.h>
 #include <stddef.h>
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
