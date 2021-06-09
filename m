Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqmKo-00AvDV-C3
 for kexec@lists.infradead.org; Wed, 09 Jun 2021 00:44:45 +0000
Received: by mail-qt1-x831.google.com with SMTP id z4so13722214qts.4
 for <kexec@lists.infradead.org>; Tue, 08 Jun 2021 17:44:42 -0700 (PDT)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v15 14/15] arm64: kexec: remove cpu-reset.h
Date: Tue,  8 Jun 2021 20:44:18 -0400
Message-Id: <20210609004419.936873-15-pasha.tatashin@soleen.com>
In-Reply-To: <20210609004419.936873-1-pasha.tatashin@soleen.com>
References: <20210609004419.936873-1-pasha.tatashin@soleen.com>
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
To: pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, maz@kernel.org, james.morse@arm.com, vladimir.murzin@arm.com, matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de, selindag@gmail.com, tyhicks@linux.microsoft.com, kernelfans@gmail.com, akpm@linux-foundation.org, madvenka@linux.microsoft.com

This header contains only cpu_soft_restart() which is never used directly
anymore. So, remove this header, and rename the helper to be
cpu_soft_restart().

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/kexec.h    |  6 ++++++
 arch/arm64/kernel/cpu-reset.S     |  7 +++----
 arch/arm64/kernel/cpu-reset.h     | 30 ------------------------------
 arch/arm64/kernel/machine_kexec.c |  6 ++----
 4 files changed, 11 insertions(+), 38 deletions(-)
 delete mode 100644 arch/arm64/kernel/cpu-reset.h

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index dca6dedc3b25..9839bfc163d7 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -90,6 +90,12 @@ static inline void crash_prepare_suspend(void) {}
 static inline void crash_post_resume(void) {}
 #endif
 
+#if defined(CONFIG_KEXEC_CORE)
+void cpu_soft_restart(unsigned long el2_switch, unsigned long entry,
+		      unsigned long arg0, unsigned long arg1,
+		      unsigned long arg2);
+#endif
+
 #define ARCH_HAS_KIMAGE_ARCH
 
 struct kimage_arch {
diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
index d47ff63a5b66..48a8af97faa9 100644
--- a/arch/arm64/kernel/cpu-reset.S
+++ b/arch/arm64/kernel/cpu-reset.S
@@ -16,8 +16,7 @@
 .pushsection    .idmap.text, "awx"
 
 /*
- * __cpu_soft_restart(el2_switch, entry, arg0, arg1, arg2) - Helper for
- * cpu_soft_restart.
+ * cpu_soft_restart(el2_switch, entry, arg0, arg1, arg2)
  *
  * @el2_switch: Flag to indicate a switch to EL2 is needed.
  * @entry: Location to jump to for soft reset.
@@ -29,7 +28,7 @@
  * branch to what would be the reset vector. It must be executed with the
  * flat identity mapping.
  */
-SYM_CODE_START(__cpu_soft_restart)
+SYM_CODE_START(cpu_soft_restart)
 	mov_q	x12, INIT_SCTLR_EL1_MMU_OFF
 	pre_disable_mmu_workaround
 	/*
@@ -48,6 +47,6 @@ SYM_CODE_START(__cpu_soft_restart)
 	mov	x1, x3				// arg1
 	mov	x2, x4				// arg2
 	br	x8
-SYM_CODE_END(__cpu_soft_restart)
+SYM_CODE_END(cpu_soft_restart)
 
 .popsection
diff --git a/arch/arm64/kernel/cpu-reset.h b/arch/arm64/kernel/cpu-reset.h
deleted file mode 100644
index 296abbac7192..000000000000
--- a/arch/arm64/kernel/cpu-reset.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * CPU reset routines
- *
- * Copyright (C) 2015 Huawei Futurewei Technologies.
- */
-
-#ifndef _ARM64_CPU_RESET_H
-#define _ARM64_CPU_RESET_H
-
-#include <asm/virt.h>
-
-void __cpu_soft_restart(unsigned long el2_switch, unsigned long entry,
-	unsigned long arg0, unsigned long arg1, unsigned long arg2);
-
-static inline void __noreturn __nocfi cpu_soft_restart(unsigned long entry,
-						       unsigned long arg0,
-						       unsigned long arg1,
-						       unsigned long arg2)
-{
-	typeof(__cpu_soft_restart) *restart;
-
-	restart = (void *)__pa_symbol(function_nocfi(__cpu_soft_restart));
-
-	cpu_install_idmap();
-	restart(0, entry, arg0, arg1, arg2);
-	unreachable();
-}
-
-#endif
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 8f8962f53ba2..a1d98f42b741 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -23,8 +23,6 @@
 #include <asm/sections.h>
 #include <asm/trans_pgd.h>
 
-#include "cpu-reset.h"
-
 /**
  * kexec_image_info - For debugging output.
  */
@@ -197,10 +195,10 @@ void machine_kexec(struct kimage *kimage)
 	 * In kexec_file case, the kernel starts directly without purgatory.
 	 */
 	if (kimage->head & IND_DONE) {
-		typeof(__cpu_soft_restart) *restart;
+		typeof(cpu_soft_restart) *restart;
 
 		cpu_install_idmap();
-		restart = (void *)__pa_symbol(function_nocfi(__cpu_soft_restart));
+		restart = (void *)__pa_symbol(function_nocfi(cpu_soft_restart));
 		restart(is_hyp_nvhe(), kimage->start, kimage->arch.dtb_mem,
 			0, 0);
 	} else {
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
