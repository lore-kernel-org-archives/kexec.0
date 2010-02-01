Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NbvAI-00054O-Mm
	for kexec@lists.infradead.org; Mon, 01 Feb 2010 12:14:12 +0000
Received: from yukiko.kent.sydney.vergenet.net
	(203-206-13-190.dyn.iinet.net.au [203.206.13.190])
	by kirsty.vergenet.net (Postfix) with ESMTP id 640CF24066
	for <kexec@lists.infradead.org>; Mon,  1 Feb 2010 23:14:01 +1100 (EST)
Message-Id: <20100201121320.943041563@vergenet.net>
Date: Mon, 01 Feb 2010 23:11:59 +1100
From: Simon Horman <horms@verge.net.au>
Subject: [patch 03/27] sh: make zImage_head32() static
References: <20100201121156.252909695@vergenet.net>
Content-Disposition: inline; filename=sh-zImage_head32-static.patch
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

Index: kexec-tools/kexec/arch/sh/kexec-zImage-sh.c
===================================================================
--- kexec-tools.orig/kexec/arch/sh/kexec-zImage-sh.c	2010-02-01 23:06:41.000000000 +1100
+++ kexec-tools/kexec/arch/sh/kexec-zImage-sh.c	2010-02-01 23:07:17.000000000 +1100
@@ -34,7 +34,7 @@ static const int probe_debug = 0;
 #define HEAD32_INIT_SR 3
 #define HEAD32_INIT_SR_VALUE 0x400000F0
 
-unsigned long zImage_head32(const char *buf, off_t len, int offs)
+static unsigned long zImage_head32(const char *buf, off_t len, int offs)
 {
 	unsigned long *values = (void *)buf;
 	int k;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
