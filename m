Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NbvAU-00056X-6p
	for kexec@lists.infradead.org; Mon, 01 Feb 2010 12:14:22 +0000
Received: from yukiko.kent.sydney.vergenet.net
	(203-206-13-190.dyn.iinet.net.au [203.206.13.190])
	by kirsty.vergenet.net (Postfix) with ESMTP id 283E12465D
	for <kexec@lists.infradead.org>; Mon,  1 Feb 2010 23:14:02 +1100 (EST)
Message-Id: <20100201121324.127080610@vergenet.net>
Date: Mon, 01 Feb 2010 23:12:16 +1100
From: Simon Horman <horms@verge.net.au>
Subject: [patch 20/27] Cast 64bit pointer to a 64bit int then a 32bit int
References: <20100201121156.252909695@vergenet.net>
Content-Disposition: inline; filename=ppc64-uint32-ptr.patch
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

The two-stage cast is because we really do want a 32bit integer value
from a 64bit pointer, and gcc assumes that we're making a mistake
if there is just one cast.

# powerpc64-unknown-linux-gnu-gcc --version
powerpc64-unknown-linux-gnu-gcc (GCC) 4.1.1
Copyright (C) 2006 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

# make
kexec/arch/ppc64/kexec-elf-rel-ppc64.c: In function 'machine_apply_elf_rel':
kexec/arch/ppc64/kexec-elf-rel-ppc64.c:66: warning: cast from pointer to integer of different size

Signed-off-by: Simon Horman <horms@verge.net.au>

Index: kexec-tools/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
===================================================================
--- kexec-tools.orig/kexec/arch/ppc64/kexec-elf-rel-ppc64.c	2010-02-01 23:06:38.000000000 +1100
+++ kexec-tools/kexec/arch/ppc64/kexec-elf-rel-ppc64.c	2010-02-01 23:07:21.000000000 +1100
@@ -63,7 +63,7 @@ void machine_apply_elf_rel(struct mem_eh
 		break;
 
 	case R_PPC64_REL32:
-		*(uint32_t *)location = value - (uint32_t)location;
+		*(uint32_t *)location = value - (uint32_t)(uint64_t)location;
 		break;
 
 	case R_PPC64_TOC:


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
