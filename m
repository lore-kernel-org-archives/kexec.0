Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1l47PA-004Z4i-Ke
 for kexec@lists.infradead.org; Mon, 25 Jan 2021 19:20:40 +0000
Received: by mail-qk1-x72a.google.com with SMTP id k193so13612209qke.6
 for <kexec@lists.infradead.org>; Mon, 25 Jan 2021 11:19:49 -0800 (PST)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v10 15/18] arm64: kexec: kexec may require EL2 vectors
Date: Mon, 25 Jan 2021 14:19:20 -0500
Message-Id: <20210125191923.1060122-16-pasha.tatashin@soleen.com>
In-Reply-To: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
References: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
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
To: pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, maz@kernel.org, james.morse@arm.com, vladimir.murzin@arm.com, matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de, selindag@gmail.com, tyhicks@linux.microsoft.com

If we have a EL2 mode without VHE, the EL2 vectors are needed in order
to switch to EL2 and jump to new world with hypervisor privileges.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/kexec.h      |  5 +++++
 arch/arm64/kernel/asm-offsets.c     |  1 +
 arch/arm64/kernel/machine_kexec.c   |  9 +++++++-
 arch/arm64/kernel/relocate_kernel.S | 35 +++++++++++++++++++++++++++++
 4 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 7f4f9abdf049..b96d8a6aac80 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -92,6 +92,7 @@ static inline void crash_post_resume(void) {}
 
 #if defined(CONFIG_KEXEC_CORE)
 extern const char arm64_relocate_new_kernel[];
+extern const char arm64_kexec_el2_vectors[];
 #endif
 
 /*
@@ -101,6 +102,9 @@ extern const char arm64_relocate_new_kernel[];
  *		kernel, or purgatory entry address).
  * kern_arg0	first argument to kernel is its dtb address. The other
  *		arguments are currently unused, and must be set to 0
+ * el2_vector	If present means that relocation routine will go to EL1
+ *		from EL2 to do the copy, and then back to EL2 to do the jump
+ *		to new world.
  */
 struct kern_reloc_arg {
 	phys_addr_t head;
@@ -109,6 +113,7 @@ struct kern_reloc_arg {
 	phys_addr_t kern_arg1;
 	phys_addr_t kern_arg2;
 	phys_addr_t kern_arg3;
+	phys_addr_t el2_vector;
 };
 
 #define ARCH_HAS_KIMAGE_ARCH
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 6067a288f568..8a9475be1b62 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -159,6 +159,7 @@ int main(void)
   DEFINE(KEXEC_KRELOC_KERN_ARG1,	offsetof(struct kern_reloc_arg, kern_arg1));
   DEFINE(KEXEC_KRELOC_KERN_ARG2,	offsetof(struct kern_reloc_arg, kern_arg2));
   DEFINE(KEXEC_KRELOC_KERN_ARG3,	offsetof(struct kern_reloc_arg, kern_arg3));
+  DEFINE(KEXEC_KRELOC_EL2_VECTOR,	offsetof(struct kern_reloc_arg, el2_vector));
 #endif
   return 0;
 }
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 361a4d082093..41d1e3ca13f8 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -75,19 +75,26 @@ int machine_kexec_post_load(struct kimage *kimage)
 {
 	void *reloc_code = page_to_virt(kimage->control_code_page);
 	struct kern_reloc_arg *kern_reloc_arg = kexec_page_alloc(kimage);
-	long func_offset, reloc_size;
+	long func_offset, vector_offset, reloc_size;
 
 	if (!kern_reloc_arg)
 		return -ENOMEM;
 
 	func_offset = arm64_relocate_new_kernel - __relocate_new_kernel_start;
 	reloc_size = __relocate_new_kernel_end - __relocate_new_kernel_start;
+	vector_offset = arm64_kexec_el2_vectors - __relocate_new_kernel_start;
+
 	memcpy(reloc_code, __relocate_new_kernel_start, reloc_size);
 	kimage->arch.kern_reloc = __pa(reloc_code) + func_offset;
 	kimage->arch.kern_reloc_arg = __pa(kern_reloc_arg);
 	kern_reloc_arg->head = kimage->head;
 	kern_reloc_arg->entry_addr = kimage->start;
 	kern_reloc_arg->kern_arg0 = kimage->arch.dtb_mem;
+
+	/* Setup vector table only when EL2 is available, but no VHE */
+	if (is_hyp_mode_available() && !is_kernel_in_hyp_mode())
+		kern_reloc_arg->el2_vector = __pa(reloc_code) + vector_offset;
+
 	kexec_image_info(kimage);
 
 	/* Flush the reloc_code in preparation for its execution. */
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index d2a4a0b0d76b..c6178b1a4e60 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -14,6 +14,17 @@
 #include <asm/page.h>
 #include <asm/sysreg.h>
 
+.macro el1_sync_64
+	.align 7
+	br	x4			/* Jump to new world from el2 */
+.endm
+
+.macro invalid_vector label
+\label:
+	.align 7
+	b \label
+.endm
+
 .pushsection    ".kexec_relocate.text", "ax"
 /*
  * arm64_relocate_new_kernel - Put a 2nd stage image in place and boot it.
@@ -76,4 +87,28 @@ SYM_CODE_START(arm64_relocate_new_kernel)
 	ldr	x0, [x0, #KEXEC_KRELOC_KERN_ARG0]	/* x0 = dtb address */
 	br	x4
 SYM_CODE_END(arm64_relocate_new_kernel)
+
+/* el2 vectors - switch el2 here while we restore the memory image. */
+	.align 11
+SYM_CODE_START(arm64_kexec_el2_vectors)
+	invalid_vector el2_sync_invalid_sp0	/* Synchronous EL2t */
+	invalid_vector el2_irq_invalid_sp0	/* IRQ EL2t */
+	invalid_vector el2_fiq_invalid_sp0	/* FIQ EL2t */
+	invalid_vector el2_error_invalid_sp0	/* Error EL2t */
+
+	invalid_vector el2_sync_invalid_spx	/* Synchronous EL2h */
+	invalid_vector el2_irq_invalid_spx	/* IRQ EL2h */
+	invalid_vector el2_fiq_invalid_spx	/* FIQ EL2h */
+	invalid_vector el2_error_invalid_spx	/* Error EL2h */
+
+	el1_sync_64				/* Synchronous 64-bit EL1 */
+	invalid_vector el1_irq_invalid_64	/* IRQ 64-bit EL1 */
+	invalid_vector el1_fiq_invalid_64	/* FIQ 64-bit EL1 */
+	invalid_vector el1_error_invalid_64	/* Error 64-bit EL1 */
+
+	invalid_vector el1_sync_invalid_32	/* Synchronous 32-bit EL1 */
+	invalid_vector el1_irq_invalid_32	/* IRQ 32-bit EL1 */
+	invalid_vector el1_fiq_invalid_32	/* FIQ 32-bit EL1 */
+	invalid_vector el1_error_invalid_32	/* Error 32-bit EL1 */
+SYM_CODE_END(arm64_kexec_el2_vectors)
 .popsection
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
