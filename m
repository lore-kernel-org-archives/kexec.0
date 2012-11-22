Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TbMdo-0000QW-WB
 for kexec@lists.infradead.org; Thu, 22 Nov 2012 02:35:50 +0000
Message-ID: <50AD8F16.3030108@cn.fujitsu.com>
Date: Thu, 22 Nov 2012 10:33:58 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH v7 1/2] x86/kexec: VMCLEAR vmcss on all cpus if necessary
References: <50AD8EB6.8080808@cn.fujitsu.com>
In-Reply-To: <50AD8EB6.8080808@cn.fujitsu.com>
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
To: "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>

This patch adds an atomic notifier list named vmclear_notifier_list.
When loading kvm-intel module, a notifier will be registered in
the list to enable vmcss loaded on all cpus to be VMCLEAR'd if
needed.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 arch/x86/include/asm/kexec.h |    2 ++
 arch/x86/kernel/crash.c      |   25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 317ff17..43e0db3 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -163,6 +163,8 @@ struct kimage_arch {
 };
 #endif
 
+extern struct atomic_notifier_head vmclear_notifier_list;
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_KEXEC_H */
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 13ad899..c953d50 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -16,6 +16,8 @@
 #include <linux/delay.h>
 #include <linux/elf.h>
 #include <linux/elfcore.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
 
 #include <asm/processor.h>
 #include <asm/hardirq.h>
@@ -30,6 +32,19 @@
 
 int in_crash_kexec;
 
+/*
+ * The list is used to VMCLEAR vmcss loaded on all
+ * cpus. And when loading kvm_intel module, the
+ * vmclear function will be registered in the list.
+ */
+ATOMIC_NOTIFIER_HEAD(vmclear_notifier_list);
+EXPORT_SYMBOL_GPL(vmclear_notifier_list);
+
+static inline void cpu_emergency_vmclear_loaded_vmcss(void)
+{
+	atomic_notifier_call_chain(&vmclear_notifier_list, 0, NULL);
+}
+
 #if defined(CONFIG_SMP) && defined(CONFIG_X86_LOCAL_APIC)
 
 static void kdump_nmi_callback(int cpu, struct pt_regs *regs)
@@ -46,6 +61,11 @@ static void kdump_nmi_callback(int cpu, struct pt_regs *regs)
 #endif
 	crash_save_cpu(regs, cpu);
 
+	/*
+	 * VMCLEAR vmcss loaded on all cpus if needed.
+	 */
+	cpu_emergency_vmclear_loaded_vmcss();
+
 	/* Disable VMX or SVM if needed.
 	 *
 	 * We need to disable virtualization on all CPUs.
@@ -88,6 +108,11 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 
 	kdump_nmi_shootdown_cpus();
 
+	/*
+	 * VMCLEAR vmcss loaded on this cpu if needed.
+	 */
+	cpu_emergency_vmclear_loaded_vmcss();
+
 	/* Booting kdump kernel with VMX or SVM enabled won't work,
 	 * because (among other limitations) we can't disable paging
 	 * with the virt flags.
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
