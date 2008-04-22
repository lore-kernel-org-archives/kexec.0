Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rv-out-0708.google.com ([209.85.198.243]
	helo=rv-out-0506.google.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JoRz2-0006vd-R5
	for kexec@lists.infradead.org; Tue, 22 Apr 2008 23:33:09 +0000
Received: by rv-out-0506.google.com with SMTP id b17so1263444rvf.42
	for <kexec@lists.infradead.org>; Tue, 22 Apr 2008 16:33:08 -0700 (PDT)
From: Jamey Sharp <jamey@thetovacompany.com>
Subject: [PATCH 8/9] Simplify initialization of argument list for `shutdown`.
Date: Tue, 22 Apr 2008 16:21:11 -0700
Message-Id: <1208906472-18465-9-git-send-email-jamey@thetovacompany.com>
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

Signed-off-by: Jamey Sharp <jamey@thetovacompany.com>
---
Admittedly gratuitous, but I couldn't stand it. :-)

 kexec/kexec.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 2a71ace..3a1656a 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -704,13 +704,12 @@ int k_unload (unsigned long kexec_flags)
  */
 static int my_shutdown(void)
 {
-	char *args[8];
-	int i = 0;
-
-	args[i++] = "shutdown";
-	args[i++] = "-r";
-	args[i++] = "now";
-	args[i++] = NULL;
+	char *args[] = {
+		"shutdown",
+		"-r",
+		"now",
+		NULL
+	};
 
 	execv("/sbin/shutdown", args);
 	execv("/etc/shutdown", args);
-- 
1.5.4.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
