Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ti-out-0910.google.com ([209.85.142.185])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Kaqf2-0006aJ-PT
	for kexec@lists.infradead.org; Wed, 03 Sep 2008 11:36:33 +0000
Received: by ti-out-0910.google.com with SMTP id a21so1794066tia.2
	for <kexec@lists.infradead.org>; Wed, 03 Sep 2008 04:36:30 -0700 (PDT)
From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 03 Sep 2008 20:36:42 +0900
Message-Id: <20080903113642.31132.32287.sendpatchset@rx1.opensource.se>
Subject: [PATCH] sh: Fix help text spelling
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
Cc: horms@verge.net.au, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm@igel.co.jp>

Fix SuperH help text spelling.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 kexec/arch/sh/kexec-sh.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/kexec/arch/sh/kexec-sh.c
+++ work/kexec/arch/sh/kexec-sh.c	2008-08-27 16:51:55.000000000 +0900
@@ -66,7 +66,7 @@ void arch_usage(void)
     " none\n\n"
     "Default options:\n"
     " --append=\"%s\"\n"
-    " STRING of --appned is set form /proc/cmdline as default.\n"
+    " STRING of --append is set from /proc/cmdline as default.\n"
     ,get_append());
 
 }

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
