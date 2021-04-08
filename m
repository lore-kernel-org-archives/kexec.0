Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lULvM-006lXA-AH
 for kexec@lists.infradead.org; Thu, 08 Apr 2021 04:05:49 +0000
Received: by mail-qv1-xf31.google.com with SMTP id u3so255765qvj.8
 for <kexec@lists.infradead.org>; Wed, 07 Apr 2021 21:05:43 -0700 (PDT)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v13 03/18] arm64: hyp-stub: Move el1_sync into the vectors
Date: Thu,  8 Apr 2021 00:05:22 -0400
Message-Id: <20210408040537.2703241-4-pasha.tatashin@soleen.com>
In-Reply-To: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
References: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
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
To: pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, maz@kernel.org, james.morse@arm.com, vladimir.murzin@arm.com, matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de, selindag@gmail.com, tyhicks@linux.microsoft.com, kernelfans@gmail.com

From: James Morse <james.morse@arm.com>

The hyp-stub's el1_sync code doesn't do very much, this can easily fit
in the vectors.

With this, all of the hyp-stubs behaviour is contained in its vectors.
This lets kexec and hibernate copy the hyp-stub when they need its
behaviour, instead of re-implementing it.

Signed-off-by: James Morse <james.morse@arm.com>

[Fixed merging issues]

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/hyp-stub.S | 59 ++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index ff329c5c074d..d1a73d0f74e0 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -21,6 +21,34 @@ SYM_CODE_START_LOCAL(\label)
 	.align 7
 	b	\label
 SYM_CODE_END(\label)
+.endm
+
+.macro hyp_stub_el1_sync
+SYM_CODE_START_LOCAL(hyp_stub_el1_sync)
+	.align 7
+	cmp	x0, #HVC_SET_VECTORS
+	b.ne	2f
+	msr	vbar_el2, x1
+	b	9f
+
+2:	cmp	x0, #HVC_SOFT_RESTART
+	b.ne	3f
+	mov	x0, x2
+	mov	x2, x4
+	mov	x4, x1
+	mov	x1, x3
+	br	x4				// no return
+
+3:	cmp	x0, #HVC_RESET_VECTORS
+	beq	9f				// Nothing to reset!
+
+	/* Someone called kvm_call_hyp() against the hyp-stub... */
+	mov_q	x0, HVC_STUB_ERR
+	eret
+
+9:	mov	x0, xzr
+	eret
+SYM_CODE_END(hyp_stub_el1_sync)
 .endm
 
 	.text
@@ -39,7 +67,7 @@ SYM_CODE_START(__hyp_stub_vectors)
 	invalid_vector	hyp_stub_el2h_fiq_invalid	// FIQ EL2h
 	invalid_vector	hyp_stub_el2h_error_invalid	// Error EL2h
 
-	ventry	el1_sync			// Synchronous 64-bit EL1
+	hyp_stub_el1_sync				// Synchronous 64-bit EL1
 	invalid_vector	hyp_stub_el1_irq_invalid	// IRQ 64-bit EL1
 	invalid_vector	hyp_stub_el1_fiq_invalid	// FIQ 64-bit EL1
 	invalid_vector	hyp_stub_el1_error_invalid	// Error 64-bit EL1
@@ -55,35 +83,6 @@ SYM_CODE_END(__hyp_stub_vectors)
 # Check the __hyp_stub_vectors didn't overflow
 .org . - (__hyp_stub_vectors_end - __hyp_stub_vectors) + SZ_2K
 
-
-SYM_CODE_START_LOCAL(el1_sync)
-	cmp	x0, #HVC_SET_VECTORS
-	b.ne	1f
-	msr	vbar_el2, x1
-	b	9f
-
-1:	cmp	x0, #HVC_VHE_RESTART
-	b.eq	mutate_to_vhe
-
-2:	cmp	x0, #HVC_SOFT_RESTART
-	b.ne	3f
-	mov	x0, x2
-	mov	x2, x4
-	mov	x4, x1
-	mov	x1, x3
-	br	x4				// no return
-
-3:	cmp	x0, #HVC_RESET_VECTORS
-	beq	9f				// Nothing to reset!
-
-	/* Someone called kvm_call_hyp() against the hyp-stub... */
-	mov_q	x0, HVC_STUB_ERR
-	eret
-
-9:	mov	x0, xzr
-	eret
-SYM_CODE_END(el1_sync)
-
 // nVHE? No way! Give me the real thing!
 SYM_CODE_START_LOCAL(mutate_to_vhe)
 	// Sanity check: MMU *must* be off
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
