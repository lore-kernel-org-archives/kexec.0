Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bKkYX-000684-ME
 for kexec@lists.infradead.org; Wed, 06 Jul 2016 10:59:50 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u66Ax86V026316
 for <kexec@lists.infradead.org>; Wed, 6 Jul 2016 06:59:28 -0400
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 by mx0b-001b2d01.pphosted.com with ESMTP id 240nbyty94-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 06 Jul 2016 06:59:28 -0400
Received: from localhost
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hutzl@linux.vnet.ibm.com>;
 Wed, 6 Jul 2016 11:59:26 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3BD062190056
 for <kexec@lists.infradead.org>; Wed,  6 Jul 2016 11:58:52 +0100 (BST)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u66AxN0q10224068
 for <kexec@lists.infradead.org>; Wed, 6 Jul 2016 10:59:23 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u66AxMXe026563
 for <kexec@lists.infradead.org>; Wed, 6 Jul 2016 04:59:22 -0600
Received: from dyn-9-152-224-56.boeblingen.de.ibm.com
 (dyn-9-152-224-56.boeblingen.de.ibm.com [9.152.224.56])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u66AxMbl026554
 for <kexec@lists.infradead.org>; Wed, 6 Jul 2016 04:59:22 -0600
From: Guenther Hutzl <hutzl@linux.vnet.ibm.com>
Subject: [PATCH] makedumpfile: fix module init base and size offset for kernel
 v4.5
Date: Wed, 6 Jul 2016 12:59:22 +0200
MIME-Version: 1.0
Message-Id: <8140a1f8-55c9-b725-ba31-fc410527d201@linux.vnet.ibm.com>
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

Hello!

This is a follow-up patch on the patch provided in post:

"[PATCH] makedumpfile: fix module core base and size offset for kernel v4.5"
by Pratyush Anand

What is missing there is the changes that were done to the module_init entry
of the struct module. The patch does basically the same as the patch for
module_core adapted to module_init.
Here is the patch:
---
Following commit in kernel v4.5 changed struct module, which affects offset
calculation of core and init layout's base and size.

commit 7523e4dc5057e157212b4741abd6256e03404cf1
Author: Rusty Russell <rusty at rustcorp.com.au>
Date:   Thu Nov 26 09:44:08 2015 +1030

    module: use a structure to encapsulate layout.

This patch fixes makedumpfile code to cater the module_init modification.

Signed-off-by: Guenther Hutzl <hutzl@linux.vnet.ibm.com>
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
2.6.6

-- 
Guenther Hutzl
Linux on System z & Virtualization Development


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
