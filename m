Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KkemC-0005fN-Gs
	for kexec@lists.infradead.org; Tue, 30 Sep 2008 12:56:28 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m8UCmBai031349
	for <kexec@lists.infradead.org>; Tue, 30 Sep 2008 08:48:11 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m8UCuP0o174634
	for <kexec@lists.infradead.org>; Tue, 30 Sep 2008 06:56:25 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m8UCtsqB010378
	for <kexec@lists.infradead.org>; Tue, 30 Sep 2008 06:55:56 -0600
Date: Tue, 30 Sep 2008 18:26:21 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
Subject: [PATCH] Relocatable kdump kernel support in kexec-tools
Message-ID: <20080930125621.GC1945@in.ibm.com>
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
To: kexec@lists.infradead.org
Cc: ppcdev <linuxppc-dev@ozlabs.org>, paulus@samba.org, Maneesh Soni <maneesh@in.ibm.com>

Relocatable kdump kernel support in kexec-tools

This patch adds relocatable kernel support for kdump in the kexec-tools
code. A signature (0xfeed1234) is passed in r6 from panic code to the
purgatory code through kexec_sequence function. The signature is used to
differentiate between relocatable kdump kernel and non-kdump kernels.

The purgatory code compares the signature and sets the __kdump_flag in
head_64.S by using the offset with respect to next kernel load address.
During the boot up, kernel code checks __kdump_flag and if it is set, the
kernel will behave as relocatable kdump kernel.

Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>
---
diff --git a/purgatory/arch/ppc64/v2wrap.S b/purgatory/arch/ppc64/v2wrap.S
index b3563de..f69dad2 100644
--- a/purgatory/arch/ppc64/v2wrap.S
+++ b/purgatory/arch/ppc64/v2wrap.S
@@ -45,6 +45,7 @@
 	oris    rn,rn,name##@h;         \
 	ori     rn,rn,name##@l
 
+#define KDUMP_SIGNATURE 0xfeed1234
 
 	.machine ppc64
 	.globl purgatory_start
@@ -64,6 +65,7 @@ master:
 	isync
 	mr      17,3            # save cpu id to r17
 	mr      15,4            # save physical address in reg15
+	mr      18,6            # save kdump flag in reg18
 
 	LOADADDR(6,my_toc)
 	ld      2,0(6)          #setup toc
@@ -94,6 +96,12 @@ master:
 	mtctr	4		# prepare branch too
 	mr      3,16            # restore dt address
 
+	LOADADDR(6,KDUMP_SIGNATURE)
+	cmpd	18,6
+	bne	regular
+	li	7,1
+	std	7,24(4)		# mark kdump flag at kernel
+regular:
 	lwz	7,0(4)		# get the first instruction that we stole
 	stw	7,0(0)		# and put it in the slave loop at 0
 				# skip cache flush, do we care?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
