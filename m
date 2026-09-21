Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCA3606A32D
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 08:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=A3E3Mj3g;
	dkim=permerror header.d=soleen.com header.i=@soleen.com header.a=rsa-sha1 header.s=google header.b=g9EBp4+o
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LyT1gPJmowaA4BnBpSt/USFny02ugqagur5yRQ9/hu4=; b=A3E3Mj3g8WF6EtzCRo+UIB+TUK
	jqrDDztZIJj90aNgMCNk2iQNnHf3Q2m7WJetsAE1FoKQJf9/3RLKDSqxx8fGm7Mvg+8ybNfEEqCcp
	bRnnGdV0DeoSM32klyUsquDI8cisHUxPe23jr/CYbmxM5BAQS6Uw5GYtgC5lE+mWY/aOwYiAy5L5b
	DhzGGEnF/Eb3j0x+PxmfUXym6Pe1+B9Hp1OczOeNko7snVfpk5CT923i8sTJWg8UyVF7unS43jhvn
	bwYxpYt14Ws1dDsNJex27XgUv5BXB4NcOr0STKWcTYr6zgQ7yMy5HXlKstjW/sJ4bhBq4aKUdqwQk
	Z5o+vNbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ55t-000000098s8-2F45;
	Tue, 20 Oct 2026 08:21:13 +0000
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8l80-00000003Pbr-33T6
	for kexec@lists.infradead.org;
	Mon, 21 Sep 2026 21:00:45 +0000
Received: by mail-yx2-x10.google.com with SMTP id 00721157ae682-85d46e4cdcdso28952587b3.2
        for <kexec@lists.infradead.org>; Mon, 21 Sep 2026 14:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1790024443; x=1790629243; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LyT1gPJmowaA4BnBpSt/USFny02ugqagur5yRQ9/hu4=;
        b=g9EBp4+oNCHZNgxPUBVlkc6Nqf1y3fNoavNddYHnlEJ3PivYuBV+k1DfAFbqJwTwXM
         28gUQmje4N67z/AEzratIL+mlHKxttIqqVE+3NeRMnNd5VP1s/9ebndQ0s2Bqrp11tAS
         x9qVSnFAgRvWlxSNt/OxVVFBNZWWcGs+K1H8EW/IgfFtIOnMh2xbmXDa0xUaM/X4LH7u
         pKaxtlEFtfNU1VX2tuzMHlZtGD2Ebeh9qJMS34r8WATqzIwvtqYJEq50rRATdBLg2QLL
         qBQ3vrm7Jfb79W3y9SOG/l1QdVwVin2QcXQGyECAGKFQxlJm4FEA0ETwCegTGcixXz0U
         P9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790024443; x=1790629243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LyT1gPJmowaA4BnBpSt/USFny02ugqagur5yRQ9/hu4=;
        b=n4NoXbJAl3IXElcvCWE5b6vi0fxoTMBJSyBg2QflBiwqLaJQi6ydjDS2yW/Yi1HCzt
         3Rab5w6RTR+0jZ6j9eZt9YA96XQ4LePuaiPbbI4ZQGK3Z3SzdtPtjdMu0Rdxqw98xWdq
         C1aw2SeCnEAc49Wad3fYQTK30UGtBO7zygqZ0Gqn5Px3WZvLy+usIzTBI+8X1GYGH2HS
         6lhn7O7p8QGZwhGUzbiTPTbmXgf0XeLyavmw2gthkJogE8Vj+W6v6Eqvi246ZHF67klJ
         I96I7SYKaSO0L4sZg1H68GWyWFBdmVGEFV8qZypo4Myi7bTLqq9HJxmAhai8Nk9HhcVH
         Jb1w==
X-Forwarded-Encrypted: i=1; AKwUvByfjZvTUsk8zMXz9K9u1rpWITYv+fyG6yGaJOhm/R7S82Wrgzcw+E5FrucbUZCoVg3vOlo+Hg==@lists.infradead.org
X-Gm-Message-State: AFuF++l+6vIFBdy3Zx4MXSprriRiczVe6vVPQVBPnw1fR5qW4wTJLxIg
	xR8JriyJKaFPT+ZvNzk0osxXORpinGecfIgNy+oUxKGzOX+QqkwLqWsxz2uI2nvfWgg=
X-Gm-Gg: AYBFou3jit6SIZu0SQUMP4HPhTgTbun+uHs0Gm1FOc1GJniIRSkGIGHO91sEam++beI
	FQmoiBDXO1FloZsgOyZMs6cKX6ChcXYv8OqNGvAqmikaYqeo21kjag6DDEPtrVSmlMqcRXy27L4
	nhgNwa5jrecWFzE5eEpRGCwld3R8aOD4r8EeKzUxiwPt6x8G18VkljN/n4Oy0Y8VIIUivk16uD/
	MDu02L3ak2aKznWST8U0sslh+kdn31NrR2jTnx2DPTKDtKSqj/BzQKO/KvzGhIFXrU2Ro6u25n1
	Mrw4Zhv8SjH38voilP6YtWwRB8yidFAxZGRhnTQFt5gtJvkc6t9yf2T4aoyUCOTipM5LrTHk2jw
	jU28r9GOZpDnblwcxGM8orR5agPSt0YXpOapYAGdF2NNg47ENjSYsSyeAEBc6HZiVgMtY4pznfy
	F08/e20yV9cicvUlEscijQ/D00pdKtVo2gr3OkpDdIB9N4uAoWc/Ux9uB+X8cv6Ji7tR16V336L
	BL/2YC46BO2XINLsFckf4rDRQOPUG8rbx199MbpixMG/h1Jyz4nrfrhKJg8WKLMSW4c1J9B2Q4l
	YjGWmklffCWQvR6wEs4=
X-Received: by 2002:a05:690c:6606:b0:85b:f1ba:b111 with SMTP id 00721157ae682-89735d833a0mr60441177b3.26.1790024441836;
        Mon, 21 Sep 2026 14:00:41 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a23c738bdfsm1445297b3.11.2026.09.21.14.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 14:00:41 -0700 (PDT)
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
Subject: [RFC PATCH 40/46] KVM: SVM: Add Caretaker SVM assembly guest entry/exit routine
Date: Mon, 21 Sep 2026 17:00:28 -0400
Message-ID: <20260921210034.180424-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260921210034.180424-1-pasha.tatashin@soleen.com>
References: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
 <20260921210034.180424-1-pasha.tatashin@soleen.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_140044_785930_AD3427E9 
X-CRM114-Status: GOOD (  13.02  )
X-Spam-Score: 1.2 (+)
X-Mailman-Approved-At: Tue, 20 Oct 2026 01:21:07 -0700
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

Add arch/x86/kvm/svm/caretaker_vmenter.S and caretaker.h for standalone
AMD SVM VMRUN world switch on preserved physical cores.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/x86/kvm/svm/caretaker.h         | 63 +++++++++++++++++++
 arch/x86/kvm/svm/caretaker_vmenter.S | 91 ++++++++++++++++++++++++++++
 2 files changed, 154 insertions(+)
 create mode 100644 arch/x86/kvm/svm/caretaker.h
 create mode 100644 arch/x86/kvm/svm/caretaker_vmenter.S

diff --git a/arch/x86/kvm/svm/caretaker.h b/arch/x86/kvm/svm/caretaker.h
new file mode 100644
index 000000000000..54a0673cb1ea
--- /dev/null
+++ b/arch/x86/kvm/svm/caretaker.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+#ifndef __SVM_CARETAKER_H
+#define __SVM_CARETAKER_H
+
+#ifndef __ASSEMBLY__
+#include <linux/types.h>
+#include <linux/kvm_host.h>
+#include <linux/oncore.h>
+#include "svm.h"
+#endif
+
+#include "../caretaker.h"
+
+#define CSP_VMCB_OFFSET		0x1000
+#define CSP_HSAVE_PA_OFFSET	0x3000
+#define CSP_VMCB_PA_OFFSET	0x3010
+#define VMCB_RAX_OFFSET		0x5f8
+
+#ifndef __ASSEMBLY__
+
+struct caretaker_svm_page {
+	struct caretaker_x86_page common;
+
+	/* Page 1 (4KB): Preserved VMCB */
+	struct vmcb vmcb __aligned(PAGE_SIZE);
+
+	/* Page 2 (4KB): Preserved HSAVE area */
+	u8 hsave_area[PAGE_SIZE] __aligned(PAGE_SIZE);
+	u64 hsave_pa;
+	u64 orig_hsave_pa;
+	u64 vmcb_pa;
+	u64 orig_efer;
+
+	/* Preserved MSR and I/O permission bitmaps referenced by VMCB */
+	u8 msrpm[MSRPM_SIZE] __aligned(PAGE_SIZE);
+	u8 iopm[IOPM_SIZE] __aligned(PAGE_SIZE);
+} __aligned(PAGE_SIZE);
+
+static_assert(offsetof(struct caretaker_svm_page, vmcb) == CSP_VMCB_OFFSET);
+static_assert(offsetof(struct caretaker_svm_page, hsave_pa) == CSP_HSAVE_PA_OFFSET);
+static_assert(offsetof(struct caretaker_svm_page, vmcb_pa) == CSP_VMCB_PA_OFFSET);
+
+void svm_recalc_intercepts(struct kvm_vcpu *vcpu);
+
+#ifdef CONFIG_KVM_CARETAKER
+int svm_caretaker_enter(void *page);
+void svm_caretaker_decode_exit(void *page, struct kvm_caretaker_exit *exit);
+void svm_caretaker_register(void);
+void svm_caretaker_unregister(void);
+void svm_caretaker_init(struct kvm_vcpu *vcpu);
+#else
+static inline void svm_caretaker_register(void) {}
+static inline void svm_caretaker_unregister(void) {}
+static inline void svm_caretaker_init(struct kvm_vcpu *vcpu) {}
+#endif
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __SVM_CARETAKER_H */
diff --git a/arch/x86/kvm/svm/caretaker_vmenter.S b/arch/x86/kvm/svm/caretaker_vmenter.S
new file mode 100644
index 000000000000..e0276a34403e
--- /dev/null
+++ b/arch/x86/kvm/svm/caretaker_vmenter.S
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+#include <linux/linkage.h>
+#include <linux/cfi_types.h>
+#include <asm/asm.h>
+#include <asm/bitsperlong.h>
+#include <asm/nospec-branch.h>
+#include "caretaker.h"
+#include "../caretaker_asm.h"
+
+.section .text.cpu_preserved, "ax"
+
+/**
+ * svm_caretaker_enter - Low-level transition to SVM guest mode and back
+ * @csp: Pointer to struct caretaker_svm_page (%rdi)
+ */
+SYM_TYPED_FUNC_START(svm_caretaker_enter)
+	ENDBR
+	CARETAKER_PUSH_HOST_REGS
+	movq %cr3, %rax
+	pushq %rax                  /* saved_cr3 */
+
+	clgi
+	sti
+
+	/* 0. Save host VMCB state (FS, GS, TR, LDTR) to host save area */
+	movq CXP_HSAVE_PA(%rdi), %rax
+	testq %rax, %rax
+	jz 10f
+	vmsave %rax
+10:
+
+	/* 1. Sync guest RAX to VMCB and load guest state (FS, GS, TR, LDTR) */
+	leaq CSP_VMCB_OFFSET(%rdi), %rax
+	movq CXP_REG_RAX(%rdi), %rbx
+	movq %rbx, VMCB_RAX_OFFSET(%rax)
+	movq CSP_VMCB_PA_OFFSET(%rdi), %rax
+	vmload %rax
+
+	/* 2. Restore guest GPRs */
+	CARETAKER_RESTORE_GPRS_NO_RAX %rdi
+
+	/* 3. Run guest */
+	pushq %rdi
+	movq CXP_REG_RDI(%rdi), %rdi
+	movq (%rsp), %rax
+	movq CSP_VMCB_PA_OFFSET(%rax), %rax
+	CARETAKER_CLEAR_CPU_BUFFERS
+	vmrun %rax
+	cli
+
+	/* 4. Guest exited: Save guest GPRs */
+	xchgq %rdi, (%rsp)          /* rdi = csp, stack = guest rdi */
+	popq CXP_REG_RDI(%rdi)
+
+	CARETAKER_SAVE_GPRS_NO_RAX %rdi
+
+	/* Stuff Return Stack Buffer to prevent guest RSB poisoning */
+	CARETAKER_FILL_RETURN_BUFFER %rax
+
+	/* 5. Save guest state to VMCB */
+	movq CSP_VMCB_PA_OFFSET(%rdi), %rax
+	vmsave %rax
+	leaq CSP_VMCB_OFFSET(%rdi), %rax
+	movq VMCB_RAX_OFFSET(%rax), %rbx      /* save.rax */
+	movq %rbx, CXP_REG_RAX(%rdi)
+
+	/* 5a. Restore host VMCB state (FS, GS, TR, LDTR) from HSAVE */
+	movq CXP_HSAVE_PA(%rdi), %rax
+	testq %rax, %rax
+	jz 40f
+	vmload %rax
+40:
+
+	/* 5b. Restore host CR3 if clobbered */
+	popq %rbx                   /* saved_cr3 */
+	movq %cr3, %rcx
+	cmpq %rbx, %rcx
+	je 50f
+	movq %rbx, %cr3
+50:
+	stgi
+
+	/* 6. Restore host callee-saved registers & return to C */
+	CARETAKER_POP_HOST_REGS
+	xorq %rax, %rax
+	ret
+SYM_FUNC_END(svm_caretaker_enter)
-- 
2.55.0.1082.g2b9226bbc0-goog


