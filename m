Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RE812-0007Ok-QD
	for kexec@lists.infradead.org; Wed, 12 Oct 2011 23:15:13 +0000
From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 1/2] sh: Correct logic errors in is_32bit()
Date: Thu, 13 Oct 2011 07:44:40 +0900
Message-Id: <1318459481-23527-1-git-send-email-horms@verge.net.au>
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
To: kexec@lists.infradead.org, linux-sh@vger.kernel.org
Cc: Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>

This corrects logic errors so that is_32bit() can actually detect that it
is running on a 32 bit system - something the original version I wrote
failed at woefully.

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 kexec/arch/sh/kexec-sh.c |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/kexec/arch/sh/kexec-sh.c b/kexec/arch/sh/kexec-sh.c
index 94ebbc7..a397d08 100644
--- a/kexec/arch/sh/kexec-sh.c
+++ b/kexec/arch/sh/kexec-sh.c
@@ -188,9 +188,8 @@ void kexec_sh_setup_zero_page(char *zero_page_buf, size_t zero_page_size,
 static int is_32bit(void)
 {
 	const char *cpuinfo = "/proc/cpuinfo";
-	char line[MAX_LINE], key[MAX_LINE], value[MAX_LINE];
+	char line[MAX_LINE];
 	FILE *fp;
-	int count;
 	int status = 0;
 
 	fp = fopen(cpuinfo, "r");
@@ -198,14 +197,17 @@ static int is_32bit(void)
 		die("Cannot open %s\n", cpuinfo);
 
 	while(fgets(line, sizeof(line), fp) != 0) {
-		count = sscanf(line, "%s : %s", key, value);
-		if (count != 2)
+		const char *key = "address sizes";
+		const char *value = " 32 bits physical";
+		char *p;
+		if (strncmp(line, key, strlen(key)))
 			continue;
-		if (!strcmp(key, "address sizes")) {
-			if (!strcmp(value, "32 bits physical"))
-				status = 1;
-			break;
-		}
+		p = strchr(line + strlen(key), ':');
+		if (!p)
+			continue;
+		if (!strncmp(p + 1, value, strlen(value)))
+			status = 1;
+		break;
 	}
 
 	fclose(fp);
-- 
1.7.6.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
