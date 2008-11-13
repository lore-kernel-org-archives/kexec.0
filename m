Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1L0gFD-0002Ac-Cu
	for kexec@lists.infradead.org; Thu, 13 Nov 2008 17:44:39 +0000
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 06/11] kvm: svm: move some SVM_* #defines to asm/virtext.h
Date: Thu, 13 Nov 2008 15:43:46 -0200
Message-Id: <1226598231-18311-7-git-send-email-ehabkost@redhat.com>
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

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 arch/x86/include/asm/virtext.h |   14 ++++++++++++++
 arch/x86/kvm/svm.h             |   12 +++---------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
index 2d090f3..f6adf9d 100644
--- a/arch/x86/include/asm/virtext.h
+++ b/arch/x86/include/asm/virtext.h
@@ -81,4 +81,18 @@ static inline void cpu_emergency_vmxoff(void)
 		__cpu_emergency_vmxoff();
 }
 
+
+/*
+ * SVM functions:
+ */
+
+#define SVM_CPUID_FEATURE_SHIFT 2
+#define SVM_CPUID_FUNC 0x8000000a
+
+#define MSR_EFER_SVME_MASK (1ULL << 12)
+#define MSR_VM_CR       0xc0010114
+#define MSR_VM_HSAVE_PA 0xc0010117ULL
+
+#define SVM_VM_CR_SVM_DISABLE 4
+
 #endif /* _ASM_X86_VIRTEX_H */
diff --git a/arch/x86/kvm/svm.h b/arch/x86/kvm/svm.h
index 1b8afa7..4649f5c 100644
--- a/arch/x86/kvm/svm.h
+++ b/arch/x86/kvm/svm.h
@@ -1,6 +1,9 @@
 #ifndef __SVM_H
 #define __SVM_H
 
+#include <asm/virtext.h>
+
+
 enum {
 	INTERCEPT_INTR,
 	INTERCEPT_NMI,
@@ -171,15 +174,6 @@ struct __attribute__ ((__packed__)) vmcb {
 	struct vmcb_save_area save;
 };
 
-#define SVM_CPUID_FEATURE_SHIFT 2
-#define SVM_CPUID_FUNC 0x8000000a
-
-#define MSR_EFER_SVME_MASK (1ULL << 12)
-#define MSR_VM_CR       0xc0010114
-#define MSR_VM_HSAVE_PA 0xc0010117ULL
-
-#define SVM_VM_CR_SVM_DISABLE 4
-
 #define SVM_SELECTOR_S_SHIFT 4
 #define SVM_SELECTOR_DPL_SHIFT 5
 #define SVM_SELECTOR_P_SHIFT 7
-- 
1.5.5.GIT


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
