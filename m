Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cfhA5-0007HN-C5
 for kexec@lists.infradead.org; Mon, 20 Feb 2017 06:09:27 +0000
From: Xunlei Pang <xlpang@redhat.com>
Subject: [PATCH v2] x86/mce: Don't participate in rendezvous process once
 nmi_shootdown_cpus() was made
Date: Mon, 20 Feb 2017 14:10:37 +0800
Message-Id: <1487571037-10821-1-git-send-email-xlpang@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: x86@kernel.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Cc: Prarit Bhargava <prarit@redhat.com>, Kiyoshi Ueda <k-ueda@ct.jp.nec.com>, Tony Luck <tony.luck@intel.com>, Xunlei Pang <xlpang@redhat.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Junichi Nomura <j-nomura@ce.jp.nec.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Dave Young <dyoung@redhat.com>

We met an issue for kdump: after kdump kernel boots up,
and there comes a broadcasted mce in first kernel, the
other cpus remaining in first kernel will enter the old
mce handler of first kernel, then timeout and panic due
to MCE synchronization, finally reset the kdump cpus.

This patch lets cpus stay quiet after nmi_shootdown_cpus(),
so before crash cpu shots them down or after kdump boots,
they should not do anything except clearing MCG_STATUS
in case of broadcasted mce. This is useful for kdump
to let the vmcore dumping perform as hard as it can.

Previous efforts:
https://patchwork.kernel.org/patch/6167631/
https://lists.gt.net/linux/kernel/2146557

Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Xunlei Pang <xlpang@redhat.com>
---
v1->v2:
Using crashing_cpu according to Borislav's suggestion.

 arch/x86/include/asm/reboot.h    |  1 +
 arch/x86/kernel/cpu/mcheck/mce.c |  6 ++++--
 arch/x86/kernel/reboot.c         | 16 +++++++++++++++-
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/reboot.h b/arch/x86/include/asm/reboot.h
index 2cb1cc2..ec8657b6 100644
--- a/arch/x86/include/asm/reboot.h
+++ b/arch/x86/include/asm/reboot.h
@@ -26,5 +26,6 @@ struct machine_ops {
 typedef void (*nmi_shootdown_cb)(int, struct pt_regs*);
 void nmi_shootdown_cpus(nmi_shootdown_cb callback);
 void run_crash_ipi_callback(struct pt_regs *regs);
+bool cpus_shotdown(void);
 
 #endif /* _ASM_X86_REBOOT_H */
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 8e9725c..3b56710 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -49,6 +49,7 @@
 #include <asm/tlbflush.h>
 #include <asm/mce.h>
 #include <asm/msr.h>
+#include <asm/reboot.h>
 
 #include "mce-internal.h"
 
@@ -1128,8 +1129,9 @@ void do_machine_check(struct pt_regs *regs, long error_code)
 	 */
 	int lmce = 1;
 
-	/* If this CPU is offline, just bail out. */
-	if (cpu_is_offline(smp_processor_id())) {
+	/* If nmi shootdown happened or this CPU is offline, just bail out. */
+	if (cpus_shotdown() ||
+	    cpu_is_offline(smp_processor_id())) {
 		u64 mcgstatus;
 
 		mcgstatus = mce_rdmsrl(MSR_IA32_MCG_STATUS);
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index e244c19..b301c8d 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -752,7 +752,7 @@ void machine_crash_shutdown(struct pt_regs *regs)
 #if defined(CONFIG_SMP)
 
 /* This keeps a track of which one is crashing cpu. */
-static int crashing_cpu;
+static int crashing_cpu = -1;
 static nmi_shootdown_cb shootdown_callback;
 
 static atomic_t waiting_for_crash_ipi;
@@ -852,6 +852,14 @@ void nmi_panic_self_stop(struct pt_regs *regs)
 	}
 }
 
+bool cpus_shotdown(void)
+{
+	if (crashing_cpu != -1)
+		return true;
+
+	return false;
+}
+
 #else /* !CONFIG_SMP */
 void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 {
@@ -861,4 +869,10 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 void run_crash_ipi_callback(struct pt_regs *regs)
 {
 }
+
+bool cpus_shotdown(void)
+{
+	return false;
+}
+
 #endif
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
