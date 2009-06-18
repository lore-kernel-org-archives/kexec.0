Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MHBSd-0007hl-Vb
	for kexec@lists.infradead.org; Thu, 18 Jun 2009 06:51:07 +0000
Received: from m1.gw.fujitsu.co.jp ([10.0.50.71])
	by fgwmail6.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	n5I6owuk019766 for <kexec@lists.infradead.org> (envelope-from
	seto.hidetoshi@jp.fujitsu.com); Thu, 18 Jun 2009 15:50:58 +0900
Received: from smail (m1 [127.0.0.1])
	by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 26BAE45DE5B
	for <kexec@lists.infradead.org>; Thu, 18 Jun 2009 15:50:56 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id D48C445DE51
	for <kexec@lists.infradead.org>; Thu, 18 Jun 2009 15:50:55 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 2AC59E08005
	for <kexec@lists.infradead.org>; Thu, 18 Jun 2009 15:50:55 +0900 (JST)
Received: from m107.s.css.fujitsu.com (m107.s.css.fujitsu.com [10.249.87.107])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 907451DB803E
	for <kexec@lists.infradead.org>; Thu, 18 Jun 2009 15:50:54 +0900 (JST)
Message-ID: <4A39E3C9.2040906@jp.fujitsu.com>
Date: Thu, 18 Jun 2009 15:50:49 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH 5/7] ia64, kdump: Mask INIT first in panic-kdump path
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

This is a fix for races on Panic and INIT.

Asserting INIT might not invoke 2nd kdump if the system is going to start
1st kdump via panic and some of cpus are already playing dead with INIT
masked.  It can be assumed that an internal agent decides to panic the
unstable system while another external agent decides to send an INIT to
the system at same time.

So mask INIT first in panic path to take the initiative on kdump.
All INITs later should be used only for freezing all other cpus.

Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Haren Myneni <hbabu@us.ibm.com>
Cc: kexec@lists.infradead.org
---
 arch/ia64/kernel/crash.c |   47 ++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/arch/ia64/kernel/crash.c b/arch/ia64/kernel/crash.c
index eacedfc..1440445 100644
--- a/arch/ia64/kernel/crash.c
+++ b/arch/ia64/kernel/crash.c
@@ -23,6 +23,7 @@
 int kdump_status[NR_CPUS];
 static atomic_t kdump_cpu_frozen;
 atomic_t kdump_in_progress;
+static int kdump_freeze_monarch;
 static int kdump_on_init = 1;
 static int kdump_on_fatal_mca = 1;
 
@@ -110,6 +111,33 @@ machine_crash_shutdown(struct pt_regs *pt)
 	 */
 	kexec_disable_iosapic();
 #ifdef CONFIG_SMP
+	/*
+	 * If kdump_on_init is set and an INIT is assered here, kdump will
+	 * be started again via INIT monarch.
+	 */
+	local_irq_disable();
+	ia64_set_psr_mc();	/* mask MCA/INIT */
+	if (atomic_inc_return(&kdump_in_progress) != 1)
+		unw_init_running(kdump_cpu_freeze, NULL);		
+
+	/*
+	 * Now this cpu is ready for kdump.
+	 * Stop all others by IPI or INIT.  They could receive INIT from
+	 * outside and might be INIT monarch, but only thing they have to
+	 * do is falling into kdump_cpu_freeze().
+	 *
+	 * If an INIT is asserted here:
+	 * - All receivers might be slaves, since some of cpus could already
+	 *   be frozen and INIT might be masked on monarch.  In this case,
+	 *   all slaves will park in while (monarch_cpu == -1) loop before
+	 *   DIE_INIT_SLAVE_ENTER that for waiting monarch enters.
+	 *	=> TBD: freeze all slaves
+	 * - One might be a monarch, but INIT rendezvous will fail since
+	 *   at least this cpu already have INIT masked so it never join
+	 *   to the rendezvous.  In this case, all slaves and monarch will
+	 *   be frozen after timeout of the INIT rendezvous.
+	 *	=> TBD: freeze them without waiting timeout
+	 */
 	kdump_smp_send_stop();
 	/* not all cpu response to IPI, send INIT to freeze them */
 	if (kdump_wait_cpu_freeze() && kdump_on_init) 	{
@@ -179,13 +207,18 @@ kdump_init_notifier(struct notifier_block *self, unsigned long val, void *data)
 	switch (val) {
 	case DIE_INIT_MONARCH_PROCESS:
 		if (kdump_on_init) {
-			atomic_set(&kdump_in_progress, 1);
+			if (atomic_inc_return(&kdump_in_progress) != 1)
+				kdump_freeze_monarch = 1;
 			*(nd->monarch_cpu) = -1;
 		}
 		break;
 	case DIE_INIT_MONARCH_LEAVE:
-		if (kdump_on_init)
-			machine_kdump_on_init();
+		if (kdump_on_init) {
+			if (kdump_freeze_monarch)
+				unw_init_running(kdump_cpu_freeze, NULL);
+			else
+				machine_kdump_on_init();
+		}
 		break;
 	case DIE_INIT_SLAVE_LEAVE:
 		if (atomic_read(&kdump_in_progress))
@@ -198,9 +231,11 @@ kdump_init_notifier(struct notifier_block *self, unsigned long val, void *data)
 	case DIE_MCA_MONARCH_LEAVE:
 		/* *(nd->data) indicate if MCA is recoverable */
 		if (kdump_on_fatal_mca && !(*(nd->data))) {
-			atomic_set(&kdump_in_progress, 1);
-			*(nd->monarch_cpu) = -1;
-			machine_kdump_on_init();
+			if (atomic_inc_return(&kdump_in_progress) == 1) {
+				*(nd->monarch_cpu) = -1;
+				machine_kdump_on_init();
+			}
+			/* We got fatal MCA while kdump!? No way!! */
 		}
 		break;
 	}
-- 
1.6.0



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
