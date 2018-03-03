Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn3nam01on0101.outbound.protection.outlook.com
 ([104.47.33.101] helo=NAM01-BN3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1esFgj-00087N-7P
 for kexec@lists.infradead.org; Sat, 03 Mar 2018 22:31:50 +0000
From: Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 024/219] x86/mce: Handle broadcasted MCE
 gracefully with kexec
Date: Sat, 3 Mar 2018 22:28:09 +0000
Message-ID: <20180303222716.26640-24-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Content-Language: en-US
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Xunlei Pang <xlpang@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Sasha Levin <Alexander.Levin@microsoft.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>, linux-edac <linux-edac@vger.kernel.org>

From: Xunlei Pang <xlpang@redhat.com>

[ Upstream commit 5bc329503e8191c91c4c40836f062ef771d8ba83 ]

When we are about to kexec a crash kernel and right then and there a
broadcasted MCE fires while we're still in the first kernel and while
the other CPUs remain in a holding pattern, the #MC handler of the
first kernel will timeout and then panic due to never completing MCE
synchronization.

Handle this in a similar way as to when the CPUs are offlined when that
broadcasted MCE happens.

[ Boris: rewrote commit message and comments. ]

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Xunlei Pang <xlpang@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Tony Luck <tony.luck@intel.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: kexec@lists.infradead.org
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/1487857012-9059-1-git-send-email-xlpang@redhat.com
Link: http://lkml.kernel.org/r/20170313095019.19351-1-bp@alien8.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/include/asm/reboot.h    |  1 +
 arch/x86/kernel/cpu/mcheck/mce.c | 18 ++++++++++++++++--
 arch/x86/kernel/reboot.c         |  5 +++--
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/reboot.h b/arch/x86/include/asm/reboot.h
index 2cb1cc253d51..fc62ba8dce93 100644
--- a/arch/x86/include/asm/reboot.h
+++ b/arch/x86/include/asm/reboot.h
@@ -15,6 +15,7 @@ struct machine_ops {
 };
 
 extern struct machine_ops machine_ops;
+extern int crashing_cpu;
 
 void native_machine_crash_shutdown(struct pt_regs *regs);
 void native_machine_shutdown(void);
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index fe5cd6ea1f0e..b0cc7bd26ab5 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -48,6 +48,7 @@
 #include <asm/tlbflush.h>
 #include <asm/mce.h>
 #include <asm/msr.h>
+#include <asm/reboot.h>
 
 #include "mce-internal.h"
 
@@ -1078,9 +1079,22 @@ void do_machine_check(struct pt_regs *regs, long error_code)
 	 * on Intel.
 	 */
 	int lmce = 1;
+	int cpu = smp_processor_id();
 
-	/* If this CPU is offline, just bail out. */
-	if (cpu_is_offline(smp_processor_id())) {
+	/*
+	 * Cases where we avoid rendezvous handler timeout:
+	 * 1) If this CPU is offline.
+	 *
+	 * 2) If crashing_cpu was set, e.g. we're entering kdump and we need to
+	 *  skip those CPUs which remain looping in the 1st kernel - see
+	 *  crash_nmi_callback().
+	 *
+	 * Note: there still is a small window between kexec-ing and the new,
+	 * kdump kernel establishing a new #MC handler where a broadcasted MCE
+	 * might not get handled properly.
+	 */
+	if (cpu_is_offline(cpu) ||
+	    (crashing_cpu != -1 && crashing_cpu != cpu)) {
 		u64 mcgstatus;
 
 		mcgstatus = mce_rdmsrl(MSR_IA32_MCG_STATUS);
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index ce020a69bba9..03f21dbfaa9d 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -769,10 +769,11 @@ void machine_crash_shutdown(struct pt_regs *regs)
 #endif
 
 
+/* This is the CPU performing the emergency shutdown work. */
+int crashing_cpu = -1;
+
 #if defined(CONFIG_SMP)
 
-/* This keeps a track of which one is crashing cpu. */
-static int crashing_cpu;
 static nmi_shootdown_cb shootdown_callback;
 
 static atomic_t waiting_for_crash_ipi;
-- 
2.14.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
