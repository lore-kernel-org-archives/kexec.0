Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97B6C982F4
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TISPcN17siKpndLz83tiaGlQU7pN0QJXl7jCDX0Mj3w=; b=zFn1N//SFzXXE+dV2Bv228mOrs
	zthG6B+OC2zW2wSQCa5U5jr9ol9inPhk/bmdhYRZmI5FtjlPRNU7PSerkln6nZ7I03XFC/Qxwxo0f
	OvadmLdEgIcFcQSxIb/kIIIL8Qu94vQhPZessSAoOy8rIFHjXeWHfsklLbWEEmLAZ2sL0q0wx9X+/
	UdHmuDEfLn92PSSd9z7bFmHkC6SByfSIlKngYdmB1HN6P2f8XfF26HXpBNH/1tBFbWTllhmHZWJvF
	72es/PiCMFjXjNRyUJ6PRApNTnfTH6uOzIo8B/CGyQRI/AofuUdKYl6genoZYRsi45FYoNlH0wK8u
	VMkeS/Ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4M-00000000MGH-3cs6;
	Sun, 20 Sep 2026 20:23:26 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8NMO-00000000Icc-00rw
	for kexec@bombadil.infradead.org;
	Sun, 20 Sep 2026 19:38:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=TISPcN17siKpndLz83tiaGlQU7pN0QJXl7jCDX0Mj3w=; b=pbYUVKQo7sjf7FE5ydxCsE9LKz
	cFTw4hIKRznicv+7mHWo4bH4mwgirE8faQ4iyCe0fzkK5EpRS56YFk4Afv+v+YukPG4Vb0qVbxZkF
	KG1v/k2qo4GpXGuUTaWhp3+0/GCrS3Mr4xzxk7RZJG4Y+z5zdhmZf9/kWiRfOAAoDoPOyABa9knKe
	qI58l6Rgb81NPKMrfra46OJb8DZWDzsTaWtjDUcigi6XbeMK4nQYuGSoi/4VY4Ng6pQZr2JQx9NhY
	nygfIp5pCCQBDXTeCwkR47khn5kJe5jMyfQwq51gAlZHYyLJB5bCYjmMcGicMYakaGMYNuQeh5QUO
	gL1MafCw==;
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x8NMJ-0000000BaPi-41In
	for kexec@lists.infradead.org;
	Sun, 20 Sep 2026 19:37:58 +0000
Received: by mail-yx2-x10.google.com with SMTP id 956f58d0204a3-66f943b286fso1950687d50.2
        for <kexec@lists.infradead.org>; Sun, 20 Sep 2026 12:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789933074; x=1790537874; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TISPcN17siKpndLz83tiaGlQU7pN0QJXl7jCDX0Mj3w=;
        b=WfOv7e7STaiC5sszgJkIgiZLdemQPLdUvqoUH3bzq2nyqDFd/Qe2bJBxrGIA+zBxvG
         D+vn7JEzbDiN1wB9J+8bjJE4azt7Es69BDLteQqgO+K38aGHn3zJfKpTs7kIoGST4Tnr
         +zU2a78qetpQyTNLim8R8EqsVZg+jlxq0gf4afcA91ru05+XfYxIBRJPznXabavFzb9S
         4droVFW9TDul1R+pA1CXmVSRiszwYtRXdwRqGdcCb6NxQ1cCmKw2BLBBqahg4+cdZ8J9
         bD0P15ezsKMiXlIo9UPg5H0x65ks22Xn+ob1w3xLwfAwz34nBWIFI/65Ak3LnAIkhMZe
         Ex5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933074; x=1790537874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TISPcN17siKpndLz83tiaGlQU7pN0QJXl7jCDX0Mj3w=;
        b=EyZPnYSbxAO9SG/obPXJ2dLPRm0GrCuszlY86orcquHLsCICZiwQPobpNRBCyNWINi
         khtIZkVtt2WDrCJi7Ms7VV64iqhAo/Lwl690tMhm6YyxnYUooBO/7SEIWDclR9gm5P44
         /++QdQ9hZ7BEgi0P9NCnz/jelOdtHvq6ZxUUGE+5dGNT4E8YRz0sw50vnyuvji3khiRS
         VxKbVaD9enbKvPyhQXnD2SSU4hjotttW6L8HQQfmUIyFK535kdHfAKwjuEOyc4Kh/PnK
         jJ0IqkP8hbR652A5jVILlfSCTfuIwTG2PdQyqY9GTmkwgRIWxyoO4/iNu1Dd/4w6SGNn
         nP3Q==
X-Forwarded-Encrypted: i=1; AKwUvBw713hs/Ck1k8goV85DkCMsMDDkHeQsi+jXGlhSNJDm+Wt8/g4Sf6yWlneRt1F/qi2R67NYxQ==@lists.infradead.org
X-Gm-Message-State: AFuF++kqvMABOkp3Q69gHt4whgC5Rump286SRxkujtpeFlPJ9z5IGZ+7
	QpV0w5PQFOt4K6ub8mRfeIEymg3H3TXrjXsSlpAfQrzmty+cNvkNpJV3mhY2Ovt8gwc=
X-Gm-Gg: AYBFou30zJdrWXIa83L6/D08CR+AIt1recidPBPe2gyrDWG4DBtK42xIzOyb6hxtcoO
	4h7vKAdCZ0rzJRpYmeIJGD8hnDvbcluna+bzifrqD6Lv9PYlgNsLdMjjVQ4Yye6Iq8T4M/JRBcJ
	GLa1G6OeETZls1feKUJrk97YwEH+wtaKC2AbdUsRcNguFLiW7BJFDtP3ueooa6Q7Xn7vhk2rni9
	/13N1cy1/FM46V+yP2XLilbQBMCPwK17jj4FCJV2OwRUAxvodefxSIwbWSsp20Hy0d+om9oTg++
	tF71y/q4PW8s+/oOqMsxUi+aAKTBzmrCEI611VRbh/XtVpPM/VLtnfVw2F/NnrLBsRw1omdssr8
	ia/xhBXuk2VGOjDuG7r9L3z2Bzoc0L6msTcG2CN4k+idr85zjqVSjLACveWVMFG+vWfl2lWlojH
	rNG99zsLfuMmbRTM2F5v4L2RFa5lmuIhnQuF/NZIqZNL+6Jr2mEsOmxIQrEJlM1tFzTAwcb4art
	GHhBDYAFjUAqh1kJr3CmJOq9t6vy3kzVa5SPD+vvbXFUW8WR4q0LlU+x5zU0lJOgmjZl09gC7Gy
	dj6RE2h9PGtymoPfPL0=
X-Received: by 2002:a05:690e:4505:20b0:671:1490:8e67 with SMTP id 956f58d0204a3-6717fdc19eamr2004447d50.72.1789933074089;
        Sun, 20 Sep 2026 12:37:54 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6729910a52dsm2550544d50.16.2026.09.20.12.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:37:53 -0700 (PDT)
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
Subject: [RFC PATCH 10/46] KVM: arm64: Implement architectural vCPU state preservation via LUO
Date: Sun, 20 Sep 2026 15:36:14 -0400
Message-ID: <20260920193650.3373435-11-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
References: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_203756_172449_B5BC63D0 
X-CRM114-Status: GOOD (  21.45  )
X-Mailman-Approved-At: Sun, 20 Sep 2026 13:23:19 -0700
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

Implement ARM64 architectural vCPU state preservation and retrieval
handlers over LUO using struct kvm_vcpu_arch_ser in
include/linux/kho/abi/kvm_arm64.h.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kvm/Kconfig            |   1 +
 arch/arm64/kvm/Makefile           |   2 +
 arch/arm64/kvm/kvm_luo.c          | 201 ++++++++++++++++++++++++++++++
 include/linux/kho/abi/kvm_arm64.h |  61 +++++++++
 4 files changed, 265 insertions(+)
 create mode 100644 arch/arm64/kvm/kvm_luo.c
 create mode 100644 include/linux/kho/abi/kvm_arm64.h

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 449154f9a485..fd25b3c0d8ca 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -37,6 +37,7 @@ menuconfig KVM
 	select SCHED_INFO
 	select GUEST_PERF_EVENTS if PERF_EVENTS
 	select KVM_GUEST_MEMFD
+	select HAVE_KVM_ARCH_VCPU_PRESERVE
 	help
 	  Support hosting virtualized guest machines.
 
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 59612d2f277c..d5e888d1bd50 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -47,3 +47,5 @@ $(obj)/hyp_constants.h: $(obj)/hyp-constants.s FORCE
 
 obj-kvm := $(addprefix $(obj)/, $(kvm-y))
 $(obj-kvm): $(obj)/hyp_constants.h
+
+kvm-y += kvm_luo.o
diff --git a/arch/arm64/kvm/kvm_luo.c b/arch/arm64/kvm/kvm_luo.c
new file mode 100644
index 000000000000..59c56836cda8
--- /dev/null
+++ b/arch/arm64/kvm/kvm_luo.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ *
+ * ARM64 KVM LUO preservation and retrieval handlers.
+ */
+
+#include <linux/kexec_handover.h>
+#include <linux/kho/abi/kvm_arm64.h>
+#include <linux/kvm_host.h>
+#include <linux/sched.h>
+
+#include <asm/kvm_emulate.h>
+#include <asm/kvm_mmu.h>
+
+#include <kvm/arm_arch_timer.h>
+#include <kvm/arm_vgic.h>
+
+#include "sys_regs.h"
+#include "vgic/vgic.h"
+
+int kvm_arch_vm_luo_preserve(struct kvm *kvm, struct kvm_luo_ser *ser)
+{
+	ser->type = kvm_phys_shift(&kvm->arch.mmu);
+	if (kvm_vm_is_protected(kvm))
+		ser->type |= KVM_VM_TYPE_ARM_PROTECTED;
+
+	return 0;
+}
+
+int kvm_arch_vm_luo_retrieve(struct kvm *kvm, struct kvm_luo_ser *ser)
+{
+	return 0;
+}
+
+void kvm_arch_vm_luo_unpreserve(struct kvm *kvm, struct kvm_luo_ser *ser)
+{
+}
+
+void kvm_arch_vm_luo_finish(struct kvm_luo_ser *ser)
+{
+}
+
+static void kvm_arm_luo_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
+{
+	regs->regs = vcpu->arch.ctxt.regs;
+	regs->sp_el1 = ctxt_sys_reg(&vcpu->arch.ctxt, SP_EL1);
+	regs->elr_el1 = ctxt_sys_reg(&vcpu->arch.ctxt, ELR_EL1);
+	regs->spsr[KVM_SPSR_EL1] = ctxt_sys_reg(&vcpu->arch.ctxt, SPSR_EL1);
+	regs->spsr[KVM_SPSR_ABT] = vcpu->arch.ctxt.spsr_abt;
+	regs->spsr[KVM_SPSR_UND] = vcpu->arch.ctxt.spsr_und;
+	regs->spsr[KVM_SPSR_IRQ] = vcpu->arch.ctxt.spsr_irq;
+	regs->spsr[KVM_SPSR_FIQ] = vcpu->arch.ctxt.spsr_fiq;
+	regs->fp_regs = vcpu->arch.ctxt.fp_regs;
+}
+
+static void kvm_arm_luo_set_regs(struct kvm_vcpu *vcpu, const struct kvm_regs *regs)
+{
+	vcpu->arch.ctxt.regs = regs->regs;
+	ctxt_sys_reg(&vcpu->arch.ctxt, SP_EL1) = regs->sp_el1;
+	ctxt_sys_reg(&vcpu->arch.ctxt, ELR_EL1) = regs->elr_el1;
+	ctxt_sys_reg(&vcpu->arch.ctxt, SPSR_EL1) = regs->spsr[KVM_SPSR_EL1];
+	vcpu->arch.ctxt.spsr_abt = regs->spsr[KVM_SPSR_ABT];
+	vcpu->arch.ctxt.spsr_und = regs->spsr[KVM_SPSR_UND];
+	vcpu->arch.ctxt.spsr_irq = regs->spsr[KVM_SPSR_IRQ];
+	vcpu->arch.ctxt.spsr_fiq = regs->spsr[KVM_SPSR_FIQ];
+	vcpu->arch.ctxt.fp_regs = regs->fp_regs;
+}
+
+int kvm_arch_vcpu_luo_preserve(struct kvm_vcpu *vcpu, struct kvm_vcpu_ser *ser)
+{
+	struct kvm_vcpu_arch_ser *state;
+	int num_sysregs;
+	u64 *indices;
+	size_t size;
+	int i;
+
+	num_sysregs = kvm_arm_get_sys_reg_indices(vcpu, NULL);
+	indices = kmalloc_array(num_sysregs, sizeof(u64), GFP_KERNEL);
+	if (!indices)
+		return -ENOMEM;
+	num_sysregs = kvm_arm_get_sys_reg_indices(vcpu, indices);
+
+	size = struct_size(state, sysregs, num_sysregs);
+	state = kho_alloc_preserve(size);
+	if (IS_ERR(state)) {
+		kfree(indices);
+		return PTR_ERR(state);
+	}
+
+	/* Core register state (uAPI struct kvm_regs) */
+	kvm_arm_luo_get_regs(vcpu, &state->regs);
+
+	/* Multiprocessor execution state (uAPI struct kvm_mp_state) */
+	kvm_arch_vcpu_ioctl_get_mpstate(vcpu, &state->mp_state);
+	state->pad = 0;
+
+	/* Exception / SError injection events (uAPI struct kvm_vcpu_events) */
+	__kvm_arm_vcpu_get_events(vcpu, &state->events);
+
+	/* CPU target and feature configuration (uAPI struct kvm_vcpu_init) */
+	state->init.target = KVM_ARM_TARGET_GENERIC_V8;
+	bitmap_to_arr32(state->init.features, vcpu->kvm->arch.vcpu_features,
+			KVM_VCPU_MAX_FEATURES);
+
+	/* System registers (uAPI struct kvm_one_reg array) */
+	state->num_sysregs = 0;
+	state->reserved = 0;
+	for (i = 0; i < num_sysregs; i++) {
+		u64 val;
+
+		if (kvm_arm_sys_reg_read(vcpu, indices[i], &val) == 0) {
+			state->sysregs[state->num_sysregs].id = indices[i];
+			state->sysregs[state->num_sysregs].addr = val;
+			state->num_sysregs++;
+		}
+	}
+	kfree(indices);
+
+	KHOSER_STORE_PTR(ser->arch_state, state);
+	return 0;
+}
+
+int kvm_arch_vcpu_luo_retrieve(struct kvm_vcpu *vcpu, struct kvm_vcpu_ser *ser)
+{
+	struct kvm_vcpu_arch_ser *state;
+	int i;
+
+	if (!ser->arch_state.phys)
+		return 0;
+
+	state = KHOSER_LOAD_PTR(ser->arch_state);
+
+	/* Restore vCPU features */
+	bitmap_from_arr32(vcpu->kvm->arch.vcpu_features, state->init.features,
+			  KVM_VCPU_MAX_FEATURES);
+	set_bit(KVM_ARCH_FLAG_VCPU_FEATURES_CONFIGURED, &vcpu->kvm->arch.flags);
+	kvm_reset_vcpu(vcpu);
+	vcpu_set_flag(vcpu, VCPU_INITIALIZED);
+
+	vcpu_reset_hcr(vcpu);
+
+	/* Restore core registers */
+	kvm_arm_luo_set_regs(vcpu, &state->regs);
+
+	if (irqchip_in_kernel(vcpu->kvm) &&
+	    vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3) {
+		vgic_v3_reset(vcpu);
+	}
+
+	/* Restore system registers */
+	for (i = 0; i < state->num_sysregs; i++)
+		kvm_arm_sys_reg_write(vcpu, state->sysregs[i].id, state->sysregs[i].addr);
+
+	/* Restore multiprocessor execution state */
+	kvm_arch_vcpu_ioctl_set_mpstate(vcpu, &state->mp_state);
+
+	/* Restore exception / SError injection events */
+	__kvm_arm_vcpu_set_events(vcpu, &state->events);
+
+	if (irqchip_in_kernel(vcpu->kvm)) {
+		struct vgic_irq *irq;
+		unsigned long flags;
+
+		vcpu->kvm->arch.vgic.enabled = true;
+
+		irq = vgic_get_vcpu_irq(vcpu, timer_irq(vcpu_vtimer(vcpu)));
+		if (irq) {
+			raw_spin_lock_irqsave(&irq->irq_lock, flags);
+			irq->enabled = true;
+			raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
+			vgic_put_irq(vcpu->kvm, irq);
+		}
+		irq = vgic_get_vcpu_irq(vcpu, timer_irq(vcpu_ptimer(vcpu)));
+		if (irq) {
+			raw_spin_lock_irqsave(&irq->irq_lock, flags);
+			irq->enabled = true;
+			raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
+			vgic_put_irq(vcpu->kvm, irq);
+		}
+	}
+
+	return 0;
+}
+
+void kvm_arch_vcpu_luo_unpreserve(struct kvm_vcpu_ser *ser)
+{
+	if (ser->arch_state.phys) {
+		kho_unpreserve_free(phys_to_virt(ser->arch_state.phys));
+		ser->arch_state.phys = 0;
+	}
+}
+
+void kvm_arch_vcpu_luo_finish(struct kvm_vcpu_ser *ser)
+{
+	if (ser->arch_state.phys) {
+		kho_restore_free(phys_to_virt(ser->arch_state.phys));
+		ser->arch_state.phys = 0;
+	}
+}
diff --git a/include/linux/kho/abi/kvm_arm64.h b/include/linux/kho/abi/kvm_arm64.h
new file mode 100644
index 000000000000..dc121224a177
--- /dev/null
+++ b/include/linux/kho/abi/kvm_arm64.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+#ifndef _LINUX_KHO_ABI_KVM_ARM64_H
+#define _LINUX_KHO_ABI_KVM_ARM64_H
+
+#ifdef CONFIG_ARM64
+
+#include <linux/build_bug.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
+#include <linux/kho/abi/kvm.h>
+#include <uapi/linux/kvm.h>
+#include <uapi/asm/kvm.h>
+
+/**
+ * DOC: arm64 KVM vCPU Live Update ABI
+ *
+ * arm64 KVM uses the ABI defined below for preserving architectural vCPU state
+ * across a kexec reboot using LUO.
+ *
+ * The state is serialized into a packed structure `struct kvm_vcpu_arch_ser`
+ * which is handed over to the next kernel via KHO.
+ *
+ * The core register structure (struct kvm_regs) is a uAPI contract.
+ *
+ * This interface is a contract. Any modification to the structure layout
+ * constitutes a breaking change. Such changes require incrementing the version
+ * number in the KVM_VCPU_LUO_FH_COMPATIBLE string.
+ */
+
+/**
+ * struct kvm_vcpu_arch_ser - Preserved arm64 architectural vCPU state in RAM.
+ * @regs:        Core general-purpose and floating-point registers (uAPI struct kvm_regs).
+ * @mp_state:    Multiprocessor execution state (uAPI struct kvm_mp_state).
+ * @pad:         Padding to maintain 64-bit alignment after mp_state.
+ * @events:      Exception and SError injection state (uAPI struct kvm_vcpu_events).
+ * @init:        Target CPU and vCPU feature bitmap (uAPI struct kvm_vcpu_init).
+ * @num_sysregs: Number of serialized system registers in sysregs array.
+ * @reserved:    Reserved padding for 64-bit alignment.
+ * @sysregs:     Guest architectural system registers (uAPI struct kvm_one_reg array).
+ */
+struct kvm_vcpu_arch_ser {
+	struct kvm_regs regs;
+	struct kvm_mp_state mp_state;
+	u32 pad;
+	struct kvm_vcpu_events events;
+	struct kvm_vcpu_init init;
+	u32 num_sysregs;
+	u32 reserved;
+	struct kvm_one_reg sysregs[];
+} __packed;
+
+static_assert(offsetof(struct kvm_vcpu_arch_ser, sysregs) % sizeof(u64) == 0,
+	      "sysregs must be 64-bit aligned");
+
+#endif /* CONFIG_ARM64 */
+
+#endif /* _LINUX_KHO_ABI_KVM_ARM64_H */
-- 
2.55.0.1082.g2b9226bbc0-goog


