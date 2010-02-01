Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NbvAS-00058F-V4
	for kexec@lists.infradead.org; Mon, 01 Feb 2010 12:14:20 +0000
Received: from yukiko.kent.sydney.vergenet.net
	(203-206-13-190.dyn.iinet.net.au [203.206.13.190])
	by kirsty.vergenet.net (Postfix) with ESMTP id C83AE24655
	for <kexec@lists.infradead.org>; Mon,  1 Feb 2010 23:14:01 +1100 (EST)
Message-Id: <20100201121322.435059133@vergenet.net>
Date: Mon, 01 Feb 2010 23:12:07 +1100
From: Simon Horman <horms@verge.net.au>
Subject: [patch 11/27] ppc: memory_range global is only used in conjunction
	with WITH_GAMECUBE
References: <20100201121156.252909695@vergenet.net>
Content-Disposition: inline; filename=ppc64-WITH_GAMECUBE-memory_range.patch
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Kexec Mailing List <kexec@lists.infradead.org>

Signed-off-by: Simon Horman <horms@verge.net.au>

Index: kexec-tools/kexec/arch/ppc/kexec-ppc.c
===================================================================
--- kexec-tools.orig/kexec/arch/ppc/kexec-ppc.c	2010-02-01 23:07:16.000000000 +1100
+++ kexec-tools/kexec/arch/ppc/kexec-ppc.c	2010-02-01 23:07:19.000000000 +1100
@@ -19,8 +19,10 @@
 
 #include "config.h"
 
+#ifdef WITH_GAMECUBE
 #define MAX_MEMORY_RANGES  64
 static struct memory_range memory_range[MAX_MEMORY_RANGES];
+#endif
 
 /* Return a sorted list of memory ranges. */
 int get_memory_ranges(struct memory_range **UNUSED(range), int *UNUSED(ranges),


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
