Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1L2BGV-0002lI-IX
	for kexec@lists.infradead.org; Mon, 17 Nov 2008 21:04:11 +0000
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 03/12] kvm: vmx: move ASM_VMX_* definitions from
	asm/kvm_host.h to asm/vmx.h
Date: Mon, 17 Nov 2008 19:03:15 -0200
Message-Id: <1226955804-16802-4-git-send-email-ehabkost@redhat.com>
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

Those definitions will be used by code outside KVM, so move it outside
of a KVM-specific source file.

Those definitions are used only on kvm/vmx.c, that already includes
asm/vmx.h, so they can be moved safely.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |   12 ------------
 arch/x86/include/asm/vmx.h      |   15 +++++++++++++++
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 8346be8..caad194 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -702,18 +702,6 @@ static inline void kvm_inject_gp(struct kvm_vcpu *vcpu, u32 error_code)
 	kvm_queue_exception_e(vcpu, GP_VECTOR, error_code);
 }
 
-#define ASM_VMX_VMCLEAR_RAX       ".byte 0x66, 0x0f, 0xc7, 0x30"
-#define ASM_VMX_VMLAUNCH          ".byte 0x0f, 0x01, 0xc2"
-#define ASM_VMX_VMRESUME          ".byte 0x0f, 0x01, 0xc3"
-#define ASM_VMX_VMPTRLD_RAX       ".byte 0x0f, 0xc7, 0x30"
-#define ASM_VMX_VMREAD_RDX_RAX    ".byte 0x0f, 0x78, 0xd0"
-#define ASM_VMX_VMWRITE_RAX_RDX   ".byte 0x0f, 0x79, 0xd0"
-#define ASM_VMX_VMWRITE_RSP_RDX   ".byte 0x0f, 0x79, 0xd4"
-#define ASM_VMX_VMXOFF            ".byte 0x0f, 0x01, 0xc4"
-#define ASM_VMX_VMXON_RAX         ".byte 0xf3, 0x0f, 0xc7, 0x30"
-#define ASM_VMX_INVEPT		  ".byte 0x66, 0x0f, 0x38, 0x80, 0x08"
-#define ASM_VMX_INVVPID		  ".byte 0x66, 0x0f, 0x38, 0x81, 0x08"
-
 #define MSR_IA32_TIME_STAMP_COUNTER		0x010
 
 #define TSS_IOPB_BASE_OFFSET 0x66
diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index ec5edc3..e8aa699 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -356,4 +356,19 @@ enum vmcs_field {
 
 #define VMX_EPT_IDENTITY_PAGETABLE_ADDR		0xfffbc000ul
 
+
+#define ASM_VMX_VMCLEAR_RAX       ".byte 0x66, 0x0f, 0xc7, 0x30"
+#define ASM_VMX_VMLAUNCH          ".byte 0x0f, 0x01, 0xc2"
+#define ASM_VMX_VMRESUME          ".byte 0x0f, 0x01, 0xc3"
+#define ASM_VMX_VMPTRLD_RAX       ".byte 0x0f, 0xc7, 0x30"
+#define ASM_VMX_VMREAD_RDX_RAX    ".byte 0x0f, 0x78, 0xd0"
+#define ASM_VMX_VMWRITE_RAX_RDX   ".byte 0x0f, 0x79, 0xd0"
+#define ASM_VMX_VMWRITE_RSP_RDX   ".byte 0x0f, 0x79, 0xd4"
+#define ASM_VMX_VMXOFF            ".byte 0x0f, 0x01, 0xc4"
+#define ASM_VMX_VMXON_RAX         ".byte 0xf3, 0x0f, 0xc7, 0x30"
+#define ASM_VMX_INVEPT		  ".byte 0x66, 0x0f, 0x38, 0x80, 0x08"
+#define ASM_VMX_INVVPID		  ".byte 0x66, 0x0f, 0x38, 0x81, 0x08"
+
+
+
 #endif
-- 
1.5.5.GIT


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
