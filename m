Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1L0gFA-00023M-PJ
	for kexec@lists.infradead.org; Thu, 13 Nov 2008 17:44:37 +0000
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 05/11] x86: cpu_emergency_vmxoff() function
Date: Thu, 13 Nov 2008 15:43:45 -0200
Message-Id: <1226598231-18311-6-git-send-email-ehabkost@redhat.com>
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

Add cpu_emergency_vmxoff() and its friends: cpu_vmx_enabled() and
__cpu_emergency_vmxoff().

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 arch/x86/include/asm/virtext.h |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
index 475fb17..2d090f3 100644
--- a/arch/x86/include/asm/virtext.h
+++ b/arch/x86/include/asm/virtext.h
@@ -58,4 +58,27 @@ static inline void cpu_vmxoff(void)
 	write_cr4(read_cr4() & ~X86_CR4_VMXE);
 }
 
+static inline int cpu_vmx_enabled(void)
+{
+	return read_cr4() & X86_CR4_VMXE;
+}
+
+/** Disable VMX if it is enabled on the current CPU
+ *
+ * You shouldn't call this if cpu_has_vmx() returns 0.
+ */
+static inline void __cpu_emergency_vmxoff(void)
+{
+	if (cpu_vmx_enabled())
+		cpu_vmxoff();
+}
+
+/** Disable VMX if it is supportd and enabled on the current CPU
+ */
+static inline void cpu_emergency_vmxoff(void)
+{
+	if (cpu_has_vmx())
+		__cpu_emergency_vmxoff();
+}
+
 #endif /* _ASM_X86_VIRTEX_H */
-- 
1.5.5.GIT


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
