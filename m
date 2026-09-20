Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9538C982F1
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LP9MAkgaZIZB/G//n4eIZm11yhyh4okaQRNwKZew5U0=; b=pDozgIGGOQMs62F0h9AzsyJBK0
	B4W9UIE5zB/K422XmQhvhFA1V1Y8rf0ETmg/1fGzDbouuOcZ1ikiiPiC8T6TDP5upbnMQhmhN0YaX
	af7QuDdQE78v/DRW6Nlps5HZI8SDCcAwjr/f7w8SEo7UzoYnUzkJDSQxSSKaabMPfxciXEdaTVhNY
	/FW/WQTCCyX/B6zb+zugYISzQEKhzomYCAvVh/VCVaXtY4ssQ6IlonAJrFHI59Ue08IBlexCZLNjB
	Cn+UmsCuXDu7t0/JLgJDWUhOkkbZvhVVN36xkOFeaXfOD1ZGCJa8fLKejMY3nfb4UJd1TUaCxt/mN
	Q/QjdfxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4M-00000000MG3-2sNh;
	Sun, 20 Sep 2026 20:23:26 +0000
Received: from mail-yx2-x0f.google.com ([2607:f8b0:4864:41::f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8NM7-00000000IWi-0cC7
	for kexec@lists.infradead.org;
	Sun, 20 Sep 2026 19:37:45 +0000
Received: by mail-yx2-x0f.google.com with SMTP id 00721157ae682-85d440939f0so15987477b3.2
        for <kexec@lists.infradead.org>; Sun, 20 Sep 2026 12:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789933062; x=1790537862; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LP9MAkgaZIZB/G//n4eIZm11yhyh4okaQRNwKZew5U0=;
        b=NSQlJE/rOIHcT/J9roXcQcmVpQW3jwpVetjLMusoEhguwaHAfoK06SnSLP4YUFbAKU
         QuQD395e9fXIhl3aBXQvkIQawSS/me2aFe2fs5uNlTdslQSU1ke/9mzn54QvFbdBsNPM
         BWcRc2sqtY19HYp6uX618BIYmH3XJrEVJ8CBI2Ay60CWRwMF7YIHEidEiL1Fc1vxeIeZ
         beygfV0dzPvCNqHAukGc5cBTZK+Ntpqz0tXDq5jUrav0pdfzpGlbfJq0EIPvPZHb/ael
         qh7JS8+96/385rsXcXPDnBhJli++BlKKA+Rc3TQcKJdIBOoXN/V0HuVOjM9PL6z55cba
         yOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933062; x=1790537862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LP9MAkgaZIZB/G//n4eIZm11yhyh4okaQRNwKZew5U0=;
        b=Mv/t0ZWbne1JcKcce1YbIjdvVB3ukC4KozsCdjl+fL3I0klUi2zfz7LkZlICV5l+V2
         G45ufxmdI38GNFcyNFoInEJUVxmSWXQZWl5f9co3KaUGda0Cy5IA/zcBegqMPO+pIsfg
         b9tUzBDvr5dyuYCGAp4B8Qr8+o7qMBJ3S06Nx7Nio4IoEJg71FrdNVFFQeVW4+N5IW1D
         yeif/Ty+glNYedwfuslpJkzBNTUt9oFYLMtYENWdybeAb9aJzCAcNGxix1K6+7YMtYdL
         4Q8LuisY+lGozT+pThJYxttFYD0KkKDJ1jbpzt8ONAROV/gFUPz+ZWOTGYq7M+6w/FIK
         3g1A==
X-Forwarded-Encrypted: i=1; AKwUvBy9dgIIa9yf9cyVXRjLPayedr2CKTTPdZGL1qYmd+HJg33fovINi86Ylv+PAWj16SPImcbEtg==@lists.infradead.org
X-Gm-Message-State: AFuF++nNUHiaF1suF83gapfHm0xbaEPwaZymc7nBFYltskCM6mG6siuQ
	/or1gc/X9rZlL8d0BiBlcjsuPitCxoyN/i//BeE/im5N1ng1kU5i9uQrRFaTlMxVKkA=
X-Gm-Gg: AYBFou16xptLZBV16kx9WMJb7edBGgqkEq98DP6GPbDVmAGq+Mzjbwc0/kF8ANaaj28
	GF4wijYwSJFbAQF0Gh3R5c4FK4qoY6p/eDJcAhd/rMhK9f1uLaLD51d6pqUNcilAXHlPPAXX7oT
	TMYzpBtMrbV0h2l421eU3AAOp5gzrTjPhHvLDyLdMWyPJ4SZxMWzMW9EJafTAKCteUp5RWQN7rE
	3CdY81wJYs2RyuNMA7EZzJVEjcBitOaBUOEdFqmU0whgxyCC6VievLZroPkPhy9Q3wX/5CLcLVv
	q3aPx5y7ARvmb3XhY0srsmsHYugBNQc/OyXb+Zgt0yvs81LyDOZpCGnJQdqyltw8B/eh+VFDcq7
	J4vZFveEFrT+Xxe+tErD1sMM2j2a3gnL5ozv2uJTH1lpcQVjpF1zoq93l1s0dgNXIu5lgTRKRab
	GSNwo9wbe7LsCt5rs/20Htr12jJSSpGbcGfsshipiZQ5KWoWi5fTWUAc0NfhRaZIP/J3iyd+jDN
	cSThuVMLjnjdCdbY4/+Iz8rlq/yfPUXOT5W2BBJgNCN9yNAZSLxF3OkQ4AvhmR/VV7YzEpgM1bQ
	suyk9enS3u+OeRbaFgs6
X-Received: by 2002:a05:690e:128f:b0:668:8dc0:bcc3 with SMTP id 956f58d0204a3-6717fadb1fcmr2667214d50.0.1789933061983;
        Sun, 20 Sep 2026 12:37:41 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a489aef57sm18632047b3.43.2026.09.20.12.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:37:41 -0700 (PDT)
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
Subject: [RFC PATCH 08/46] KVM: x86: Add x86 vCPU LUO preservation ABI and register helpers
Date: Sun, 20 Sep 2026 15:36:12 -0400
Message-ID: <20260920193650.3373435-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
References: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_123744_023790_8E9EA57C 
X-CRM114-Status: GOOD (  21.66  )
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

Add struct kvm_vcpu_arch_ser in include/linux/kho/abi/kvm_x86.h
and export x86 register and MSR access helpers for LUO state save/restore.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/x86/kvm/cpuid.c            |  4 +-
 arch/x86/kvm/cpuid.h            |  1 +
 arch/x86/kvm/msrs.c             | 15 ++++++
 arch/x86/kvm/msrs.h             |  2 +
 arch/x86/kvm/regs.c             |  8 ++--
 arch/x86/kvm/regs.h             |  4 ++
 arch/x86/kvm/x86.c              |  8 ++--
 arch/x86/kvm/x86.h              |  4 ++
 include/linux/kho/abi/kvm_x86.h | 84 +++++++++++++++++++++++++++++++++
 9 files changed, 120 insertions(+), 10 deletions(-)
 create mode 100644 include/linux/kho/abi/kvm_x86.h

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 851f151efb35..5aba16e0610b 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -507,8 +507,8 @@ u64 kvm_vcpu_reserved_gpa_bits_raw(struct kvm_vcpu *vcpu)
 	return rsvd_bits(cpuid_maxphyaddr(vcpu), 63);
 }
 
-static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
-                        int nent)
+int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
+		  int nent)
 {
 	u32 vcpu_caps[NR_KVM_CPU_CAPS];
 	int r;
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 8d863f45585d..e5ec112d39cc 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -21,6 +21,7 @@ static inline void kvm_finalize_cpu_caps(void)
 }
 
 void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu);
+int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2, int nent);
 struct kvm_cpuid_entry2 *kvm_find_cpuid_entry2(struct kvm_cpuid_entry2 *entries,
 					       int nent, u32 function, u64 index);
 /*
diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index dd3bb04878ca..ae849e0b7d14 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -339,6 +339,21 @@ static u32 msr_based_features[ARRAY_SIZE(msr_based_features_all_except_vmx) +
 			      (KVM_LAST_EMULATED_VMX_MSR - KVM_FIRST_EMULATED_VMX_MSR + 1)];
 static unsigned int num_msr_based_features;
 
+unsigned int kvm_num_msrs_to_save(void)
+{
+	return num_msrs_to_save + num_emulated_msrs;
+}
+
+u32 kvm_get_msr_to_save_index(unsigned int i)
+{
+	if (i < num_msrs_to_save)
+		return msrs_to_save[i];
+	i -= num_msrs_to_save;
+	if (i < num_emulated_msrs)
+		return emulated_msrs[i];
+	return 0;
+}
+
 int kvm_get_msr_index_list(struct kvm_msr_list __user *user_msr_list)
 {
 	struct kvm_msr_list msr_list;
diff --git a/arch/x86/kvm/msrs.h b/arch/x86/kvm/msrs.h
index 7cc182a15b3b..3a5e39041d99 100644
--- a/arch/x86/kvm/msrs.h
+++ b/arch/x86/kvm/msrs.h
@@ -65,6 +65,8 @@ int __kvm_emulate_msr_read(struct kvm_vcpu *vcpu, u32 index, u64 *data);
 int __kvm_emulate_msr_write(struct kvm_vcpu *vcpu, u32 index, u64 data);
 int kvm_msr_read(struct kvm_vcpu *vcpu, u32 index, u64 *data);
 int kvm_msr_write(struct kvm_vcpu *vcpu, u32 index, u64 data);
+unsigned int kvm_num_msrs_to_save(void);
+u32 kvm_get_msr_to_save_index(unsigned int i);
 int kvm_emulate_rdmsr(struct kvm_vcpu *vcpu);
 int kvm_emulate_rdmsr_imm(struct kvm_vcpu *vcpu, u32 msr, int reg);
 int kvm_emulate_wrmsr(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
index 8f66438989e4..02f041c355cc 100644
--- a/arch/x86/kvm/regs.c
+++ b/arch/x86/kvm/regs.c
@@ -51,7 +51,7 @@ void kvm_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_set_rflags);
 
-static void __get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
+void __get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
 	if (vcpu->arch.emulate_regs_need_sync_to_vcpu) {
 		/*
@@ -99,7 +99,7 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	return 0;
 }
 
-static void __set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
+void __set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
 	vcpu->arch.emulate_regs_need_sync_from_vcpu = true;
 	vcpu->arch.emulate_regs_need_sync_to_vcpu = false;
@@ -498,7 +498,7 @@ static void __get_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 	sregs->apic_base = vcpu->arch.apic_base;
 }
 
-static void __get_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
+void __get_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 {
 	__get_sregs_common(vcpu, sregs);
 
@@ -635,7 +635,7 @@ static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,
 	return 0;
 }
 
-static int __set_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
+int __set_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 {
 	int pending_vec, max_bits;
 	int mmu_reset_needed = 0;
diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
index 447f0ec3e63e..40947b1be404 100644
--- a/arch/x86/kvm/regs.h
+++ b/arch/x86/kvm/regs.h
@@ -517,5 +517,9 @@ int kvm_vcpu_ioctl_x86_get_debugregs(struct kvm_vcpu *vcpu,
 int kvm_vcpu_ioctl_x86_set_debugregs(struct kvm_vcpu *vcpu,
 				     struct kvm_debugregs *dbgregs);
 
+void __get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs);
+void __set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs);
+void __get_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs);
+int __set_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs);
 
 #endif
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 79468ddfe473..69e0d67a309b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2959,8 +2959,8 @@ void kvm_handle_exception_payload_quirk(struct kvm_vcpu *vcpu)
 		kvm_deliver_exception_payload(vcpu, ex);
 }
 
-static void kvm_vcpu_ioctl_x86_get_vcpu_events(struct kvm_vcpu *vcpu,
-					       struct kvm_vcpu_events *events)
+void kvm_vcpu_ioctl_x86_get_vcpu_events(struct kvm_vcpu *vcpu,
+					struct kvm_vcpu_events *events)
 {
 	struct kvm_queued_exception *ex = kvm_get_exception_to_save(vcpu);
 
@@ -3028,8 +3028,8 @@ static void kvm_vcpu_ioctl_x86_get_vcpu_events(struct kvm_vcpu *vcpu,
 	}
 }
 
-static int kvm_vcpu_ioctl_x86_set_vcpu_events(struct kvm_vcpu *vcpu,
-					      struct kvm_vcpu_events *events)
+int kvm_vcpu_ioctl_x86_set_vcpu_events(struct kvm_vcpu *vcpu,
+				       struct kvm_vcpu_events *events)
 {
 	if (events->flags & ~(KVM_VCPUEVENT_VALID_NMI_PENDING
 			      | KVM_VCPUEVENT_VALID_SIPI_VECTOR
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 0f5919b092e4..936ee660ccec 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -492,6 +492,10 @@ int kvm_task_switch(struct kvm_vcpu *vcpu, u16 tss_selector, int idt_index,
 		    int reason, bool has_error_code, u32 error_code);
 
 int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr);
+void kvm_vcpu_ioctl_x86_get_vcpu_events(struct kvm_vcpu *vcpu,
+					struct kvm_vcpu_events *events);
+int kvm_vcpu_ioctl_x86_set_vcpu_events(struct kvm_vcpu *vcpu,
+				       struct kvm_vcpu_events *events);
 int kvm_emulate_xsetbv(struct kvm_vcpu *vcpu);
 int kvm_emulate_rdpmc(struct kvm_vcpu *vcpu);
 
diff --git a/include/linux/kho/abi/kvm_x86.h b/include/linux/kho/abi/kvm_x86.h
new file mode 100644
index 000000000000..316250482db5
--- /dev/null
+++ b/include/linux/kho/abi/kvm_x86.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+#ifndef _LINUX_KHO_ABI_KVM_X86_H
+#define _LINUX_KHO_ABI_KVM_X86_H
+
+#ifdef CONFIG_X86_64
+
+#include <linux/build_bug.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
+#include <linux/kho/abi/kvm.h>
+#include <uapi/linux/kvm.h>
+#include <uapi/asm/kvm.h>
+
+/**
+ * DOC: x86 KVM Live Update ABI
+ *
+ * x86 KVM uses the ABI defined below for preserving architectural VM and vCPU
+ * state across a kexec reboot using LUO.
+ *
+ * The vCPU-level architectural state contains the compact register sets and
+ * CPUID table for each vCPU.
+ *
+ * All sub-structures (struct kvm_regs, struct kvm_sregs, struct kvm_mp_state,
+ * struct kvm_cpuid_entry2) are uAPI contracts.
+ */
+
+/**
+ * struct kvm_vcpu_arch_ser - Preserved x86 architectural vCPU state in RAM.
+ * @regs:          General-purpose registers (uAPI struct kvm_regs).
+ * @sregs:         Segment and control registers (uAPI struct kvm_sregs).
+ * @mp_state:      Multiprocessor state (uAPI struct kvm_mp_state).
+ * @pad:           Padding to maintain 64-bit alignment after mp_state.
+ * @xcrs:          Extended control registers including XCR0 (uAPI struct kvm_xcrs).
+ * @lapic:         In-kernel local APIC register state (uAPI struct kvm_lapic_state).
+ * @pad_xsave:     Padding that aligns @xsave to 64 bytes; see the static_assert
+ *                 below.  Must be zero.
+ * @xsave:         Extended processor state (uAPI struct kvm_xsave).  This is the
+ *                 only copy of the guest FPU state; there is no kvm_fpu twin.
+ * @events:        vCPU exception, interrupt, NMI and SMI events (uAPI struct kvm_vcpu_events).
+ * @debugregs:     Hardware debug registers DR0-DR7 (uAPI struct kvm_debugregs).
+ * @num_msrs:      Number of valid MSR entries in msrs.
+ * @cpuid_nent:    Number of valid CPUID entries immediately following msrs[num_msrs].
+ * @msrs:          Array of preserved architectural and paravirtual MSR entries,
+ *                 followed by @cpuid_nent struct kvm_cpuid_entry2 entries.
+ */
+struct kvm_vcpu_arch_ser {
+	struct kvm_regs regs;
+	struct kvm_sregs sregs;
+	struct kvm_mp_state mp_state;
+	u32 pad;
+	struct kvm_xcrs xcrs;
+	struct kvm_lapic_state lapic;
+	u8 pad_xsave[40];
+	struct kvm_xsave xsave;
+	struct kvm_vcpu_events events;
+	struct kvm_debugregs debugregs;
+	u32 num_msrs;
+	u32 cpuid_nent;
+	struct kvm_msr_entry msrs[];
+} __packed;
+
+static_assert(offsetof(struct kvm_vcpu_arch_ser, msrs) % sizeof(u64) == 0,
+	      "msrs must be 64-bit aligned");
+
+/*
+ * @xsave must be a legal XSAVE destination.  The structure is __packed, so
+ * without @pad_xsave the member lands at offset 1880, which is not even
+ * 16-byte aligned, and the XSAVE/XRSTOR family faults on anything less than
+ * 64.  The allocation itself is fine: kho_alloc_preserve() returns a folio
+ * address, so the base is page aligned.
+ *
+ * If this assert fires, a member above @xsave changed size; adjust
+ * @pad_xsave rather than deleting the assert.
+ */
+static_assert(offsetof(struct kvm_vcpu_arch_ser, xsave) % 64 == 0,
+	      "xsave must be 64-byte aligned to be XSAVE-able in place");
+
+#endif /* CONFIG_X86_64 */
+
+#endif /* _LINUX_KHO_ABI_KVM_X86_H */
-- 
2.55.0.1082.g2b9226bbc0-goog


