Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83116CDB466
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 20:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qdf9wlEwYGQxvc+Hf3szutVgopWEGslSCHkRt8TVTVk=; b=3doTWrqOtI3+8ROgadtwRZwbhs
	f/ansboBulMdAYDLhiCEz1OJvQ3k+IGAsr/i0dNcPzWSqModRuDm2BJ0fID4oPJJ61QG8KjHJXYFR
	wMyTsppWRvwic7oNMEPVD7MTF+1BMra5IpVfzsWpA5WhMJxuHE0JwhcaRaobn1TggzWxMWgH7QRBb
	kV2iRds3K3EIVkww8T9LXr1RyrYuNPacOC7w0ok3k85gH4aJyA58mjmIZ0XlLlYcFwg2oxKMfYh04
	GBnmwfPQSzia3i0JpX5E/xSQCmXd3Xs36VLm6V9+7ERbTSuwd1Dsr4fwpnBply363UjssBQhEUe3T
	k/GKtLsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wblgk-00000005Nnk-21E4;
	Mon, 22 Jun 2026 20:56:14 +0000
Received: from esa4.hc555-34.eu.iphmx.com ([207.54.77.171])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wblgg-00000005NhR-2xYb
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 20:56:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1782161770; x=1813697770;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a9YQotg7g+Yczu2ysjgVcjHM/oVcXa3nHLiYH4oeaBw=;
  b=ux1Zm7V//nefve1FsT7O9lJ44hLhXUNJbnpr1//erpUgNdoc7SsYCYzs
   GtQEZtLCfFHh5cVrRy5VqmJBThL2WVFRL5r+vwfd7pz2Zw93MIZX/zAVj
   P44D2BKUCM3ZYTOZr1V0+Qtj3nbhbQYtM106BJpgLcfrCRtkCq65ZaEVX
   QqYKfAGvXRzQkajLZFS99LWRz6rpo4xb72jiIOzomWWgtvNx7BBpaETCV
   44Xl6YQ1WQUaz2qZoijC0reK6Cs/zdkUMmPfWMmIA2UKXhmksrYvlxRzK
   XLyG95N9PzKJA4FXH8EOZ9azCXYlXEcvz1egiuFZqyAIE81j3IVkL2zRM
   g==;
X-CSE-ConnectionGUID: rQD5raQuQjS7Rxwb562Qrw==
X-CSE-MsgGUID: x/PftGlQTxGqwiXRU6lUvg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
  by esa4.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 23:56:09 +0300
X-CSE-ConnectionGUID: uLOAQ7XSSsez1eWG0SFh+w==
X-CSE-MsgGUID: GQH1QkgwRmixY8o6UAeWxw==
Received: from unknown (HELO epgd034.me-corp.lan) ([10.154.54.3])
  by ces03_data.me-corp.lan with SMTP; 23 Jun 2026 00:01:09 +0300
Received: by epgd034.me-corp.lan (sSMTP sendmail emulation); Mon, 22 Jun 2026 23:56:08 +0300
From: Pnina Feder <pnina.feder@mobileye.com>
To: kexec@lists.infradead.org
Cc: horms@kernel.org,
	Pnina Feder <pnina.feder@mobileye.com>
Subject: [PATCH 06/10] vmcore_tasks: arch: Add MIPS64 architecture support
Date: Mon, 22 Jun 2026 23:54:44 +0300
Message-ID: <20260622205550.1087163-7-pnina.feder@mobileye.com>
In-Reply-To: <20260622205550.1087163-1-pnina.feder@mobileye.com>
References: <20260622205550.1087163-1-pnina.feder@mobileye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_135611_257218_DF1C234B 
X-CRM114-Status: GOOD (  21.03  )
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

Add MIPS64 page table translation and instruction helpers:

- mips64_defs.h: MIPS64 instruction format helpers, pt_regs
  register structure (32 GPRs + CP0), opcode constants.

- 3-level page table walk (PGD -> PMD -> PTE) with parameters
  read from vmcoreinfo at runtime: _PFN_SHIFT, _PFN_MASK,
  PMD_SHIFT, PGDIR_SHIFT, PTRS_PER_*, _PAGE_PRESENT, _PAGE_VALID.
  Falls back to sensible defaults when entries are missing.
  Derives max physical address bits from PT_LOAD segments when
  vmcoreinfo lacks _MAX_PHYSMEM_BITS.

- Direct kernel virtual-to-physical translation overriding the
  weak defaults in memory.c for MIPS64 fixed segments: XKPHYS
  (cached CCA=3), KSEG0, and KSEG1.

- Instruction decode helpers for the generic unwinder:
  is_sp_move_ins: detects addiu/daddiu sp,sp,imm
  is_ra_save_ins: detects sw/sd ra,offset(sp)
  is_end_of_backtrace: detects 0xf825 (move ra,zero) sentinel

- Signal trampoline detection: deterministic matching of the
  MIPS rt_sigreturn instruction pair (li v0,__NR_rt_sigreturn;
  syscall). Validates syscall numbers for o32, n32, and n64
  ABIs. Signal frame layout driven by vmcoreinfo offsets.

- Register formatting for MIPS64 pt_regs in tasks output.

Signed-off-by: Pnina Feder <pnina.feder@mobileye.com>
---
 vmcore_tasks/arch/mips64/mips64.c      | 648 +++++++++++++++++++++++++
 vmcore_tasks/arch/mips64/mips64_defs.h |  78 +++
 2 files changed, 726 insertions(+)
 create mode 100644 vmcore_tasks/arch/mips64/mips64.c
 create mode 100644 vmcore_tasks/arch/mips64/mips64_defs.h

diff --git a/vmcore_tasks/arch/mips64/mips64.c b/vmcore_tasks/arch/mips64/mips64.c
new file mode 100644
index 00000000..09ad5497
--- /dev/null
+++ b/vmcore_tasks/arch/mips64/mips64.c
@@ -0,0 +1,648 @@
+#include <stdint.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <string.h>
+
+#include "memory.h"
+#include "vmcore_info.h"
+#include "elf_info.h"
+
+#include "vmcore_tasks_defs.h"
+
+/* ========================================================================
+ * MIPS64 Memory Layout Overrides
+ *
+ * MIPS64 uses fixed address segments instead of configurable PAGE_OFFSET:
+ *
+ *   XKPHYS:  0x8000000000000000 - 0xBFFFFFFFFFFFFFFF
+ *            paddr = kvaddr & 0x07FFFFFFFFFFFFFF
+ *            Cached (CCA=3): 0x9800000000000000
+ *
+ *   KSEG0:   0xFFFFFFFF80000000 - 0xFFFFFFFF9FFFFFFF
+ *            paddr = kvaddr & 0x1FFFFFFF
+ *
+ *   KSEG1:   0xFFFFFFFFA0000000 - 0xFFFFFFFFBFFFFFFF
+ *            paddr = kvaddr & 0x1FFFFFFF
+ * ======================================================================== */
+
+#define MIPS64_XKPHYS_CACHED   0x9800000000000000ULL
+#define MIPS64_XKPHYS_BASE     0x8000000000000000ULL
+#define MIPS64_XKPHYS_TOP      0xBFFFFFFFFFFFFFFFULL
+#define MIPS64_XKPHYS_PHYS_MASK 0x07FFFFFFFFFFFFFFULL  /* bits [58:0] = physical address */
+
+#define MIPS64_KSEG0_BASE      0xFFFFFFFF80000000ULL
+#define MIPS64_KSEG0_END       0xFFFFFFFF9FFFFFFFULL
+#define MIPS64_KSEG1_BASE      0xFFFFFFFFA0000000ULL
+#define MIPS64_KSEG1_END       0xFFFFFFFFBFFFFFFFULL
+#define MIPS64_KSEG_MASK       0x1FFFFFFFULL
+
+#define MIPS_SYSCALL_MASK 0xFC00003F
+#define MIPS_SYSCALL_INS  0x0000000C
+
+#ifndef MIPS_OP_ORI
+#define MIPS_OP_ORI 0x0d
+#endif
+
+#ifndef MIPS_REG_V0
+#define MIPS_REG_V0 2
+#endif
+
+/* __NR_rt_sigreturn values by ABI (Linux MIPS syscall base + table index). */
+#define MIPS_NR_RT_SIGRETURN_O32 4193U  /* 4000 + 193 */
+#define MIPS_NR_RT_SIGRETURN_N64 5211U  /* 5000 + 211 */
+#define MIPS_NR_RT_SIGRETURN_N32 6211U  /* 6000 + 211 */
+
+/* MIPS64 pagetable walk runtime parameters (from vmcoreinfo, with fallbacks) */
+static uint64_t mips64_page_present;
+static uint64_t mips64_page_valid;
+static uint64_t mips64_pfn_mask;
+static unsigned int mips64_pfn_shift;
+static unsigned int mips64_pmd_shift;
+static unsigned int mips64_pgdir_shift;
+static unsigned int mips64_page_shift;
+static uint64_t mips64_pgd_mask;
+static uint64_t mips64_pmd_mask;
+static uint64_t mips64_pte_mask;
+static uint64_t mips64_level_mask;
+static uint64_t mips64_phys_mask;
+
+static inline uint64_t mips64_entry_phys_base(uint64_t entry)
+{
+	uint64_t base;
+
+	if (mips64_pfn_mask) {
+		uint64_t pfn = (entry & mips64_pfn_mask) >> mips64_pfn_shift;
+		base = (pfn << mips64_page_shift);
+	} else {
+		base = entry & SYS_PAGE_MASK;
+	}
+
+	return base & mips64_phys_mask;
+}
+
+static inline bool mips64_pte_is_present_valid(uint64_t pte)
+{
+	if (!(pte & mips64_page_present))
+		return false;
+
+	if (mips64_page_valid && !(pte & mips64_page_valid))
+		return false;
+
+	return true;
+}
+
+static inline uint64_t mips64_pgd_index(uint64_t vaddr)
+{
+	return (vaddr >> mips64_pgdir_shift) & mips64_pgd_mask;
+}
+
+static inline uint64_t mips64_pmd_index(uint64_t vaddr)
+{
+	return (vaddr >> mips64_pmd_shift) & mips64_pmd_mask;
+}
+
+static inline uint64_t mips64_pte_index(uint64_t vaddr)
+{
+	return (vaddr >> mips64_page_shift) & mips64_pte_mask;
+}
+
+static bool mips64_table_entry_to_paddr(uint64_t entry,
+					const char *level,
+					uint64_t *table_paddr)
+{
+	uint64_t aligned = (entry & SYS_PAGE_MASK) & mips64_phys_mask;
+
+	if (!aligned) {
+		pr_trace("mips64_vtop: %s entry 0x%llx aligns to 0\n",
+			 level, (unsigned long long)entry);
+		return false;
+	}
+
+	if (is_kvaddr(aligned)) {
+		if (!vtop_direct(aligned, table_paddr)) {
+			pr_trace("mips64_vtop: %s aligned kvaddr 0x%llx failed direct vtop\n",
+				 level, (unsigned long long)aligned);
+			return false;
+		}
+		pr_trace("mips64_vtop: %s entry 0x%llx (kvaddr 0x%llx) -> next table paddr 0x%llx\n",
+			 level, (unsigned long long)entry,
+			 (unsigned long long)aligned,
+			 (unsigned long long)*table_paddr);
+		return true;
+	}
+
+	*table_paddr = aligned;
+	pr_trace("mips64_vtop: %s entry 0x%llx -> next table paddr 0x%llx\n",
+		 level, (unsigned long long)entry,
+		 (unsigned long long)*table_paddr);
+	return true;
+}
+
+void mips64_pagetable_init(void)
+{
+	uint64_t max_phys_bits;
+	uint64_t ptrs_per;
+	unsigned long long phys_start;
+	unsigned long long phys_end;
+	unsigned long long virt_start;
+	unsigned long long virt_end;
+	unsigned long long max_phys_seen = 0;
+	int idx;
+
+	mips64_page_shift = get_page_shift();
+
+	if (NUMBER_EXISTS("_PAGE_PRESENT"))
+		mips64_page_present = NUMBER("_PAGE_PRESENT");
+	else
+		mips64_page_present = MIPS64_PTE_PRESENT;
+
+	if (NUMBER_EXISTS("_PAGE_VALID"))
+		mips64_page_valid = NUMBER("_PAGE_VALID");
+	else
+		mips64_page_valid = 0;
+
+	if (NUMBER_EXISTS("_PFN_SHIFT"))
+		mips64_pfn_shift = (unsigned int)NUMBER("_PFN_SHIFT");
+	else
+		mips64_pfn_shift = 15;
+
+	if (NUMBER_EXISTS("_PFN_MASK"))
+		mips64_pfn_mask = NUMBER("_PFN_MASK");
+	else
+		mips64_pfn_mask = 0;
+
+	if (NUMBER_EXISTS("PMD_SHIFT"))
+		mips64_pmd_shift = (unsigned int)NUMBER("PMD_SHIFT");
+	else
+		mips64_pmd_shift = (mips64_page_shift * 2) - 3;
+
+	if (NUMBER_EXISTS("PGDIR_SHIFT"))
+		mips64_pgdir_shift = (unsigned int)NUMBER("PGDIR_SHIFT");
+	else
+		mips64_pgdir_shift = mips64_pmd_shift + mips64_page_shift - 3;
+
+	if (mips64_page_shift < 4)
+		mips64_level_mask = 0;
+	else
+		mips64_level_mask = (1ULL << (mips64_page_shift - 3)) - 1;
+
+	mips64_pgd_mask = mips64_level_mask;
+	mips64_pmd_mask = mips64_level_mask;
+	mips64_pte_mask = mips64_level_mask;
+
+	if (NUMBER_EXISTS("PTRS_PER_PGD")) {
+		ptrs_per = NUMBER("PTRS_PER_PGD");
+		if (ptrs_per)
+			mips64_pgd_mask = ptrs_per - 1;
+	}
+	if (NUMBER_EXISTS("PTRS_PER_PMD")) {
+		ptrs_per = NUMBER("PTRS_PER_PMD");
+		if (ptrs_per)
+			mips64_pmd_mask = ptrs_per - 1;
+	}
+	if (NUMBER_EXISTS("PTRS_PER_PTE")) {
+		ptrs_per = NUMBER("PTRS_PER_PTE");
+		if (ptrs_per)
+			mips64_pte_mask = ptrs_per - 1;
+	}
+
+	if (NUMBER_EXISTS("_MAX_PHYSMEM_BITS"))
+		max_phys_bits = NUMBER("_MAX_PHYSMEM_BITS");
+	else if (NUMBER_EXISTS("MAX_PHYSMEM_BITS"))
+		max_phys_bits = NUMBER("MAX_PHYSMEM_BITS");
+	else {
+		max_phys_bits = 0;
+		for (idx = 0; get_pt_load(idx, &phys_start, &phys_end,
+					  &virt_start, &virt_end); idx++) {
+			(void)virt_start;
+			(void)virt_end;
+			if (phys_end > 0 && (phys_end - 1) > max_phys_seen)
+				max_phys_seen = phys_end - 1;
+		}
+
+		if (max_phys_seen) {
+			max_phys_bits = 64U - (uint64_t)__builtin_clzll(max_phys_seen);
+			pr_trace("mips64 pagetable: derived max phys bits=%llu from PT_LOAD max paddr=0x%llx\n",
+				 (unsigned long long)max_phys_bits,
+				 (unsigned long long)max_phys_seen);
+		} else {
+			max_phys_bits = 59;
+		}
+	}
+
+	if (max_phys_bits >= 64)
+		mips64_phys_mask = ~0ULL;
+	else
+		mips64_phys_mask = (1ULL << max_phys_bits) - 1;
+
+	pr_trace("mips64 pagetable: page_shift=%u pfn_shift=%u pfn_mask=0x%llx "
+		 "pmd_shift=%u pgdir_shift=%u present=0x%llx valid=0x%llx "
+		 "masks[pgd=0x%llx pmd=0x%llx pte=0x%llx] phys_mask=0x%llx\n",
+		 mips64_page_shift, mips64_pfn_shift,
+		 (unsigned long long)mips64_pfn_mask,
+		 mips64_pmd_shift, mips64_pgdir_shift,
+		 (unsigned long long)mips64_page_present,
+		 (unsigned long long)mips64_page_valid,
+		 (unsigned long long)mips64_pgd_mask,
+		 (unsigned long long)mips64_pmd_mask,
+		 (unsigned long long)mips64_pte_mask,
+		 (unsigned long long)mips64_phys_mask);
+}
+
+bool mips64_vtop(uint64_t pgd_paddr, uint64_t vaddr, uint64_t *paddr)
+{
+	uint64_t pgd_idx;
+	uint64_t pmd_idx;
+	uint64_t pte_idx;
+	uint64_t pgd_entry;
+	uint64_t pmd_entry;
+	uint64_t pte_entry;
+	uint64_t pmd_paddr;
+	uint64_t pte_paddr;
+	uint64_t raw_paddr;
+
+	pgd_idx = mips64_pgd_index(vaddr);
+	pmd_idx = mips64_pmd_index(vaddr);
+	pte_idx = mips64_pte_index(vaddr);
+
+	pr_trace("mips64_vtop: walk vaddr=0x%llx pgd_paddr=0x%llx idx[pgd=%llu pmd=%llu pte=%llu]\n",
+		 (unsigned long long)vaddr,
+		 (unsigned long long)pgd_paddr,
+		 (unsigned long long)pgd_idx,
+		 (unsigned long long)pmd_idx,
+		 (unsigned long long)pte_idx);
+
+	uint64_t pgd_entry_paddr = pgd_paddr + (pgd_idx * sizeof(uint64_t));
+	if (readmem(pgd_entry_paddr, &pgd_entry, sizeof(pgd_entry), "pgd_entry", PADDR) < 0) {
+		pr_verbose("mips64_vtop: failed read PGD entry at paddr=0x%llx\n",
+			 (unsigned long long)pgd_entry_paddr);
+		return false;
+	}
+
+	pr_trace("mips64_vtop: PGD[%llu] @0x%llx = 0x%llx\n",
+		 (unsigned long long)pgd_idx,
+		 (unsigned long long)pgd_entry_paddr,
+		 (unsigned long long)pgd_entry);
+
+	if (!pgd_entry) {
+		pr_verbose("mips64_vtop: empty PGD entry\n");
+		return false;
+	}
+
+	if (!mips64_table_entry_to_paddr(pgd_entry, "PGD", &pmd_paddr))
+		return false;
+
+	uint64_t pmd_entry_paddr = pmd_paddr + (pmd_idx * sizeof(uint64_t));
+	if (readmem(pmd_entry_paddr, &pmd_entry, sizeof(pmd_entry), "pmd_entry", PADDR) < 0) {
+		pr_verbose("mips64_vtop: failed read PMD entry at paddr=0x%llx\n",
+			 (unsigned long long)pmd_entry_paddr);
+		return false;
+	}
+
+	pr_trace("mips64_vtop: PMD[%llu] @0x%llx = 0x%llx\n",
+		 (unsigned long long)pmd_idx,
+		 (unsigned long long)pmd_entry_paddr,
+		 (unsigned long long)pmd_entry);
+
+	if (!pmd_entry) {
+		pr_verbose("mips64_vtop: empty PMD entry\n");
+		return false;
+	}
+
+	if (!mips64_table_entry_to_paddr(pmd_entry, "PMD", &pte_paddr))
+		return false;
+
+	uint64_t pte_entry_paddr = pte_paddr + (pte_idx * sizeof(uint64_t));
+	if (readmem(pte_entry_paddr, &pte_entry, sizeof(pte_entry), "pte_entry", PADDR) < 0) {
+		pr_verbose("mips64_vtop: failed read PTE entry at paddr=0x%llx\n",
+			 (unsigned long long)pte_entry_paddr);
+		return false;
+	}
+
+	pr_trace("mips64_vtop: PTE[%llu] @0x%llx = 0x%llx\n",
+		 (unsigned long long)pte_idx,
+		 (unsigned long long)pte_entry_paddr,
+		 (unsigned long long)pte_entry);
+
+	if (!mips64_pte_is_present_valid(pte_entry)) {
+		pr_verbose("mips64_vtop: PTE not valid/present (pte=0x%llx present=0x%llx valid=0x%llx)\n",
+			 (unsigned long long)pte_entry,
+			 (unsigned long long)mips64_page_present,
+			 (unsigned long long)mips64_page_valid);
+		return false;
+	}
+
+	if (mips64_pfn_mask) {
+		uint64_t pfn = (pte_entry & mips64_pfn_mask) >> mips64_pfn_shift;
+		raw_paddr = (pfn << mips64_page_shift) | (vaddr & (SYS_PAGE_SIZE - 1));
+	} else {
+		raw_paddr = ((pte_entry >> mips64_pfn_shift) << mips64_page_shift) |
+			  (vaddr & (SYS_PAGE_SIZE - 1));
+	}
+
+	*paddr = raw_paddr & mips64_phys_mask;
+
+	pr_trace("mips64_vtop: success vaddr=0x%llx -> raw_paddr=0x%llx masked_paddr=0x%llx (page_off=0x%llx)\n",
+		 (unsigned long long)vaddr,
+			(unsigned long long)raw_paddr,
+		 (unsigned long long)*paddr,
+		 (unsigned long long)(vaddr & (SYS_PAGE_SIZE - 1)));
+
+	return true;
+}
+
+/**
+ * get_page_offset - MIPS64 uses XKPHYS cached segment as PAGE_OFFSET
+ */
+uint64_t get_page_offset(void)
+{
+	return MIPS64_XKPHYS_CACHED;
+}
+
+/**
+ * is_kvaddr - check if address is in a MIPS64 kernel segment
+ */
+bool is_kvaddr(uint64_t vaddr)
+{
+	/* XKPHYS: 0x8000000000000000 - 0xBFFFFFFFFFFFFFFF (top 2 bits = 10) */
+	if (vaddr >= MIPS64_XKPHYS_BASE && vaddr <= MIPS64_XKPHYS_TOP)
+		return true;
+
+	/* KSEG0 */
+	if (vaddr >= MIPS64_KSEG0_BASE && vaddr <= MIPS64_KSEG0_END)
+		return true;
+
+	/* KSEG1 */
+	if (vaddr >= MIPS64_KSEG1_BASE && vaddr <= MIPS64_KSEG1_END)
+		return true;
+
+	return false;
+}
+
+/**
+ * vtop_direct - MIPS64 kernel virtual to physical translation
+ */
+bool vtop_direct(uint64_t kvaddr, uint64_t *paddr)
+{
+	if (kvaddr >= MIPS64_XKPHYS_BASE && kvaddr <= MIPS64_XKPHYS_TOP) {
+		*paddr = kvaddr & MIPS64_XKPHYS_PHYS_MASK;
+		return true;
+	}
+
+	if (kvaddr >= MIPS64_KSEG0_BASE && kvaddr <= MIPS64_KSEG0_END) {
+		*paddr = kvaddr & MIPS64_KSEG_MASK;
+		return true;
+	}
+
+	if (kvaddr >= MIPS64_KSEG1_BASE && kvaddr <= MIPS64_KSEG1_END) {
+		*paddr = kvaddr & MIPS64_KSEG_MASK;
+		return true;
+	}
+
+	return false;
+}
+
+
+
+/*
+ * MIPS64 instruction helpers for the generic unwinder.
+ */
+
+/**
+ * is_sp_move_ins_mips64 - detect stack pointer adjustment
+ *
+ * Matches:
+ *   addiu sp, sp, imm   (opcode 0x09, rs=29, rt=29)
+ *   daddiu sp, sp, imm  (opcode 0x19, rs=29, rt=29)
+ *
+ * Also detects (but ignores) dynamic stack allocation:
+ *   dsubu sp, sp, v0     (R-format, func=0x2f, rs=29, rd=29, rt=2)
+ */
+static bool is_sp_move_ins_mips64(uint32_t insn, int *stack_adj)
+{
+	unsigned int opcode = mips_opcode(insn);
+	unsigned int rs = mips_rs(insn);
+	unsigned int rt = mips_rt(insn);
+
+	/* addiu sp, sp, imm  or  daddiu sp, sp, imm */
+	if (rs == MIPS_REG_SP && rt == MIPS_REG_SP) {
+		if (opcode == MIPS_OP_ADDIU || opcode == MIPS_OP_DADDIU) {
+			*stack_adj = (int)mips_simmediate(insn);
+			return true;
+		}
+	}
+
+	/* dsubu sp, sp, v0 — dynamic stack allocation, log but don't report */
+	if (opcode == MIPS_OP_SPECIAL &&
+		mips_func(insn) == MIPS_FUNC_DSUBU &&
+		rs == MIPS_REG_SP &&
+		mips_rd(insn) == MIPS_REG_SP &&
+		rt == 2) {
+		pr_trace("mips64: dynamic stack allocation (dsubu sp,sp,v0) at insn=0x%08x\n", insn);
+	}
+
+	return false;
+}
+
+/**
+ * is_ra_save_ins_mips64 - detect RA save to stack
+ *
+ * Matches:
+ *   sw ra, offset(sp)   (opcode 0x2b, rs=29, rt=31)
+ *   sd ra, offset(sp)   (opcode 0x3f, rs=29, rt=31)
+ */
+static bool is_ra_save_ins_mips64(uint32_t insn, unsigned long *ra_offset)
+{
+	unsigned int opcode = mips_opcode(insn);
+	unsigned int rs = mips_rs(insn);
+	unsigned int rt = mips_rt(insn);
+
+	if ((opcode == MIPS_OP_SW || opcode == MIPS_OP_SD) &&
+		rs == MIPS_REG_SP && rt == MIPS_REG_RA) {
+		int16_t imm = mips_simmediate(insn);
+
+		if (imm < 0)
+			return false;
+
+		*ra_offset = (unsigned long)imm;
+		return true;
+	}
+
+	return false;
+}
+
+/**
+ * is_end_of_backtrace_mips64 - detect end-of-backtrace marker
+ *
+ * The kernel uses 0xf825 (move ra, zero / or ra, zero, zero)
+ * as a sentinel indicating no further frames.
+ */
+static bool is_end_of_backtrace_mips64(uint32_t insn)
+{
+	if (insn == MIPS_END_OF_BT_MARKER) {
+		pr_trace("mips64: found end of backtrace marker\n");
+		return true;
+	}
+	return false;
+}
+
+/**
+ * read_task_registers - MIPS64 override
+ */
+bool read_task_registers(uint64_t stack_ptr, struct pt_regs *regs)
+{
+	uint64_t regs_addr;
+	size_t pt_regs_size = SIZE("pt_regs");
+	size_t thread_size = NUMBER("THREAD_SIZE");
+
+	if (!stack_ptr) {
+		fprintf(stderr, "Invalid stack pointer\n");
+		return false;
+	}
+
+	regs_addr = stack_ptr + thread_size - 32 - pt_regs_size;
+
+	pr_verbose("mips64 read_task_registers: stack=0x%llx thread_size=%zu "
+		 "pt_regs_size=%zu regs_addr=0x%llx\n",
+		 (unsigned long long)stack_ptr, thread_size,
+		 pt_regs_size, (unsigned long long)regs_addr);
+
+	if (readmem(regs_addr, regs, pt_regs_size, "read pt_regs", KVADDR) < 0) {
+		fprintf(stderr, "Failed to read pt_regs from 0x%016llx\n",
+			(unsigned long long)regs_addr);
+		return false;
+	}
+
+	return true;
+}
+
+static inline bool mips64_is_rt_sigreturn_nr(uint32_t nr)
+{
+	return nr == MIPS_NR_RT_SIGRETURN_O32 ||
+	       nr == MIPS_NR_RT_SIGRETURN_N64 ||
+	       nr == MIPS_NR_RT_SIGRETURN_N32;
+}
+
+/*
+ * Match "li v0, __NR_rt_sigreturn" forms used before syscall:
+ *   addiu  v0, zero, imm
+ *   daddiu v0, zero, imm
+ *   ori    v0, zero, imm
+ */
+static inline bool mips64_extract_li_v0_imm(uint32_t insn, uint32_t *imm_out)
+{
+	unsigned int opcode = mips_opcode(insn);
+	unsigned int rs = mips_rs(insn);
+	unsigned int rt = mips_rt(insn);
+
+	if (!imm_out)
+		return false;
+
+	if (rs != 0 || rt != MIPS_REG_V0)
+		return false;
+
+	if (opcode == MIPS_OP_ADDIU ||
+	    opcode == MIPS_OP_DADDIU ||
+	    opcode == MIPS_OP_ORI) {
+		*imm_out = (uint32_t)(insn & 0xffffU);
+		return true;
+	}
+
+	return false;
+}
+
+static bool mips64_is_rt_sigreturn_trampoline(uint64_t li_addr, uint64_t syscall_addr)
+{
+	uint32_t li_insn = 0;
+	uint32_t sc_insn = 0;
+	uint32_t nr = 0;
+
+	if (readmem(li_addr, &li_insn, sizeof(li_insn), "mips sigtramp li", UVADDR) < 0)
+		return false;
+
+	if (readmem(syscall_addr, &sc_insn, sizeof(sc_insn),
+		    "mips sigtramp syscall", UVADDR) < 0)
+		return false;
+
+	if ((sc_insn & MIPS_SYSCALL_MASK) != MIPS_SYSCALL_INS)
+		return false;
+
+	if (!mips64_extract_li_v0_imm(li_insn, &nr))
+		return false;
+
+	if (!mips64_is_rt_sigreturn_nr(nr))
+		return false;
+
+	pr_trace("mips64: matched rt_sigreturn trampoline li@0x%llx sc@0x%llx nr=%u\n",
+		 (unsigned long long)li_addr,
+		 (unsigned long long)syscall_addr,
+		 nr);
+
+	return true;
+}
+
+static bool mips64_likely_signal_pc(uint64_t pc)
+{
+	/*
+	 * Deterministic sigtramp detection:
+	 *   [li v0, __NR_rt_sigreturn] ; [syscall]
+	 * Accept if PC is on syscall or on the preceding li.
+	 */
+	if (pc >= 4 && mips64_is_rt_sigreturn_trampoline(pc - 4, pc))
+		return true;
+
+	if (pc <= (UINT64_MAX - 4) &&
+	    mips64_is_rt_sigreturn_trampoline(pc, pc + 4))
+		return true;
+
+	return false;
+}
+
+static const struct signal_unwind_layout mips64_sig_layout = {
+	.rt_sigframe_uc_key = "rt_sigframe.rs_uc",
+	.ucontext_mcontext_key = "ucontext.uc_mcontext",
+	.sigcontext_regs_key = "sigcontext.sc_regs",
+	.sigcontext_pc_key = "sigcontext.sc_pc",
+	.reg_width = 8,
+	.sp_reg_index = 29,
+	.ra_reg_index = 31,
+	.pc_reg_index = -1,
+	.pc_reg_alt_index = -1,
+};
+
+/**
+ * mips64_init - initialize arch_deps for MIPS64
+ */
+void mips64_init(void)
+{
+	mips64_pagetable_init();
+	arch.unwind_ops.insn_size           = 4;
+	arch.unwind_ops.ra_width            = 8;
+	arch.unwind_ops.is_sp_move_ins      = is_sp_move_ins_mips64;
+	arch.unwind_ops.is_ra_save_ins      = is_ra_save_ins_mips64;
+	arch.unwind_ops.is_end_of_backtrace = is_end_of_backtrace_mips64;
+	arch.unwind_ops.post_unwind_fixup   = NULL;
+	arch.unwind_ops.likely_signal_pc    = mips64_likely_signal_pc;
+	arch.unwind_ops.signal_layout       = &mips64_sig_layout;
+
+	arch.vtop = mips64_vtop;
+}
+
+void write_user_registers_formatted(FILE *fp, struct pt_regs *regs)
+{
+	fprintf(fp, "user registers:\n");
+	for (int i = 0; i < 32; i += 4) {
+		fprintf(fp, "R%02d:0x%016llx R%02d:0x%016llx R%02d:0x%016llx R%02d:0x%016llx\n",
+			i,     (unsigned long long)regs->regs[i],
+			i + 1, (unsigned long long)regs->regs[i + 1],
+			i + 2, (unsigned long long)regs->regs[i + 2],
+			i + 3, (unsigned long long)regs->regs[i + 3]);
+	}
+	fprintf(fp, "cp0_status:  0x%016llx   hi:       0x%016llx   lo:     0x%016llx\n",
+		(unsigned long long)regs->cp0_status,
+		(unsigned long long)regs->hi, (unsigned long long)regs->lo);
+	fprintf(fp, "cp0_badvaddr:0x%016llx   cp0_cause:0x%016llx   cp0_epc:0x%016llx\n",
+		(unsigned long long)regs->cp0_badvaddr,
+		(unsigned long long)regs->cp0_cause,
+		(unsigned long long)regs->cp0_epc);
+}
\ No newline at end of file
diff --git a/vmcore_tasks/arch/mips64/mips64_defs.h b/vmcore_tasks/arch/mips64/mips64_defs.h
new file mode 100644
index 00000000..97bcdac7
--- /dev/null
+++ b/vmcore_tasks/arch/mips64/mips64_defs.h
@@ -0,0 +1,78 @@
+#ifndef MIPS64_DEFS_H
+#define MIPS64_DEFS_H
+
+#include <stdint.h>
+
+#include "vmcore_info.h"
+
+/* Page table definitions */
+#define SYS_PAGE_SIZE       (get_page_size())
+#define SYS_PAGE_SHIFT      (get_page_shift())
+#define SYS_PAGE_MASK       (~(SYS_PAGE_SIZE - 1))
+
+/*
+ * MIPS64 PTE bit layout (from vmcoreinfo):
+ *
+ *   _PFN_SHIFT   = 15   (bits 0-14 are flags, PFN starts at bit 15)
+ *   PMD_SHIFT    = 25
+ *   PGDIR_SHIFT  = 36
+ *   PGTABLE_LEVELS = 3  (PGD → PMD → PTE)
+ *
+ * Physical address from a leaf PTE:
+ *   paddr = (pte >> _PFN_SHIFT) << PAGE_SHIFT
+ *
+ * PGD and PMD entries store physical addresses of next-level tables
+ * directly — they do NOT use _PFN_SHIFT encoding.
+ */
+
+/* PTE flag bits (bits below _PFN_SHIFT) */
+#define MIPS64_PTE_PRESENT   (1UL << 0)
+
+/* MIPS instruction format helpers */
+
+/* I-format: opcode(6) | rs(5) | rt(5) | immediate(16) */
+static inline unsigned int mips_opcode(uint32_t insn)   { return (insn >> 26) & 0x3f; }
+static inline unsigned int mips_rs(uint32_t insn)       { return (insn >> 21) & 0x1f; }
+static inline unsigned int mips_rt(uint32_t insn)       { return (insn >> 16) & 0x1f; }
+static inline int16_t      mips_simmediate(uint32_t insn) { return (int16_t)(insn & 0xffff); }
+
+/* R-format: opcode(6) | rs(5) | rt(5) | rd(5) | sa(5) | func(6) */
+static inline unsigned int mips_rd(uint32_t insn)       { return (insn >> 11) & 0x1f; }
+static inline unsigned int mips_func(uint32_t insn)     { return insn & 0x3f; }
+
+/* MIPS opcodes */
+#define MIPS_OP_ADDIU    0x09
+#define MIPS_OP_DADDIU   0x19
+#define MIPS_OP_SW       0x2b
+#define MIPS_OP_SD       0x3f
+#define MIPS_OP_SPECIAL  0x00
+
+/* MIPS R-format function codes */
+#define MIPS_FUNC_DSUBU  0x2f
+
+/* MIPS register numbers */
+#define MIPS_REG_SP      29
+#define MIPS_REG_RA      31
+
+struct pt_regs {
+	/* Saved main processor registers. */
+	unsigned long regs[32];
+
+	/* Saved special registers. */
+	unsigned long cp0_status;
+	unsigned long hi;
+	unsigned long lo;
+	unsigned long cp0_badvaddr;
+	unsigned long cp0_cause;
+	unsigned long cp0_epc;
+	unsigned long __last[0];
+};
+
+#define PT_REGS_PC(X)   ((X).cp0_epc)
+#define PT_REGS_RA(X)   ((X).regs[MIPS_REG_RA])
+#define PT_REGS_SP(X)   ((X).regs[MIPS_REG_SP])
+
+/* End of backtrace marker */
+#define MIPS_END_OF_BT_MARKER  0xf825
+
+#endif /* MIPS64_DEFS_H */
\ No newline at end of file
-- 
2.43.0


