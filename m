Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1ckqdw-0000mh-V7
 for kexec@lists.infradead.org; Mon, 06 Mar 2017 11:17:35 +0000
Date: Mon, 6 Mar 2017 12:16:54 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4] x86/mce: Don't participate in rendezvous process once
 nmi_shootdown_cpus() was made
Message-ID: <20170306111654.xmmizzae4assppk3@pd.tnic>
References: <1487857012-9059-1-git-send-email-xlpang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1487857012-9059-1-git-send-email-xlpang@redhat.com>
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
To: Xunlei Pang <xlpang@redhat.com>, Tony Luck <tony.luck@intel.com>
Cc: Prarit Bhargava <prarit@redhat.com>, Kiyoshi Ueda <k-ueda@ct.jp.nec.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Junichi Nomura <j-nomura@ce.jp.nec.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Dave Young <dyoung@redhat.com>

On Thu, Feb 23, 2017 at 09:36:52PM +0800, Xunlei Pang wrote:
> We met an issue for kdump: after kdump kernel boots up,
> and there comes a broadcasted mce in first kernel, the
> other cpus remaining in first kernel will enter the old
> mce handler of first kernel, then timeout and panic due
> to MCE synchronization, finally reset the kdump cpus.
> 
> This patch lets cpus stay quiet after nmi_shootdown_cpus(),
> so after kdump boots, cpus remaining in 1st kernel should
> not do anything except clearing MCG_STATUS. This is useful
> for kdump to let vmcore dumping perform as hard as it can.

Ok, I went and rewrote the text to make it more succinct, to the point
and correct spelling and formatting.

Tony, ACK?

---
From 2d76fdd4044b4659bb8746948b986e3f4eb75e22 Mon Sep 17 00:00:00 2001
From: Xunlei Pang <xlpang@redhat.com>
Date: Thu, 23 Feb 2017 21:36:52 +0800
Subject: [PATCH] x86/mce: Handle broadcasted MCE gracefully with kexec

When we are about to kexec a crash kernel and right then and there
a broadcasted MCE fires while we're still in first kernel and while
the other CPUs remain in a holding pattern, the #MC handler of the
first kernel will timeout and then panic due to never completing MCE
synchronization.

Handle this in a similar way to as when the CPUs are offlined when that
broadcasted MCE happens.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Xunlei Pang <xlpang@redhat.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: kexec@lists.infradead.org
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: x86-ml <x86@kernel.org>
Link: http://lkml.kernel.org/r/1487857012-9059-1-git-send-email-xlpang@redhat.com
[ Boris: rewrote commit message and comments. ]
Signed-off-by: Borislav Petkov <bp@suse.de>
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
index 8e9725c607ea..177472ace838 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -49,6 +49,7 @@
 #include <asm/tlbflush.h>
 #include <asm/mce.h>
 #include <asm/msr.h>
+#include <asm/reboot.h>
 
 #include "mce-internal.h"
 
@@ -1127,9 +1128,22 @@ void do_machine_check(struct pt_regs *regs, long error_code)
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
index e244c19a2451..d3718cc5edbf 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -749,10 +749,11 @@ void machine_crash_shutdown(struct pt_regs *regs)
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
2.11.0

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
