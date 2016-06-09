Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <194f9fd51174555c41472015a48f54e452c44cc3.1465502767.git.geoff@infradead.org>
In-Reply-To: <cover.1465502767.git.geoff@infradead.org>
References: <cover.1465502767.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH v18 02/13] arm64: Add cpus_are_stuck_in_kernel
Date: Thu, 09 Jun 2016 20:08:44 +0000
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
CPUs spinning in here, kexec will release them once the memory is re-used
by the new kernel.

Provide a function to expose whether this counter is non-zero, so we can
use this when loading a new kexec image, and when calling machine_kexec().

Signed-off-by: James Morse <james.morse@arm.com>
[Split off from a larger patch]
Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/include/asm/smp.h | 10 ++++++++++
 arch/arm64/kernel/smp.c      |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 433e504..38712f4 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -124,6 +124,16 @@ static inline void cpu_panic_kernel(void)
 	cpu_park_loop();
 }
 
+/*
+ * If a secondary CPU fails to come online, (e.g. due to mismatched features),
+ * it will try to call cpu_die(). If this fails, it updates
+ * cpus_stuck_in_kernel and sits in cpu_park_loop().
+ *
+ * Kexec checks this counter and refuses to load/kexec if it is non-zero, as
+ * cpu_park_loop() would be overwritten releasing the parked cpus.
+ */
+bool cpus_are_stuck_in_kernel(void);
+
 #endif /* ifndef __ASSEMBLY__ */
 
 #endif /* ifndef __ASM_SMP_H */
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 678e084..d0bcd55 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -909,3 +909,8 @@ int setup_profiling_timer(unsigned int multiplier)
 {
 	return -EINVAL;
 }
+
+bool cpus_are_stuck_in_kernel(void)
+{
+	return !!cpus_stuck_in_kernel;
+}
-- 
2.5.0



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
