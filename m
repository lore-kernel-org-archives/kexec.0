Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hnQkz-00055G-68
 for kexec@lists.infradead.org; Tue, 16 Jul 2019 16:56:51 +0000
Received: by mail-qt1-x843.google.com with SMTP id w17so20287189qto.10
 for <kexec@lists.infradead.org>; Tue, 16 Jul 2019 09:56:49 -0700 (PDT)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [RFC v1 4/4] arm64: Keep MMU on while kernel is being relocated
Date: Tue, 16 Jul 2019 12:56:41 -0400
Message-Id: <20190716165641.6990-5-pasha.tatashin@soleen.com>
In-Reply-To: <20190716165641.6990-1-pasha.tatashin@soleen.com>
References: <20190716165641.6990-1-pasha.tatashin@soleen.com>
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
To: pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

It is inefficient to do kernel relocation with MMU disabled. This is
because if MMU is disabled,  dcache must also be disabled.

Now, that we have identity page table we can disable MMU after relocation
is completed.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/cpu-reset.S       |  8 -------
 arch/arm64/kernel/relocate_kernel.S | 36 ++++++++++++++++++-----------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
index 6ea337d464c4..d5cfc17b8e1f 100644
--- a/arch/arm64/kernel/cpu-reset.S
+++ b/arch/arm64/kernel/cpu-reset.S
@@ -30,14 +30,6 @@
  * flat identity mapping.
  */
 ENTRY(__cpu_soft_restart)
-	/* Clear sctlr_el1 flags. */
-	mrs	x12, sctlr_el1
-	ldr	x13, =SCTLR_ELx_FLAGS
-	bic	x12, x12, x13
-	pre_disable_mmu_workaround
-	msr	sctlr_el1, x12
-	isb
-
 	cbz	x0, 1f				// el2_switch?
 	mov	x0, #HVC_SOFT_RESTART
 	hvc	#0				// no return
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index c1d7db71a726..e2724fedd082 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -36,18 +36,6 @@ ENTRY(arm64_relocate_new_kernel)
 	mov	x14, xzr			/* x14 = entry ptr */
 	mov	x13, xzr			/* x13 = copy dest */
 
-	/* Clear the sctlr_el2 flags. */
-	mrs	x0, CurrentEL
-	cmp	x0, #CurrentEL_EL2
-	b.ne	1f
-	mrs	x0, sctlr_el2
-	ldr	x1, =SCTLR_ELx_FLAGS
-	bic	x0, x0, x1
-	pre_disable_mmu_workaround
-	msr	sctlr_el2, x0
-	isb
-1:
-
 	/* Check if the new image needs relocation. */
 	tbnz	x16, IND_DONE_BIT, .Ldone
 
@@ -63,10 +51,10 @@ ENTRY(arm64_relocate_new_kernel)
 	add     x20, x0, #PAGE_SIZE
 	sub     x1, x15, #1
 	bic     x0, x0, x1
-2:	dc      ivac, x0
+1:	dc      ivac, x0
 	add     x0, x0, x15
 	cmp     x0, x20
-	b.lo    2b
+	b.lo    1b
 	dsb     sy
 
 	mov x20, x13
@@ -104,6 +92,26 @@ ENTRY(arm64_relocate_new_kernel)
 	dsb	nsh
 	isb
 
+	/* Clear sctlr_el1 flags. */
+	mrs	x12, sctlr_el1
+	ldr	x13, =SCTLR_ELx_FLAGS
+	bic	x12, x12, x13
+	pre_disable_mmu_workaround
+	msr	sctlr_el1, x12
+	isb
+
+	/* Clear the sctlr_el2 flags. */
+	mrs	x0, CurrentEL
+	cmp	x0, #CurrentEL_EL2
+	b.ne	2f
+	mrs	x0, sctlr_el2
+	ldr	x1, =SCTLR_ELx_FLAGS
+	bic	x0, x0, x1
+	pre_disable_mmu_workaround
+	msr	sctlr_el2, x0
+	isb
+2:
+
 	/* Start new image. */
 	mov	x0, x18
 	mov	x1, xzr
-- 
2.22.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
