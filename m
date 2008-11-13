Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1L0gFB-00023l-AE
	for kexec@lists.infradead.org; Thu, 13 Nov 2008 17:44:37 +0000
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 07/11] kvm: svm: move has_svm() code to asm/virtext.h
Date: Thu, 13 Nov 2008 15:43:47 -0200
Message-Id: <1226598231-18311-8-git-send-email-ehabkost@redhat.com>
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

Use a trick to keep the printk()s on has_svm() working as before. gcc
will take care of not generating code for the 'msg' stuff when the
function is called with a NULL msg argument.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 arch/x86/include/asm/virtext.h |   33 +++++++++++++++++++++++++++++++++
 arch/x86/kvm/svm.c             |   19 +++++--------------
 2 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
index f6adf9d..e900015 100644
--- a/arch/x86/include/asm/virtext.h
+++ b/arch/x86/include/asm/virtext.h
@@ -95,4 +95,37 @@ static inline void cpu_emergency_vmxoff(void)
 
 #define SVM_VM_CR_SVM_DISABLE 4
 
+/** Check if the CPU has SVM support
+ *
+ * You can use the 'msg' arg to get a message describing the problem,
+ * if the function returns zero. Simply pass NULL if you are not interested
+ * on the messages; gcc should take care of not generating code for
+ * the messages on this case.
+ */
+static inline int cpu_has_svm(const char **msg)
+{
+	uint32_t eax, ebx, ecx, edx;
+
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD) {
+		if (msg)
+			*msg = "not amd";
+		return 0;
+	}
+
+	cpuid(0x80000000, &eax, &ebx, &ecx, &edx);
+	if (eax < SVM_CPUID_FUNC) {
+		if (msg)
+			*msg = "can't execute cpuid_8000000a";
+		return 0;
+	}
+
+	cpuid(0x80000001, &eax, &ebx, &ecx, &edx);
+	if (!(ecx & (1 << SVM_CPUID_FEATURE_SHIFT))) {
+		if (msg)
+			*msg = "svm not available";
+		return 0;
+	}
+	return 1;
+}
+
 #endif /* _ASM_X86_VIRTEX_H */
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 9c4ce65..64241f5 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -28,6 +28,8 @@
 
 #include <asm/desc.h>
 
+#include <asm/virtext.h>
+
 #define __ex(x) __kvm_handle_fault_on_reboot(x)
 
 MODULE_AUTHOR("Qumranet");
@@ -245,24 +247,13 @@ static void skip_emulated_instruction(struct kvm_vcpu *vcpu)
 
 static int has_svm(void)
 {
-	uint32_t eax, ebx, ecx, edx;
-
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD) {
-		printk(KERN_INFO "has_svm: not amd\n");
-		return 0;
-	}
+	const char *msg;
 
-	cpuid(0x80000000, &eax, &ebx, &ecx, &edx);
-	if (eax < SVM_CPUID_FUNC) {
-		printk(KERN_INFO "has_svm: can't execute cpuid_8000000a\n");
+	if (!cpu_has_svm(&msg)) {
+		printk(KERN_INFO "has_svn: %s\n", msg);
 		return 0;
 	}
 
-	cpuid(0x80000001, &eax, &ebx, &ecx, &edx);
-	if (!(ecx & (1 << SVM_CPUID_FEATURE_SHIFT))) {
-		printk(KERN_DEBUG "has_svm: svm not available\n");
-		return 0;
-	}
 	return 1;
 }
 
-- 
1.5.5.GIT


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
