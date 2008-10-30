Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KvXgE-0000Lu-Lm
	for kexec@lists.infradead.org; Thu, 30 Oct 2008 13:35:19 +0000
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 6/6] kvm: x86: set kdump virt_disable function on
	initialization
Date: Thu, 30 Oct 2008 11:34:46 -0200
Message-Id: <1225373687-6960-7-git-send-email-ehabkost@redhat.com>
In-Reply-To: <1225373687-6960-1-git-send-email-ehabkost@redhat.com>
References: <1225373687-6960-1-git-send-email-ehabkost@redhat.com>
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
To: Avi Kivity <avi@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

Finally implement the virt_disable function for kdump. It will call
kvm_x86_ops->crash_hardware_disable(), that will disable virtualization
extensions on the CPU if it is not disabled yet.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 arch/x86/kvm/x86.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ff895e2..4f7a221 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -40,6 +40,7 @@
 #include <asm/msr.h>
 #include <asm/desc.h>
 #include <asm/mtrr.h>
+#include <asm/virtext.h>
 
 #define MAX_IO_MSRS 256
 #define CR0_RESERVED_BITS						\
@@ -2581,6 +2582,13 @@ int kvm_emulate_pio_string(struct kvm_vcpu *vcpu, struct kvm_run *run, int in,
 }
 EXPORT_SYMBOL_GPL(kvm_emulate_pio_string);
 
+/* Called at crash time, so we can disable virtualization if needed
+ */
+static void crash_hardware_disable(unsigned int cpu)
+{
+	kvm_x86_ops->crash_hardware_disable(NULL);
+}
+
 int kvm_arch_init(void *opaque)
 {
 	int r;
@@ -2605,9 +2613,15 @@ int kvm_arch_init(void *opaque)
 
 	kvm_x86_ops = ops;
 
+	r = set_virt_disable_func(crash_hardware_disable);
+	if (r) {
+		printk(KERN_ERR "kvm: virt_disable function already set?\n");
+		goto out_clear_ops;
+	}
+
 	r = kvm_mmu_module_init();
 	if (r)
-		goto out_clear_ops;
+		goto out_clear_crash;
 
 	kvm_init_msr_list();
 
@@ -2617,6 +2631,8 @@ int kvm_arch_init(void *opaque)
 			PT_DIRTY_MASK, PT64_NX_MASK, 0, 0);
 	return 0;
 
+out_clear_crash:
+	clear_virt_disable_func();
 out_clear_ops:
 	kvm_x86_ops = NULL;
 out:
@@ -2625,6 +2641,7 @@ out:
 
 void kvm_arch_exit(void)
 {
+	clear_virt_disable_func();
 	kvm_x86_ops = NULL;
 	kvm_mmu_module_exit();
 }
-- 
1.5.5.GIT


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
