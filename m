Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVx5q-00EhTY-Gv
 for kexec@lists.infradead.org; Thu, 30 Sep 2021 14:31:30 +0000
Received: by mail-qk1-x72b.google.com with SMTP id 72so5964093qkk.7
 for <kexec@lists.infradead.org>; Thu, 30 Sep 2021 07:31:25 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v18 09/15] arm64: kexec: relocate in EL1 mode
Date: Thu, 30 Sep 2021 14:31:07 +0000
Message-Id: <20210930143113.1502553-10-pasha.tatashin@soleen.com>
In-Reply-To: <20210930143113.1502553-1-pasha.tatashin@soleen.com>
References: <20210930143113.1502553-1-pasha.tatashin@soleen.com>
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
To: pasha.tatashin@soleen.com, sashal@kernel.org, ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, maz@kernel.org, james.morse@arm.com, vladimir.murzin@arm.com, matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de, selindag@gmail.com, kernelfans@gmail.com, akpm@linux-foundation.org

Since we are going to keep MMU enabled during relocation, we need to
keep EL1 mode throughout the relocation.

Keep EL1 enabled, and switch EL2 only before entering the new world.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/cpu-reset.h       |  3 +--
 arch/arm64/kernel/machine_kexec.c   |  4 ++--
 arch/arm64/kernel/relocate_kernel.S | 13 +++++++++++--
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/cpu-reset.h b/arch/arm64/kernel/cpu-reset.h
index 81b3d0fe7a63..296abbac7192 100644
--- a/arch/arm64/kernel/cpu-reset.h
+++ b/arch/arm64/kernel/cpu-reset.h
@@ -20,11 +20,10 @@ static inline void __noreturn __nocfi cpu_soft_restart(unsigned long entry,
 {
 	typeof(__cpu_soft_restart) *restart;
 
-	unsigned long el2_switch = is_hyp_nvhe();
 	restart = (void *)__pa_symbol(function_nocfi(__cpu_soft_restart));
 
 	cpu_install_idmap();
-	restart(el2_switch, entry, arg0, arg1, arg2);
+	restart(0, entry, arg0, arg1, arg2);
 	unreachable();
 }
 
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 59a4b4172b68..cf5d6f22a041 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -240,8 +240,8 @@ void machine_kexec(struct kimage *kimage)
 	} else {
 		if (is_hyp_nvhe())
 			__hyp_set_vectors(kimage->arch.el2_vectors);
-		cpu_soft_restart(kimage->arch.kern_reloc, virt_to_phys(kimage),
-				 0, 0);
+		cpu_soft_restart(kimage->arch.kern_reloc,
+				 virt_to_phys(kimage), 0, 0);
 	}
 
 	BUG(); /* Should never get here. */
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index 63ea19868f63..b4fb97312a80 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -13,6 +13,7 @@
 #include <asm/kexec.h>
 #include <asm/page.h>
 #include <asm/sysreg.h>
+#include <asm/virt.h>
 
 /*
  * arm64_relocate_new_kernel - Put a 2nd stage image in place and boot it.
@@ -61,12 +62,20 @@ SYM_CODE_START(arm64_relocate_new_kernel)
 	isb
 
 	/* Start new image. */
+	ldr	x1, [x0, #KIMAGE_ARCH_EL2_VECTORS]	/* relocation start */
+	cbz	x1, .Lel1
+	ldr	x1, [x0, #KIMAGE_START]		/* relocation start */
+	ldr	x2, [x0, #KIMAGE_ARCH_DTB_MEM]	/* dtb address */
+	mov	x3, xzr
+	mov	x4, xzr
+	mov     x0, #HVC_SOFT_RESTART
+	hvc	#0				/* Jumps from el2 */
+.Lel1:
 	ldr	x4, [x0, #KIMAGE_START]		/* relocation start */
 	ldr	x0, [x0, #KIMAGE_ARCH_DTB_MEM]	/* dtb address */
-	mov	x1, xzr
 	mov	x2, xzr
 	mov	x3, xzr
-	br	x4
+	br	x4				/* Jumps from el1 */
 SYM_CODE_END(arm64_relocate_new_kernel)
 
 .align 3	/* To keep the 64-bit values below naturally aligned. */
-- 
2.33.0.800.g4c38ced690-goog


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
