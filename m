Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1brEfu-0004zb-0Q
 for kexec@lists.infradead.org; Tue, 04 Oct 2016 01:37:43 +0000
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u941XEva071463
 for <kexec@lists.infradead.org>; Mon, 3 Oct 2016 21:37:19 -0400
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25uy9jy1rr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 03 Oct 2016 21:37:19 -0400
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 4 Oct 2016 07:07:16 +0530
Received: from d28relay08.in.ibm.com (d28relay08.in.ibm.com [9.184.220.159])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id E6E913940033
 for <kexec@lists.infradead.org>; Tue,  4 Oct 2016 07:07:13 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u941b0Nj31064262
 for <kexec@lists.infradead.org>; Tue, 4 Oct 2016 07:07:00 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u941bDsG029037
 for <kexec@lists.infradead.org>; Tue, 4 Oct 2016 07:07:13 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v3] kexec/fs2dt: Check for NULL pointer in
 dt_copy_old_root_param()
Date: Tue,  4 Oct 2016 07:07:05 +0530
Message-Id: <1475545025-31977-1-git-send-email-maddy@linux.vnet.ibm.com>
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
To: horms@verge.net.au
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, kexec@lists.infradead.org

In dt_copy_old_root_param(), FILE * returned
from fopen is not checked for NULL pointer
before passinig to fclose(). This could trigger
a segfault. Patch to fix the same.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
Changelog v2
-Removed redundant check fp

Changelog v1:
- Moved the check right after fopen
 
 kexec/fs2dt.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/kexec/fs2dt.c b/kexec/fs2dt.c
index 6ed2399759cf..79aa0f320a5a 100644
--- a/kexec/fs2dt.c
+++ b/kexec/fs2dt.c
@@ -524,19 +524,21 @@ static void dt_copy_old_root_param(void)
 	strcpy(filename, pathname);
 	strcat(filename, "bootargs");
 	fp = fopen(filename, "r");
-	if (fp) {
-		if (getline(&last_cmdline, &len, fp) == -1)
-			die("unable to read %s\n", filename);
-
-		p = strstr(last_cmdline, "root=");
-		if (p) {
-			old_param = strtok(p, " ");
-			len = strlen(local_cmdline);
-			if (len != 0)
-				strcat(local_cmdline, " ");
-			strcat(local_cmdline, old_param);
-		}
+	if (!fp)
+		return;
+
+	if (getline(&last_cmdline, &len, fp) == -1)
+		die("unable to read %s\n", filename);
+
+	p = strstr(last_cmdline, "root=");
+	if (p) {
+		old_param = strtok(p, " ");
+		len = strlen(local_cmdline);
+		if (len != 0)
+			strcat(local_cmdline, " ");
+		strcat(local_cmdline, old_param);
 	}
+
 	if (last_cmdline)
 		free(last_cmdline);
 
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
