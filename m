Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B56606A324
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 08:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=I0hehFnd;
	dkim=temperror header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=oc45Sng7;
	dkim=permerror header.d=soleen.com header.i=@soleen.com header.a=rsa-sha1 header.s=google header.b=SbYtqE2B
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4dqs3u8rw3iSD+q7sDNmdGaZSDb+sElYZHHxIFq5uRQ=; b=I0hehFndQlvTUgLB9qcgXEUrlw
	VGxsVz4zcw3T3kcilnV7o/h3Fil6gjL6g46EflSWO+wY5H/COYusUQdO74tt3VXFfKPS1+odgpZTM
	DJHqcOaHdcM60KmT+CJDN34ejTArfQ4sVR5cMaqGlh59kEE2ZWYj4HkGEgz1hZQ9XI0J6OcyK1+y5
	czpZAPJ1OR1oq0V6L8h4DuV/Zc9EpFnzzQLxNuHX0vChz06FkWGqRJXYSDEimiUQYmBybDdTXEcIy
	2DkpFv6J3zZOukgxHBz/WfhzTuTCdeBALC92GYJSwoa/INU0j4vuT/nPTEyIjmtv1e+mFBLivbcdM
	f+HAS2Yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ55u-000000098t0-03JW;
	Tue, 20 Oct 2026 08:21:14 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8l8F-00000003Pix-0aEn
	for kexec@bombadil.infradead.org;
	Mon, 21 Sep 2026 21:00:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=4dqs3u8rw3iSD+q7sDNmdGaZSDb+sElYZHHxIFq5uRQ=; b=oc45Sng771YCq1wLume5bi+16u
	4iDSey0dUtbuP8zzGwQNFgH9lGvWvQ3Rmg08sD5bHQvK4DEmp6z8845qttYxjLg5CyDShgZLJdlRP
	8zz4Vn8xbMIfwrl2FdXdL3JWaTvdth+QLxu7eE0hkm2PFP5szx7dxxfGd8g0S4NSj/ZnTjYZ47Snd
	TUHBm1u5rONksl/vRZSeSvLlw4HkDXn/Va/eFCwUHvViukRUQRpjMef9er0+npGmoGL/zob7g/ZQy
	R5TDWWbmH989XNH1A4ZxLpRJ9IyljPGSGPDH7zW4dJrDFu7FC+2sGgYn6GOWsflnqtP5kX2WW8pal
	B62e6/fA==;
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x8l8A-0000000Cp6a-0QRt
	for kexec@lists.infradead.org;
	Mon, 21 Sep 2026 21:00:57 +0000
Received: by mail-yx2-x10.google.com with SMTP id 00721157ae682-85d43f9b119so31248767b3.2
        for <kexec@lists.infradead.org>; Mon, 21 Sep 2026 14:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1790024449; x=1790629249; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4dqs3u8rw3iSD+q7sDNmdGaZSDb+sElYZHHxIFq5uRQ=;
        b=SbYtqE2BSX7dtwyRwwOFW7MBT4vcY0cfUcOvwcthhFINTF3eRGbVBtFJGQxIOvAvCb
         ZPfAG+jxzG5reTphRtB/yrsLyXZkWrJ1qUiQgbwDIkq95cK+FRmSVkTrLuBH4By+A1t2
         d1apUSNkoWpeLS4QnO+wy/8w0DzDduMPOD13FJ809aFG3LLXbBUZ6R1J44ka3E0oljJJ
         qF8uLYGpAE68LcOsQFZ2GhJuEbMVV1ZFQ7DoZoOZHvaqIhbgE8uoBp/UJap2tkHAFNGx
         GV0uuAWI4X6TZ+YKUB3axBQjuhk0E83DIvTCrzctdmi7u4eJVSYjJUvddQwf6mKXteB0
         PlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790024449; x=1790629249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4dqs3u8rw3iSD+q7sDNmdGaZSDb+sElYZHHxIFq5uRQ=;
        b=AlfJc8D338qpGlqqLVp+TqP8zVkCuyqHsgbpdtlsn0Wh49NhPJJN2dNbJqpPo4MnrO
         /aRKvQ4cok2VUJbzL4KWeRg1VL5T7lvh+kgsf+XQpgy1Q1v8n7x/51poKJ/1E7AUCXCc
         apWB0teORFI0gA/pKoIrB0cFY6DHsiXsX4gKcdviCy+CpKlLQjc+q8adjjazI6bKHMMR
         LuRtASqWpFbkVp22Cwc7boDvhn+JG1QxBDcQimqk9orAM3PB5bnt5xcdDs3BtQw6MMv7
         uTcIQ8oXlbITjd9KSmSShK437tyAO9KJG++CWQtU9Pae0j5WodXv2hjmJSLv7CALUIsa
         UqTg==
X-Forwarded-Encrypted: i=1; AKwUvBytIorloWdwHuUuClgsETnmXldDOPKwQNsNkfLz2Cr41LCFbrc9+YeRS/UOzbSM8vgme7zDxw==@lists.infradead.org
X-Gm-Message-State: AFuF++mQCqNzMm1j7hvc/1aSG29r4G6PJ0I7KwJ0hxBBUD+si/0Nstb3
	eM3uDie9db8DrwuZayUDo/1vNo0EWWNeDrOaoSolMw6td2eRcAU7WmPECb+AWTkcjA8=
X-Gm-Gg: AYBFou1eKHpjL62GGEq+hjZtTLU95dq+IXR3/uycHo5fdxnu4HDXz3Rq/qRdKg/IT0d
	3dj0aBZsTP9ZvX6VNoqoOOW/P4SnPw6lRh4L6eBnMw4O69M5tdJ9AKHVhgonfXNCVf7cKALEne+
	Gv5E+E47Azuc7TceT+fHdT35kZXApSq2grx3Z7MVD+FOArlaqeZfRjel5kH6Cw7zrANQV9Yqicd
	6Rh4+Za/9s+NnSCwCLDdehs2QfHpr8olvvEkwY8h9ReJ4LDY1e0aIeDGEJJugDu2TNqgxpddtKB
	kTC0T3xMj5cv4JK/UJyOAcRe3Tnz44dBL6OMJi+n8ADlm5DEMsP4OHACgzpntOKjAXzzMf1QR6K
	Oh8R1rmIBaF3cmpYgUFZIN0U89yAaH/rLhle63qYBPaQZNYWl5eLAFyPcNmYpIrKmdR5QXWyCUx
	+TAx2d1wn3/c8qNNh85M2Sd11lg9qnt6e586UODFywkQXmQE69jbMmE/Cz/aSevEDEcML1p+u4C
	b4HyIF0F5KzqAzhkOS8AW5zvA5E5A+pTOT0TM8jp2a3nfm66QgdS55z8IkXxbDQ8QKXNxB3PZgP
	ZgC2RfW2bieGrzj1zf0=
X-Received: by 2002:a05:690c:39b:b0:89a:63da:fa95 with SMTP id 00721157ae682-89a63db043amr28878177b3.80.1790024449272;
        Mon, 21 Sep 2026 14:00:49 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a23c738bdfsm1445297b3.11.2026.09.21.14.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 14:00:48 -0700 (PDT)
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
Subject: [RFC PATCH 43/46] KVM: arm64: Add Caretaker EL2 exception vectors and guest entry/exit assembly
Date: Mon, 21 Sep 2026 17:00:31 -0400
Message-ID: <20260921210034.180424-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260921210034.180424-1-pasha.tatashin@soleen.com>
References: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
 <20260921210034.180424-1-pasha.tatashin@soleen.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_220055_805476_EAFA1FD5 
X-CRM114-Status: GOOD (  16.09  )
X-Spam-Score: 3.4 (+++)
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

Add arch/arm64/kvm/caretaker_vmenter.S for standalone VHE EL2 guest
entry/exit world switch and exception vector dispatch on preserved cores.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kvm/caretaker_vmenter.S | 248 +++++++++++++++++++++++++++++
 1 file changed, 248 insertions(+)
 create mode 100644 arch/arm64/kvm/caretaker_vmenter.S

diff --git a/arch/arm64/kvm/caretaker_vmenter.S b/arch/arm64/kvm/caretaker_vmenter.S
new file mode 100644
index 000000000000..6dff9fbe931f
--- /dev/null
+++ b/arch/arm64/kvm/caretaker_vmenter.S
@@ -0,0 +1,248 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Caretaker low-level guest entry/exit and vector table for ARM64 VHE.
+ *
+ * Copyright (c) 2026, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <asm/kvm_arm.h>
+#include <asm/kvm_asm.h>
+#include <asm/sysreg.h>
+#include "caretaker.h"
+
+	.pushsection ".text.cpu_preserved", "ax"
+
+.macro cventry target
+	.align 7
+	stp	x0, x1, [sp, #-16]!
+	b	\target
+.endm
+
+	.align 11
+SYM_CODE_START(caretaker_hyp_vector)
+	/* Current EL with SP0 */
+	cventry	caretaker_invalid
+	cventry	caretaker_el2h_irq
+	cventry	caretaker_el2h_irq
+	cventry	caretaker_invalid
+
+	/* Current EL with SPx (EL2h) */
+	cventry	caretaker_invalid
+	cventry	caretaker_el2h_irq
+	cventry	caretaker_el2h_irq
+	cventry	caretaker_invalid
+
+	/* Lower EL using AArch64 (Guest EL1/EL0) */
+	cventry	caretaker_el1_sync
+	cventry	caretaker_el1_irq
+	cventry	caretaker_el1_fiq
+	cventry	caretaker_el1_error
+
+	/* Lower EL using AArch32 */
+	cventry	caretaker_el1_sync
+	cventry	caretaker_el1_irq
+	cventry	caretaker_el1_fiq
+	cventry	caretaker_el1_error
+SYM_CODE_END(caretaker_hyp_vector)
+
+SYM_CODE_START_LOCAL(caretaker_invalid)
+	mrs	x0, elr_el2
+	mrs	x1, esr_el2
+	mrs	x2, far_el2
+	b	arm64_caretaker_handle_invalid
+SYM_CODE_END(caretaker_invalid)
+
+SYM_CODE_START_LOCAL(caretaker_el2h_irq)
+	stp	x2, x3,   [sp, #-16]!
+	stp	x4, x5,   [sp, #-16]!
+	stp	x6, x7,   [sp, #-16]!
+	stp	x8, x9,   [sp, #-16]!
+	stp	x10, x11, [sp, #-16]!
+	stp	x12, x13, [sp, #-16]!
+	stp	x14, x15, [sp, #-16]!
+	stp	x16, x17, [sp, #-16]!
+	stp	x29, x30, [sp, #-16]!
+
+	mrs_s	x0, SYS_ICC_IAR1_EL1
+	cmp	x0, #GIC_SPECIAL_INTID_START
+	b.ge	1f
+	msr_s	SYS_ICC_EOIR1_EL1, x0
+	msr_s	SYS_ICC_DIR_EL1, x0
+1:
+	/*
+	 * Silence the EL2 physical timer before returning.
+	 *
+	 * It is the only EL2 interrupt source the Caretaker arms
+	 * (arm64_caretaker_op_arm_timer() writes CNTHP_CTL_EL2.ENABLE to
+	 * drive the on-core quantum), and it is level-triggered off
+	 * CNTHP_CTL_EL2.ISTATUS.  Neither EOIR1 nor DIR clears ISTATUS, so
+	 * without disabling ENABLE here the line re-asserts the instant we
+	 * eret and the core live-locks taking the same interrupt forever --
+	 * it never reaches the run loop, which means it can never observe a
+	 * detach request and can never be reclaimed.
+	 *
+	 * This is done on the special-INTID path too: a spurious read of
+	 * IAR1 does not mean the timer has stopped asserting.  The run loop
+	 * re-arms the timer for each new quantum, so dropping it here costs
+	 * at most the remainder of the current one.
+	 */
+	msr_s	SYS_CNTHP_CTL_EL2, xzr
+	isb
+
+	ldp	x29, x30, [sp], #16
+	ldp	x16, x17, [sp], #16
+	ldp	x14, x15, [sp], #16
+	ldp	x12, x13, [sp], #16
+	ldp	x10, x11, [sp], #16
+	ldp	x8, x9,   [sp], #16
+	ldp	x6, x7,   [sp], #16
+	ldp	x4, x5,   [sp], #16
+	ldp	x2, x3,   [sp], #16
+	ldp	x0, x1,   [sp], #16
+	eret
+	sb
+SYM_CODE_END(caretaker_el2h_irq)
+
+SYM_CODE_START_LOCAL(caretaker_el1_sync)
+	mov	x0, #ARM_EXCEPTION_TRAP
+	b	caretaker_guest_exit
+SYM_CODE_END(caretaker_el1_sync)
+
+SYM_CODE_START_LOCAL(caretaker_el1_irq)
+SYM_CODE_START_LOCAL(caretaker_el1_fiq)
+	mov	x0, #ARM_EXCEPTION_IRQ
+	b	caretaker_guest_exit
+SYM_CODE_END(caretaker_el1_fiq)
+SYM_CODE_END(caretaker_el1_irq)
+
+SYM_CODE_START_LOCAL(caretaker_el1_error)
+	mov	x0, #ARM_EXCEPTION_EL1_SERROR
+	b	caretaker_guest_exit
+SYM_CODE_END(caretaker_el1_error)
+
+/*
+ * u64 caretaker_guest_enter(struct kvm_vcpu *vcpu);
+ *   x0: vcpu pointer
+ * Returns exit code in x0.
+ */
+SYM_FUNC_START(caretaker_guest_enter)
+	// Save host callee-saved registers on stack
+	stp	x19, x20, [sp, #-112]!
+	stp	x21, x22, [sp, #16]
+	stp	x23, x24, [sp, #32]
+	stp	x25, x26, [sp, #48]
+	stp	x27, x28, [sp, #64]
+	stp	x29, x30, [sp, #80]
+	str	x0, [sp, #96]			// Save vcpu pointer on host stack
+	mrs	x1, sp_el0
+	str	x1, [sp, #104]			// Save host sp_el0 (current task)
+
+	// Install caretaker vectors
+	adr_l	x1, caretaker_hyp_vector
+	msr	vbar_el1, x1
+	msr	vbar_el2, x1
+	isb
+
+	// Restore guest context from ctx->ctxt
+	add	x29, x0, #CAP_CTXT_OFFSET
+
+	ldr	x1, [x29, #CPU_XREG_OFFSET(32)]	// regs.pc
+	msr	elr_el2, x1
+	ldr	x1, [x29, #CPU_XREG_OFFSET(33)]	// regs.pstate
+	msr	spsr_el2, x1
+	ldr	x1, [x29, #CPU_XREG_OFFSET(31)]	// regs.sp
+	msr	sp_el0, x1
+
+	// Restore guest GPRs x0-x28, lr (x30)
+	ldp	x0, x1, [x29, #CPU_XREG_OFFSET(0)]
+	ldp	x2, x3, [x29, #CPU_XREG_OFFSET(2)]
+	ldp	x4, x5, [x29, #CPU_XREG_OFFSET(4)]
+	ldp	x6, x7, [x29, #CPU_XREG_OFFSET(6)]
+	ldp	x8, x9, [x29, #CPU_XREG_OFFSET(8)]
+	ldp	x10, x11, [x29, #CPU_XREG_OFFSET(10)]
+	ldp	x12, x13, [x29, #CPU_XREG_OFFSET(12)]
+	ldp	x14, x15, [x29, #CPU_XREG_OFFSET(14)]
+	ldp	x16, x17, [x29, #CPU_XREG_OFFSET(16)]
+	ldp	x18, x19, [x29, #CPU_XREG_OFFSET(18)]
+	ldp	x20, x21, [x29, #CPU_XREG_OFFSET(20)]
+	ldp	x22, x23, [x29, #CPU_XREG_OFFSET(22)]
+	ldp	x24, x25, [x29, #CPU_XREG_OFFSET(24)]
+	ldp	x26, x27, [x29, #CPU_XREG_OFFSET(26)]
+	ldr	x30,      [x29, #CPU_XREG_OFFSET(30)]
+	ldp	x28, x29, [x29, #CPU_XREG_OFFSET(28)]
+
+	eret
+	sb
+SYM_FUNC_END(caretaker_guest_enter)
+
+SYM_CODE_START_LOCAL(caretaker_guest_exit)
+	// Save exception code in x0 temporarily
+	str	x0, [sp, #-16]!
+
+	// Retrieve ctx pointer from host stack
+	ldr	x0, [sp, #128]
+	add	x1, x0, #CAP_CTXT_OFFSET
+
+	// Save guest GPRs x2-x29, lr (x30)
+	stp	x2, x3,   [x1, #CPU_XREG_OFFSET(2)]
+	stp	x4, x5,   [x1, #CPU_XREG_OFFSET(4)]
+	stp	x6, x7,   [x1, #CPU_XREG_OFFSET(6)]
+	stp	x8, x9,   [x1, #CPU_XREG_OFFSET(8)]
+	stp	x10, x11, [x1, #CPU_XREG_OFFSET(10)]
+	stp	x12, x13, [x1, #CPU_XREG_OFFSET(12)]
+	stp	x14, x15, [x1, #CPU_XREG_OFFSET(14)]
+	stp	x16, x17, [x1, #CPU_XREG_OFFSET(16)]
+	stp	x18, x19, [x1, #CPU_XREG_OFFSET(18)]
+	stp	x20, x21, [x1, #CPU_XREG_OFFSET(20)]
+	stp	x22, x23, [x1, #CPU_XREG_OFFSET(22)]
+	stp	x24, x25, [x1, #CPU_XREG_OFFSET(24)]
+	stp	x26, x27, [x1, #CPU_XREG_OFFSET(26)]
+	stp	x28, x29, [x1, #CPU_XREG_OFFSET(28)]
+	str	x30,      [x1, #CPU_XREG_OFFSET(30)]
+
+	// Clear Branch History Buffer (Spectre-BHB mitigation) across EL1->EL2 exit
+	mov	x2, #32
+1:	b	2f
+2:	subs	x2, x2, #1
+	b.ne	1b
+	isb
+
+	// Retrieve and save guest x0, x1 (from vector entry on stack)
+	ldp	x2, x3, [sp, #16]
+	stp	x2, x3, [x1, #CPU_XREG_OFFSET(0)]
+
+	// Save guest system registers
+	mrs	x2, elr_el2
+	str	x2, [x1, #CPU_XREG_OFFSET(32)]	// regs.pc
+	mrs	x2, spsr_el2
+	str	x2, [x1, #CPU_XREG_OFFSET(33)]	// regs.pstate
+	mrs	x2, sp_el0
+	str	x2, [x1, #CPU_XREG_OFFSET(31)]	// regs.sp
+	mrs	x2, esr_el2
+	str	x2, [x0, #CAP_FAULT_ESR]
+	mrs	x2, far_el2
+	str	x2, [x0, #CAP_FAULT_FAR]
+	mrs	x2, hpfar_el2
+	str	x2, [x0, #CAP_FAULT_HPFAR]
+
+	// Restore return value (exception code) in x0
+	ldr	x0, [sp], #32			// pops exception code + saved x0,x1
+
+	// Restore host callee-saved registers
+	ldp	x19, x20, [sp, #0]
+	ldp	x21, x22, [sp, #16]
+	ldp	x23, x24, [sp, #32]
+	ldp	x25, x26, [sp, #48]
+	ldp	x27, x28, [sp, #64]
+	ldp	x29, x30, [sp, #80]
+	ldr	x1, [sp, #104]
+	msr	sp_el0, x1
+	add	sp, sp, #112
+
+	ret
+SYM_CODE_END(caretaker_guest_exit)
+
+	.popsection
-- 
2.55.0.1082.g2b9226bbc0-goog


