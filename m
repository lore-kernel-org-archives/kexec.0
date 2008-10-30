Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KvXgC-0000LU-Ve
	for kexec@lists.infradead.org; Thu, 30 Oct 2008 13:35:27 +0000
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 4/6] kvm: vmx: crash_hardware_disable function
Date: Thu, 30 Oct 2008 11:34:44 -0200
Message-Id: <1225373687-6960-5-git-send-email-ehabkost@redhat.com>
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

We need to first check if virtualization was enabled. We do this by
checking CR4.VMXE. If it is set, run vmxoff and clear CR4.VMXE.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 arch/x86/kvm/vmx.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index ece9cb7..0f4e191 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1091,13 +1091,24 @@ static void vmclear_local_vcpus(void)
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
+static void crash_hardware_disable(void *garbage)
+{
+	if (read_cr4() & X86_CR4_VMXE)
+		__hardware_disable();
+}
+
 static __init int adjust_vmx_controls(u32 ctl_min, u32 ctl_opt,
 				      u32 msr, u32 *result)
 {
@@ -3589,6 +3600,7 @@ static struct kvm_x86_ops vmx_x86_ops = {
 	.check_processor_compatibility = vmx_check_processor_compat,
 	.hardware_enable = hardware_enable,
 	.hardware_disable = hardware_disable,
+	.crash_hardware_disable = crash_hardware_disable,
 	.cpu_has_accelerated_tpr = cpu_has_vmx_virtualize_apic_accesses,
 
 	.vcpu_create = vmx_create_vcpu,
-- 
1.5.5.GIT


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
