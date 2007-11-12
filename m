Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.66 #1 (Red Hat Linux))
	id 1IrRKc-0005vA-B4
	for kexec@lists.infradead.org; Sun, 11 Nov 2007 23:55:37 -0500
From: Simon Horman <horms@verge.net.au>
Subject: [patch] ia64: Guard elfcorehdr_addr with #if CONFIG_PROC_FS
Message-Id: <20071112045521.2BAF54F9EB@tabatha.lab.ultramonkey.org>
Date: Mon, 12 Nov 2007 13:55:21 +0900 (JST)
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: linux-ia64@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Haren Myneni <hbabu@us.ibm.com>, Tony Luck <tony.luck@intel.com>, Vivek Goyal <vgoyal@in.ibm.com>

Access to elfcorehdr_addr needs to be guarded by #if CONFIG_PROC_FS
as well as the existing #if guards.

Fixes the following build problem:

arch/ia64/hp/common/built-in.o: In function
`sba_init':arch/ia64/hp/common/sba_iommu.c:2043: undefined reference to `elfcorehdr_addr'
:arch/ia64/hp/common/sba_iommu.c:2043: undefined reference to `elfcorehdr_addr'

Signed-off-by: Simon Horman <horms@verge.net.au>

Index: net-2.6/arch/ia64/hp/common/sba_iommu.c
===================================================================
--- net-2.6.orig/arch/ia64/hp/common/sba_iommu.c	2007-11-12 12:49:23.000000000 +0900
+++ net-2.6/arch/ia64/hp/common/sba_iommu.c	2007-11-12 13:29:07.000000000 +0900
@@ -2034,7 +2034,8 @@ sba_init(void)
 	if (!ia64_platform_is("hpzx1") && !ia64_platform_is("hpzx1_swiotlb"))
 		return 0;
 
-#if defined(CONFIG_IA64_GENERIC) && defined(CONFIG_CRASH_DUMP)
+#if defined(CONFIG_IA64_GENERIC) && defined(CONFIG_CRASH_DUMP) && \
+        defined(CONFIG_PROC_FS)
 	/* If we are booting a kdump kernel, the sba_iommu will
 	 * cause devices that were not shutdown properly to MCA
 	 * as soon as they are turned back on.  Our only option for

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
