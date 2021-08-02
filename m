Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mAft2-000Jlp-NA
 for kexec@lists.infradead.org; Mon, 02 Aug 2021 21:54:20 +0000
Received: by mail-qk1-x730.google.com with SMTP id z24so18113670qkz.7
 for <kexec@lists.infradead.org>; Mon, 02 Aug 2021 14:54:16 -0700 (PDT)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v16 03/15] arm64: hibernate: abstract ttrb0 setup function
Date: Mon,  2 Aug 2021 17:53:56 -0400
Message-Id: <20210802215408.804942-4-pasha.tatashin@soleen.com>
In-Reply-To: <20210802215408.804942-1-pasha.tatashin@soleen.com>
References: <20210802215408.804942-1-pasha.tatashin@soleen.com>
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

Currently, only hibernate sets custom ttbr0 with safe idmaped function.
Kexec, is also going to be using this functionality when relocation code
is going to be idmapped.

Move the setup sequence to a dedicated cpu_install_ttbr0() for custom
ttbr0.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/mmu_context.h | 24 ++++++++++++++++++++++++
 arch/arm64/kernel/hibernate.c        | 21 +--------------------
 2 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index eeb210997149..edb57e075abe 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -115,6 +115,30 @@ static inline void cpu_install_idmap(void)
 	cpu_switch_mm(lm_alias(idmap_pg_dir), &init_mm);
 }
 
+/*
+ * Load our new page tables. A strict BBM approach requires that we ensure that
+ * TLBs are free of any entries that may overlap with the global mappings we are
+ * about to install.
+ *
+ * For a real hibernate/resume/kexec cycle TTBR0 currently points to a zero
+ * page, but TLBs may contain stale ASID-tagged entries (e.g. for EFI runtime
+ * services), while for a userspace-driven test_resume cycle it points to
+ * userspace page tables (and we must point it at a zero page ourselves).
+ *
+ * We change T0SZ as part of installing the idmap. This is undone by
+ * cpu_uninstall_idmap() in __cpu_suspend_exit().
+ */
+static inline void cpu_install_ttbr0(phys_addr_t ttbr0, unsigned long t0sz)
+{
+	cpu_set_reserved_ttbr0();
+	local_flush_tlb_all();
+	__cpu_set_tcr_t0sz(t0sz);
+
+	/* avoid cpu_switch_mm() and its SW-PAN and CNP interactions */
+	write_sysreg(ttbr0, ttbr0_el1);
+	isb();
+}
+
 /*
  * Atomically replaces the active TTBR1_EL1 PGD with a new VA-compatible PGD,
  * avoiding the possibility of conflicting TLB entries being allocated.
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index b96ef9060e4c..2758f75d6809 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -212,26 +212,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	if (rc)
 		return rc;
 
-	/*
-	 * Load our new page tables. A strict BBM approach requires that we
-	 * ensure that TLBs are free of any entries that may overlap with the
-	 * global mappings we are about to install.
-	 *
-	 * For a real hibernate/resume cycle TTBR0 currently points to a zero
-	 * page, but TLBs may contain stale ASID-tagged entries (e.g. for EFI
-	 * runtime services), while for a userspace-driven test_resume cycle it
-	 * points to userspace page tables (and we must point it at a zero page
-	 * ourselves).
-	 *
-	 * We change T0SZ as part of installing the idmap. This is undone by
-	 * cpu_uninstall_idmap() in __cpu_suspend_exit().
-	 */
-	cpu_set_reserved_ttbr0();
-	local_flush_tlb_all();
-	__cpu_set_tcr_t0sz(t0sz);
-	write_sysreg(trans_ttbr0, ttbr0_el1);
-	isb();
-
+	cpu_install_ttbr0(trans_ttbr0, t0sz);
 	*phys_dst_addr = virt_to_phys(page);
 
 	return 0;
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
