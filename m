Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MOnsu-00069M-0c
	for kexec@lists.infradead.org; Thu, 09 Jul 2009 07:17:43 +0000
Received: from m6.gw.fujitsu.co.jp ([10.0.50.76])
	by fgwmail7.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	n697HWQ0017921 for <kexec@lists.infradead.org> (envelope-from
	seto.hidetoshi@jp.fujitsu.com); Thu, 9 Jul 2009 16:17:34 +0900
Received: from smail (m6 [127.0.0.1])
	by outgoing.m6.gw.fujitsu.co.jp (Postfix) with ESMTP id 57A2845DE50
	for <kexec@lists.infradead.org>; Thu,  9 Jul 2009 16:17:32 +0900 (JST)
Received: from s6.gw.fujitsu.co.jp (s6.gw.fujitsu.co.jp [10.0.50.96])
	by m6.gw.fujitsu.co.jp (Postfix) with ESMTP id 3245245DE4F
	for <kexec@lists.infradead.org>; Thu,  9 Jul 2009 16:17:32 +0900 (JST)
Received: from s6.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s6.gw.fujitsu.co.jp (Postfix) with ESMTP id 199C51DB8037
	for <kexec@lists.infradead.org>; Thu,  9 Jul 2009 16:17:32 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.249.87.104])
	by s6.gw.fujitsu.co.jp (Postfix) with ESMTP id BB01DE08003
	for <kexec@lists.infradead.org>; Thu,  9 Jul 2009 16:17:28 +0900 (JST)
Message-ID: <4A55997E.8020903@jp.fujitsu.com>
Date: Thu, 09 Jul 2009 16:17:18 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH v2 6/7] ia64, kdump: Try INIT regardless of kdump_on_init
References: <4A39E247.4030908@jp.fujitsu.com> <4A5595F3.2050609@jp.fujitsu.com>
In-Reply-To: <4A5595F3.2050609@jp.fujitsu.com>
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
Cc: Haren Myneni <hbabu@us.ibm.com>, "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>, "Yu,
	Fenghua" <fenghua.yu@intel.com>

CPUs should be frozen if possible, otherwise it might hinder kdump.
So if there are CPUs not respond to IPI, try INIT to stop them.

Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Haren Myneni <hbabu@us.ibm.com>
Cc: kexec@lists.infradead.org
---
 arch/ia64/kernel/crash.c |   43 +++++++++++++++++++++----------------------
 1 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/arch/ia64/kernel/crash.c b/arch/ia64/kernel/crash.c
index 9c851b7..0995fdc 100644
--- a/arch/ia64/kernel/crash.c
+++ b/arch/ia64/kernel/crash.c
@@ -138,8 +138,10 @@ machine_crash_shutdown(struct pt_regs *pt)
 	 */
 	kdump_smp_send_stop();
 	/* not all cpu response to IPI, send INIT to freeze them */
-	if (kdump_wait_cpu_freeze() && kdump_on_init) 	{
+	if (kdump_wait_cpu_freeze()) {
 		kdump_smp_send_init();
+		/* wait again, don't go ahead if possible */
+		kdump_wait_cpu_freeze();
 	}
 #endif
 }
@@ -178,6 +180,19 @@ kdump_init_notifier(struct notifier_block *self, unsigned long val, void *data)
 	struct ia64_mca_notify_die *nd;
 	struct die_args *args = data;
 
+	if (atomic_read(&kdump_in_progress)) {
+		switch (val) {
+		case DIE_INIT_MONARCH_LEAVE:
+			if (!kdump_freeze_monarch)
+				break;
+			/* fall through */
+		case DIE_INIT_SLAVE_LEAVE:
+		case DIE_MCA_RENDZVOUS_LEAVE:
+			unw_init_running(kdump_cpu_freeze, NULL);
+			break;
+		}
+	}
+
 	if (!kdump_on_init && !kdump_on_fatal_mca)
 		return NOTIFY_DONE;
 
@@ -190,41 +205,25 @@ kdump_init_notifier(struct notifier_block *self, unsigned long val, void *data)
 	}
 
 	if (val != DIE_INIT_MONARCH_LEAVE &&
-	    val != DIE_INIT_SLAVE_LEAVE &&
 	    val != DIE_INIT_MONARCH_PROCESS &&
-	    val != DIE_MCA_RENDZVOUS_LEAVE &&
 	    val != DIE_MCA_MONARCH_LEAVE)
 		return NOTIFY_DONE;
 
 	nd = (struct ia64_mca_notify_die *)args->err;
-	/* Reason code 1 means machine check rendezvous*/
-	if ((val == DIE_INIT_MONARCH_LEAVE || val == DIE_INIT_SLAVE_LEAVE
-	    || val == DIE_INIT_MONARCH_PROCESS) && nd->sos->rv_rc == 1)
-		return NOTIFY_DONE;
 
 	switch (val) {
 	case DIE_INIT_MONARCH_PROCESS:
-		if (kdump_on_init) {
+		/* Reason code 1 means machine check rendezvous*/
+		if (kdump_on_init && (nd->sos->rv_rc != 1)) {
 			if (atomic_inc_return(&kdump_in_progress) != 1)
 				kdump_freeze_monarch = 1;
 			*(nd->monarch_cpu) = -1;
 		}
 		break;
 	case DIE_INIT_MONARCH_LEAVE:
-		if (kdump_on_init) {
-			if (kdump_freeze_monarch)
-				unw_init_running(kdump_cpu_freeze, NULL);
-			else
-				machine_kdump_on_init();
-		}
-		break;
-	case DIE_INIT_SLAVE_LEAVE:
-		if (atomic_read(&kdump_in_progress))
-			unw_init_running(kdump_cpu_freeze, NULL);
-		break;
-	case DIE_MCA_RENDZVOUS_LEAVE:
-		if (atomic_read(&kdump_in_progress))
-			unw_init_running(kdump_cpu_freeze, NULL);
+		/* Reason code 1 means machine check rendezvous*/
+		if (kdump_on_init && (nd->sos->rv_rc != 1))
+			machine_kdump_on_init();
 		break;
 	case DIE_MCA_MONARCH_LEAVE:
 		/* *(nd->data) indicate if MCA is recoverable */
-- 
1.6.0



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
