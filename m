Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1L2BGY-00030b-Ia
	for kexec@lists.infradead.org; Mon, 17 Nov 2008 21:04:14 +0000
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 09/12] kvm: svm: move svm_hardware_disable() code to
	asm/virtext.h
Date: Mon, 17 Nov 2008 19:03:21 -0200
Message-Id: <1226955804-16802-10-git-send-email-ehabkost@redhat.com>
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

Create cpu_svm_disable() function.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 arch/x86/include/asm/virtext.h |   14 ++++++++++++++
 arch/x86/kvm/svm.c             |    6 +-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
index 6f0d409..2cfe363 100644
--- a/arch/x86/include/asm/virtext.h
+++ b/arch/x86/include/asm/virtext.h
@@ -107,4 +107,18 @@ static inline int cpu_has_svm(const char **msg)
 	return 1;
 }
 
+
+/** Disable SVM on the current CPU
+ *
+ * You should call this only if cpu_has_svm() returned true.
+ */
+static inline void cpu_svm_disable(void)
+{
+	uint64_t efer;
+
+	wrmsrl(MSR_VM_HSAVE_PA, 0);
+	rdmsrl(MSR_EFER, efer);
+	wrmsrl(MSR_EFER, efer & ~MSR_EFER_SVME_MASK);
+}
+
 #endif /* _ASM_X86_VIRTEX_H */
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 64241f5..7ded2ee 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -259,11 +259,7 @@ static int has_svm(void)
 
 static void svm_hardware_disable(void *garbage)
 {
-	uint64_t efer;
-
-	wrmsrl(MSR_VM_HSAVE_PA, 0);
-	rdmsrl(MSR_EFER, efer);
-	wrmsrl(MSR_EFER, efer & ~MSR_EFER_SVME_MASK);
+	cpu_svm_disable();
 }
 
 static void svm_hardware_enable(void *garbage)
-- 
1.5.5.GIT


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
