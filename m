Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hnQkx-00053t-En
 for kexec@lists.infradead.org; Tue, 16 Jul 2019 16:56:51 +0000
Received: by mail-qk1-x742.google.com with SMTP id r21so15174937qke.2
 for <kexec@lists.infradead.org>; Tue, 16 Jul 2019 09:56:47 -0700 (PDT)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [RFC v1 3/4] arm64, kexec: add kexec's own identity page table
Date: Tue, 16 Jul 2019 12:56:40 -0400
Message-Id: <20190716165641.6990-4-pasha.tatashin@soleen.com>
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

Allocate and configure identity page table to be used for kexec reboot.
Note, for now we still have MMU disabled during kernel relocation phase,
so this table is still used the same as idmap_pg_dir was used.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/machine_kexec.c | 78 ++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index f4565eb01d09..60433c264178 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -12,6 +12,7 @@
 #include <linux/kexec.h>
 #include <linux/page-flags.h>
 #include <linux/smp.h>
+#include <linux/memblock.h>
 
 #include <asm/cacheflush.h>
 #include <asm/cpu_ops.h>
@@ -20,6 +21,7 @@
 #include <asm/mmu.h>
 #include <asm/mmu_context.h>
 #include <asm/page.h>
+#include <asm/ident_map.h>
 
 #include "cpu-reset.h"
 
@@ -55,6 +57,77 @@ static void _kexec_image_info(const char *func, int line,
 	}
 }
 
+/* Allocates pages for kexec page table */
+static void *kexec_pgtable_alloc(void *arg)
+{
+	struct kimage *kimage = (struct kimage *)arg;
+	struct page *page = kimage_alloc_control_pages(kimage, 0);
+
+	if (!page)
+		return NULL;
+
+	return page_address(page);
+}
+
+/*
+ * Create identity mapped page table for kexec purposes. The flags that are used
+ * in this page table are the same as what is set in __create_page_tables. The
+ * page table is needed for performance reasons. Without it, kernel relocation
+ * is rather slow, because when MMU is off, d-caching is disabled as well.
+ */
+static int
+kexec_create_pgtable(struct kimage *kimage)
+{
+	void *pgd_page = kexec_pgtable_alloc(kimage);
+	phys_addr_t kexec_pgtable;
+	int rv, i;
+	struct memblock_region *reg;
+	struct ident_map_info info = {
+		.alloc_pgt_page	= kexec_pgtable_alloc,
+		.alloc_arg	= kimage,
+		.page_flags	= PMD_SECT_VALID | PMD_SECT_AF | PMD_SECT_S |
+				  PMD_ATTRINDX(MT_NORMAL),
+		.offset		= 0,
+		.pud_pages	= false,
+	};
+
+	if (!pgd_page)
+		return -ENOMEM;
+
+	clear_page(pgd_page);
+	kexec_pgtable = __pa(pgd_page);
+
+	for_each_memblock(memory, reg) {
+		phys_addr_t mstart = reg->base;
+		phys_addr_t mend   = reg->base + reg->size;
+
+		rv = ident_map_pgd_populate(&info, kexec_pgtable, mstart, mend);
+		if (rv)
+			return rv;
+	}
+
+	/*
+	 * It is possible new kernel knows of some physical addresses that this
+	 * kernel does not know: for example a different device tree might
+	 * provide information of a memory region, or memory could have been
+	 * reduced via mem= kernel parameter.
+	 * This is why also unconditionally map new kernel segments, even though
+	 * most likely this is redundant.
+	 */
+	for (i = 0; i < kimage->nr_segments; i++) {
+		phys_addr_t mstart = kimage->segment[i].mem;
+		phys_addr_t mend   = mstart + kimage->segment[i].memsz;
+
+		rv = ident_map_pgd_populate(&info, kexec_pgtable, mstart, mend);
+		if (rv)
+			return rv;
+	}
+
+	kimage->arch.kexec_pgtable = pgd_page;
+
+	return 0;
+}
+
 void machine_kexec_cleanup(struct kimage *kimage)
 {
 	/* Empty routine needed to avoid build errors. */
@@ -70,6 +143,7 @@ void machine_kexec_cleanup(struct kimage *kimage)
 int machine_kexec_prepare(struct kimage *kimage)
 {
 	void *reloc_buf = page_address(kimage->control_code_page);
+	int rv;
 
 	if (kimage->type != KEXEC_TYPE_CRASH && cpus_are_stuck_in_kernel()) {
 		pr_err("Can't kexec: CPUs are stuck in the kernel.\n");
@@ -84,10 +158,10 @@ int machine_kexec_prepare(struct kimage *kimage)
 	       arm64_relocate_new_kernel_size);
 
 	kimage->arch.relocate_kern = reloc_buf;
-	kimage->arch.kexec_pgtable = lm_alias(idmap_pg_dir);
+	rv = kexec_create_pgtable(kimage);
 	kexec_image_info(kimage);
 
-	return 0;
+	return rv;
 }
 
 /**
-- 
2.22.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
