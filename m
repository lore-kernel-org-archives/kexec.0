Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Nbvbb-00043T-UQ
	for kexec@lists.infradead.org; Mon, 01 Feb 2010 12:42:20 +0000
Received: from yukiko.kent.sydney.vergenet.net
	(203-206-13-190.dyn.iinet.net.au [203.206.13.190])
	by kirsty.vergenet.net (Postfix) with ESMTP id 48D4124662
	for <kexec@lists.infradead.org>; Mon,  1 Feb 2010 23:14:02 +1100 (EST)
Message-Id: <20100201121325.127004920@vergenet.net>
Date: Mon, 01 Feb 2010 23:12:21 +1100
From: Simon Horman <horms@verge.net.au>
Subject: [patch 25/27] arm: Include unistd.h for getpagesize()
References: <20100201121156.252909695@vergenet.net>
Content-Disposition: inline; filename=arm-getpagesize-include.patch
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

Index: kexec-tools/kexec/arch/arm/kexec-zImage-arm.c
===================================================================
--- kexec-tools.orig/kexec/arch/arm/kexec-zImage-arm.c	2010-02-01 23:07:16.000000000 +1100
+++ kexec-tools/kexec/arch/arm/kexec-zImage-arm.c	2010-02-01 23:07:23.000000000 +1100
@@ -10,6 +10,7 @@
 #include <errno.h>
 #include <limits.h>
 #include <stdint.h>
+#include <unistd.h>
 #include <getopt.h>
 #include <arch/options.h>
 #include "../../kexec.h"


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
