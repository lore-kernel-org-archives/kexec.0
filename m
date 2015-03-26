Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Yb3BI-0003XE-Hk
 for kexec@lists.infradead.org; Thu, 26 Mar 2015 08:30:26 +0000
Received: by pdbni2 with SMTP id ni2so55930371pdb.1
 for <kexec@lists.infradead.org>; Thu, 26 Mar 2015 01:30:01 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH 3/5] arm64: kdump: do not go into EL2 before starting a crash
 dump kernel
Date: Thu, 26 Mar 2015 17:28:51 +0900
Message-Id: <1427358533-3754-4-git-send-email-takahiro.akashi@linaro.org>
In-Reply-To: <1427358533-3754-1-git-send-email-takahiro.akashi@linaro.org>
References: <1427358533-3754-1-git-send-email-takahiro.akashi@linaro.org>
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
To: catalin.marinas@arm.com, will.deacon@arm.com, vgoyal@redhat.com, hbabus@us.ibm.com
Cc: linaro-kernel@lists.linaro.org, geoff@infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, broonie@kernel.org, david.griego@linaro.org, linux-arm-kernel@lists.infradead.org

Unlike normal kexec case, we don't have a chance to reset EL2 context in
a generic way because bad exceptions may directly invoke crash_kexec().
(See die().)
Kvm is not useful on crash dump kernel anyway, and so we let it
un-initialized across rebooting.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/kernel/process.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index d894d3e..9859f5c 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -48,6 +48,7 @@
 #include <asm/compat.h>
 #include <asm/cacheflush.h>
 #include <asm/fpsimd.h>
+#include <asm/kexec.h>
 #include <asm/mmu_context.h>
 #include <asm/processor.h>
 #include <asm/stacktrace.h>
@@ -64,7 +65,11 @@ void soft_restart(unsigned long addr)
 	setup_mm_for_reboot();
 
 	cpu_soft_restart(virt_to_phys(cpu_reset),
-		is_hyp_mode_available(), addr);
+#ifdef CONFIG_KEXEC
+		!in_crash_kexec &&
+#endif
+		is_hyp_mode_available(),
+		addr);
 
 	/* Should never get here */
 	BUG();
-- 
1.7.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
