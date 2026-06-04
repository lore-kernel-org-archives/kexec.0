Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE69CD8C80
	for <kexec@archiver.kernel.org>; Thu,  4 Jun 2026 13:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vVBcY3pGKXN86VwrQOSMTZKS6zJWPeD7faRkNJrB9t8=; b=YfX5mPfy36mXgFVPg6FBU3yuON
	Db3W66rSXpZfoBuvtFr/L4JP3IFTmmukLAZQCwcu+DrAZHfiQbQeAwiYIUVqhLAu7wgOax21yxlge
	V9Jr8PWepmdJ9xS1UBXNPkSml0ZH2vXKrWJdbapiuf3M0YSMCm9fnnwSvZwCxV5grbbQB5AzyPwyH
	4YhyEQr4UerOuFmYt1ez3AaiTjcKB+8bSZQ62QFJ65QJ1C4CPByZx64BtVpaI42BSE6HUywwiMDRa
	0Did9qL75iBkI53aR5U5AbK+a2vMmal7UB7lX7IEuQkq4yOHk2yp0MS3ZN+iXXSTOEJAyGc7j7EWL
	wkCiFOGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV83y-0000000GmOP-3Wem;
	Thu, 04 Jun 2026 13:24:46 +0000
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV83r-0000000GmBK-22qf;
	Thu, 04 Jun 2026 13:24:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780579476; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=vVBcY3pGKXN86VwrQOSMTZKS6zJWPeD7faRkNJrB9t8=;
	b=nql2M3KPNeZJn8dHovHmbkhmbzkxor8DNfMdcruWISkkRbckDKjGJAIFVOugzdi6bZl/bKPOdDNDDpiUgEdeBBSi/z6FKtggr9ea5hVWr+HPtVzkDIoxR/IlRdlS52wNAkyEo0KkBpU5UtZNGUf4ktMyhncI5tM3qR5AQjtQPh8=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X4AKnYU_1780579469;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X4AKnYU_1780579469 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 04 Jun 2026 21:24:30 +0800
From: fangyu.yu@linux.alibaba.com
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Nick Kossifidis <mick@ics.forth.gr>
Cc: Song Shuai <songshuaishuai@tinylab.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Richard Lyu <richard.lyu@suse.com>,
	Nam Cao <namcao@linutronix.de>,
	Jisheng Zhang <jszhang@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	guoren@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [PATCH v3 5/9] riscv: kexec: Build trampoline page tables for crash kernel entry
Date: Thu,  4 Jun 2026 21:24:14 +0800
Message-Id: <20260604132418.15725-6-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260604132418.15725-1-fangyu.yu@linux.alibaba.com>
References: <20260604132418.15725-1-fangyu.yu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260604_062439_850377_49E8D049 
X-CRM114-Status: GOOD (  13.21  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

Crash kexec uses riscv_kexec_norelocate as a trampoline to jump into
the crashkernel. Pre-build dedicated 4 KB page tables in
machine_kexec_prepare() that map the trampoline page as executable,
so the panic path only has to switch satp and jump.

Two mappings are installed into a shared pgd:
  - VA(__kexec_tramp_text_start) -> PA(__kexec_tramp_text_start)
  - PA(__kexec_tramp_text_start) -> PA(__kexec_tramp_text_start)

The lower-level tables (p4d/pud/pmd/pte) are shared between both
mappings; map_tramp_page() walks the existing tree and only
populates entries that are still zero, so the two installs coexist
even when their indices happen to collide at any level.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 arch/riscv/kernel/machine_kexec.c | 87 +++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
index e6e179cffc44..1947b7bdf5c4 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -18,6 +18,85 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 
+/*
+ * Trampoline page tables. Both the VA(trampoline)->PA and the
+ * PA(trampoline)->PA identity mapping are installed in this single
+ * pgd; the lower-level tables are shared so the two mappings can
+ * coexist even if they happen to collide at any level (the walker
+ * only populates entries that are still zero).
+ *
+ * Pre-allocate for the largest paging mode (Sv57). Levels that the
+ * runtime mode does not use simply waste a page or two of BSS, in
+ * exchange for a builder that is infallible and safe to run from
+ * the panic path.
+ */
+static pgd_t kexec_tramp_pgd[PTRS_PER_PGD] __aligned(PAGE_SIZE);
+#ifdef CONFIG_64BIT
+static p4d_t kexec_tramp_p4d[PTRS_PER_P4D] __aligned(PAGE_SIZE);
+static pud_t kexec_tramp_pud[PTRS_PER_PUD] __aligned(PAGE_SIZE);
+static pmd_t kexec_tramp_pmd[PTRS_PER_PMD] __aligned(PAGE_SIZE);
+#endif
+static pte_t kexec_tramp_pte[PTRS_PER_PTE] __aligned(PAGE_SIZE);
+
+static void map_tramp_page(unsigned long va, unsigned long pa)
+{
+	pgd_t *pgd = kexec_tramp_pgd + pgd_index(va);
+
+#ifdef CONFIG_64BIT
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	if (pgtable_l5_enabled) {
+		if (pgd_val(*pgd) == 0)
+			set_pgd(pgd, pfn_pgd(PFN_DOWN(__pa_symbol(kexec_tramp_p4d)),
+					     PAGE_TABLE));
+		p4d = kexec_tramp_p4d + p4d_index(va);
+	} else {
+		p4d = (p4d_t *)pgd;
+	}
+
+	if (pgtable_l4_enabled) {
+		if (p4d_val(*p4d) == 0)
+			set_p4d(p4d, pfn_p4d(PFN_DOWN(__pa_symbol(kexec_tramp_pud)),
+					     PAGE_TABLE));
+		pud = kexec_tramp_pud + pud_index(va);
+	} else {
+		pud = (pud_t *)p4d;
+	}
+
+	if (pud_val(*pud) == 0)
+		set_pud(pud, pfn_pud(PFN_DOWN(__pa_symbol(kexec_tramp_pmd)),
+				     PAGE_TABLE));
+	pmd = kexec_tramp_pmd + pmd_index(va);
+
+	if (pmd_val(*pmd) == 0)
+		set_pmd(pmd, pfn_pmd(PFN_DOWN(__pa_symbol(kexec_tramp_pte)),
+				     PAGE_TABLE));
+#else
+	/* Sv32: PGD points directly to the PTE table. */
+	if (pgd_val(*pgd) == 0)
+		set_pgd(pgd, pfn_pgd(PFN_DOWN(__pa_symbol(kexec_tramp_pte)),
+				     PAGE_TABLE));
+#endif
+
+	set_pte(kexec_tramp_pte + pte_index(va),
+		pfn_pte(PFN_DOWN(pa), PAGE_KERNEL_EXEC));
+}
+
+static void riscv_kexec_build_tramp(unsigned long va, unsigned long pa)
+{
+	/* VA -> PA: map the trampoline page via its kernel VA. */
+	map_tramp_page(va, pa);
+
+	/*
+	 * PA -> PA: identity-map the same page so the second-pass code
+	 * can keep executing after the kernel VA mapping is dropped.
+	 */
+	map_tramp_page(pa, pa);
+}
+
+
 /*
  * machine_kexec_prepare - Initialize kexec
  *
@@ -73,6 +152,14 @@ machine_kexec_prepare(struct kimage *image)
 
 		/* Mark the control page executable */
 		set_memory_x((unsigned long) control_code_buffer, 1);
+	} else {
+		/*
+		 * Crash kexec uses riscv_kexec_norelocate as a trampoline.
+		 * Pre-build the trampoline page tables here so the panic
+		 * path only has to switch satp and jump.
+		 */
+		riscv_kexec_build_tramp((unsigned long)__kexec_tramp_text_start,
+					__pa_symbol(__kexec_tramp_text_start));
 	}
 
 	return 0;
-- 
2.50.1


