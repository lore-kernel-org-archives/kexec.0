Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jy3vp-0000hn-Hy
 for kexec@lists.infradead.org; Wed, 22 Jul 2020 01:52:30 +0000
Received: by mail-pj1-x1041.google.com with SMTP id cv18so2164466pjb.1
 for <kexec@lists.infradead.org>; Tue, 21 Jul 2020 18:52:27 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
Subject: [PATCHv3 1/2] powerpc/pseries: group lmb operation and memblock's
Date: Wed, 22 Jul 2020 09:52:09 +0800
Message-Id: <1595382730-10565-1-git-send-email-kernelfans@gmail.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linuxppc-dev@lists.ozlabs.org
Cc: Nathan Lynch <nathanl@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org, Hari Bathini <hbathini@linux.ibm.com>, Pingfan Liu <kernelfans@gmail.com>

This patch prepares for the incoming patch which swaps the order of KOBJ_
uevent and dt's updating.

It has no functional effect, just groups lmb operation and memblock's in
order to insert dt updating operation easily, and makes it easier to
review.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Nathan Lynch <nathanl@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kexec@lists.infradead.org
---
v2 -> v3: rebase onto ppc next-test branch
---
 arch/powerpc/platforms/pseries/hotplug-memory.c | 26 ++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 5d545b7..1a3ac3b 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -355,7 +355,8 @@ static int dlpar_add_lmb(struct drmem_lmb *);
 static int dlpar_remove_lmb(struct drmem_lmb *lmb)
 {
 	unsigned long block_sz;
-	int rc;
+	phys_addr_t base_addr;
+	int rc, nid;
 
 	if (!lmb_is_removable(lmb))
 		return -EINVAL;
@@ -364,17 +365,19 @@ static int dlpar_remove_lmb(struct drmem_lmb *lmb)
 	if (rc)
 		return rc;
 
+	base_addr = lmb->base_addr;
+	nid = lmb->nid;
 	block_sz = pseries_memory_block_size();
 
-	__remove_memory(lmb->nid, lmb->base_addr, block_sz);
-
-	/* Update memory regions for memory remove */
-	memblock_remove(lmb->base_addr, block_sz);
-
 	invalidate_lmb_associativity_index(lmb);
 	lmb_clear_nid(lmb);
 	lmb->flags &= ~DRCONF_MEM_ASSIGNED;
 
+	__remove_memory(nid, base_addr, block_sz);
+
+	/* Update memory regions for memory remove */
+	memblock_remove(base_addr, block_sz);
+
 	return 0;
 }
 
@@ -603,6 +606,8 @@ static int dlpar_add_lmb(struct drmem_lmb *lmb)
 	}
 
 	lmb_set_nid(lmb);
+	lmb->flags |= DRCONF_MEM_ASSIGNED;
+
 	block_sz = memory_block_size_bytes();
 
 	/* Add the memory */
@@ -614,11 +619,14 @@ static int dlpar_add_lmb(struct drmem_lmb *lmb)
 
 	rc = dlpar_online_lmb(lmb);
 	if (rc) {
-		__remove_memory(lmb->nid, lmb->base_addr, block_sz);
+		int nid = lmb->nid;
+		phys_addr_t base_addr = lmb->base_addr;
+
 		invalidate_lmb_associativity_index(lmb);
 		lmb_clear_nid(lmb);
-	} else {
-		lmb->flags |= DRCONF_MEM_ASSIGNED;
+		lmb->flags &= ~DRCONF_MEM_ASSIGNED;
+
+		__remove_memory(nid, base_addr, block_sz);
 	}
 
 	return rc;
-- 
2.7.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
