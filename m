Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NbvAZ-00058E-SH
	for kexec@lists.infradead.org; Mon, 01 Feb 2010 12:14:29 +0000
Received: from yukiko.kent.sydney.vergenet.net
	(203-206-13-190.dyn.iinet.net.au [203.206.13.190])
	by kirsty.vergenet.net (Postfix) with ESMTP id 4879124661
	for <kexec@lists.infradead.org>; Mon,  1 Feb 2010 23:14:02 +1100 (EST)
Message-Id: <20100201121324.879532803@vergenet.net>
Date: Mon, 01 Feb 2010 23:12:20 +1100
From: Simon Horman <horms@verge.net.au>
Subject: [patch 24/27] sh: netbsd_booter extern qualifier should come first
References: <20100201121156.252909695@vergenet.net>
Content-Disposition: inline; filename=sh-netbsd_booter-extern-first.patch
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

# sh4-unknown-linux-gnu-gcc --version
sh4-unknown-linux-gnu-gcc (GCC) 4.1.1
Copyright (C) 2006 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

# make
kexec/arch/sh/kexec-netbsd-sh.c:29: warning: 'extern' is not at beginning of declaration

Signed-off-by: Simon Horman <horms@verge.net.au>

Index: kexec-tools/kexec/arch/sh/kexec-netbsd-sh.c
===================================================================
--- kexec-tools.orig/kexec/arch/sh/kexec-netbsd-sh.c	2010-02-01 23:07:16.000000000 +1100
+++ kexec-tools/kexec/arch/sh/kexec-netbsd-sh.c	2010-02-01 23:07:22.000000000 +1100
@@ -26,7 +26,7 @@
 #include <arch/options.h>
 
 static const int probe_debug = 0;
-const extern unsigned char netbsd_booter[];
+extern const unsigned char netbsd_booter[];
 
 /*
  * netbsd_sh_probe - sanity check the elf image


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
