Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TbS6T-0003sZ-TT
 for kexec@lists.infradead.org; Thu, 22 Nov 2012 08:25:46 +0000
Message-ID: <50ADE11A.401@cn.fujitsu.com>
Date: Thu, 22 Nov 2012 16:23:54 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH v8 1/2] x86/kexec: add a new atomic notifier list for kdump
References: <50ADE0C2.1000106@cn.fujitsu.com>
In-Reply-To: <50ADE0C2.1000106@cn.fujitsu.com>
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

This patch adds an atomic notifier list named crash_notifier_list.
Currently, when loading kvm-intel module, a notifier will be registered
in the list to enable vmcss loaded on all cpus to be VMCLEAR'd if
needed.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 arch/x86/include/asm/kexec.h |    2 ++
 arch/x86/kernel/crash.c      |    9 +++++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 317ff17..5e22b00 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -163,6 +163,8 @@ struct kimage_arch {
 };
 #endif
 
+extern struct atomic_notifier_head crash_notifier_list;
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_KEXEC_H */
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 13ad899..c5b2f70 100644
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
@@ -30,6 +32,9 @@
 
 int in_crash_kexec;
 
+ATOMIC_NOTIFIER_HEAD(crash_notifier_list);
+EXPORT_SYMBOL_GPL(crash_notifier_list);
+
 #if defined(CONFIG_SMP) && defined(CONFIG_X86_LOCAL_APIC)
 
 static void kdump_nmi_callback(int cpu, struct pt_regs *regs)
@@ -46,6 +51,8 @@ static void kdump_nmi_callback(int cpu, struct pt_regs *regs)
 #endif
 	crash_save_cpu(regs, cpu);
 
+	atomic_notifier_call_chain(&crash_notifier_list, 0, NULL);
+
 	/* Disable VMX or SVM if needed.
 	 *
 	 * We need to disable virtualization on all CPUs.
@@ -88,6 +95,8 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 
 	kdump_nmi_shootdown_cpus();
 
+	atomic_notifier_call_chain(&crash_notifier_list, 0, NULL);
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
