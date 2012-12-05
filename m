Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TgA1j-0002zV-G9
 for kexec@lists.infradead.org; Wed, 05 Dec 2012 08:08:20 +0000
Message-ID: <50BF0076.10205@cn.fujitsu.com>
Date: Wed, 05 Dec 2012 16:06:14 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v10 2/2] KVM-INTEL: provide the vmclear function and a
 bitmap to support VMCLEAR in kdump
References: <50BEFEBA.6070602@cn.fujitsu.com>
In-Reply-To: <50BEFEBA.6070602@cn.fujitsu.com>
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
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>

The vmclear function will be assigned to the callback function pointer
when loading kvm-intel module. And the bitmap indicates whether we
should do VMCLEAR operation in kdump. The bits in the bitmap are
set/unset according to different conditions.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 arch/x86/kvm/vmx.c |   67 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index f858159..2d5226a 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -42,6 +42,7 @@
 #include <asm/i387.h>
 #include <asm/xcr.h>
 #include <asm/perf_event.h>
+#include <asm/kexec.h>
 
 #include "trace.h"
 
@@ -992,6 +993,46 @@ static void vmcs_load(struct vmcs *vmcs)
 		       vmcs, phys_addr);
 }
 
+#ifdef CONFIG_KEXEC
+/*
+ * This bitmap is used to indicate whether the vmclear
+ * operation is enabled on all cpus. All disabled by
+ * default.
+ */
+static cpumask_t crash_vmclear_enabled_bitmap = CPU_MASK_NONE;
+
+static inline void crash_enable_local_vmclear(int cpu)
+{
+	cpumask_set_cpu(cpu, &crash_vmclear_enabled_bitmap);
+}
+
+static inline void crash_disable_local_vmclear(int cpu)
+{
+	cpumask_clear_cpu(cpu, &crash_vmclear_enabled_bitmap);
+}
+
+static inline int crash_local_vmclear_enabled(int cpu)
+{
+	return cpumask_test_cpu(cpu, &crash_vmclear_enabled_bitmap);
+}
+
+static void crash_vmclear_local_loaded_vmcss(void)
+{
+	int cpu = raw_smp_processor_id();
+	struct loaded_vmcs *v;
+
+	if (!crash_local_vmclear_enabled(cpu))
+		return;
+
+	list_for_each_entry(v, &per_cpu(loaded_vmcss_on_cpu, cpu),
+			    loaded_vmcss_on_cpu_link)
+		vmcs_clear(v->vmcs);
+}
+#else
+static inline void crash_enable_local_vmclear(int cpu) { }
+static inline void crash_disable_local_vmclear(int cpu) { }
+#endif /* CONFIG_KEXEC */
+
 static void __loaded_vmcs_clear(void *arg)
 {
 	struct loaded_vmcs *loaded_vmcs = arg;
@@ -1001,8 +1042,10 @@ static void __loaded_vmcs_clear(void *arg)
 		return; /* vcpu migration can race with cpu offline */
 	if (per_cpu(current_vmcs, cpu) == loaded_vmcs->vmcs)
 		per_cpu(current_vmcs, cpu) = NULL;
+	crash_disable_local_vmclear(cpu);
 	list_del(&loaded_vmcs->loaded_vmcss_on_cpu_link);
 	loaded_vmcs_init(loaded_vmcs);
+	crash_enable_local_vmclear(cpu);
 }
 
 static void loaded_vmcs_clear(struct loaded_vmcs *loaded_vmcs)
@@ -1535,8 +1578,10 @@ static void vmx_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 		kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
 		local_irq_disable();
+		crash_disable_local_vmclear(cpu);
 		list_add(&vmx->loaded_vmcs->loaded_vmcss_on_cpu_link,
 			 &per_cpu(loaded_vmcss_on_cpu, cpu));
+		crash_enable_local_vmclear(cpu);
 		local_irq_enable();
 
 		/*
@@ -2341,6 +2386,18 @@ static int hardware_enable(void *garbage)
 		return -EBUSY;
 
 	INIT_LIST_HEAD(&per_cpu(loaded_vmcss_on_cpu, cpu));
+
+	/*
+	 * Now we can enable the vmclear operation in kdump
+	 * since the loaded_vmcss_on_cpu list on this cpu
+	 * has been initialized.
+	 *
+	 * Though the cpu is not in VMX operation now, there
+	 * is no problem to enable the vmclear operation
+	 * for the loaded_vmcss_on_cpu list is empty!
+	 */
+	crash_enable_local_vmclear(cpu);
+
 	rdmsrl(MSR_IA32_FEATURE_CONTROL, old);
 
 	test_bits = FEATURE_CONTROL_LOCKED;
@@ -7367,6 +7424,11 @@ static int __init vmx_init(void)
 	if (r)
 		goto out3;
 
+#ifdef CONFIG_KEXEC
+	rcu_assign_pointer(crash_vmclear_loaded_vmcss,
+			   crash_vmclear_local_loaded_vmcss);
+#endif
+
 	vmx_disable_intercept_for_msr(MSR_FS_BASE, false);
 	vmx_disable_intercept_for_msr(MSR_GS_BASE, false);
 	vmx_disable_intercept_for_msr(MSR_KERNEL_GS_BASE, true);
@@ -7404,6 +7466,11 @@ static void __exit vmx_exit(void)
 	free_page((unsigned long)vmx_io_bitmap_b);
 	free_page((unsigned long)vmx_io_bitmap_a);
 
+#ifdef CONFIG_KEXEC
+	rcu_assign_pointer(crash_vmclear_loaded_vmcss, NULL);
+	synchronize_rcu();
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
