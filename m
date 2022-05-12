From: Pingfan Liu <kernelfans@gmail.com>
Date: Thu, 12 May 2022 11:06:18 +0800
Subject: [PATCHv4 1/2] cpu/hotplug: Keep cpu hotplug disabled until the
 rebooting cpu is stable
In-Reply-To: <20220512030619.13426-1-kernelfans@gmail.com>
References: <20220512030619.13426-1-kernelfans@gmail.com>
Message-ID: <20220512030619.13426-2-kernelfans@gmail.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

smp_shutdown_nonboot_cpus() repeats the same code chunk as
migrate_to_reboot_cpu() to ensure that the rebooting happens on a valid
cpu.

	if (!cpu_online(primary_cpu))
		primary_cpu = cpumask_first(cpu_online_mask);

This is due to an unexpected cpu-down event like the following:
kernel_kexec()
   migrate_to_reboot_cpu();
   cpu_hotplug_enable();
                        -----------> comes a cpu_down(this_cpu) on other cpu
   machine_shutdown();
     smp_shutdown_nonboot_cpus();    which needs to re-check "if (!cpu_online(primary_cpu))"

Although the kexec-reboot task can get through a cpu_down() on its cpu,
this code looks a little confusing.

Tracing down the git history, the cpu_hotplug_enable() called by
kernel_kexec() is introduced by commit 011e4b02f1da ("powerpc, kexec:
Fix "Processor X is stuck" issue during kexec from ST mode"), which
wakes up all offline cpu by cpu_up(cpu). Later, it is required by the
architectures(arm/arm64/ia64/riscv) which resort to cpu hot-removing to
achieve kexec-reboot by
smp_shutdown_nonboot_cpus()->cpu_down_maps_locked().

Hence, the cpu_hotplug_enable() in kernel_kexec() is an architecture
requirement.

By deferring the cpu hotplug enable to a more proper point, where
smp_shutdown_nonboot_cpus() holds cpu_add_remove_lock, the
unexpected cpu-down event is squashed out and the rebooting cpu can keep
unchanged. (For powerpc, no gains from this change.)

As a result, the repeated code chunk can be removed and in [2/2], the
callsites of smp_shutdown_nonboot_cpus() can be consistent.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincent Donnefort <vincent.donnefort@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: YueHaibing <yuehaibing@huawei.com>
Cc: Baokun Li <libaokun1@huawei.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: kexec at lists.infradead.org
To: linuxppc-dev@lists.ozlabs.org
To: linux-kernel@vger.kernel.org
---
 arch/powerpc/kexec/core_64.c |  1 +
 kernel/cpu.c                 | 10 +++++-----
 kernel/kexec_core.c          | 11 +++++------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
index 6cc7793b8420..8ccf22197f08 100644
--- a/arch/powerpc/kexec/core_64.c
+++ b/arch/powerpc/kexec/core_64.c
@@ -224,6 +224,7 @@ static void wake_offline_cpus(void)
 
 static void kexec_prepare_cpus(void)
 {
+	cpu_hotplug_enable();
 	wake_offline_cpus();
 	smp_call_function(kexec_smp_down, NULL, /* wait */0);
 	local_irq_disable();
diff --git a/kernel/cpu.c b/kernel/cpu.c
index d0a9aa0b42e8..4415370f0e91 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1236,12 +1236,12 @@ void smp_shutdown_nonboot_cpus(unsigned int primary_cpu)
 	cpu_maps_update_begin();
 
 	/*
-	 * Make certain the cpu I'm about to reboot on is online.
-	 *
-	 * This is inline to what migrate_to_reboot_cpu() already do.
+	 * At this point, the cpu hotplug is still disabled by
+	 * migrate_to_reboot_cpu() to guarantee that the rebooting happens on
+	 * the selected CPU.  But cpu_down_maps_locked() returns -EBUSY, if
+	 * cpu_hotplug_disabled. So re-enable CPU hotplug here.
 	 */
-	if (!cpu_online(primary_cpu))
-		primary_cpu = cpumask_first(cpu_online_mask);
+	__cpu_hotplug_enable();
 
 	for_each_online_cpu(cpu) {
 		if (cpu == primary_cpu)
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 68480f731192..1bd5a8c95a20 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1168,14 +1168,13 @@ int kernel_kexec(void)
 		kexec_in_progress = true;
 		kernel_restart_prepare("kexec reboot");
 		migrate_to_reboot_cpu();
-
 		/*
-		 * migrate_to_reboot_cpu() disables CPU hotplug assuming that
-		 * no further code needs to use CPU hotplug (which is true in
-		 * the reboot case). However, the kexec path depends on using
-		 * CPU hotplug again; so re-enable it here.
+		 * migrate_to_reboot_cpu() disables CPU hotplug and pin the
+		 * rebooting thread on the selected CPU. If an architecture
+		 * requires CPU hotplug to achieve kexec reboot, it should
+		 * enable the hotplug in the architecture specific code
 		 */
-		cpu_hotplug_enable();
+
 		pr_notice("Starting new kernel\n");
 		machine_shutdown();
 	}
-- 
2.31.1


