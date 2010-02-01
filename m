Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NbvAT-00058J-5u
	for kexec@lists.infradead.org; Mon, 01 Feb 2010 12:14:20 +0000
Received: from yukiko.kent.sydney.vergenet.net
	(203-206-13-190.dyn.iinet.net.au [203.206.13.190])
	by kirsty.vergenet.net (Postfix) with ESMTP id EBAB624659
	for <kexec@lists.infradead.org>; Mon,  1 Feb 2010 23:14:01 +1100 (EST)
Message-Id: <20100201121323.189765941@vergenet.net>
Date: Mon, 01 Feb 2010 23:12:11 +1100
From: Simon Horman <horms@verge.net.au>
Subject: [patch 15/27] Cast when making signed/unsigned comparison in
	locate_hole()
References: <20100201121156.252909695@vergenet.net>
Content-Disposition: inline; filename=unsigned-long-and-int-comparison.patch
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

Index: kexec-tools/kexec/kexec.c
===================================================================
--- kexec-tools.orig/kexec/kexec.c	2010-02-01 23:07:15.000000000 +1100
+++ kexec-tools/kexec/kexec.c	2010-02-01 23:07:20.000000000 +1100
@@ -208,7 +208,7 @@ unsigned long locate_hole(struct kexec_i
 		hole_align = 1;
 	}
 	/* Align everything to at least a page size boundary */
-	if (hole_align < getpagesize()) {
+	if (hole_align < (unsigned long)getpagesize()) {
 		hole_align = getpagesize();
 	}
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
