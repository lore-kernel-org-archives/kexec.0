Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NbvAa-0005Dj-Fk
	for kexec@lists.infradead.org; Mon, 01 Feb 2010 12:14:30 +0000
Received: from yukiko.kent.sydney.vergenet.net
	(203-206-13-190.dyn.iinet.net.au [203.206.13.190])
	by kirsty.vergenet.net (Postfix) with ESMTP id 49EC724664
	for <kexec@lists.infradead.org>; Mon,  1 Feb 2010 23:14:02 +1100 (EST)
Message-Id: <20100201121325.513662711@vergenet.net>
Date: Mon, 01 Feb 2010 23:12:23 +1100
From: Simon Horman <horms@verge.net.au>
Subject: [patch 27/27] cris: cast trampoline_base
References: <20100201121156.252909695@vergenet.net>
Content-Disposition: inline; filename=cris-trampoline_base.patch
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

# crisv32-axis-linux-gnu-gcc --version
crisv32-axis-linux-gnu-gcc (GCC) 3.2.1 Axis release R64/1.64
Copyright (C) 2002 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

# make
kexec/arch/cris/kexec-elf-cris.c: In function `elf_cris_load':
kexec/arch/cris/kexec-elf-cris.c:134: warning: assignment makes pointer from integer without a cast

Signed-off-by: Simon Horman <horms@verge.net.au>

Index: kexec-tools/kexec/arch/cris/kexec-elf-cris.c
===================================================================
--- kexec-tools.orig/kexec/arch/cris/kexec-elf-cris.c	2010-02-01 23:06:38.000000000 +1100
+++ kexec-tools/kexec/arch/cris/kexec-elf-cris.c	2010-02-01 23:07:23.000000000 +1100
@@ -131,6 +131,6 @@ int elf_cris_load(int argc, char **argv,
 					  4, 0, elf_max_addr(&ehdr), 1);
 	memcpy(trampoline_buf,
 	       cris_trampoline, cris_trampoline_size);
-	info->entry = trampoline_base;
+	info->entry = (void *)trampoline_base;
 	return 0;
 }


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
