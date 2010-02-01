Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NbvAU-0005A1-JS
	for kexec@lists.infradead.org; Mon, 01 Feb 2010 12:14:22 +0000
Received: from yukiko.kent.sydney.vergenet.net
	(203-206-13-190.dyn.iinet.net.au [203.206.13.190])
	by kirsty.vergenet.net (Postfix) with ESMTP id 15CC32465B
	for <kexec@lists.infradead.org>; Mon,  1 Feb 2010 23:14:02 +1100 (EST)
Message-Id: <20100201121323.563487017@vergenet.net>
Date: Mon, 01 Feb 2010 23:12:13 +1100
From: Simon Horman <horms@verge.net.au>
Subject: [patch 17/27] x86_64: initialise temp_region in exclude_region() and
	delete_memmap()
References: <20100201121156.252909695@vergenet.net>
Content-Disposition: inline; filename=uninitialised.patch
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

Index: kexec-tools/kexec/arch/x86_64/crashdump-x86_64.c
===================================================================
--- kexec-tools.orig/kexec/arch/x86_64/crashdump-x86_64.c	2010-02-01 23:07:20.000000000 +1100
+++ kexec-tools/kexec/arch/x86_64/crashdump-x86_64.c	2010-02-01 23:07:21.000000000 +1100
@@ -286,7 +286,7 @@ static int get_crash_memory_ranges(struc
 static int exclude_region(int *nr_ranges, uint64_t start, uint64_t end)
 {
 	int i, j, tidx = -1;
-	struct memory_range temp_region;
+	struct memory_range temp_region = { 0, 0, 0 };
 
 	for (i = 0; i < (*nr_ranges); i++) {
 		unsigned long long mstart, mend;
@@ -385,7 +385,7 @@ static int delete_memmap(struct memory_r
 {
 	int i, j, nr_entries = 0, tidx = -1, operation = 0, align = 1024;
 	unsigned long long mstart, mend;
-	struct memory_range temp_region;
+	struct memory_range temp_region = { 0, 0, 0 };
 
 	/* Do alignment check. */
 	if ((addr%align) || (size%align))


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
