Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate3.uk.ibm.com ([194.196.100.163])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Qm3gk-0006TV-OS
	for kexec@lists.infradead.org; Wed, 27 Jul 2011 12:58:20 +0000
Received: from d06nrmr1307.portsmouth.uk.ibm.com
	(d06nrmr1307.portsmouth.uk.ibm.com [9.149.38.129])
	by mtagate3.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p6RCwAXP025174
	for <kexec@lists.infradead.org>; Wed, 27 Jul 2011 12:58:10 GMT
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
	[9.149.37.252])
	by d06nrmr1307.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p6RCw9Ni2285658
	for <kexec@lists.infradead.org>; Wed, 27 Jul 2011 13:58:09 +0100
Received: from d06av11.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av11.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p6RCw8ex000527
	for <kexec@lists.infradead.org>; Wed, 27 Jul 2011 06:58:09 -0600
Message-Id: <20110727125808.367205861@linux.vnet.ibm.com>
Date: Wed, 27 Jul 2011 14:55:10 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [patch v2 06/10] s390: Export store_status() function
References: <20110727125504.491183728@linux.vnet.ibm.com>
Content-Disposition: inline; filename=s390-kdump-arch-store-status.patch
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: vgoyal@redhat.com
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, horms@verge.net.au, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org

From: Michael Holzheu <holzheu@linux.vnet.ibm.com>

For kdump we need a store status function to save the registers for the
current CPU. Therefore this patch exports a function "store_status()".
In addition to that now also floating point registers are saved correctly.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 arch/s390/kernel/reipl64.S |   80 +++++++++++++++++++++++++++++++++------------
 1 file changed, 60 insertions(+), 20 deletions(-)

--- a/arch/s390/kernel/reipl64.S
+++ b/arch/s390/kernel/reipl64.S
@@ -1,5 +1,5 @@
 /*
- *    Copyright IBM Corp 2000,2009
+ *    Copyright IBM Corp 2000,2011
  *    Author(s): Holger Smolinski <Holger.Smolinski@de.ibm.com>,
  *		 Denis Joseph Barrow,
  */
@@ -8,6 +8,64 @@
 #include <asm/asm-offsets.h>
 
 #
+# store_status
+#
+# Prerequisites to run this function:
+# - Prefix register is set to zero
+# - Original prefix register is stored in "dump_prefix_page"
+# - Lowcore protection is off
+#
+ENTRY(store_status)
+	/* Save register one and load save area base */
+	stg	%r1,__LC_SAVE_AREA_64(%r0)
+	lghi	%r1,SAVE_AREA_BASE
+	/* General purpose registers */
+	stmg	%r0,%r15,__LC_GPREGS_SAVE_AREA-SAVE_AREA_BASE(%r1)
+	lg	%r2,__LC_SAVE_AREA_64(%r0)
+	stg	%r2,__LC_GPREGS_SAVE_AREA-SAVE_AREA_BASE+8(%r1)
+	/* Control registers */
+	stctg	%c0,%c15,__LC_CREGS_SAVE_AREA-SAVE_AREA_BASE(%r1)
+	/* Access registers */
+	stam	%a0,%a15,__LC_AREGS_SAVE_AREA-SAVE_AREA_BASE(%r1)
+	/* Floating point registers */
+	std	%f0, 0x00 + __LC_FPREGS_SAVE_AREA-SAVE_AREA_BASE(%r1)
+	std	%f1, 0x08 + __LC_FPREGS_SAVE_AREA-SAVE_AREA_BASE(%r1)
+	std	%f2, 0x10 + __LC_FPREGS_SAVE_AREA-SAVE_AREA_BASE(%r1)
+	std	%f3, 0x18 + __LC_FPREGS_SAVE_AREA-SAVE_AREA_BASE(%r1)
+	std	%f4, 0x20 + __LC_FPREGS_SAVE_AREA-SAVE_AREA_BASE(%r1)
+	std	%f5, 0x28 + __LC_FPREGS_SAVE_AREA-SAVE_AREA_BASE(%r1)
+	std	%f6, 0x30 + __LC_FPREGS_SAVE_AREA-SAVE_AREA_BASE(%r1)
+	std	%f7, 0x38 + __LC_FPREGS_SAVE_AREA-SAVE_AREA_BASE(%r1)
+	std	%f8, 0x40 + __LC_FPREGS_SAVE_AREA-SAVE_AREA_BASE(%r1)
+	std	%f9, 0x48 + __LC_FPREGS_SAVE_AREA-SAVE_AREA_BASE(%r1)
+	std	%f10,0x50 + __LC_FPREGS_SAVE_AREA-SAVE_AREA_BASE(%r1)
+	std	%f11,0x58 + __LC_FPREGS_SAVE_AREA-SAVE_AREA_BASE(%r1)
+	std	%f12,0x60 + __LC_FPREGS_SAVE_AREA-SAVE_AREA_BASE(%r1)
+	std	%f13,0x68 + __LC_FPREGS_SAVE_AREA-SAVE_AREA_BASE(%r1)
+	std	%f14,0x70 + __LC_FPREGS_SAVE_AREA-SAVE_AREA_BASE(%r1)
+	std	%f15,0x78 + __LC_FPREGS_SAVE_AREA-SAVE_AREA_BASE(%r1)
+	/* Floating point control register */
+	stfpc	__LC_FP_CREG_SAVE_AREA-SAVE_AREA_BASE(%r1)
+	/* CPU timer */
+	stpt	__LC_CPU_TIMER_SAVE_AREA-SAVE_AREA_BASE(%r1)
+	/* Saved prefix register */
+	larl	%r2,dump_prefix_page
+	mvc	__LC_PREFIX_SAVE_AREA-SAVE_AREA_BASE(4,%r1),0(%r2)
+	/* Clock comparator - seven bytes */
+	larl	%r2,.Lclkcmp
+	stckc	0(%r2)
+	mvc	__LC_CLOCK_COMP_SAVE_AREA-SAVE_AREA_BASE + 1(7,%r1),1(%r2)
+	/* Program status word */
+	epsw	%r2,%r3
+	st	%r2,__LC_PSW_SAVE_AREA-SAVE_AREA_BASE + 0(%r1)
+	st	%r3,__LC_PSW_SAVE_AREA-SAVE_AREA_BASE + 4(%r1)
+	larl	%r2,store_status
+	stg	%r2,__LC_PSW_SAVE_AREA-SAVE_AREA_BASE + 8(%r1)
+	br	%r14
+.align	8
+.Lclkcmp:	.quad	0x0000000000000000
+
+#
 # do_reipl_asm
 # Parameter: r2 = schid of reipl device
 #
@@ -15,22 +73,7 @@
 ENTRY(do_reipl_asm)
 		basr	%r13,0
 .Lpg0:		lpswe	.Lnewpsw-.Lpg0(%r13)
-.Lpg1:		# do store status of all registers
-
-		stg	%r1,.Lregsave-.Lpg0(%r13)
-		lghi	%r1,0x1000
-		stmg	%r0,%r15,__LC_GPREGS_SAVE_AREA-0x1000(%r1)
-		lg	%r0,.Lregsave-.Lpg0(%r13)
-		stg	%r0,__LC_GPREGS_SAVE_AREA-0x1000+8(%r1)
-		stctg	%c0,%c15,__LC_CREGS_SAVE_AREA-0x1000(%r1)
-		stam	%a0,%a15,__LC_AREGS_SAVE_AREA-0x1000(%r1)
-		lg	%r10,.Ldump_pfx-.Lpg0(%r13)
-		mvc	__LC_PREFIX_SAVE_AREA-0x1000(4,%r1),0(%r10)
-		stfpc	__LC_FP_CREG_SAVE_AREA-0x1000(%r1)
-		stckc	.Lclkcmp-.Lpg0(%r13)
-		mvc	__LC_CLOCK_COMP_SAVE_AREA-0x1000(7,%r1),.Lclkcmp-.Lpg0(%r13)
-		stpt	__LC_CPU_TIMER_SAVE_AREA-0x1000(%r1)
-		stg	%r13, __LC_PSW_SAVE_AREA-0x1000+8(%r1)
+.Lpg1:		brasl	%r14,store_status
 
 		lctlg	%c6,%c6,.Lall-.Lpg0(%r13)
 		lgr	%r1,%r2
@@ -67,10 +110,7 @@ ENTRY(do_reipl_asm)
 		st	%r14,.Ldispsw+12-.Lpg0(%r13)
 		lpswe	.Ldispsw-.Lpg0(%r13)
 		.align	8
-.Lclkcmp:	.quad	0x0000000000000000
 .Lall:		.quad	0x00000000ff000000
-.Ldump_pfx:	.quad	dump_prefix_page
-.Lregsave:	.quad	0x0000000000000000
 		.align	16
 /*
  * These addresses have to be 31 bit otherwise


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
