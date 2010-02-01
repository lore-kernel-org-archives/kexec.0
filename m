Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NbvAO-00056X-Th
	for kexec@lists.infradead.org; Mon, 01 Feb 2010 12:14:13 +0000
Received: from yukiko.kent.sydney.vergenet.net
	(203-206-13-190.dyn.iinet.net.au [203.206.13.190])
	by kirsty.vergenet.net (Postfix) with ESMTP id 9750024651
	for <kexec@lists.infradead.org>; Mon,  1 Feb 2010 23:14:01 +1100 (EST)
Message-Id: <20100201121321.693591328@vergenet.net>
Date: Mon, 01 Feb 2010 23:12:03 +1100
From: Simon Horman <horms@verge.net.au>
Subject: [patch 07/27] ia64: Remove unused info parameter from
	add_loaded_segments_info()
References: <20100201121156.252909695@vergenet.net>
Content-Disposition: inline;
	filename=ia64-add_loaded_segments_info-remove-unused-parameter.
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
--- kexec-tools.orig/kexec/arch/ia64/crashdump-ia64.c	2010-02-01 23:06:40.000000000 +1100
+++ kexec-tools/kexec/arch/ia64/crashdump-ia64.c	2010-02-01 23:07:18.000000000 +1100
@@ -71,8 +71,7 @@ static int seg_comp(const void *a, const
 
 /* purgatory code need this info to patch the EFI memmap
  */
-static void add_loaded_segments_info(struct kexec_info *info,
-	struct mem_ehdr *ehdr, unsigned long max_addr)
+static void add_loaded_segments_info(struct mem_ehdr *ehdr)
 {
 	 int i;
          for(i = 0; i < ehdr->e_phnum; i++) {
@@ -265,7 +264,7 @@ int load_crashdump_segments(struct kexec
 		loaded_segments_num++;
 		cmdline_add_elfcorehdr(cmdline, elfcorehdr);
 	}
-	add_loaded_segments_info(info, ehdr, max_addr);
+	add_loaded_segments_info(ehdr);
 	size = sizeof(struct loaded_segment) * loaded_segments_num;
 	qsort(loaded_segments, loaded_segments_num,
                         sizeof(struct loaded_segment), seg_comp);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
