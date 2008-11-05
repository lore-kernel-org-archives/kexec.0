Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KxoVJ-0007q3-As
	for kexec@lists.infradead.org; Wed, 05 Nov 2008 19:57:25 +0000
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 10/15] kdump: Hook emergency_virt_disable() on crash shutdown
	code
Date: Wed,  5 Nov 2008 17:56:53 -0200
Message-Id: <1225915018-6548-11-git-send-email-ehabkost@redhat.com>
In-Reply-To: <1225915018-6548-1-git-send-email-ehabkost@redhat.com>
References: <1225915018-6548-1-git-send-email-ehabkost@redhat.com>
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
Cc: Andrew Morton <akpm@osdl.org>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrey Borzenkov <arvidjaar@mail.ru>, mingo@redhat.com, Vivek Goyal <vgoyal@redhat.com>

[v2: add comments on source code, explaining why it is needed]

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 arch/x86/kernel/crash.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index d84a852..040f3ca 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -26,6 +26,7 @@
 #include <linux/kdebug.h>
 #include <asm/smp.h>
 #include <asm/reboot.h>
+#include <asm/virtext.h>
 
 #include <mach_ipi.h>
 
@@ -49,6 +50,11 @@ static void kdump_nmi_callback(int cpu, struct die_args *args)
 #endif
 	crash_save_cpu(regs, cpu);
 
+	/* We need to disable virtualization on all CPUs.
+	 * Having VMX or SVM enabled on any CPU may break rebooting
+	 * after the kdump kernel has finished its task.
+	 */
+	emergency_virt_disable();
 	disable_local_APIC();
 }
 
@@ -80,6 +86,13 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 	local_irq_disable();
 
 	kdump_nmi_shootdown_cpus();
+
+	/* Booting kdump kernel with VMX or SVM enabled won't work,
+	 * because (among other limitations) we can't disable paging
+	 * with the virt flags.
+	 */
+	emergency_virt_disable();
+
 	lapic_shutdown();
 #if defined(CONFIG_X86_IO_APIC)
 	disable_IO_APIC();
-- 
1.5.5.GIT


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
