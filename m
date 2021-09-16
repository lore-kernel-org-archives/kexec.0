Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mR0ZY-00CaAK-G6
 for kexec@lists.infradead.org; Thu, 16 Sep 2021 23:13:43 +0000
Received: by mail-qk1-x730.google.com with SMTP id t4so11633692qkb.9
 for <kexec@lists.infradead.org>; Thu, 16 Sep 2021 16:13:40 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v17 08/15] arm64: kexec: configure EL2 vectors for kexec
Date: Thu, 16 Sep 2021 19:13:18 -0400
Message-Id: <20210916231325.125533-9-pasha.tatashin@soleen.com>
In-Reply-To: <20210916231325.125533-1-pasha.tatashin@soleen.com>
References: <20210916231325.125533-1-pasha.tatashin@soleen.com>
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

If we have a EL2 mode without VHE, the EL2 vectors are needed in order
to switch to EL2 and jump to new world with hypervisor privileges.

In preparation to MMU enabled relocation, configure our EL2 table now.

Kexec uses #HVC_SOFT_RESTART to branch to the new world, so extend
el1_sync vector that is provided by trans_pgd_copy_el2_vectors() to
support this case.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/Kconfig                |  2 +-
 arch/arm64/include/asm/kexec.h    |  1 +
 arch/arm64/kernel/asm-offsets.c   |  1 +
 arch/arm64/kernel/machine_kexec.c | 31 +++++++++++++++++++++++++++++++
 arch/arm64/mm/trans_pgd-asm.S     |  9 ++++++++-
 5 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5c7ae4c3954b..552a057b40af 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1135,7 +1135,7 @@ config CRASH_DUMP
 
 config TRANS_TABLE
 	def_bool y
-	depends on HIBERNATION
+	depends on HIBERNATION || KEXEC_CORE
 
 config XEN_DOM0
 	def_bool y
diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 00dbcc71aeb2..753a1c398898 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -96,6 +96,7 @@ struct kimage_arch {
 	void *dtb;
 	phys_addr_t dtb_mem;
 	phys_addr_t kern_reloc;
+	phys_addr_t el2_vectors;
 };
 
 #ifdef CONFIG_KEXEC_FILE
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 1d3319c7518e..6a2b8b1a4872 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -174,6 +174,7 @@ int main(void)
 #endif
 #ifdef CONFIG_KEXEC_CORE
   DEFINE(KIMAGE_ARCH_DTB_MEM,		offsetof(struct kimage, arch.dtb_mem));
+  DEFINE(KIMAGE_ARCH_EL2_VECTORS,	offsetof(struct kimage, arch.el2_vectors));
   DEFINE(KIMAGE_HEAD,			offsetof(struct kimage, head));
   DEFINE(KIMAGE_START,			offsetof(struct kimage, start));
   BLANK();
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index e210b19592c6..59a4b4172b68 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -21,6 +21,7 @@
 #include <asm/mmu.h>
 #include <asm/mmu_context.h>
 #include <asm/page.h>
+#include <asm/trans_pgd.h>
 
 #include "cpu-reset.h"
 
@@ -43,7 +44,9 @@ static void _kexec_image_info(const char *func, int line,
 	pr_debug("    start:       %lx\n", kimage->start);
 	pr_debug("    head:        %lx\n", kimage->head);
 	pr_debug("    nr_segments: %lu\n", kimage->nr_segments);
+	pr_debug("    dtb_mem: %pa\n", &kimage->arch.dtb_mem);
 	pr_debug("    kern_reloc: %pa\n", &kimage->arch.kern_reloc);
+	pr_debug("    el2_vectors: %pa\n", &kimage->arch.el2_vectors);
 
 	for (i = 0; i < kimage->nr_segments; i++) {
 		pr_debug("      segment[%lu]: %016lx - %016lx, 0x%lx bytes, %lu pages\n",
@@ -143,9 +146,27 @@ static void kexec_segment_flush(const struct kimage *kimage)
 	}
 }
 
+/* Allocates pages for kexec page table */
+static void *kexec_page_alloc(void *arg)
+{
+	struct kimage *kimage = (struct kimage *)arg;
+	struct page *page = kimage_alloc_control_pages(kimage, 0);
+
+	if (!page)
+		return NULL;
+
+	memset(page_address(page), 0, PAGE_SIZE);
+
+	return page_address(page);
+}
+
 int machine_kexec_post_load(struct kimage *kimage)
 {
 	void *reloc_code = page_to_virt(kimage->control_code_page);
+	struct trans_pgd_info info = {
+		.trans_alloc_page	= kexec_page_alloc,
+		.trans_alloc_arg	= kimage,
+	};
 
 	/* If in place, relocation is not used, only flush next kernel */
 	if (kimage->head & IND_DONE) {
@@ -154,6 +175,14 @@ int machine_kexec_post_load(struct kimage *kimage)
 		return 0;
 	}
 
+	kimage->arch.el2_vectors = 0;
+	if (is_hyp_nvhe()) {
+		int rc = trans_pgd_copy_el2_vectors(&info,
+						    &kimage->arch.el2_vectors);
+		if (rc)
+			return rc;
+	}
+
 	memcpy(reloc_code, arm64_relocate_new_kernel,
 	       arm64_relocate_new_kernel_size);
 	kimage->arch.kern_reloc = __pa(reloc_code);
@@ -209,6 +238,8 @@ void machine_kexec(struct kimage *kimage)
 		restart(is_hyp_nvhe(), kimage->start, kimage->arch.dtb_mem,
 			0, 0);
 	} else {
+		if (is_hyp_nvhe())
+			__hyp_set_vectors(kimage->arch.el2_vectors);
 		cpu_soft_restart(kimage->arch.kern_reloc, virt_to_phys(kimage),
 				 0, 0);
 	}
diff --git a/arch/arm64/mm/trans_pgd-asm.S b/arch/arm64/mm/trans_pgd-asm.S
index 8c4bffe3089d..021c31573bcb 100644
--- a/arch/arm64/mm/trans_pgd-asm.S
+++ b/arch/arm64/mm/trans_pgd-asm.S
@@ -24,7 +24,14 @@ SYM_CODE_START_LOCAL(el1_sync)
 	msr	vbar_el2, x1
 	mov	x0, xzr
 	eret
-1:	/* Unexpected argument, set an error */
+1:	cmp	x0, #HVC_SOFT_RESTART	/* Called from kexec */
+	b.ne	2f
+	mov	x0, x2
+	mov	x2, x4
+	mov	x4, x1
+	mov	x1, x3
+	br	x4
+2:	/* Unexpected argument, set an error */
 	mov_q	x0, HVC_STUB_ERR
 	eret
 SYM_CODE_END(el1_sync)
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
