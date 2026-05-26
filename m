Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8B8CD6E42
	for <kexec@archiver.kernel.org>; Tue, 26 May 2026 12:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DvfO0VeeEacS9q7ZhAuHErWFEWy3R6Vu+rVPY71B4m0=; b=ePJXgZrqtfIvhs2+Z8bAUmTZ7E
	9x4dRW1hRh7DXWr+Ckhoz+PgPCsmznN1w3NCHrz4kftSv+cj7dGzB98xDfgZdahaE4gscdm3baZeB
	zBDw+kux7+S/5XgIa8PnRqcwhomvn6a0VIUQ4ehCr/errdA4gCPr3LobKaFYsC5nittx2sETDTpAc
	ZJGHPogId5D8UwHnG1XUwIBHYJ+bSaKFzmCKCfCfy8/3ZJmT5ObQIiu2lDjnBTVFwWGm0spY/1f0x
	yaarEpV69i0o7ymJ08X5lEpe1VATWnEVzKHkUL2d7/qkuHjHhL6VVCnCAuVi6572vUynIb/ZpaLgA
	r054jaqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRrEw-00000001xhx-1oGZ;
	Tue, 26 May 2026 12:50:34 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRrEp-00000001xcB-0kwt;
	Tue, 26 May 2026 12:50:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779799821; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=DvfO0VeeEacS9q7ZhAuHErWFEWy3R6Vu+rVPY71B4m0=;
	b=YFUxxZsEg3TL69wygoYTOkVhurcT1GLGf+EVtPbndq37jUdyCOAb+JcgYwd3/cy4ED8dr3KKvuTTEf4wjCeKw5Qfa9bjd+bJ/Y0bGw58TfceU9uPkCt+WEY2lSqiIsNTi00uehdUp5UvvRuObjSU03YbCUvRBGTxqu3q8A5SsBw=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X3gDNKm_1779799818;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X3gDNKm_1779799818 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 26 May 2026 20:50:19 +0800
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
Subject: [PATCH v2 3/7] riscv: kexec: Build trampoline page tables for crash kernel entry
Date: Tue, 26 May 2026 20:50:05 +0800
Message-Id: <20260526125009.2404-4-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260526125009.2404-1-fangyu.yu@linux.alibaba.com>
References: <20260526125009.2404-1-fangyu.yu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_055027_823078_4EBD1094 
X-CRM114-Status: GOOD (  12.00  )
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
the crashkernel. Add a small helper to build dedicated 4KB page tables
that map the trampoline page as executable.

Two mappings are installed:
  - VA(__kexec_tramp_text_start) -> PA(__kexec_tramp_text_start)
  - PA(__kexec_tramp_text_start) -> PA(__kexec_tramp_text_start)

This allows the trampoline to run regardless of whether it is entered
via its linked virtual address or its physical address.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 arch/riscv/kernel/machine_kexec.c | 67 +++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
index 2306ce3e5f22..9b4b495e7c15 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -18,6 +18,65 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 
+static pgd_t kexec_tramp_pgd[PTRS_PER_PGD] __aligned(PAGE_SIZE);
+static p4d_t kexec_tramp_p4d[PTRS_PER_P4D] __aligned(PAGE_SIZE);
+static pud_t kexec_tramp_pud[PTRS_PER_PUD] __aligned(PAGE_SIZE);
+static pmd_t kexec_tramp_pmd[PTRS_PER_PMD] __aligned(PAGE_SIZE);
+static pte_t kexec_tramp_pte[PTRS_PER_PTE] __aligned(PAGE_SIZE);
+static p4d_t kexec_tramp_p4d2[PTRS_PER_P4D] __aligned(PAGE_SIZE);
+static pud_t kexec_tramp_pud2[PTRS_PER_PUD] __aligned(PAGE_SIZE);
+static pmd_t kexec_tramp_pmd2[PTRS_PER_PMD] __aligned(PAGE_SIZE);
+static pte_t kexec_tramp_pte2[PTRS_PER_PTE] __aligned(PAGE_SIZE);
+
+static void map_tramp_page(p4d_t *p4ds, pud_t *puds, pmd_t *pmds, pte_t *ptes,
+			   unsigned long va, unsigned long pa)
+{
+	pgd_t *pgd = (pgd_t *)kexec_tramp_pgd + pgd_index(va);
+	pmd_t *pmd;
+
+	if (pgtable_l5_enabled) {
+		p4d_t *p4d;
+
+		set_pgd(pgd, pfn_pgd(PFN_DOWN(__pa_symbol(p4ds)), PAGE_TABLE));
+		p4d = (p4d_t *)p4ds + p4d_index(va);
+		if (pgtable_l4_enabled)
+			set_p4d(p4d, pfn_p4d(PFN_DOWN(__pa_symbol(puds)),
+				PAGE_TABLE));
+		else
+			set_p4d(p4d, pfn_p4d(PFN_DOWN(__pa_symbol(pmds)),
+				PAGE_TABLE));
+	} else {
+		set_pgd(pgd, pfn_pgd(PFN_DOWN(__pa_symbol(puds)), PAGE_TABLE));
+	}
+
+	if (pgtable_l4_enabled) {
+		pud_t *pud = (pud_t *)puds + pud_index(va);
+
+		set_pud(pud, pfn_pud(PFN_DOWN(__pa_symbol(pmds)), PAGE_TABLE));
+		pmd = (pmd_t *)pmds + pmd_index(va);
+	} else {
+		pmd = (pmd_t *)puds + pmd_index(va);
+	}
+	set_pmd(pmd, pfn_pmd(PFN_DOWN(__pa_symbol(ptes)), PAGE_TABLE));
+
+	set_pte((pte_t *)ptes + pte_index(va),
+		pfn_pte(PFN_DOWN(pa), PAGE_KERNEL_EXEC));
+}
+
+static void riscv_kexec_build_tramp(unsigned long va, unsigned long pa)
+{
+	/* VA -> PA: map the trampoline page via its kernel VA. */
+	map_tramp_page(kexec_tramp_p4d,  kexec_tramp_pud,
+		       kexec_tramp_pmd,  kexec_tramp_pte,  va, pa);
+
+	/*
+	 * PA -> PA: identity-map the same page so the second-pass code
+	 * can keep executing after the kernel VA mapping is dropped.
+	 */
+	map_tramp_page(kexec_tramp_p4d2, kexec_tramp_pud2,
+		       kexec_tramp_pmd2, kexec_tramp_pte2, pa, pa);
+}
+
 /*
  * machine_kexec_prepare - Initialize kexec
  *
@@ -73,6 +132,14 @@ machine_kexec_prepare(struct kimage *image)
 
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


