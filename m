Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hnQkx-00053S-AB
 for kexec@lists.infradead.org; Tue, 16 Jul 2019 16:56:50 +0000
Received: by mail-qt1-x843.google.com with SMTP id z4so20327002qtc.3
 for <kexec@lists.infradead.org>; Tue, 16 Jul 2019 09:56:46 -0700 (PDT)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [RFC v1 2/4] arm64, kexec: interface preparation for mmu enabled kexec
Date: Tue, 16 Jul 2019 12:56:39 -0400
Message-Id: <20190716165641.6990-3-pasha.tatashin@soleen.com>
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

Currently cpu_install_idmap() is used to install page table during kexec
switch over to purgatory. We soon will be using our own page table, that
maps the whole physical range (and might be even more, i.e if new DTB
describes a bigger physical range or mem= parameter limited physical
range in the current kernel).

Make kimage_arch to be always part of arm64.
Add relocate_kern and kexec_pgtable verctors to this struct, as we won't
be able to rely on a single control page anymore.

Copy relocation function in machine_kexec_prepare(), and setup page
table there as well (for now idmap_pg_dir).

Cleanup call to cpu_soft_restart by removing ugly ifdefs. When
kimage->arch.dtb_mem is not set, it is 0 anyway.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/kexec.h    |  5 +--
 arch/arm64/kernel/cpu-reset.h     |  7 ++++-
 arch/arm64/kernel/machine_kexec.c | 52 ++++++++++++++-----------------
 3 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 12a561a54128..ef2d2442b890 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -90,14 +90,15 @@ static inline void crash_prepare_suspend(void) {}
 static inline void crash_post_resume(void) {}
 #endif
 
-#ifdef CONFIG_KEXEC_FILE
 #define ARCH_HAS_KIMAGE_ARCH
-
 struct kimage_arch {
 	void *dtb;
 	unsigned long dtb_mem;
+	void  *relocate_kern;
+	pgd_t *kexec_pgtable;
 };
 
+#ifdef CONFIG_KEXEC_FILE
 extern const struct kexec_file_ops kexec_image_ops;
 
 struct kimage;
diff --git a/arch/arm64/kernel/cpu-reset.h b/arch/arm64/kernel/cpu-reset.h
index ed50e9587ad8..c795811587f0 100644
--- a/arch/arm64/kernel/cpu-reset.h
+++ b/arch/arm64/kernel/cpu-reset.h
@@ -14,6 +14,7 @@ void __cpu_soft_restart(unsigned long el2_switch, unsigned long entry,
 	unsigned long arg0, unsigned long arg1, unsigned long arg2);
 
 static inline void __noreturn cpu_soft_restart(unsigned long entry,
+					       pgd_t *kexec_pgtable,
 					       unsigned long arg0,
 					       unsigned long arg1,
 					       unsigned long arg2)
@@ -24,7 +25,11 @@ static inline void __noreturn cpu_soft_restart(unsigned long entry,
 		is_hyp_mode_available();
 	restart = (void *)__pa_symbol(__cpu_soft_restart);
 
-	cpu_install_idmap();
+	cpu_set_reserved_ttbr0();
+	local_flush_tlb_all();
+	write_sysreg(phys_to_ttbr(virt_to_phys(kexec_pgtable)), ttbr0_el1);
+	isb();
+
 	restart(el2_switch, entry, arg0, arg1, arg2);
 	unreachable();
 }
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 0df8493624e0..f4565eb01d09 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -42,6 +42,8 @@ static void _kexec_image_info(const char *func, int line,
 	pr_debug("    start:       %lx\n", kimage->start);
 	pr_debug("    head:        %lx\n", kimage->head);
 	pr_debug("    nr_segments: %lu\n", kimage->nr_segments);
+	pr_debug("    arch.kexec_pgtable: %p\n", kimage->arch.kexec_pgtable);
+	pr_debug("    arch.relocate_kern: %p\n", kimage->arch.relocate_kern);
 
 	for (i = 0; i < kimage->nr_segments; i++) {
 		pr_debug("      segment[%lu]: %016lx - %016lx, 0x%lx bytes, %lu pages\n",
@@ -67,13 +69,24 @@ void machine_kexec_cleanup(struct kimage *kimage)
  */
 int machine_kexec_prepare(struct kimage *kimage)
 {
-	kexec_image_info(kimage);
+	void *reloc_buf = page_address(kimage->control_code_page);
 
 	if (kimage->type != KEXEC_TYPE_CRASH && cpus_are_stuck_in_kernel()) {
 		pr_err("Can't kexec: CPUs are stuck in the kernel.\n");
 		return -EBUSY;
 	}
 
+	/*
+	 * Copy arm64_relocate_new_kernel to the buffer for use after the kernel
+	 * is shut down.
+	 */
+	memcpy(reloc_buf, arm64_relocate_new_kernel,
+	       arm64_relocate_new_kernel_size);
+
+	kimage->arch.relocate_kern = reloc_buf;
+	kimage->arch.kexec_pgtable = lm_alias(idmap_pg_dir);
+	kexec_image_info(kimage);
+
 	return 0;
 }
 
@@ -143,8 +156,6 @@ static void kexec_segment_flush(const struct kimage *kimage)
  */
 void machine_kexec(struct kimage *kimage)
 {
-	phys_addr_t reboot_code_buffer_phys;
-	void *reboot_code_buffer;
 	bool in_kexec_crash = (kimage == kexec_crash_image);
 	bool stuck_cpus = cpus_are_stuck_in_kernel();
 
@@ -155,32 +166,17 @@ void machine_kexec(struct kimage *kimage)
 	WARN(in_kexec_crash && (stuck_cpus || smp_crash_stop_failed()),
 		"Some CPUs may be stale, kdump will be unreliable.\n");
 
-	reboot_code_buffer_phys = page_to_phys(kimage->control_code_page);
-	reboot_code_buffer = phys_to_virt(reboot_code_buffer_phys);
-
 	kexec_image_info(kimage);
-
-	pr_debug("%s:%d: control_code_page:        %p\n", __func__, __LINE__,
-		kimage->control_code_page);
-	pr_debug("%s:%d: reboot_code_buffer_phys:  %pa\n", __func__, __LINE__,
-		&reboot_code_buffer_phys);
-	pr_debug("%s:%d: reboot_code_buffer:       %p\n", __func__, __LINE__,
-		reboot_code_buffer);
 	pr_debug("%s:%d: relocate_new_kernel:      %p\n", __func__, __LINE__,
 		arm64_relocate_new_kernel);
 	pr_debug("%s:%d: relocate_new_kernel_size: 0x%lx(%lu) bytes\n",
 		__func__, __LINE__, arm64_relocate_new_kernel_size,
 		arm64_relocate_new_kernel_size);
 
-	/*
-	 * Copy arm64_relocate_new_kernel to the reboot_code_buffer for use
-	 * after the kernel is shut down.
-	 */
-	memcpy(reboot_code_buffer, arm64_relocate_new_kernel,
-		arm64_relocate_new_kernel_size);
 
-	/* Flush the reboot_code_buffer in preparation for its execution. */
-	__flush_dcache_area(reboot_code_buffer, arm64_relocate_new_kernel_size);
+	/* Flush the relocate_kern in preparation for its execution. */
+	__flush_dcache_area(kimage->arch.relocate_kern,
+			    arm64_relocate_new_kernel_size);
 
 	/*
 	 * Although we've killed off the secondary CPUs, we don't update
@@ -188,7 +184,7 @@ void machine_kexec(struct kimage *kimage)
 	 * need to avoid flush_icache_range(), which will attempt to IPI
 	 * the offline CPUs. Therefore, we must use the __* variant here.
 	 */
-	__flush_icache_range((uintptr_t)reboot_code_buffer,
+	__flush_icache_range((uintptr_t)kimage->arch.relocate_kern,
 			     arm64_relocate_new_kernel_size);
 
 	/* Flush the kimage list and its buffers. */
@@ -204,7 +200,7 @@ void machine_kexec(struct kimage *kimage)
 
 	/*
 	 * cpu_soft_restart will shutdown the MMU, disable data caches, then
-	 * transfer control to the reboot_code_buffer which contains a copy of
+	 * transfer control to the relocate_kern which contains a copy of
 	 * the arm64_relocate_new_kernel routine.  arm64_relocate_new_kernel
 	 * uses physical addressing to relocate the new image to its final
 	 * position and transfers control to the image entry point when the
@@ -214,12 +210,10 @@ void machine_kexec(struct kimage *kimage)
 	 * userspace (kexec-tools).
 	 * In kexec_file case, the kernel starts directly without purgatory.
 	 */
-	cpu_soft_restart(reboot_code_buffer_phys, kimage->head, kimage->start,
-#ifdef CONFIG_KEXEC_FILE
-						kimage->arch.dtb_mem);
-#else
-						0);
-#endif
+	cpu_soft_restart(__pa(kimage->arch.relocate_kern),
+			 kimage->arch.kexec_pgtable,
+			 kimage->head, kimage->start,
+			 kimage->arch.dtb_mem);
 
 	BUG(); /* Should never get here. */
 }
-- 
2.22.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
