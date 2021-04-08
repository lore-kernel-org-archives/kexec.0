Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lULvK-006lWR-V2
 for kexec@lists.infradead.org; Thu, 08 Apr 2021 04:05:47 +0000
Received: by mail-qk1-x72f.google.com with SMTP id c4so950944qkg.3
 for <kexec@lists.infradead.org>; Wed, 07 Apr 2021 21:05:42 -0700 (PDT)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v13 02/18] arm64: hyp-stub: Move invalid vector entries into
 the vectors
Date: Thu,  8 Apr 2021 00:05:21 -0400
Message-Id: <20210408040537.2703241-3-pasha.tatashin@soleen.com>
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

Most of the hyp-stub's vector entries are invalid. These are each
a unique function that branches to itself. To move these into the
vectors, merge the ventry and invalid_vector macros and give each
one a unique name.

This means we can copy the hyp-stub as it is self contained within
its vectors.

Signed-off-by: James Morse <james.morse@arm.com>

[Fixed merging issues]

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/hyp-stub.S | 56 +++++++++++++++---------------------
 1 file changed, 23 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index 572b28646005..ff329c5c074d 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -16,31 +16,38 @@
 #include <asm/ptrace.h>
 #include <asm/virt.h>
 
+.macro invalid_vector	label
+SYM_CODE_START_LOCAL(\label)
+	.align 7
+	b	\label
+SYM_CODE_END(\label)
+.endm
+
 	.text
 	.pushsection	.hyp.text, "ax"
 
 	.align 11
 
 SYM_CODE_START(__hyp_stub_vectors)
-	ventry	el2_sync_invalid		// Synchronous EL2t
-	ventry	el2_irq_invalid			// IRQ EL2t
-	ventry	el2_fiq_invalid			// FIQ EL2t
-	ventry	el2_error_invalid		// Error EL2t
+	invalid_vector	hyp_stub_el2t_sync_invalid	// Synchronous EL2t
+	invalid_vector	hyp_stub_el2t_irq_invalid	// IRQ EL2t
+	invalid_vector	hyp_stub_el2t_fiq_invalid	// FIQ EL2t
+	invalid_vector	hyp_stub_el2t_error_invalid	// Error EL2t
 
-	ventry	el2_sync_invalid		// Synchronous EL2h
-	ventry	el2_irq_invalid			// IRQ EL2h
-	ventry	el2_fiq_invalid			// FIQ EL2h
-	ventry	el2_error_invalid		// Error EL2h
+	invalid_vector	hyp_stub_el2h_sync_invalid	// Synchronous EL2h
+	invalid_vector	hyp_stub_el2h_irq_invalid	// IRQ EL2h
+	invalid_vector	hyp_stub_el2h_fiq_invalid	// FIQ EL2h
+	invalid_vector	hyp_stub_el2h_error_invalid	// Error EL2h
 
 	ventry	el1_sync			// Synchronous 64-bit EL1
-	ventry	el1_irq_invalid			// IRQ 64-bit EL1
-	ventry	el1_fiq_invalid			// FIQ 64-bit EL1
-	ventry	el1_error_invalid		// Error 64-bit EL1
-
-	ventry	el1_sync_invalid		// Synchronous 32-bit EL1
-	ventry	el1_irq_invalid			// IRQ 32-bit EL1
-	ventry	el1_fiq_invalid			// FIQ 32-bit EL1
-	ventry	el1_error_invalid		// Error 32-bit EL1
+	invalid_vector	hyp_stub_el1_irq_invalid	// IRQ 64-bit EL1
+	invalid_vector	hyp_stub_el1_fiq_invalid	// FIQ 64-bit EL1
+	invalid_vector	hyp_stub_el1_error_invalid	// Error 64-bit EL1
+
+	invalid_vector	hyp_stub_32b_el1_sync_invalid	// Synchronous 32-bit EL1
+	invalid_vector	hyp_stub_32b_el1_irq_invalid	// IRQ 32-bit EL1
+	invalid_vector	hyp_stub_32b_el1_fiq_invalid	// FIQ 32-bit EL1
+	invalid_vector	hyp_stub_32b_el1_error_invalid	// Error 32-bit EL1
 	.align 11
 SYM_INNER_LABEL(__hyp_stub_vectors_end, SYM_L_LOCAL)
 SYM_CODE_END(__hyp_stub_vectors)
@@ -173,23 +180,6 @@ SYM_CODE_END(enter_vhe)
 
 	.popsection
 
-.macro invalid_vector	label
-SYM_CODE_START_LOCAL(\label)
-	b \label
-SYM_CODE_END(\label)
-.endm
-
-	invalid_vector	el2_sync_invalid
-	invalid_vector	el2_irq_invalid
-	invalid_vector	el2_fiq_invalid
-	invalid_vector	el2_error_invalid
-	invalid_vector	el1_sync_invalid
-	invalid_vector	el1_irq_invalid
-	invalid_vector	el1_fiq_invalid
-	invalid_vector	el1_error_invalid
-
-	.popsection
-
 /*
  * __hyp_set_vectors: Call this after boot to set the initial hypervisor
  * vectors as part of hypervisor installation.  On an SMP system, this should
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
