Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A5ACDB477
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 20:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9NandZe2EtKFsiM56Xdbda9fb7UHJ5iGG4kViGXLMVM=; b=ft/D2xZVdtGSnSVHlzZg4AnqEQ
	jzUjGNu1nmf2uDFHjfmZs7XDsIbb6WDcGEBQIlKON/oMF2HvLE3n7bM12wdf3egeCvJxChFfDVBEI
	raJe+QW5C2adY4WBiuRgIhvEo4X2vnx7HO5jXoUD98ZbB+VGknWffpeo0Ccmr88i4mHxywv9kc9eI
	w1swT574ZtEKaGTj40QaBFq72zXtoaa1/wiQYcApjTe4SadsZSI1P4rviZGeFzjuu+l451HEQZOSl
	CnFhgjUITVg0JxgtlAZKb4voGK+G6oKvb0FqCqGDFtdsuzlVBUfESd6ENbsKcU1dR6qagmwuTl3sY
	ms1QXQJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wblgj-00000005Nmg-1Sn6;
	Mon, 22 Jun 2026 20:56:13 +0000
Received: from esa1.hc555-34.eu.iphmx.com ([23.90.104.144])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wblgf-00000005NiT-3huF
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 20:56:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1782161769; x=1813697769;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UcUQGu9/FBxksvg71a0fbVEXTDq9aCpHhke/qIFkjdY=;
  b=jHjJ1u60G50cPogu3H/AudFxZLh9B1JKXP2Pp+o+YCCrIaaixnQDmnRT
   XC4M/99zYReIO5J2aFYjzjNnyuAtd4WsfzYJrS/aDqAG8PLlfrslFVKhw
   YpnmNT7OTqheEBRj4CCufPZ1q06Krh0Dv0TUJCHviOeDTeAWzvPjNpLPp
   sFQNQuUpgZvJsglil/JLmeLi7i1ogtWYOQyE8cLQKmcgO3N5Yk7rspWKi
   vTrITyKrr15mj3sQXcoOs5BOBPfo4s9/E8iWsrS6WDofwDkD4TWXS+LmZ
   QMILg+O5Tlrk1OGAUGKdM5qVEQIKAVAp4nJX41TayH9q+swXaeNPlLw2o
   w==;
X-CSE-ConnectionGUID: 25uvBqGFQ8maQWbClrd9hw==
X-CSE-MsgGUID: /KE6516oTw+gwOehComk+w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 23:56:07 +0300
X-CSE-ConnectionGUID: wp2ATKE5R/SPhg32/qkCCQ==
X-CSE-MsgGUID: c4ToLRasQ5u4o9xSJ5YxaA==
Received: from unknown (HELO epgd034.me-corp.lan) ([10.154.54.3])
  by ces04_data.me-crop.lan with SMTP; 23 Jun 2026 00:01:14 +0300
Received: by epgd034.me-corp.lan (sSMTP sendmail emulation); Mon, 22 Jun 2026 23:56:06 +0300
From: Pnina Feder <pnina.feder@mobileye.com>
To: kexec@lists.infradead.org
Cc: horms@kernel.org,
	Pnina Feder <pnina.feder@mobileye.com>
Subject: [PATCH 05/10] vmcore_tasks: arch: Add RISC-V 64-bit architecture support
Date: Mon, 22 Jun 2026 23:54:43 +0300
Message-ID: <20260622205550.1087163-6-pnina.feder@mobileye.com>
In-Reply-To: <20260622205550.1087163-1-pnina.feder@mobileye.com>
References: <20260622205550.1087163-1-pnina.feder@mobileye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_135610_376575_4F6A381A 
X-CRM114-Status: GOOD (  23.38  )
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

Add RISC-V 64-bit page table translation and instruction helpers:

- riscv64_defs.h: SV39 page table constants, PTE format and
  extraction macros, pt_regs register structure.

- SV39 3-level page table walk (PGD -> PMD -> PTE) with support
  for 1GB gigapages and 2MB megapages at leaf entries.
  SV48 and SV57 stubs selected from vmcoreinfo VA_BITS but not
  yet implemented.

- Instruction decode helpers for the generic unwinder:
  is_sp_move_ins: detects addi sp, sp, imm (stack frame setup)
  is_ra_save_ins: detects sd ra, offset(sp) (RA save to stack)

- Signal frame detection: scans for ecall + li a7,__NR_rt_sigreturn
  pattern near PC to identify signal trampolines. Signal frame
  layout driven by vmcoreinfo offsets (rt_sigframe, ucontext,
  sigcontext).

- Register formatting for pt_regs dump in mini coredump output.

Page size read at runtime from vmcoreinfo via get_page_size().

Signed-off-by: Pnina Feder <pnina.feder@mobileye.com>
---
 vmcore_tasks/arch/riscv64/riscv64.c      | 327 +++++++++++++++++++++++
 vmcore_tasks/arch/riscv64/riscv64_defs.h | 127 +++++++++
 2 files changed, 454 insertions(+)
 create mode 100644 vmcore_tasks/arch/riscv64/riscv64.c
 create mode 100644 vmcore_tasks/arch/riscv64/riscv64_defs.h

diff --git a/vmcore_tasks/arch/riscv64/riscv64.c b/vmcore_tasks/arch/riscv64/riscv64.c
new file mode 100644
index 00000000..7123d037
--- /dev/null
+++ b/vmcore_tasks/arch/riscv64/riscv64.c
@@ -0,0 +1,327 @@
+#include <stdint.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <string.h>
+
+#include "memory.h"
+#include "vmcore_info.h"
+
+#include "vmcore_tasks_defs.h"
+
+#define RISCV_ECALL_INS            0x00000073U
+#define RISCV_ADDI_OPCODE          0x13U
+#define RISCV_RT_SIGRETURN_NR_DEF  139U
+
+/*
+ * Sv39 Page Table Walk - Main Implementation
+ * 
+ * @param pgd_paddr Physical address of PGD (page table root)
+ * @param vaddr     Virtual address to translate
+ * @param paddr     Output: physical address
+ * @return          true if translation succeeded
+ */
+bool riscv64_sv39_vtop(uint64_t pgd_paddr,
+		       uint64_t vaddr,
+		       uint64_t *paddr)
+{
+	uint64_t pgd_entry, pmd_entry, pte_entry;
+	uint64_t pgd_entry_paddr, pmd_paddr, pte_paddr;
+	uint64_t pfn;
+
+	pr_trace("riscv64_sv39_vtop: Translating vaddr 0x%llx using PGD at paddr 0x%llx\n",
+		 (unsigned long long)vaddr, (unsigned long long)pgd_paddr);
+	/*
+	 * STEP 1: Read PGD entry
+	 * 
+	 * PGD entry address = pgd_paddr + (pgd_index * 8)
+	 * Each entry is 8 bytes (64-bit)
+	 */
+	pgd_entry_paddr = pgd_paddr + (pgd_index(vaddr) * sizeof(uint64_t));
+
+	if (readmem(pgd_entry_paddr, &pgd_entry, sizeof(pgd_entry), "pgd_entry", PADDR) < 0)
+		return false;
+
+	/* Check if PGD entry is valid */
+	if (!(pgd_entry & _PAGE_PRESENT))
+		return false;
+
+	/* 
+	 * Check for 1GB gigapage (leaf PGD entry)
+	 * If R, W, or X bits are set, this is a leaf entry
+	 */
+	if (pgd_entry & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC)) {
+		/* 1GB page: PA = PPN[2] | vaddr[29:0] */
+		pfn = pte_pfn(pgd_entry);
+		*paddr = pfn_to_phys(pfn) | (vaddr & ((1UL << PGD_SHIFT) - 1));
+		return true;
+	}
+
+	/* Extract physical address of PMD table */
+	pmd_paddr = pte_to_phys(pgd_entry);
+
+	/*
+	 * STEP 2: Read PMD entry
+	 */
+	uint64_t pmd_entry_paddr = pmd_paddr + (pmd_index(vaddr) * sizeof(uint64_t));
+
+	if (readmem(pmd_entry_paddr, &pmd_entry, sizeof(pmd_entry), "pmd_entry", PADDR) < 0)
+		return false;
+
+	if (!(pmd_entry & _PAGE_PRESENT))
+		return false;
+
+	/*
+	 * Check for 2MB megapage (leaf PMD entry)
+	 */
+	if (pmd_entry & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC)) {
+		/* 2MB page: PA = PPN[2:1] | vaddr[20:0] */
+		pfn = pte_pfn(pmd_entry);
+		*paddr = pfn_to_phys(pfn) | (vaddr & ((1UL << PMD_SHIFT) - 1));
+		return true;
+	}
+
+	/* Extract physical address of PTE table */
+	pte_paddr = pte_to_phys(pmd_entry);
+
+	/*
+	 * STEP 3: Read PTE entry
+	 */
+	uint64_t pte_entry_paddr = pte_paddr + (pte_index(vaddr) * sizeof(uint64_t));
+
+	if (readmem(pte_entry_paddr, &pte_entry, sizeof(pte_entry), "pte_entry", PADDR) < 0)
+		return false;
+
+	if (!(pte_entry & _PAGE_PRESENT)) {
+		pr_trace("PTE not present for vaddr 0x%llx: pte_entry=0x%llx (V=%d R=%d W=%d X=%d)\n",
+			 (unsigned long long)vaddr,
+			 (unsigned long long)pte_entry,
+			 !!(pte_entry & _PAGE_PRESENT),
+			 !!(pte_entry & _PAGE_READ),
+			 !!(pte_entry & _PAGE_WRITE),
+			 !!(pte_entry & _PAGE_EXEC));
+		return false;
+	}
+
+	/*
+	 * STEP 4: Extract final physical address
+	 * PA = PPN << 12 | rv_page_offset(vaddr)
+	 */
+	pfn = pte_pfn(pte_entry);
+	*paddr = pfn_to_phys(pfn) | rv_page_offset(vaddr);
+
+	return true;
+}
+
+bool riscv64_sv48_vtop(uint64_t pgd_paddr,
+		       uint64_t vaddr,
+		       uint64_t *paddr)
+{
+	// Not implemented yet
+	(void)pgd_paddr; (void)vaddr; (void)paddr;
+	fprintf(stderr, "riscv64_sv48_vtop: SV48 translation not implemented\n");
+	return false;
+}
+
+bool riscv64_sv57_vtop(uint64_t pgd_paddr,
+		       uint64_t vaddr,
+		       uint64_t *paddr)
+{
+	// Not implemented yet
+	(void)pgd_paddr; (void)vaddr; (void)paddr;
+	fprintf(stderr, "riscv64_sv57_vtop: SV57 translation not implemented\n");
+	return false;
+}
+
+/* Helper - extract RISC-V fields from a 32-bit instruction word */
+static inline unsigned int rv_opcode(uint32_t insn) { return insn & 0x7f; }
+static inline unsigned int rv_rd(uint32_t insn)     { return (insn >> 7) & 0x1f; }
+static inline unsigned int rv_funct3(uint32_t insn) { return (insn >> 12) & 0x7; }
+static inline unsigned int rv_rs1(uint32_t insn)    { return (insn >> 15) & 0x1f; }
+static inline unsigned int rv_rs2(uint32_t insn)    { return (insn >> 20) & 0x1f; }
+static inline unsigned int rv_funct7(uint32_t insn) { return (insn >> 25) & 0x7f; }
+
+/* Decode I-type signed imm (12-bit) */
+static inline int32_t rv_imm_i(uint32_t insn)
+{
+	int32_t imm = (int32_t)(insn >> 20) & 0xfff;
+	/* sign extend 12-bit */
+	if (imm & 0x800)
+		imm |= ~0xfff;
+	return imm;
+}
+
+/* Decode S-type signed imm (store), imm[11:5] = bits 31:25, imm[4:0] = bits 11:7 */
+static inline int32_t rv_imm_s(uint32_t insn)
+{
+	int32_t imm = ((insn >> 25) & 0x7f) << 5;
+
+	imm |= ((insn >> 7) & 0x1f);
+	/* sign extend 12-bit */
+	if (imm & 0x800)
+		imm |= ~0xfff;
+	return imm;
+}
+
+/* helper: detect addi sp, sp, imm  -> stack adjustment */
+/* returns true and sets *stack_adj (signed) if matches */
+static inline bool is_sp_move_ins_rv64(uint32_t insn, int *stack_adj)
+{
+	/* we look for addi rd=sp(2), rs1=sp(2), opcode = OP_IMM, funct3 = 0 (addi) */
+	if (rv_opcode(insn) == OPCODE_OP_IMM && rv_rd(insn) == REG_SP &&
+		rv_rs1(insn) == REG_SP && rv_funct3(insn) == 0) {
+		/* immediate is sign-extended 12-bit */
+		int32_t imm = rv_imm_i(insn);
+		*stack_adj = imm; /* imm can be negative for "addi sp, sp, -N" */
+		return true;
+	}
+	return false;
+}
+
+/* helper: detect store of ra into stack frame: sd ra, offset(sp) or sw ra, offset(sp) */
+/* returns true and sets *ra_offset (unsigned) if matches */
+static inline bool is_ra_save_ins_rv64(uint32_t insn, unsigned long *ra_offset)
+{
+	/* store opcode (S-type). stores have opcode == OPCODE_STORE (0x23).
+	 * funct3 selects width: 0=sb,1=sh,2=sw,3=sd (on RV64)
+	 *
+	 * We accept any store where rs2 == ra (x1) and rs1 == sp (x2).
+	 * Then the offset is the signed S-type immediate. Caller will treat offset as unsigned
+	 * and compute new_frame.ra = old_sp + offset.
+	 */
+	if (rv_opcode(insn) == OPCODE_STORE && rv_rs2(insn) == REG_RA &&
+		rv_rs1(insn) == REG_SP) {
+		int32_t imm = rv_imm_s(insn);
+		/* imm might be negative for weird encodings, but typical prologue uses positive offset */
+		if (imm < 0)
+			return false;
+		*ra_offset = (unsigned long)imm;
+		return true;
+	}
+	return false;
+}
+
+/* Check if instruction is signal syscall */
+static bool riscv_is_addi_a7_x0_imm(uint32_t insn, uint32_t imm12)
+{
+	uint32_t opcode = insn & 0x7f;
+	uint32_t rd     = (insn >> 7) & 0x1f;
+	uint32_t funct3 = (insn >> 12) & 0x7;
+	uint32_t rs1    = (insn >> 15) & 0x1f;
+	uint32_t imm    = (insn >> 20) & 0xfff;
+	
+	return opcode == RISCV_ADDI_OPCODE &&
+	       rd == 17 &&          /* a7 */
+	       funct3 == 0 &&
+	       rs1 == 0 &&          /* x0 */
+	       imm == (imm12 & 0xfff);
+}
+
+static bool riscv64_likely_signal_pc(uint64_t pc)
+{
+	uint32_t nr = RISCV_RT_SIGRETURN_NR_DEF;
+	uint32_t insn[9];
+	int i, j;
+
+	if (NUMBER_EXISTS("__NR_rt_sigreturn"))
+		nr = (uint32_t)NUMBER("__NR_rt_sigreturn");
+
+	/* read window [pc-16, pc+16], 4-byte aligned */
+	for (i = -4; i <= 4; i++) {
+		uint64_t a = pc + ((int64_t)i * 4);
+		if (readmem(a, &insn[i + 4], sizeof(uint32_t),
+			    "riscv sigtramp window", UVADDR) != (ssize_t)sizeof(uint32_t))
+			return false;
+	}
+
+	/* require ecall + nearby 'li a7,__NR_rt_sigreturn' */
+	for (i = 0; i < 9; i++) {
+		if (insn[i] != RISCV_ECALL_INS)
+			continue;
+
+		for (j = i - 3; j <= i - 1; j++) {
+			if (j < 0 || j >= 9)
+				continue;
+			if (riscv_is_addi_a7_x0_imm(insn[j], nr))
+				return true;
+		}
+	}
+
+	return false;
+}
+
+/* vmcoreinfo-driven signal-frame layout for RISC-V */
+static const struct signal_unwind_layout riscv64_sig_layout = {
+	/* sp + OFFSET(rt_sigframe.uc) */
+	.rt_sigframe_uc_key    = "rt_sigframe.uc",
+	/* + OFFSET(ucontext.uc_mcontext) */
+	.ucontext_mcontext_key = "ucontext.uc_mcontext",
+	/* + OFFSET(sigcontext.sc_regs) */
+	.sigcontext_regs_key   = "sigcontext.sc_regs",
+	
+	/* no dedicated sigcontext PC key exported for RISC-V in your setup */
+	.sigcontext_pc_key     = NULL,
+	
+	.reg_width             = 8,   /* 64-bit regs */
+	.ra_reg_index          = REG_RA,
+	.sp_reg_index          = REG_SP,
+	.pc_reg_index          = REG_PC,
+	.pc_reg_alt_index      = -1,
+};
+
+void riscv64_init(void)
+{
+	arch.unwind_ops.insn_size = 4; /* 32-bit instructions */
+	arch.unwind_ops.ra_width = 8;   /* RA is 64-bit */
+	arch.unwind_ops.is_sp_move_ins = is_sp_move_ins_rv64;
+	arch.unwind_ops.is_ra_save_ins = is_ra_save_ins_rv64;
+	arch.unwind_ops.is_end_of_backtrace = NULL; /* not used */
+	arch.unwind_ops.post_unwind_fixup = NULL; /* not used */
+	arch.unwind_ops.likely_signal_pc = riscv64_likely_signal_pc;
+	arch.unwind_ops.signal_layout = &riscv64_sig_layout;
+
+	int vtop_type = NUMBER("VA_BITS");
+	switch(vtop_type) {
+		case 39:
+			arch.vtop = riscv64_sv39_vtop;
+			break;
+		case 48:
+			arch.vtop = riscv64_sv48_vtop;
+			break;
+		case 57:
+			arch.vtop = riscv64_sv57_vtop;
+			break;
+		default:
+			fprintf(stderr, "Unsupported or missing RISCV VA_BITS=%d in vmcoreinfo\n", vtop_type);
+			arch.vtop = NULL;
+			break;
+	}
+}
+
+void write_user_registers_formatted(FILE *fp, struct pt_regs *regs)
+{
+	fprintf(fp, "user registers:\n");
+	fprintf(fp, "pc :0x%016llx ra :0x%016llx sp :0x%016llx gp :0x%016llx\n",
+		(unsigned long long)regs->pc, (unsigned long long)regs->ra,
+		(unsigned long long)regs->sp, (unsigned long long)regs->gp);
+	fprintf(fp, "tp :0x%016llx t0 :0x%016llx t1 :0x%016llx t2 :0x%016llx\n",
+		(unsigned long long)regs->tp, (unsigned long long)regs->t0,
+		(unsigned long long)regs->t1, (unsigned long long)regs->t2);
+	fprintf(fp, "s0 :0x%016llx s1 :0x%016llx a0 :0x%016llx a1 :0x%016llx\n",
+		(unsigned long long)regs->s0, (unsigned long long)regs->s1,
+		(unsigned long long)regs->a0, (unsigned long long)regs->a1);
+	fprintf(fp, "a2 :0x%016llx a3 :0x%016llx a4 :0x%016llx a5 :0x%016llx\n",
+		(unsigned long long)regs->a2, (unsigned long long)regs->a3,
+		(unsigned long long)regs->a4, (unsigned long long)regs->a5);
+	fprintf(fp, "a6 :0x%016llx a7 :0x%016llx s2 :0x%016llx s3 :0x%016llx\n",
+		(unsigned long long)regs->a6, (unsigned long long)regs->a7,
+		(unsigned long long)regs->s2, (unsigned long long)regs->s3);
+	fprintf(fp, "s4 :0x%016llx s5 :0x%016llx s6 :0x%016llx s7 :0x%016llx\n",
+		(unsigned long long)regs->s4, (unsigned long long)regs->s5,
+		(unsigned long long)regs->s6, (unsigned long long)regs->s7);
+	fprintf(fp, "s8 :0x%016llx s9 :0x%016llx s10:0x%016llx s11:0x%016llx\n",
+		(unsigned long long)regs->s8, (unsigned long long)regs->s9,
+		(unsigned long long)regs->s10, (unsigned long long)regs->s11);
+	fprintf(fp, "t3 :0x%016llx t4 :0x%016llx t5 :0x%016llx t6 :0x%016llx\n",
+		(unsigned long long)regs->t3, (unsigned long long)regs->t4,
+		(unsigned long long)regs->t5, (unsigned long long)regs->t6);
+}
diff --git a/vmcore_tasks/arch/riscv64/riscv64_defs.h b/vmcore_tasks/arch/riscv64/riscv64_defs.h
new file mode 100644
index 00000000..fbeaec8d
--- /dev/null
+++ b/vmcore_tasks/arch/riscv64/riscv64_defs.h
@@ -0,0 +1,127 @@
+#ifndef RISCV64_DEFS_H
+#define RISCV64_DEFS_H
+
+#include <stdint.h>
+
+#include "vmcore_info.h"
+
+/* Page table definitions */
+/* Page size - read from vmcoreinfo at runtime via sys_cfg */
+#define SYS_PAGE_SIZE       (get_page_size())
+#define SYS_PAGE_SHIFT      (get_page_shift())
+#define SYS_PAGE_MASK       (~(SYS_PAGE_SIZE - 1)) // 0xFFFFFFFFFFFFF000
+
+/* SV39 Page table shifts for 4k pages */
+/* WARNING: These assume 4K pages. For non-4K page sizes, these must be
+ * recalculated based on get_page_shift(). */
+/* NOTE: Sv48/Sv57 require different shifts — see riscv64_sv48_vtop */
+#define PGD_SHIFT           30    // PGD covers bits [38:30]
+#define PMD_SHIFT           21    // PMD covers bits [29:21]
+#define PTE_SHIFT           12    // PTE covers bits [20:12]
+
+/* Entries per level (9 bits each = 512 entries) */
+#define PTRS_PER_PGD        512
+#define PTRS_PER_PMD        512
+#define PTRS_PER_PTE        512
+
+/* PTE format */
+#define _PAGE_PFN_SHIFT     10    // PPN starts at bit 10 in PTE
+#define PTE_PFN_MASK        0x003FFFFFFFFFFC00UL  // Bits [53:10] = PPN
+
+/* Page flags (bits [9:0]) */
+#define _PAGE_PRESENT       (1 << 0)   // V - Valid
+#define _PAGE_READ          (1 << 1)   // R - Readable
+#define _PAGE_WRITE         (1 << 2)   // W - Writable
+#define _PAGE_EXEC          (1 << 3)   // X - Executable
+#define _PAGE_USER          (1 << 4)   // U - User accessible
+#define _PAGE_GLOBAL        (1 << 5)   // G - Global mapping
+#define _PAGE_ACCESSED      (1 << 6)   // A - Accessed
+#define _PAGE_DIRTY         (1 << 7)   // D - Dirty
+
+/* Mask for PPN + protection bits (bits [53:0]) */
+#define PTE_PFN_PROT_MASK   0x003FFFFFFFFFFFFFULL
+
+
+/* Extract index for each page table level from virtual address */
+
+// PGD index: bits [38:30] - 9 bits
+#define pgd_index(vaddr)    (((vaddr) >> PGD_SHIFT) & (PTRS_PER_PGD - 1))
+
+// PMD index: bits [29:21] - 9 bits
+#define pmd_index(vaddr)    (((vaddr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
+
+// PTE index: bits [20:12] - 9 bits  
+#define pte_index(vaddr)    (((vaddr) >> PTE_SHIFT) & (PTRS_PER_PTE - 1))
+
+// Page offset: bits [11:0] - 12 bits
+#define rv_page_offset(vaddr)  ((vaddr) & (SYS_PAGE_SIZE - 1))
+
+
+/* Extract physical address of next-level page table from PTE value */
+#define pte_to_phys(pte_val)  (((pte_val) >> _PAGE_PFN_SHIFT) << SYS_PAGE_SHIFT)
+
+/* Same as above, written differently */
+#define pte_pfn(pte_val)      ((pte_val) >> _PAGE_PFN_SHIFT)
+#define pfn_to_phys(pfn)      ((pfn) << SYS_PAGE_SHIFT)
+/* unwind related definitions */
+#define GET_OFFSET_IN_PAGE(x) ((x) & (SYS_PAGE_SIZE - 1))
+#define GET_PAGE_NR(x) ((x) & SYS_PAGE_MASK)
+#define MAX_ALLOC_PAGES 3
+
+/* Opcode values (subset we need) */
+#define OPCODE_OP_IMM   0x13  /* addi, slli, ... */
+#define OPCODE_STORE    0x23  /* stores: sb, sh, sw, sd */
+#define OPCODE_OP       0x33  /* register-register ops (not used for these checks) */
+
+/* Registers */
+#define REG_PC  0
+#define REG_RA  1
+#define REG_SP  2
+
+/* RISC-V CPU register state structure */
+struct pt_regs {
+	unsigned long pc;  /* program counter */
+	unsigned long ra;
+	unsigned long sp;
+	unsigned long gp;
+	unsigned long tp;
+	unsigned long t0;
+	unsigned long t1;
+	unsigned long t2;
+	unsigned long s0;
+	unsigned long s1;
+	unsigned long a0;
+	unsigned long a1;
+	unsigned long a2;
+	unsigned long a3;
+	unsigned long a4;
+	unsigned long a5;
+	unsigned long a6;
+	unsigned long a7;
+	unsigned long s2;
+	unsigned long s3;
+	unsigned long s4;
+	unsigned long s5;
+	unsigned long s6;
+	unsigned long s7;
+	unsigned long s8;
+	unsigned long s9;
+	unsigned long s10;
+	unsigned long s11;
+	unsigned long t3;
+	unsigned long t4;
+	unsigned long t5;
+	unsigned long t6;
+	/* Supervisor/Machine CSRs */
+	unsigned long status;
+	unsigned long badaddr;
+	unsigned long cause;
+	/* a0 value before the syscall */
+	unsigned long orig_a0;
+};
+
+#define PT_REGS_PC(X)   ((X).pc)
+#define PT_REGS_RA(X)   ((X).ra)
+#define PT_REGS_SP(X)   ((X).sp)
+
+#endif /* RISCV64_DEFS_H */
\ No newline at end of file
-- 
2.43.0


