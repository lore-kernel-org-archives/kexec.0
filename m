Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F847606A331
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 08:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=xu5tGLv9;
	dkim=permerror header.d=soleen.com header.i=@soleen.com header.a=rsa-sha1 header.s=google header.b=aNGUaDYW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/xTOOxWAB7EXdp+9zJNQXlE7w6mryIyyfkbDpuO17P4=; b=xu5tGLv9pQG5YSaW3v2d3+6nDY
	lWvG06DWHCoudr8FJDoYEyIZUq8bwFchbtMwqzV3eIQMeyjGJ6N4U7VbvEim18cST8w1B/zckLkiJ
	ve/7lo7EGfvkutzVdUfnj21XzsSypmHhRzFCHQE4GksXn3LUrKk8ZsUsVXcPORnXXobxaaLzmUu87
	YaqWnD2Ru00StYmjY6nmvFsVH1pgZBCZABnUA0Tst3ImWtBMMy/RdoxHDnrWYRYZLLFnOzjQQ5pgo
	Ii6GqIC2vTm4Nac/fxZWmhKyQ21t/rXzlNX2C0aPojvuOmVspCti7XHjnsZZjxMaiPjVSdksI32R6
	Fl0bSXVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ55u-000000098tX-1APD;
	Tue, 20 Oct 2026 08:21:14 +0000
Received: from mail-qk2-x11.google.com ([2607:f8b0:4864:34::11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8lY0-00000003Spk-1Hnw
	for kexec@lists.infradead.org;
	Mon, 21 Sep 2026 21:27:39 +0000
Received: by mail-qk2-x11.google.com with SMTP id af79cd13be357-939109fafddso225825285a.0
        for <kexec@lists.infradead.org>; Mon, 21 Sep 2026 14:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1790026055; x=1790630855; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/xTOOxWAB7EXdp+9zJNQXlE7w6mryIyyfkbDpuO17P4=;
        b=aNGUaDYWzv522MPR7noAU7cfOEpeDWGL4ECxNBjjTT22qWZ0AAbIy4cjhdD5FJq7kO
         aMuLIfaLwwIGHk/sk3rQ573ZG3RbIiIfVlRZpL63kLmuRc0p9ohF8f/d3IwMTpnsxMlZ
         /uYozG4j3S1f70VLKFd0iEeimeXlaGo9ky13u3xR5Frr4ZwsAB5dhq85jBA8t7QTUJH5
         iB7pwk/V2iCOQABA8iyQ7zEk1hTOOj/aXAuSAfiPPQbu0d66ahbsu7nd33eKzHqtF32C
         DRvTLzTgI6ehp3U6MAdc2bwYgq0RTzR186lxQ2v6OQcVcz0zvQ+Yp91US1PGC3EfyhGI
         hKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790026055; x=1790630855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/xTOOxWAB7EXdp+9zJNQXlE7w6mryIyyfkbDpuO17P4=;
        b=bDrEAWMw1g5hMzPemORRb5zoPLrsjvZiXHuMdAz5Kz7CbG8b9BVI89ndOhwtkLMi1s
         zIMu/X1Xe6P6Ee6+vBcic+SAGf6Tg2UevIJMMOCbtZ4CimFposXrt0Zyo/6+80fzGIrg
         iySzJsqyCYocWRlhBG/mrbQdz2uK+MjRO+ZDxKhNbhwFW9EYtzKnIiJe/++guC6zVyRp
         AU0x1KzcuL1t3+WPSBT+HZVTDqSRbL5kxdHqjsWH5S8gtCY+g2TAefKg12fKeUZr+X/x
         NutoW3aQxIdBW5PiXeiVAuUT20UvtZr+aqsDTapGA8IqkNzJAYPjHx1KbsCqTGGvg2Kh
         EYEQ==
X-Forwarded-Encrypted: i=1; AKwUvByqq8xqa0tsve57GnyK7IgelXEP+sq/dfaXhdmP9uAlRPP2iukLyUNLW0UGkEVI9JLsNwlPLQ==@lists.infradead.org
X-Gm-Message-State: AFuF++mDKUijAgZWjDFaRH46MjQSCfUtJscbVzUyMsB/4BMktgCinFmV
	w/DO3NUxbt/hX/Dqo5aMvvascRvOYnSak//4UMMyD7MtH0EJjt8zuQ08YZ4hLUtP7xUEMoMss6F
	YA1Um
X-Gm-Gg: AYBFou1FoxRrZcdBinLPEIm06AAzbZX/Aihwl6jSVxiWkO2nSCEr5tGluAklZtUXtJc
	xMsV+92pLKW/CnZwp5ncZn9fyTG1kFY++NtiV09p/mN1tsYc7kRXerylL/jJIyT4VT1f0WLyVKY
	cNiDuomozStKZfpwHc5Au/wrXKbZJQlRnMIXfDOzaYshbstxrxQprvZ9+DWjIs1x70MyuzwLvUL
	mS244xLWbPKeN4EeYyCgfYgZYoK0R3rsPhC8bMjLOAN5iEakZE7JYp3ph+tnfcpqL+DVr+OH0X+
	urMEXCzKyBrCj4yvpoJoz3jGb0tOOlSoGGCSzSWTReizfJGalhfiwJWzBNpVDvfMIYtH7agdLjq
	dbSuUMNfCp2cANU6fu4fnFX87ccOCEeGNxyX+/esqKCzKs6soz+4rvQUCdNyDJk52+y2EL4or6N
	PBUZ9UEKtZstwWoLpBInin0WVVvUOahCuJ2scdEHofU7qYYVPZksxKwJoWq7RDZ+CjpcR2kGYvr
	OSSwqlrGYHtL3M8RDJW6EffiyiO85HEXcm+Epn2V/lSGWrKxHWCGkLtWypE4mBYP6jsWLYWBL39
	fY1JcZ2SuEKDtYKgDd8=
X-Received: by 2002:a05:690c:7482:b0:884:c7c1:31c4 with SMTP id 00721157ae682-8972b0f46e0mr40971027b3.0.1790024454228;
        Mon, 21 Sep 2026 14:00:54 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a23c738bdfsm1445297b3.11.2026.09.21.14.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 14:00:52 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	legion@kernel.org,
	kees@kernel.org,
	will@kernel.org,
	ruanjinjie@huawei.com,
	atomlin@atomlin.com,
	rppt@kernel.org,
	jani.nikula@intel.com,
	hamzamahfooz@linux.microsoft.com,
	joey.gouly@arm.com,
	tglx@kernel.org,
	nsc@kernel.org,
	alexandre.chartre@oracle.com,
	james.morse@arm.com,
	dianders@chromium.org,
	bp@alien8.de,
	jpoimboe@kernel.org,
	shuah@kernel.org,
	catalin.marinas@arm.com,
	linux-kbuild@vger.kernel.org,
	linux-arch@vger.kernel.org,
	kvmarm@lists.linux.dev,
	jaredwhite@microsoft.com,
	johan@kernel.org,
	pbonzini@redhat.com,
	mingo@redhat.com,
	linux-mm@kvack.org,
	seanjc@google.com,
	mark.rutland@arm.com,
	vdonnefort@google.com,
	tarunsahu@google.com,
	gshan@redhat.com,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	xur@google.com,
	djbw@kernel.org,
	oupton@kernel.org,
	nogikh@google.com,
	sumitg@nvidia.com,
	linux-kernel@vger.kernel.org,
	zengheng4@huawei.com,
	peterz@infradead.org,
	corbet@lwn.net,
	suzuki.poulose@arm.com,
	luto@kernel.org,
	hpa@zytor.com,
	zhangpengjie2@huawei.com,
	x86@kernel.org,
	yuzenghui@huawei.com,
	jic23@kernel.org,
	ardb@kernel.org,
	pasha.tatashin@soleen.com,
	petr.pavlu@suse.com,
	ryan.roberts@arm.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	dave.hansen@linux.intel.com,
	rdunlap@infradead.org,
	kvm@vger.kernel.org,
	fuad.tabba@linux.dev,
	maz@kernel.org,
	mbenes@suse.cz,
	jgross@suse.com,
	seiden@linux.ibm.com,
	pierre.gondois@arm.com,
	song@kernel.org,
	nathan@kernel.org,
	pmladek@suse.com,
	graf@amazon.com,
	chao.gao@intel.com,
	zhenglifeng1@huawei.com,
	arnd@arndb.de,
	sidnayyar@google.com,
	linux-arm-kernel@lists.infradead.org,
	vladimir.murzin@arm.com,
	kas@kernel.org
Subject: [RFC PATCH 45/46] KVM: arm64: Implement Caretaker system register trap and exception handlers
Date: Mon, 21 Sep 2026 17:00:33 -0400
Message-ID: <20260921210034.180424-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260921210034.180424-1-pasha.tatashin@soleen.com>
References: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
 <20260921210034.180424-1-pasha.tatashin@soleen.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_142736_409168_6D1E36D0 
X-CRM114-Status: GOOD (  19.77  )
X-Spam-Score: 1.2 (+)
X-Mailman-Approved-At: Tue, 20 Oct 2026 01:21:10 -0700
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement standalone Caretaker EL2 exception decoding, system register
trap handling, and stage-2 non-RAM IPA yield in arch/arm64/kvm/caretaker.c.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kvm/caretaker.c | 408 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 405 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/caretaker.c b/arch/arm64/kvm/caretaker.c
index 65c11fe8c2fa..6980c1f6b998 100644
--- a/arch/arm64/kvm/caretaker.c
+++ b/arch/arm64/kvm/caretaker.c
@@ -60,10 +60,8 @@ arm64_caretaker_handle_invalid(u64 elr, u64 esr, u64 far)
 	}
 
 	while (1) {
-		if (cpu_preserved_should_exit(cpu)) {
-			cpu_preserved_set_dead(cpu);
+		if (cpu_preserved_should_exit(cpu))
 			arch_cpu_preserved_park_finish(cpu);
-		}
 		arch_cpu_preserved_park_wait();
 	}
 }
@@ -519,3 +517,407 @@ __caretaker_text static void caretaker_vgic_v3_save(struct vgic_v3_cpu_if *cpu_i
 	isb();
 }
 
+__caretaker_text static void
+caretaker_arm64_inject_sgi(struct caretaker_arm64_page *target_cap, u32 sgi)
+{
+	int slot = -1;
+	int i;
+
+	if (!target_cap)
+		return;
+
+	cpu_preserved_inval(target_cap);
+
+	/* Check if the SGI is already pending or active */
+	for (i = 0; i < target_cap->ctx.vgic_v3.used_lrs; i++) {
+		u64 lr = target_cap->ctx.vgic_v3.vgic_lr[i];
+
+		if ((lr & ICH_LR_VIRTUAL_ID_MASK) == (sgi & 0xf) && (lr & ICH_LR_STATE))
+			return;
+		if ((lr & ICH_LR_STATE) == 0 && slot < 0)
+			slot = i;
+	}
+
+	if (slot < 0 && target_cap->ctx.vgic_v3.used_lrs < VGIC_V3_MAX_LRS) {
+		slot = target_cap->ctx.vgic_v3.used_lrs;
+		target_cap->ctx.vgic_v3.used_lrs++;
+	}
+
+	if (slot >= 0) {
+		target_cap->ctx.vgic_v3.vgic_lr[slot] =
+			((u64)sgi & 0xf) |
+			ICH_LR_PENDING_BIT |
+			ICH_LR_GROUP |
+			(GIC_DEFAULT_SGI_PRIO << ICH_LR_PRIORITY_SHIFT);
+	} else {
+		target_cap->ctx.pending_sgis |= BIT(sgi & 0xf);
+	}
+
+	cpu_preserved_clean(target_cap);
+
+	/* If target vCPU is running on a remote physical CPU, kick it */
+	if (target_cap->abi.cb.pcpu_id >= 0 &&
+	    target_cap->abi.cb.pcpu_id != arm64_caretaker_get_pcpu()) {
+		arch_cpu_preserved_kick(target_cap->abi.cb.pcpu_id);
+	}
+}
+
+__caretaker_text static void
+caretaker_arm64_handle_sgi(struct caretaker_arm64_page *src_cap, u64 reg)
+{
+	struct caretaker_arm64_page *target;
+	u32 sgi = FIELD_GET(ICC_SGI1R_SGI_ID_MASK, reg);
+	unsigned int i;
+
+	if (!src_cap || !src_cap->next_vcpu)
+		return;
+
+	if (reg & BIT_ULL(ICC_SGI1R_IRQ_ROUTING_MODE_BIT)) {
+		/* Broadcast to all other vCPUs */
+		for (target = src_cap->next_vcpu;
+		     target && target != src_cap;
+		     target = target->next_vcpu) {
+			cpu_preserved_inval(target);
+			caretaker_arm64_inject_sgi(target, sgi);
+		}
+	} else {
+		u64 aff3 = FIELD_GET(ICC_SGI1R_AFFINITY_3_MASK, reg);
+		u64 aff2 = FIELD_GET(ICC_SGI1R_AFFINITY_2_MASK, reg);
+		u64 aff1 = FIELD_GET(ICC_SGI1R_AFFINITY_1_MASK, reg);
+		u64 rs = FIELD_GET(ICC_SGI1R_RS_MASK, reg);
+		u64 cluster_mpidr = (aff3 << MPIDR_LEVEL_SHIFT(3)) |
+				    (aff2 << MPIDR_LEVEL_SHIFT(2)) |
+				    (aff1 << MPIDR_LEVEL_SHIFT(1));
+		u64 target_list = FIELD_GET(ICC_SGI1R_TARGET_LIST_MASK, reg);
+
+		for (i = 0; i < 16; i++) {
+			u64 target_mpidr;
+
+			if (!(target_list & BIT(i)))
+				continue;
+
+			target_mpidr = cluster_mpidr |
+				       ((rs * 16 + i) << MPIDR_LEVEL_SHIFT(0));
+
+			target = src_cap;
+			do {
+				cpu_preserved_inval(target);
+				if ((ctxt_sys_reg(&target->ctx.ctxt, MPIDR_EL1) &
+				     MPIDR_HWID_BITMASK) == target_mpidr) {
+					caretaker_arm64_inject_sgi(target, sgi);
+					break;
+				}
+				target = target->next_vcpu;
+			} while (target && target != src_cap);
+		}
+	}
+}
+
+static __caretaker_text int arm64_caretaker_op_enter(void *data)
+{
+	struct caretaker_arm64_page *cap = data;
+	u64 guest_hcr;
+
+	gicv3_caretaker_clear_active_priorities();
+	write_sysreg_s(ICC_PMR_EL1_MASK, SYS_ICC_PMR_EL1);
+	write_sysreg_s(ICC_CTLR_EL1_EOImode_drop, SYS_ICC_CTLR_EL1);
+	write_sysreg_s(ICC_IGRPEN1_EL1_MASK, SYS_ICC_IGRPEN1_EL1);
+	pmr_sync();
+
+	guest_hcr = (cap->ctx.hcr_el2 | HCR_AMO | HCR_IMO | HCR_FMO | HCR_E2H) & ~HCR_TGE;
+	write_sysreg_hcr(guest_hcr);
+	isb();
+
+	cap->last_ret = caretaker_guest_enter(&cap->ctx);
+
+	write_sysreg_hcr(HCR_HOST_VHE_FLAGS);
+	isb();
+
+	return 0;
+}
+
+static __caretaker_text void
+arm64_caretaker_op_arm_timer(void *data, u64 deadline_ticks)
+{
+	if (deadline_ticks) {
+		write_sysreg_s(deadline_ticks, SYS_CNTHP_CVAL_EL2);
+		isb();
+		write_sysreg_s(1, SYS_CNTHP_CTL_EL2);
+	} else {
+		write_sysreg_s(0, SYS_CNTHP_CTL_EL2);
+	}
+	isb();
+}
+
+static __caretaker_text void
+arm64_caretaker_op_disarm_timer(void *data)
+{
+	write_sysreg_s(0, SYS_CNTHP_CTL_EL2);
+	isb();
+}
+
+static __caretaker_text void
+arm64_caretaker_op_decode_exit(void *data, struct kvm_caretaker_exit *exit)
+{
+	struct caretaker_arm64_page *cap = data;
+	u64 ret = cap->last_ret;
+
+	exit->rip = cap->ctx.ctxt.regs.pc;
+	exit->insn_len = 0;
+	exit->type = KVM_CARETAKER_EXIT_UNKNOWN;
+
+	if (ARM_EXCEPTION_CODE(ret) == ARM_EXCEPTION_IRQ) {
+		caretaker_gic_drain_iar();
+		gicv3_caretaker_clear_active_priorities();
+		dsb(sy);
+		isb();
+
+		exit->type = KVM_CARETAKER_EXIT_PREEMPT_TIMER;
+		return;
+	}
+
+	if (ARM_EXCEPTION_IS_TRAP(ret)) {
+		u64 esr = cap->ctx.fault.esr_el2;
+		u8 ec = ESR_ELx_EC(esr);
+
+		exit->insn_len = 4;
+
+		if (ec == ESR_ELx_EC_WFx) {
+			exit->type = KVM_CARETAKER_EXIT_IDLE;
+			return;
+		}
+
+		if (ec == ESR_ELx_EC_SYS64) {
+			u32 iss = ESR_ELx_ISS(esr);
+			u32 sys_op = iss & ESR_ELx_SYS64_ISS_SYS_OP_MASK;
+
+			if (sys_op == ESR_ELx_SYS64_ISS_SYS_ICC_SGI1R_EL1 ||
+			    sys_op == ESR_ELx_SYS64_ISS_SYS_ICC_ASGI1R_EL1 ||
+			    sys_op == ESR_ELx_SYS64_ISS_SYS_ICC_SGI0R_EL1) {
+				u32 rt = ESR_ELx_SYS64_ISS_RT(esr);
+				u64 val = (rt < 31) ? cap->ctx.ctxt.regs.regs[rt] : 0;
+
+				exit->type = KVM_CARETAKER_EXIT_CROSS_VCPU;
+				exit->sgi.sgi_id = FIELD_GET(ICC_SGI1R_SGI_ID_MASK, val);
+				exit->sgi.target_mask = val;
+				return;
+			}
+		}
+
+		if (ec == ESR_ELx_EC_DABT_LOW || ec == ESR_ELx_EC_IABT_LOW) {
+			/*
+			 * Stage-2 abort on a non-RAM IPA (e.g. MMIO device).
+			 * Do not advance PC: yield this vCPU out of guest mode
+			 * so the incoming kernel's real KVM + VMM handles the
+			 * fault on re-attachment.
+			 */
+			exit->type = KVM_CARETAKER_EXIT_IDLE;
+			exit->insn_len = 0;
+			return;
+		}
+
+		exit->type = KVM_CARETAKER_EXIT_ARCH;
+		exit->raw_reason = esr;
+		return;
+	}
+
+	exit->type = KVM_CARETAKER_EXIT_ARCH;
+}
+
+static __caretaker_text void
+arm64_caretaker_op_advance_rip(void *data, u64 next_rip)
+{
+	struct caretaker_arm64_page *cap = data;
+
+	cap->ctx.ctxt.regs.pc = next_rip;
+}
+
+static __caretaker_text bool
+arm64_caretaker_op_handle_exit(void *data, struct kvm_caretaker_exit *exit)
+{
+	struct caretaker_arm64_page *cap = data;
+
+	if (exit->type == KVM_CARETAKER_EXIT_CROSS_VCPU) {
+		caretaker_arm64_handle_sgi(cap, exit->sgi.target_mask);
+		exit->rip += exit->insn_len;
+		return true;
+	}
+
+	/*
+	 * KVM_CARETAKER_EXIT_ARCH is the fallback type assigned by
+	 * arm64_caretaker_op_decode_exit() to every trap it did not decode,
+	 * including system register accesses.  Skipping the instruction here
+	 * would leave the destination register holding whatever it held
+	 * before the trap and bypass KVM's ID register sanitisation, with the
+	 * guest none the wiser.
+	 *
+	 * Leave PC pointing at the trapping instruction and report the exit
+	 * as unhandled so the vCPU parks until the incoming kernel reclaims
+	 * it and full KVM handles the trap.
+	 */
+	return false;
+}
+
+static __caretaker_text inline u64 arm64_sysreg_to_uapi_id(u32 reg)
+{
+	if (reg == SYS_CNTV_CVAL_EL0)
+		return KVM_REG_ARM_TIMER_CVAL;
+	return (KVM_REG_ARM64 | KVM_REG_SIZE_U64 |
+		KVM_REG_ARM64_SYSREG |
+		((u64)sys_reg_Op0(reg) << KVM_REG_ARM64_SYSREG_OP0_SHIFT) |
+		((u64)sys_reg_Op1(reg) << KVM_REG_ARM64_SYSREG_OP1_SHIFT) |
+		((u64)sys_reg_CRn(reg) << KVM_REG_ARM64_SYSREG_CRN_SHIFT) |
+		((u64)sys_reg_CRm(reg) << KVM_REG_ARM64_SYSREG_CRM_SHIFT) |
+		((u64)sys_reg_Op2(reg) << KVM_REG_ARM64_SYSREG_OP2_SHIFT));
+}
+
+static __caretaker_text void
+arm64_caretaker_update_sysreg(struct kvm_vcpu_arch_ser *state,
+			      u32 reg, u64 val)
+{
+	u64 id = arm64_sysreg_to_uapi_id(reg);
+	u32 i;
+
+	for (i = 0; i < state->num_sysregs; i++) {
+		if (state->sysregs[i].id == id) {
+			state->sysregs[i].addr = val;
+			return;
+		}
+	}
+}
+
+static __caretaker_text void
+arm64_caretaker_detach_serialize(struct caretaker_arm64_page *cap)
+{
+	cap->abi.vgic_initialized = cap->ctx.vgic_initialized ? 1 : 0;
+	cap->abi.cntvoff_el2 = cap->ctx.cntvoff_el2;
+	cap->abi.hcr_el2 = cap->ctx.hcr_el2;
+	cap->abi.mdcr_el2 = cap->ctx.mdcr_el2;
+	cap->abi.cflags = (u32)cap->ctx.cflags;
+	if (cap->ctx.vgic_initialized) {
+		int i;
+
+		cap->abi.used_lrs = cap->ctx.vgic_v3.used_lrs;
+		cap->abi.vgic_hcr = cap->ctx.vgic_v3.vgic_hcr;
+		cap->abi.vgic_vmcr = cap->ctx.vgic_v3.vgic_vmcr;
+		for (i = 0; i < 4; i++) {
+			cap->abi.vgic_ap0r[i] = cap->ctx.vgic_v3.vgic_ap0r[i];
+			cap->abi.vgic_ap1r[i] = cap->ctx.vgic_v3.vgic_ap1r[i];
+		}
+		for (i = 0; i < 16; i++)
+			cap->abi.vgic_lr[i] = cap->ctx.vgic_v3.vgic_lr[i];
+	}
+
+	if (cap->arch_state) {
+		struct kvm_vcpu_arch_ser *state = cap->arch_state;
+
+		cpu_preserved_memcpy(&state->regs.regs, &cap->ctx.ctxt.regs,
+				     sizeof(state->regs.regs));
+		state->regs.sp_el1 = ctxt_sys_reg(&cap->ctx.ctxt, SP_EL1);
+		state->regs.elr_el1 = ctxt_sys_reg(&cap->ctx.ctxt, ELR_EL1);
+		state->regs.spsr[KVM_SPSR_EL1] = ctxt_sys_reg(&cap->ctx.ctxt, SPSR_EL1);
+		state->regs.spsr[KVM_SPSR_ABT] = cap->ctx.ctxt.spsr_abt;
+		state->regs.spsr[KVM_SPSR_UND] = cap->ctx.ctxt.spsr_und;
+		state->regs.spsr[KVM_SPSR_IRQ] = cap->ctx.ctxt.spsr_irq;
+		state->regs.spsr[KVM_SPSR_FIQ] = cap->ctx.ctxt.spsr_fiq;
+		cpu_preserved_memcpy(&state->regs.fp_regs, &cap->ctx.ctxt.fp_regs,
+				     sizeof(state->regs.fp_regs));
+
+		arm64_caretaker_update_sysreg(state, SYS_SCTLR_EL1,
+					      ctxt_sys_reg(&cap->ctx.ctxt, SCTLR_EL1));
+		arm64_caretaker_update_sysreg(state, SYS_CPACR_EL1,
+					      ctxt_sys_reg(&cap->ctx.ctxt, CPACR_EL1));
+		arm64_caretaker_update_sysreg(state, SYS_TTBR0_EL1,
+					      ctxt_sys_reg(&cap->ctx.ctxt, TTBR0_EL1));
+		arm64_caretaker_update_sysreg(state, SYS_TTBR1_EL1,
+					      ctxt_sys_reg(&cap->ctx.ctxt, TTBR1_EL1));
+		arm64_caretaker_update_sysreg(state, SYS_TCR_EL1,
+					      ctxt_sys_reg(&cap->ctx.ctxt, TCR_EL1));
+		arm64_caretaker_update_sysreg(state, SYS_ESR_EL1,
+					      ctxt_sys_reg(&cap->ctx.ctxt, ESR_EL1));
+		arm64_caretaker_update_sysreg(state, SYS_AFSR0_EL1,
+					      ctxt_sys_reg(&cap->ctx.ctxt, AFSR0_EL1));
+		arm64_caretaker_update_sysreg(state, SYS_AFSR1_EL1,
+					      ctxt_sys_reg(&cap->ctx.ctxt, AFSR1_EL1));
+		arm64_caretaker_update_sysreg(state, SYS_FAR_EL1,
+					      ctxt_sys_reg(&cap->ctx.ctxt, FAR_EL1));
+		arm64_caretaker_update_sysreg(state, SYS_MAIR_EL1,
+					      ctxt_sys_reg(&cap->ctx.ctxt, MAIR_EL1));
+		arm64_caretaker_update_sysreg(state, SYS_VBAR_EL1,
+					      ctxt_sys_reg(&cap->ctx.ctxt, VBAR_EL1));
+		arm64_caretaker_update_sysreg(state, SYS_CONTEXTIDR_EL1,
+					      ctxt_sys_reg(&cap->ctx.ctxt, CONTEXTIDR_EL1));
+		arm64_caretaker_update_sysreg(state, SYS_AMAIR_EL1,
+					      ctxt_sys_reg(&cap->ctx.ctxt, AMAIR_EL1));
+		arm64_caretaker_update_sysreg(state, SYS_CNTKCTL_EL1,
+					      ctxt_sys_reg(&cap->ctx.ctxt, CNTKCTL_EL1));
+		arm64_caretaker_update_sysreg(state, SYS_PAR_EL1,
+					      ctxt_sys_reg(&cap->ctx.ctxt, PAR_EL1));
+		arm64_caretaker_update_sysreg(state, SYS_TPIDR_EL1,
+					      ctxt_sys_reg(&cap->ctx.ctxt, TPIDR_EL1));
+		arm64_caretaker_update_sysreg(state, SYS_TPIDR_EL0,
+					      ctxt_sys_reg(&cap->ctx.ctxt, TPIDR_EL0));
+		arm64_caretaker_update_sysreg(state, SYS_TPIDRRO_EL0,
+					      ctxt_sys_reg(&cap->ctx.ctxt, TPIDRRO_EL0));
+		arm64_caretaker_update_sysreg(state, SYS_SP_EL1,
+					      ctxt_sys_reg(&cap->ctx.ctxt, SP_EL1));
+		arm64_caretaker_update_sysreg(state, SYS_ELR_EL1,
+					      ctxt_sys_reg(&cap->ctx.ctxt, ELR_EL1));
+		arm64_caretaker_update_sysreg(state, SYS_SPSR_EL1,
+					      ctxt_sys_reg(&cap->ctx.ctxt, SPSR_EL1));
+		arm64_caretaker_update_sysreg(state, SYS_MDSCR_EL1,
+					      ctxt_sys_reg(&cap->ctx.ctxt, MDSCR_EL1));
+		arm64_caretaker_update_sysreg(state, SYS_CNTV_CVAL_EL0,
+					      cap->ctx.cntv_cval_el0);
+		arm64_caretaker_update_sysreg(state, SYS_CNTV_CTL_EL0,
+					      cap->ctx.cntv_ctl_el0);
+		cpu_preserved_clean_sz(state,
+				       struct_size(state, sysregs, state->num_sysregs));
+	}
+
+	cpu_preserved_clean(&cap->abi);
+}
+
+static void arm64_caretaker_sync_vcpu(struct kvm_vcpu *vcpu,
+				      void *data)
+{
+	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
+	struct kvm_caretaker_arch_ser *abi = data;
+	u64 cval, ctl;
+	int t;
+
+	/* Sync handover ABI prefix back into incoming vcpu */
+	vcpu->arch.hcr_el2 = abi->hcr_el2;
+	vcpu->arch.mdcr_el2 = abi->mdcr_el2;
+	vcpu->arch.cflags = abi->cflags;
+
+	if (abi->vgic_initialized) {
+		int i;
+
+		vcpu->arch.vgic_cpu.vgic_v3.used_lrs = abi->used_lrs;
+		vcpu->arch.vgic_cpu.vgic_v3.vgic_hcr = abi->vgic_hcr;
+		vcpu->arch.vgic_cpu.vgic_v3.vgic_vmcr = abi->vgic_vmcr;
+		for (i = 0; i < 4; i++) {
+			vcpu->arch.vgic_cpu.vgic_v3.vgic_ap0r[i] = abi->vgic_ap0r[i];
+			vcpu->arch.vgic_cpu.vgic_v3.vgic_ap1r[i] = abi->vgic_ap1r[i];
+		}
+		for (i = 0; i < 16; i++)
+			vcpu->arch.vgic_cpu.vgic_v3.vgic_lr[i] = abi->vgic_lr[i];
+	}
+
+	cval = __vcpu_sys_reg(vcpu, CNTV_CVAL_EL0);
+	ctl = __vcpu_sys_reg(vcpu, CNTV_CTL_EL0);
+	timer_set_offset(vtimer, abi->cntvoff_el2);
+	write_sysreg(abi->cntvoff_el2, cntvoff_el2);
+	write_sysreg_el0(cval, SYS_CNTV_CVAL);
+	write_sysreg_el0(ctl, SYS_CNTV_CTL);
+	isb();
+
+	vcpu_set_flag(vcpu, VCPU_INITIALIZED);
+
+	for (t = 0; t < NR_KVM_TIMERS; t++)
+		vcpu->arch.timer_cpu.timers[t].loaded = false;
+
+	kvm_make_request(KVM_REQ_IRQ_PENDING, vcpu);
+}
+
-- 
2.55.0.1082.g2b9226bbc0-goog


