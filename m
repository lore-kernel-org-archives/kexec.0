Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bpWFu-0002AK-1v
 for kexec@lists.infradead.org; Thu, 29 Sep 2016 07:59:46 +0000
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8T7vrS6093831
 for <kexec@lists.infradead.org>; Thu, 29 Sep 2016 03:59:24 -0400
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25rrpuxj2r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 29 Sep 2016 03:59:24 -0400
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 29 Sep 2016 13:29:20 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id A88EB125805F
 for <kexec@lists.infradead.org>; Thu, 29 Sep 2016 13:29:40 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8T7xHQP45285500
 for <kexec@lists.infradead.org>; Thu, 29 Sep 2016 13:29:17 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8T7xHWd010660
 for <kexec@lists.infradead.org>; Thu, 29 Sep 2016 13:29:17 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v2] kexec/fs2dt: Check for NULL pointer in
 dt_copy_old_root_param()
Date: Thu, 29 Sep 2016 13:29:13 +0530
Message-Id: <1475135953-21729-1-git-send-email-maddy@linux.vnet.ibm.com>
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
Cc: panand@redhat.com, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, kexec@lists.infradead.org

In dt_copy_old_root_param(), FILE * returned
from fopen is not checked for NULL pointer
before passinig to fclose(). This could trigger
a segfault. Patch to fix the same.

Reviewed-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
Changelog v1:
 - Moved the check right after fopen

 kexec/fs2dt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kexec/fs2dt.c b/kexec/fs2dt.c
index 6ed2399759cf..5ba3ec0fa65c 100644
--- a/kexec/fs2dt.c
+++ b/kexec/fs2dt.c
@@ -524,6 +524,9 @@ static void dt_copy_old_root_param(void)
 	strcpy(filename, pathname);
 	strcat(filename, "bootargs");
 	fp = fopen(filename, "r");
+	if (!fp)
+		return;
+
 	if (fp) {
 		if (getline(&last_cmdline, &len, fp) == -1)
 			die("unable to read %s\n", filename);
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
