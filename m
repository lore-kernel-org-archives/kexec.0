Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAUYC-0008JA-4z
 for kexec@lists.infradead.org; Tue, 25 Aug 2020 08:43:29 +0000
From: Youling Tang <tangyouling@loongson.cn>
Subject: [PATCH] kexec-tools: Fix resource leaks in kexec.c
Date: Tue, 25 Aug 2020 16:43:23 +0800
Message-Id: <1598345003-1634-1-git-send-email-tangyouling@loongson.cn>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

Add free() call when handling some error returns.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 kexec/kexec.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index a62b362..a0f0908 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1128,11 +1128,15 @@ char *get_command_line(void)
 		die("Could not allocate memory to read /proc/cmdline.");
 
 	fp = fopen("/proc/cmdline", "r");
-	if (!fp)
+	if (!fp) {
+		free(line);
 		die("Could not open /proc/cmdline.");
+	}
 
-	if (fgets(line, sizeof_line, fp) == NULL)
+	if (fgets(line, sizeof_line, fp) == NULL) {
+		free(line);
 		die("Can't read /proc/cmdline.");
+	}
 
 	fclose(fp);
 
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
