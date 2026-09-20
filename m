Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF06C982D8
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k5EaTmFX7UEEJKbougudGcIFK6qUIRFfVy3dwTjeVQg=; b=Sk+vQsqYkyLywArVBMi019t3kU
	KCUNSFKF43i51KfMBU5+XQQAwc1/UCJgQcfWzW4n/2YcZJo99PXdNcVmQ1CtM+KljonLw6GnXWVzi
	nHjenIbGDXM18AzQP9A0XiK3sbc6n7oNCSC6uCEAP4W2W7xXiDbz0rCJUsYvySENLARMVg2cEUJL3
	dlyVdAtKe26NtFiQB59VHqeDus3v8MFxyFeLTBgAMjC0EtTUOJENnK1DFSeSgH+D4hgR8uBW4AjM4
	pPTy88MB8ngLijqeJZxUS/S/gysfi71RbTq6YotG6z5rOVtVh3eGYEwVwKwJDeCDJ8mTgONMdOOO5
	uU6IV1Hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4z-00000000Nos-1tDb;
	Sun, 20 Sep 2026 20:24:05 +0000
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8NNq-00000000J83-1UUV
	for kexec@lists.infradead.org;
	Sun, 20 Sep 2026 19:39:31 +0000
Received: by mail-yx2-x10.google.com with SMTP id 00721157ae682-85d440939efso18018977b3.1
        for <kexec@lists.infradead.org>; Sun, 20 Sep 2026 12:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789933169; x=1790537969; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=k5EaTmFX7UEEJKbougudGcIFK6qUIRFfVy3dwTjeVQg=;
        b=CazWC//YlkR9UQn4TMlV7UDo9cPLcQyOaUHF4zCuU9HotpcQKF2DFVgaquU0cb7lMd
         8l+/qGeRJVnkICouvNH2lrp1BXUjAFnblenME+/RbGwYph+r3IA+FKva2ZVCwTIDkNDh
         UBcpO/amLyK7gAq0jaGSC4lEcmazQlS7tZBzK9X/yMVZsXf2JvgUf9/oenYDnVxGp8f0
         nNAB8/6AUAk4txMDKrqxPGUz4D/m46j/dsWetwQqdiDayanZohH34t+4RG2W+irsF2M7
         8T0elfaYz8TmO9v6RsdlnYpSMosGFjLuhZxmjPyg6PrMxLQT1IkrGcAebXEwWif0IX5j
         sm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933169; x=1790537969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=k5EaTmFX7UEEJKbougudGcIFK6qUIRFfVy3dwTjeVQg=;
        b=gWecFDH+TmBjjGAuZ7pevmc2yFTY5ljS3TDqJFcv/2LiYvTd/WtbAldTO/rbT1FJUH
         LvgPc4AXCwLO4hP3LmAKQjyFGQYSsRL+VQcXgaovlGArNw79ADzVmbEYurJK/Lhd9/vP
         Ig0Ud8cBBLwp0ER0IH9IXiDosK5ZSvadLiXHJsfAYak9+MqVmCnd8hAbHzTwVmV7cJWn
         NfIa1BcFqK/WxpaHsFDAiY142CuWCO1oGGtTuLPYup5h/0TwTedEGboHArduprx4K+fn
         L5/880IUc5qBEk+/y+z1l4NqGnvno837AybQ+irTexQ2gDxoan47LbJsdIgUpoO4URdJ
         Qrxg==
X-Forwarded-Encrypted: i=1; AKwUvByH331jWhy8HohdjvpmnXOq64DuCkEB3iI3vvqR5q/6efPANrdE6C0YGAL7fKeAAzGkdjd9yw==@lists.infradead.org
X-Gm-Message-State: AFuF++lGMNzYelOS9JCJp9SjKfM7WIrm5ZjsqeZM46kFUibBpZzfOdKK
	Dej/wlzfb4eGu8EM0k8r83frSN5Isn0cXKsmAAXRmaT6pXIrFX2Cv5Lw1AR6Y31P9fI=
X-Gm-Gg: AYBFou315WzWP+bZzb7ICA4kTUUYTYwkic+EUHMA6qnVJgkxFfEakn2b1tOhTfbL8Jw
	qLYTNQ+FKeI40/bUOsbF0YtrQjFipZ7c3BdYui1ZH3kUwfyx59mwqgRVGCf5oma4zaaghDIhRGN
	GU2sQihwIj3zLoBpxjrzm87Wef4ZLqxfGQv2Sw5BoMX/B/G2UYJN6/i0mU/SnCde1/ReeqsHvFf
	KQv6etMhbh6/3kmW0CtHwVvo5S67nGF6p7iRJJmIBZ11Atf4F9rC+NbdPHeShWOowRDVQJqt5EY
	eBNsTiDKNEaJj21M4cKAe+PLaNqMeD6O100AMcfSVOfdeVFRT/I9bVs5bezfDh73M5/isaC8pAV
	cpdF7dNQ6L98f90CPrGJKCfDU/OtfN6QmcbrLAlSn498eVsUfDu9HNf6E7nf3ScaTqWrBozoeLp
	5EKrWSlC/aK5L0vqErlqwSlNh/ZODxXP0DeH6ktEySUYQVm1IkbSB/4sTGxr+L36dz8Sg8AH7jw
	U/kc0TI6u6B51GD0Eqew1gnSaODvDMELxTmNZVBWuMEpkk42lGrX0tcQW94Ih5ofZw8D3g88HyO
	C2/HwlgHxaPeteLnJYA=
X-Received: by 2002:a05:690c:6:b0:88c:b8ef:4fb9 with SMTP id 00721157ae682-89736848436mr28151587b3.66.1789933169160;
        Sun, 20 Sep 2026 12:39:29 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a46e4dd4fsm18636037b3.25.2026.09.20.12.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:39:28 -0700 (PDT)
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
Subject: [RFC PATCH 26/46] oncore: Add on-core KHO ABI and public framework headers
Date: Sun, 20 Sep 2026 15:36:30 -0400
Message-ID: <20260920193650.3373435-27-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
References: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_123930_411618_0EDE9771 
X-CRM114-Status: GOOD (  18.22  )
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

Define the On-Core KHO serialization ABI (include/linux/kho/abi/cpu.h)
and public session and job management APIs (include/linux/oncore.h).

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/oncore.h |  24 ++++++
 arch/x86/include/asm/oncore.h   |  25 +++++++
 include/linux/kho/abi/cpu.h     |   1 +
 include/linux/oncore.h          | 129 ++++++++++++++++++++++++++++++++
 kernel/liveupdate/Kconfig       |  10 +++
 5 files changed, 189 insertions(+)
 create mode 100644 arch/arm64/include/asm/oncore.h
 create mode 100644 arch/x86/include/asm/oncore.h
 create mode 100644 include/linux/oncore.h

diff --git a/arch/arm64/include/asm/oncore.h b/arch/arm64/include/asm/oncore.h
new file mode 100644
index 000000000000..fbd0f218d867
--- /dev/null
+++ b/arch/arm64/include/asm/oncore.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ *
+ * ARM64 architecture hooks for On-Core execution.
+ */
+#ifndef _ASM_ARM64_ONCORE_H
+#define _ASM_ARM64_ONCORE_H
+
+#include <linux/types.h>
+#include <asm/arch_timer.h>
+
+static inline u64 __cpu_preserved_text arch_oncore_read_counter(void)
+{
+	return __arch_counter_get_cntpct();
+}
+
+static inline u64 arch_oncore_counter_freq_hz(void)
+{
+	return arch_timer_get_cntfrq();
+}
+
+#endif /* _ASM_ARM64_ONCORE_H */
diff --git a/arch/x86/include/asm/oncore.h b/arch/x86/include/asm/oncore.h
new file mode 100644
index 000000000000..f64697a95d6a
--- /dev/null
+++ b/arch/x86/include/asm/oncore.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ *
+ * x86 architecture hooks for On-Core execution.
+ */
+#ifndef _ASM_X86_ONCORE_H
+#define _ASM_X86_ONCORE_H
+
+#include <linux/types.h>
+#include <asm/msr.h>
+#include <asm/tsc.h>
+
+static inline u64 __cpu_preserved_text arch_oncore_read_counter(void)
+{
+	return rdtsc();
+}
+
+static inline u64 arch_oncore_counter_freq_hz(void)
+{
+	return (u64)tsc_khz * 1000ULL;
+}
+
+#endif /* _ASM_X86_ONCORE_H */
diff --git a/include/linux/kho/abi/cpu.h b/include/linux/kho/abi/cpu.h
index f75bfb4c6161..4d63e623f162 100644
--- a/include/linux/kho/abi/cpu.h
+++ b/include/linux/kho/abi/cpu.h
@@ -145,6 +145,7 @@ struct cpu_preserved_file_ser {
 	u32 cpu;
 	u32 reserved;
 	u64 stack_pa;
+	DECLARE_KHOSER_PTR(oncore, struct oncore_session_ser *);
 } __packed;
 
 #endif /* _LINUX_KHO_ABI_CPU_H */
diff --git a/include/linux/oncore.h b/include/linux/oncore.h
new file mode 100644
index 000000000000..2817b0282a32
--- /dev/null
+++ b/include/linux/oncore.h
@@ -0,0 +1,129 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ *
+ * On-Core Session and Scheduling Framework for Live Update
+ */
+#ifndef __LINUX_ONCORE_H
+#define __LINUX_ONCORE_H
+
+#include <linux/cpu_preserve.h>
+#include <linux/types.h>
+
+/*
+ * Only ever used as an opaque handle here, so do not include
+ * <linux/liveupdate.h>: this header is reached from <linux/kvm_host.h> via
+ * <linux/kvm_caretaker.h>, and including it would drag the entire LUO header
+ * stack into every KVM translation unit on every architecture.
+ */
+struct liveupdate_session;
+struct oncore_session;
+struct oncore_session_ser;
+struct oncore_job;
+
+#include <asm/oncore.h>
+
+/**
+ * enum oncore_exit_reason - Why an on-core job returned to the scheduler
+ * @ONCORE_EXIT_QUANTUM_EXPIRED: Time slice elapsed; the job is still runnable.
+ * @ONCORE_EXIT_ATTACH_SIGNALED: The incoming kernel asked for the CPU back.
+ * @ONCORE_EXIT_YIELD_IDLE: The job has no work right now (guest HLT/WFI).
+ * @ONCORE_EXIT_ERROR: The job hit an unrecoverable error and must be dropped.
+ * @ONCORE_EXIT_STALL: The job hit something it cannot handle on-core and
+ *                     cannot make forward progress until the incoming kernel
+ *                     reclaims it.  Unlike %ONCORE_EXIT_QUANTUM_EXPIRED, an
+ *                     immediate re-run is guaranteed to hit the same wall, so
+ *                     the scheduler backs off instead of spinning.
+ */
+enum oncore_exit_reason {
+	ONCORE_EXIT_QUANTUM_EXPIRED = 0,
+	ONCORE_EXIT_ATTACH_SIGNALED,
+	ONCORE_EXIT_YIELD_IDLE,
+	ONCORE_EXIT_ERROR,
+	ONCORE_EXIT_STALL,
+};
+
+typedef enum oncore_exit_reason (*oncore_job_fn)(void *data,
+						 u64 deadline_ticks);
+
+#ifdef CONFIG_LIVEUPDATE_ONCORE
+int oncore_session_add_cpu(struct liveupdate_session *s, int cpu);
+void oncore_session_remove_cpu(struct liveupdate_session *s, int cpu);
+struct oncore_session_ser *oncore_session_get_ser(struct liveupdate_session *s);
+void oncore_session_restore(struct liveupdate_session *s,
+			    struct oncore_session_ser *ser);
+phys_addr_t oncore_session_get_pgd_pa(struct oncore_session *sess);
+struct oncore_job *oncore_session_submit_job(struct liveupdate_session *s,
+					     oncore_job_fn run_fn,
+					     void *data);
+int oncore_session_activate_job(struct liveupdate_session *s,
+				struct oncore_job *job);
+void oncore_job_set_data(struct oncore_job *job, void *data);
+int oncore_job_cpu(const struct oncore_job *job);
+struct oncore_session *oncore_job_session(const struct oncore_job *job);
+int oncore_session_cancel_job(struct liveupdate_session *s,
+			      struct oncore_job *job);
+int oncore_session_map_range(struct oncore_session *sess, phys_addr_t pa,
+			     unsigned long va, size_t size, pgprot_t prot);
+int oncore_session_map_buffer(struct oncore_session *sess, void *va,
+			      size_t size);
+#else
+static inline int oncore_session_add_cpu(struct liveupdate_session *s, int cpu) { return 0; }
+
+static inline void oncore_session_remove_cpu(struct liveupdate_session *s, int cpu) {}
+
+static inline struct oncore_session_ser *
+oncore_session_get_ser(struct liveupdate_session *s)
+{
+	return NULL;
+}
+
+static inline void oncore_session_restore(struct liveupdate_session *s,
+					  struct oncore_session_ser *ser) {}
+
+static inline phys_addr_t oncore_session_get_pgd_pa(struct oncore_session *sess) { return 0; }
+
+static inline struct oncore_job *oncore_session_submit_job(struct liveupdate_session *s,
+							   oncore_job_fn run_fn,
+							   void *data)
+{
+	return NULL;
+}
+
+static inline int oncore_session_activate_job(struct liveupdate_session *s,
+					      struct oncore_job *job)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void oncore_job_set_data(struct oncore_job *job, void *data) {}
+
+static inline int oncore_job_cpu(const struct oncore_job *job) { return -1; }
+
+static inline struct oncore_session *
+oncore_job_session(const struct oncore_job *job)
+{
+	return NULL;
+}
+
+static inline int oncore_session_cancel_job(struct liveupdate_session *s,
+					    struct oncore_job *job)
+{
+	return 0;
+}
+
+static inline int oncore_session_map_range(struct oncore_session *sess, phys_addr_t pa,
+					   unsigned long va, size_t size, pgprot_t prot)
+{
+	return 0;
+}
+
+static inline int oncore_session_map_buffer(struct oncore_session *sess, void *va,
+					    size_t size)
+{
+	return 0;
+}
+#endif /* CONFIG_LIVEUPDATE_ONCORE */
+
+#endif /* __LINUX_ONCORE_H */
diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
index 52c5fd7a620b..0e1f72de2a48 100644
--- a/kernel/liveupdate/Kconfig
+++ b/kernel/liveupdate/Kconfig
@@ -136,4 +136,14 @@ config LIVEUPDATE_CPU
 
 	  If unsure, say N.
 
+config LIVEUPDATE_ONCORE
+	bool "On-core execution framework"
+	depends on LIVEUPDATE_CPU
+	default LIVEUPDATE_CPU
+	help
+	  Provide the on-core execution session and job scheduling framework
+	  for workloads running on preserved physical CPUs across a host
+	  live update (kexec handover). This allows subsystems such as KVM
+	  Caretaker to bind jobs to isolated physical cores during kexec.
+
 endmenu
-- 
2.55.0.1082.g2b9226bbc0-goog


