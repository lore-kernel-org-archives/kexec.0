Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn1nam07on2062.outbound.protection.outlook.com
 ([40.107.212.62] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mEaXx-00DBUl-67
 for kexec@lists.infradead.org; Fri, 13 Aug 2021 17:00:44 +0000
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v2 06/12] x86/sev: Replace occurrences of sev_active() with
 prot_guest_has()
Date: Fri, 13 Aug 2021 11:59:25 -0500
Message-Id: <2b3a8fc4659f2e7617399cecdcca549e0fa1dcb7.1628873970.git.thomas.lendacky@amd.com>
In-Reply-To: <cover.1628873970.git.thomas.lendacky@amd.com>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
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
To: linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>, Brijesh Singh <brijesh.singh@amd.com>, Joerg Roedel <joro@8bytes.org>, Andi Kleen <ak@linux.intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Joerg Roedel <jroedel@suse.de>

Replace occurrences of sev_active() with the more generic prot_guest_has()
using PATTR_GUEST_MEM_ENCRYPT, except for in arch/x86/mm/mem_encrypt*.c
where PATTR_SEV will be used. If future support is added for other memory
encryption technologies, the use of PATTR_GUEST_MEM_ENCRYPT can be
updated, as required, to use PATTR_SEV.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/mem_encrypt.h |  2 --
 arch/x86/kernel/crash_dump_64.c    |  4 +++-
 arch/x86/kernel/kvm.c              |  3 ++-
 arch/x86/kernel/kvmclock.c         |  4 ++--
 arch/x86/kernel/machine_kexec_64.c | 16 ++++++++--------
 arch/x86/kvm/svm/svm.c             |  3 ++-
 arch/x86/mm/ioremap.c              |  6 +++---
 arch/x86/mm/mem_encrypt.c          | 15 +++++++--------
 arch/x86/platform/efi/efi_64.c     |  9 +++++----
 9 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 956338406cec..7e25de37c148 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -50,7 +50,6 @@ void __init mem_encrypt_free_decrypted_mem(void);
 void __init mem_encrypt_init(void);
 
 void __init sev_es_init_vc_handling(void);
-bool sev_active(void);
 bool sev_es_active(void);
 bool amd_prot_guest_has(unsigned int attr);
 
@@ -75,7 +74,6 @@ static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
 static inline void __init sme_enable(struct boot_params *bp) { }
 
 static inline void sev_es_init_vc_handling(void) { }
-static inline bool sev_active(void) { return false; }
 static inline bool sev_es_active(void) { return false; }
 static inline bool amd_prot_guest_has(unsigned int attr) { return false; }
 
diff --git a/arch/x86/kernel/crash_dump_64.c b/arch/x86/kernel/crash_dump_64.c
index 045e82e8945b..0cfe35f03e67 100644
--- a/arch/x86/kernel/crash_dump_64.c
+++ b/arch/x86/kernel/crash_dump_64.c
@@ -10,6 +10,7 @@
 #include <linux/crash_dump.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
+#include <linux/protected_guest.h>
 
 static ssize_t __copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
 				  unsigned long offset, int userbuf,
@@ -73,5 +74,6 @@ ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf, size_t csize,
 
 ssize_t elfcorehdr_read(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0, sev_active());
+	return read_from_oldmem(buf, count, ppos, 0,
+				prot_guest_has(PATTR_GUEST_MEM_ENCRYPT));
 }
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index a26643dc6bd6..9d08ad2f3faa 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -27,6 +27,7 @@
 #include <linux/nmi.h>
 #include <linux/swait.h>
 #include <linux/syscore_ops.h>
+#include <linux/protected_guest.h>
 #include <asm/timer.h>
 #include <asm/cpu.h>
 #include <asm/traps.h>
@@ -418,7 +419,7 @@ static void __init sev_map_percpu_data(void)
 {
 	int cpu;
 
-	if (!sev_active())
+	if (!prot_guest_has(PATTR_GUEST_MEM_ENCRYPT))
 		return;
 
 	for_each_possible_cpu(cpu) {
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index ad273e5861c1..f7ba78a23dcd 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -16,9 +16,9 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/set_memory.h>
+#include <linux/protected_guest.h>
 
 #include <asm/hypervisor.h>
-#include <asm/mem_encrypt.h>
 #include <asm/x86_init.h>
 #include <asm/kvmclock.h>
 
@@ -232,7 +232,7 @@ static void __init kvmclock_init_mem(void)
 	 * hvclock is shared between the guest and the hypervisor, must
 	 * be mapped decrypted.
 	 */
-	if (sev_active()) {
+	if (prot_guest_has(PATTR_GUEST_MEM_ENCRYPT)) {
 		r = set_memory_decrypted((unsigned long) hvclock_mem,
 					 1UL << order);
 		if (r) {
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 8e7b517ad738..66ff788b79c9 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -167,7 +167,7 @@ static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
 	}
 	pte = pte_offset_kernel(pmd, vaddr);
 
-	if (sev_active())
+	if (prot_guest_has(PATTR_GUEST_MEM_ENCRYPT))
 		prot = PAGE_KERNEL_EXEC;
 
 	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, prot));
@@ -207,7 +207,7 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 	level4p = (pgd_t *)__va(start_pgtable);
 	clear_page(level4p);
 
-	if (sev_active()) {
+	if (prot_guest_has(PATTR_GUEST_MEM_ENCRYPT)) {
 		info.page_flag   |= _PAGE_ENC;
 		info.kernpg_flag |= _PAGE_ENC;
 	}
@@ -570,12 +570,12 @@ void arch_kexec_unprotect_crashkres(void)
  */
 int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, gfp_t gfp)
 {
-	if (sev_active())
+	if (!prot_guest_has(PATTR_HOST_MEM_ENCRYPT))
 		return 0;
 
 	/*
-	 * If SME is active we need to be sure that kexec pages are
-	 * not encrypted because when we boot to the new kernel the
+	 * If host memory encryption is active we need to be sure that kexec
+	 * pages are not encrypted because when we boot to the new kernel the
 	 * pages won't be accessed encrypted (initially).
 	 */
 	return set_memory_decrypted((unsigned long)vaddr, pages);
@@ -583,12 +583,12 @@ int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, gfp_t gfp)
 
 void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages)
 {
-	if (sev_active())
+	if (!prot_guest_has(PATTR_HOST_MEM_ENCRYPT))
 		return;
 
 	/*
-	 * If SME is active we need to reset the pages back to being
-	 * an encrypted mapping before freeing them.
+	 * If host memory encryption is active we need to reset the pages back
+	 * to being an encrypted mapping before freeing them.
 	 */
 	set_memory_encrypted((unsigned long)vaddr, pages);
 }
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e8ccab50ebf6..b69f5ac622d5 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -25,6 +25,7 @@
 #include <linux/pagemap.h>
 #include <linux/swap.h>
 #include <linux/rwsem.h>
+#include <linux/protected_guest.h>
 
 #include <asm/apic.h>
 #include <asm/perf_event.h>
@@ -457,7 +458,7 @@ static int has_svm(void)
 		return 0;
 	}
 
-	if (sev_active()) {
+	if (prot_guest_has(PATTR_SEV)) {
 		pr_info("KVM is unsupported when running as an SEV guest\n");
 		return 0;
 	}
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 583afd54c7e1..3ed0f28f12af 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -92,7 +92,7 @@ static unsigned int __ioremap_check_ram(struct resource *res)
  */
 static unsigned int __ioremap_check_encrypted(struct resource *res)
 {
-	if (!sev_active())
+	if (!prot_guest_has(PATTR_GUEST_MEM_ENCRYPT))
 		return 0;
 
 	switch (res->desc) {
@@ -112,7 +112,7 @@ static unsigned int __ioremap_check_encrypted(struct resource *res)
  */
 static void __ioremap_check_other(resource_size_t addr, struct ioremap_desc *desc)
 {
-	if (!sev_active())
+	if (!prot_guest_has(PATTR_GUEST_MEM_ENCRYPT))
 		return;
 
 	if (!IS_ENABLED(CONFIG_EFI))
@@ -556,7 +556,7 @@ static bool memremap_should_map_decrypted(resource_size_t phys_addr,
 	case E820_TYPE_NVS:
 	case E820_TYPE_UNUSABLE:
 		/* For SEV, these areas are encrypted */
-		if (sev_active())
+		if (prot_guest_has(PATTR_GUEST_MEM_ENCRYPT))
 			break;
 		fallthrough;
 
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 5635ca9a1fbe..83bc928f529e 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -194,7 +194,7 @@ void __init sme_early_init(void)
 	for (i = 0; i < ARRAY_SIZE(protection_map); i++)
 		protection_map[i] = pgprot_encrypted(protection_map[i]);
 
-	if (sev_active())
+	if (amd_prot_guest_has(PATTR_SEV))
 		swiotlb_force = SWIOTLB_FORCE;
 }
 
@@ -203,7 +203,7 @@ void __init sev_setup_arch(void)
 	phys_addr_t total_mem = memblock_phys_mem_size();
 	unsigned long size;
 
-	if (!sev_active())
+	if (!amd_prot_guest_has(PATTR_SEV))
 		return;
 
 	/*
@@ -373,7 +373,7 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size)
  * up under SME the trampoline area cannot be encrypted, whereas under SEV
  * the trampoline area must be encrypted.
  */
-bool sev_active(void)
+static bool sev_active(void)
 {
 	return sev_status & MSR_AMD64_SEV_ENABLED;
 }
@@ -382,7 +382,6 @@ static bool sme_active(void)
 {
 	return sme_me_mask && !sev_active();
 }
-EXPORT_SYMBOL_GPL(sev_active);
 
 /* Needs to be called from non-instrumentable code */
 bool noinstr sev_es_active(void)
@@ -420,7 +419,7 @@ bool force_dma_unencrypted(struct device *dev)
 	/*
 	 * For SEV, all DMA must be to unencrypted addresses.
 	 */
-	if (sev_active())
+	if (amd_prot_guest_has(PATTR_SEV))
 		return true;
 
 	/*
@@ -479,7 +478,7 @@ static void print_mem_encrypt_feature_info(void)
 	}
 
 	/* Secure Encrypted Virtualization */
-	if (sev_active())
+	if (amd_prot_guest_has(PATTR_SEV))
 		pr_cont(" SEV");
 
 	/* Encrypted Register State */
@@ -502,7 +501,7 @@ void __init mem_encrypt_init(void)
 	 * With SEV, we need to unroll the rep string I/O instructions,
 	 * but SEV-ES supports them through the #VC handler.
 	 */
-	if (sev_active() && !sev_es_active())
+	if (amd_prot_guest_has(PATTR_SEV) && !sev_es_active())
 		static_branch_enable(&sev_enable_key);
 
 	print_mem_encrypt_feature_info();
@@ -510,6 +509,6 @@ void __init mem_encrypt_init(void)
 
 int arch_has_restricted_virtio_memory_access(void)
 {
-	return sev_active();
+	return amd_prot_guest_has(PATTR_SEV);
 }
 EXPORT_SYMBOL_GPL(arch_has_restricted_virtio_memory_access);
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 7515e78ef898..94737fcc1e21 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -33,7 +33,7 @@
 #include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/ucs2_string.h>
-#include <linux/mem_encrypt.h>
+#include <linux/protected_guest.h>
 #include <linux/sched/task.h>
 
 #include <asm/setup.h>
@@ -284,7 +284,8 @@ static void __init __map_region(efi_memory_desc_t *md, u64 va)
 	if (!(md->attribute & EFI_MEMORY_WB))
 		flags |= _PAGE_PCD;
 
-	if (sev_active() && md->type != EFI_MEMORY_MAPPED_IO)
+	if (prot_guest_has(PATTR_GUEST_MEM_ENCRYPT) &&
+	    md->type != EFI_MEMORY_MAPPED_IO)
 		flags |= _PAGE_ENC;
 
 	pfn = md->phys_addr >> PAGE_SHIFT;
@@ -390,7 +391,7 @@ static int __init efi_update_mem_attr(struct mm_struct *mm, efi_memory_desc_t *m
 	if (!(md->attribute & EFI_MEMORY_RO))
 		pf |= _PAGE_RW;
 
-	if (sev_active())
+	if (prot_guest_has(PATTR_GUEST_MEM_ENCRYPT))
 		pf |= _PAGE_ENC;
 
 	return efi_update_mappings(md, pf);
@@ -438,7 +439,7 @@ void __init efi_runtime_update_mappings(void)
 			(md->type != EFI_RUNTIME_SERVICES_CODE))
 			pf |= _PAGE_RW;
 
-		if (sev_active())
+		if (prot_guest_has(PATTR_GUEST_MEM_ENCRYPT))
 			pf |= _PAGE_ENC;
 
 		efi_update_mappings(md, pf);
-- 
2.32.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
