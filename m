Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Per Fransson <per.xx.fransson@stericsson.com>
Subject: [PATCH v3] ARM: kexec: Add call to non-crashing cores through IPI
Date: Wed, 1 Dec 2010 09:24:06 +0100
Message-ID: <1291191846-12417-1-git-send-email-per.xx.fransson@stericsson.com>
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
To: linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org
Cc: Per Fransson <per.xx.fransson@stericsson.com>

When kexec is used to start a crash kernel the other cores
are notified. These non-crashing cores will save their state
in the crash notes and then do nothing.

Signed-off-by: Per Fransson <per.xx.fransson@stericsson.com>
---
v3 changes:
* Lowered loglevel of non-crashing CPU prints

* Added logging for non-crashing CPUs which do not respond

 arch/arm/kernel/machine_kexec.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 3a8fd51..30ead13 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -23,6 +23,8 @@ extern unsigned long kexec_indirection_page;
 extern unsigned long kexec_mach_type;
 extern unsigned long kexec_boot_atags;
 
+static atomic_t waiting_for_crash_ipi;
+
 /*
  * Provide a dummy crash_notes definition while crash dump arrives to arm.
  * This prevents breakage of crash_notes attribute in kernel/ksysfs.c.
@@ -37,9 +39,37 @@ void machine_kexec_cleanup(struct kimage *image)
 {
 }
 
+void machine_crash_nonpanic_core(void *unused)
+{
+	struct pt_regs regs;
+
+	crash_setup_regs(&regs, NULL);
+	printk(KERN_DEBUG "CPU %u will stop doing anything useful since another CPU has crashed\n",
+	       smp_processor_id());
+	crash_save_cpu(&regs, smp_processor_id());
+	flush_cache_all();
+
+	atomic_dec(&waiting_for_crash_ipi);
+	while (1)
+		cpu_relax();
+}
+
 void machine_crash_shutdown(struct pt_regs *regs)
 {
+	unsigned long msecs;
+
 	local_irq_disable();
+
+	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
+	smp_call_function(machine_crash_nonpanic_core, NULL, false);
+	msecs = 1000; /* Wait at most a second for the other cpus to stop */
+	while ((atomic_read(&waiting_for_crash_ipi) > 0) && msecs) {
+		mdelay(1);
+		msecs--;
+	}
+	if (atomic_read(&waiting_for_crash_ipi) > 0)
+		printk(KERN_WARNING "Non-crashing CPUs did not react to IPI\n");
+
 	crash_save_cpu(regs, smp_processor_id());
 
 	printk(KERN_INFO "Loading crashdump kernel...\n");
-- 
1.7.2.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
