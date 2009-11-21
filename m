Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp-out13.alice.it ([85.33.2.18])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NBz8k-0005qg-NV
	for kexec@lists.infradead.org; Sat, 21 Nov 2009 23:13:19 +0000
From: Andrea Adami <andrea.adami@gmail.com>
Subject: [PATCH] kexec.c: workaround getline and fscanf to make it *libc
	agnostic. Tested against klibc and dietlibc.
Date: Sun, 22 Nov 2009 00:12:49 +0100
Message-Id: <1258845169-4999-1-git-send-email-andrea.adami@gmail.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Yuri Bushmelev <jay4mail@gmail.com>, Andrea Adami <andrea.adami@gmail.com>


Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
Signed-off-by: Yuri Bushmelev <jay4mail@gmail.com>
---
 kexec/kexec.c |   38 ++++++++++++++++++++++++++++++--------
 1 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index ce105cd..a3ca79c 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -933,15 +933,32 @@ void usage(void)
 
 static int kexec_loaded(void)
 {
-	int ret;
+	long ret = -1;
 	FILE *fp;
+	char *p;
+	char line[3];
 
 	fp = fopen("/sys/kernel/kexec_loaded", "r");
 	if (fp == NULL)
 		return -1;
-	fscanf(fp, "%d", &ret);
+/*	fscanf(fp, "%d", &ret); */
+	p = fgets(line, sizeof(line), fp);
 	fclose(fp);
-	return ret;
+
+	if ( NULL == p)
+		return -1;
+
+	ret = strtol(line, &p, 10);
+
+	if (ret > INT_MAX)
+	/* Too long */
+		return -1;
+
+	if (p == line)
+	/* No digits were found */
+		return -1;
+
+	return (int)ret;
 }
 
 /*
@@ -989,18 +1006,23 @@ static void remove_parameter(char *line, const char *param_name)
 char *get_command_line(void)
 {
 	FILE *fp;
-	size_t len;
-	char *line = NULL;
+	const int sizeof_line = 1024;
+	char *line = malloc(sizeof_line); /* according to strdup() later */
 
 	fp = fopen("/proc/cmdline", "r");
 	if (!fp)
-		die("Could not read /proc/cmdline.");
-	getline(&line, &len, fp);
+		die("Could not open /proc/cmdline.");
+
+	if ( NULL == fgets(line, sizeof(line), fp) ) {
+		die("Can't read /proc/cmdline.");
+
+/* 	getline(&line, &len, fp); */
 	fclose(fp);
+	}
 
 	if (line) {
 		/* strip newline */
-		*(line + strlen(line) - 1) = 0;
+		line[strlen(line) - 1] = '\0';
 
 		remove_parameter(line, "BOOT_IMAGE");
 		if (kexec_flags & KEXEC_ON_CRASH)
-- 
1.6.4.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
