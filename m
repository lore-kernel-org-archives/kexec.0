Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UK8wJ-0007cv-6G
 for kexec@lists.infradead.org; Mon, 25 Mar 2013 15:04:00 +0000
Received: by mail-pb0-f47.google.com with SMTP id rp2so4209418pbb.34
 for <kexec@lists.infradead.org>; Mon, 25 Mar 2013 08:03:57 -0700 (PDT)
Message-ID: <51506758.4070902@gmail.com>
Date: Mon, 25 Mar 2013 23:03:52 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 01/13] kexec: fix possible memory leak in check_reuse_initrd
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
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

If the if test is ok, then it will call die() to exit the process,
so freeing line will not be reached, causing memory leak. Fix this.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/kexec.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index f3928af..6575ada 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1020,13 +1020,15 @@ char *get_command_line(void)
 /* check we retained the initrd */
 static void check_reuse_initrd(void)
 {
+	char *str = NULL;
 	char *line = get_command_line();
 
-	if (strstr(line, "retain_initrd") == NULL)
+	str = strstr(line, "retain_initrd");
+	free(line);
+
+	if (str == NULL)
 		die("unrecoverable error: current boot didn't "
 		    "retain the initrd for reuse.\n");
-
-	free(line);
 }
 
 char *concat_cmdline(const char *base, const char *append)
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
