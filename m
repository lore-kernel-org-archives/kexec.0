Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Kl6Nt-0003uv-TY
	for kexec@lists.infradead.org; Wed, 01 Oct 2008 18:25:14 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m91IP4vP025150
	for <kexec@lists.infradead.org>; Wed, 1 Oct 2008 14:25:04 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m91IP48T258172
	for <kexec@lists.infradead.org>; Wed, 1 Oct 2008 14:25:04 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m91IP4oh002896
	for <kexec@lists.infradead.org>; Wed, 1 Oct 2008 14:25:04 -0400
Date: Wed, 1 Oct 2008 23:55:01 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
Subject: [PATCH] Fix kdump kernel hang issue with relocatable kernel patches
Message-ID: <20081001182501.GA20319@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Reply-To: mohan@in.ibm.com
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: paulus@samba.org
Cc: ppcdev <linuxppc-dev@ozlabs.org>, kexec@lists.infradead.org

One of the relocatable kernel support patches assumes that the target
address will be 0. But for kdump kernels (without relocation support) it
will be 32MB. The following patch fixes this issue.

Fix kdump kernel issue

Kdump kernel without relocation support needs to be moved to
PHYSICAL_START (ie 32MB) instead of 0. This patch fixes this
issue.

Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>
---
 arch/powerpc/kernel/head_64.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 84856be..8934500 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -1395,7 +1395,7 @@ _STATIC(__after_prom_start)
  *
  * Note: This process overwrites the OF exception vectors.
  */
-	li	r3,0			/* target addr */
+	LOAD_REG_IMMEDIATE(r3, PHYSICAL_START) /* target addr */
 	mr.	r4,r26			/* In some cases the loader may  */
 	beq	9f			/* have already put us at zero */
 	lis	r5,(copy_to_here - _stext)@ha
-- 
1.5.5.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
