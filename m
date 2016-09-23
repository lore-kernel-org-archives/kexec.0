Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bnKkT-0002CI-0R
 for kexec@lists.infradead.org; Fri, 23 Sep 2016 07:18:19 +0000
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8N7HrD7096442
 for <kexec@lists.infradead.org>; Fri, 23 Sep 2016 03:17:56 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25mqb5kjc6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 23 Sep 2016 03:17:55 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <maddy@linux.vnet.ibm.com>;
 Fri, 23 Sep 2016 17:17:44 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 87CF82CE8046
 for <kexec@lists.infradead.org>; Fri, 23 Sep 2016 17:17:43 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8N7HhBg5112092
 for <kexec@lists.infradead.org>; Fri, 23 Sep 2016 17:17:43 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8N7HhBl006002
 for <kexec@lists.infradead.org>; Fri, 23 Sep 2016 17:17:43 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH] kexec/fs2dt: Check for NULL pointer in
 dt_copy_old_root_param()
Date: Fri, 23 Sep 2016 12:47:39 +0530
Message-Id: <1474615059-9510-1-git-send-email-maddy@linux.vnet.ibm.com>
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
a segfault. Patch adds a check.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 kexec/fs2dt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kexec/fs2dt.c b/kexec/fs2dt.c
index 6ed2399759cf..2c1ebdf525f4 100644
--- a/kexec/fs2dt.c
+++ b/kexec/fs2dt.c
@@ -540,7 +540,8 @@ static void dt_copy_old_root_param(void)
 	if (last_cmdline)
 		free(last_cmdline);
 
-	fclose(fp);
+	if (fp)
+		fclose(fp);
 }
 
 /*
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
