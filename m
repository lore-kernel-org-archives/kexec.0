Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-da0-x22f.google.com ([2607:f8b0:400e:c00::22f])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UFpI3-00046h-OT
 for kexec@lists.infradead.org; Wed, 13 Mar 2013 17:16:36 +0000
Received: by mail-da0-f47.google.com with SMTP id s35so503234dak.6
 for <kexec@lists.infradead.org>; Wed, 13 Mar 2013 10:16:33 -0700 (PDT)
Message-ID: <5140B469.8080308@gmail.com>
Date: Thu, 14 Mar 2013 01:16:25 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH] kexec: check size before trying the malloc
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

If size is zero, it is unnecessary to do the malloc operation.
So checking size first is better than doing malloc first.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/kexec.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 3ef6f0d..494c5b3 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -76,9 +76,9 @@ static char *xstrdup(const char *str)
 void *xmalloc(size_t size)
 {
 	void *buf;
-	buf = malloc(size);
 	if (!size)
 		return NULL;
+	buf = malloc(size);
 	if (!buf) {
 		die("Cannot malloc %ld bytes: %s\n",
 			size + 0UL, strerror(errno));
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
