Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iKpTt-0004YC-1H
 for kexec@lists.infradead.org; Wed, 16 Oct 2019 20:01:16 +0000
Received: by mail-qk1-x743.google.com with SMTP id z67so23951009qkb.12
 for <kexec@lists.infradead.org>; Wed, 16 Oct 2019 13:01:12 -0700 (PDT)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v7 22/25] arm64: kexec: kexec EL2 vectors
Date: Wed, 16 Oct 2019 16:00:31 -0400
Message-Id: <20191016200034.1342308-23-pasha.tatashin@soleen.com>
In-Reply-To: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
References: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
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
To: pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com, james.morse@arm.com, vladimir.murzin@arm.com, matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org, mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de

If we have a EL2 mode without VHE, the EL2 vectors are needed in order
to switch to EL2 and jump to new world with hyperivsor privileges.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/kexec.h      |  5 +++++
 arch/arm64/kernel/asm-offsets.c     |  1 +
 arch/arm64/kernel/machine_kexec.c   |  5 +++++
 arch/arm64/kernel/relocate_kernel.S | 34 +++++++++++++++++++++++++++++
 4 files changed, 45 insertions(+)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 8cad34e7a9d9..414a0a41a60a 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -95,6 +95,7 @@ static inline void crash_post_resume(void) {}
 extern const unsigned long kexec_relocate_code_size;
 extern const unsigned char kexec_relocate_code_start[];
 extern const unsigned long kexec_kern_reloc_offset;
+extern const unsigned long kexec_el2_vectors_offset;
 #endif
 
 /*
@@ -104,6 +105,9 @@ extern const unsigned long kexec_kern_reloc_offset;
  *		kernel, or purgatory entry address).
  * kern_arg0	first argument to kernel is its dtb address. The other
  *		arguments are currently unused, and must be set to 0
+ * el2_vector	If present means that relocation routine will go to EL1
+ *		from EL2 to do the copy, and then back to EL2 to do the jump
+ *		to new world.
  */
 struct kern_reloc_arg {
 	phys_addr_t head;
@@ -112,6 +116,7 @@ struct kern_reloc_arg {
 	phys_addr_t kern_arg1;
 	phys_addr_t kern_arg2;
 	phys_addr_t kern_arg3;
+	phys_addr_t el2_vector;
 };
 
 #define ARCH_HAS_KIMAGE_ARCH
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 6fd21374abec..ad7764d68904 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -135,6 +135,7 @@ int main(void)
   DEFINE(KEXEC_KRELOC_KERN_ARG1,	offsetof(struct kern_reloc_arg, kern_arg1));
   DEFINE(KEXEC_KRELOC_KERN_ARG2,	offsetof(struct kern_reloc_arg, kern_arg2));
   DEFINE(KEXEC_KRELOC_KERN_ARG3,	offsetof(struct kern_reloc_arg, kern_arg3));
+  DEFINE(KEXEC_KRELOC_EL2_VECTOR,	offsetof(struct kern_reloc_arg, el2_vector));
 #endif
   return 0;
 }
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 5e7b1f6569c4..ac6ade7c96ff 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -84,6 +84,11 @@ int machine_kexec_post_load(struct kimage *kimage)
 	kern_reloc_arg->head = kimage->head;
 	kern_reloc_arg->entry_addr = kimage->start;
 	kern_reloc_arg->kern_arg0 = kimage->arch.dtb_mem;
+	/* Setup vector table only when EL2 is available, but no VHE */
+	if (is_hyp_mode_available() && !is_kernel_in_hyp_mode()) {
+		kern_reloc_arg->el2_vector = __pa(reloc_code)
+						+ kexec_el2_vectors_offset;
+	}
 	kexec_image_info(kimage);
 
 	return 0;
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index 3c05220a79ab..67efa42575a5 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -88,6 +88,38 @@ ENTRY(arm64_relocate_new_kernel)
 .ltorg
 END(arm64_relocate_new_kernel)
 
+.macro el1_sync_64
+	br	x4			/* Jump to new world from el2 */
+	.fill 31, 4, 0			/* Set other 31 instr to zeroes */
+.endm
+
+.macro invalid_vector label
+\label:
+	b \label
+	.fill 31, 4, 0			/* Set other 31 instr to zeroes */
+.endm
+
+/* el2 vectors - switch el2 here while we restore the memory image. */
+	.align 11
+ENTRY(kexec_el2_vectors)
+	invalid_vector el2_sync_invalid_sp0	/* Synchronous EL2t */
+	invalid_vector el2_irq_invalid_sp0	/* IRQ EL2t */
+	invalid_vector el2_fiq_invalid_sp0	/* FIQ EL2t */
+	invalid_vector el2_error_invalid_sp0	/* Error EL2t */
+	invalid_vector el2_sync_invalid_spx	/* Synchronous EL2h */
+	invalid_vector el2_irq_invalid_spx	/* IRQ EL2h */
+	invalid_vector el2_fiq_invalid_spx	/* FIQ EL2h */
+	invalid_vector el2_error_invalid_spx	/* Error EL2h */
+		el1_sync_64			/* Synchronous 64-bit EL1 */
+	invalid_vector el1_irq_invalid_64	/* IRQ 64-bit EL1 */
+	invalid_vector el1_fiq_invalid_64	/* FIQ 64-bit EL1 */
+	invalid_vector el1_error_invalid_64	/* Error 64-bit EL1 */
+	invalid_vector el1_sync_invalid_32	/* Synchronous 32-bit EL1 */
+	invalid_vector el1_irq_invalid_32	/* IRQ 32-bit EL1 */
+	invalid_vector el1_fiq_invalid_32	/* FIQ 32-bit EL1 */
+	invalid_vector el1_error_invalid_32	/* Error 32-bit EL1 */
+END(kexec_el2_vectors)
+
 .Lkexec_relocate_code_end:
 .org	KEXEC_CONTROL_PAGE_SIZE
 .align 3	/* To keep the 64-bit values below naturally aligned. */
@@ -99,3 +131,5 @@ GLOBAL(kexec_relocate_code_size)
 	.quad	.Lkexec_relocate_code_end - kexec_relocate_code_start
 GLOBAL(kexec_kern_reloc_offset)
 	.quad	arm64_relocate_new_kernel - kexec_relocate_code_start
+GLOBAL(kexec_el2_vectors_offset)
+	.quad	kexec_el2_vectors - kexec_relocate_code_start
-- 
2.23.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
