Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <dfed1c27146457caec8f3c228a499f5e44678fd2.1399594544.git.geoff@infradead.org>
In-Reply-To: <cover.1399594544.git.geoff@infradead.org>
References: <cover.1399594544.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 1/8] arm64: Use cpu_ops for smp_stop
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

The current implementation of ipi_cpu_stop() is just a tight infinite loop
around cpu_relax().  Add a check for a valid cpu_die method of the appropriate
cpu_operations structure, and if a valid method is found, transfer control to
that method.

The core kexec code calls the arch specific machine_shutdown() routine to
shutdown any SMP secondary CPUs.  The current implementation of the arm64
machine_shutdown() uses smp_send_stop(), which ultimately runs ipi_cpu_stop()
on the secondary CPUs.  The infinite loop implementation of the current
ipi_cpu_stop() does not have any mechanism to get the CPU into a state
compatable with a kexec re-boot.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/kernel/smp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index f0a141d..020bbd5 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -508,6 +508,14 @@ static void ipi_cpu_stop(unsigned int cpu)
 
 	local_irq_disable();
 
+	/* If we have the cup_ops use them. */
+
+	if (cpu_ops[cpu]->cpu_disable && cpu_ops[cpu]->cpu_die
+		&& !cpu_ops[cpu]->cpu_disable(cpu))
+		cpu_ops[cpu]->cpu_die(cpu);
+
+	/* Spin here if the cup_ops fail. */
+
 	while (1)
 		cpu_relax();
 }
-- 
1.9.1



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
