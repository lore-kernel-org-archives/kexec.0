Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxpBD-005Fzu-E0
 for kexec@lists.infradead.org; Thu, 16 Dec 2021 11:44:14 +0000
From: Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v3 4/5] use slurp_proc_file() in get_command_line()
Date: Thu, 16 Dec 2021 12:43:55 +0100
Message-Id: <20211216114356.605851-5-svens@linux.ibm.com>
In-Reply-To: <20211216114356.605851-1-svens@linux.ibm.com>
References: <20211216114356.605851-1-svens@linux.ibm.com>
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
Cc: kexec@lists.infradead.org, prudo@redhat.com, Sven Schnelle <svens@linux.ibm.com>

This way the size of the command line that get_command_line() can handle
is no longer fixed.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 kexec/kexec.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index f3adac517161..7e4787bc8211 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1172,25 +1172,19 @@ static char *slurp_proc_file(const char *filename, size_t *len)
  */
 char *get_command_line(void)
 {
-	FILE *fp;
-	char *line;
-	const int sizeof_line = 2048;
-
-	line = malloc(sizeof_line);
-	if (line == NULL)
-		die("Could not allocate memory to read /proc/cmdline.");
-
-	fp = fopen("/proc/cmdline", "r");
-	if (!fp)
-		die("Could not open /proc/cmdline.");
-
-	if (fgets(line, sizeof_line, fp) == NULL)
-		die("Can't read /proc/cmdline.");
+	char *p, *line;
+	size_t size;
 
-	fclose(fp);
+	line = slurp_proc_file("/proc/cmdline", &size);
+	if (!line || !size)
+		die("Failed to read /proc/cmdline\n");
 
 	/* strip newline */
-	line[strlen(line) - 1] = '\0';
+	line[size-1] = '\0';
+
+	p = strpbrk(line, "\r\n");
+	if (p)
+		*p = '\0';
 
 	remove_parameter(line, "BOOT_IMAGE");
 	if (kexec_flags & KEXEC_ON_CRASH)
-- 
2.32.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
