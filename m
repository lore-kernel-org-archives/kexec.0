Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1L2BGU-0002gX-K9
	for kexec@lists.infradead.org; Mon, 17 Nov 2008 21:04:11 +0000
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 12/12] x86: disable VMX on all CPUs on reboot
Date: Mon, 17 Nov 2008 19:03:24 -0200
Message-Id: <1226955804-16802-13-git-send-email-ehabkost@redhat.com>
In-Reply-To: <1226955804-16802-1-git-send-email-ehabkost@redhat.com>
References: <1226955804-16802-1-git-send-email-ehabkost@redhat.com>
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

On emergency_restart, we may need to use an NMI to disable virtualization
on all CPUs. We do that using nmi_shootdown_cpus() if VMX is enabled.

Note: With this patch, we will run the NMI stuff only when the CPU where
emergency_restart() was called has VMX enabled. This should work on most
cases because KVM enables VMX on all CPUs, but we may miss the small
window where KVM is doing that. Also, I don't know if all code using
VMX out there always enable VMX on all CPUs like KVM does. We have two
other alternatives for that:

a) Have an API that all code that enables VMX on any CPU should use
   to tell the kernel core that it is going to enable VMX on the CPUs.
b) Always call nmi_shootdown_cpus() if the CPU supports VMX. This is
   a bit intrusive and more risky, as it would run nmi_shootdown_cpus()
   on emergency_reboot() even on systems where virtualization is never
   enabled.


Finding a proper point to hook the nmi_shootdown_cpus() call isn't
trivial, as the non-emergency machine_restart() (that doesn't need the
NMI tricks) uses machine_emergency_restart() directly.

The solution to make this work without adding a new function or argument
to machine_ops was setting a 'reboot_emergency' flag that tells if
native_machine_emergency_restart() needs to do the virt cleanup or not.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 arch/x86/kernel/reboot.c |   63 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 6f05a28..a5f8c09 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -12,6 +12,7 @@
 #include <asm/proto.h>
 #include <asm/reboot_fixups.h>
 #include <asm/reboot.h>
+#include <asm/virtext.h>
 
 #ifdef CONFIG_X86_32
 # include <linux/dmi.h>
@@ -39,6 +40,13 @@ int reboot_force;
 static int reboot_cpu = -1;
 #endif
 
+/* This is set if we need to go through the 'emergency' path.
+ * When machine_emergency_restart() is called, we may be on
+ * an inconsistent state and won't be able to do a clean cleanup
+ */
+static int reboot_emergency;
+
+
 /* This is set by the PCI code if either type 1 or type 2 PCI is detected */
 bool port_cf9_safe = false;
 
@@ -359,6 +367,48 @@ static inline void kb_wait(void)
 	}
 }
 
+static void vmxoff_nmi(int cpu, struct die_args *args)
+{
+	cpu_emergency_vmxoff();
+}
+
+/* Use NMIs as IPIs to tell all CPUs to disable virtualization
+ */
+static void emergency_vmx_disable_all(void)
+{
+	/* Just make sure we won't change CPUs while doing this */
+	local_irq_disable();
+
+	/* We need to disable VMX on all CPUs before rebooting, otherwise
+	 * we risk hanging up the machine, because the CPU ignore INIT
+	 * signals when VMX is enabled.
+	 *
+	 * We can't take any locks and we may be on an inconsistent
+	 * state, so we use NMIs as IPIs to tell the other CPUs to disable
+	 * VMX and halt.
+	 * 
+	 * For safety, we will avoid running the nmi_shootdown_cpus()
+	 * stuff unnecessarily, but we don't have a way to check
+	 * if other CPUs have VMX enabled. So we will call it only if the
+	 * CPU we are running on has VMX enabled.
+	 *
+	 * We will miss cases where VMX is not enabled on all CPUs. This
+	 * shouldn't do much harm because KVM always enable VMX on all
+	 * CPUs anyway. But we can miss it on the small window where KVM
+	 * is still enabling VMX.
+	 */
+	if (cpu_has_vmx() && cpu_vmx_enabled()) {
+		/* Disable VMX on this CPU.
+		 */
+		cpu_vmxoff();
+
+		/* Halt and disable VMX on the other CPUs */
+		nmi_shootdown_cpus(vmxoff_nmi);
+
+	}
+}
+
+
 void __attribute__((weak)) mach_reboot_fixups(void)
 {
 }
@@ -367,6 +417,9 @@ static void native_machine_emergency_restart(void)
 {
 	int i;
 
+	if (reboot_emergency)
+		emergency_vmx_disable_all();
+
 	/* Tell the BIOS if we want cold or warm reboot */
 	*((unsigned short *)__va(0x472)) = reboot_mode;
 
@@ -473,13 +526,19 @@ void native_machine_shutdown(void)
 #endif
 }
 
+static void __machine_emergency_restart(int emergency)
+{
+	reboot_emergency = emergency;
+	machine_ops.emergency_restart();
+}
+
 static void native_machine_restart(char *__unused)
 {
 	printk("machine restart\n");
 
 	if (!reboot_force)
 		machine_shutdown();
-	machine_emergency_restart();
+	__machine_emergency_restart(0);
 }
 
 static void native_machine_halt(void)
@@ -523,7 +582,7 @@ void machine_shutdown(void)
 
 void machine_emergency_restart(void)
 {
-	machine_ops.emergency_restart();
+	__machine_emergency_restart(1);
 }
 
 void machine_restart(char *cmd)
-- 
1.5.5.GIT


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
