Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MHBUl-000851-0o
	for kexec@lists.infradead.org; Thu, 18 Jun 2009 06:53:23 +0000
Received: from m2.gw.fujitsu.co.jp ([10.0.50.72])
	by fgwmail7.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	n5I6r91u026656 for <kexec@lists.infradead.org> (envelope-from
	seto.hidetoshi@jp.fujitsu.com); Thu, 18 Jun 2009 15:53:09 +0900
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id CDD3045DE63
	for <kexec@lists.infradead.org>; Thu, 18 Jun 2009 15:53:08 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 785EF45DE5D
	for <kexec@lists.infradead.org>; Thu, 18 Jun 2009 15:53:08 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 40BA61DB804B
	for <kexec@lists.infradead.org>; Thu, 18 Jun 2009 15:53:08 +0900 (JST)
Received: from m107.s.css.fujitsu.com (m107.s.css.fujitsu.com [10.249.87.107])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id C2D091DB803E
	for <kexec@lists.infradead.org>; Thu, 18 Jun 2009 15:53:07 +0900 (JST)
Message-ID: <4A39E451.2020100@jp.fujitsu.com>
Date: Thu, 18 Jun 2009 15:53:05 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH 7/7] ia64, kdump: Short path to freeze CPUs
References: <4A39E247.4030908@jp.fujitsu.com>
In-Reply-To: <4A39E247.4030908@jp.fujitsu.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Haren Myneni <hbabu@us.ibm.com>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>

Setting monarch_cpu = -1 to let slaves frozen might not work, because
there might be slaves being late, not entered the rendezvous yet.
Such slaves might be caught in while (monarch_cpu == -1) loop.

Use kdump_in_progress instead of monarch_cpus to break INIT rendezvous
and let all slaves enter DIE_INIT_SLAVE_LEAVE smoothly.

And monarch no longer need to manage rendezvous if once kdump_in_progress
is set, catch the monarch in DIE_INIT_MONARCH_ENTER then.

Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Haren Myneni <hbabu@us.ibm.com>
Cc: kexec@lists.infradead.org
---
 arch/ia64/kernel/crash.c |   15 ++++++---------
 arch/ia64/kernel/mca.c   |   15 +++++++++++++--
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/ia64/kernel/crash.c b/arch/ia64/kernel/crash.c
index f43eccf..cf833af 100644
--- a/arch/ia64/kernel/crash.c
+++ b/arch/ia64/kernel/crash.c
@@ -129,14 +129,13 @@ machine_crash_shutdown(struct pt_regs *pt)
 	 * If an INIT is asserted here:
 	 * - All receivers might be slaves, since some of cpus could already
 	 *   be frozen and INIT might be masked on monarch.  In this case,
-	 *   all slaves will park in while (monarch_cpu == -1) loop before
-	 *   DIE_INIT_SLAVE_ENTER that for waiting monarch enters.
-	 *	=> TBD: freeze all slaves
+	 *   all slaves will be frozen soon since kdump_in_progress will let
+	 *   them into DIE_INIT_SLAVE_LEAVE.
 	 * - One might be a monarch, but INIT rendezvous will fail since
 	 *   at least this cpu already have INIT masked so it never join
 	 *   to the rendezvous.  In this case, all slaves and monarch will
-	 *   be frozen after timeout of the INIT rendezvous.
-	 *	=> TBD: freeze them without waiting timeout
+	 *   be frozen soon with no wait since the INIT rendezvous is skipped
+	 *   by kdump_in_progress.
 	 */
 	kdump_smp_send_stop();
 	/* not all cpu response to IPI, send INIT to freeze them */
@@ -189,6 +188,7 @@ kdump_init_notifier(struct notifier_block *self, unsigned long val, void *data)
 				break;
 			/* fall through */
 		case DIE_INIT_SLAVE_LEAVE:
+		case DIE_INIT_MONARCH_ENTER:
 		case DIE_MCA_RENDZVOUS_LEAVE:
 			unw_init_running(kdump_cpu_freeze, NULL);
 			break;
@@ -219,7 +219,6 @@ kdump_init_notifier(struct notifier_block *self, unsigned long val, void *data)
 		if (kdump_on_init && (nd->sos->rv_rc != 1)) {
 			if (atomic_inc_return(&kdump_in_progress) != 1)
 				kdump_freeze_monarch = 1;
-			*(nd->monarch_cpu) = -1;
 		}
 		break;
 	case DIE_INIT_MONARCH_LEAVE:
@@ -230,10 +229,8 @@ kdump_init_notifier(struct notifier_block *self, unsigned long val, void *data)
 	case DIE_MCA_MONARCH_LEAVE:
 		/* *(nd->data) indicate if MCA is recoverable */
 		if (kdump_on_fatal_mca && !(*(nd->data))) {
-			if (atomic_inc_return(&kdump_in_progress) == 1) {
-				*(nd->monarch_cpu) = -1;
+			if (atomic_inc_return(&kdump_in_progress) == 1)
 				machine_kdump_on_init();
-			}
 			/* We got fatal MCA while kdump!? No way!! */
 		}
 		break;
diff --git a/arch/ia64/kernel/mca.c b/arch/ia64/kernel/mca.c
index 8f33a88..7a34c6c 100644
--- a/arch/ia64/kernel/mca.c
+++ b/arch/ia64/kernel/mca.c
@@ -1682,14 +1682,25 @@ ia64_init_handler(struct pt_regs *regs, struct switch_stack *sw,
 
 	if (!sos->monarch) {
 		ia64_mc_info.imi_rendez_checkin[cpu] = IA64_MCA_RENDEZ_CHECKIN_INIT;
+
+#ifdef CONFIG_KEXEC
+		while (monarch_cpu == -1 && !atomic_read(&kdump_in_progress))
+			udelay(1000);
+#else
 		while (monarch_cpu == -1)
-		       cpu_relax();	/* spin until monarch enters */
+			cpu_relax();	/* spin until monarch enters */
+#endif
 
 		NOTIFY_INIT(DIE_INIT_SLAVE_ENTER, regs, (long)&nd, 1);
 		NOTIFY_INIT(DIE_INIT_SLAVE_PROCESS, regs, (long)&nd, 1);
 
+#ifdef CONFIG_KEXEC
+		while (monarch_cpu != -1 && !atomic_read(&kdump_in_progress))
+			udelay(1000);
+#else
 		while (monarch_cpu != -1)
-		       cpu_relax();	/* spin until monarch leaves */
+			cpu_relax();	/* spin until monarch leaves */
+#endif
 
 		NOTIFY_INIT(DIE_INIT_SLAVE_LEAVE, regs, (long)&nd, 1);
 
-- 
1.6.0



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
