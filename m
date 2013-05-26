Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UgXnC-000381-AB
 for kexec@lists.infradead.org; Sun, 26 May 2013 10:03:11 +0000
Received: by mail-pd0-f182.google.com with SMTP id g10so5621635pdj.27
 for <kexec@lists.infradead.org>; Sun, 26 May 2013 03:02:48 -0700 (PDT)
Message-ID: <51A1DDBD.3020507@gmail.com>
Date: Sun, 26 May 2013 18:02:37 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH] kexec-tools: ppc/ppc64: cleanup: Remove never reached return
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

The return will never be reached, so remove it.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/arch/ppc/kexec-ppc.c     |    1 -
 kexec/arch/ppc64/kexec-ppc64.c |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/ppc/kexec-ppc.c b/kexec/arch/ppc/kexec-ppc.c
index 5a2966e..d046110 100644
--- a/kexec/arch/ppc/kexec-ppc.c
+++ b/kexec/arch/ppc/kexec-ppc.c
@@ -736,7 +736,6 @@ static int get_devtree_details(unsigned long kexec_flags)
 					!= 1) {
 				perror(fname);
 				goto error_openfile;
-				return -1;
 			}
 			memset(fname, 0, sizeof(fname));
 			sprintf(fname, "%s%s%s",
diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
index 389741a..21bd0a8 100644
--- a/kexec/arch/ppc64/kexec-ppc64.c
+++ b/kexec/arch/ppc64/kexec-ppc64.c
@@ -590,7 +590,6 @@ static int get_devtree_details(unsigned long kexec_flags)
 			if (fread(&tce_base, sizeof(uint64_t), 1, file) != 1) {
 				perror(fname);
 				goto error_openfile;
-				return -1;
 			}
 			memset(fname, 0, sizeof(fname));
 			strcpy(fname, device_tree);
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
