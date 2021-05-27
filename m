Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmHZo-0071hT-HY
 for kexec@lists.infradead.org; Thu, 27 May 2021 15:05:40 +0000
Received: by mail-qk1-x734.google.com with SMTP id v8so944265qkv.1
 for <kexec@lists.infradead.org>; Thu, 27 May 2021 08:05:36 -0700 (PDT)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH 04/18] arm64: kernel: add helper for booted at EL2 and not VHE
Date: Thu, 27 May 2021 11:05:12 -0400
Message-Id: <20210527150526.271941-5-pasha.tatashin@soleen.com>
In-Reply-To: <20210527150526.271941-1-pasha.tatashin@soleen.com>
References: <20210527150526.271941-1-pasha.tatashin@soleen.com>
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

With a dedicated boolean function  is_hyp_callable(). This will be needed
later in kexec in order to sooner switch back to EL2.

Suggested-by: James Morse <james.morse@arm.com>

[Fixed merging issues]

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/virt.h | 5 +++++
 arch/arm64/kernel/cpu-reset.h | 3 +--
 arch/arm64/kernel/hibernate.c | 9 +++------
 arch/arm64/kernel/sdei.c      | 2 +-
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 7379f35ae2c6..4216c8623538 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -128,6 +128,11 @@ static __always_inline bool is_protected_kvm_enabled(void)
 		return cpus_have_final_cap(ARM64_KVM_PROTECTED_MODE);
 }
 
+static inline bool is_hyp_callable(void)
+{
+	return is_hyp_mode_available() && !is_kernel_in_hyp_mode();
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* ! __ASM__VIRT_H */
diff --git a/arch/arm64/kernel/cpu-reset.h b/arch/arm64/kernel/cpu-reset.h
index 9a7b1262ef17..48d0ed48c147 100644
--- a/arch/arm64/kernel/cpu-reset.h
+++ b/arch/arm64/kernel/cpu-reset.h
@@ -20,8 +20,7 @@ static inline void __noreturn __nocfi cpu_soft_restart(unsigned long entry,
 {
 	typeof(__cpu_soft_restart) *restart;
 
-	unsigned long el2_switch = !is_kernel_in_hyp_mode() &&
-		is_hyp_mode_available();
+	unsigned long el2_switch = is_hyp_callable();
 	restart = (void *)__pa_symbol(function_nocfi(__cpu_soft_restart));
 
 	cpu_install_idmap();
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index b1cef371df2b..c764574a1acb 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -48,9 +48,6 @@
  */
 extern int in_suspend;
 
-/* Do we need to reset el2? */
-#define el2_reset_needed() (is_hyp_mode_available() && !is_kernel_in_hyp_mode())
-
 /* temporary el2 vectors in the __hibernate_exit_text section. */
 extern char hibernate_el2_vectors[];
 
@@ -125,7 +122,7 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
 	hdr->reenter_kernel	= _cpu_resume;
 
 	/* We can't use __hyp_get_vectors() because kvm may still be loaded */
-	if (el2_reset_needed())
+	if (is_hyp_callable())
 		hdr->__hyp_stub_vectors = __pa_symbol(__hyp_stub_vectors);
 	else
 		hdr->__hyp_stub_vectors = 0;
@@ -387,7 +384,7 @@ int swsusp_arch_suspend(void)
 		dcache_clean_range(__idmap_text_start, __idmap_text_end);
 
 		/* Clean kvm setup code to PoC? */
-		if (el2_reset_needed()) {
+		if (is_hyp_callable()) {
 			dcache_clean_range(__hyp_idmap_text_start, __hyp_idmap_text_end);
 			dcache_clean_range(__hyp_text_start, __hyp_text_end);
 		}
@@ -482,7 +479,7 @@ int swsusp_arch_resume(void)
 	 *
 	 * We can skip this step if we booted at EL1, or are running with VHE.
 	 */
-	if (el2_reset_needed()) {
+	if (is_hyp_callable()) {
 		phys_addr_t el2_vectors = (phys_addr_t)hibernate_exit;
 		el2_vectors += hibernate_el2_vectors -
 			       __hibernate_exit_text_start;     /* offset */
diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index 2c7ca449dd51..af0ac2f920cf 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -200,7 +200,7 @@ unsigned long sdei_arch_get_entry_point(int conduit)
 	 * dropped to EL1 because we don't support VHE, then we can't support
 	 * SDEI.
 	 */
-	if (is_hyp_mode_available() && !is_kernel_in_hyp_mode()) {
+	if (is_hyp_callable()) {
 		pr_err("Not supported on this hardware/boot configuration\n");
 		goto out_err;
 	}
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
