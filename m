Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KxoVJ-0007uH-Qs
	for kexec@lists.infradead.org; Wed, 05 Nov 2008 19:57:26 +0000
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 14/15] kvm: vmx: crash_hardware_disable function
Date: Wed,  5 Nov 2008 17:56:57 -0200
Message-Id: <1225915018-6548-15-git-send-email-ehabkost@redhat.com>
In-Reply-To: <1225915018-6548-1-git-send-email-ehabkost@redhat.com>
References: <1225915018-6548-1-git-send-email-ehabkost@redhat.com>
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
Cc: Andrew Morton <akpm@osdl.org>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrey Borzenkov <arvidjaar@mail.ru>, mingo@redhat.com, Vivek Goyal <vgoyal@redhat.com>

We need to first check if virtualization was enabled. We do this by
checking CR4.VMXE. If it is set, run vmxoff and clear CR4.VMXE.

Register it using set_virt_disable_func() on hardware_setup, and
unregister it on hardware_unsetup.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 arch/x86/kvm/vmx.c |   40 +++++++++++++++++++++++++++++++++++-----
 1 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index ece9cb7..4b10768 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -31,6 +31,7 @@
 
 #include <asm/io.h>
 #include <asm/desc.h>
+#include <asm/virtext.h>
 
 #define __ex(x) __kvm_handle_fault_on_reboot(x)
 
@@ -1091,13 +1092,24 @@ static void vmclear_local_vcpus(void)
 		__vcpu_clear(vmx);
 }
 
-static void hardware_disable(void *garbage)
+static void __hardware_disable(void)
 {
-	vmclear_local_vcpus();
 	asm volatile (__ex(ASM_VMX_VMXOFF) : : : "cc");
 	write_cr4(read_cr4() & ~X86_CR4_VMXE);
 }
 
+static void hardware_disable(void *garbage)
+{
+	vmclear_local_vcpus();
+	__hardware_disable();
+}
+
+static void crash_hardware_disable(void)
+{
+	if (read_cr4() & X86_CR4_VMXE)
+		__hardware_disable();
+}
+
 static __init int adjust_vmx_controls(u32 ctl_min, u32 ctl_opt,
 				      u32 msr, u32 *result)
 {
@@ -1281,18 +1293,36 @@ static __init int alloc_kvm_area(void)
 
 static __init int hardware_setup(void)
 {
-	if (setup_vmcs_config(&vmcs_config) < 0)
-		return -EIO;
+	int r;
+
+	r = set_virt_disable_func(crash_hardware_disable);
+	if (r)
+		goto err;
+
+	if (setup_vmcs_config(&vmcs_config) < 0) {
+		r = -EIO;
+		goto err_clear_virt_disable;
+	}
 
 	if (boot_cpu_has(X86_FEATURE_NX))
 		kvm_enable_efer_bits(EFER_NX);
 
-	return alloc_kvm_area();
+	r = alloc_kvm_area();
+	if (r)
+		goto err_clear_virt_disable;
+
+	return 0;
+
+err_clear_virt_disable:
+	clear_virt_disable_func();
+err:
+	return r;
 }
 
 static __exit void hardware_unsetup(void)
 {
 	free_kvm_area();
+	clear_virt_disable_func();
 }
 
 static void fix_pmode_dataseg(int seg, struct kvm_save_segment *save)
-- 
1.5.5.GIT


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
