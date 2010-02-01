Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NbvAO-00056Y-Tq
	for kexec@lists.infradead.org; Mon, 01 Feb 2010 12:14:13 +0000
Received: from yukiko.kent.sydney.vergenet.net
	(203-206-13-190.dyn.iinet.net.au [203.206.13.190])
	by kirsty.vergenet.net (Postfix) with ESMTP id 9F70624652
	for <kexec@lists.infradead.org>; Mon,  1 Feb 2010 23:14:01 +1100 (EST)
Message-Id: <20100201121321.875517669@vergenet.net>
Date: Mon, 01 Feb 2010 23:12:04 +1100
From: Simon Horman <horms@verge.net.au>
Subject: [patch 08/27] ia64: Remove unused range parameter from
	get_crash_memory_ranges()
References: <20100201121156.252909695@vergenet.net>
Content-Disposition: inline;
	filename=ia64-get_crash_memory_ranges-removed-unused.parameter.patch
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

Index: kexec-tools/kexec/arch/ia64/crashdump-ia64.c
===================================================================
--- kexec-tools.orig/kexec/arch/ia64/crashdump-ia64.c	2010-02-01 23:07:18.000000000 +1100
+++ kexec-tools/kexec/arch/ia64/crashdump-ia64.c	2010-02-01 23:07:18.000000000 +1100
@@ -152,7 +152,7 @@ static int exclude_crash_reserve_region(
 	return 0;
 }
 
-static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
+static int get_crash_memory_ranges(int *ranges)
 {
 	const char *iomem = proc_iomem();
         char line[MAX_LINE];
@@ -236,7 +236,7 @@ int load_crashdump_segments(struct kexec
 	size_t size;
 	void *tmp;
 	if (info->kexec_flags & KEXEC_ON_CRASH &&
-	    get_crash_memory_ranges(&mem_range, &nr_ranges) == 0) {
+	    get_crash_memory_ranges(&nr_ranges) == 0) {
 		int i;
 
 		info->kern_paddr_start = kernel_code_start;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
