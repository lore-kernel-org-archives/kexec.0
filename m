Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZkQgm-0005jd-SB
 for kexec@lists.infradead.org; Fri, 09 Oct 2015 05:57:57 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
 (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
 by mx1.redhat.com (Postfix) with ESMTPS id 99660AB97B
 for <kexec@lists.infradead.org>; Fri,  9 Oct 2015 05:57:35 +0000 (UTC)
Date: Fri, 9 Oct 2015 13:57:22 +0800
From: Dave Young <dyoung@redhat.com>
Subject: [PATCH] kexec-tools: do not copy 1st kernel root= param in fs2dt.c
Message-ID: <20151009055722.GA6248@dhcp-129-237.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
To: kexec@lists.infradead.org
Cc: jstodola@redhat.com

Jan Stodola <jstodola@redhat.com> reported ppc64 root= is always added in kexec
kernel cmdline. But sometimes we need boot without root= for example we use
kexec to boot into installation initramfs image like below:
kexec --load vmlinuz --initrd=initrd.img --command-line=\
"inst.repo=http://<server>/<path>/Server/ppc64le/os/"

While creating dtb, in case there's no root= in user provided cmdline params 
kexec-tools will find the original root= param used in 1st kernel and pass it
to 2nd kernel. This caused that user have no way to remove root= cmdline.

Dropping that part of code so that one can get chance to kexec into 2nd kernel
without root= param. One can still provide root= in --command-line=""

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 kexec/fs2dt.c |   31 +------------------------------
 1 file changed, 1 insertion(+), 30 deletions(-)

--- kexec-tools.orig/kexec/fs2dt.c
+++ kexec-tools/kexec/fs2dt.c
@@ -579,8 +579,7 @@ static void putnode(void)
 		reserve(initrd_base, initrd_size);
 	}
 
-	/* Add cmdline to the second kernel.  Check to see if the new
-	 * cmdline has a root=.  If not, use the old root= cmdline.  */
+	/* Add cmdline to the second kernel. */
 	if (!strcmp(basename,"chosen/")) {
 		size_t result;
 		size_t cmd_len = 0;
@@ -594,36 +593,8 @@ static void putnode(void)
 			param = strstr(local_cmdline, "crashkernel=");
 			if (param)
 				crash_param = 1;
-			/* does the new cmdline have a root= ? ... */
-			param = strstr(local_cmdline, "root=");
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
-		strcat(local_cmdline, " ");
-		cmd_len = strlen(local_cmdline);
 		cmd_len = cmd_len + 1;
 
 		/* add new bootargs */

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
