Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cgOF1-00060W-Oz
 for kexec@lists.infradead.org; Wed, 22 Feb 2017 04:09:31 +0000
From: Xunlei Pang <xlpang@redhat.com>
Subject: [PATCH v3] x86/mce: Don't participate in rendezvous process once
 nmi_shootdown_cpus() was made
Date: Wed, 22 Feb 2017 12:11:14 +0800
Message-Id: <1487736674-2058-1-git-send-email-xlpang@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: x86@kernel.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Cc: Prarit Bhargava <prarit@redhat.com>, Kiyoshi Ueda <k-ueda@ct.jp.nec.com>, Tony Luck <tony.luck@intel.com>, Xunlei Pang <xlpang@redhat.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Junichi Nomura <j-nomura@ce.jp.nec.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Dave Young <dyoung@redhat.com>

We met an issue for kdump: after kdump kernel boots up,
and there comes a broadcasted mce in first kernel, the
other cpus remaining in first kernel will enter the old
mce handler of first kernel, then timeout and panic due
to MCE synchronization, finally reset the kdump cpus.

This patch lets cpus stay quiet after nmi_shootdown_cpus(),
so after kdump boots, cpus remaining in 1st kernel should 
not do anything except clearing MCG_STATUS. This is useful
for kdump to let vmcore dumping perform as hard as it can.

Previous efforts:
https://patchwork.kernel.org/patch/6167631/
https://lists.gt.net/linux/kernel/2146557

Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Xunlei Pang <xlpang@redhat.com>
---
v1->v2:
Using crashing_cpu according to Borislav's suggestion.

v2->v3:
- Used crashing_cpu in mce.c explicitly, not skip crashing_cpu.
- Added some comments.

 arch/x86/include/asm/reboot.h    |  1 +
 arch/x86/kernel/cpu/mcheck/mce.c | 12 ++++++++++--
 arch/x86/kernel/reboot.c         |  5 +++--
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/reboot.h b/arch/x86/include/asm/reboot.h
index 2cb1cc2..fc62ba8 100644
--- a/arch/x86/include/asm/reboot.h
+++ b/arch/x86/include/asm/reboot.h
@@ -15,6 +15,7 @@ struct machine_ops {
 };
 
 extern struct machine_ops machine_ops;
+extern int crashing_cpu;
 
 void native_machine_crash_shutdown(struct pt_regs *regs);
 void native_machine_shutdown(void);
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 8e9725c..1493222 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -49,6 +49,7 @@
 #include <asm/tlbflush.h>
 #include <asm/mce.h>
 #include <asm/msr.h>
+#include <asm/reboot.h>
 
 #include "mce-internal.h"
 
@@ -1127,9 +1128,16 @@ void do_machine_check(struct pt_regs *regs, long error_code)
 	 * on Intel.
 	 */
 	int lmce = 1;
+	int cpu = smp_processor_id();
 
-	/* If this CPU is offline, just bail out. */
-	if (cpu_is_offline(smp_processor_id())) {
+	/*
+	 * Cases to bail out to avoid rendezvous process timeout:
+	 * 1)If this CPU is offline.
+	 * 2)If crashing_cpu was set, e.g. entering kdump,
+	 *   we need to skip cpus remaining in 1st kernel.
+	 */
+	if (cpu_is_offline(cpu) ||
+	    (crashing_cpu != -1 && crashing_cpu != cpu)) {
 		u64 mcgstatus;
 
 		mcgstatus = mce_rdmsrl(MSR_IA32_MCG_STATUS);
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index e244c19..92ecf4b 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -749,10 +749,11 @@ void machine_crash_shutdown(struct pt_regs *regs)
 #endif
 
 
+/* This keeps a track of which one is crashing cpu. */
+int crashing_cpu = -1;
+
 #if defined(CONFIG_SMP)
 
-/* This keeps a track of which one is crashing cpu. */
-static int crashing_cpu;
 static nmi_shootdown_cb shootdown_callback;
 
 static atomic_t waiting_for_crash_ipi;
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
