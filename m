Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOl5w-00FRlV-IH
 for kexec@lists.infradead.org; Tue, 23 Mar 2021 17:45:35 +0000
Received: by mail-wr1-x442.google.com with SMTP id 61so21652333wrm.12
 for <kexec@lists.infradead.org>; Tue, 23 Mar 2021 10:45:31 -0700 (PDT)
From: Raphael Ning <raphning@gmail.com>
Subject: [PATCH] kexec: Fix description of --status exit code
Date: Tue, 23 Mar 2021 17:45:02 +0000
Message-Id: <20210323174502.32673-1-raphning@gmail.com>
MIME-Version: 1.0
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
Cc: kexec@lists.infradead.org, Julien Grall <julien@xen.org>, Hongyan Xia <hx242@xen.org>, Raphael Ning <raphning@amazon.com>

From: Raphael Ning <raphning@amazon.com>

On both Linux and Xen, an exit code of 0 from `kexec --status`
indicates that the kexec image being queried is NOT loaded, which
is contrary to what the man page and usage() say.

Signed-off-by: Raphael Ning <raphning@amazon.com>
---
 kexec/kexec.8 | 6 +++---
 kexec/kexec.c | 3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/kexec/kexec.8 b/kexec/kexec.8
index 258072587cd0..3ebede67388e 100644
--- a/kexec/kexec.8
+++ b/kexec/kexec.8
@@ -108,9 +108,9 @@ command:
 Enable debugging messages.
 .TP
 .B \-S\ (\-\-status)
-Return 0 if the type (by default crash) is loaded. Can be used in conjuction
-with -l or -p to toggle the type. Note this option supersedes other options
-and it will
+Return 1 if the type (by default crash) is loaded, 0 if not. Can be used in
+conjuction with -l or -p to toggle the type. Note this option supersedes other
+options and it will
 .BR not\ load\ or\ unload\ the\ kernel.
 .TP
 .B \-e\ (\-\-exec)
diff --git a/kexec/kexec.c b/kexec/kexec.c
index fd7c8d2b7a79..ffc689ac3d7f 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1040,7 +1040,8 @@ void usage(void)
 	       "                      syscall is not supported or the kernel did not\n"
 	       "                      understand the image\n"
 	       " -d, --debug          Enable debugging to help spot a failure.\n"
-	       " -S, --status         Return 0 if the type (by default crash) is loaded.\n"
+	       " -S, --status         Return 1 if the type (by default crash) is loaded,\n"
+	       "                      0 if not.\n"
 	       "\n"
 	       "Supported kernel file types and options: \n");
 	for (i = 0; i < file_types; i++) {
-- 
2.23.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
