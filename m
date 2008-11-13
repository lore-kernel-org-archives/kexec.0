Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1L0gF3-0001wP-7j
	for kexec@lists.infradead.org; Thu, 13 Nov 2008 17:44:29 +0000
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 02/11] kvm: vmx: move ASM_VMX_* definitions to asm/virtext.h
Date: Thu, 13 Nov 2008 15:43:42 -0200
Message-Id: <1226598231-18311-3-git-send-email-ehabkost@redhat.com>
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

Move the definitions so they can be used by non-kvm code.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |   14 ++------------
 arch/x86/include/asm/virtext.h  |   17 +++++++++++++++++
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 8346be8..5920e9a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -22,6 +22,8 @@
 #include <asm/pvclock-abi.h>
 #include <asm/desc.h>
 
+#include <asm/virtext.h>
+
 #define KVM_MAX_VCPUS 16
 #define KVM_MEMORY_SLOTS 32
 /* memory slots that does not exposed to userspace */
@@ -702,18 +704,6 @@ static inline void kvm_inject_gp(struct kvm_vcpu *vcpu, u32 error_code)
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
diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
index 298b6a0..351fa23 100644
--- a/arch/x86/include/asm/virtext.h
+++ b/arch/x86/include/asm/virtext.h
@@ -19,6 +19,23 @@
 #include <asm/system.h>
 
 /*
+ * VMX asm instructions:
+ */
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
+/*
  * VMX functions:
  */
 
-- 
1.5.5.GIT


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
