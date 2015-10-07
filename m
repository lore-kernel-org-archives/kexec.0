Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn1on0116.outbound.protection.outlook.com
 ([157.56.110.116] helo=na01-bn1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zjfiz-00016f-N5
 for kexec@lists.infradead.org; Wed, 07 Oct 2015 03:49:07 +0000
From: Scott Wood <scottwood@freescale.com>
Subject: [PATCH v2 12/18] powerpc/book3e/kdump: Enable
 crash_kexec_wait_realmode
Date: Tue, 6 Oct 2015 22:48:16 -0500
Message-ID: <1444189702-17241-13-git-send-email-scottwood@freescale.com>
In-Reply-To: <1444189702-17241-1-git-send-email-scottwood@freescale.com>
References: <1444189702-17241-1-git-send-email-scottwood@freescale.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linuxppc-dev@lists.ozlabs.org
Cc: Scott Wood <scottwood@freescale.com>, Tiejun Chen <tiejun.chen@intel.com>, kexec@lists.infradead.org, Michael Ellerman <mpe@ellerman.id.au>

While book3e doesn't have "real mode", we still want to wait for
all the non-crash cpus to complete their shutdown.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/crash.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
index 51dbace..2bb252c 100644
--- a/arch/powerpc/kernel/crash.c
+++ b/arch/powerpc/kernel/crash.c
@@ -221,8 +221,8 @@ void crash_kexec_secondary(struct pt_regs *regs)
 #endif	/* CONFIG_SMP */
 
 /* wait for all the CPUs to hit real mode but timeout if they don't come in */
-#if defined(CONFIG_SMP) && defined(CONFIG_PPC_STD_MMU_64)
-static void crash_kexec_wait_realmode(int cpu)
+#if defined(CONFIG_SMP) && defined(CONFIG_PPC64)
+static void __maybe_unused crash_kexec_wait_realmode(int cpu)
 {
 	unsigned int msecs;
 	int i;
@@ -244,7 +244,7 @@ static void crash_kexec_wait_realmode(int cpu)
 }
 #else
 static inline void crash_kexec_wait_realmode(int cpu) {}
-#endif	/* CONFIG_SMP && CONFIG_PPC_STD_MMU_64 */
+#endif	/* CONFIG_SMP && CONFIG_PPC64 */
 
 /*
  * Register a function to be called on shutdown.  Only use this if you
-- 
2.1.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
