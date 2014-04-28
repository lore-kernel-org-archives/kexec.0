Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WeimL-0001mA-Uu
 for kexec@lists.infradead.org; Mon, 28 Apr 2014 10:27:18 +0000
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <ldufour@linux.vnet.ibm.com>;
 Mon, 28 Apr 2014 11:26:55 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1F0B517D804E
 for <kexec@lists.infradead.org>; Mon, 28 Apr 2014 11:27:54 +0100 (BST)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
 [9.149.37.247])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3SAQqCk393726
 for <kexec@lists.infradead.org>; Mon, 28 Apr 2014 10:26:52 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3SAQpBh018946
 for <kexec@lists.infradead.org>; Mon, 28 Apr 2014 04:26:52 -0600
Subject: [PATCH] ppc64/purgatory: Device tree values should be read/stored
 in Big Endian
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Mon, 28 Apr 2014 12:26:50 +0200
Message-ID: <20140428102650.5128.70350.stgit@nimbus>
MIME-Version: 1.0
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

The purgatory code reads the device tree's version and stores if needed the
currently running CPU number. These 2 values are stored in Big Endian
format in the device tree and should be byte swapped when running in Little
Endian mode.

Without this fix, when running in SMP environment, kexec or kdump kernel may
fail booting with the following message :
Failed to identify boot CPU

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 purgatory/arch/ppc64/v2wrap.S |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/purgatory/arch/ppc64/v2wrap.S b/purgatory/arch/ppc64/v2wrap.S
index 6fc62e3..dc5034f 100644
--- a/purgatory/arch/ppc64/v2wrap.S
+++ b/purgatory/arch/ppc64/v2wrap.S
@@ -90,10 +90,20 @@ master:
 	LOADADDR(16, dt_offset)
 	ld      3,0(16)         # load device-tree address
 	mr      16,3            # save dt address in reg16
+#ifdef __BIG_ENDIAN__
 	lwz     6,20(3)         # fetch version number
+#else
+	li	4,20
+	lwbrx	6,3,4		# fetch BE version number
+#endif
 	cmpwi   0,6,2           # v2 ?
 	blt     80f
+#ifdef __BIG_ENDIAN__
 	stw     17,28(3)        # save my cpu number as boot_cpu_phys
+#else
+	li	4,28
+	stwbrx	17,3,4		# Store my cpu as BE value
+#endif
 80:
 	LOADADDR(6,opal_base)	# For OPAL early debug
 	ld      8,0(6)          # load the OPAL base address in r8


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
