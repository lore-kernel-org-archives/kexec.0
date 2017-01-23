Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cVZYQ-0000tc-B3
 for kexec@lists.infradead.org; Mon, 23 Jan 2017 08:00:44 +0000
From: Xunlei Pang <xlpang@redhat.com>
Subject: [PATCH] x86/mce: Keep quiet in case of broadcasted mce after system
 panic
Date: Mon, 23 Jan 2017 16:01:51 +0800
Message-Id: <1485158511-22374-1-git-send-email-xlpang@redhat.com>
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

This patch lets cpus stay quiet when panic happens, so
before crash cpu shots them down or after kdump boots,
they should not do anything except clearing MCG_STATUS
in case of broadcasted mce. This is useful for kdump
to let the vmcore dumping perform as hard as it can.

Previous efforts:
https://patchwork.kernel.org/patch/6167631/
https://lists.gt.net/linux/kernel/2146557

Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Signed-off-by: Xunlei Pang <xlpang@redhat.com>
---
 arch/x86/kernel/cpu/mcheck/mce.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 00ef432..0c2bf77 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1157,6 +1157,23 @@ void do_machine_check(struct pt_regs *regs, long error_code)
 
 	mce_gather_info(&m, regs);
 
+	/*
+	 * Check if this MCE is signaled to only this logical processor,
+	 * on Intel only.
+	 */
+	if (m.cpuvendor == X86_VENDOR_INTEL)
+		lmce = m.mcgstatus & MCG_STATUS_LMCES;
+
+	/*
+	 * Special treatment for Intel broadcasted machine check:
+	 * To avoid panic due to MCE synchronization in case of kdump,
+	 * after system panic, clear global status and bail out.
+	 */
+	if (!lmce && atomic_read(&panic_cpu) != PANIC_CPU_INVALID) {
+		wrmsrl(MSR_IA32_MCG_STATUS, 0);
+		goto out;
+	}
+
 	final = this_cpu_ptr(&mces_seen);
 	*final = m;
 
@@ -1174,13 +1191,6 @@ void do_machine_check(struct pt_regs *regs, long error_code)
 		kill_it = 1;
 
 	/*
-	 * Check if this MCE is signaled to only this logical processor,
-	 * on Intel only.
-	 */
-	if (m.cpuvendor == X86_VENDOR_INTEL)
-		lmce = m.mcgstatus & MCG_STATUS_LMCES;
-
-	/*
 	 * Go through all banks in exclusion of the other CPUs. This way we
 	 * don't report duplicated events on shared banks because the first one
 	 * to see it will clear it. If this is a Local MCE, then no need to
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
