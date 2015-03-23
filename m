Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ya0x6-0000qV-Uq
 for kexec@lists.infradead.org; Mon, 23 Mar 2015 11:55:29 +0000
Received: by pabxg6 with SMTP id xg6so176782559pab.0
 for <kexec@lists.infradead.org>; Mon, 23 Mar 2015 04:55:07 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC 2/4] arm64: kexec: fix kvm issue
Date: Mon, 23 Mar 2015 20:53:57 +0900
Message-Id: <1427111639-4575-3-git-send-email-takahiro.akashi@linaro.org>
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

The current kvm implementation keeps EL2 vector table installed even
when the system is shut down. This prevents kexec from putting the system
with kvm back into EL2 when starting a new kernel.

This patch resolves this issue by calling a cpu tear-down function via
reboot notifier, kvm_reboot_notify(), which is invoked by
kernel_restart_prepare() in kernel_kexec().
While kvm has a generic hook, kvm_reboot(), we can't use it here because
a cpu teardown function will not be invoked, under current implementation,
if no guest vm has been created by kvm_create_vm().
Please note that kvm_usage_count is zero in this case.

We'd better, in the future, implement cpu hotplug support and put the
arch-specific initialization into kvm_arch_hardware_enable/disable().
This way, we would be able to revert this patch.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm/kvm/arm.c     |   21 +++++++++++++++++++++
 arch/arm64/kvm/Kconfig |    1 -
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 35c8bc0..b879cf6 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -25,6 +25,7 @@
 #include <linux/vmalloc.h>
 #include <linux/fs.h>
 #include <linux/mman.h>
+#include <linux/reboot.h>
 #include <linux/sched.h>
 #include <linux/kvm.h>
 #include <trace/events/kvm.h>
@@ -1103,6 +1104,23 @@ struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr)
 	return NULL;
 }
 
+static int kvm_reboot_notify(struct notifier_block *nb,
+			     unsigned long val, void *v)
+{
+	/*
+	 * Reset each CPU in EL2 to initial state.
+	 */
+	on_each_cpu(kvm_cpu_reset, NULL, 1);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block kvm_reboot_nb = {
+	.notifier_call		= kvm_reboot_notify,
+	.next			= NULL,
+	.priority		= 0, /* FIXME */
+};
+
 /**
  * Initialize Hyp-mode and memory mappings on all CPUs.
  */
@@ -1141,6 +1159,9 @@ int kvm_arch_init(void *opaque)
 	hyp_cpu_pm_init();
 
 	kvm_coproc_table_init();
+
+	register_reboot_notifier(&kvm_reboot_nb);
+
 	return 0;
 out_err:
 	cpu_notifier_register_done();
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 30ae7a7..f5590c8 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -18,7 +18,6 @@ if VIRTUALIZATION
 
 config KVM
 	bool "Kernel-based Virtual Machine (KVM) support"
-	depends on !KEXEC
 	select MMU_NOTIFIER
 	select PREEMPT_NOTIFIERS
 	select ANON_INODES
-- 
1.7.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
