Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZoRq1-0005Fb-RI
 for kexec@lists.infradead.org; Tue, 20 Oct 2015 08:00:06 +0000
Received: by pacfv9 with SMTP id fv9so14415434pac.3
 for <kexec@lists.infradead.org>; Tue, 20 Oct 2015 00:59:50 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH 2/2] fixup! arm64: kvm: allows kvm cpu hotplug
Date: Tue, 20 Oct 2015 16:58:27 +0900
Message-Id: <1445327907-23274-3-git-send-email-takahiro.akashi@linaro.org>
In-Reply-To: <1445327907-23274-1-git-send-email-takahiro.akashi@linaro.org>
References: <1445327907-23274-1-git-send-email-takahiro.akashi@linaro.org>
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
To: catalin.marinas@arm.com, will.deacon@arm.com, geoff@infradead.org, marc.zyngier@arm.com
Cc: mark.rutland@arm.com, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, broonie@kernel.org, david.griego@linaro.org, christoffer.dall@linaro.org, linux-arm-kernel@lists.infradead.org

Without this patch, kvm cannot start a guest when cpuidle is enabled
if the hardware does not retain cpu state (EL2) in idle state.

This patch re-initailizes EL2 state at CPU_PM_EXIT by calling
kvm_arch_hardware_enable() if and only if kvm has been initialized
before CPU_PM_ENTER, that is, if any vcpus have been created.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm/kvm/arm.c |   25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 0871809..fbff638 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -60,6 +60,8 @@ static atomic64_t kvm_vmid_gen = ATOMIC64_INIT(1);
 static u8 kvm_next_vmid;
 static DEFINE_SPINLOCK(kvm_vmid_lock);
 
+static DEFINE_PER_CPU(unsigned char, kvm_arm_hardware_enabled);
+
 static void kvm_arm_set_running_vcpu(struct kvm_vcpu *vcpu)
 {
 	BUG_ON(preemptible());
@@ -955,12 +957,27 @@ static int hyp_init_cpu_pm_notifier(struct notifier_block *self,
 				    unsigned long cmd,
 				    void *v)
 {
-	if (cmd == CPU_PM_EXIT && kvm_arm_get_running_vcpu()) {
-		kvm_arch_hardware_enable();
+	switch (cmd) {
+	case CPU_PM_ENTER:
+		if (__hyp_get_vectors() != hyp_default_vectors)
+			__this_cpu_write(kvm_arm_hardware_enabled, 1);
+		else
+			__this_cpu_write(kvm_arm_hardware_enabled, 0);
+		/*
+		 * don't call kvm_arch_hardware_disable() in case of
+		 * CPU_PM_ENTER because it does't actually save any state.
+		 */
+
+		return NOTIFY_OK;
+	case CPU_PM_EXIT:
+		if (__this_cpu_read(kvm_arm_hardware_enabled))
+			kvm_arch_hardware_enable();
+
 		return NOTIFY_OK;
-	}
 
-	return NOTIFY_DONE;
+	default:
+		return NOTIFY_DONE;
+	}
 }
 
 static struct notifier_block hyp_init_cpu_pm_nb = {
-- 
1.7.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
