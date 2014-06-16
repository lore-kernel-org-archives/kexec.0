Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WwWFl-000384-Ve
 for kexec@lists.infradead.org; Mon, 16 Jun 2014 12:43:14 +0000
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <ldufour@linux.vnet.ibm.com>;
 Mon, 16 Jun 2014 13:42:49 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6B1CA17D804E
 for <kexec@lists.infradead.org>; Mon, 16 Jun 2014 13:44:10 +0100 (BST)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5GCgkFS35520554
 for <kexec@lists.infradead.org>; Mon, 16 Jun 2014 12:42:46 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5GCgjVU018180
 for <kexec@lists.infradead.org>; Mon, 16 Jun 2014 06:42:46 -0600
Subject: [PATCH] kexec/ppc64: move to device tree version 17
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Mon, 16 Jun 2014 14:42:43 +0200
Message-ID: <20140616124243.11173.39355.stgit@nimbus>
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
To: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

Kernel commit e6a6928c3ea1d0195ed75a091e345696b916c09b changed the way the
device tree is processed in the kernel. Now version 2 is no more supported.

This patch move the version of the device tree generated in ppc64
environment from 2 to 17, allowing to kexec kernel 3.16.

In addition, automates the define of NEED_STRUCTURE_BLOCK_EXTRA_PAD which
should not be set for DT version 16 and above.

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 kexec/arch/ppc64/kexec-ppc64.h |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/ppc64/kexec-ppc64.h b/kexec/arch/ppc64/kexec-ppc64.h
index 9a0aecf..89ee942 100644
--- a/kexec/arch/ppc64/kexec-ppc64.h
+++ b/kexec/arch/ppc64/kexec-ppc64.h
@@ -6,9 +6,11 @@
 #define CORE_TYPE_ELF32 1
 #define CORE_TYPE_ELF64 2
 
-#define BOOT_BLOCK_VERSION 2
-#define BOOT_BLOCK_LAST_COMP_VERSION 2
-#define NEED_STRUCTURE_BLOCK_EXTRA_PAD
+#define BOOT_BLOCK_VERSION 17
+#define BOOT_BLOCK_LAST_COMP_VERSION 17
+#if (BOOT_BLOCK_VERSION < 16)
+#	define NEED_STRUCTURE_BLOCK_EXTRA_PAD
+#endif
 #define HAVE_DYNAMIC_MEMORY
 #define NEED_RESERVE_DTB
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
