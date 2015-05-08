Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YqWx6-0007i5-Qz
 for kexec@lists.infradead.org; Fri, 08 May 2015 01:19:46 +0000
Received: by pdbnk13 with SMTP id nk13so56374136pdb.0
 for <kexec@lists.infradead.org>; Thu, 07 May 2015 18:19:23 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [v4 4/4] arm: kvm: add stub implementation for kvm_cpu_reset()
Date: Fri,  8 May 2015 10:18:04 +0900
Message-Id: <1431047884-5637-5-git-send-email-takahiro.akashi@linaro.org>
In-Reply-To: <1431047884-5637-1-git-send-email-takahiro.akashi@linaro.org>
References: <1431047884-5637-1-git-send-email-takahiro.akashi@linaro.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com, mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, geoff@infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, broonie@kernel.org, david.griego@linaro.org, christoffer.dall@linaro.org, freddy77@gmail.com

Just to avoid compiling errors on arm.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm/include/asm/kvm_asm.h  |    1 +
 arch/arm/include/asm/kvm_host.h |   12 ++++++++++++
 arch/arm/include/asm/kvm_mmu.h  |    5 +++++
 arch/arm/kvm/init.S             |    6 ++++++
 4 files changed, 24 insertions(+)

diff --git a/arch/arm/include/asm/kvm_asm.h b/arch/arm/include/asm/kvm_asm.h
index 25410b2..462babf 100644
--- a/arch/arm/include/asm/kvm_asm.h
+++ b/arch/arm/include/asm/kvm_asm.h
@@ -85,6 +85,7 @@ struct kvm_vcpu;
 
 extern char __kvm_hyp_init[];
 extern char __kvm_hyp_init_end[];
+extern char __kvm_hyp_reset[];
 
 extern char __kvm_hyp_exit[];
 extern char __kvm_hyp_exit_end[];
diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index ca97764..6d38134 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -220,6 +220,18 @@ static inline void __cpu_init_hyp_mode(phys_addr_t boot_pgd_ptr,
 	kvm_call_hyp((void*)hyp_stack_ptr, vector_ptr, pgd_ptr);
 }
 
+static inline void __cpu_reset_hyp_mode(phys_addr_t boot_pgd_ptr,
+					phys_addr_t phys_idmap_start,
+					unsigned long stub_vector_ptr,
+					unsigned long reset_func)
+{
+	/*
+	 * TODO
+	 * kvm_call_reset(boot_pgd_ptr, phys_idmap_start, stub_vector_ptr,
+	 *		  reset_func);
+	 */
+}
+
 static inline int kvm_arch_dev_ioctl_check_extension(long ext)
 {
 	return 0;
diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 37ca2a4..d85bcd1 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -66,6 +66,7 @@ void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu);
 phys_addr_t kvm_mmu_get_httbr(void);
 phys_addr_t kvm_mmu_get_boot_httbr(void);
 phys_addr_t kvm_get_idmap_vector(void);
+phys_addr_t kvm_get_idmap_start(void);
 int kvm_mmu_init(void);
 void kvm_clear_hyp_idmap(void);
 
@@ -270,6 +271,10 @@ static inline void __kvm_flush_dcache_pud(pud_t pud)
 void kvm_set_way_flush(struct kvm_vcpu *vcpu);
 void kvm_toggle_cache(struct kvm_vcpu *vcpu, bool was_enabled);
 
+extern char __hyp_idmap_text_start[];
+#define kvm_virt_to_trampoline(x)       \
+			(TRAMPOLINE_VA + ((x) - __hyp_idmap_text_start))
+
 #endif	/* !__ASSEMBLY__ */
 
 #endif /* __ARM_KVM_MMU_H__ */
diff --git a/arch/arm/kvm/init.S b/arch/arm/kvm/init.S
index 3988e72..9178c9a 100644
--- a/arch/arm/kvm/init.S
+++ b/arch/arm/kvm/init.S
@@ -156,4 +156,10 @@ target:	@ We're now in the trampoline code, switch page tables
 	.globl __kvm_hyp_init_end
 __kvm_hyp_init_end:
 
+	.globl __kvm_hyp_reset
+__kvm_hyp_reset:
+	@ TODO
+
+	eret
+
 	.popsection
-- 
1.7.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
