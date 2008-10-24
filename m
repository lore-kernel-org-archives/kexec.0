Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KtEU6-0001RR-JS
	for kexec@lists.infradead.org; Fri, 24 Oct 2008 04:41:15 +0000
From: Michael Neuling <mikey@neuling.org>
Subject: [PATCH 3/3] powerpc/ppc64/kdump: better flag for running relocatable 
In-reply-to: <18687.62202.333736.269891@drongo.ozlabs.ibm.com> 
References: <f90d4d7306443a720ca31adf513faf25@bga.com> <kexec-kern-2@bga.com>
	<18687.61506.924500.411952@drongo.ozlabs.ibm.com>
	<18687.62202.333736.269891@drongo.ozlabs.ibm.com>
Date: Fri, 24 Oct 2008 15:41:09 +1100
Message-ID: <21633.1224823269@neuling.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Paul Mackerras <paulus@samba.org>
Cc: Ben Herrenschmidt <benh@kernel.crashing.org>, kexec@lists.infradead.org, Milton Miller <miltonm@bga.com>, Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev@ozlabs.org, Simon Horman <horms@verge.net.au>

From: Milton Miller <miltonm@bga.com>

The __kdump_flag ABI is overly constraining for future development.  

As of 2.6.27, the kernel entry point has 4 constraints:  Offset 0 is
the starting point for the master (boot) cpu (entered with r3 pointing
to the device tree structure), offset 0x60 is code for the slave cpus
(entered with r3 set to their device tree physical id), offset 0x20 is
used by the iseries hypervisor, and secondary cpus must be well behaved
when the first 256 bytes are copied to address 0.

Placing the __kdump_flag at 0x18 is bad because:

- It was taking the last 8 bytes before the iseries hypervisor data.  
- It was 8 bytes for a boolean flag
- It had no way of identifying that the flag was present
- It does leave any room for the master to add any additional code
  before branching, which hurts debug.
- It will be unnecessarily hard for 32 bit code to be common (8 bytes)

Now that we have eliminated the use of __kdump_flag in favor of
the standard is_kdump_kernel(), this flag only controls run without
relocating the kernel to PHYSICAL_START (0), so rename it __run_at_load.

Move the flag to 0x5c, 1 word before the secondary cpu entry point at
0x60.  Initialize it with "run0" to say it will run at 0 unless it is
set to 1.  It only exists if we are relocatable.

Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/head_64.S |   30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

As discussed, this changes the __run_at_load location to 
0x5c + load offset rather than 0x5c + 0.

Index: linux-2.6-ozlabs/arch/powerpc/kernel/head_64.S
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/head_64.S
+++ linux-2.6-ozlabs/arch/powerpc/kernel/head_64.S
@@ -104,12 +104,6 @@ __secondary_hold_spinloop:
 __secondary_hold_acknowledge:
 	.llong	0x0
 
-	/* This flag is set by purgatory if we should be a kdump kernel. */
-	/* Do not move this variable as purgatory knows about it. */
-	.globl	__kdump_flag
-__kdump_flag:
-	.llong	0x0
-
 #ifdef CONFIG_PPC_ISERIES
 	/*
 	 * At offset 0x20, there is a pointer to iSeries LPAR data.
@@ -119,6 +113,20 @@ __kdump_flag:
 	.llong hvReleaseData-KERNELBASE
 #endif /* CONFIG_PPC_ISERIES */
 
+#ifdef CONFIG_CRASH_DUMP
+	/* This flag is set to 1 by a loader if the kernel should run
+	 * at the loaded address instead of the linked address.  This
+	 * is used by kexec-tools to keep the the kdump kernel in the
+	 * crash_kernel region.  The loader is responsible for
+	 * observing the alignment requirement.
+	 */
+	/* Do not move this variable as kexec-tools knows about it. */
+	. = 0x5c
+	.globl	__run_at_load
+__run_at_load:
+	.long	0x72756e30	/* "run0" -- relocate to 0 by default */
+#endif
+
 	. = 0x60
 /*
  * The following code is used to hold secondary processors
@@ -1407,8 +1415,8 @@ _STATIC(__after_prom_start)
 	lis	r25,PAGE_OFFSET@highest	/* compute virtual base of kernel */
 	sldi	r25,r25,32
 #ifdef CONFIG_CRASH_DUMP
-	ld	r7,__kdump_flag-_stext(r26)
-	cmpldi	cr0,r7,1	/* kdump kernel ? - stay where we are */
+	lwz	r7,__run_at_load-_stext(r26)
+	cmplwi	cr0,r7,1	/* kdump kernel ? - stay where we are */
 	bne	1f
 	add	r25,r25,r26
 #endif
@@ -1432,11 +1440,11 @@ _STATIC(__after_prom_start)
 #ifdef CONFIG_CRASH_DUMP
 /*
  * Check if the kernel has to be running as relocatable kernel based on the
- * variable __kdump_flag, if it is set the kernel is treated as relocatable
+ * variable __run_at_load, if it is set the kernel is treated as relocatable
  * kernel, otherwise it will be moved to PHYSICAL_START
  */
-	ld	r7,__kdump_flag-_stext(r26)
-	cmpldi	cr0,r7,1
+	lwz	r7,__run_at_load-_stext(r26)
+	cmplwi	cr0,r7,1
 	bne	3f
 
 	li	r5,__end_interrupts - _stext	/* just copy interrupts */

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
