Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JUGBv-0003VN-Hr
	for kexec@lists.infradead.org; Wed, 27 Feb 2008 06:54:59 +0000
Received: from tabatha.lab.ultramonkey.org (vagw.valinux.co.jp [210.128.90.14])
	by koto.vergenet.net (Postfix) with ESMTP id 5BA57341C2
	for <kexec@lists.infradead.org>; Wed, 27 Feb 2008 15:54:52 +0900 (JST)
Message-Id: <20080227065343.079523630@vergenet.net>
References: <20080227065154.518014550@vergenet.net>
Date: Wed, 27 Feb 2008 15:51:57 +0900
From: Simon Horman <horms@verge.net.au>
Subject: [patch 3/5] kexec-tools: use proc_iomem()
Content-Disposition: inline; filename=arm-proc_iomem.patch
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Use proc_iomem() on arm for consistency with other architectures.

Signed-off-by: Simon Horman <horms@verge.net.au>

--- 

 kexec/arch/arm/kexec-arm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: kexec-tools-testing-ia64-xen/kexec/arch/arm/kexec-arm.c
===================================================================
--- kexec-tools-testing-ia64-xen.orig/kexec/arch/arm/kexec-arm.c	2008-02-26 16:21:04.000000000 +0900
+++ kexec-tools-testing-ia64-xen/kexec/arch/arm/kexec-arm.c	2008-02-26 16:24:17.000000000 +0900
@@ -26,7 +26,7 @@ static struct memory_range memory_range[
 int get_memory_ranges(struct memory_range **range, int *ranges,
 		unsigned long kexec_flags)
 {
-	const char iomem[]= "/proc/iomem";
+	const char iomem[]= proc_iomem();
 	int memory_ranges = 0;
 	char line[MAX_LINE];
 	FILE *fp;

-- 

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
