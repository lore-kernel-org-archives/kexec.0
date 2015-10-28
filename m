Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZrJYC-0004c0-7R
 for kexec@lists.infradead.org; Wed, 28 Oct 2015 05:45:33 +0000
Message-Id: <20151028054359.909471239@redhat.com>
Date: Wed, 28 Oct 2015 13:41:35 +0800
From: dyoung@redhat.com
Subject: [kexec-tools PATCH 1/3] fs2dt.c: move copy old root param as a new
 function
References: <20151028054134.200833741@redhat.com>
Content-Disposition: inline; filename=fs2dt-fix.patch
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
To: kexec@lists.infradead.org
Cc: jstodola@redhat.com, horms@verge.net.au

Split the copy old root param code to a new function dt_copy_old_root_param
Also add a global variable dt_no_old_root, do not copy root param when
dt_no_old_root == 1. It will be used in later patches.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 kexec/fs2dt.c |   66 +++++++++++++++++++++++++++++++++++-----------------------
 kexec/fs2dt.h |    1 
 2 files changed, 41 insertions(+), 26 deletions(-)

--- kexec-tools.orig/kexec/fs2dt.c
+++ kexec-tools/kexec/fs2dt.c
@@ -53,6 +53,7 @@ extern unsigned char reuse_initrd;
 /* Used for enabling printing message from purgatory code
  * Only has implemented for PPC64 */
 int my_debug;
+int dt_no_old_root;
 
 /* This provides the behaviour of hte existing ppc64 implementation */
 static void pad_structure_block(size_t len) {
@@ -511,6 +512,37 @@ static int comparefunc(const struct dire
 	return strcmp(str1, str2);
 }
 
+/* grab root= from the old command line */
+static void dt_copy_old_root_param(void)
+{
+	FILE *fp;
+	char filename[MAXPATH];
+	char *last_cmdline = NULL;
+	char *p, *old_param;
+	size_t len = 0;
+
+	strcpy(filename, pathname);
+	strcat(filename, "bootargs");
+	fp = fopen(filename, "r");
+	if (fp) {
+		if (getline(&last_cmdline, &len, fp) == -1)
+			die("unable to read %s\n", filename);
+
+		p = strstr(last_cmdline, "root=");
+		if (p) {
+			old_param = strtok(p, " ");
+			len = strlen(local_cmdline);
+			if (len != 0)
+				strcat(local_cmdline, " ");
+			strcat(local_cmdline, old_param);
+		}
+	}
+	if (last_cmdline)
+		free(last_cmdline);
+
+	fclose(fp);
+}
+
 /*
  * put a node (directory) in the property structure.  first properties
  * then children.
@@ -579,8 +611,11 @@ static void putnode(void)
 		reserve(initrd_base, initrd_size);
 	}
 
-	/* Add cmdline to the second kernel.  Check to see if the new
-	 * cmdline has a root=.  If not, use the old root= cmdline.  */
+	/*
+	 * Add cmdline to the second kernel. Use the old root= cmdline if there
+	 * is no root= in the new command line and there's no --dt-no-old-root
+	 * option being used.
+	 */
 	if (!strcmp(basename,"chosen/")) {
 		size_t result;
 		size_t cmd_len = 0;
@@ -598,30 +633,9 @@ static void putnode(void)
 			param = strstr(local_cmdline, "root=");
 		}
 
-		/* ... if not, grab root= from the old command line */
-		if (!param) {
-			FILE *fp;
-			char *last_cmdline = NULL;
-			char *old_param;
-
-			strcpy(filename, pathname);
-			strcat(filename, "bootargs");
-			fp = fopen(filename, "r");
-			if (fp) {
-				if (getline(&last_cmdline, &cmd_len, fp) == -1)
-					die("unable to read %s\n", filename);
-
-				param = strstr(last_cmdline, "root=");
-				if (param) {
-					old_param = strtok(param, " ");
-					if (cmd_len != 0)
-						strcat(local_cmdline, " ");
-					strcat(local_cmdline, old_param);
-				}
-			}
-			if (last_cmdline)
-				free(last_cmdline);
-		}
+		if (!param && !dt_no_old_root)
+			dt_copy_old_root_param();
+
 		strcat(local_cmdline, " ");
 		cmd_len = strlen(local_cmdline);
 		cmd_len = cmd_len + 1;
--- kexec-tools.orig/kexec/fs2dt.h
+++ kexec-tools/kexec/fs2dt.h
@@ -31,6 +31,7 @@ extern struct bootblock bb[1];
 /* Used for enabling printing message from purgatory code
  * Only has implemented for PPC64 */
 int my_debug;
+extern int dt_no_old_root;
 
 void reserve(unsigned long long where, unsigned long long length);
 void create_flatten_tree(char **, off_t *, const char *);



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
