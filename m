Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hsqh3-0007qL-Jx
 for kexec@lists.infradead.org; Wed, 31 Jul 2019 15:39:13 +0000
Received: by mail-qt1-x844.google.com with SMTP id h21so66968636qtn.13
 for <kexec@lists.infradead.org>; Wed, 31 Jul 2019 08:39:09 -0700 (PDT)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [RFC v2 7/8] arm64, kexec: configure transitional page table for kexec
Date: Wed, 31 Jul 2019 11:38:56 -0400
Message-Id: <20190731153857.4045-8-pasha.tatashin@soleen.com>
In-Reply-To: <20190731153857.4045-1-pasha.tatashin@soleen.com>
References: <20190731153857.4045-1-pasha.tatashin@soleen.com>
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
To: pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com, james.morse@arm.com, vladimir.murzin@arm.com, matthias.bgg@gmail.com, bhsharma@redhat.com

Configure a page table located in kexec-safe memory that has
the following mappings:

1. mapping for text of relocation function with executable permission.
2. mapping for argument for relocation function.
3. mappings for all source ranges
4. mappings for all destination ranges.
5. mappings for array that contains information about source/destinations.

We could make this page table to contain liner addresses, but instead do
identity maps (va == pa) for every mapping. This is because the relocation
code can be executed at EV2, where ttbr1 might not be available. There is
no way to execute relocation code at EV1, because the old world is
overwritten and thus no place to trap to to escalator to EV2.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/kexec.h    |  3 +
 arch/arm64/kernel/asm-offsets.c   |  1 +
 arch/arm64/kernel/machine_kexec.c | 96 ++++++++++++++++++++++++++++++-
 3 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index d5b79d4c7fae..1f226cc76e24 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -97,6 +97,8 @@ static inline void crash_post_resume(void) {}
  *		kernel, or purgatory entry address).
  * kern_arg0	first argument to kernel is its dtb address. The other
  *		arguments are currently unused, and must be set to 0
+ * trans_table:	idmap for source and destination pages, as well as for
+ *		relocation text.
  */
 struct kern_reloc_arg {
 	unsigned long	head;
@@ -105,6 +107,7 @@ struct kern_reloc_arg {
 	unsigned long	kern_arg1;
 	unsigned long	kern_arg2;
 	unsigned long	kern_arg3;
+	unsigned long	trans_table;
 };
 
 #define ARCH_HAS_KIMAGE_ARCH
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 900394907fd8..002db58b28f3 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -135,6 +135,7 @@ int main(void)
   DEFINE(KRELOC_KERN_ARG1,	offsetof(struct kern_reloc_arg, kern_arg1));
   DEFINE(KRELOC_KERN_ARG2,	offsetof(struct kern_reloc_arg, kern_arg2));
   DEFINE(KRELOC_KERN_ARG3,	offsetof(struct kern_reloc_arg, kern_arg3));
+  DEFINE(KRELOC_TRANS_TABLE,	offsetof(struct kern_reloc_arg, trans_table));
 #endif
   return 0;
 }
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index d7291a663379..402c8fb48f7e 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -20,6 +20,7 @@
 #include <asm/mmu.h>
 #include <asm/mmu_context.h>
 #include <asm/page.h>
+#include <asm/trans_table.h>
 
 #include "cpu-reset.h"
 
@@ -72,11 +73,96 @@ static void *kexec_page_alloc(void *arg)
 	return page_address(page);
 }
 
+/*
+ * idmap every segment that needs to be relocated. We map pages for
+ * destination, source, and also array that holds source, and destination
+ * addresses.
+ * Ideally, we could linearly map src and dst addresses, so, in relocation
+ * routine we would need to only do memcpy(dst, src, len), but this is not
+ * possible, because on armv8.0 EL2 does not have ttbr1, and thus we might
+ * not have enough linear VA range. So, simply idmap it here, that works
+ * for both EL1, and EL2. Note: we cannot really do relocation in EL1 and
+ * later upgrade to EL2 because old world is erased, so there is no where
+ * to trap.
+ */
+static int map_segments(struct kimage *kimage, pgd_t *pgdp,
+			struct trans_table_info *info)
+{
+	unsigned long *ptr = 0;
+	unsigned long dest = 0;
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
+			rc = trans_table_map_page(info, pgdp, ptr,
+						  addr, PAGE_KERNEL);
+			if (rc)
+				return rc;
+			break;
+		case IND_SOURCE:
+			rc = trans_table_map_page(info, pgdp, __va(addr),
+						  addr, PAGE_KERNEL);
+			if (rc)
+				return rc;
+			rc = trans_table_map_page(info, pgdp, __va(dest),
+						  dest, PAGE_KERNEL);
+			if (rc)
+				return rc;
+			dest += PAGE_SIZE;
+		}
+	}
+	return 0;
+}
+
+static int mmu_relocate_setup(struct kimage *kimage, unsigned long kern_reloc,
+			      struct kern_reloc_arg *kern_reloc_arg)
+{
+	struct trans_table_info info = {
+		.trans_alloc_page	= kexec_page_alloc,
+		.trans_alloc_arg	= kimage,
+		.trans_flags		= 0,
+	};
+	pgd_t *trans_table;
+	int rc;
+
+	rc = trans_table_create_empty(&info, &trans_table);
+	if (rc)
+		return rc;
+
+	rc = map_segments(kimage, trans_table, &info);
+	if (rc)
+		return rc;
+
+	/* Map relocation function va == pa */
+	rc = trans_table_map_page(&info, trans_table,  __va(kern_reloc),
+				  kern_reloc, PAGE_KERNEL_EXEC);
+	if (rc)
+		return rc;
+
+	/* Map relocation function argument va == pa */
+	rc = trans_table_map_page(&info, trans_table, kern_reloc_arg,
+				  __pa(kern_reloc_arg), PAGE_KERNEL);
+	if (rc)
+		return rc;
+
+	kern_reloc_arg->trans_table = __pa(trans_table);
+
+	return 0;
+}
 
 int machine_kexec_post_load(struct kimage *kimage)
 {
 	unsigned long kern_reloc;
 	struct kern_reloc_arg *kern_reloc_arg;
+	int rc = 0;
 
 	kern_reloc = page_to_phys(kimage->control_code_page);
 	memcpy(__va(kern_reloc), arm64_relocate_new_kernel,
@@ -94,8 +180,16 @@ int machine_kexec_post_load(struct kimage *kimage)
 	kern_reloc_arg->entry_addr = kimage->start;
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
-- 
2.22.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
