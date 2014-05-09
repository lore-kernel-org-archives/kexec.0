Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <3bc3a27893963afadcbb63d5ad8e3ef84b9d74ac.1399594544.git.geoff@infradead.org>
In-Reply-To: <cover.1399594544.git.geoff@infradead.org>
References: <cover.1399594544.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 4/8] arm64: Add smp_spin_table_set_die
Date: Fri, 09 May 2014 00:48:17 +0000
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
Cc: Deepak Saxena <dsaxena@linaro.org>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Remove the const attribute from the smp_spin_table_ops instance in
smp_spin_table.c and add the new routine smp_spin_table_set_die() which allows a
custom cpu die method to be set in the smp_spin_table_ops instance.

The ability to set a custom cpu die routine is needed by kexec to allow it to
manage any secondary CPUs that need to be shut down as described in booting.txt.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/include/asm/cpu_ops.h   | 2 ++
 arch/arm64/kernel/smp_spin_table.c | 8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpu_ops.h b/arch/arm64/include/asm/cpu_ops.h
index 872f61a..42bcd24 100644
--- a/arch/arm64/include/asm/cpu_ops.h
+++ b/arch/arm64/include/asm/cpu_ops.h
@@ -63,4 +63,6 @@ extern int cpu_read_ops(struct device_node *dn, int cpu,
 	const struct cpu_operations **cpu_ops);
 extern void __init cpu_read_bootcpu_ops(void);
 
+void smp_spin_table_set_die(void (*fn)(unsigned int));
+
 #endif /* ifndef __ASM_CPU_OPS_H */
diff --git a/arch/arm64/kernel/smp_spin_table.c b/arch/arm64/kernel/smp_spin_table.c
index 26c780b..ce7d0a3 100644
--- a/arch/arm64/kernel/smp_spin_table.c
+++ b/arch/arm64/kernel/smp_spin_table.c
@@ -153,7 +153,7 @@ static void smp_spin_table_cpu_die(unsigned int cpu)
 		cpu_relax();
 }
 
-const struct cpu_operations smp_spin_table_ops = {
+struct cpu_operations smp_spin_table_ops = {
 	.name		= "spin-table",
 	.cpu_init	= smp_spin_table_cpu_init,
 	.cpu_prepare	= smp_spin_table_cpu_prepare,
@@ -162,3 +162,9 @@ const struct cpu_operations smp_spin_table_ops = {
 	.cpu_disable	= smp_spin_table_cpu_disable,
 	.cpu_die	= smp_spin_table_cpu_die,
 };
+
+void smp_spin_table_set_die(void (*fn)(unsigned int))
+{
+	BUG_ON(!fn);
+	smp_spin_table_ops.cpu_die = fn;
+}
-- 
1.9.1



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
