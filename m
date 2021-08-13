Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-bn8nam12on2046.outbound.protection.outlook.com
 ([40.107.237.46] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mEaY5-00DBZu-Ip
 for kexec@lists.infradead.org; Fri, 13 Aug 2021 17:00:53 +0000
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v2 07/12] x86/sev: Replace occurrences of sev_es_active() with
 prot_guest_has()
Date: Fri, 13 Aug 2021 11:59:26 -0500
Message-Id: <0b8480d93b5090fcc34cf5d5035d4d89aa765d79.1628873970.git.thomas.lendacky@amd.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>, Brijesh Singh <brijesh.singh@amd.com>, Joerg Roedel <joro@8bytes.org>, Andi Kleen <ak@linux.intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>

Replace occurrences of sev_es_active() with the more generic
prot_guest_has() using PATTR_GUEST_PROT_STATE, except for in
arch/x86/kernel/sev*.c and arch/x86/mm/mem_encrypt*.c where PATTR_SEV_ES
will be used. If future support is added for other memory encyrption
techonologies, the use of PATTR_GUEST_PROT_STATE can be updated, as
required, to specifically use PATTR_SEV_ES.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/mem_encrypt.h | 2 --
 arch/x86/kernel/sev.c              | 6 +++---
 arch/x86/mm/mem_encrypt.c          | 7 +++----
 arch/x86/realmode/init.c           | 3 +--
 4 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 7e25de37c148..797146e0cd6b 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -50,7 +50,6 @@ void __init mem_encrypt_free_decrypted_mem(void);
 void __init mem_encrypt_init(void);
 
 void __init sev_es_init_vc_handling(void);
-bool sev_es_active(void);
 bool amd_prot_guest_has(unsigned int attr);
 
 #define __bss_decrypted __section(".bss..decrypted")
@@ -74,7 +73,6 @@ static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
 static inline void __init sme_enable(struct boot_params *bp) { }
 
 static inline void sev_es_init_vc_handling(void) { }
-static inline bool sev_es_active(void) { return false; }
 static inline bool amd_prot_guest_has(unsigned int attr) { return false; }
 
 static inline int __init
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index a6895e440bc3..66a4ab9d95d7 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -11,7 +11,7 @@
 
 #include <linux/sched/debug.h>	/* For show_regs() */
 #include <linux/percpu-defs.h>
-#include <linux/mem_encrypt.h>
+#include <linux/protected_guest.h>
 #include <linux/printk.h>
 #include <linux/mm_types.h>
 #include <linux/set_memory.h>
@@ -615,7 +615,7 @@ int __init sev_es_efi_map_ghcbs(pgd_t *pgd)
 	int cpu;
 	u64 pfn;
 
-	if (!sev_es_active())
+	if (!prot_guest_has(PATTR_SEV_ES))
 		return 0;
 
 	pflags = _PAGE_NX | _PAGE_RW;
@@ -774,7 +774,7 @@ void __init sev_es_init_vc_handling(void)
 
 	BUILD_BUG_ON(offsetof(struct sev_es_runtime_data, ghcb_page) % PAGE_SIZE);
 
-	if (!sev_es_active())
+	if (!prot_guest_has(PATTR_SEV_ES))
 		return;
 
 	if (!sev_es_check_cpu_features())
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 83bc928f529e..38dfa84b77a1 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -383,8 +383,7 @@ static bool sme_active(void)
 	return sme_me_mask && !sev_active();
 }
 
-/* Needs to be called from non-instrumentable code */
-bool noinstr sev_es_active(void)
+static bool sev_es_active(void)
 {
 	return sev_status & MSR_AMD64_SEV_ES_ENABLED;
 }
@@ -482,7 +481,7 @@ static void print_mem_encrypt_feature_info(void)
 		pr_cont(" SEV");
 
 	/* Encrypted Register State */
-	if (sev_es_active())
+	if (amd_prot_guest_has(PATTR_SEV_ES))
 		pr_cont(" SEV-ES");
 
 	pr_cont("\n");
@@ -501,7 +500,7 @@ void __init mem_encrypt_init(void)
 	 * With SEV, we need to unroll the rep string I/O instructions,
 	 * but SEV-ES supports them through the #VC handler.
 	 */
-	if (amd_prot_guest_has(PATTR_SEV) && !sev_es_active())
+	if (amd_prot_guest_has(PATTR_SEV) && !amd_prot_guest_has(PATTR_SEV_ES))
 		static_branch_enable(&sev_enable_key);
 
 	print_mem_encrypt_feature_info();
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 2109ae569c67..7711d0071f41 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -2,7 +2,6 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/memblock.h>
-#include <linux/mem_encrypt.h>
 #include <linux/protected_guest.h>
 #include <linux/pgtable.h>
 
@@ -48,7 +47,7 @@ static void sme_sev_setup_real_mode(struct trampoline_header *th)
 	if (prot_guest_has(PATTR_HOST_MEM_ENCRYPT))
 		th->flags |= TH_FLAGS_SME_ACTIVE;
 
-	if (sev_es_active()) {
+	if (prot_guest_has(PATTR_GUEST_PROT_STATE)) {
 		/*
 		 * Skip the call to verify_cpu() in secondary_startup_64 as it
 		 * will cause #VC exceptions when the AP can't handle them yet.
-- 
2.32.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
