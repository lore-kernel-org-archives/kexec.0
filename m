Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1L0gFC-00027S-1P
	for kexec@lists.infradead.org; Thu, 13 Nov 2008 17:44:38 +0000
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 01/11] kvm: vmx: move cpu_has_kvm_support() to an inline on
	asm/virtext.h
Date: Thu, 13 Nov 2008 15:43:41 -0200
Message-Id: <1226598231-18311-2-git-send-email-ehabkost@redhat.com>
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

It will be used by core code on kdump and reboot, to disable
vmx if needed.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 arch/x86/include/asm/virtext.h |   31 +++++++++++++++++++++++++++++++
 arch/x86/kvm/vmx.c             |    4 ++--
 2 files changed, 33 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/include/asm/virtext.h

diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
new file mode 100644
index 0000000..298b6a0
--- /dev/null
+++ b/arch/x86/include/asm/virtext.h
@@ -0,0 +1,31 @@
+/* CPU virtualization extensions handling
+ *
+ * This should carry the code for handling CPU virtualization extensions
+ * that needs to live in the kernel core.
+ *
+ * Author: Eduardo Habkost <ehabkost@redhat.com>
+ *
+ * Copyright (C) 2008, Red Hat Inc.
+ *
+ * Contains code from KVM, Copyright (C) 2006 Qumranet, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ */
+#ifndef _ASM_X86_VIRTEX_H
+#define _ASM_X86_VIRTEX_H
+
+#include <asm/processor.h>
+#include <asm/system.h>
+
+/*
+ * VMX functions:
+ */
+
+static inline int cpu_has_vmx(void)
+{
+	unsigned long ecx = cpuid_ecx(1);
+	return test_bit(5, &ecx); /* CPUID.1:ECX.VMX[bit 5] -> VT */
+}
+
+#endif /* _ASM_X86_VIRTEX_H */
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index d06b4dc..5cde1e3 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -31,6 +31,7 @@
 
 #include <asm/io.h>
 #include <asm/desc.h>
+#include <asm/virtext.h>
 
 #define __ex(x) __kvm_handle_fault_on_reboot(x)
 
@@ -1032,8 +1033,7 @@ static int vmx_get_irq(struct kvm_vcpu *vcpu)
 
 static __init int cpu_has_kvm_support(void)
 {
-	unsigned long ecx = cpuid_ecx(1);
-	return test_bit(5, &ecx); /* CPUID.1:ECX.VMX[bit 5] -> VT */
+	return cpu_has_vmx();
 }
 
 static __init int vmx_disabled_by_bios(void)
-- 
1.5.5.GIT


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
