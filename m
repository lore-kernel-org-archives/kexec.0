Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lb0-x22b.google.com ([2a00:1450:4010:c04::22b])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YHBhQ-0001bV-RZ
 for kexec@lists.infradead.org; Fri, 30 Jan 2015 13:33:29 +0000
Received: by mail-lb0-f171.google.com with SMTP id u14so36212062lbd.2
 for <kexec@lists.infradead.org>; Fri, 30 Jan 2015 05:33:05 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] kernel/kexec.c: Use strchrnul
Date: Fri, 30 Jan 2015 14:32:52 +0100
Message-Id: <1422624772-20285-1-git-send-email-linux@rasmusvillemoes.dk>
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
To: Eric Biederman <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org

strchrnul exists precisely for this use case.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 kernel/kexec.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 9a8a01abbaed..70e7050f7ab9 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1792,12 +1792,9 @@ static __init char *get_last_crashkernel(char *cmdline,
 	/* find crashkernel and use the last one if there are more */
 	p = strstr(p, name);
 	while (p) {
-		char *end_p = strchr(p, ' ');
+		char *end_p = strchrnul(p, ' ');
 		char *q;
 
-		if (!end_p)
-			end_p = p + strlen(p);
-
 		if (!suffix) {
 			int i;
 
-- 
2.1.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
