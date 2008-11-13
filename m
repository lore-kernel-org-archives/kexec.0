Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1L0gF8-000215-Q9
	for kexec@lists.infradead.org; Thu, 13 Nov 2008 17:44:35 +0000
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 09/11] x86: asm/virtext.h: create cpu_emergency_svm_disable()
Date: Thu, 13 Nov 2008 15:43:49 -0200
Message-Id: <1226598231-18311-10-git-send-email-ehabkost@redhat.com>
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

This function can be used by the reboot or kdump code to forcibly
disable SVM on the CPU.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 arch/x86/include/asm/virtext.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
index 7281e10..e4f6bb0 100644
--- a/arch/x86/include/asm/virtext.h
+++ b/arch/x86/include/asm/virtext.h
@@ -142,4 +142,12 @@ static inline void cpu_svm_disable(void)
 	wrmsrl(MSR_EFER, efer & ~MSR_EFER_SVME_MASK);
 }
 
+/** Makes sure SVM is disabled, if it is supported on the CPU
+ */
+static inline void cpu_emergency_svm_disable(void)
+{
+	if (cpu_has_svm(NULL))
+		cpu_svm_disable();
+}
+
 #endif /* _ASM_X86_VIRTEX_H */
-- 
1.5.5.GIT


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
