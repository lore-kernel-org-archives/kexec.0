Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HgxoR-0001Yy-8d
	for kexec@lists.infradead.org; Thu, 26 Apr 2007 02:50:44 -0400
From: Michael Neuling <mikey@neuling.org>
MIME-Version: 1.0
Subject: [PATCH] fix valid_memory_range region merging
Date: Thu, 26 Apr 2007 16:50:34 +1000
Message-ID: <1165.1177570234@neuling.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, horms@verge.net.au

Check the next region we are including is type RANGE_RAM as well.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
I've not actually seen this cause a problem, but it looks wrong.  We
should probably merge regions properly and solve this problem for real. 

 kexec/kexec.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: kexec-tools-testing/kexec/kexec.c
===================================================================
--- kexec-tools-testing.orig/kexec/kexec.c
+++ kexec-tools-testing/kexec/kexec.c
@@ -96,7 +96,8 @@ int valid_memory_range(struct kexec_info
 		mstart = info->memory_range[i].start;
 		mend = info->memory_range[i].end;
 		if (i < info->memory_ranges - 1
-		    && mend == info->memory_range[i+1].start)
+		    && mend == info->memory_range[i+1].start
+		    && info->memory_range[i+1].type == RANGE_RAM)
 			mend = info->memory_range[i+1].end;
 
 		/* Check to see if we are fully contained */

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
