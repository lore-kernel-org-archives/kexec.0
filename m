Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <97dcd35763eddf1b4c50a26d16389f313269f0c8.1466702804.git.geoff@infradead.org>
In-Reply-To: <cover.1466702804.git.geoff@infradead.org>
References: <cover.1466702804.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH v20 01/14] arm64: hibernate: Don't hibernate on systems with
 stuck CPUs
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

Hibernate relies on cpu hotplug to prevent secondary cores executing
the kernel text while it is being restored.

Add a call to cpus_are_stuck_in_kernel() to determine if there are
CPUs not counted by 'num_online_cpus()', and prevent hibernate in this
case.

Fixes: 82869ac57b5 ("arm64: kernel: Add support for hibernate/suspend-to-disk")
Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/kernel/hibernate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index f8df75d..21ab5df 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -33,6 +33,7 @@
 #include <asm/pgtable.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/sections.h>
+#include <asm/smp.h>
 #include <asm/suspend.h>
 #include <asm/virt.h>
 
@@ -236,6 +237,11 @@ int swsusp_arch_suspend(void)
 	unsigned long flags;
 	struct sleep_stack_data state;
 
+	if (cpus_are_stuck_in_kernel()) {
+		pr_err("Can't hibernate: no mechanism to offline secondary CPUs.\n");
+		return -EBUSY;
+	}
+
 	local_dbg_save(flags);
 
 	if (__cpu_suspend_enter(&state)) {
-- 
2.5.0



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
