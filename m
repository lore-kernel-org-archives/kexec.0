Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <938f5ec9deff917f8e4ad276c01b5c753b7ee83a.1466702804.git.geoff@infradead.org>
In-Reply-To: <cover.1466702804.git.geoff@infradead.org>
References: <cover.1466702804.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH v20 02/14] arm64: smp: Add function to determine if cpus are
 stuck in the kernel
Date: Thu, 23 Jun 2016 17:54:48 +0000
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
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, marc.zyngier@arm.com, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, linux-arm-kernel@lists.infradead.org

From: James Morse <james.morse@arm.com>

kernel/smp.c has a fancy counter that keeps track of the number of CPUs
it marked as not-present and left in cpu_park_loop(). If there are any
CPUs spinning in here, features like kexec or hibernate may release them
by overwriting this memory.

This problem also occurs on machines using spin-tables to release
secondary cores.
After commit 44dbcc93ab67 ("arm64: Fix behavior of maxcpus=N")
we bring all known cpus into the secondary holding pen, meaning this
memory can't be re-used by kexec or hibernate.

Add a function cpus_are_stuck_in_kernel() to determine if either of these
cases have occurred.

Signed-off-by: James Morse <james.morse@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/smp.h | 12 ++++++++++++
 arch/arm64/kernel/smp.c      | 18 ++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 433e504..0226447 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -124,6 +124,18 @@ static inline void cpu_panic_kernel(void)
 	cpu_park_loop();
 }
 
+/*
+ * If a secondary CPU enters the kernel but fails to come online,
+ * (e.g. due to mismatched features), and cannot exit the kernel,
+ * we increment cpus_stuck_in_kernel and leave the CPU in a
+ * quiesecent loop within the kernel text. The memory containing
+ * this loop must not be re-used for anything else as the 'stuck'
+ * core is executing it.
+ *
+ * This function is used to inhibit features like kexec and hibernate.
+ */
+bool cpus_are_stuck_in_kernel(void);
+
 #endif /* ifndef __ASSEMBLY__ */
 
 #endif /* ifndef __ASM_SMP_H */
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 678e084..62ff3c0 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -909,3 +909,21 @@ int setup_profiling_timer(unsigned int multiplier)
 {
 	return -EINVAL;
 }
+
+static bool have_cpu_die(void)
+{
+#ifdef CONFIG_HOTPLUG_CPU
+	int any_cpu = raw_smp_processor_id();
+
+	if (cpu_ops[any_cpu]->cpu_die)
+		return true;
+#endif
+	return false;
+}
+
+bool cpus_are_stuck_in_kernel(void)
+{
+	bool smp_spin_tables = (num_possible_cpus() > 1 && !have_cpu_die());
+
+	return !!cpus_stuck_in_kernel || smp_spin_tables;
+}
-- 
2.5.0



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
