Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C36C982E6
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fQwtMjDkRZvOK0KEqWuda0aT7+Kg50uVl9w6x/heTIA=; b=bZiP1cdVlWlmNSFOp0/W4qTqRd
	nKxZ18FDtZ6zFd16Fs7t5QbIhRr0yGklzGjSMZDTlESI7INyVLFo4DoN2omKeS0pcPqRCFETjjXfO
	yuVnW64KHDA5P94P4yD2bE57UO6Pf72Xj9P9O0h+j05jFtZspjmTEkt0Y8gU4KlqA3XhB0bqMRBDB
	5TqxStxdz6RsScWXAHvP8WyDzSSFF8tmYCGi9H2pC2u/vWQYWm2Kwc19fwm6mn6yj0sLEB5yZ1KLu
	RhDKnfo5EAHi9PPKbqgPnv2HbFc6Y6ntZvwJmSdJCxsofeHsI8gxwA2VDMJaIdpfWa/V2S1uiUdnj
	E4VCj01Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4s-00000000NbN-2mKC;
	Sun, 20 Sep 2026 20:23:59 +0000
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8NNA-00000000Iuq-34Ya
	for kexec@lists.infradead.org;
	Sun, 20 Sep 2026 19:38:50 +0000
Received: by mail-yx2-x11.google.com with SMTP id 00721157ae682-85d43daa8f4so14401847b3.3
        for <kexec@lists.infradead.org>; Sun, 20 Sep 2026 12:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789933128; x=1790537928; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fQwtMjDkRZvOK0KEqWuda0aT7+Kg50uVl9w6x/heTIA=;
        b=Q+L2x9/P5JmiezuQSJWS8gHQGZGXXqlEaUW3XUYSJz4RAy80sf5Cjt6ZEOh2rhbvXD
         w7fwW5B2J6fsIazICH+kOl+Ry7jIWouiGlk186GsQbB9/TN6FQwGvOYG8d9hzEhFAK2E
         ycODsvEdLwS+jtOiCTnKx3BRqlUiai4txMHxrLhppgtdY6KCECKQB2CwcTTvhft32BBk
         lWOOLw5IAE2ki5cLMLd6TXofbUc0wlNDhRE8ooTdYbLuv9tY1KgWfdpsGoGKAcfxvp5P
         C7uQXU/58dfZNlsEBcVYKq5q6vt+bmZiOXjA0sW+zbUsn43j9QXH0TKMk85f2dqir7Lr
         GScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933128; x=1790537928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fQwtMjDkRZvOK0KEqWuda0aT7+Kg50uVl9w6x/heTIA=;
        b=m3Z0qU7/NPvXfh84lVo/mClyI0++SgQaWXqCQcs8/F7Fa+Qc7PU9Rdj128v3dJmGf6
         GFcAfidXhkB2A4kOOaAjGtbJdDd3PSWDdLnGI+6NCavmRo8Fy7Q35JzqNY7oVh2NXfck
         gsMRbGS/aM3CrZMYDCBftDFkMJuIAdlNQ0exSc4JODikctxSwxWOWngAnukeRkHWw1+a
         0E4zDKeZK3C1qw9g/DKQYen12ly7FLcemh7fscmvH3YruMM4EdpzPDM5VT31nLLUpH5I
         RO74HPKGF59BJY2A6A8PnBeAHM6r2QTYdPUq3oZ6pbb6YrHofEJd6YZlxM4cs1OQdtrf
         NCFA==
X-Forwarded-Encrypted: i=1; AKwUvBzH7YdONi/3ouM7pvBijZoFacE+5l7PVY3VQEemF1CS6H1UcVSQrSvP+eDxNN00RJ+ewoo2ww==@lists.infradead.org
X-Gm-Message-State: AFuF++l1xaugHoBJHUiu2cHuxF236zDX4/tmKkUXe8sJy7Xo/WLGDqhe
	7Jr6GBErHvZnjJHilh0qun8o6ccmA87kOVcF9KxNhTHGxGwn0RFXpZFnVd0x4Y/prpc=
X-Gm-Gg: AYBFou31i+RSfGhb+GJyv+DqN88IN1gWbrezP8QBVRn6WBLAvT3RLT2asLYcIyboytN
	vqZqF9dBQt57ykQEcopSpc91AqlfKUcNWhGa9V9sw471o6gbz5zwQtIkBwJWmXOCkUhnyiLBtlb
	90b7zhBK1OjeHh7bpdCUFpcOAO1awufzIhLs5cwKxwiErZyQpt9AnN34s7xnLned9VKDXHt+Zzb
	gClEN+SbFBxTNKxYWN0ewfHC9MYvF92mmsdZrGMkh3C7r0W+GhlGAuu1YicaJvnX9qC/o44KLTB
	4bNqRketfJTqxm37zxaDhRa07t335YjJkWmoVTy/WqLTxdK8QpHf8uYP94nD4cGC0YcjkGo38VJ
	Df178PGbpEr8Lm/oaElyYlPrRyi69MCcaFl/fBZvFG2KeqFKJnMip/fDlUJd8tgyA+JM+jx9kI7
	6QUjuwNYO/ZWBuqTNba30TptTGyiajW8kMrW3pRANDbxaXRXhBr8X49ePsaelWOyPFfqyt8FLeY
	oAJxs8SiUiYCtYTAG+YB6JFxI06NddQDNNgko6itlwjwAZefApnLY8u917SDXqnNkBkyNI+J4/z
	f789iEWgUb6gRxUEbiw=
X-Received: by 2002:a05:690c:d8a:b0:882:309e:fcaa with SMTP id 00721157ae682-89733726012mr21472487b3.15.1789933127683;
        Sun, 20 Sep 2026 12:38:47 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a46c43cecsm19037957b3.22.2026.09.20.12.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:38:46 -0700 (PDT)
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
Subject: [RFC PATCH 19/46] x86: liveupdate: Add low-level physical CPU preservation assembly
Date: Sun, 20 Sep 2026 15:36:23 -0400
Message-ID: <20260920193650.3373435-20-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
References: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_123848_782940_5D353D49 
X-CRM114-Status: GOOD (  12.74  )
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

Add arch/x86/kernel/preserve_cpu.S stack switch routine, preserved linker
sections in vmlinux.lds.S, and SMP stop exclusion for preserved cores.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/x86/include/asm/cpu_preserve.h | 31 +++++++++++++++
 arch/x86/kernel/preserve_cpu.S      | 62 +++++++++++++++++++++++++++++
 arch/x86/kernel/vmlinux.lds.S       |  2 +
 3 files changed, 95 insertions(+)
 create mode 100644 arch/x86/include/asm/cpu_preserve.h
 create mode 100644 arch/x86/kernel/preserve_cpu.S

diff --git a/arch/x86/include/asm/cpu_preserve.h b/arch/x86/include/asm/cpu_preserve.h
new file mode 100644
index 000000000000..969903eb70cb
--- /dev/null
+++ b/arch/x86/include/asm/cpu_preserve.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+#ifndef __ASM_X86_CPU_PRESERVE_H
+#define __ASM_X86_CPU_PRESERVE_H
+
+#include <asm/page_types.h>
+
+#define ARCH_CPU_PRESERVED_STACK_ORDER	THREAD_SIZE_ORDER
+
+#ifdef CONFIG_CC_IS_GCC
+#define ARCH_CPU_PRESERVED_TEXT \
+	__attribute__((indirect_branch("keep"), function_return("keep")))
+#else
+#define ARCH_CPU_PRESERVED_TEXT
+#endif
+
+#ifdef CONFIG_LIVEUPDATE_CPU
+void arch_cpu_preserved_load_desc(void);
+bool arch_cpu_preserved_is_active(void);
+void x86_preserved_iret_stub(void);
+void x86_preserved_iret_err_stub(void);
+void x86_preserved_apic_eoi_stub(void);
+#else
+static inline void arch_cpu_preserved_load_desc(void) {}
+static inline bool arch_cpu_preserved_is_active(void) { return false; }
+#endif
+
+#endif /* __ASM_X86_CPU_PRESERVE_H */
diff --git a/arch/x86/kernel/preserve_cpu.S b/arch/x86/kernel/preserve_cpu.S
new file mode 100644
index 000000000000..8acb98d46f90
--- /dev/null
+++ b/arch/x86/kernel/preserve_cpu.S
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+#include <linux/linkage.h>
+#include <asm/nospec-branch.h>
+#include <asm/unwind_hints.h>
+
+	.section .text.cpu_preserved, "ax"
+
+SYM_CODE_START(x86_preserved_iret_err_stub)
+	UNWIND_HINT_IRET_REGS
+	ENDBR
+	addq	$8, %rsp
+	iretq
+SYM_CODE_END(x86_preserved_iret_err_stub)
+
+SYM_CODE_START(x86_preserved_iret_stub)
+	UNWIND_HINT_IRET_REGS
+	ENDBR
+	iretq
+SYM_CODE_END(x86_preserved_iret_stub)
+
+SYM_CODE_START(x86_preserved_apic_eoi_stub)
+	UNWIND_HINT_IRET_REGS
+	ENDBR
+	pushq	%rax
+	pushq	%rcx
+	pushq	%rdx
+	/* x2APIC mode: MSR 0x80b (APIC_EOI) = 0 */
+	movl	$0x80b, %ecx
+	xorl	%eax, %eax
+	xorl	%edx, %edx
+	wrmsr
+	popq	%rdx
+	popq	%rcx
+	popq	%rax
+	iretq
+SYM_CODE_END(x86_preserved_apic_eoi_stub)
+
+/*
+ * arch_cpu_preserved_call_on_stack - Switch stack and call function
+ * @cpu: CPU ID (%rdi)
+ * @stack: Target stack top (%rsi)
+ * @fn: Function pointer to invoke (%rdx)
+ */
+SYM_CODE_START(arch_cpu_preserved_call_on_stack)
+	pushq	%rbp
+	movq	%rsp, %rbp
+	pushq	%r12
+
+	movq	%rsp, %r12	/* save old stack pointer */
+	movq	%rsi, %rsp	/* switch to target stack */
+
+	call	*%rdx		/* call fn(cpu) */
+
+	movq	%r12, %rsp	/* restore old stack pointer */
+	popq	%r12
+	leave
+	ret
+SYM_CODE_END(arch_cpu_preserved_call_on_stack)
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 2438b89a4620..9b8b70057bcf 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -155,6 +155,7 @@ SECTIONS
 #endif
 		ALIGN_ENTRY_TEXT_END
 
+		CPU_PRESERVED_TEXT
 		TEXT_TEXT
 		SCHED_TEXT
 		LOCK_TEXT
@@ -194,6 +195,7 @@ SECTIONS
 #endif
 
 		PAGE_ALIGNED_DATA(PAGE_SIZE)
+		CPU_PRESERVED_DATA
 
 		CACHE_HOT_DATA(L1_CACHE_BYTES)
 
-- 
2.55.0.1082.g2b9226bbc0-goog


