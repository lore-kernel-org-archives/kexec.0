Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn1on0118.outbound.protection.outlook.com
 ([157.56.110.118] helo=na01-bn1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zjfiy-00018p-W9
 for kexec@lists.infradead.org; Wed, 07 Oct 2015 03:49:06 +0000
From: Scott Wood <scottwood@freescale.com>
Subject: [PATCH v2 11/18] powerpc/book3e: support CONFIG_RELOCATABLE
Date: Tue, 6 Oct 2015 22:48:15 -0500
Message-ID: <1444189702-17241-12-git-send-email-scottwood@freescale.com>
In-Reply-To: <1444189702-17241-1-git-send-email-scottwood@freescale.com>
References: <1444189702-17241-1-git-send-email-scottwood@freescale.com>
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
To: linuxppc-dev@lists.ozlabs.org
Cc: Tiejun Chen <tiejun.chen@windriver.com>, Tiejun Chen <tiejun.chen@intel.com>, kexec@lists.infradead.org, Scott Wood <scottwood@freescale.com>, Michael Ellerman <mpe@ellerman.id.au>

From: Tiejun Chen <tiejun.chen@windriver.com>

book3e is different with book3s since 3s includes the exception
vectors code in head_64.S as it relies on absolute addressing
which is only possible within this compilation unit. So we have
to get that label address with got.

And when boot a relocated kernel, we should reset ipvr properly again
after .relocate.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
[scottwood: cleanup and ifdef removal]
Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/include/asm/exception-64e.h |  4 ++--
 arch/powerpc/kernel/exceptions-64e.S     |  9 +++++++--
 arch/powerpc/kernel/head_64.S            | 22 +++++++++++++++++++---
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64e.h b/arch/powerpc/include/asm/exception-64e.h
index a8b52b6..344fc43 100644
--- a/arch/powerpc/include/asm/exception-64e.h
+++ b/arch/powerpc/include/asm/exception-64e.h
@@ -204,8 +204,8 @@ exc_##label##_book3e:
 #endif
 
 #define SET_IVOR(vector_number, vector_offset)	\
-	li	r3,vector_offset@l; 		\
-	ori	r3,r3,interrupt_base_book3e@l;	\
+	LOAD_REG_ADDR(r3,interrupt_base_book3e);\
+	ori	r3,r3,vector_offset@l;		\
 	mtspr	SPRN_IVOR##vector_number,r3;
 
 #endif /* _ASM_POWERPC_EXCEPTION_64E_H */
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 9d4a006..488e631 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -1351,7 +1351,10 @@ skpinv:	addi	r6,r6,1				/* Increment */
  * r4 = MAS0 w/TLBSEL & ESEL for the temp mapping
  */
 	/* Now we branch the new virtual address mapped by this entry */
-	LOAD_REG_IMMEDIATE(r6,2f)
+	bl	1f		/* Find our address */
+1:	mflr	r6
+	addi	r6,r6,(2f - 1b)
+	tovirt(r6,r6)
 	lis	r7,MSR_KERNEL@h
 	ori	r7,r7,MSR_KERNEL@l
 	mtspr	SPRN_SRR0,r6
@@ -1583,9 +1586,11 @@ _GLOBAL(book3e_secondary_thread_init)
 	mflr	r28
 	b	3b
 
+	.globl init_core_book3e
 init_core_book3e:
 	/* Establish the interrupt vector base */
-	LOAD_REG_IMMEDIATE(r3, interrupt_base_book3e)
+	tovirt(r2,r2)
+	LOAD_REG_ADDR(r3, interrupt_base_book3e)
 	mtspr	SPRN_IVPR,r3
 	sync
 	blr
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index a1e85ca..1b77956 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -457,12 +457,22 @@ __after_prom_start:
 	/* process relocations for the final address of the kernel */
 	lis	r25,PAGE_OFFSET@highest	/* compute virtual base of kernel */
 	sldi	r25,r25,32
+#if defined(CONFIG_PPC_BOOK3E)
+	tovirt(r26,r26)		/* on booke, we already run at PAGE_OFFSET */
+#endif
 	lwz	r7,__run_at_load-_stext(r26)
+#if defined(CONFIG_PPC_BOOK3E)
+	tophys(r26,r26)
+#endif
 	cmplwi	cr0,r7,1	/* flagged to stay where we are ? */
 	bne	1f
 	add	r25,r25,r26
 1:	mr	r3,r25
 	bl	relocate
+#if defined(CONFIG_PPC_BOOK3E)
+	/* IVPR needs to be set after relocation. */
+	bl	init_core_book3e
+#endif
 #endif
 
 /*
@@ -490,12 +500,21 @@ __after_prom_start:
  * variable __run_at_load, if it is set the kernel is treated as relocatable
  * kernel, otherwise it will be moved to PHYSICAL_START
  */
+#if defined(CONFIG_PPC_BOOK3E)
+	tovirt(r26,r26)		/* on booke, we already run at PAGE_OFFSET */
+#endif
 	lwz	r7,__run_at_load-_stext(r26)
 	cmplwi	cr0,r7,1
 	bne	3f
 
+#ifdef CONFIG_PPC_BOOK3E
+	LOAD_REG_ADDR(r5, __end_interrupts)
+	LOAD_REG_ADDR(r11, _stext)
+	sub	r5,r5,r11
+#else
 	/* just copy interrupts */
 	LOAD_REG_IMMEDIATE(r5, __end_interrupts - _stext)
+#endif
 	b	5f
 3:
 #endif
@@ -514,9 +533,6 @@ __after_prom_start:
 p_end:	.llong	_end - _stext
 
 4:	/* Now copy the rest of the kernel up to _end */
-#if defined(CONFIG_PPC_BOOK3E)
-	tovirt(r26,r26)
-#endif
 	addis	r5,r26,(p_end - _stext)@ha
 	ld	r5,(p_end - _stext)@l(r5)	/* get _end */
 5:	bl	copy_and_flush		/* copy the rest */
-- 
2.1.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
