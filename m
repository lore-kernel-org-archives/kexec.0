Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1L0gF8-00020j-17
	for kexec@lists.infradead.org; Thu, 13 Nov 2008 17:44:34 +0000
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 03/11] x86: asm/virtext.h: add cpu_vmxoff() inline function
Date: Thu, 13 Nov 2008 15:43:43 -0200
Message-Id: <1226598231-18311-4-git-send-email-ehabkost@redhat.com>
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

Unfortunately we can't use exactly the same code from vmx
hardware_disable(), because the KVM function uses the
__kvm_handle_fault_on_reboot() tricks.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 arch/x86/include/asm/virtext.h |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
index 351fa23..475fb17 100644
--- a/arch/x86/include/asm/virtext.h
+++ b/arch/x86/include/asm/virtext.h
@@ -45,4 +45,17 @@ static inline int cpu_has_vmx(void)
 	return test_bit(5, &ecx); /* CPUID.1:ECX.VMX[bit 5] -> VT */
 }
 
+
+/** Disable VMX on the current CPU
+ *
+ * vmxoff causes a undefined-opcode exception if vmxon was not run
+ * on the CPU previously. Only call this function if you know VMX
+ * is enabled.
+ */
+static inline void cpu_vmxoff(void)
+{
+	asm volatile (ASM_VMX_VMXOFF : : : "cc");
+	write_cr4(read_cr4() & ~X86_CR4_VMXE);
+}
+
 #endif /* _ASM_X86_VIRTEX_H */
-- 
1.5.5.GIT


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
