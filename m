Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4ob8-0005rV-Q4
 for kexec@lists.infradead.org; Wed, 27 Jan 2021 17:27:33 +0000
Received: by mail-qt1-x82a.google.com with SMTP id z6so1992287qtn.0
 for <kexec@lists.infradead.org>; Wed, 27 Jan 2021 09:27:17 -0800 (PST)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v11 4/6] arm64: kexec: configure trans_pgd page table for kexec
Date: Wed, 27 Jan 2021 12:27:04 -0500
Message-Id: <20210127172706.617195-5-pasha.tatashin@soleen.com>
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

Configure a page table located in kexec-safe memory that has
the following mappings:

1. identity mapping for text of relocation function with executable
   permission.
2. va mappings for all source ranges
3. va mappings for all destination ranges.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/Kconfig                |  2 +-
 arch/arm64/include/asm/kexec.h    | 12 +++++
 arch/arm64/kernel/asm-offsets.c   |  6 +++
 arch/arm64/kernel/machine_kexec.c | 89 ++++++++++++++++++++++++++++++-
 4 files changed, 107 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fc0ed9d6e011..440abd0c0ee1 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1134,7 +1134,7 @@ config CRASH_DUMP
 
 config TRANS_TABLE
 	def_bool y
-	depends on HIBERNATION
+	depends on HIBERNATION || KEXEC_CORE
 
 config XEN_DOM0
 	def_bool y
diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index b96d8a6aac80..049cde429b1b 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -105,6 +105,12 @@ extern const char arm64_kexec_el2_vectors[];
  * el2_vector	If present means that relocation routine will go to EL1
  *		from EL2 to do the copy, and then back to EL2 to do the jump
  *		to new world.
+ * trans_ttbr0	idmap for relocation function and its argument
+ * trans_ttbr1	map for source/destination addresses.
+ * trans_t0sz	t0sz for idmap page in trans_ttbr0
+ * src_addr	start address for source pages.
+ * dst_addr	start address for destination pages.
+ * copy_len	Number of bytes that need to be copied
  */
 struct kern_reloc_arg {
 	phys_addr_t head;
@@ -114,6 +120,12 @@ struct kern_reloc_arg {
 	phys_addr_t kern_arg2;
 	phys_addr_t kern_arg3;
 	phys_addr_t el2_vector;
+	phys_addr_t trans_ttbr0;
+	phys_addr_t trans_ttbr1;
+	unsigned long trans_t0sz;
+	unsigned long src_addr;
+	unsigned long dst_addr;
+	unsigned long copy_len;
 };
 
 #define ARCH_HAS_KIMAGE_ARCH
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 8a9475be1b62..06278611451d 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -160,6 +160,12 @@ int main(void)
   DEFINE(KEXEC_KRELOC_KERN_ARG2,	offsetof(struct kern_reloc_arg, kern_arg2));
   DEFINE(KEXEC_KRELOC_KERN_ARG3,	offsetof(struct kern_reloc_arg, kern_arg3));
   DEFINE(KEXEC_KRELOC_EL2_VECTOR,	offsetof(struct kern_reloc_arg, el2_vector));
+  DEFINE(KEXEC_KRELOC_TRANS_TTBR0,	offsetof(struct kern_reloc_arg, trans_ttbr0));
+  DEFINE(KEXEC_KRELOC_TRANS_TTBR1,	offsetof(struct kern_reloc_arg, trans_ttbr1));
+  DEFINE(KEXEC_KRELOC_TRANS_T0SZ,	offsetof(struct kern_reloc_arg, trans_t0sz));
+  DEFINE(KEXEC_KRELOC_SRC_ADDR,	offsetof(struct kern_reloc_arg, src_addr));
+  DEFINE(KEXEC_KRELOC_DST_ADDR,	offsetof(struct kern_reloc_arg, dst_addr));
+  DEFINE(KEXEC_KRELOC_COPY_LEN,	offsetof(struct kern_reloc_arg, copy_len));
 #endif
   return 0;
 }
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 41d1e3ca13f8..9588c91f67c6 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -21,6 +21,7 @@
 #include <asm/mmu_context.h>
 #include <asm/page.h>
 #include <asm/sections.h>
+#include <asm/trans_pgd.h>
 
 #include "cpu-reset.h"
 
@@ -71,11 +72,89 @@ static void *kexec_page_alloc(void *arg)
 	return page_address(page);
 }
 
+/*
+ * Map source segments starting from src_va, and map destination
+ * segments starting from dst_va, and return size of copy in
+ * *copy_len argument.
+ * Relocation function essentially needs to do:
+ * memcpy(dst_va, src_va, copy_len);
+ */
+static int map_segments(struct kimage *kimage, pgd_t *pgdp,
+			struct trans_pgd_info *info,
+			unsigned long src_va,
+			unsigned long dst_va,
+			unsigned long *copy_len)
+{
+	unsigned long *ptr = 0;
+	unsigned long dest = 0;
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
+static int mmu_relocate_setup(struct kimage *kimage, void *reloc_code,
+			      struct kern_reloc_arg *kern_reloc_arg)
+{
+	struct trans_pgd_info info = {
+		.trans_alloc_page	= kexec_page_alloc,
+		.trans_alloc_arg	= kimage,
+	};
+	pgd_t *trans_pgd = kexec_page_alloc(kimage);
+	int rc;
+
+	if (!trans_pgd)
+		return -ENOMEM;
+
+	/* idmap relocation function */
+	rc = trans_pgd_idmap_page(&info, &kern_reloc_arg->trans_ttbr0,
+				  &kern_reloc_arg->trans_t0sz, reloc_code);
+	if (rc)
+		return rc;
+
+	kern_reloc_arg->src_addr = _PAGE_OFFSET(VA_BITS_MIN);
+	kern_reloc_arg->dst_addr = _PAGE_OFFSET(VA_BITS_MIN - 1);
+	kern_reloc_arg->trans_ttbr1 = phys_to_ttbr(__pa(trans_pgd));
+
+	rc = map_segments(kimage, trans_pgd, &info, kern_reloc_arg->src_addr,
+			  kern_reloc_arg->dst_addr, &kern_reloc_arg->copy_len);
+	return rc;
+}
+
 int machine_kexec_post_load(struct kimage *kimage)
 {
 	void *reloc_code = page_to_virt(kimage->control_code_page);
 	struct kern_reloc_arg *kern_reloc_arg = kexec_page_alloc(kimage);
 	long func_offset, vector_offset, reloc_size;
+	int rc = 0;
 
 	if (!kern_reloc_arg)
 		return -ENOMEM;
@@ -95,6 +174,14 @@ int machine_kexec_post_load(struct kimage *kimage)
 	if (is_hyp_mode_available() && !is_kernel_in_hyp_mode())
 		kern_reloc_arg->el2_vector = __pa(reloc_code) + vector_offset;
 
+	/*
+	 * If relocation is not needed, we do not need to enable MMU in
+	 * relocation routine, therefore do not create page tables for
+	 * scenarios such as crash kernel
+	 */
+	if (!(kimage->head & IND_DONE))
+		rc = mmu_relocate_setup(kimage, reloc_code, kern_reloc_arg);
+
 	kexec_image_info(kimage);
 
 	/* Flush the reloc_code in preparation for its execution. */
@@ -103,7 +190,7 @@ int machine_kexec_post_load(struct kimage *kimage)
 			   reloc_size);
 	__flush_dcache_area(kern_reloc_arg, sizeof(struct kern_reloc_arg));
 
-	return 0;
+	return rc;
 }
 
 /**
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
