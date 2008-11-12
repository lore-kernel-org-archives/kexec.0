Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1L0FsL-0006yt-OR
	for kexec@lists.infradead.org; Wed, 12 Nov 2008 13:35:18 +0000
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 1/8] x86 kdump: Extract kdump-specific code from
	crash_nmi_callback()
Date: Wed, 12 Nov 2008 11:34:37 -0200
Message-Id: <1226496884-24628-2-git-send-email-ehabkost@redhat.com>
In-Reply-To: <1226496884-24628-1-git-send-email-ehabkost@redhat.com>
References: <1226496884-24628-1-git-send-email-ehabkost@redhat.com>
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
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, Avi Kivity <avi@redhat.com>, Andrey Borzenkov <arvidjaar@mail.ru>, Vivek Goyal <vgoyal@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>

The NMI CPU-halting code will be used on non-kdump cases, also
(e.g. emergency_reboot when virtualization is enabled).

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 arch/x86/kernel/crash.c |   31 ++++++++++++++++++++-----------
 1 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 2685538..6047542 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -35,19 +35,34 @@ static int crashing_cpu;
 #if defined(CONFIG_SMP) && defined(CONFIG_X86_LOCAL_APIC)
 static atomic_t waiting_for_crash_ipi;
 
-static int crash_nmi_callback(struct notifier_block *self,
-			unsigned long val, void *data)
+static void kdump_nmi_callback(int cpu, struct die_args *args)
 {
 	struct pt_regs *regs;
 #ifdef CONFIG_X86_32
 	struct pt_regs fixed_regs;
 #endif
+
+	regs = args->regs;
+
+#ifdef CONFIG_X86_32
+	if (!user_mode_vm(regs)) {
+		crash_fixup_ss_esp(&fixed_regs, regs);
+		regs = &fixed_regs;
+	}
+#endif
+	crash_save_cpu(regs, cpu);
+
+	disable_local_APIC();
+}
+
+static int crash_nmi_callback(struct notifier_block *self,
+			unsigned long val, void *data)
+{
 	int cpu;
 
 	if (val != DIE_NMI_IPI)
 		return NOTIFY_OK;
 
-	regs = ((struct die_args *)data)->regs;
 	cpu = raw_smp_processor_id();
 
 	/* Don't do anything if this handler is invoked on crashing cpu.
@@ -58,14 +73,8 @@ static int crash_nmi_callback(struct notifier_block *self,
 		return NOTIFY_STOP;
 	local_irq_disable();
 
-#ifdef CONFIG_X86_32
-	if (!user_mode_vm(regs)) {
-		crash_fixup_ss_esp(&fixed_regs, regs);
-		regs = &fixed_regs;
-	}
-#endif
-	crash_save_cpu(regs, cpu);
-	disable_local_APIC();
+	kdump_nmi_callback(cpu, (struct die_args *)data);
+
 	atomic_dec(&waiting_for_crash_ipi);
 	/* Assume hlt works */
 	halt();
-- 
1.5.5.GIT


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
