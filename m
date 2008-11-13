Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1L0gF7-0001zn-B6
	for kexec@lists.infradead.org; Thu, 13 Nov 2008 17:44:33 +0000
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 10/11] kdump: forcibly disable VMX and SVM on
	machine_crash_shutdown()
Date: Thu, 13 Nov 2008 15:43:50 -0200
Message-Id: <1226598231-18311-11-git-send-email-ehabkost@redhat.com>
In-Reply-To: <1226598231-18311-1-git-send-email-ehabkost@redhat.com>
References: <1226598231-18311-1-git-send-email-ehabkost@redhat.com>
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
To: Avi Kivity <avi@redhat.com>, Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrey Borzenkov <arvidjaar@mail.ru>, mingo@redhat.com, Vivek Goyal <vgoyal@redhat.com>

We need to disable virtualization extensions on all CPUs before booting
the kdump kernel, otherwise the kdump kernel booting will fail, and
rebooting after the kdump kernel did its task may also fail.

We do it using cpu_emergency_vmxoff() and cpu_emergency_svm_disable(),
that should always work, because those functions check if the CPUs
support SVM or VMX before doing their tasks.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 arch/x86/kernel/crash.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index d84a852..c689d19 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -26,6 +26,7 @@
 #include <linux/kdebug.h>
 #include <asm/smp.h>
 #include <asm/reboot.h>
+#include <asm/virtext.h>
 
 #include <mach_ipi.h>
 
@@ -49,6 +50,15 @@ static void kdump_nmi_callback(int cpu, struct die_args *args)
 #endif
 	crash_save_cpu(regs, cpu);
 
+	/* Disable VMX or SVM if needed.
+	 *
+	 * We need to disable virtualization on all CPUs.
+	 * Having VMX or SVM enabled on any CPU may break rebooting
+	 * after the kdump kernel has finished its task.
+	 */
+	cpu_emergency_vmxoff();
+	cpu_emergency_svm_disable();
+
 	disable_local_APIC();
 }
 
@@ -80,6 +90,14 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 	local_irq_disable();
 
 	kdump_nmi_shootdown_cpus();
+
+	/* Booting kdump kernel with VMX or SVM enabled won't work,
+	 * because (among other limitations) we can't disable paging
+	 * with the virt flags.
+	 */
+	cpu_emergency_vmxoff();
+	cpu_emergency_svm_disable();
+
 	lapic_shutdown();
 #if defined(CONFIG_X86_IO_APIC)
 	disable_IO_APIC();
-- 
1.5.5.GIT


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
