Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZMNLu-0008Cb-Hm
 for kexec@lists.infradead.org; Mon, 03 Aug 2015 21:32:59 +0000
Date: Mon, 3 Aug 2015 23:32:28 +0200
From: Jiri Olsa <jolsa@redhat.com>
Subject: [RFC] perf: Clear MSRs on kexec
Message-ID: <20150803213228.GC14481@krava.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
To: linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Cc: Don Zickus <dzickus@redhat.com>, Peter Zijlstra <peterz@infradead.org>, dong.su@ericsson.com, Haren Myneni <hbabu@us.ibm.com>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

hi,
I'm getting following message on the kdump kernel start

  Broken BIOS detected, complain to your hardware vendor.\
  [Firmware Bug]: the BIOS has corrupted hw-PMU resources (MSR 38d is b0)

it seems to be caused by NMI watchdog being configured
and fixed counter values stays in MSRs, which triggers
warning in check_hw_exists and disables perf support
in kdump kernel.. which probably does not hurt ;-)

zeroing MSRs during kdump shutdown seems to work (attached)
but I'm not sure thats correct place for kdump perf callback

thanks,
jirka


---
 arch/x86/include/asm/perf_event.h |  2 ++
 arch/x86/kernel/cpu/perf_event.c  | 23 +++++++++++++++++++++++
 arch/x86/kernel/cpu/perf_event.h  |  1 +
 arch/x86/kernel/crash.c           |  3 +++
 4 files changed, 29 insertions(+)

diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index dc0f6ed35b08..8e49668cf8fe 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -217,6 +217,7 @@ static inline u32 get_ibs_caps(void) { return 0; }
 
 #ifdef CONFIG_PERF_EVENTS
 extern void perf_events_lapic_init(void);
+extern void perf_clear_msrs(void);
 
 /*
  * Abuse bits {3,5} of the cpu eflags register. These flags are otherwise
@@ -275,6 +276,7 @@ static inline void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
 
 static inline void perf_events_lapic_init(void)	{ }
 static inline void perf_check_microcode(void) { }
+static inline void perf_clear_msrs(void) { }
 #endif
 
 #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_AMD)
diff --git a/arch/x86/kernel/cpu/perf_event.c b/arch/x86/kernel/cpu/perf_event.c
index 3658de47900f..f30dbcfb6905 100644
--- a/arch/x86/kernel/cpu/perf_event.c
+++ b/arch/x86/kernel/cpu/perf_event.c
@@ -269,6 +269,27 @@ msr_fail:
 	return false;
 }
 
+void perf_clear_msrs(void)
+{
+	int i, reg, ret;
+
+	if (!x86_pmu.enabled)
+		return;
+
+	for (i = 0; i < x86_pmu.num_counters; i++) {
+		reg = x86_pmu_config_addr(i);
+		ret = wrmsrl_safe(reg, 0);
+		if (WARN_ONCE(ret, "failed to zero perf counter msr, reg %x\n", reg))
+			break;
+	}
+
+	if (x86_pmu.num_counters_fixed) {
+		reg = MSR_ARCH_PERFMON_FIXED_CTR_CTRL;
+		ret = wrmsrl_safe(reg, 0);
+		WARN_ONCE(ret, "failed to zero perf fixed counters msr\n");
+	}
+}
+
 static void hw_perf_event_destroy(struct perf_event *event)
 {
 	x86_release_hardware();
@@ -1689,6 +1710,8 @@ static int __init init_hw_perf_events(void)
 	if (!check_hw_exists())
 		return 0;
 
+	x86_pmu.enabled = true;
+
 	pr_cont("%s PMU driver.\n", x86_pmu.name);
 
 	x86_pmu.attr_rdpmc = 1; /* enable userspace RDPMC usage by default */
diff --git a/arch/x86/kernel/cpu/perf_event.h b/arch/x86/kernel/cpu/perf_event.h
index 3e7fd27dfe20..ca8a5068f8a0 100644
--- a/arch/x86/kernel/cpu/perf_event.h
+++ b/arch/x86/kernel/cpu/perf_event.h
@@ -508,6 +508,7 @@ struct x86_pmu {
 	 */
 	const char	*name;
 	int		version;
+	bool		enabled;
 	int		(*handle_irq)(struct pt_regs *);
 	void		(*disable_all)(void);
 	void		(*enable_all)(int added);
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index e068d6683dba..20ed1ffdab8c 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -35,6 +35,7 @@
 #include <asm/cpu.h>
 #include <asm/reboot.h>
 #include <asm/virtext.h>
+#include <asm/perf_event.h>
 
 /* Alignment required for elf header segment */
 #define ELF_CORE_HEADER_ALIGN   4096
@@ -128,6 +129,7 @@ static void kdump_nmi_callback(int cpu, struct pt_regs *regs)
 	cpu_emergency_svm_disable();
 
 	disable_local_APIC();
+	perf_clear_msrs();
 }
 
 static void kdump_nmi_shootdown_cpus(void)
@@ -182,6 +184,7 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 	hpet_disable();
 #endif
 	crash_save_cpu(regs, safe_smp_processor_id());
+	perf_clear_msrs();
 }
 
 #ifdef CONFIG_KEXEC_FILE
-- 
2.4.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
