Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TYZM4-0007W8-M9
 for kexec@lists.infradead.org; Wed, 14 Nov 2012 09:33:57 +0000
Message-ID: <50A3651F.3020809@cn.fujitsu.com>
Date: Wed, 14 Nov 2012 17:32:15 +0800
From: zhangyanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH v4 2/2] KVM: set/unset crash_clear_loaded_vmcss and
 vmclear_skipped in kvm_intel module
References: <50A3645F.60302@cn.fujitsu.com>
In-Reply-To: <50A3645F.60302@cn.fujitsu.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 arch/x86/kvm/vmx.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 4ff0ab9..029ec7b 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -41,6 +41,7 @@
 #include <asm/i387.h>
 #include <asm/xcr.h>
 #include <asm/perf_event.h>
+#include <asm/kexec.h>
 
 #include "trace.h"
 
@@ -963,6 +964,20 @@ static void vmcs_load(struct vmcs *vmcs)
 		       vmcs, phys_addr);
 }
 
+static inline void enable_vmclear_in_kdump(int cpu)
+{
+#ifdef CONFIG_KEXEC
+	per_cpu(vmclear_skipped, cpu) = 0;
+#endif
+}
+
+static inline void disable_vmclear_in_kdump(int cpu)
+{
+#ifdef CONFIG_KEXEC
+	per_cpu(vmclear_skipped, cpu) = 1;
+#endif
+}
+
 static void __loaded_vmcs_clear(void *arg)
 {
 	struct loaded_vmcs *loaded_vmcs = arg;
@@ -972,8 +987,10 @@ static void __loaded_vmcs_clear(void *arg)
 		return; /* vcpu migration can race with cpu offline */
 	if (per_cpu(current_vmcs, cpu) == loaded_vmcs->vmcs)
 		per_cpu(current_vmcs, cpu) = NULL;
+	disable_vmclear_in_kdump(cpu);
 	list_del(&loaded_vmcs->loaded_vmcss_on_cpu_link);
 	loaded_vmcs_init(loaded_vmcs);
+	enable_vmclear_in_kdump(cpu);
 }
 
 static void loaded_vmcs_clear(struct loaded_vmcs *loaded_vmcs)
@@ -1491,8 +1508,10 @@ static void vmx_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 		kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
 		local_irq_disable();
+		disable_vmclear_in_kdump(cpu);
 		list_add(&vmx->loaded_vmcs->loaded_vmcss_on_cpu_link,
 			 &per_cpu(loaded_vmcss_on_cpu, cpu));
+		enable_vmclear_in_kdump(cpu);
 		local_irq_enable();
 
 		/*
@@ -2302,6 +2321,9 @@ static int hardware_enable(void *garbage)
 		return -EBUSY;
 
 	INIT_LIST_HEAD(&per_cpu(loaded_vmcss_on_cpu, cpu));
+
+	enable_vmclear_in_kdump(cpu);
+
 	rdmsrl(MSR_IA32_FEATURE_CONTROL, old);
 
 	test_bits = FEATURE_CONTROL_LOCKED;
@@ -2333,6 +2355,8 @@ static void vmclear_local_loaded_vmcss(void)
 	list_for_each_entry_safe(v, n, &per_cpu(loaded_vmcss_on_cpu, cpu),
 				 loaded_vmcss_on_cpu_link)
 		__loaded_vmcs_clear(v);
+
+	disable_vmclear_in_kdump(cpu);
 }
 
 
@@ -7230,6 +7254,10 @@ static int __init vmx_init(void)
 	if (r)
 		goto out3;
 
+#ifdef CONFIG_KEXEC
+	crash_clear_loaded_vmcss = vmclear_local_loaded_vmcss;
+#endif
+
 	vmx_disable_intercept_for_msr(MSR_FS_BASE, false);
 	vmx_disable_intercept_for_msr(MSR_GS_BASE, false);
 	vmx_disable_intercept_for_msr(MSR_KERNEL_GS_BASE, true);
@@ -7265,6 +7293,10 @@ static void __exit vmx_exit(void)
 	free_page((unsigned long)vmx_io_bitmap_b);
 	free_page((unsigned long)vmx_io_bitmap_a);
 
+#ifdef CONFIG_KEXEC
+	crash_clear_loaded_vmcss = NULL;
+#endif
+
 	kvm_exit();
 }
 
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
