Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NbvAX-0005C9-Ks
	for kexec@lists.infradead.org; Mon, 01 Feb 2010 12:14:26 +0000
Received: from yukiko.kent.sydney.vergenet.net
	(203-206-13-190.dyn.iinet.net.au [203.206.13.190])
	by kirsty.vergenet.net (Postfix) with ESMTP id 341132465F
	for <kexec@lists.infradead.org>; Mon,  1 Feb 2010 23:14:02 +1100 (EST)
Message-Id: <20100201121324.498525328@vergenet.net>
Date: Mon, 01 Feb 2010 23:12:18 +1100
From: Simon Horman <horms@verge.net.au>
Subject: [patch 22/27] Dont discard the const qualifier of proc_iomem()
References: <20100201121156.252909695@vergenet.net>
Content-Disposition: inline; filename=s390-const-proc-iomem.patch
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

Index: kexec-tools/kexec/arch/s390/kexec-s390.c
===================================================================
--- kexec-tools.orig/kexec/arch/s390/kexec-s390.c	2010-02-01 23:07:20.000000000 +1100
+++ kexec-tools/kexec/arch/s390/kexec-s390.c	2010-02-01 23:07:22.000000000 +1100
@@ -40,7 +40,7 @@ int get_memory_ranges(struct memory_rang
 		      unsigned long UNUSED(flags))
 {
 	char sys_ram[] = "System RAM\n";
-	char *iomem = proc_iomem();
+	const char *iomem = proc_iomem();
 	FILE *fp;
 	char line[80];
 	int current_range = 0;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
