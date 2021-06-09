Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt1-f175.google.com ([209.85.160.175])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqmLU-00AvUt-Bj
 for kexec@lists.infradead.org; Wed, 09 Jun 2021 00:45:27 +0000
Received: by mail-qt1-f175.google.com with SMTP id a15so2501519qtx.13
 for <kexec@lists.infradead.org>; Tue, 08 Jun 2021 17:45:24 -0700 (PDT)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v15 01/15] arm64: kernel: add helper for booted at EL2 and not
 VHE
Date: Tue,  8 Jun 2021 20:44:05 -0400
Message-Id: <20210609004419.936873-2-pasha.tatashin@soleen.com>
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

Replace places that contain logic like this:
	is_hyp_mode_available() && !is_kernel_in_hyp_mode()

With a dedicated boolean function  is_hyp_nvhe(). This will be needed
later in kexec in order to sooner switch back to EL2.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/virt.h | 5 +++++
 arch/arm64/kernel/cpu-reset.h | 3 +--
 arch/arm64/kernel/hibernate.c | 2 +-
 arch/arm64/kernel/sdei.c      | 2 +-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 7379f35ae2c6..a9457e96203c 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -128,6 +128,11 @@ static __always_inline bool is_protected_kvm_enabled(void)
 		return cpus_have_final_cap(ARM64_KVM_PROTECTED_MODE);
 }
 
+static inline bool is_hyp_nvhe(void)
+{
+	return is_hyp_mode_available() && !is_kernel_in_hyp_mode();
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* ! __ASM__VIRT_H */
diff --git a/arch/arm64/kernel/cpu-reset.h b/arch/arm64/kernel/cpu-reset.h
index 9a7b1262ef17..81b3d0fe7a63 100644
--- a/arch/arm64/kernel/cpu-reset.h
+++ b/arch/arm64/kernel/cpu-reset.h
@@ -20,8 +20,7 @@ static inline void __noreturn __nocfi cpu_soft_restart(unsigned long entry,
 {
 	typeof(__cpu_soft_restart) *restart;
 
-	unsigned long el2_switch = !is_kernel_in_hyp_mode() &&
-		is_hyp_mode_available();
+	unsigned long el2_switch = is_hyp_nvhe();
 	restart = (void *)__pa_symbol(function_nocfi(__cpu_soft_restart));
 
 	cpu_install_idmap();
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index b1cef371df2b..42b5d8105ab9 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -49,7 +49,7 @@
 extern int in_suspend;
 
 /* Do we need to reset el2? */
-#define el2_reset_needed() (is_hyp_mode_available() && !is_kernel_in_hyp_mode())
+#define el2_reset_needed() (is_hyp_nvhe())
 
 /* temporary el2 vectors in the __hibernate_exit_text section. */
 extern char hibernate_el2_vectors[];
diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index 2c7ca449dd51..cf06929c44e3 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -200,7 +200,7 @@ unsigned long sdei_arch_get_entry_point(int conduit)
 	 * dropped to EL1 because we don't support VHE, then we can't support
 	 * SDEI.
 	 */
-	if (is_hyp_mode_available() && !is_kernel_in_hyp_mode()) {
+	if (is_hyp_nvhe()) {
 		pr_err("Not supported on this hardware/boot configuration\n");
 		goto out_err;
 	}
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
