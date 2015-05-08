Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YqWwr-0007br-JC
 for kexec@lists.infradead.org; Fri, 08 May 2015 01:19:30 +0000
Received: by pdea3 with SMTP id a3so56303410pde.3
 for <kexec@lists.infradead.org>; Thu, 07 May 2015 18:19:08 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [v4 2/4] arm64: kvm: add kvm cpu hotplug
Date: Fri,  8 May 2015 10:18:02 +0900
Message-Id: <1431047884-5637-3-git-send-email-takahiro.akashi@linaro.org>
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

This patch allows cpu cores to be up and down by adding
kvm_arch_hardware_enable/isable(). This way, especially in kexec case,
cores are reset to initial states and kexec can gracefully shutdown the
system and reboot a new kernel from EL2.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm/include/asm/kvm_host.h   |    1 -
 arch/arm/kvm/arm.c                |   29 +++++++++++++++++++----------
 arch/arm64/include/asm/kvm_host.h |    1 -
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 41008cd..ca97764 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -237,7 +237,6 @@ void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
 
 struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr);
 
-static inline void kvm_arch_hardware_disable(void) {}
 static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 251ab9e..e989925 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -87,11 +87,6 @@ struct kvm_vcpu * __percpu *kvm_get_running_vcpus(void)
 	return &kvm_arm_running_vcpu;
 }
 
-int kvm_arch_hardware_enable(void)
-{
-	return 0;
-}
-
 int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
 {
 	return kvm_vcpu_exiting_guest_mode(vcpu) == IN_GUEST_MODE;
@@ -885,6 +880,9 @@ static void cpu_init_hyp_mode(void *dummy)
 	unsigned long stack_page;
 	unsigned long vector_ptr;
 
+	if (__hyp_get_vectors() != hyp_default_vectors)
+		return;
+
 	/* Switch from the HYP stub to our own HYP init vector */
 	__hyp_set_vectors(kvm_get_idmap_vector());
 
@@ -921,6 +919,10 @@ static int hyp_init_cpu_notify(struct notifier_block *self,
 		if (__hyp_get_vectors() == hyp_default_vectors)
 			cpu_init_hyp_mode(NULL);
 		break;
+	case CPU_DYING:
+	case CPU_DYING_FROZEN:
+		kvm_cpu_reset(NULL);
+		break;
 	}
 
 	return NOTIFY_OK;
@@ -936,6 +938,7 @@ static int hyp_init_cpu_pm_notifier(struct notifier_block *self,
 				    void *v)
 {
 	if (cmd == CPU_PM_EXIT &&
+	    kvm_arm_get_running_vcpu() &&
 	    __hyp_get_vectors() == hyp_default_vectors) {
 		cpu_init_hyp_mode(NULL);
 		return NOTIFY_OK;
@@ -1039,11 +1042,6 @@ static int init_hyp_mode(void)
 	}
 
 	/*
-	 * Execute the init code on each CPU.
-	 */
-	on_each_cpu(cpu_init_hyp_mode, NULL, 1);
-
-	/*
 	 * Init HYP view of VGIC
 	 */
 	err = kvm_vgic_hyp_init();
@@ -1144,6 +1142,17 @@ out_err:
 	return err;
 }
 
+int kvm_arch_hardware_enable(void)
+{
+	cpu_init_hyp_mode(NULL);
+	return 0;
+}
+
+void kvm_arch_hardware_disable(void)
+{
+	kvm_cpu_reset(NULL);
+}
+
 /* NOP: Compiling as a module not supported */
 void kvm_arch_exit(void)
 {
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 6a8da9c..831e6a4 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -262,7 +262,6 @@ static inline void vgic_arch_setup(const struct vgic_params *vgic)
 	}
 }
 
-static inline void kvm_arch_hardware_disable(void) {}
 static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
-- 
1.7.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
