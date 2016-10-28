Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bzzOV-00070L-UZ
 for kexec@lists.infradead.org; Fri, 28 Oct 2016 05:07:56 +0000
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9S56ZRe036836
 for <kexec@lists.infradead.org>; Fri, 28 Oct 2016 01:07:34 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26bvc2basb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 28 Oct 2016 01:07:34 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <kamalesh@linux.vnet.ibm.com>;
 Fri, 28 Oct 2016 15:07:31 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id EC64A2BB0054
 for <kexec@lists.infradead.org>; Fri, 28 Oct 2016 16:07:28 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9S57S8f13697094
 for <kexec@lists.infradead.org>; Fri, 28 Oct 2016 16:07:28 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9S57SWU014974
 for <kexec@lists.infradead.org>; Fri, 28 Oct 2016 16:07:28 +1100
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: [PATCH] Fix module module_init/init_size offsets for v4.5 kernel
Date: Fri, 28 Oct 2016 10:37:14 +0530
Message-Id: <1477631234-15500-1-git-send-email-kamalesh@linux.vnet.ibm.com>
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
Cc: Pratyush Anand <panand@redhat.com>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

Kernel commit 7523e4dc50 (module: use a structure to encapsulate layout.)
encapsulates core_layout and init_layout into module_layout structure.

commit fa6a75a93 (Fix module core base and size offset for kernel v4.5)
fixes offset value calculation for core layout's base and size, whereas
Kernel v4.5 module changes also needs fixing of module init_size and
module_init for the makedumpfile to read the correct module address.

This patch fixes calculation of offsets values for module init_size and
module_init.

Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Pratyush Anand <panand@redhat.com>
---
 makedumpfile.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index 853b999..f33a90d 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1689,7 +1689,25 @@ get_structure_info(void)
 		OFFSET(module.core_size) += core_layout;
 	}
 	OFFSET_INIT(module.module_init, "module", "module_init");
+	if (OFFSET(module.module_init) == NOT_FOUND_STRUCTURE) {
+		/* for kernel version 4.5 and above */
+		long init_layout;
+
+		OFFSET_INIT(module.module_init, "module", "init_layout");
+		init_layout = OFFSET(module.module_init);
+		OFFSET_INIT(module.module_init, "module_layout", "base");
+		OFFSET(module.module_init) += init_layout;
+	}
 	OFFSET_INIT(module.init_size, "module", "init_size");
+	if (OFFSET(module.init_size) == NOT_FOUND_STRUCTURE) {
+		/* for kernel version 4.5 and above */
+		long init_layout;
+
+		OFFSET_INIT(module.init_size, "module", "init_layout");
+		init_layout = OFFSET(module.init_size);
+		OFFSET_INIT(module.init_size, "module_layout", "size");
+		OFFSET(module.init_size) += init_layout;
+	}
 
 	ENUM_NUMBER_INIT(NR_FREE_PAGES, "NR_FREE_PAGES");
 	ENUM_NUMBER_INIT(N_ONLINE, "N_ONLINE");
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
