Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79EF1C982E6
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EGHl9G2Q8EmXvEbGL4UYBvGbfn4j1FoYD4wdklwyMj4=; b=eyktzgSTHnCRQYuNKnyKsbxUwM
	NnVtT4njqxFt7wSKDDltraMs2CeYojngTycm+bwNPXG5jPEgqeF+WTAwn/OeSlMLJygi7mBkHK9xo
	QTaQVbcA7zACew7BclcJKEPXzXs+d1rA/IMmvXgnS4wogFr/gf8WPIVDRSh5JHp+f/Xy8Mxo6XzO6
	hkjkW3bWgWncFvLILf5wDKI1nIPmX5w6sCLGbmBkjSENuVSkQOCn5KpSYJlmH3x5M64gCBH1qgi1/
	s6XQfJVCXGspNEbbGpvJaTNIZiRoJboIyubqRxzO8pjU0aX8noM3UtqeaMfjYf8Yq998dxvsYjW46
	nX28DaKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O57-00000000O8A-2UA2;
	Sun, 20 Sep 2026 20:24:13 +0000
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8NOc-00000000JML-4772
	for kexec@lists.infradead.org;
	Sun, 20 Sep 2026 19:40:20 +0000
Received: by mail-yx2-x10.google.com with SMTP id 00721157ae682-85d43db0c16so16391087b3.1
        for <kexec@lists.infradead.org>; Sun, 20 Sep 2026 12:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789933218; x=1790538018; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EGHl9G2Q8EmXvEbGL4UYBvGbfn4j1FoYD4wdklwyMj4=;
        b=SQsUTVyOBpqDSSvMZfv9eWVxx7FWesC40MIXSBnJNLckCMFSKJ+kfAPlH9RLNWi4M5
         YMRQJRdQCU3VylqnhCY1dZTcSrsUnI1Gsy8U6nOic7crtqH6plDluosNCbqfaw/E5dMX
         p/ygAqy3d7TVbjvIka9QAWh2nY/IOxxof+c/4e7En7ql+YtPb30YIZBL4ZUjUgNdgfVk
         Tqhl3Pio+AX1h4TYOEPcTPifZBNKiraaRiUXMBV7HYo9f1ic9cwz8T+ESCdpnaSKzo1A
         UuVzy0rYo+K+kBteelU/fjRazi22qQ0XyS0vUrKk4thbyCWHWDyYaYQ3lC03/hdgTJ0T
         mlIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933218; x=1790538018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EGHl9G2Q8EmXvEbGL4UYBvGbfn4j1FoYD4wdklwyMj4=;
        b=MkVNVxxiCwRVpHaTZRAKtXNxWlsKWaWhaptEqzvEYFgeivyase0MByMl/ZhXOPxGmR
         vwraUjMeveXFCFXay2EJZABg5svfGQxBZUKC/4yBk9kSBpAi5Vj4J7k5GTAGjiu0RSO4
         aOgrC6UkIGCrasvgeZByRd3J8AnQQ4hC722tpbxKXJG5FSrW/CCax4+qLaul/7VqtK4u
         e39jCJnWHTIMgKBhA74nUD8Tym4l0YSEEayiL8jiBcHmCPaOag79li1lpxodbnfrmR57
         QbiFe/h1K5sGwYe8bm/bwxjGTAWUKqwhvts8Et9BFcbSLaVMAdjSuqVf8Efmqf0bMhab
         xtnw==
X-Forwarded-Encrypted: i=1; AKwUvByD+Kq9rsI5+mhIAgfDJ9STNY4h7kaQOgHPmxCVrXGm+hk1bMaM3YZnzgcnivOKfAmbckx22A==@lists.infradead.org
X-Gm-Message-State: AFuF++lLlXQ+WV3Uhzp+CFqEOoKo/pmnOPNbliUSTBHs9v03VTl9Dxav
	Z2deTDKa7eDbwDDzexoLeQk3mhgpqdDcgMbHXniFeh1CC1tvZjF4n+5JhCtHHXs+FP4=
X-Gm-Gg: AYBFou0iEd+kvLxnOr+81RiLR4ChJGWZ1sETBg5KCNHvJh3eR3zd5PRUsaJA4Is/PNY
	xE1RzaE4LBZZ5Nk3lgf/zHGhMdjRmAV6v9cNRHgVP3zAK5vNyZzM/MLy2WEdo6Lq5Xq6dDbNLhX
	rK3Hybo4A/OsPerOKVdzffOjBX1jGlYpk2WHtXI2p7hbZK5ZjXnyRJnS2liZHEd6PABFyBaWzkA
	AMz4Pzf88IBhp3fmIG3R4QJZGj40U+Vl2WB2wA2TawwFh1svHRnmMv/VGKhIdxBrwXqIEJ0XLZu
	w2etY3G5853yU4cl1c26fzVM+F5WhnAkQhwOGUx1cpQIKxJUZdSL+n/i1Vf++f6g5jAv8ZZ8eyR
	NxocvMspfni+jf0QFrHYKqrLJ/vq7u7XYU4tDPHqXAK0Lq3xY8mx/vNbndhkISCKqWHqQw61oWi
	6D5NJu7tOH6TJg/HlBHqsAtQIgftrzX5X262i6nkTI5zfDo3zcduD7y08L5WTE0YyvOhf9gHW9R
	DTSqk8UU/9ZdeaEHi5ksFHznJJniyIfVm1c4YnO0RQsCq5JOMilusDrfHxMY8yQpBAY8m0egbRB
	+FkkT5RtRF9oa/BSpzvsLDWYm6ldjA==
X-Received: by 2002:a05:690e:12c4:b0:672:99e0:ebda with SMTP id 956f58d0204a3-67299e0ee4emr1603719d50.114.1789933217886;
        Sun, 20 Sep 2026 12:40:17 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a45d8fb9asm18884327b3.17.2026.09.20.12.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:40:16 -0700 (PDT)
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
Subject: [RFC PATCH 34/46] KVM: x86: Implement Caretaker LAPIC timer and interrupt injection
Date: Sun, 20 Sep 2026 15:36:38 -0400
Message-ID: <20260920193650.3373435-35-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
References: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_124019_050612_8A8C554F 
X-CRM114-Status: GOOD (  20.38  )
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

Implement standalone Caretaker LAPIC timer deadline programming and
interrupt injection helpers in arch/x86/kvm/caretaker.c.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/x86/kvm/caretaker.c | 312 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 312 insertions(+)
 create mode 100644 arch/x86/kvm/caretaker.c

diff --git a/arch/x86/kvm/caretaker.c b/arch/x86/kvm/caretaker.c
new file mode 100644
index 000000000000..9e0f20cbb137
--- /dev/null
+++ b/arch/x86/kvm/caretaker.c
@@ -0,0 +1,312 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ *
+ * x86 KVM Caretaker execution loop and hardware virtualization attachment.
+ */
+
+#include <linux/cpu.h>
+#include <linux/cpu_preserve.h>
+#include <linux/delay.h>
+#include <linux/kexec_handover.h>
+#include <linux/kho/abi/kvm.h>
+#include <linux/kvm_host.h>
+#include <linux/oncore.h>
+#include <linux/smp.h>
+#include <uapi/linux/serial_reg.h>
+
+#include <asm/apic.h>
+#include <asm/cpu_entry_area.h>
+#include <linux/cpu_preserve.h>
+#include <asm/desc.h>
+#include <asm/fpu/api.h>
+#include <asm/fixmap.h>
+#include <asm/irq_vectors.h>
+#include <linux/kvm_host.h>
+#include <asm/msr.h>
+#include <linux/sync_core.h>
+#include <asm/trapnr.h>
+#include <asm/virt.h>
+
+#include "caretaker.h"
+#include "cpuid.h"
+#include "lapic.h"
+#include "regs.h"
+#include "x86.h"
+
+/* Host register state saved around an on-core caretaker run. */
+struct caretaker_x86_host_state {
+	struct desc_ptr orig_idt;
+	unsigned long orig_cr2;
+	unsigned long orig_fs_base;
+	unsigned long orig_gs_base;
+	unsigned long orig_kernel_gs_base;
+	u64 orig_star;
+	u64 orig_lstar;
+	u64 orig_fmask;
+};
+
+/* Defined below their first use. */
+static void kvm_x86_caretaker_save_gprs(struct kvm_vcpu *vcpu, u64 *gprs);
+static void kvm_x86_caretaker_init_idt(gate_desc *idt);
+static void kvm_x86_caretaker_init_gdt_tss(struct desc_struct *gdt,
+					   struct x86_hw_tss *tss,
+					   unsigned long stack_top);
+
+/*
+ * A preserved page is handed over by physical address.  The SME/SEV C-bit is
+ * an encryption attribute, not part of the address, so strip it before
+ * forming a kernel virtual address.
+ *
+ * Both helpers are __always_inline because callers live in
+ * __cpu_preserved_text: an out-of-line copy would sit outside the section
+ * that survives the kexec.
+ */
+static __always_inline void *caretaker_pa_to_va(u64 pa)
+{
+	return phys_to_virt(__sme_clr(pa));
+}
+
+/* The control block is embedded in the vendor-agnostic caretaker page. */
+static __always_inline struct caretaker_x86_page *
+cxp_from_cb(struct kvm_caretaker_cb_ser *cb)
+{
+	return container_of(cb, struct caretaker_x86_page, abi.cb);
+}
+
+static const struct kvm_x86_caretaker_ops *kvm_x86_caretaker_ops __cpu_preserved_data;
+
+void kvm_x86_caretaker_register_ops(const struct kvm_x86_caretaker_ops *ops)
+{
+	WRITE_ONCE(kvm_x86_caretaker_ops, ops);
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_x86_caretaker_register_ops);
+
+void kvm_x86_caretaker_unregister_ops(const struct kvm_x86_caretaker_ops *ops)
+{
+	if (kvm_x86_caretaker_ops == ops)
+		WRITE_ONCE(kvm_x86_caretaker_ops, NULL);
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_x86_caretaker_unregister_ops);
+
+static bool caretaker_x86_has_tsc_deadline __cpu_preserved_data;
+static u32 caretaker_x86_lapic_timer_period __cpu_preserved_data;
+static u32 caretaker_x86_tsc_khz __cpu_preserved_data;
+gate_desc caretaker_x86_idt[IDT_ENTRIES] __caretaker_data __aligned(16);
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(caretaker_x86_idt);
+static bool caretaker_x86_idt_initialized;
+
+static void kvm_x86_caretaker_init_uart(struct caretaker_uart *uart)
+{
+	if (!uart)
+		return;
+
+	uart->lcr = UART_LCR_WLEN8;
+	uart->ier = 0x00;
+	uart->mcr = UART_MCR_DTR | UART_MCR_RTS;
+	uart->scr = 0x00;
+	uart->dll = 0x01;
+	uart->dlm = 0x00;
+}
+
+int kvm_x86_caretaker_preserve_page(struct kvm_caretaker_arch_ser *abi,
+				    struct page *page)
+{
+	int ret;
+
+	if (WARN_ON_ONCE(abi->nr_preserved_pages >= KVM_X86_CARETAKER_MAX_PAGES))
+		return -ENOSPC;
+
+	ret = kho_preserve_pages(page, 1);
+	if (ret)
+		return ret;
+
+	abi->preserved_pages_pa[abi->nr_preserved_pages++] = page_to_phys(page);
+	return 0;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_x86_caretaker_preserve_page);
+
+void kvm_x86_caretaker_unpreserve_pages(struct kvm_caretaker_arch_ser *abi)
+{
+	u32 i;
+
+	for (i = 0; i < abi->nr_preserved_pages; i++)
+		kho_unpreserve_pages(phys_to_page(__sme_clr(abi->preserved_pages_pa[i])), 1);
+	abi->nr_preserved_pages = 0;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_x86_caretaker_unpreserve_pages);
+
+int kvm_x86_caretaker_init_common_page(struct caretaker_x86_page *cxp,
+				       struct kvm_vcpu *vcpu,
+				       size_t full_page_size)
+{
+	struct oncore_session *sess;
+	phys_addr_t pgd_pa;
+	u32 apic_id;
+	int pcpu;
+	int ret;
+
+	if (!cxp || !vcpu)
+		return -EINVAL;
+
+	caretaker_x86_has_tsc_deadline = boot_cpu_has(X86_FEATURE_TSC_DEADLINE_TIMER);
+	caretaker_x86_lapic_timer_period = lapic_timer_period;
+	caretaker_x86_tsc_khz = tsc_khz;
+	cpu_preserved_clean(&caretaker_x86_has_tsc_deadline);
+	cpu_preserved_clean(&caretaker_x86_lapic_timer_period);
+	cpu_preserved_clean(&caretaker_x86_tsc_khz);
+	if (!caretaker_x86_idt_initialized) {
+		kvm_x86_caretaker_init_idt(caretaker_x86_idt);
+		cpu_preserved_clean_sz(caretaker_x86_idt, sizeof(caretaker_x86_idt));
+		caretaker_x86_idt_initialized = true;
+	}
+
+	memset(cxp, 0, full_page_size);
+
+	kvm_caretaker_init_common_vcpu(&cxp->vcpu, &cxp->abi.cb, vcpu, cxp,
+				       full_page_size, NULL, cxp);
+
+	pcpu = cxp->abi.cb.pcpu_id;
+
+	apic_id = apic->cpu_present_to_apicid(pcpu);
+	if (apic_id == BAD_APICID)
+		apic_id = pcpu;
+	cxp->abi.apic_id = apic_id;
+
+	kvm_x86_caretaker_init_uart(&cxp->uart);
+
+	cxp->save_guest_fpu = boot_cpu_has(X86_FEATURE_XSAVE) &&
+			      !fpstate_is_confidential(&vcpu->arch.guest_fpu);
+
+	/* Capture guest GPRs */
+	kvm_x86_caretaker_save_gprs(vcpu, &cxp->rax);
+
+	/* Preserved CR3 from session or fallback to global cpu_preserve page table */
+	sess = oncore_job_session(vcpu->caretaker.job);
+	pgd_pa = oncore_session_get_pgd_pa(sess);
+	cxp->host_cr3 = pgd_pa ? pgd_pa : x86_caretaker_pgd_pa;
+	cxp->cr3 = kvm_read_cr3(vcpu);
+	cxp->cr0 = kvm_read_cr0(vcpu);
+	cxp->cr4 = kvm_read_cr4(vcpu);
+	cxp->efer = vcpu->arch.efer;
+
+	/* Build KHO-preserved Host GDT and TSS */
+	kvm_x86_caretaker_init_gdt_tss(cxp->gdt, &cxp->tss,
+				       (unsigned long)&cxp->stack[CXP_STACK_SIZE]);
+
+	/* Preserve in-kernel local APIC register page across kexec */
+	if (vcpu->arch.apic && vcpu->arch.apic->regs) {
+		ret = kvm_x86_caretaker_preserve_page(&cxp->abi,
+						      virt_to_page(vcpu->arch.apic->regs));
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_x86_caretaker_init_common_page);
+
+static void kvm_x86_caretaker_save_gprs(struct kvm_vcpu *vcpu, u64 *gprs)
+{
+	gprs[0]  = kvm_register_read_raw(vcpu, VCPU_REGS_RAX);
+	gprs[1]  = kvm_register_read_raw(vcpu, VCPU_REGS_RBX);
+	gprs[2]  = kvm_register_read_raw(vcpu, VCPU_REGS_RCX);
+	gprs[3]  = kvm_register_read_raw(vcpu, VCPU_REGS_RDX);
+	gprs[4]  = kvm_register_read_raw(vcpu, VCPU_REGS_RSI);
+	gprs[5]  = kvm_register_read_raw(vcpu, VCPU_REGS_RDI);
+	gprs[6]  = kvm_register_read_raw(vcpu, VCPU_REGS_RBP);
+	gprs[7]  = kvm_register_read_raw(vcpu, VCPU_REGS_R8);
+	gprs[8]  = kvm_register_read_raw(vcpu, VCPU_REGS_R9);
+	gprs[9]  = kvm_register_read_raw(vcpu, VCPU_REGS_R10);
+	gprs[10] = kvm_register_read_raw(vcpu, VCPU_REGS_R11);
+	gprs[11] = kvm_register_read_raw(vcpu, VCPU_REGS_R12);
+	gprs[12] = kvm_register_read_raw(vcpu, VCPU_REGS_R13);
+	gprs[13] = kvm_register_read_raw(vcpu, VCPU_REGS_R14);
+	gprs[14] = kvm_register_read_raw(vcpu, VCPU_REGS_R15);
+}
+
+static void kvm_x86_caretaker_init_idt(gate_desc *idt)
+{
+	int v;
+
+	for (v = 0; v < IDT_ENTRIES; v++) {
+		bool has_err = (v == X86_TRAP_DF ||
+				(v >= X86_TRAP_TS && v <= X86_TRAP_PF) ||
+				v == X86_TRAP_AC || v == X86_TRAP_CP ||
+				v == X86_TRAP_VC || v == 30);
+		unsigned long handler = (v >= FIRST_EXTERNAL_VECTOR) ?
+			(unsigned long)&x86_preserved_apic_eoi_stub :
+			(has_err ? (unsigned long)&x86_preserved_iret_err_stub :
+				   (unsigned long)&x86_preserved_iret_stub);
+
+		pack_gate(&idt[v], GATE_INTERRUPT, handler, 0, 0, __KERNEL_CS);
+	}
+}
+
+static void kvm_x86_caretaker_init_gdt_tss(struct desc_struct *gdt,
+					   struct x86_hw_tss *tss,
+					   unsigned long stack_top)
+{
+	int k;
+
+	memcpy(gdt, get_current_gdt_ro(), sizeof(struct desc_struct) * GDT_ENTRIES);
+	memset(tss, 0, sizeof(*tss));
+	tss->sp0 = stack_top;
+	tss->io_bitmap_base = sizeof(*tss);
+	for (k = 0; k < ARRAY_SIZE(tss->ist); k++)
+		tss->ist[k] = stack_top;
+
+	caretaker_set_tss_desc(gdt, (unsigned long)tss, sizeof(struct x86_hw_tss) - 1);
+}
+
+__caretaker_text void kvm_x86_caretaker_arm_timer(u64 deadline_ticks)
+{
+	if (!deadline_ticks)
+		return;
+
+	if (caretaker_x86_has_tsc_deadline) {
+		u32 lvtt = LOCAL_TIMER_VECTOR | APIC_LVT_TIMER_TSCDEADLINE;
+
+		native_wrmsrq(APIC_BASE_MSR + (APIC_LVTT >> 4), lvtt);
+		native_wrmsrq(MSR_IA32_TSC_DEADLINE, deadline_ticks);
+	} else {
+		u64 now = rdtsc();
+		u64 delta_tsc = (deadline_ticks > now) ? (deadline_ticks - now) : 1;
+		u32 lvtt = LOCAL_TIMER_VECTOR;
+		u64 count;
+
+		if (caretaker_x86_tsc_khz != 0 && caretaker_x86_lapic_timer_period != 0) {
+			u64 period = caretaker_x86_lapic_timer_period;
+			u64 apic_khz = (period * HZ) / 1000ULL;
+
+			count = (delta_tsc * apic_khz) /
+				((u64)caretaker_x86_tsc_khz * 16ULL);
+		} else {
+			count = delta_tsc >> 4;
+		}
+		if (count == 0)
+			count = 1;
+		if (count > U32_MAX)
+			count = U32_MAX;
+
+		native_wrmsrq(APIC_BASE_MSR + (APIC_TDCR >> 4),
+			      APIC_TDR_DIV_16);
+		native_wrmsrq(APIC_BASE_MSR + (APIC_LVTT >> 4), lvtt);
+		native_wrmsrq(APIC_BASE_MSR + (APIC_TMICT >> 4), (u32)count);
+	}
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_x86_caretaker_arm_timer);
+
+__caretaker_text void kvm_x86_caretaker_disarm_timer(void)
+{
+	if (caretaker_x86_has_tsc_deadline)
+		native_wrmsrq(MSR_IA32_TSC_DEADLINE, 0);
+	else
+		native_wrmsrq(APIC_BASE_MSR + (APIC_TMICT >> 4), 0);
+
+	native_wrmsrq(APIC_BASE_MSR + (APIC_LVTT >> 4),
+		      APIC_LVT_MASKED | LOCAL_TIMER_VECTOR);
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_x86_caretaker_disarm_timer);
+
-- 
2.55.0.1082.g2b9226bbc0-goog


