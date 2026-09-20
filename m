Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F04BC982EF
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K+2B3zmRro/zDH0n7+YdvazCE3Eaf+b235sNOcPlOno=; b=a+nRkQKGqu/wm+Vw1ysJ+rPRys
	t/9D8X40WGFAgXEOoAZWFuA6hnnIRwGLpV0d284OwC2oA8otjwVZFNXVlq1+w4jUSVqyDQLeYPzDV
	Q3h2IDxHf36pTBtcHBOaa+4AU2wpthb9fv0/w619lzLAi5vxpGhrqDAWUAR5sLpXQxq7o6BAC7xpR
	XJlaIHgMhV0s1TaqFlSBeRxJvPX0X202Denvb2eoqv2PUmRu8fUjpXa4k7vW//WIixJQ/6prWLHEy
	qWESt9Pawb5Y2AieGwBDr12o9GoCyto64GkQ5aorHe3bnongxeeFHdvvm7EF48z/0bBkHyN0IMdPV
	o88gnFSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O55-00000000O3U-2Xw8;
	Sun, 20 Sep 2026 20:24:11 +0000
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8NOK-00000000JGP-1mPO
	for kexec@lists.infradead.org;
	Sun, 20 Sep 2026 19:40:01 +0000
Received: by mail-yx2-x10.google.com with SMTP id 956f58d0204a3-66fabb1a601so1826073d50.3
        for <kexec@lists.infradead.org>; Sun, 20 Sep 2026 12:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789933199; x=1790537999; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=K+2B3zmRro/zDH0n7+YdvazCE3Eaf+b235sNOcPlOno=;
        b=J6vllhWla+kXMYhmOQpZCmigR5y9nm+mtnkw2S+DgHFqD9iWo9zirVl2/NTe0WxT14
         JvJN2KMSEsh0f2ZIstE8pr/HYcbUywRmG/YpDSle2NxBmsNC/5RkPmUrZxvpVXboGwQ6
         ggGVKkNbAp+VzBfTRJZICH1EtMv/6utDDluhZ7UfM1KXDgspiGRGKMmtqM6McUn2IUKi
         4Cli6HH7tgGFt9zQwhnw8qAVep6DhaYtXkUCbPMx2u+NBZDhiud+4h/8Q7MDZ4elBxpS
         ab19DSS2EKBiAGgLXVjzXLgjZGu0AaNs76BrTx7Dkea2CQLtO+wtXp7Oi9Ykxcx8ixUt
         Au0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933199; x=1790537999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=K+2B3zmRro/zDH0n7+YdvazCE3Eaf+b235sNOcPlOno=;
        b=ozKBkUyhUfdlZOoh2dvUJ6jK9XUM4/BhdUqNrUJHN957wlBKEcKbvMmd31d88/Fq1S
         yAJCvK3UpSlLQRj7rQQHWnzJIJFrc26fiFRwLiFLzdJ0C7t/3X+8l3RvwzFVI/WnaJNt
         0+hnBe4b2UKuYc2ToDDUTXwKGIxLkvv/hQ0831wKK/k+uctlcMBFCO8bmLWZ4KggX1GW
         MZGYsOan7P1OdvTQFxXu/Qvxky4ZL+nsYwmlMu4pMzZfZwItfJE9Ry25hobhlflfmIvz
         ZBWFVjtQYQYM8kQ7jK7d7f/oqCUIICfobH4jhY1M75qY3u7A/0v+J3KGppt1uXGg5VHC
         osGA==
X-Forwarded-Encrypted: i=1; AKwUvBxCvP497ZH39IzuvVaXM1lQndDY2WDefBHRV+HV67Jd3W/qjTwmXR+9mjpghwqn2mF3P+tpAw==@lists.infradead.org
X-Gm-Message-State: AFuF++kxBEl4YRiT0Y2pL7iZsvsjGqIUdP6MV1jz0l0wGU4cxcoqpmjg
	3a2SYKi1s29fP+nufuedwkelKzNQbp3qmFf5vXPQ6ngy+K4GHuPCfgktzFxoGL94lTY=
X-Gm-Gg: AYBFou2o0nFCPMxHuuEpkDnjP1HSQHmKJLvkzgBx0jQKVAl6Gc7kNeZvRM5lk9fdo5M
	OL5UPc2jjUU1a2atvXx77kQzMs/mTyWShBrzuOerVrpDY4X7ddSA15dnkIyv3Zg76b1I2bBscf+
	wssXIz7r81s9DjHTmxS6S9NYy0THgdB4tgw8lVeUc6DgK2Tw9q8jsv38FRvUabULjZYWBpIqFV/
	k/XvnYJIe2+XiI+QDkzmmWdllm8pDlNZty1PCLVkSyhRbbvNVr0SDnbJD7DvHDqMZOOBfX3BFAr
	Mh0JoNzGvgYZ0xjl9r11gGbColWgehrxE3zMTdkEMAunxgr1uihtMDLFijsKpFbyqxl7J7169BE
	1HryyTrBP3HQv1YDriG0XnJLogca7FrV768ZzuQqUVVERh0K2PHbBB4U8DSxQDYSD40HtFaZsUN
	lJl4SIS+8zZkAfBRUALTRh4qkAXBfb03fdURX6Y9vewiZHf6aFbnBo0k4zhC4ch6THDe7Hq71O0
	MM9NwpnwxITadMqPK6juUVUdQ8UgEJQe5REbvWbxdnU4dCMJaJI0B1GQ+PXxVtLRlTQ3mKKACyU
	+rARxeRiuXPeowUlnnE=
X-Received: by 2002:a05:690e:1408:b0:671:41c1:daaf with SMTP id 956f58d0204a3-6717fc95e09mr2518491d50.6.1789933199337;
        Sun, 20 Sep 2026 12:39:59 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-672990ab5desm2605625d50.8.2026.09.20.12.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:39:58 -0700 (PDT)
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
Subject: [RFC PATCH 31/46] KVM: caretaker: Add generic KHO ABI telemetry and debugfs reporting
Date: Sun, 20 Sep 2026 15:36:35 -0400
Message-ID: <20260920193650.3373435-32-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
References: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_124000_496522_F67111CD 
X-CRM114-Status: GOOD (  20.60  )
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

When a preserved vCPU executes inside the Caretaker during a host live
update blackout window, standard kernel tracing and KVM exit counters
are unavailable because the host kernel is being replaced via kexec. If
a guest vCPU hits an unhandled exit and parks, or experiences unexpected
exit patterns during the transition, the incoming kernel has no
visibility into what occurred while the vCPU was detached.

Add optional cross-kexec Caretaker execution telemetry behind
CONFIG_KVM_CARETAKER_DEBUG. During detached execution, the Caretaker
records run counts, exit counts, stall counts, the last exit reason and
guest PC, and stall diagnostics into a KHO-preserved telemetry buffer
referenced from struct kvm_caretaker_cb_ser. When the incoming kernel
reclaims the vCPU, it logs a summary to dmesg and exposes the preserved
telemetry under /sys/kernel/debug/kvm/<vm>/vcpu<N>/caretaker_telemetry.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/kvm_caretaker.h |  97 +++++++++++++++++++++++++++
 virt/kvm/Kconfig              |  10 +++
 virt/kvm/Makefile.kvm         |   1 +
 virt/kvm/caretaker_debug.c    | 120 ++++++++++++++++++++++++++++++++++
 virt/kvm/kvm_main.c           |   1 +
 5 files changed, 229 insertions(+)
 create mode 100644 virt/kvm/caretaker_debug.c

diff --git a/include/linux/kvm_caretaker.h b/include/linux/kvm_caretaker.h
index 0d4bdde7b1c3..f889d17212b0 100644
--- a/include/linux/kvm_caretaker.h
+++ b/include/linux/kvm_caretaker.h
@@ -108,11 +108,13 @@ struct kvm_caretaker_ops {
  * @cb:        Pointer to KHO-preserved Caretaker control block (&struct kvm_caretaker_cb_ser).
  * @ops:       Architecture operations vector (&struct kvm_caretaker_ops).
  * @arch_data: Architecture-specific runtime context passed to @ops callbacks.
+ * @telemetry: Pointer to KHO-preserved telemetry counters, or %NULL.
  */
 struct kvm_caretaker_vcpu {
 	struct kvm_caretaker_cb_ser *cb;
 	const struct kvm_caretaker_ops *ops;
 	void *arch_data;
+	struct kvm_caretaker_telemetry_ser *telemetry;
 };
 
 struct kvm_kho_folios_ser *kvm_kho_folios_alloc(unsigned int max_folios);
@@ -260,11 +262,106 @@ void kvm_caretaker_vcpu_finish(struct kvm_vcpu *vcpu,
 			       struct liveupdate_session *session,
 			       struct kvm_vcpu_ser *ser);
 
+#ifdef CONFIG_KVM_CARETAKER_DEBUG
+void kvm_caretaker_telemetry_init(struct kvm_caretaker_vcpu *cvcpu,
+				  struct oncore_session *sess);
+void kvm_caretaker_telemetry_report(struct kvm_vcpu *vcpu,
+				    struct kvm_caretaker_cb_ser *cb);
+void kvm_caretaker_telemetry_free(struct kvm_vcpu_ser *ser, bool is_incoming);
+void kvm_caretaker_create_vcpu_debugfs(struct kvm_vcpu *vcpu,
+				       struct dentry *debugfs_dentry);
+
+/**
+ * kvm_caretaker_telemetry_run - Record a guest entry in Caretaker telemetry
+ * @cvcpu: Common Caretaker vCPU descriptor.
+ */
+static __always_inline __caretaker_text void
+kvm_caretaker_telemetry_run(struct kvm_caretaker_vcpu *cvcpu)
+{
+	if (cvcpu->telemetry)
+		cvcpu->telemetry->total_runs++;
+}
+
+/**
+ * kvm_caretaker_telemetry_exit - Record a decoded VM exit in Caretaker telemetry
+ * @cvcpu: Common Caretaker vCPU descriptor.
+ * @exit:  Decoded VM exit descriptor.
+ */
+static __always_inline __caretaker_text void
+kvm_caretaker_telemetry_exit(struct kvm_caretaker_vcpu *cvcpu,
+			     const struct kvm_caretaker_exit *exit)
+{
+	if (cvcpu->telemetry) {
+		cvcpu->telemetry->total_exits++;
+		cvcpu->telemetry->last_exit_reason = exit->raw_reason;
+		cvcpu->telemetry->last_exit_rip = exit->rip;
+	}
+}
+
+/**
+ * kvm_caretaker_telemetry_stall - Record an unhandled stall exit in Caretaker telemetry
+ * @cvcpu:  Common Caretaker vCPU descriptor.
+ * @reason: Raw hardware exit reason or entry failure code.
+ * @rip:    Guest instruction pointer at stall (0 if entry failure).
+ */
+static __always_inline __caretaker_text void
+kvm_caretaker_telemetry_stall(struct kvm_caretaker_vcpu *cvcpu,
+			      u64 reason, u64 rip)
+{
+	if (cvcpu->telemetry) {
+		cvcpu->telemetry->stall_count++;
+		cvcpu->telemetry->last_exit_reason = reason;
+		cvcpu->telemetry->stall_exit_reason = reason;
+		if (rip)
+			cvcpu->telemetry->stall_exit_rip = rip;
+	}
+}
+
+/**
+ * kvm_caretaker_telemetry_flush - Clean Caretaker telemetry counters to PoC
+ * @cvcpu: Common Caretaker vCPU descriptor.
+ */
+static __always_inline __caretaker_text void
+kvm_caretaker_telemetry_flush(struct kvm_caretaker_vcpu *cvcpu)
+{
+	if (cvcpu->telemetry)
+		cpu_preserved_clean_sz(cvcpu->telemetry,
+				       sizeof(*cvcpu->telemetry));
+}
+#else
+static inline void kvm_caretaker_telemetry_init(struct kvm_caretaker_vcpu *cvcpu,
+						struct oncore_session *sess) {}
+
+static inline void kvm_caretaker_telemetry_report(struct kvm_vcpu *vcpu,
+						  struct kvm_caretaker_cb_ser *cb) {}
+
+static inline void kvm_caretaker_telemetry_free(struct kvm_vcpu_ser *ser,
+						bool is_incoming) {}
+
+static inline void kvm_caretaker_create_vcpu_debugfs(struct kvm_vcpu *vcpu,
+						     struct dentry *debugfs_dentry) {}
+static __always_inline void
+kvm_caretaker_telemetry_run(struct kvm_caretaker_vcpu *cvcpu) {}
+static __always_inline void
+kvm_caretaker_telemetry_exit(struct kvm_caretaker_vcpu *cvcpu,
+			     const struct kvm_caretaker_exit *exit) {}
+static __always_inline void
+kvm_caretaker_telemetry_stall(struct kvm_caretaker_vcpu *cvcpu,
+			      u64 reason, u64 rip) {}
+static __always_inline void
+kvm_caretaker_telemetry_flush(struct kvm_caretaker_vcpu *cvcpu) {}
+#endif
+
 #else /* !CONFIG_KVM_CARETAKER */
 
 #define __caretaker_text
 #define __caretaker_data
 
+struct dentry;
+
+static inline void kvm_caretaker_create_vcpu_debugfs(struct kvm_vcpu *vcpu,
+						     struct dentry *debugfs_dentry) {}
+
 static inline bool kvm_caretaker_is_stopped(const struct kvm_caretaker_cb_ser *cb)
 {
 	return true;
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 165e0c85b8aa..bee73dd079c6 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -153,3 +153,13 @@ config KVM_CARETAKER
 	  without pausing the guest.
 
 	  If unsure, say N.
+
+config KVM_CARETAKER_DEBUG
+	bool "Caretaker execution telemetry and debug reporting"
+	depends on KVM_CARETAKER
+	default n
+	help
+	  Enable Caretaker telemetry collection and reporting of VM exits,
+	  runs, and stall diagnostics via debugfs and dmesg upon vCPU resume
+	  following a host kexec live update or cancelled live update session.
+	  If unsure, say N.
diff --git a/virt/kvm/Makefile.kvm b/virt/kvm/Makefile.kvm
index ae1fcf9861b7..157d0bf6132d 100644
--- a/virt/kvm/Makefile.kvm
+++ b/virt/kvm/Makefile.kvm
@@ -15,6 +15,7 @@ kvm-$(CONFIG_HAVE_KVM_PFNCACHE) += $(KVM)/pfncache.o
 kvm-$(CONFIG_KVM_GUEST_MEMFD) += $(KVM)/guest_memfd.o
 kvm-$(CONFIG_LIVEUPDATE_GUEST_MEMFD) += $(KVM)/guest_memfd_luo.o $(KVM)/kvm_luo.o
 kvm-$(CONFIG_KVM_CARETAKER) += $(KVM)/caretaker.o
+kvm-$(CONFIG_KVM_CARETAKER_DEBUG) += $(KVM)/caretaker_debug.o
 KASAN_SANITIZE_$(KVM)/caretaker.o := n
 KCSAN_SANITIZE_$(KVM)/caretaker.o := n
 UBSAN_SANITIZE_$(KVM)/caretaker.o := n
diff --git a/virt/kvm/caretaker_debug.c b/virt/kvm/caretaker_debug.c
new file mode 100644
index 000000000000..8905938bfec3
--- /dev/null
+++ b/virt/kvm/caretaker_debug.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ *
+ * KVM Caretaker execution telemetry and debugfs reporting.
+ */
+
+#include <linux/cpu_preserve.h>
+#include <linux/debugfs.h>
+#include <linux/kernel.h>
+#include <linux/kexec_handover.h>
+#include <linux/kho/abi/kvm.h>
+#include <linux/kvm_caretaker.h>
+#include <linux/kvm_host.h>
+#include <linux/oncore.h>
+#include <linux/seq_file.h>
+
+void kvm_caretaker_telemetry_init(struct kvm_caretaker_vcpu *cvcpu,
+				  struct oncore_session *sess)
+{
+	struct kvm_caretaker_telemetry_ser *tel;
+
+	tel = kho_alloc_preserve(sizeof(*tel));
+	if (IS_ERR_OR_NULL(tel))
+		return;
+
+	memset(tel, 0, sizeof(*tel));
+	oncore_session_map_buffer(sess, tel, sizeof(*tel));
+	cpu_preserved_clean_sz(tel, sizeof(*tel));
+	cvcpu->telemetry = tel;
+	KHOSER_STORE_PTR(cvcpu->cb->telemetry, tel);
+}
+
+void kvm_caretaker_telemetry_report(struct kvm_vcpu *vcpu,
+				    struct kvm_caretaker_cb_ser *cb)
+{
+	struct kvm_caretaker_telemetry_ser *tel;
+
+	if (!vcpu || !cb)
+		return;
+
+	cpu_preserved_inval(cb);
+	tel = KHOSER_LOAD_PTR(cb->telemetry);
+	if (!tel)
+		return;
+
+	cpu_preserved_inval(tel);
+	vcpu->caretaker.last_telemetry = *tel;
+
+	pr_info("caretaker: vcpu %d resume: runs=%llu exits=%llu stalls=%llu last_exit=0x%llx (%llu) rip=0x%llx\n",
+		vcpu->vcpu_id, tel->total_runs, tel->total_exits,
+		tel->stall_count, tel->last_exit_reason,
+		tel->last_exit_reason, tel->last_exit_rip);
+	if (tel->stall_count) {
+		pr_info("caretaker: vcpu %d stall info: reason=0x%llx (%llu) rip=0x%llx\n",
+			vcpu->vcpu_id, tel->stall_exit_reason,
+			tel->stall_exit_reason, tel->stall_exit_rip);
+	}
+}
+
+void kvm_caretaker_telemetry_free(struct kvm_vcpu_ser *ser, bool is_incoming)
+{
+	struct kvm_caretaker_telemetry_ser *tel;
+	struct kvm_caretaker_cb_ser *cb;
+
+	if (!ser || !(ser->flags & KVM_VCPU_LUO_FLAG_CARETAKER))
+		return;
+
+	cb = KHOSER_LOAD_PTR(ser->cb);
+	tel = cb ? KHOSER_LOAD_PTR(cb->telemetry) : NULL;
+	if (tel) {
+		cb->telemetry.phys = 0;
+		if (is_incoming)
+			kho_restore_free(tel);
+		else
+			kho_unpreserve_free(tel);
+	}
+}
+
+static int caretaker_telemetry_show(struct seq_file *m, void *v)
+{
+	struct kvm_vcpu *vcpu = m->private;
+	const struct kvm_caretaker_telemetry_ser *t =
+		&vcpu->caretaker.last_telemetry;
+	struct kvm_caretaker_cb_ser *cb = READ_ONCE(vcpu->caretaker.cb);
+
+	if (cb) {
+		struct kvm_caretaker_telemetry_ser *live;
+
+		cpu_preserved_inval(cb);
+		live = KHOSER_LOAD_PTR(cb->telemetry);
+		if (live) {
+			cpu_preserved_inval(live);
+			t = live;
+		}
+	}
+
+	seq_printf(m, "runs: %llu\n", t->total_runs);
+	seq_printf(m, "exits: %llu\n", t->total_exits);
+	seq_printf(m, "stalls: %llu\n", t->stall_count);
+	seq_printf(m, "last_exit_reason: 0x%llx (%llu)\n",
+		   t->last_exit_reason, t->last_exit_reason);
+	seq_printf(m, "last_exit_rip: 0x%llx\n", t->last_exit_rip);
+	seq_printf(m, "stall_exit_reason: 0x%llx (%llu)\n",
+		   t->stall_exit_reason, t->stall_exit_reason);
+	seq_printf(m, "stall_exit_rip: 0x%llx\n", t->stall_exit_rip);
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(caretaker_telemetry);
+
+void kvm_caretaker_create_vcpu_debugfs(struct kvm_vcpu *vcpu,
+				       struct dentry *debugfs_dentry)
+{
+	if (!debugfs_dentry)
+		return;
+
+	debugfs_create_file("caretaker_telemetry", 0444, debugfs_dentry, vcpu,
+			    &caretaker_telemetry_fops);
+}
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 4f661c5d2ee2..84b4b96d7916 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4156,6 +4156,7 @@ static void kvm_create_vcpu_debugfs(struct kvm_vcpu *vcpu)
 	debugfs_create_file("pid", 0444, debugfs_dentry, vcpu,
 			    &vcpu_get_pid_fops);
 
+	kvm_caretaker_create_vcpu_debugfs(vcpu, debugfs_dentry);
 	kvm_arch_create_vcpu_debugfs(vcpu, debugfs_dentry);
 }
 #endif
-- 
2.55.0.1082.g2b9226bbc0-goog


