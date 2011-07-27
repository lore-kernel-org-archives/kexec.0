Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from ozlabs.org ([2402:b800:7003:1:1::1])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QlvX6-00072P-46
	for kexec@lists.infradead.org; Wed, 27 Jul 2011 04:15:45 +0000
Date: Wed, 27 Jul 2011 14:15:03 +1000
From: Anton Blanchard <anton@samba.org>
Subject: [PATCH] powerpc: pseries: Fix kexec on machines with more than 4TB
	of RAM
Message-ID: <20110727141503.3faa93f5@kryten>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: benh@kernel.crashing.org, paulus@samba.org, mikey@neuling.org, miltonm@bga.com
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org


On a box with 8TB of RAM the MMU hashtable is 64GB in size. That
means we have 4G PTEs. pSeries_lpar_hptab_clear was using a signed
int to store the index which will overflow at 2G.

Signed-off-by: Anton Blanchard <anton@samba.org>
Cc: <stable@kernel.org>
---

Index: linux-powerpc/arch/powerpc/platforms/pseries/lpar.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/platforms/pseries/lpar.c	2011-07-27 13:50:18.408091576 +1000
+++ linux-powerpc/arch/powerpc/platforms/pseries/lpar.c	2011-07-27 13:51:19.359196131 +1000
@@ -203,7 +203,7 @@ static void pSeries_lpar_hptab_clear(voi
 		unsigned long ptel;
 	} ptes[4];
 	long lpar_rc;
-	int i, j;
+	unsigned long i, j;
 
 	/* Read in batches of 4,
 	 * invalidate only valid entries not in the VRMA

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
