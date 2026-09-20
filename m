Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF756C982F3
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y5wqvR/8Rgbn3Q8wmCLu7MA68JCRgtXzVIxWF4pI6Mc=; b=dbLC2UNesjQyDf7BAt/sAGh/E0
	wSbeHND+n7ttjgUyC29OFsy5DKvSmiB/MYs7yszkoL/2LeRcICNANy8Em+GGVrhIYFM0Tgb1gYwBm
	h0QLapGpUbkdcLvPIqJd6R+tpf/gD1TTgHk8Pda06RETN+eeLV8rhkdQhb4kwfI0pECddMb2vvlxW
	yfezgMfrbLCHbxk7mmSZmdGD9FbWf+b4sJF4jMcevKNhgyehnVK+Ey0tR3RNpnUcWyI3k8wnWqhc0
	iAYa9my2t/8smMRbj/AKIR4hWgm+qw4I17C8sSeIGUwVg0L+P/FvluFU0LZy57k/CkTsBNDL5eS3T
	UoVba78Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O59-00000000OD6-17Sh;
	Sun, 20 Sep 2026 20:24:15 +0000
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8NOw-00000000JRg-2IZa
	for kexec@lists.infradead.org;
	Sun, 20 Sep 2026 19:40:39 +0000
Received: by mail-yx2-x11.google.com with SMTP id 956f58d0204a3-66e4ab201f9so1873710d50.0
        for <kexec@lists.infradead.org>; Sun, 20 Sep 2026 12:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789933237; x=1790538037; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Y5wqvR/8Rgbn3Q8wmCLu7MA68JCRgtXzVIxWF4pI6Mc=;
        b=CkAWE7oEGGT1hhuNmiPrNsGFB9KQFYBOWuVco08gKsU7dFGRCm/OKJG4rUG/uIV/sm
         /bXedYeOn4TgpFBazFKxYJlClvamkVuUKwTlCOD6IXbj6/LWyJfL4gLKD5pZeWbDOnxm
         n9h9UZ43DykTVFC2ZsMrgV5yrAiC59wlX8hjc5QRJkp23fa9YI7+JOIsAiS5cbWc10J0
         9yYw+8JXwN7rp9E8FbQTSuy+VB9wBabeaZtpYvxo4XeKOOFlf2x4XaSM0m2r5BsjL08e
         QjUDm8eplfCcpBKL2MEDouZgMHX0PFakLBNxLLF9hHb4bAnFk7XNMiarjX54Dhqq0pKU
         gbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933237; x=1790538037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Y5wqvR/8Rgbn3Q8wmCLu7MA68JCRgtXzVIxWF4pI6Mc=;
        b=EH7ra0IcxiAB5oRVnf0tCfTmf11AjYjOozGC+TKHSC2EL3ZXZHeIRbRb7OmH0JP+5j
         CQriHj4AcbJmueWdB8MXaLq4UtGZW11TVJnIpMJmmEsUutT8aA1G67aGdrUdvlJAeVX4
         +BKQyE0CakAZi2QJf7HTpXxqGZPr9ljbieWhbWpYRhoSToikHmq+YUvMI5la1mHWat58
         ZtTZPCj4OClQEy7AUOp209a1ZbIzAw6ONfgB0NQaQ9DdrSflwSlkNWTyFix4/+0a+TTP
         w+PqSoEPBHVh84YsAAScE7RxltnVuPBnny+0zLxLJuz5wwaomUOKO8DhaHBcDTV3sKks
         PjbQ==
X-Forwarded-Encrypted: i=1; AKwUvByqVf6w7aCDe72fXv9jH5MxFFUc5FRwQjI0crAIFjxhR8NgFV5wCEr3bLHSXPKNdDCTf8YcOQ==@lists.infradead.org
X-Gm-Message-State: AFuF++kpRKrwn8vsBYcpCVivjMofwxWghiZ33TxyPP2hQYChFp0rdGzQ
	vzzNsHBJgXvV8P66RnexkNShPgWcUkKIfOFBjKDc2jtPlHUDLwzxmUYmCGUEV5wJuZ8=
X-Gm-Gg: AYBFou1JXenGDWm7BFACoNQ/4qfTpGaI7e6EcgHWOyPJb8mp2PoJZSJEd8xLlSQpQLv
	rcVXqr0DPlM9YsTqXmwMpAzUVmjJeWWiuVcf4goUbvS+GHhKwJ+ePUoF7m9jPfvpfs2oWeBpjhu
	D9GZxAftGi18KBhsSRqZGSXwnFpb3xKmpQ1/7GQWkgo5V1aH+ss5MjwDskslxC8sdQsE8tiEyYM
	HvEFJAhisU+UerocCFlIAzfXt9008ey0aLMm7W3J8reEMsnF1Ta2R5MHDh/HX2GVj3d8o1feKE4
	6os+BswPNx8O9D/F5M9yx4md7jgl6lOY2MpHWNUXN4sQ47jPE5oE3LBpZQI6S0ylY9yKaUw3uQP
	zrKUC5dXc06IuXXtmHRwmitdQEZae0kTMH+ef1k8oga3wTfqekmvkO7442IYs8CmUw1iQZDy3DS
	SGrQFl7tBLLxt3HxlFAJY6WR5orh01pgu/xK6igyK70OT4pSaj2KVWzfnQJKM4gOTM27LRG93KS
	ksn27l1jN3smnQXCPxxnX/0o3nGIMU/LFLSU5voqmMwvvuGNdU46e2qCiaa/WsbRYKsoKcXccSf
	v28mG+icRvVtWsjwVmb/
X-Received: by 2002:a05:690e:4854:20b0:672:99e1:11f2 with SMTP id 956f58d0204a3-67299e11844mr878861d50.143.1789933237384;
        Sun, 20 Sep 2026 12:40:37 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-672990aada0sm2671022d50.9.2026.09.20.12.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:40:36 -0700 (PDT)
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
Subject: [RFC PATCH 37/46] KVM: VMX: Add Caretaker VMX assembly guest entry/exit routine and helpers
Date: Sun, 20 Sep 2026 15:36:41 -0400
Message-ID: <20260920193650.3373435-38-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
References: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_124038_603318_0B0CA9D1 
X-CRM114-Status: GOOD (  14.57  )
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

Add arch/x86/kvm/vmx/caretaker_vmenter.S and caretaker.h for standalone
Intel VMX VMLAUNCH/VMRESUME world switch on preserved physical cores.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/x86/kvm/msrs.c                  |   2 +
 arch/x86/kvm/vmx/caretaker.h         |  78 +++++++++++++++++++
 arch/x86/kvm/vmx/caretaker_vmenter.S | 112 +++++++++++++++++++++++++++
 3 files changed, 192 insertions(+)
 create mode 100644 arch/x86/kvm/vmx/caretaker.h
 create mode 100644 arch/x86/kvm/vmx/caretaker_vmenter.S

diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index ae849e0b7d14..536c8d1959dc 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -882,11 +882,13 @@ int kvm_msr_write(struct kvm_vcpu *vcpu, u32 index, u64 data)
 {
 	return __kvm_set_msr(vcpu, index, data, true);
 }
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_msr_write);
 
 int kvm_msr_read(struct kvm_vcpu *vcpu, u32 index, u64 *data)
 {
 	return __kvm_get_msr(vcpu, index, data, true);
 }
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_msr_read);
 
 int __kvm_emulate_msr_read(struct kvm_vcpu *vcpu, u32 index, u64 *data)
 {
diff --git a/arch/x86/kvm/vmx/caretaker.h b/arch/x86/kvm/vmx/caretaker.h
new file mode 100644
index 000000000000..d4272e202e73
--- /dev/null
+++ b/arch/x86/kvm/vmx/caretaker.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+#ifndef __VMX_CARETAKER_H
+#define __VMX_CARETAKER_H
+
+#define VMCS_VM_INSTRUCTION_ERROR	0x4400
+
+#ifndef __ASSEMBLY__
+#include <linux/types.h>
+#include <linux/kvm_host.h>
+#include <linux/oncore.h>
+#include <asm/vmx.h>
+#endif
+
+#include "../caretaker.h"
+
+#ifndef __ASSEMBLY__
+#include <asm/desc.h>
+#include <linux/processor.h>
+
+/* Length of instructions */
+#define PAUSE_INSN_LEN			2
+#define VMCALL_INSN_LEN			3
+
+/* Exit qualification bitfields for I/O instructions (Intel SDM Vol 3C) */
+#define VMX_IO_SIZE_MASK		0x7
+#define VMX_IO_DIRECTION_BIT		BIT(3)
+#define VMX_IO_PORT_SHIFT		16
+
+/* Default VMX preemption timer shift (counts down every 2^5 TSC ticks) */
+#define VMX_PREEMPTION_TIMER_SHIFT	5
+
+struct caretaker_vmx_page {
+	struct caretaker_x86_page common;
+	/* Guest syscall state not automatically switched by VMCS */
+	u64 star;
+	u64 lstar;
+	u64 fmask;
+	u64 vmxon_pa;
+	u32 timer_shift;
+	u32 ple_supported;
+	u8 vmxon_area[PAGE_SIZE] __aligned(PAGE_SIZE);
+} __aligned(PAGE_SIZE);
+
+static inline unsigned long vmx_vmread(unsigned long field)
+{
+	unsigned long val;
+
+	asm volatile("vmread %1, %0" : "=r" (val) : "r" (field) : "cc");
+	return val;
+}
+
+static inline void vmx_vmwrite(unsigned long field, unsigned long val)
+{
+	asm volatile("vmwrite %1, %0" : : "r" (field), "r" (val) : "cc");
+}
+
+#ifdef CONFIG_KVM_CARETAKER
+int vmx_caretaker_enter(void *page);
+void vmx_caretaker_exit_handler(void);
+void vmx_caretaker_register(void);
+void vmx_caretaker_unregister(void);
+void vmx_caretaker_decode_exit(void *page,
+			       struct kvm_caretaker_exit *exit);
+void vmx_caretaker_init_host_vmcs(struct caretaker_vmx_page *cvp);
+void vmx_caretaker_init(struct kvm_vcpu *vcpu);
+#else
+static inline void vmx_caretaker_register(void) {}
+static inline void vmx_caretaker_unregister(void) {}
+static inline void vmx_caretaker_init(struct kvm_vcpu *vcpu) {}
+#endif
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __VMX_CARETAKER_H */
diff --git a/arch/x86/kvm/vmx/caretaker_vmenter.S b/arch/x86/kvm/vmx/caretaker_vmenter.S
new file mode 100644
index 000000000000..ff135cba854d
--- /dev/null
+++ b/arch/x86/kvm/vmx/caretaker_vmenter.S
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+#include <linux/linkage.h>
+#include <linux/cfi_types.h>
+#include <linux/objtool.h>
+#include <asm/asm.h>
+#include <asm/bitsperlong.h>
+#include <asm/kvm_vcpu_regs.h>
+#include <asm/nospec-branch.h>
+#include <asm/msr-index.h>
+#include <asm/page_types.h>
+#include "caretaker.h"
+#include "../caretaker_asm.h"
+
+.section .text.cpu_preserved, "ax"
+
+/**
+ * vmx_caretaker_enter - Low-level transition to VMX guest mode and back
+ * @cvp: Pointer to struct caretaker_vmx_page (%rdi)
+ */
+SYM_TYPED_FUNC_START(vmx_caretaker_enter)
+	ENDBR
+	CARETAKER_PUSH_HOST_REGS
+	movq %rsp, CXP_STACK_ORIG(%rdi)
+
+	/* Switch to private preserved stack */
+	movq CXP_STACK_TOP(%rdi), %rsp
+
+	/* Activate VMCS on this pCPU */
+	vmptrld CXP_VMCS_PA(%rdi)
+
+	/* Restore guest MSR_KERNEL_GS_BASE if valid/canonical */
+	movq CXP_KERNEL_GS_BASE(%rdi), %rax
+	movq %rax, %rdx
+	sarq $56, %rdx
+	incq %rdx
+	cmpq $1, %rdx
+	ja 2f
+	movl $MSR_KERNEL_GS_BASE, %ecx
+	movq CXP_KERNEL_GS_BASE(%rdi), %rax
+	movq %rax, %rdx
+	shrq $32, %rdx
+1:	wrmsr
+2:
+	_ASM_EXTABLE(1b, 2b)
+
+	/* Restore guest GPRs */
+	CARETAKER_RESTORE_GPRS %rdi
+
+	pushq %rdi
+	movq CXP_REG_RDI(%rdi), %rdi
+
+	/* Clear CPU microarchitectural buffers before guest entry */
+	CARETAKER_CLEAR_CPU_BUFFERS
+
+	/* Launch or resume */
+	vmresume
+	vmlaunch
+
+	/* If both fail, record error and return */
+	popq %rdi
+	mov $VMCS_VM_INSTRUCTION_ERROR, %eax
+	vmread %rax, %rax
+	movq %rax, CXP_LAST_EXIT_CODE(%rdi)
+	btsq $31, %rax
+	jmp .Lvmx_ret
+SYM_FUNC_END(vmx_caretaker_enter)
+
+SYM_FUNC_START(vmx_caretaker_exit_handler)
+	ENDBR
+	/*
+	 * Hardware jumps here on VM-Exit with:
+	 * RSP = HOST_RSP (CXP_STACK_TOP)
+	 * CR3 = HOST_CR3
+	 */
+	pushq %rdi
+
+	/* Recompute CVP pointer from RSP: CVP = (RSP & PAGE_MASK) - CXP_STACK_OFFSET */
+	movq %rsp, %rdi
+	andq $PAGE_MASK, %rdi
+	subq $CXP_STACK_OFFSET, %rdi
+
+	/* Save guest GPRs into CVP */
+	CARETAKER_SAVE_GPRS %rdi
+	popq CXP_REG_RDI(%rdi)
+
+	/* Stuff Return Stack Buffer to prevent guest RSB poisoning */
+	CARETAKER_FILL_RETURN_BUFFER %rax
+
+	/* Read guest MSR_KERNEL_GS_BASE */
+	movl $MSR_KERNEL_GS_BASE, %ecx
+	rdmsr
+	shlq $32, %rdx
+	orq %rax, %rdx
+	movq %rdx, CXP_KERNEL_GS_BASE(%rdi)
+
+	xorq %rax, %rax
+	jmp .Lvmx_ret
+
+.Lvmx_ret:
+	/* Restore caller stack */
+	movq CXP_STACK_ORIG(%rdi), %rsp
+
+	/* Restore host callee-saved registers */
+	CARETAKER_POP_HOST_REGS
+	ret
+SYM_FUNC_END(vmx_caretaker_exit_handler)
+STACK_FRAME_NON_STANDARD(vmx_caretaker_enter)
+STACK_FRAME_NON_STANDARD(vmx_caretaker_exit_handler)
-- 
2.55.0.1082.g2b9226bbc0-goog


