Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E36C982D8
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8AnhgWYPBDTyEtljyN9gDdKnSFvI32a3E+pDg291Dw4=; b=Ip4p+wGbA3CCLAJ8XsF4tM/WC+
	32zp+W2/ijLZq78J+9hfxDJljWLPe34uELK0w7undSqsJ2X/sogmkl/LRQtQH6TZ2rMs2jPC5B6oB
	CLdLCUbZjY47ofHgssy2MFU9klYfIOUzFhoVEkZsk5oER8IZP5EpdSsRc753Up/LI5kgo+LJQUO0i
	f4/vC4or9lTGhjbKyKBcZE/lxRCJuPIgutbtwlskU8TsNaGf6vvJUUOkajzB6mPwyt24csR8Uu1eX
	q664bCoJ2ixfUlI3N+eZRUrMzTSVuXvnSjJuSTXYX+7E0YincB5Z8Vs1e1HO01cHLap32hY8hUBCC
	4uJQpM5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O59-00000000OE4-2Axd;
	Sun, 20 Sep 2026 20:24:15 +0000
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8NP1-00000000JTZ-35NA
	for kexec@lists.infradead.org;
	Sun, 20 Sep 2026 19:40:44 +0000
Received: by mail-yx2-x11.google.com with SMTP id 956f58d0204a3-66e4aac9321so2007893d50.3
        for <kexec@lists.infradead.org>; Sun, 20 Sep 2026 12:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789933243; x=1790538043; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8AnhgWYPBDTyEtljyN9gDdKnSFvI32a3E+pDg291Dw4=;
        b=NNHd/1ZRpKbU+hTb/6mFPxHwS47yhQSPq7USEaomOYeQs/CGusNmFnatSIlKSaWGPV
         DHWm/zB/wo5GJQHjDvoB1Z4WUeg5aFtxXYWXfa14bz+dGyW2UhFC6dRHgWuypH3befoe
         ON3fsts+aHD9dkhlmvQW/QDuoto0gazd2E9aaDfTn5r6PcvsUqHPo6xWpwJ5AdMmITuj
         YnpZQVOivxL9BiHeT0U1Wq8NcrU8rg1Cciz9Mr8GNLpbuTFde7bSV2K0LObyqGYF0v+s
         fUmdNov5sLir8RWTagdoPuj/ds5WnsoLEoD93Z2TkahYAwpuLbT4klq2gMd7Ct+i112w
         Q7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933243; x=1790538043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8AnhgWYPBDTyEtljyN9gDdKnSFvI32a3E+pDg291Dw4=;
        b=ba8Xe9M1+h13/CMERsVfSuLdsUUVCk7J+mjL/dcyIjXSkoJqrsTzc0KsX1OdTwf8zD
         V6H7QAppuCynLqKMlxT0IMTdd16nFa8l8BP5mys/DFIkGNUxKu5whVFaYMezpYue65rf
         CMWLQD/fXplqkCnsFjZ+rerg2+6JToxEhsdliOy/uGYKHxvvg8uaGNyXk2B8PP0VKbLe
         TocyaDMQILh0tV2Fh3GySUdh9+Su1zrD4CcbrF7BwWp9/J+5UXj3v0zDkybhNPn3EG7q
         yinro0UA7BvaezF3ovZqYb2u/diqh0X+VD1oeBu+LmFG83ZQ4JZjcfQpw8+gpKC0qWaY
         znGQ==
X-Forwarded-Encrypted: i=1; AKwUvBw/r2MLy5mTW3RaGRWvyfj2eUQcYFWI8BL0dO0p1eJ6J4+VVM+gy7FOv3/m0UGa50SXdRSc5g==@lists.infradead.org
X-Gm-Message-State: AFuF++l8nER8VDmyHQh6VNPkL2IlEQAigZGOD3dbdU4UDkHFzv003vnQ
	EfDJUUrTfEkw6KqzoRHrdxxEuCH7xUCQtO+1nVPVL4M32B53HYSeHXKEzFfR6d0BNjw=
X-Gm-Gg: AYBFou1F5ntSU3kjmnOI8Osc50peOpgpWTNtifVKKRq9fRfBPo6/CS0WZMF3XTpz6EO
	eR5/o2JXo5djDIarigTdIcJqKn8ijCzaADTWSmCcTwSlXNQaJNqSnGM0CH7nO9AyhCOh4tNFMlQ
	Att9RWXXBXR8QxCO/FxQsrkSJdkNzJM6D2pxZ9g3r7xeRcmHDYkkCABNgZxLnOC+KLYhsU0ndCX
	9W0gspw3fAciw/Ualm48V8g/YC/KMrOU//k7VSERu+Sx3AqDR10CXEnOcxdY2T6rnbcvNWGFtzt
	hzUKaT2MLX+hlklTWi+y6y71JVHyMFQpZZob4ComoiGbR0Cc5bIw5GZuTTYX1dRRiMjjUo0xKph
	TC33urbGvpKXN5ptWQkESjH7z5FgQw1f8YvaRars24T/ZDkUQcSIelb27LNqY7sv6V1BxpzLPKC
	ceb+goocdWR9p4yyBwpfI642yWTxyCM3Jjl16o3jYwhabdgZZphAPC8J12S0ENW84QBeCPK6uRz
	1/MXnQUSDaKrGySEj9Dz3yTdwohE7fwV5AyjNFEMXjYJQXVmj0ViIlquLxvwlUfa542aqqbQiqr
	wCyDge84125qhgCQqIs=
X-Received: by 2002:a05:690e:b88:b0:671:1a19:2dc with SMTP id 956f58d0204a3-6717fc6196emr2697319d50.11.1789933242627;
        Sun, 20 Sep 2026 12:40:42 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-672991445desm2616083d50.20.2026.09.20.12.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:40:42 -0700 (PDT)
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
Subject: [RFC PATCH 38/46] KVM: VMX: Implement Caretaker VMX VMCS lifecycle and exit dispatch
Date: Sun, 20 Sep 2026 15:36:42 -0400
Message-ID: <20260920193650.3373435-39-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
References: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_124043_847624_622948E9 
X-CRM114-Status: GOOD (  20.01  )
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

Implement Intel VMX Caretaker VMCS setup, exit decoding, and guest
entry/exit loop in arch/x86/kvm/vmx/caretaker.c.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/x86/kvm/vmx/caretaker.c         | 340 +++++++++++++++++++++++++++
 arch/x86/kvm/vmx/caretaker_vmenter.S |  12 +-
 arch/x86/kvm/vmx/vmx.c               |   2 +-
 arch/x86/kvm/vmx/vmx.h               |   1 +
 4 files changed, 347 insertions(+), 8 deletions(-)
 create mode 100644 arch/x86/kvm/vmx/caretaker.c

diff --git a/arch/x86/kvm/vmx/caretaker.c b/arch/x86/kvm/vmx/caretaker.c
new file mode 100644
index 000000000000..47b4743650e5
--- /dev/null
+++ b/arch/x86/kvm/vmx/caretaker.c
@@ -0,0 +1,340 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Intel VMX Caretaker Standalone Execution Engine
+ *
+ * Copyright (c) 2026, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ *
+ * Runs the Intel VMX guest execution loop in an isolated, KHO-preserved memory
+ * page that remains alive and executing across kexec relocation and
+ * kernel handover.
+ */
+
+#include <linux/cleanup.h>
+#include <linux/cpu_preserve.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/kexec.h>
+#include <linux/kexec_handover.h>
+#include <linux/kvm_host.h>
+#include <linux/objtool.h>
+#include <linux/oncore.h>
+
+#include <asm/apic.h>
+#include <asm/cpu_entry_area.h>
+#include <asm/desc.h>
+#include <asm/fixmap.h>
+#include <linux/pgtable.h>
+#include <linux/processor.h>
+#include <asm/segment.h>
+#include <asm/set_memory.h>
+#include <asm/virt.h>
+#include <asm/vmx.h>
+
+#include "../caretaker.h"
+#include "caretaker.h"
+#include "vmx.h"
+#include "vmx_ops.h"
+#include "x86.h"
+#include "x86_ops.h"
+
+static int vmx_caretaker_init_page(struct caretaker_vmx_page *cvp,
+				   struct kvm_vcpu *vcpu);
+STACK_FRAME_NON_STANDARD(vmx_caretaker_init_page);
+
+static int vmx_caretaker_init_page(struct caretaker_vmx_page *cvp,
+				   struct kvm_vcpu *vcpu)
+{
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	u64 basic_msr, misc_msr;
+	int ret;
+
+	if (!vmx->vmcs01.vmcs)
+		return -EINVAL;
+
+	ret = kvm_x86_caretaker_init_common_page(&cvp->common, vcpu, sizeof(*cvp));
+	if (ret)
+		return ret;
+	cvp->common.abi.vmcs_pa = virt_to_phys(vmx->vmcs01.vmcs);
+	cvp->vmxon_pa = virt_to_phys(cvp->vmxon_area);
+
+	memset(cvp->vmxon_area, 0, PAGE_SIZE);
+	basic_msr = native_rdmsrq(MSR_IA32_VMX_BASIC);
+	*(u32 *)cvp->vmxon_area = vmx_basic_vmcs_revision_id(basic_msr);
+
+	if (!rdmsrq_safe(MSR_IA32_VMX_MISC, &misc_msr))
+		cvp->timer_shift = vmx_misc_preemption_timer_rate(misc_msr);
+	else
+		cvp->timer_shift = VMX_PREEMPTION_TIMER_SHIFT;
+
+	cvp->ple_supported = cpu_has_vmx_ple();
+
+	vcpu_load(vcpu);
+
+	cvp->common.kernel_gs_base = vmx->msr_guest_kernel_gs_base;
+	kvm_msr_read(vcpu, MSR_STAR, &cvp->star);
+	kvm_msr_read(vcpu, MSR_LSTAR, &cvp->lstar);
+	kvm_msr_read(vcpu, MSR_SYSCALL_MASK, &cvp->fmask);
+
+	/* Save current guest control registers from KVM */
+	cvp->common.cr0 = kvm_read_cr0(vcpu);
+	cvp->common.cr3 = kvm_read_cr3(vcpu);
+	cvp->common.cr4 = kvm_read_cr4(vcpu);
+	cvp->common.efer = vcpu->arch.efer;
+
+	cvp->common.last_exit_rip = kvm_rip_read(vcpu);
+	cvp->common.last_exit_rsp = kvm_rsp_read(vcpu);
+	cvp->common.last_exit_rflags = kvm_get_rflags(vcpu);
+
+	if (kvm_host.efer & EFER_NX)
+		cvp->common.efer |= EFER_NX;
+
+	vcpu_put(vcpu);
+
+	if (vmx->loaded_vmcs)
+		loaded_vmcs_clear(vmx->loaded_vmcs);
+
+	return 0;
+}
+
+void vmx_caretaker_init(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	struct caretaker_vmx_page *cvp;
+	struct kvm_caretaker_arch_ser *abi;
+
+	cvp = kho_alloc_preserve(sizeof(*cvp));
+	if (IS_ERR(cvp)) {
+		pr_err("caretaker vmx: failed to allocate preserved page\n");
+		return;
+	}
+
+	if (vmx_caretaker_init_page(cvp, vcpu))
+		goto err_free;
+
+	abi = &cvp->common.abi;
+	if (vmx->vmcs01.vmcs &&
+	    kvm_x86_caretaker_preserve_page(abi, virt_to_page(vmx->vmcs01.vmcs)))
+		goto err_free;
+	if (vmx->vmcs01.msr_bitmap &&
+	    kvm_x86_caretaker_preserve_page(abi, virt_to_page(vmx->vmcs01.msr_bitmap)))
+		goto err_free;
+	if (vmx->pml_pg &&
+	    kvm_x86_caretaker_preserve_page(abi, vmx->pml_pg))
+		goto err_free;
+	if (vmx->ve_info &&
+	    kvm_x86_caretaker_preserve_page(abi, virt_to_page(vmx->ve_info)))
+		goto err_free;
+
+	return;
+
+err_free:
+	kvm_x86_caretaker_unpreserve_pages(&cvp->common.abi);
+	vcpu->caretaker.cb = NULL;
+	kho_unpreserve_free(cvp);
+}
+
+static __cpu_preserved_text void vmx_caretaker_disarm_timer(void *page)
+{
+	u32 pin = (u32)vmx_vmread(PIN_BASED_VM_EXEC_CONTROL);
+
+	if (pin & PIN_BASED_VMX_PREEMPTION_TIMER) {
+		vmx_vmwrite(PIN_BASED_VM_EXEC_CONTROL,
+			    pin & ~PIN_BASED_VMX_PREEMPTION_TIMER);
+	}
+}
+
+static inline unsigned long vmx_caretaker_read_cr0(void)
+{
+	unsigned long mask = vmx_vmread(CR0_GUEST_HOST_MASK);
+
+	return (vmx_vmread(CR0_READ_SHADOW) & mask) |
+	       (vmx_vmread(GUEST_CR0) & ~mask);
+}
+
+static inline unsigned long vmx_caretaker_read_cr4(void)
+{
+	unsigned long mask = vmx_vmread(CR4_GUEST_HOST_MASK);
+
+	return (vmx_vmread(CR4_READ_SHADOW) & mask) |
+	       (vmx_vmread(GUEST_CR4) & ~mask);
+}
+
+static inline u64 vmx_caretaker_read_efer(void)
+{
+	u64 efer = vmx_vmread(GUEST_IA32_EFER);
+
+	if (!efer)
+		efer = native_rdmsrq(MSR_EFER);
+	if (vmx_vmread(VM_ENTRY_CONTROLS) & VM_ENTRY_IA32E_MODE)
+		efer |= EFER_LMA | EFER_LME;
+	return efer;
+}
+
+void __cpu_preserved_text
+vmx_caretaker_decode_exit(void *page,
+			  struct kvm_caretaker_exit *exit)
+{
+	struct caretaker_vmx_page *cvp = page;
+	u32 insn_len = (u32)vmx_vmread(VM_EXIT_INSTRUCTION_LEN);
+	u16 exit_reason = (u16)vmx_vmread(VM_EXIT_REASON);
+	u64 qual = vmx_vmread(EXIT_QUALIFICATION);
+	u64 rip = vmx_vmread(GUEST_RIP);
+
+	cvp->common.last_exit_rip = rip;
+	cvp->common.last_exit_rsp = vmx_vmread(GUEST_RSP);
+	cvp->common.last_exit_rflags = vmx_vmread(GUEST_RFLAGS);
+	cvp->common.cr3 = vmx_vmread(GUEST_CR3);
+	cvp->common.cr0 = vmx_caretaker_read_cr0();
+	cvp->common.cr4 = vmx_caretaker_read_cr4();
+
+	exit->rip = rip;
+	exit->insn_len = insn_len;
+	exit->raw_reason = exit_reason;
+	exit->type = KVM_CARETAKER_EXIT_ARCH;
+
+	switch (exit_reason) {
+	case EXIT_REASON_IO_INSTRUCTION: {
+		u16 port = (u16)(qual >> VMX_IO_PORT_SHIFT);
+
+		if (port >= COM1_PORT_BASE && port <= COM1_PORT_END) {
+			exit->type = KVM_CARETAKER_EXIT_CONSOLE;
+			exit->mmio_io.addr = port;
+			exit->mmio_io.is_write = !(qual & VMX_IO_DIRECTION_BIT);
+			exit->mmio_io.size = (u8)((qual & VMX_IO_SIZE_MASK) + 1);
+			exit->mmio_io.is_mmio = false;
+			exit->mmio_io.val_ptr = &cvp->common.rax;
+		}
+		break;
+	}
+	case EXIT_REASON_HLT:
+		exit->type = KVM_CARETAKER_EXIT_IDLE;
+		break;
+	case EXIT_REASON_PAUSE_INSTRUCTION:
+		exit->type = KVM_CARETAKER_EXIT_IDLE;
+		exit->insn_len = insn_len ? insn_len : PAUSE_INSN_LEN;
+		break;
+	case EXIT_REASON_CPUID:
+		exit->type = KVM_CARETAKER_EXIT_CPUID;
+		break;
+	case EXIT_REASON_VMCALL:
+		/*
+		 * Do not write a return value.  The Caretaker cannot run the
+		 * hypercall, and reporting success for something like
+		 * KVM_HC_SEND_IPI or a PV TLB flush is worse than not
+		 * answering at all.  CROSS_VCPU now stalls, so the guest
+		 * stays parked on the VMCALL with RAX untouched until the
+		 * incoming kernel services it.
+		 */
+		exit->type = KVM_CARETAKER_EXIT_CROSS_VCPU;
+		exit->insn_len = insn_len ? insn_len : VMCALL_INSN_LEN;
+		break;
+	case EXIT_REASON_MSR_READ:
+		exit->type = KVM_CARETAKER_EXIT_MSR;
+		exit->msr.msr = (u32)cvp->common.rcx;
+		exit->msr.is_write = false;
+		break;
+	case EXIT_REASON_MSR_WRITE:
+		exit->type = KVM_CARETAKER_EXIT_MSR;
+		exit->msr.msr = (u32)cvp->common.rcx;
+		exit->msr.is_write = true;
+		break;
+	case EXIT_REASON_RDTSC:
+		exit->type = KVM_CARETAKER_EXIT_RDTSC;
+		break;
+	case EXIT_REASON_EPT_VIOLATION:
+		exit->type = KVM_CARETAKER_EXIT_UNHANDLED;
+		break;
+	case EXIT_REASON_PREEMPTION_TIMER:
+		exit->type = KVM_CARETAKER_EXIT_PREEMPT_TIMER;
+		exit->insn_len = 0;
+		vmx_caretaker_disarm_timer(cvp);
+		break;
+	case EXIT_REASON_EOI_INDUCED:
+	case EXIT_REASON_APIC_WRITE:
+	case EXIT_REASON_APIC_ACCESS:
+	case EXIT_REASON_INTERRUPT_WINDOW:
+		exit->type = KVM_CARETAKER_EXIT_CROSS_VCPU;
+		exit->insn_len = 0;
+		break;
+	case EXIT_REASON_EXTERNAL_INTERRUPT:
+	case EXIT_REASON_EXCEPTION_NMI:
+	case EXIT_REASON_INIT_SIGNAL:
+	case EXIT_REASON_SIPI_SIGNAL:
+		exit->type = KVM_CARETAKER_EXIT_PREEMPT_TIMER;
+		exit->insn_len = 0;
+		break;
+	default:
+		break;
+	}
+}
+
+void __cpu_preserved_text
+vmx_caretaker_init_host_vmcs(struct caretaker_vmx_page *cvp)
+{
+	u64 fs_base = 0, gs_base = 0;
+	unsigned long pin, cpu_ctl;
+
+	phys_addr_t host_cr3 = cvp->common.host_cr3;
+
+	/* Configure Host Controls */
+	vmx_vmwrite(HOST_CR0, read_cr0());
+	vmx_vmwrite(HOST_CR4, __read_cr4());
+	if (!host_cr3) {
+		struct cpu_preserved_stack_context *sctx = cpu_preserved_get_stack_context();
+
+		if (sctx && sctx->session_pgd_pa)
+			host_cr3 = sctx->session_pgd_pa;
+		else
+			host_cr3 = x86_caretaker_pgd_pa;
+	}
+	if (host_cr3)
+		vmx_vmwrite(HOST_CR3, host_cr3);
+	vmx_vmwrite(HOST_RSP, (unsigned long)&cvp->common.stack[CXP_STACK_SIZE]);
+	vmx_vmwrite(HOST_RIP, (unsigned long)&vmx_caretaker_exit_handler);
+
+	/* Configure Host Selectors */
+	vmx_vmwrite(HOST_CS_SELECTOR, __KERNEL_CS);
+	vmx_vmwrite(HOST_SS_SELECTOR, __KERNEL_DS);
+	vmx_vmwrite(HOST_DS_SELECTOR, __KERNEL_DS);
+	vmx_vmwrite(HOST_ES_SELECTOR, __KERNEL_DS);
+	vmx_vmwrite(HOST_FS_SELECTOR, 0);
+	vmx_vmwrite(HOST_GS_SELECTOR, 0);
+	vmx_vmwrite(HOST_TR_SELECTOR, GDT_ENTRY_TSS * 8);
+
+	/* Configure Host Bases */
+	fs_base = native_rdmsrq(MSR_FS_BASE);
+	gs_base = native_rdmsrq(MSR_GS_BASE);
+	vmx_vmwrite(HOST_FS_BASE, fs_base);
+	vmx_vmwrite(HOST_GS_BASE, gs_base);
+	vmx_vmwrite(HOST_TR_BASE, (unsigned long)&cvp->common.tss);
+	vmx_vmwrite(HOST_GDTR_BASE, (unsigned long)&cvp->common.gdt[0]);
+	vmx_vmwrite(HOST_IDTR_BASE, (unsigned long)&caretaker_x86_idt[0]);
+
+	/* Configure PIN and CPU execution controls */
+	pin = vmx_vmread(PIN_BASED_VM_EXEC_CONTROL);
+	pin |= (PIN_BASED_EXT_INTR_MASK | PIN_BASED_NMI_EXITING);
+	pin &= ~(PIN_BASED_VMX_PREEMPTION_TIMER | PIN_BASED_POSTED_INTR);
+	vmx_vmwrite(PIN_BASED_VM_EXEC_CONTROL, pin);
+
+	cpu_ctl = vmx_vmread(CPU_BASED_VM_EXEC_CONTROL);
+	cpu_ctl &= ~(CPU_BASED_INTR_WINDOW_EXITING |
+		     CPU_BASED_NMI_WINDOW_EXITING);
+	cpu_ctl |= (CPU_BASED_HLT_EXITING |
+		    CPU_BASED_PAUSE_EXITING |
+		    CPU_BASED_MWAIT_EXITING |
+		    CPU_BASED_MONITOR_EXITING |
+		    CPU_BASED_UNCOND_IO_EXITING);
+
+	if (cvp && cvp->ple_supported &&
+	    (cpu_ctl & CPU_BASED_ACTIVATE_SECONDARY_CONTROLS)) {
+		unsigned long sec_ctl = vmx_vmread(SECONDARY_VM_EXEC_CONTROL);
+
+		sec_ctl |= SECONDARY_EXEC_PAUSE_LOOP_EXITING;
+		vmx_vmwrite(SECONDARY_VM_EXEC_CONTROL, sec_ctl);
+		vmx_vmwrite(PLE_GAP, 4096);
+		vmx_vmwrite(PLE_WINDOW, 4096);
+	}
+	vmx_vmwrite(CPU_BASED_VM_EXEC_CONTROL, cpu_ctl);
+}
+
diff --git a/arch/x86/kvm/vmx/caretaker_vmenter.S b/arch/x86/kvm/vmx/caretaker_vmenter.S
index ff135cba854d..51781e3e61e2 100644
--- a/arch/x86/kvm/vmx/caretaker_vmenter.S
+++ b/arch/x86/kvm/vmx/caretaker_vmenter.S
@@ -26,8 +26,8 @@ SYM_TYPED_FUNC_START(vmx_caretaker_enter)
 	CARETAKER_PUSH_HOST_REGS
 	movq %rsp, CXP_STACK_ORIG(%rdi)
 
-	/* Switch to private preserved stack */
-	movq CXP_STACK_TOP(%rdi), %rsp
+	/* Switch to private preserved stack at top of caretaker_x86_page */
+	leaq PAGE_SIZE(%rdi), %rsp
 
 	/* Activate VMCS on this pCPU */
 	vmptrld CXP_VMCS_PA(%rdi)
@@ -60,11 +60,10 @@ SYM_TYPED_FUNC_START(vmx_caretaker_enter)
 	vmresume
 	vmlaunch
 
-	/* If both fail, record error and return */
+	/* If both fail, return error in %rax */
 	popq %rdi
 	mov $VMCS_VM_INSTRUCTION_ERROR, %eax
 	vmread %rax, %rax
-	movq %rax, CXP_LAST_EXIT_CODE(%rdi)
 	btsq $31, %rax
 	jmp .Lvmx_ret
 SYM_FUNC_END(vmx_caretaker_enter)
@@ -73,15 +72,14 @@ SYM_FUNC_START(vmx_caretaker_exit_handler)
 	ENDBR
 	/*
 	 * Hardware jumps here on VM-Exit with:
-	 * RSP = HOST_RSP (CXP_STACK_TOP)
+	 * RSP = HOST_RSP (top of 4 KB struct caretaker_x86_page)
 	 * CR3 = HOST_CR3
 	 */
 	pushq %rdi
 
-	/* Recompute CVP pointer from RSP: CVP = (RSP & PAGE_MASK) - CXP_STACK_OFFSET */
+	/* Recover CVP base from RSP: stack lives in the upper half of page 0 */
 	movq %rsp, %rdi
 	andq $PAGE_MASK, %rdi
-	subq $CXP_STACK_OFFSET, %rdi
 
 	/* Save guest GPRs into CVP */
 	CARETAKER_SAVE_GPRS %rdi
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 612ab07d4100..48b6e69f99bf 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -839,7 +839,7 @@ static void __loaded_vmcs_clear(void *arg)
 	loaded_vmcs->launched = 0;
 }
 
-static void loaded_vmcs_clear(struct loaded_vmcs *loaded_vmcs)
+void loaded_vmcs_clear(struct loaded_vmcs *loaded_vmcs)
 {
 	int cpu = loaded_vmcs->cpu;
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index dc8517f15bc4..5cb64ae4c8ee 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -342,6 +342,7 @@ static __always_inline u32 vmx_get_intr_info(struct kvm_vcpu *vcpu)
 }
 
 void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu);
+void loaded_vmcs_clear(struct loaded_vmcs *loaded_vmcs);
 int allocate_vpid(void);
 void free_vpid(int vpid);
 void vmx_set_constant_host_state(struct vcpu_vmx *vmx);
-- 
2.55.0.1082.g2b9226bbc0-goog


