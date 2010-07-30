Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OehWo-0006zn-Lr
	for kexec@lists.infradead.org; Fri, 30 Jul 2010 04:49:03 +0000
Message-ID: <4C5259C4.1010006@ozlabs.org>
Date: Fri, 30 Jul 2010 14:49:08 +1000
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
Subject: [PATCH 2/2] powerpc/kexec: Fix orphaned offline CPUs across kexec
References: <4C5258C8.1030305@ozlabs.org>
In-Reply-To: <4C5258C8.1030305@ozlabs.org>
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
To: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org
Cc: Michael Neuling <mikey@neuling.org>, Milton Miller <miltonm@bga.com>

When CPU hotplug is used, some CPUs may be offline at the time a kexec is
performed.  The subsequent kernel may expect these CPUs to be already running,
and will declare them stuck.  On pseries, there's also a soft-offline (cede)
state that CPUs may be in; this can also cause problems as the kexeced kernel
may ask RTAS if they're online -- and RTAS would say they are.  The CPU will
either appear stuck, or will cause a crash as we replace its cede loop beneath
it.

This patch kicks each present offline CPU awake before the kexec, so that
none are forever lost to these assumptions in the subsequent kernel.

Now, the behaviour is that all available CPUs that were offlined are now
online & usable after the kexec.  This mimics the behaviour of a full reboot
(on which all CPUs will be restarted).

Signed-off-by: Matt Evans <matt@ozlabs.org>
---
 arch/powerpc/kernel/machine_kexec_64.c |   26 +++++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index aa3d5cd..37f805e 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -16,6 +16,7 @@
 #include <linux/init_task.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
+#include <linux/cpu.h>
 
 #include <asm/page.h>
 #include <asm/current.h>
@@ -213,9 +214,32 @@ static void kexec_prepare_cpus_wait(int wait_state)
 	mb();
 }
 
-static void kexec_prepare_cpus(void)
+/*
+ * We need to make sure each present CPU is online.  The next kernel will scan
+ * the device tree and assume primary threads are online and query secondary
+ * threads via RTAS to online them if required.  If we don't online primary
+ * threads, they will be stuck.  However, we also online secondary threads as we
+ * may be using 'cede offline'.  In this case RTAS doesn't see the secondary
+ * threads as offline -- and again, these CPUs will be stuck.
+ *
+ * So, we online all CPUs that should be running, including secondary threads.
+ */
+static void wake_offline_cpus(void)
 {
+	int cpu = 0;
+
+	for_each_present_cpu(cpu) {
+		if (!cpu_online(cpu)) {
+			printk(KERN_INFO "kexec: Waking offline cpu %d.\n",
+			       cpu);
+			cpu_up(cpu);
+		}
+	}
+}
 
+static void kexec_prepare_cpus(void)
+{
+	wake_offline_cpus();
 	smp_call_function(kexec_smp_down, NULL, /* wait */0);
 	local_irq_disable();
 	mb(); /* make sure IRQs are disabled before we say they are */
-- 
1.6.3.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
