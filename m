Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NbvAZ-00058D-U8
	for kexec@lists.infradead.org; Mon, 01 Feb 2010 12:14:30 +0000
Received: from yukiko.kent.sydney.vergenet.net
	(203-206-13-190.dyn.iinet.net.au [203.206.13.190])
	by kirsty.vergenet.net (Postfix) with ESMTP id 496FE24663
	for <kexec@lists.infradead.org>; Mon,  1 Feb 2010 23:14:02 +1100 (EST)
Message-Id: <20100201121325.315548253@vergenet.net>
Date: Mon, 01 Feb 2010 23:12:22 +1100
From: Simon Horman <horms@verge.net.au>
Subject: [patch 26/27] arm: Initialise initrd_start in zImage_arm_load()
References: <20100201121156.252909695@vergenet.net>
Content-Disposition: inline;
	filename=arm-atag_arm_load-initialise-initrd-start.patch
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

Although the following compiler warning is bogus
it seems harmless to initialise initrd_start to NULL.

# arm-unknown-linux-gnu-gcc --version
arm-unknown-linux-gnu-gcc (GCC) 4.1.1
Copyright (C) 2006 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

# make
kexec/arch/arm/kexec-zImage-arm.c: In function 'zImage_arm_load':
kexec/arch/arm/kexec-zImage-arm.c:135: warning: 'initrd_start' may be used
uninitialized in this function

Signed-off-by: Simon Horman <horms@verge.net.au>

Index: kexec-tools/kexec/arch/arm/kexec-zImage-arm.c
===================================================================
--- kexec-tools.orig/kexec/arch/arm/kexec-zImage-arm.c	2010-02-01 23:07:23.000000000 +1100
+++ kexec-tools/kexec/arch/arm/kexec-zImage-arm.c	2010-02-01 23:07:23.000000000 +1100
@@ -132,7 +132,7 @@ int atag_arm_load(struct kexec_info *inf
 	char *buf;
 	off_t len;
 	struct tag *params;
-	uint32_t *initrd_start;
+	uint32_t *initrd_start = NULL;
 	
 	buf = xmalloc(getpagesize());
 	if (!buf) {


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
