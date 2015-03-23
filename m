Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ya0xI-0001fX-7i
 for kexec@lists.infradead.org; Mon, 23 Mar 2015 11:55:41 +0000
Received: by pacwe9 with SMTP id we9so189533651pac.1
 for <kexec@lists.infradead.org>; Mon, 23 Mar 2015 04:55:18 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC 3/4] arm64: kvm: add cpu reset hook for cpu hotplug
Date: Mon, 23 Mar 2015 20:53:58 +0900
Message-Id: <1427111639-4575-4-git-send-email-takahiro.akashi@linaro.org>
In-Reply-To: <1427111639-4575-1-git-send-email-takahiro.akashi@linaro.org>
References: <1427111639-4575-1-git-send-email-takahiro.akashi@linaro.org>
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

This patch doesn't enable cpu hotplug under kvm, but is a prerequiste
when the feature is implemented.
Once kvm_arch_hardware_enable/disable() is properly implemented,
arm64-specific cpu notifier hook, hyp_init_cpu_notify(), will be
able to be removed and replaced by generic kvm_cpu_hotplug().

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm/kvm/arm.c                |    9 +++++++++
 arch/arm64/include/asm/kvm_host.h |    1 -
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index b879cf6..08804d3 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -925,6 +925,10 @@ static int hyp_init_cpu_notify(struct notifier_block *self,
 		if (__hyp_get_vectors() == hyp_default_vectors)
 			cpu_init_hyp_mode(NULL);
 		break;
+	case CPU_DYING:
+	case CPU_DYING_FROZEN:
+		kvm_cpu_reset(NULL);
+		break;
 	}
 
 	return NOTIFY_OK;
@@ -1168,6 +1172,11 @@ out_err:
 	return err;
 }
 
+void kvm_arch_hardware_disable(void)
+{
+	kvm_cpu_reset(NULL);
+}
+
 /* NOP: Compiling as a module not supported */
 void kvm_arch_exit(void)
 {
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 97f88fe..a97b2fe 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -261,7 +261,6 @@ static inline void vgic_arch_setup(const struct vgic_params *vgic)
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
