Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NbvAS-00058G-V8
	for kexec@lists.infradead.org; Mon, 01 Feb 2010 12:14:19 +0000
Received: from yukiko.kent.sydney.vergenet.net
	(203-206-13-190.dyn.iinet.net.au [203.206.13.190])
	by kirsty.vergenet.net (Postfix) with ESMTP id E66CA24658
	for <kexec@lists.infradead.org>; Mon,  1 Feb 2010 23:14:01 +1100 (EST)
Message-Id: <20100201121322.999011754@vergenet.net>
Date: Mon, 01 Feb 2010 23:12:10 +1100
From: Simon Horman <horms@verge.net.au>
Subject: [patch 14/27] unsigned values are always at least 0
References: <20100201121156.252909695@vergenet.net>
Content-Disposition: inline; filename=unsigned-always-at-least-zero.patch
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

Index: kexec-tools/kexec/arch/i386/crashdump-x86.c
===================================================================
--- kexec-tools.orig/kexec/arch/i386/crashdump-x86.c	2010-02-01 23:07:19.000000000 +1100
+++ kexec-tools/kexec/arch/i386/crashdump-x86.c	2010-02-01 23:07:20.000000000 +1100
@@ -111,7 +111,7 @@ static int get_crash_memory_ranges(struc
 		}
 
 		/* First 640K already registered */
-		if (start >= 0x00000000ULL && end <= 0x0009ffffULL)
+		if (end <= 0x0009ffff)
 			continue;
 
 		crash_memory_range[memory_ranges].start = start;
Index: kexec-tools/kexec/arch/x86_64/crashdump-x86_64.c
===================================================================
--- kexec-tools.orig/kexec/arch/x86_64/crashdump-x86_64.c	2010-02-01 23:07:19.000000000 +1100
+++ kexec-tools/kexec/arch/x86_64/crashdump-x86_64.c	2010-02-01 23:07:20.000000000 +1100
@@ -233,7 +233,7 @@ static int get_crash_memory_ranges(struc
 		}
 
 		/* First 640K already registered */
-		if (start >= 0x00000000 && end <= 0x0009ffff)
+		if (end <= 0x0009ffff)
 			continue;
 
 		crash_memory_range[memory_ranges].start = start;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
