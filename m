Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KrwGU-0001Jq-4z
	for kexec@lists.infradead.org; Mon, 20 Oct 2008 15:01:50 +0000
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 2/2] kvm: disable virtualization when halting CPUs on crash
Date: Mon, 20 Oct 2008 13:01:34 -0200
Message-Id: <1224514894-30171-3-git-send-email-ehabkost@redhat.com>
In-Reply-To: <1224514894-30171-1-git-send-email-ehabkost@redhat.com>
References: <1224514894-30171-1-git-send-email-ehabkost@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, kvm@vger.kernel.org
Cc: Eduardo Habkost <ehabkost@redhat.com>

Use the emergency_halt_notifier interface to disable virtualization
on all the CPUs on machine_crash_shutdown().

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 arch/x86/kvm/x86.c |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5d29c50..17e2df1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -40,6 +40,7 @@
 #include <asm/msr.h>
 #include <asm/desc.h>
 #include <asm/mtrr.h>
+#include <asm/reboot.h>
 
 #define MAX_IO_MSRS 256
 #define CR0_RESERVED_BITS						\
@@ -2583,6 +2584,18 @@ int kvm_emulate_pio_string(struct kvm_vcpu *vcpu, struct kvm_run *run, int in,
 }
 EXPORT_SYMBOL_GPL(kvm_emulate_pio_string);
 
+static int kvm_emergency_halt(struct notifier_block *notifier,
+			      unsigned long val, void *v)
+{
+	/* We are crashing. Do the very least */
+	kvm_arch_hardware_disable(NULL);
+	return NOTIFY_OK;
+}
+
+static struct notifier_block kvm_emergency_halt_notifier = {
+	.notifier_call = kvm_emergency_halt,
+};
+
 int kvm_arch_init(void *opaque)
 {
 	int r;
@@ -2605,10 +2618,14 @@ int kvm_arch_init(void *opaque)
 		goto out;
 	}
 
-	r = kvm_mmu_module_init();
+	r = register_emergency_halt_notifier(&kvm_emergency_halt_notifier);
 	if (r)
 		goto out;
 
+	r = kvm_mmu_module_init();
+	if (r)
+		goto out_unregister;
+
 	kvm_init_msr_list();
 
 	kvm_x86_ops = ops;
@@ -2618,6 +2635,8 @@ int kvm_arch_init(void *opaque)
 			PT_DIRTY_MASK, PT64_NX_MASK, 0, 0);
 	return 0;
 
+out_unregister:
+	unregister_emergency_halt_notifier(&kvm_emergency_halt_notifier);
 out:
 	return r;
 }
@@ -2626,6 +2645,7 @@ void kvm_arch_exit(void)
 {
 	kvm_x86_ops = NULL;
 	kvm_mmu_module_exit();
+	unregister_emergency_halt_notifier(&kvm_emergency_halt_notifier);
 }
 
 int kvm_emulate_halt(struct kvm_vcpu *vcpu)
-- 
1.5.5.GIT


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
