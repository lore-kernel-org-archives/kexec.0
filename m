Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from sullivan.realtime.net ([205.238.132.226])
	by casper.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1KskUF-0004Pq-JT
	for kexec@lists.infradead.org; Wed, 22 Oct 2008 20:39:28 +0000
Date: Wed, 22 Oct 2008 15:39:18 -0500 (CDT)
From: Milton Miller <miltonm@bga.com>
Subject: [PATCH 1/3] powerpc: kexec exit should not use magic numbers
Message-id: <kexec-kern-1@bga.com>
In-Reply-To: <f90d4d7306443a720ca31adf513faf25@bga.com>
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
To: Ben Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev@ozlabs.org, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Paul Mackerras <paulus@samba.org>

The relocatable kernel kdump patch (54622f10a6aabb8bb2bdacf3dd070046f03dc246)
added a magic flag value in a register to tell purgatory that it should
be a panic kernel.  This part is wrong and is reverted by this patch.

The kernel gets a list of memory blocks and a entry point from user space.
Its job is to copy the blocks into place and then branch to the designated
entry point (after turning "off" the mmu).

The user space tool inserts a trampoline, called purgatory, that runs
before the user supplied code.   Its job is to establish the entry
environment for the new kernel or other application based on the contents
of memory.  The purgatory code is compiled and embedded in the tool,
where it is later patched using the elf symbol table using elf symbols.

Since the tool knows it is creating a purgatory that will run after a
kernel crash, it should just patch purgatory (or the kernel directly)
if something needs to happen.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
keep the whitespace fix at if(crashing_cpu == -1)

Index: next.git/arch/powerpc/include/asm/kdump.h
===================================================================
--- next.git.orig/arch/powerpc/include/asm/kdump.h	2008-10-22 06:53:22.000000000 -0500
+++ next.git/arch/powerpc/include/asm/kdump.h	2008-10-22 06:54:12.000000000 -0500
@@ -9,12 +9,6 @@
  * Reserve to the end of the FWNMI area, see head_64.S */
 #define KDUMP_RESERVE_LIMIT	0x10000 /* 64K */
 
-/*
- * Used to differentiate between relocatable kdump kernel and other
- * kernels
- */
-#define KDUMP_SIGNATURE	0xfeed1234
-
 #ifdef CONFIG_CRASH_DUMP
 
 #define KDUMP_TRAMPOLINE_START	0x0100
Index: next.git/arch/powerpc/kernel/machine_kexec_64.c
===================================================================
--- next.git.orig/arch/powerpc/kernel/machine_kexec_64.c	2008-10-22 06:53:22.000000000 -0500
+++ next.git/arch/powerpc/kernel/machine_kexec_64.c	2008-10-22 06:54:12.000000000 -0500
@@ -255,14 +255,11 @@ static union thread_union kexec_stack
 /* Our assembly helper, in kexec_stub.S */
 extern NORET_TYPE void kexec_sequence(void *newstack, unsigned long start,
 					void *image, void *control,
-					void (*clear_all)(void),
-					unsigned long kdump_flag) ATTRIB_NORET;
+					void (*clear_all)(void)) ATTRIB_NORET;
 
 /* too late to fail here */
 void default_machine_kexec(struct kimage *image)
 {
-	unsigned long kdump_flag = 0;
-
 	/* prepare control code if any */
 
 	/*
@@ -275,8 +272,6 @@ void default_machine_kexec(struct kimage
 
 	if (crashing_cpu == -1)
 		kexec_prepare_cpus();
-	else
-		kdump_flag = KDUMP_SIGNATURE;
 
 	/* switch to a staticly allocated stack.  Based on irq stack code.
 	 * XXX: the task struct will likely be invalid once we do the copy!
@@ -289,7 +284,7 @@ void default_machine_kexec(struct kimage
 	 */
 	kexec_sequence(&kexec_stack, image->start, image,
 			page_address(image->control_code_page),
-			ppc_md.hpte_clear_all, kdump_flag);
+			ppc_md.hpte_clear_all);
 	/* NOTREACHED */
 }
 
Index: next.git/arch/powerpc/kernel/misc_64.S
===================================================================
--- next.git.orig/arch/powerpc/kernel/misc_64.S	2008-10-22 06:53:22.000000000 -0500
+++ next.git/arch/powerpc/kernel/misc_64.S	2008-10-22 06:54:12.000000000 -0500
@@ -611,12 +611,10 @@ real_mode:	/* assume normal blr return *
 
 
 /*
- * kexec_sequence(newstack, start, image, control, clear_all(), kdump_flag)
+ * kexec_sequence(newstack, start, image, control, clear_all())
  *
  * does the grungy work with stack switching and real mode switches
  * also does simple calls to other code
- *
- * kdump_flag says whether the next kernel should be a kdump kernel.
  */
 
 _GLOBAL(kexec_sequence)
@@ -649,7 +647,7 @@ _GLOBAL(kexec_sequence)
 	mr	r29,r5			/* image (virt) */
 	mr	r28,r6			/* control, unused */
 	mr	r27,r7			/* clear_all() fn desc */
-	mr	r26,r8			/* kdump flag */
+	mr	r26,r8			/* spare */
 	lhz	r25,PACAHWCPUID(r13)	/* get our phys cpu from paca */
 
 	/* disable interrupts, we are overwriting kernel data next */
@@ -711,6 +709,5 @@ _GLOBAL(kexec_sequence)
 	mr	r4,r30	# start, aka phys mem offset
 	mtlr	4
 	li	r5,0
-	mr	r6,r26			/* kdump_flag */
-	blr	/* image->start(physid, image->start, 0, kdump_flag); */
+	blr	/* image->start(physid, image->start, 0); */
 #endif /* CONFIG_KEXEC */

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
