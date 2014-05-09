Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <4f77128335984c2678eda4e9db39d8bedfc77fab.1399594544.git.geoff@infradead.org>
In-Reply-To: <cover.1399594544.git.geoff@infradead.org>
References: <cover.1399594544.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 5/8] arm64: Split soft_restart into two stages
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

Remove the call to setup_restart() from within soft_restart(), change
setup_restart() from local to global scope by removing its static attribute,
and add a function prototype for setup_restart() in system_misc.h.

Splitting setup_restart() and soft_restart() into two different operations
allows for the calling routine to call setup_restart(), then perform some
operation with the identity map in enabled, and then call soft_restart() to
disable the MMU and perform the soft reset.  It is expected that the calling
routine will call setup_restart(), then shortly thereafter call soft_restart().

To properly manage the shutdown of spin-table secondary CPUs it is necessary to
transition those CPUs into a state compatible with booting.txt.  The existing
implementation of soft_restart() did not allow for the transition to an
identity mapped spin loop.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/include/asm/system_misc.h | 1 +
 arch/arm64/kernel/process.c          | 4 +---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/system_misc.h b/arch/arm64/include/asm/system_misc.h
index 7a18fab..15bc824 100644
--- a/arch/arm64/include/asm/system_misc.h
+++ b/arch/arm64/include/asm/system_misc.h
@@ -41,6 +41,7 @@ struct mm_struct;
 extern void show_pte(struct mm_struct *mm, unsigned long addr);
 extern void __show_regs(struct pt_regs *);
 
+void setup_restart(void);
 void soft_restart(unsigned long);
 extern void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
 
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 6391485..d52c660 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -50,7 +50,7 @@
 #include <asm/processor.h>
 #include <asm/stacktrace.h>
 
-static void setup_restart(void)
+void setup_restart(void)
 {
 	/*
 	 * Tell the mm system that we are going to reboot -
@@ -74,8 +74,6 @@ void soft_restart(unsigned long addr)
 	typedef void (*phys_reset_t)(unsigned long);
 	phys_reset_t phys_reset;
 
-	setup_restart();
-
 	/* Switch to the identity mapping */
 	phys_reset = (phys_reset_t)virt_to_phys(cpu_reset);
 	phys_reset(addr);
-- 
1.9.1



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
