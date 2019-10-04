Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iGShJ-0002Nr-MZ
 for kexec@lists.infradead.org; Fri, 04 Oct 2019 18:53:08 +0000
Received: by mail-qk1-x741.google.com with SMTP id x134so6791429qkb.0
 for <kexec@lists.infradead.org>; Fri, 04 Oct 2019 11:53:01 -0700 (PDT)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v6 16/17] arm64: kexec: configure trans_pgd page table for
 kexec
Date: Fri,  4 Oct 2019 14:52:33 -0400
Message-Id: <20191004185234.31471-17-pasha.tatashin@soleen.com>
In-Reply-To: <20191004185234.31471-1-pasha.tatashin@soleen.com>
References: <20191004185234.31471-1-pasha.tatashin@soleen.com>
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
To: pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com, james.morse@arm.com, vladimir.murzin@arm.com, matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org, mark.rutland@arm.com

Configure a page table located in kexec-safe memory that has
the following mappings:

1. identity mapping for text of relocation function with executable
   permission.
2. identity mapping for argument for relocation function.
3. linear mappings for all source ranges
4. linear mappings for all destination ranges.

Also, configure el2_vector, that is used to jump to new kernel from EL2 on
non-VHE kernels.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/kexec.h      |  32 +++++++
 arch/arm64/kernel/asm-offsets.c     |   6 ++
 arch/arm64/kernel/machine_kexec.c   | 125 ++++++++++++++++++++++++++--
 arch/arm64/kernel/relocate_kernel.S |  16 +++-
 4 files changed, 170 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index d5b79d4c7fae..450d8440f597 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -90,6 +90,23 @@ static inline void crash_prepare_suspend(void) {}
 static inline void crash_post_resume(void) {}
 #endif
 
+#if defined(CONFIG_KEXEC_CORE)
+/* Global variables for the arm64_relocate_new_kernel routine. */
+extern const unsigned char arm64_relocate_new_kernel[];
+extern const unsigned long arm64_relocate_new_kernel_size;
+
+/* Body of the vector for escalating to EL2 from relocation routine */
+extern const unsigned char kexec_el1_sync[];
+extern const unsigned long kexec_el1_sync_size;
+
+#define KEXEC_EL2_VECTOR_TABLE_SIZE	2048
+#define KEXEC_EL2_SYNC_OFFSET		(KEXEC_EL2_VECTOR_TABLE_SIZE / 2)
+
+#endif
+
+#define KEXEC_SRC_START	PAGE_OFFSET
+#define KEXEC_DST_START	(PAGE_OFFSET + \
+			((UL(0xffffffffffffffff) - PAGE_OFFSET) >> 1) + 1)
 /*
  * kern_reloc_arg is passed to kernel relocation function as an argument.
  * head		kimage->head, allows to traverse through relocation segments.
@@ -97,6 +114,15 @@ static inline void crash_post_resume(void) {}
  *		kernel, or purgatory entry address).
  * kern_arg0	first argument to kernel is its dtb address. The other
  *		arguments are currently unused, and must be set to 0
+ * trans_ttbr0	idmap for relocation function and its argument
+ * trans_ttbr1	linear map for source/destination addresses.
+ * el2_vector	If present means that relocation routine will go to EL1
+ *		from EL2 to do the copy, and then back to EL2 to do the jump
+ *		to new world. This vector contains only the final jump
+ *		instruction at KEXEC_EL2_SYNC_OFFSET.
+ * src_addr	linear map for source pages.
+ * dst_addr	linear map for destination pages.
+ * copy_len	Number of bytes that need to be copied
  */
 struct kern_reloc_arg {
 	unsigned long	head;
@@ -105,6 +131,12 @@ struct kern_reloc_arg {
 	unsigned long	kern_arg1;
 	unsigned long	kern_arg2;
 	unsigned long	kern_arg3;
+	unsigned long	trans_ttbr0;
+	unsigned long	trans_ttbr1;
+	unsigned long	el2_vector;
+	unsigned long	src_addr;
+	unsigned long	dst_addr;
+	unsigned long	copy_len;
 };
 
 #define ARCH_HAS_KIMAGE_ARCH
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 900394907fd8..7c2ba09a8ceb 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -135,6 +135,12 @@ int main(void)
   DEFINE(KRELOC_KERN_ARG1,	offsetof(struct kern_reloc_arg, kern_arg1));
   DEFINE(KRELOC_KERN_ARG2,	offsetof(struct kern_reloc_arg, kern_arg2));
   DEFINE(KRELOC_KERN_ARG3,	offsetof(struct kern_reloc_arg, kern_arg3));
+  DEFINE(KRELOC_TRANS_TTBR0,	offsetof(struct kern_reloc_arg, trans_ttbr0));
+  DEFINE(KRELOC_TRANS_TTBR1,	offsetof(struct kern_reloc_arg, trans_ttbr1));
+  DEFINE(KRELOC_EL2_VECTOR,	offsetof(struct kern_reloc_arg, el2_vector));
+  DEFINE(KRELOC_SRC_ADDR,	offsetof(struct kern_reloc_arg, src_addr));
+  DEFINE(KRELOC_DST_ADDR,	offsetof(struct kern_reloc_arg, dst_addr));
+  DEFINE(KRELOC_COPY_LEN,	offsetof(struct kern_reloc_arg, copy_len));
 #endif
   return 0;
 }
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index fb6138a1c9ff..71479013dd24 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -20,13 +20,10 @@
 #include <asm/mmu.h>
 #include <asm/mmu_context.h>
 #include <asm/page.h>
+#include <asm/trans_pgd.h>
 
 #include "cpu-reset.h"
 
-/* Global variables for the arm64_relocate_new_kernel routine. */
-extern const unsigned char arm64_relocate_new_kernel[];
-extern const unsigned long arm64_relocate_new_kernel_size;
-
 /**
  * kexec_image_info - For debugging output.
  */
@@ -74,15 +71,124 @@ static void *kexec_page_alloc(void *arg)
 	return page_address(page);
 }
 
+/*
+ * Map source segments starting from KEXEC_SRC_START, and map destination
+ * segments starting from KEXEC_DST_START, and return size of copy in
+ * *copy_len argument.
+ * Relocation function essentially needs to do:
+ * memcpy(KEXEC_DST_START, KEXEC_SRC_START, copy_len);
+ */
+static int map_segments(struct kimage *kimage, pgd_t *pgdp,
+			struct trans_pgd_info *info,
+			unsigned long *copy_len)
+{
+	unsigned long *ptr = 0;
+	unsigned long dest = 0;
+	unsigned long src_va = KEXEC_SRC_START;
+	unsigned long dst_va = KEXEC_DST_START;
+	unsigned long len = 0;
+	unsigned long entry, addr;
+	int rc;
+
+	for (entry = kimage->head; !(entry & IND_DONE); entry = *ptr++) {
+		addr = entry & PAGE_MASK;
+
+		switch (entry & IND_FLAGS) {
+		case IND_DESTINATION:
+			dest = addr;
+			break;
+		case IND_INDIRECTION:
+			ptr = __va(addr);
+			if (rc)
+				return rc;
+			break;
+		case IND_SOURCE:
+			rc = trans_pgd_map_page(info, pgdp, __va(addr),
+						src_va, PAGE_KERNEL);
+			if (rc)
+				return rc;
+			rc = trans_pgd_map_page(info, pgdp, __va(dest),
+						dst_va, PAGE_KERNEL);
+			if (rc)
+				return rc;
+			dest += PAGE_SIZE;
+			src_va += PAGE_SIZE;
+			dst_va += PAGE_SIZE;
+			len += PAGE_SIZE;
+		}
+	}
+	*copy_len = len;
+
+	return 0;
+}
+
+static int mmu_relocate_setup(struct kimage *kimage, unsigned long kern_reloc,
+			      struct kern_reloc_arg *kern_reloc_arg)
+{
+	struct trans_pgd_info info = {
+		.trans_alloc_page	= kexec_page_alloc,
+		.trans_alloc_arg	= kimage,
+	};
+
+	pgd_t *trans_ttbr0 = kexec_page_alloc(kimage);
+	pgd_t *trans_ttbr1 = kexec_page_alloc(kimage);
+	int rc;
+
+	if (!trans_ttbr0 || !trans_ttbr1)
+		return -ENOMEM;
+
+	rc = map_segments(kimage, trans_ttbr1, &info,
+			  &kern_reloc_arg->copy_len);
+	if (rc)
+		return rc;
+
+	/* Map relocation function va == pa */
+	rc = trans_pgd_map_page(&info, trans_ttbr0,  __va(kern_reloc),
+				kern_reloc, PAGE_KERNEL_EXEC);
+	if (rc)
+		return rc;
+
+	/* Map relocation function argument va == pa */
+	rc = trans_pgd_map_page(&info, trans_ttbr0, kern_reloc_arg,
+				__pa(kern_reloc_arg), PAGE_KERNEL);
+	if (rc)
+		return rc;
+
+	kern_reloc_arg->trans_ttbr0 = phys_to_ttbr(__pa(trans_ttbr0));
+	kern_reloc_arg->trans_ttbr1 = phys_to_ttbr(__pa(trans_ttbr1));
+	kern_reloc_arg->src_addr = KEXEC_SRC_START;
+	kern_reloc_arg->dst_addr = KEXEC_DST_START;
+
+	return 0;
+}
+
 int machine_kexec_post_load(struct kimage *kimage)
 {
+	unsigned long el2_vector = 0;
 	unsigned long kern_reloc;
 	struct kern_reloc_arg *kern_reloc_arg;
+	int rc = 0;
+
+	/*
+	 * Sanity check that relocation function + el2_vector fit into one
+	 * page.
+	 */
+	if (arm64_relocate_new_kernel_size > KEXEC_EL2_VECTOR_TABLE_SIZE) {
+		pr_err("can't fit relocation function and el2_vector in one page");
+		return -ENOMEM;
+	}
 
 	kern_reloc = page_to_phys(kimage->control_code_page);
 	memcpy(__va(kern_reloc), arm64_relocate_new_kernel,
 	       arm64_relocate_new_kernel_size);
 
+	/* Setup vector table only when EL2 is available, but no VHE */
+	if (is_hyp_mode_available() && !is_kernel_in_hyp_mode()) {
+		el2_vector = kern_reloc + KEXEC_EL2_VECTOR_TABLE_SIZE;
+		memcpy(__va(el2_vector + KEXEC_EL2_SYNC_OFFSET), kexec_el1_sync,
+		       kexec_el1_sync_size);
+	}
+
 	kern_reloc_arg = kexec_page_alloc(kimage);
 	if (!kern_reloc_arg)
 		return -ENOMEM;
@@ -92,10 +198,19 @@ int machine_kexec_post_load(struct kimage *kimage)
 
 	kern_reloc_arg->head = kimage->head;
 	kern_reloc_arg->entry_addr = kimage->start;
+	kern_reloc_arg->el2_vector = el2_vector;
 	kern_reloc_arg->kern_arg0 = kimage->arch.dtb_mem;
 
+	/*
+	 * If relocation is not needed, we do not need to enable MMU in
+	 * relocation routine, therefore do not create page tables for
+	 * scenarios such as crash kernel
+	 */
+	if (!(kimage->head & IND_DONE))
+		rc = mmu_relocate_setup(kimage, kern_reloc, kern_reloc_arg);
+
 	kexec_image_info(kimage);
-	return 0;
+	return rc;
 }
 
 /**
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index d352faf7cbe6..14243a678277 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -83,17 +83,25 @@ ENTRY(arm64_relocate_new_kernel)
 	ldr	x1, [x0, #KRELOC_KERN_ARG1]
 	ldr	x0, [x0, #KRELOC_KERN_ARG0]	/* x0 = dtb address */
 	br	x4
+.ltorg
+.Larm64_relocate_new_kernel_end:
 END(arm64_relocate_new_kernel)
 
-.ltorg
+ENTRY(kexec_el1_sync)
+	br	x4				/* Jump to new world from el2 */
+.Lkexec_el1_sync_end:
+END(kexec_el1_sync)
+
 .align 3	/* To keep the 64-bit values below naturally aligned. */
-.Lcopy_end:
 .org	KEXEC_CONTROL_PAGE_SIZE
-
 /*
  * arm64_relocate_new_kernel_size - Number of bytes to copy to the
  * control_code_page.
  */
 .globl arm64_relocate_new_kernel_size
 arm64_relocate_new_kernel_size:
-	.quad	.Lcopy_end - arm64_relocate_new_kernel
+	.quad	.Larm64_relocate_new_kernel_end - arm64_relocate_new_kernel
+
+.globl kexec_el1_sync_size
+kexec_el1_sync_size:
+	.quad	.Lkexec_el1_sync_end - kexec_el1_sync
-- 
2.23.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
