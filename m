Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD26CD98F2
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 20:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iR4ApKz6GIOKjSLuTn5Ot+WTfvYnVc1uJCvuDeOV4Yg=; b=pw9Q2SZ60/tUAR9ig1c1++F/A8
	Qz9VVCZH9iIJtz+9bebi93F/rm8qSWnLs6mS2ICSiF1c81Lwx5z2yfJoSFxMRkVFfhEAp6lPwTvLd
	UytWyp+BUqAG3eyCYpAD+axvOWKpQ0QyUybH3GH4Vfx50SwAehJdbx5lbLoMxSKGhUm2KUs0KbWwk
	MJ7fE/eVB3WU2Eb44EeUFtXjIulLmVQIm1y+OmR3GzfNjPpt3+bXFPbC/wCfEsmNdEXRerjngUzjn
	xUL+xDT/nwXmKv/RgOx7hIhltB5ieGbELkHTNJlTpyt2X1Nn0Kh+DNgx4U8qV6k/e6/LSScwWmQF1
	rD0Sb9SQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wblgm-00000005NpP-3Wgh;
	Mon, 22 Jun 2026 20:56:16 +0000
Received: from esa1.hc555-34.eu.iphmx.com ([23.90.104.144])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wblgi-00000005NiT-3AYw
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 20:56:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1782161772; x=1813697772;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dRIZvKIv1SQqeNBxK7lz3dBq4AEmf8fikxXx+bU9Vh4=;
  b=sAjba+nnRjoNxXa/bPx/0YblrxZ8am9HgeBFkBHtb3/c8AeS8/WZcR1M
   AVXFPB1QXTHLSPm++ATFNqf5CUsK0LygM6OWw9OMa43oows5inYS1Tdf9
   OqRFqHlYuFxqlxnPMNBsgVeDWMjhDgpD7KEr6meroZO0IMkRVVdK2O4Z+
   WYtIm2pMPxn0QBvBb0VBg+/h2oHDHWpt+om7TUYgfGk8K6quMyFIlpnIA
   KtYTDm/ypNeRmCqembKjEUMH1iC9Tmphdqgc69GGv/37LhXnG09S9R81f
   0zQv9fv0Wa8siuBzFkWCezHhggG7ltF9dDFyfXMxjGR8kmyHC0H6R0xPh
   Q==;
X-CSE-ConnectionGUID: 25uvBqGFQ8maQWbClrd9hw==
X-CSE-MsgGUID: M4W3R7T+TGSVvZ0UDUfNkQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 23:56:12 +0300
X-CSE-ConnectionGUID: wwar/N0eS/+Z0FekLJijTw==
X-CSE-MsgGUID: fY0Iww5iQ42g7UnhwWcblQ==
Received: from unknown (HELO epgd034.me-corp.lan) ([10.154.54.3])
  by ces04_data.me-crop.lan with SMTP; 23 Jun 2026 00:01:19 +0300
Received: by epgd034.me-corp.lan (sSMTP sendmail emulation); Mon, 22 Jun 2026 23:56:11 +0300
From: Pnina Feder <pnina.feder@mobileye.com>
To: kexec@lists.infradead.org
Cc: horms@kernel.org,
	Pnina Feder <pnina.feder@mobileye.com>
Subject: [PATCH 07/10] vmcore_tasks: Add generic user-space stack unwinder
Date: Mon, 22 Jun 2026 23:54:45 +0300
Message-ID: <20260622205550.1087163-8-pnina.feder@mobileye.com>
In-Reply-To: <20260622205550.1087163-1-pnina.feder@mobileye.com>
References: <20260622205550.1087163-1-pnina.feder@mobileye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_135613_102846_B70D2878 
X-CRM114-Status: GOOD (  22.86  )
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

Add architecture-independent user-space frame unwinder that uses
arch-provided instruction callbacks to walk the call stack.

The unwinder tries recovery in order:
  1. Signal frame: if arch reports PC looks like a signal trampoline,
     walks rt_sigframe -> ucontext -> sigcontext using vmcoreinfo
     offsets to recover saved PC, SP, and RA.
  2. Prologue scan: scans backward from PC looking for stack frame
     setup (SP adjustment) and RA save instructions. Uses a buffered
     read strategy with page-boundary handling for efficiency.

Architecture-specific behavior is provided via arch.unwind_ops:
  - is_sp_move_ins(): detect stack pointer adjustment
  - is_ra_save_ins(): detect return address save to stack
  - is_end_of_backtrace(): detect end-of-trace markers (optional)
  - post_unwind_fixup(): arch-specific post-processing (optional)
  - likely_signal_pc(): hint whether PC is in a signal trampoline
  - signal_layout: describes signal frame structure offsets

This separation allows adding new architectures by implementing
only the instruction decode callbacks, without duplicating the
unwinding logic.

Signed-off-by: Pnina Feder <pnina.feder@mobileye.com>
---
 vmcore_tasks/unwind.c | 267 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 267 insertions(+)
 create mode 100644 vmcore_tasks/unwind.c

diff --git a/vmcore_tasks/unwind.c b/vmcore_tasks/unwind.c
new file mode 100644
index 00000000..99d23322
--- /dev/null
+++ b/vmcore_tasks/unwind.c
@@ -0,0 +1,267 @@
+#include <stdio.h>
+#include <string.h>
+#include "memory.h"
+#include "vmcore_tasks_defs.h"
+
+/* Return codes for unwind_one_frame */
+#define UNWIND_OK        0
+#define UNWIND_LEAF     -1   /* No prologue found — possible leaf function */
+#define UNWIND_FAIL     -2   /* Hard failure (bad memory, etc.) */
+
+static bool sigframe_candidate_ok(uint64_t old_pc, uint64_t old_sp, uint64_t old_ra,
+				  uint64_t new_pc, uint64_t new_sp, uint64_t new_ra)
+{
+	if (!new_pc || !new_sp)
+		return false;
+	if (new_pc == old_pc && new_ra == old_ra)
+		return false;
+	/* Signal return should restore caller SP above current sigframe SP. */
+	if (new_sp <= old_sp)
+		return false;
+	/* Reject absurd jumps in SP (false positives). */
+	if ((new_sp - old_sp) > (1ULL << 20))
+		return false;
+	return true;
+}
+
+static int unwind_signal_frame(struct stackframe *frame)
+{
+	const struct signal_unwind_layout *layout = arch.unwind_ops.signal_layout;
+	uint64_t old_pc, old_sp, old_ra;
+	uint64_t uc_addr, mctx_addr, regs_addr;
+	uint64_t new_pc = 0, new_sp = 0, new_ra = 0;
+
+	if (!frame || !layout)
+		return -1;
+
+	/* Required vmcoreinfo keys to locate rt_sigframe -> ucontext -> sigcontext regs. */
+	if (!layout->rt_sigframe_uc_key ||
+	    !layout->ucontext_mcontext_key ||
+	    !layout->sigcontext_regs_key)
+		return -1;
+
+	if (!OFFSET_EXISTS(layout->rt_sigframe_uc_key) ||
+	    !OFFSET_EXISTS(layout->ucontext_mcontext_key) ||
+	    !OFFSET_EXISTS(layout->sigcontext_regs_key))
+		return -1;
+
+	/* Walk the layout chain from current SP to saved register block. */
+	uc_addr   = frame->sp + OFFSET(layout->rt_sigframe_uc_key);
+	mctx_addr = uc_addr   + OFFSET(layout->ucontext_mcontext_key);
+	regs_addr = mctx_addr + OFFSET(layout->sigcontext_regs_key);
+
+	/* Always recover RA and SP from arch provided indices */
+	if (readmem(regs_addr + ((uint64_t)layout->ra_reg_index * layout->reg_width),
+	    &new_ra, layout->reg_width, "sigcontext ra", UVADDR) < 0)
+		return -1;
+	if (readmem(regs_addr + ((uint64_t)layout->sp_reg_index * layout->reg_width),
+	    &new_sp, layout->reg_width, "sigcontext sp", UVADDR) < 0)
+		return -1;
+
+	old_pc = frame->pc;
+	old_sp = frame->sp;
+	old_ra = frame->ra;
+
+	/* PC can be either a dedicated field or a slot in the regs array. */
+	if (layout->sigcontext_pc_key && OFFSET_EXISTS(layout->sigcontext_pc_key)) {
+		uint64_t pc_addr = mctx_addr + OFFSET(layout->sigcontext_pc_key);
+		if (readmem(pc_addr, &new_pc, layout->reg_width,
+		    "sigcontext pc", UVADDR) < 0)
+			return -1;
+	} else {
+		if (readmem(regs_addr + ((uint64_t)layout->pc_reg_index * layout->reg_width),
+				 &new_pc, layout->reg_width, "sigcontext pc", UVADDR) < 0)
+			return -1;
+		/* Try alternate PC slot for kernels/ABIs with different ordering. */
+		if (!sigframe_candidate_ok(old_pc, old_sp, old_ra, new_pc, new_sp, new_ra) &&
+		    layout->pc_reg_alt_index >= 0) {
+			if (readmem(regs_addr + ((uint64_t)layout->pc_reg_alt_index * layout->reg_width),
+					 &new_pc, layout->reg_width, "sigcontext pc(alt)", UVADDR) < 0)
+				return -1;
+		}
+	}
+
+	/* Final sanity gate before committing recovered frame. */
+	if (!sigframe_candidate_ok(old_pc, old_sp, old_ra, new_pc, new_sp, new_ra))
+		return -1;
+
+	pr_verbose("sigframe-candidate: old[pc=0x%016llx sp=0x%016llx ra=0x%016llx] new[pc=0x%016llx sp=0x%016llx ra=0x%016llx] chain[uc=0x%016llx mctx=0x%016llx regs=0x%016llx] src=%s idx[sp=%d ra=%d pc=%d alt=%d] w=%u\n",
+		   (unsigned long long)old_pc, (unsigned long long)old_sp, (unsigned long long)old_ra,
+		   (unsigned long long)new_pc, (unsigned long long)new_sp, (unsigned long long)new_ra,
+		   (unsigned long long)uc_addr, (unsigned long long)mctx_addr, (unsigned long long)regs_addr,
+		   (layout->sigcontext_pc_key && OFFSET_EXISTS(layout->sigcontext_pc_key)) ? "sigcontext_pc_key" : "regs[]",
+		   layout->sp_reg_index, layout->ra_reg_index, layout->pc_reg_index, layout->pc_reg_alt_index,
+		   layout->reg_width);
+
+	frame->pc = (unsigned long)new_pc;
+	frame->sp = (unsigned long)new_sp;
+	frame->ra = (unsigned long)new_ra;
+	return 0;
+}
+
+/*
+ * Try to recover the previous frame by scanning backward for prologue
+ * instructions (SP adjustment + RA save).
+ *
+ * Returns: UNWIND_OK on success, UNWIND_LEAF if no prologue found,
+ *          UNWIND_FAIL on hard error.
+ */
+static int unwind_prologue_scan(struct stackframe *frame, unsigned int max_check)
+{
+	off_t ra_offset = 0;
+	size_t stack_size = 0;
+	unsigned long scan_addr, scan_end;
+	uint32_t insn;
+	int sp_adjust = 0;
+	unsigned long ra_slot = 0;
+
+	uint8_t code_buf[CODE_BUF_SIZE];
+	unsigned long buf_base = 0;
+	ssize_t buf_len = 0;
+
+	scan_addr = frame->pc - arch.unwind_ops.insn_size;
+
+	if (max_check >= frame->pc)
+		scan_end = 0;
+	else
+		scan_end = frame->pc - max_check;
+
+	while (scan_addr >= scan_end) {
+		/* Refill code buffer when needed */
+		if (buf_len == 0 || scan_addr < buf_base) {
+			if (scan_addr + arch.unwind_ops.insn_size < CODE_BUF_SIZE)
+				buf_base = 0;
+			else
+				buf_base = scan_addr + arch.unwind_ops.insn_size - CODE_BUF_SIZE;
+
+			if (buf_base < scan_end)
+				buf_base = scan_end & ~((unsigned long)arch.unwind_ops.insn_size - 1);
+
+			size_t to_read = scan_addr + arch.unwind_ops.insn_size - buf_base;
+			buf_len = readmem(buf_base, code_buf, to_read,
+					  "read code chunk", UVADDR);
+			if (buf_len <= 0) {
+				unsigned long next_page = (buf_base & SYS_PAGE_MASK) + SYS_PAGE_SIZE;
+				pr_trace("Failed to read at 0x%lx, advancing scan_end to 0x%lx\n",
+					 buf_base, next_page);
+				scan_end = next_page;
+				buf_len = 0;
+				continue;
+			}
+		}
+
+		size_t offset = scan_addr - buf_base;
+		if (offset + arch.unwind_ops.insn_size > (size_t)buf_len) {
+			pr_verbose("Offset out of buffer range\n");
+			return UNWIND_FAIL;
+		}
+		memcpy(&insn, code_buf + offset, arch.unwind_ops.insn_size);
+
+		if (arch.unwind_ops.is_sp_move_ins(insn, &sp_adjust)) {
+			if (sp_adjust < 0) {
+				stack_size = (size_t)(-sp_adjust);
+				pr_trace("sp_move: pc=0x%lx insn=0x%08x adjust=%d\n",
+					 scan_addr, insn, sp_adjust);
+				break;
+			}
+		} else if (arch.unwind_ops.is_ra_save_ins(insn, &ra_slot)) {
+			pr_trace("ra_save: pc=0x%lx insn=0x%08x slot=%lu\n",
+				 scan_addr, insn, ra_slot);
+			ra_offset = (off_t)ra_slot;
+		}
+
+		if (scan_addr < arch.unwind_ops.insn_size)
+			break;
+		scan_addr -= arch.unwind_ops.insn_size;
+	}
+
+	if (!stack_size)
+		return UNWIND_LEAF;
+
+	if (ra_offset) {
+		unsigned long ra_addr = frame->sp + ra_offset;
+		unsigned long new_ra;
+		if (readmem(ra_addr, &new_ra, arch.unwind_ops.ra_width,
+			    "read RA from stack", UVADDR) != (ssize_t)arch.unwind_ops.ra_width) {
+			pr_trace("RA slot unreadable at 0x%lx; treating as end of backtrace\n",
+				 ra_addr);
+			return UNWIND_FAIL;
+		}
+		frame->ra = new_ra;
+		frame->pc = new_ra;
+	} else if (frame->ra != 0) {
+		/* No RA slot found — use existing RA as fallback (e.g. from registers) */
+		frame->pc = frame->ra;
+	} else {
+		fprintf(stderr, "No RA found and frame->ra is 0\n");
+		return UNWIND_FAIL;
+	}
+
+	frame->sp += stack_size;
+
+	pr_trace("unwound: pc=0x%lx ra=0x%lx sp=0x%lx\n",
+		 frame->pc, frame->ra, frame->sp);
+	return UNWIND_OK;
+}
+
+/*
+ * Try signal-frame recovery if the arch hints that PC looks like a
+ * signal trampoline.
+ */
+static int try_signal_frame_unwind(struct stackframe *frame)
+{
+	if (!arch.unwind_ops.signal_layout)
+		return -1;
+
+	bool likely = true;
+	if (arch.unwind_ops.likely_signal_pc)
+		likely = arch.unwind_ops.likely_signal_pc(frame->pc);
+
+	if (!likely)
+		return -1;
+
+	struct stackframe candidate = *frame;
+	if (unwind_signal_frame(&candidate) != 0)
+		return -1;
+
+	pr_verbose("signal-frame: pc 0x%lx->0x%lx sp 0x%lx->0x%lx ra 0x%lx->0x%lx\n",
+		 frame->pc, candidate.pc, frame->sp, candidate.sp,
+		 frame->ra, candidate.ra);
+	*frame = candidate;
+	return 0;
+}
+
+/*
+ * Public entry point: unwind one user-space frame.
+ *
+ * Tries, in order:
+ *   1. Signal-frame recovery
+ *   2. Prologue-scan unwinding
+ *
+ * Returns UNWIND_OK, UNWIND_LEAF, or UNWIND_FAIL.
+ */
+int unwind_user_frame(struct stackframe *frame, unsigned int max_check)
+{
+	int ret;
+
+	if (!frame->pc || !frame->sp) {
+		fprintf(stderr, "error: pc or sp is zero: pc=0x%lx sp=0x%lx\n",
+			frame->pc, frame->sp);
+		return UNWIND_FAIL;
+	}
+
+	if (try_signal_frame_unwind(frame) == 0)
+		return UNWIND_OK;
+
+	ret = unwind_prologue_scan(frame, max_check);
+	if (ret != UNWIND_OK)
+		return ret;
+
+	/* Optional arch-specific fixup after unwinding. */
+	if (arch.unwind_ops.post_unwind_fixup) {
+		if (arch.unwind_ops.post_unwind_fixup(frame, max_check) != 0)
+			return UNWIND_FAIL;
+	}
+
+	return UNWIND_OK;
+}
\ No newline at end of file
-- 
2.43.0


