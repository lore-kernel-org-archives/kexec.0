Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZScQx-0008DJ-I9
 for kexec@lists.infradead.org; Fri, 21 Aug 2015 02:52:00 +0000
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <sam.mj@au1.ibm.com>;
 Fri, 21 Aug 2015 12:51:33 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 8019C2CE8055
 for <kexec@lists.infradead.org>; Fri, 21 Aug 2015 12:51:30 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7L2pMs246399686
 for <kexec@lists.infradead.org>; Fri, 21 Aug 2015 12:51:31 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7L2ovRt000654
 for <kexec@lists.infradead.org>; Fri, 21 Aug 2015 12:50:57 +1000
From: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
Subject: [PATCH] purgatory/arch/ppc64: Reset primary cpu endian to big-endian
Date: Fri, 21 Aug 2015 12:51:16 +1000
Message-Id: <1440125476-9420-1-git-send-email-sam.mj@au1.ibm.com>
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
To: kexec@lists.infradead.org
Cc: mpe@ellerman.id.au, horms@verge.net.au, Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>

Older big-endian ppc64 kernels don't include the FIXUP_ENDIAN check,
meaning if we kexec from a little-endian kernel the target kernel will
fail to boot.
Returning to big-endian before we enter the target kernel ensures that
the target kernel can boot whether or not it includes FIXUP_ENDIAN.

This mirrors commit 150b14e7 in kexec-lite.

Signed-off-by: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
---
 purgatory/arch/ppc64/v2wrap.S | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/purgatory/arch/ppc64/v2wrap.S b/purgatory/arch/ppc64/v2wrap.S
index dc5034f..179ade9 100644
--- a/purgatory/arch/ppc64/v2wrap.S
+++ b/purgatory/arch/ppc64/v2wrap.S
@@ -114,10 +114,16 @@ master:
 	LOADADDR(6,run_at_load) # the load flag
 	lwz	7,0(6)		# possibly patched by kexec-elf-ppc64
 	stw	7,0x5c(4)	# and patch it into the kernel
-	li	5,0		# r5 will be 0 for kernel
-	mtctr	4		# prepare branch too
 	mr      3,16            # restore dt address
 
+	mtsrr0	4		# prepare branch to
+
+	mfmsr	5
+	clrrdi	5,5,1		# clear MSR_LE
+	mtsrr1	5
+
+	li	5,0		# r5 will be 0 for kernel
+
 				# skip cache flush, do we care?
 
-	bctr			# start kernel
+	rfid			# update MSR and start kernel
-- 
2.5.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
