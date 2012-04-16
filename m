Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SJbZV-0002KJ-6f
 for kexec@lists.infradead.org; Mon, 16 Apr 2012 02:21:42 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id B7E2B3EE0C0
 for <kexec@lists.infradead.org>; Mon, 16 Apr 2012 11:21:36 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 6093145DE5C
 for <kexec@lists.infradead.org>; Mon, 16 Apr 2012 11:21:35 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 1D85545DE56
 for <kexec@lists.infradead.org>; Mon, 16 Apr 2012 11:21:35 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 06C071DB8052
 for <kexec@lists.infradead.org>; Mon, 16 Apr 2012 11:21:35 +0900 (JST)
Received: from m107.s.css.fujitsu.com (m107.s.css.fujitsu.com [10.240.81.147])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 9BDA31DB804E
 for <kexec@lists.infradead.org>; Mon, 16 Apr 2012 11:21:34 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH 1/2] Introduce crash ipi helpers to wait for APs to stop
Date: Mon, 16 Apr 2012 11:21:33 +0900
Message-ID: <20120416022133.9303.41287.stgit@localhost6.localdomain6>
In-Reply-To: <20120416021951.9303.58568.stgit@localhost6.localdomain6>
References: <20120416021951.9303.58568.stgit@localhost6.localdomain6>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, vgoyal@redhat.com, kumagai-atsushi@mxc.nes.nec.co.jp

Introduce crash ipi helpers to use them from BSP and AP sides in
common.

There's no logical change in this patch.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 arch/x86/include/asm/reboot.h |    4 +++
 arch/x86/kernel/reboot.c      |   53 ++++++++++++++++++++++++++++++++---------
 2 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/reboot.h b/arch/x86/include/asm/reboot.h
index 92f29706..2f8e9e7 100644
--- a/arch/x86/include/asm/reboot.h
+++ b/arch/x86/include/asm/reboot.h
@@ -26,4 +26,8 @@ void machine_real_restart(unsigned int type);
 typedef void (*nmi_shootdown_cb)(int, struct pt_regs*);
 void nmi_shootdown_cpus(nmi_shootdown_cb callback);
 
+void crash_ipi_init(void);
+void crash_ipi_dec_and_halt(void);
+void crash_ipi_wait_for_APs(void);
+
 #endif /* _ASM_X86_REBOOT_H */
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index d840e69..6dd77a8 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -769,6 +769,31 @@ static nmi_shootdown_cb shootdown_callback;
 
 static atomic_t waiting_for_crash_ipi;
 
+void crash_ipi_init(void)
+{
+	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
+}
+
+void crash_ipi_dec_and_halt(void)
+{
+	atomic_dec(&waiting_for_crash_ipi);
+	/* Assume hlt works */
+	halt();
+	for (;;)
+		cpu_relax();
+}
+
+void crash_ipi_wait_for_APs(void)
+{
+	unsigned long msecs;
+
+	msecs = 1000; /* Wait at most a second for the other cpus to stop */
+	while ((atomic_read(&waiting_for_crash_ipi) > 0) && msecs) {
+		mdelay(1);
+		msecs--;
+	}
+}
+
 static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
 {
 	int cpu;
@@ -785,11 +810,7 @@ static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
 
 	shootdown_callback(cpu, regs);
 
-	atomic_dec(&waiting_for_crash_ipi);
-	/* Assume hlt works */
-	halt();
-	for (;;)
-		cpu_relax();
+	crash_ipi_dec_and_halt();
 
 	return NMI_HANDLED;
 }
@@ -807,7 +828,6 @@ static void smp_send_nmi_allbutself(void)
  */
 void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 {
-	unsigned long msecs;
 	local_irq_disable();
 
 	/* Make a note of crashing cpu. Will be used in NMI callback.*/
@@ -815,7 +835,8 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 
 	shootdown_callback = callback;
 
-	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
+	crash_ipi_init();
+
 	/* Would it be better to replace the trap vector here? */
 	if (register_nmi_handler(NMI_LOCAL, crash_nmi_callback,
 				 NMI_FLAG_FIRST, "crash"))
@@ -827,11 +848,7 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 
 	smp_send_nmi_allbutself();
 
-	msecs = 1000; /* Wait at most a second for the other cpus to stop */
-	while ((atomic_read(&waiting_for_crash_ipi) > 0) && msecs) {
-		mdelay(1);
-		msecs--;
-	}
+	crash_ipi_wait_for_APs();
 
 	/* Leave the nmi callback set */
 }
@@ -840,4 +857,16 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 {
 	/* No other CPUs to shoot down */
 }
+
+void crash_ipi_init(void)
+{
+}
+
+void crash_ipi_dec_and_halt(void)
+{
+}
+
+void crash_ipi_wait_for_APs(void)
+{
+}
 #endif


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
