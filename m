Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn1on0135.outbound.protection.outlook.com
 ([157.56.110.135] helo=na01-bn1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZGYQY-0007mM-SN
 for kexec@lists.infradead.org; Sat, 18 Jul 2015 20:09:43 +0000
From: Scott Wood <scottwood@freescale.com>
Subject: [RFC PATCH 08/17] powerpc/book3e-64: rename interrupt_end_book3e with
 __end_interrupts
Date: Sat, 18 Jul 2015 15:08:45 -0500
Message-ID: <1437250134-307-9-git-send-email-scottwood@freescale.com>
In-Reply-To: <1437250134-307-1-git-send-email-scottwood@freescale.com>
References: <1437250134-307-1-git-send-email-scottwood@freescale.com>
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
Cc: Scott Wood <scottwood@freescale.com>, Tiejun Chen <tiejun.chen@intel.com>, kexec@lists.infradead.org, Tiejun Chen <tiejun.chen@windriver.com>

From: Tiejun Chen <tiejun.chen@windriver.com>

Rename 'interrupt_end_book3e' to '__end_interrupts' so that the symbol
can be used by both book3s and book3e.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
[scottwood: edit changelog]
Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/exceptions-64e.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index f3bd5e7..9d4a006 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -542,8 +542,8 @@ interrupt_base_book3e:					/* fake trap */
 	EXCEPTION_STUB(0x320, ehpriv)
 	EXCEPTION_STUB(0x340, lrat_error)
 
-	.globl interrupt_end_book3e
-interrupt_end_book3e:
+	.globl __end_interrupts
+__end_interrupts:
 
 /* Critical Input Interrupt */
 	START_EXCEPTION(critical_input);
@@ -736,7 +736,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	beq+	1f
 
 	LOAD_REG_IMMEDIATE(r14,interrupt_base_book3e)
-	LOAD_REG_IMMEDIATE(r15,interrupt_end_book3e)
+	LOAD_REG_IMMEDIATE(r15,__end_interrupts)
 	cmpld	cr0,r10,r14
 	cmpld	cr1,r10,r15
 	blt+	cr0,1f
@@ -800,7 +800,7 @@ kernel_dbg_exc:
 	beq+	1f
 
 	LOAD_REG_IMMEDIATE(r14,interrupt_base_book3e)
-	LOAD_REG_IMMEDIATE(r15,interrupt_end_book3e)
+	LOAD_REG_IMMEDIATE(r15,__end_interrupts)
 	cmpld	cr0,r10,r14
 	cmpld	cr1,r10,r15
 	blt+	cr0,1f
-- 
2.1.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
