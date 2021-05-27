Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmHZn-0071gL-5r
 for kexec@lists.infradead.org; Thu, 27 May 2021 15:05:39 +0000
Received: by mail-qt1-x829.google.com with SMTP id h21so424783qtu.5
 for <kexec@lists.infradead.org>; Thu, 27 May 2021 08:05:34 -0700 (PDT)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH 03/18] arm64: hyp-stub: Move elx_sync into the vectors
Date: Thu, 27 May 2021 11:05:11 -0400
Message-Id: <20210527150526.271941-4-pasha.tatashin@soleen.com>
In-Reply-To: <20210527150526.271941-1-pasha.tatashin@soleen.com>
References: <20210527150526.271941-1-pasha.tatashin@soleen.com>
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
To: pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, maz@kernel.org, james.morse@arm.com, vladimir.murzin@arm.com, matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de, selindag@gmail.com, tyhicks@linux.microsoft.com, kernelfans@gmail.com, akpm@linux-foundation.org, madvenka@linux.microsoft.com

The hyp-stub's elx_sync code fits in the vector.

With this, all of the hyp-stubs behaviour is contained in its vectors.
This lets kexec and hibernate copy the hyp-stub when they need its
behaviour, instead of re-implementing it.

Co-developed-by: James Morse <james.morse@arm.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/hyp-stub.S | 64 +++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 31 deletions(-)

diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index 18a97bee3779..86af6c4e52b9 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -21,6 +21,37 @@ SYM_CODE_START_LOCAL(\label)
 	.align 7
 	b	\label
 SYM_CODE_END(\label)
+.endm
+
+.macro elx_sync_vector	label
+SYM_CODE_START_LOCAL(\label)
+	.align 7
+	cmp	x0, #HVC_SET_VECTORS
+	b.ne	1f
+	msr	vbar_el2, x1
+	b	9f
+
+1:	cmp	x0, #HVC_VHE_RESTART
+	b.eq	mutate_to_vhe
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
+SYM_CODE_END(\label)
 .endm
 
 	.text
@@ -34,12 +65,12 @@ SYM_CODE_START(__hyp_stub_vectors)
 	invalid_vector	hyp_stub_el2t_fiq_invalid	// FIQ EL2t
 	invalid_vector	hyp_stub_el2t_error_invalid	// Error EL2t
 
-	ventry	elx_sync				// Synchronous EL2h
+	elx_sync_vector	el2h_sync			// Synchronous EL2h
 	invalid_vector	hyp_stub_el2h_irq_invalid	// IRQ EL2h
 	invalid_vector	hyp_stub_el2h_fiq_invalid	// FIQ EL2h
 	invalid_vector	hyp_stub_el2h_error_invalid	// Error EL2h
 
-	ventry	elx_sync				// Synchronous 64-bit EL1
+	elx_sync_vector	el1_sync			// Synchronous 64-bit EL1
 	invalid_vector	hyp_stub_el1_irq_invalid	// IRQ 64-bit EL1
 	invalid_vector	hyp_stub_el1_fiq_invalid	// FIQ 64-bit EL1
 	invalid_vector	hyp_stub_el1_error_invalid	// Error 64-bit EL1
@@ -55,35 +86,6 @@ SYM_CODE_END(__hyp_stub_vectors)
 # Check the __hyp_stub_vectors didn't overflow
 .org . - (__hyp_stub_vectors_end - __hyp_stub_vectors) + SZ_2K
 
-
-SYM_CODE_START_LOCAL(elx_sync)
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
-SYM_CODE_END(elx_sync)
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
