Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4ob5-0005pk-JM
 for kexec@lists.infradead.org; Wed, 27 Jan 2021 17:27:28 +0000
Received: by mail-qt1-x82f.google.com with SMTP id z6so1992134qtn.0
 for <kexec@lists.infradead.org>; Wed, 27 Jan 2021 09:27:13 -0800 (PST)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v11 2/6] arm64: kexec: use ld script for relocation function
Date: Wed, 27 Jan 2021 12:27:02 -0500
Message-Id: <20210127172706.617195-3-pasha.tatashin@soleen.com>
In-Reply-To: <20210127172706.617195-1-pasha.tatashin@soleen.com>
References: <20210127172706.617195-1-pasha.tatashin@soleen.com>
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

Currently, relocation code declares start and end variables
which are used to compute it size.

The better way to do this is to use ld script incited, and put relocation
function in its own section.

Soon, relocation function will share the same page with EL2 vectors. So,
proper marking is needed.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/kexec.h      |  4 ++++
 arch/arm64/include/asm/sections.h   |  1 +
 arch/arm64/kernel/machine_kexec.c   | 17 ++++++++---------
 arch/arm64/kernel/relocate_kernel.S | 15 ++-------------
 arch/arm64/kernel/vmlinux.lds.S     | 19 +++++++++++++++++++
 5 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 990185744148..7f4f9abdf049 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -90,6 +90,10 @@ static inline void crash_prepare_suspend(void) {}
 static inline void crash_post_resume(void) {}
 #endif
 
+#if defined(CONFIG_KEXEC_CORE)
+extern const char arm64_relocate_new_kernel[];
+#endif
+
 /*
  * kern_reloc_arg is passed to kernel relocation function as an argument.
  * head		kimage->head, allows to traverse through relocation segments.
diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
index 8ff579361731..ae873eb22205 100644
--- a/arch/arm64/include/asm/sections.h
+++ b/arch/arm64/include/asm/sections.h
@@ -19,5 +19,6 @@ extern char __exittext_begin[], __exittext_end[];
 extern char __irqentry_text_start[], __irqentry_text_end[];
 extern char __mmuoff_data_start[], __mmuoff_data_end[];
 extern char __entry_tramp_text_start[], __entry_tramp_text_end[];
+extern char __relocate_new_kernel_start[], __relocate_new_kernel_end[];
 
 #endif /* __ASM_SECTIONS_H */
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 679db3f1e0c5..361a4d082093 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -20,13 +20,10 @@
 #include <asm/mmu.h>
 #include <asm/mmu_context.h>
 #include <asm/page.h>
+#include <asm/sections.h>
 
 #include "cpu-reset.h"
 
-/* Global variables for the arm64_relocate_new_kernel routine. */
-extern const unsigned char arm64_relocate_new_kernel[];
-extern const unsigned long arm64_relocate_new_kernel_size;
-
 /**
  * kexec_image_info - For debugging output.
  */
@@ -78,13 +75,15 @@ int machine_kexec_post_load(struct kimage *kimage)
 {
 	void *reloc_code = page_to_virt(kimage->control_code_page);
 	struct kern_reloc_arg *kern_reloc_arg = kexec_page_alloc(kimage);
+	long func_offset, reloc_size;
 
 	if (!kern_reloc_arg)
 		return -ENOMEM;
 
-	memcpy(reloc_code, arm64_relocate_new_kernel,
-	       arm64_relocate_new_kernel_size);
-	kimage->arch.kern_reloc = __pa(reloc_code);
+	func_offset = arm64_relocate_new_kernel - __relocate_new_kernel_start;
+	reloc_size = __relocate_new_kernel_end - __relocate_new_kernel_start;
+	memcpy(reloc_code, __relocate_new_kernel_start, reloc_size);
+	kimage->arch.kern_reloc = __pa(reloc_code) + func_offset;
 	kimage->arch.kern_reloc_arg = __pa(kern_reloc_arg);
 	kern_reloc_arg->head = kimage->head;
 	kern_reloc_arg->entry_addr = kimage->start;
@@ -92,9 +91,9 @@ int machine_kexec_post_load(struct kimage *kimage)
 	kexec_image_info(kimage);
 
 	/* Flush the reloc_code in preparation for its execution. */
-	__flush_dcache_area(reloc_code, arm64_relocate_new_kernel_size);
+	__flush_dcache_area(reloc_code, reloc_size);
 	flush_icache_range((uintptr_t)reloc_code, (uintptr_t)reloc_code +
-			   arm64_relocate_new_kernel_size);
+			   reloc_size);
 	__flush_dcache_area(kern_reloc_arg, sizeof(struct kern_reloc_arg));
 
 	return 0;
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index c92228aeddca..d2a4a0b0d76b 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -14,6 +14,7 @@
 #include <asm/page.h>
 #include <asm/sysreg.h>
 
+.pushsection    ".kexec_relocate.text", "ax"
 /*
  * arm64_relocate_new_kernel - Put a 2nd stage image in place and boot it.
  *
@@ -75,16 +76,4 @@ SYM_CODE_START(arm64_relocate_new_kernel)
 	ldr	x0, [x0, #KEXEC_KRELOC_KERN_ARG0]	/* x0 = dtb address */
 	br	x4
 SYM_CODE_END(arm64_relocate_new_kernel)
-
-.align 3	/* To keep the 64-bit values below naturally aligned. */
-
-.Lcopy_end:
-.org	KEXEC_CONTROL_PAGE_SIZE
-
-/*
- * arm64_relocate_new_kernel_size - Number of bytes to copy to the
- * control_code_page.
- */
-.globl arm64_relocate_new_kernel_size
-arm64_relocate_new_kernel_size:
-	.quad	.Lcopy_end - arm64_relocate_new_kernel
+.popsection
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 4c0b0c89ad59..33b0d3c9fd3b 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -12,6 +12,7 @@
 #include <asm/cache.h>
 #include <asm/hyp_image.h>
 #include <asm/kernel-pgtable.h>
+#include <asm/kexec.h>
 #include <asm/memory.h>
 #include <asm/page.h>
 
@@ -82,6 +83,16 @@ jiffies = jiffies_64;
 #define HIBERNATE_TEXT
 #endif
 
+#ifdef CONFIG_KEXEC_CORE
+#define KEXEC_TEXT					\
+	. = ALIGN(SZ_4K);				\
+	__relocate_new_kernel_start = .;		\
+	*(.kexec_relocate.text)				\
+	__relocate_new_kernel_end = .;
+#else
+#define KEXEC_TEXT
+#endif
+
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 #define TRAMP_TEXT					\
 	. = ALIGN(PAGE_SIZE);				\
@@ -142,6 +153,7 @@ SECTIONS
 			HYPERVISOR_TEXT
 			IDMAP_TEXT
 			HIBERNATE_TEXT
+			KEXEC_TEXT
 			TRAMP_TEXT
 			*(.fixup)
 			*(.gnu.warning)
@@ -316,3 +328,10 @@ ASSERT((__entry_tramp_text_end - __entry_tramp_text_start) == PAGE_SIZE,
  * If padding is applied before .head.text, virt<->phys conversions will fail.
  */
 ASSERT(_text == KIMAGE_VADDR, "HEAD is misaligned")
+
+#ifdef CONFIG_KEXEC_CORE
+/* kexec relocation code should fit into one KEXEC_CONTROL_PAGE_SIZE */
+ASSERT(__relocate_new_kernel_end - (__relocate_new_kernel_start & ~(SZ_4K - 1))
+	<= SZ_4K, "kexec relocation code is too big or misaligned")
+ASSERT(KEXEC_CONTROL_PAGE_SIZE >= SZ_4K, "KEXEC_CONTROL_PAGE_SIZE is brokern")
+#endif
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
