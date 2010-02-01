Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NbvAX-00056T-3v
	for kexec@lists.infradead.org; Mon, 01 Feb 2010 12:14:26 +0000
Received: from yukiko.kent.sydney.vergenet.net
	(203-206-13-190.dyn.iinet.net.au [203.206.13.190])
	by kirsty.vergenet.net (Postfix) with ESMTP id 3CDA924660
	for <kexec@lists.infradead.org>; Mon,  1 Feb 2010 23:14:02 +1100 (EST)
Message-Id: <20100201121324.311378133@vergenet.net>
Date: Mon, 01 Feb 2010 23:12:17 +1100
From: Simon Horman <horms@verge.net.au>
Subject: [patch 21/27] ia64: move_loaded_segments: handle no matching region
References: <20100201121156.252909695@vergenet.net>
Content-Disposition: inline; filename=ia64-move_loaded_segments-not-found.patch
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

Apparently this never happens, but the current code seems excessively loose.

1) die if it does happen
2) initialise offset to make gcc happy.

# ia64-unknown-linux-gnu-gcc --version
ia64-unknown-linux-gnu-gcc (GCC) 3.4.5
Copyright (C) 2004 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

# make
kexec/arch/ia64/kexec-elf-ia64.c: In function `move_loaded_segments':
kexec/arch/ia64/kexec-elf-ia64.c:102: warning: 'offset' might be used
uninitialized in this function

Signed-off-by: Simon Horman <horms@verge.net.au>

Index: kexec-tools/kexec/arch/ia64/kexec-elf-ia64.c
===================================================================
--- kexec-tools.orig/kexec/arch/ia64/kexec-elf-ia64.c	2010-02-01 23:07:19.000000000 +1100
+++ kexec-tools/kexec/arch/ia64/kexec-elf-ia64.c	2010-02-01 23:07:22.000000000 +1100
@@ -99,15 +99,19 @@ void elf_ia64_usage(void)
 void move_loaded_segments(struct mem_ehdr *ehdr, unsigned long addr)
 {
 	unsigned i;
-	long offset;
+	long offset = 0;
+	int found = 0;
 	struct mem_phdr *phdr;
 	for(i = 0; i < ehdr->e_phnum; i++) {
 		phdr = &ehdr->e_phdr[i];
 		if (phdr->p_type == PT_LOAD) {
 			offset = addr - phdr->p_paddr;
+			found++;
 			break;
 		}
 	}
+	if (!found)
+		die("move_loaded_segments: no PT_LOAD region 0x%016x\n", addr);
 	ehdr->e_entry += offset;
 	for(i = 0; i < ehdr->e_phnum; i++) {
 		phdr = &ehdr->e_phdr[i];


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
