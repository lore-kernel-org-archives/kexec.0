Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9BBBC982EB
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FzvnH7Tj+3ecQR8Da1AzLHxGHVnw3o+AvLmAX6Dhz5A=; b=LqyBqpSwmsJAPEGDELM0TSrjA+
	1Ti81pCzymHy9H29Ry3BnyNbAhOqW+Vvg5ctyU66/RxRgiFRLFyb6RoDhBw6kaVtVFwAJt426BpBF
	ulhGD6mFb2Kb5DfBaJPdSPd0SDMj87VHizLr+qS+UhaPWXzcaF0sLbggU0sDDksR7tmoJL9IDc+8z
	i3KgLJpT8WlP0u6K/sfamZXFSWQAMyLao54VmniqiH8rYFqEw5yNG8RNyyEEFn+62VfugY1+idbWS
	eqZtdGLrYeFL34lIp44mnMbdhhDjp8y2J2iOACRD4WHen2noClzmiILdRdm1468K2Swm6e9yLnkTp
	Hb506qeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O54-00000000O0Q-2wdx;
	Sun, 20 Sep 2026 20:24:10 +0000
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8NO8-00000000JDA-0SWy
	for kexec@lists.infradead.org;
	Sun, 20 Sep 2026 19:39:49 +0000
Received: by mail-yx2-x10.google.com with SMTP id 956f58d0204a3-66e50968489so2009239d50.0
        for <kexec@lists.infradead.org>; Sun, 20 Sep 2026 12:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789933187; x=1790537987; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FzvnH7Tj+3ecQR8Da1AzLHxGHVnw3o+AvLmAX6Dhz5A=;
        b=QGUp1zDditenA9UG6FDFiR/0+9bw3+sUJyzK1jAVV2yKEKegS63/4W+AsHMuuqc5Bz
         QyR/KC9JG8Y4k0k+/7Q7OiH2LCMPVjCHCGh99MZwvnfArkrncjlE+kw+hP5GQjZTF1Cq
         0hhxPa55NzfZx5css0VH8eU8yB4e0kgusYXxRDp2S8YKvxnC37vy99D3Bk1A+fhsryYx
         LO0BU28qakwdtoc0qMe4tAluIRbz6Pf9tznd7Rr5Q03afdWenOb3uLvhjJeNzznd9wkC
         vZDZ+72CIzjdEGHVOIrt3wLoef1oXLml+eURoUjjr8VA1EzQTI2hS/L3tSm/3fSOzhOv
         Bnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933187; x=1790537987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=FzvnH7Tj+3ecQR8Da1AzLHxGHVnw3o+AvLmAX6Dhz5A=;
        b=WEQ+9q80b/CNvl2atl9z24Uor7ky9fAqyQAnwVsy3UozMhLZurixfLUxdSoCLE684w
         GsJwbLH4O2jf/Ou6+MZSpB8BjKP8GLBpX+KilAym56WyDdBytKCRiJFnWJDnx6E8upIt
         +sZlR+SniLoOVx8ImPVVUYDykMylCY1RZcjjp3VkUXo3MvqGPB6svYd53hbp5rtUtmGa
         a2MuAL4ezDs4Uz+upPntWybDZygeYkWn3CsXRM4v2a5H1JF/yrS50gab6UHnKBoNiYsf
         jBc/cibX5/tbK0idcrXjDbZ0Hy540ViOdac5QaAN45Hvadl+r9UhALaB9Ejt1xb9JniT
         s+rg==
X-Forwarded-Encrypted: i=1; AKwUvBw8h5DS+RZp3f5/b596cLszQEoS5PYMO/Ws9kz+T4dh0Kmg6ePn0Uw0JU/wGOXMoLs5/Dy2/A==@lists.infradead.org
X-Gm-Message-State: AFuF++lO1vKBVDtWyAIxMJwWTB86ywYgD26LTotPVjNGf9BcWvibrUbp
	ydCISFgp2bU2WVC6E0wAbhbEscZEjzp8U25r/NHY4/aT7pWO09knQyJcdrRWE7Aa/xZvrYpuLD+
	THO8plvY=
X-Gm-Gg: AYBFou0jgn8HPsYmKzLCeS6AYYRae7o/yG0IbO87U//vcuAvQ5v4VwxE04I6gmbUfUM
	Cbp4FQd6CGcVzBJ/bomXxQqYBpjDszWT/W8rZiOAdB5tp4r4Z8sNcAMTkaQG9ZirJS5D1MS5R9T
	dQ20qaP7PIXTuIG14clfG9j0YapkvkCjIpoNXx3EFgUFUMD4xJXVodtElVaKpYh33G3RFulfhUL
	FLJfwwUAjuFwwrR71y+tIAP0MmO3oHY0y2C+GM8tPBMYP7tDU3KVmtx1h9vS2dN12cUaDFslTnw
	kTvxJsQKykUxzec831V7U6B0c7XiuEdsD5p0wjdIQ3RHPey6mgB+/X5vZu5js1jbEFophsWPcNM
	zWvqINPV3ci+9NqXuPodqjJb/w5qnSjcV/pi8CakWcds4r8TSfZELoQSqYM/TBWgYMMMLQf0mOQ
	h+f+YAAfb46aC1K3gdvslMk0xEZzH+vPsEc/M6MQeNKoBaKr47GjN2ZfB5kl9ckZkO/uIkvh+XW
	s3Ty0Cdh25WWgyK07or8CrrAopU6WeS30DBo0wo739hVwvBykn1oacC7kHGbb35QC9OfybXpVaN
	8le4WUCShrQFgUwVqfk=
X-Received: by 2002:a05:690e:e81:b0:66f:9564:7827 with SMTP id 956f58d0204a3-6717fc61321mr2344146d50.22.1789933186912;
        Sun, 20 Sep 2026 12:39:46 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a482d3648sm18573057b3.39.2026.09.20.12.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:39:46 -0700 (PDT)
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
Subject: [RFC PATCH 29/46] KVM: caretaker: Implement Caretaker session memory mapping helpers
Date: Sun, 20 Sep 2026 15:36:33 -0400
Message-ID: <20260920193650.3373435-30-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
References: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_123948_231780_C5FAC068 
X-CRM114-Status: GOOD (  21.48  )
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

Implement Caretaker guest memory mapping, control block transitions,
and architecture ops registration in virt/kvm/caretaker.c.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 virt/kvm/caretaker.c | 452 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 452 insertions(+)
 create mode 100644 virt/kvm/caretaker.c

diff --git a/virt/kvm/caretaker.c b/virt/kvm/caretaker.c
new file mode 100644
index 000000000000..b4a203562727
--- /dev/null
+++ b/virt/kvm/caretaker.c
@@ -0,0 +1,452 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ *
+ * Core KVM Caretaker common execution engine and lifecycle management.
+ */
+
+/**
+ * DOC: KVM Caretaker Architecture and Lifecycle
+ *
+ * Overview: Orphaned Virtual Machines During Live Update
+ * ------------------------------------------------------
+ * During a host kernel Live Update (kexec), the userspace VMM and the outgoing
+ * Linux kernel tear down and vanish while the incoming kernel boots and a new
+ * userspace VMM process adopts the preserved state.  Throughout this handover
+ * window, preserved virtual machines are temporarily "orphaned" from any full
+ * host operating system or userspace VMM.
+ *
+ * Instead of freezing all guest vCPUs in RAM for the duration of kexec, the KVM
+ * Caretaker framework keeps preserved guest vCPUs actively executing on
+ * preserved physical CPUs (CONFIG_LIVEUPDATE_CPU) scheduled by the On-Core
+ * runtime (CONFIG_LIVEUPDATE_ONCORE).  When a Live Update session has preserved
+ * physical CPUs attached, Caretaker detaches each vCPU into a self-contained
+ * KHO-preserved runtime page and schedules it on the preserved cores
+ * (%KVM_VCPU_LUO_FLAG_CARETAKER).  If a session has zero preserved physical
+ * CPUs, Caretaker transparently falls back to RAM-only vCPU preservation.
+ *
+ * System Layering
+ * ---------------
+ * Orphaned VM execution is structured across four layers:
+ *
+ * 1. Physical CPU Preservation (kernel/liveupdate/cpu_preserve.c):
+ *    Isolates physical CPU cores from Linux hotplug teardown on dedicated
+ *    KHO-preserved stacks (&struct cpu_preserved_stack_context), switches them
+ *    to isolated page tables (&struct cpu_preserved_as) mapping only
+ *    .text.cpu_preserved and .data.cpu_preserved outside KHO Scratch memory,
+ *    and provides cache-coherency and cross-CPU wake primitives.
+ *
+ * 2. On-Core Session & Scheduler (kernel/liveupdate/oncore.c):
+ *    Groups preserved physical CPUs and an isolated address space per
+ *    &struct liveupdate_session, and runs a lockless round-robin FIFO
+ *    scheduler (oncore_cpu_schedule_loop()) that time-slices M workload jobs
+ *    across N preserved physical CPUs (supporting both 1:1 dedicated pinning
+ *    and M > N oversubscription).
+ *
+ * 3. Common KVM Caretaker Engine:
+ *    Implements the architecture-neutral vCPU quantum loop
+ *    (kvm_caretaker_vcpu_run()), normalized VM-exit dispatch
+ *    (kvm_caretaker_dispatch_exit()), guest idle handling (HLT/PAUSE/WFI),
+ *    unhandled-exit stall parking (%ONCORE_EXIT_STALL), lockless control-block
+ *    state transitions (&struct kvm_caretaker_cb_ser), and KVM LUO lifecycle
+ *    hooks.
+ *
+ * 4. Architecture & Vendor Backends (arch/x86/kvm/ and arch/arm64/kvm/):
+ *    Implement &struct kvm_caretaker_ops (guest entry/exit assembly, hardware
+ *    timer programming, and VMCS/VMCB/EL2 context management) and self-contained
+ *    on-core emulation for performance-critical exits (early UART console,
+ *    CPUID, MSRs, RDTSC, GICv3 CPU interface / SGI delivery, and architectural
+ *    timers) while keeping guest EPT/NPT/Stage-2 page tables live in hardware.
+ *
+ * Orphaned vCPU Lifecycle and State Machine
+ * -----------------------------------------
+ * Each vCPU's KHO-preserved control block (&struct kvm_caretaker_cb_ser)
+ * transitions through four phases across a live update:
+ *
+ * 1. Pre-Preserve & Activation (Outgoing Kernel -- LUO Prepare/Freeze):
+ *    - kvm_caretaker_vcpu_pre_preserve() submits an &struct oncore_job for
+ *      kvm_arch_vcpu_caretaker_run() to the session's least-loaded preserved
+ *      physical CPU and sets %KVM_VCPU_LUO_FLAG_CARETAKER.
+ *    - kvm_arch_vcpu_luo_preserve() allocates the architecture Caretaker page,
+ *      preserves stage-2/TDP MMU page tables, captures guest register and
+ *      virtualization hardware state, and calls kvm_caretaker_init_common_vcpu()
+ *      to map the runtime page into the session's isolated PGD and initialize
+ *      @cb->state to %KVM_CARETAKER_PAUSED.
+ *    - kvm_caretaker_vcpu_post_preserve() binds @cb to the job, cleans @cb to
+ *      PoC, and calls oncore_session_activate_job() to enqueue the job and kick
+ *      the assigned preserved physical CPU.
+ *
+ * 2. Orphaned On-Core Execution (Across Kexec Handover):
+ *    - The preserved CPU invokes kvm_arch_vcpu_caretaker_run(), which
+ *      atomically transitions @cb->state from %KVM_CARETAKER_PAUSED to
+ *      %KVM_CARETAKER_RUNNING and calls kvm_caretaker_vcpu_run().
+ *    - kvm_caretaker_vcpu_run() arms the preemption timer for @deadline_ticks
+ *      and repeatedly enters the guest (ops->enter_guest()), decodes exits
+ *      (ops->decode_exit()), and dispatches on-core handlers.
+ *    - When the time quantum expires (%ONCORE_EXIT_QUANTUM_EXPIRED), the guest
+ *      executes HLT/WFI (%ONCORE_EXIT_YIELD_IDLE), or an exit cannot be
+ *      emulated on-core (%ONCORE_EXIT_STALL, leaving RIP/PC on the faulting
+ *      instruction), the backend serializes live hardware state into
+ *      @ser->arch_state, transitions @cb->state back to %KVM_CARETAKER_PAUSED,
+ *      and returns to the On-Core scheduler.
+ *
+ * 3. Re-Attachment & Adoption (Incoming Kernel -- LUO Retrieve/Finish):
+ *    - During LUO retrieve, kvm_caretaker_vcpu_pre_retrieve() invokes
+ *      kvm_arch_vcpu_luo_pre_retrieve_caretaker(), which calls
+ *      kvm_caretaker_wait_for_attach().
+ *    - Fast path: if @cb->state is %KVM_CARETAKER_PAUSED, a single cmpxchg()
+ *      transitions it to %KVM_CARETAKER_STOPPED immediately.
+ *    - Slow path: if @cb->state is %KVM_CARETAKER_RUNNING, it transitions to
+ *      %KVM_CARETAKER_STOPPING and sends an IPI kick to force a VM exit.  The
+ *      preserved CPU observes kvm_caretaker_should_exit(), serializes final
+ *      guest state into @ser->arch_state, publishes %KVM_CARETAKER_STOPPED, and
+ *      exits with %ONCORE_EXIT_ATTACH_SIGNALED.
+ *    - kvm_arch_vcpu_luo_retrieve() and kvm_caretaker_vcpu_retrieve() then
+ *      load the updated state into the incoming &struct kvm_vcpu and resume
+ *      normal KVM execution.
+ *
+ * 4. Cancellation / Rollback (Outgoing Kernel -- LUO Unpreserve):
+ *    - If live update is cancelled before kexec, kvm_caretaker_vcpu_unpreserve()
+ *      executes the same attach handshake to stop the vCPU on the preserved
+ *      core, synchronizes any guest state changes back into the outgoing
+ *      &struct kvm_vcpu, and cancels the job via oncore_session_cancel_job().
+ */
+
+#include <linux/cpu_preserve.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/kho/abi/kvm.h>
+#include <linux/kvm_caretaker.h>
+#include <linux/kvm_host.h>
+#include <linux/liveupdate.h>
+#include <linux/objtool.h>
+#include <linux/oncore.h>
+
+/**
+ * kvm_caretaker_vcpu_is_attached - Check whether a vCPU has attached back to host KVM
+ * @vcpu: Target KVM vCPU.
+ *
+ * Return: %true if @vcpu is not running under Caretaker (control block is %NULL
+ *         or in %KVM_CARETAKER_STOPPED), %false if still owned by Caretaker.
+ */
+bool kvm_caretaker_vcpu_is_attached(struct kvm_vcpu *vcpu)
+{
+	return kvm_caretaker_is_stopped(vcpu->caretaker.cb);
+}
+
+/**
+ * kvm_caretaker_init_common_vcpu - Initialize common Caretaker vCPU runtime state
+ * @cvcpu:        Common Caretaker vCPU descriptor to initialize.
+ * @cb:           KHO-preserved Caretaker control block embedded in the arch page.
+ * @vcpu:         Host KVM vCPU being preserved.
+ * @runtime_va:   Virtual address of the architecture Caretaker runtime page.
+ * @runtime_size: Size in bytes of @runtime_va.
+ * @ops:          Architecture operations table (&struct kvm_caretaker_ops).
+ * @arch_data:    Architecture context pointer passed to @ops callbacks.
+ *
+ * Initializes @cb in %KVM_CARETAKER_PAUSED state with the preserved physical
+ * CPU ID assigned to @vcpu->caretaker.job, maps the runtime buffer into the
+ * On-Core session's isolated page tables, and allocates KHO telemetry state.
+ */
+void kvm_caretaker_init_common_vcpu(struct kvm_caretaker_vcpu *cvcpu,
+				    struct kvm_caretaker_cb_ser *cb,
+				    struct kvm_vcpu *vcpu,
+				    void *runtime_va,
+				    size_t runtime_size,
+				    const struct kvm_caretaker_ops *ops,
+				    void *arch_data)
+{
+	struct oncore_session *sess = oncore_job_session(vcpu->caretaker.job);
+
+	cb->state = KVM_CARETAKER_PAUSED;
+	cb->pcpu_id = oncore_job_cpu(vcpu->caretaker.job);
+	cb->vcpu_id = vcpu->vcpu_id;
+	cb->reserved = 0;
+	cb->telemetry.phys = 0;
+
+	cvcpu->cb = cb;
+	cvcpu->ops = ops;
+	cvcpu->arch_data = arch_data ? arch_data : cvcpu;
+	cvcpu->telemetry = NULL;
+
+	vcpu->caretaker.cb = cb;
+
+	oncore_session_map_buffer(sess, runtime_va, runtime_size);
+	kvm_caretaker_telemetry_init(cvcpu, sess);
+}
+
+/**
+ * kvm_caretaker_should_exit - Check whether the Caretaker vCPU loop must exit for attachment
+ * @cvcpu: Common Caretaker vCPU descriptor.
+ *
+ * Invalidates cache lines for @cvcpu->cb and checks whether the host kernel has
+ * requested attachment (%KVM_CARETAKER_STOPPING / %KVM_CARETAKER_STOPPED) or
+ * whether the underlying preserved physical CPU is exiting its workload loop.
+ *
+ * Return: %true if the vCPU must immediately exit guest execution and serialize
+ *         its state for host attachment, %false otherwise.
+ */
+bool __cpu_preserved_text
+kvm_caretaker_should_exit(struct kvm_caretaker_vcpu *cvcpu)
+{
+	struct cpu_preserved_stack_context *sctx;
+	u32 st;
+
+	cpu_preserved_inval(cvcpu->cb);
+
+	st = READ_ONCE(cvcpu->cb->state);
+	if (st != KVM_CARETAKER_PAUSED && st != KVM_CARETAKER_RUNNING)
+		return true;
+
+	sctx = cpu_preserved_get_stack_context();
+	return cpu_preserved_should_exit(sctx ? sctx->cpu : cvcpu->cb->pcpu_id);
+}
+
+static bool __cpu_preserved_text
+kvm_caretaker_dispatch_exit(struct kvm_caretaker_vcpu *cvcpu,
+			    struct kvm_caretaker_exit *exit)
+{
+	switch (exit->type) {
+	case KVM_CARETAKER_EXIT_IDLE:
+		cpu_relax();
+		exit->rip += exit->insn_len;
+		return false;
+
+	case KVM_CARETAKER_EXIT_PREEMPT_TIMER:
+	case KVM_CARETAKER_EXIT_UNHANDLED:
+	case KVM_CARETAKER_EXIT_UNKNOWN:
+		return false;
+
+	case KVM_CARETAKER_EXIT_CONSOLE:
+	case KVM_CARETAKER_EXIT_CROSS_VCPU:
+	case KVM_CARETAKER_EXIT_INSN_STEP:
+	case KVM_CARETAKER_EXIT_ARCH:
+	default:
+		if (cvcpu->ops->handle_arch_exit)
+			return cvcpu->ops->handle_arch_exit(cvcpu->arch_data,
+							    exit);
+		return false;
+	}
+}
+STACK_FRAME_NON_STANDARD(kvm_caretaker_dispatch_exit);
+
+static int __cpu_preserved_text
+kvm_caretaker_enter_guest(struct kvm_caretaker_vcpu *cvcpu)
+{
+	void *arch_data = cvcpu->arch_data;
+	int ret;
+
+	ret = cvcpu->ops->enter_guest(arch_data);
+	kvm_caretaker_telemetry_run(cvcpu);
+	if (ret && !kvm_caretaker_should_exit(cvcpu)) {
+		cpu_relax();
+		ret = cvcpu->ops->enter_guest(arch_data);
+		kvm_caretaker_telemetry_run(cvcpu);
+	}
+	if (ret)
+		kvm_caretaker_telemetry_stall(cvcpu, (u32)ret, 0);
+
+	return ret;
+}
+STACK_FRAME_NON_STANDARD(kvm_caretaker_enter_guest);
+
+static bool __cpu_preserved_text
+kvm_caretaker_handle_exit(struct kvm_caretaker_vcpu *cvcpu,
+			  enum oncore_exit_reason *reason)
+{
+	const struct kvm_caretaker_ops *ops = cvcpu->ops;
+	struct kvm_caretaker_exit exit __uninitialized;
+	void *arch_data = cvcpu->arch_data;
+	bool handled;
+
+	cpu_preserved_memset(&exit, 0, sizeof(exit));
+	if (ops->decode_exit)
+		ops->decode_exit(arch_data, &exit);
+
+	kvm_caretaker_telemetry_exit(cvcpu, &exit);
+	if (kvm_caretaker_should_exit(cvcpu))
+		return false;
+
+	handled = kvm_caretaker_dispatch_exit(cvcpu, &exit);
+	if (ops->advance_rip)
+		ops->advance_rip(arch_data, exit.rip);
+	if (handled)
+		return true;
+
+	/*
+	 * A preemption-timer exit is the normal end of a time slice, so leave
+	 * @reason alone for it.  For anything else nothing emulated the exit
+	 * and RIP was left on the faulting instruction, so re-entering the
+	 * guest would take the exact same exit again.  Tell the scheduler the
+	 * job is stuck rather than letting it look like an expired time slice,
+	 * so that it backs off instead of spinning on VM entry/exit until the
+	 * incoming kernel reclaims the vCPU.
+	 */
+	if (exit.type == KVM_CARETAKER_EXIT_IDLE) {
+		*reason = ONCORE_EXIT_YIELD_IDLE;
+	} else if (exit.type != KVM_CARETAKER_EXIT_PREEMPT_TIMER) {
+		*reason = ONCORE_EXIT_STALL;
+		kvm_caretaker_telemetry_stall(cvcpu, exit.raw_reason, exit.rip);
+	}
+
+	return false;
+}
+STACK_FRAME_NON_STANDARD(kvm_caretaker_handle_exit);
+
+/**
+ * kvm_caretaker_vcpu_run - Common hardware vCPU execution loop for Caretaker
+ * @cvcpu:          Common Caretaker vCPU descriptor.
+ * @deadline_ticks: Hardware counter deadline for the current scheduling quantum.
+ *
+ * Arms the hardware preemption timer for @deadline_ticks and repeatedly enters
+ * the guest via @cvcpu->ops->enter_guest(), decodes VM exits, and dispatches
+ * on-core exit handlers until the time slice expires, the guest yields on
+ * HLT/WFI, the incoming kernel signals attachment, or an unhandled exit stalls
+ * the vCPU.
+ *
+ * Context: Preserved physical CPU (__cpu_preserved_text) with IRQs disabled.
+ * Return: &enum oncore_exit_reason indicating why the vCPU left the loop.
+ */
+enum oncore_exit_reason __cpu_preserved_text
+kvm_caretaker_vcpu_run(struct kvm_caretaker_vcpu *cvcpu, u64 deadline_ticks)
+{
+	struct cpu_preserved_stack_context *sctx = cpu_preserved_get_stack_context();
+	enum oncore_exit_reason reason = ONCORE_EXIT_QUANTUM_EXPIRED;
+	const struct kvm_caretaker_ops *ops = cvcpu->ops;
+	void *arch_data = cvcpu->arch_data;
+
+	if (sctx)
+		cvcpu->cb->pcpu_id = sctx->cpu;
+
+	if (kvm_caretaker_should_exit(cvcpu))
+		return ONCORE_EXIT_ATTACH_SIGNALED;
+
+	if (ops->pre_run)
+		ops->pre_run(arch_data);
+
+	if (ops->arm_timer)
+		ops->arm_timer(arch_data, deadline_ticks);
+
+	while (!kvm_caretaker_should_exit(cvcpu)) {
+		if (arch_oncore_read_counter() >= deadline_ticks)
+			break;
+
+		if (kvm_caretaker_enter_guest(cvcpu)) {
+			reason = ONCORE_EXIT_ERROR;
+			break;
+		}
+
+		if (!kvm_caretaker_handle_exit(cvcpu, &reason))
+			break;
+	}
+
+	if (ops->disarm_timer)
+		ops->disarm_timer(arch_data);
+
+	if (ops->post_run)
+		ops->post_run(arch_data);
+
+	kvm_caretaker_telemetry_flush(cvcpu);
+
+	if (kvm_caretaker_should_exit(cvcpu))
+		return ONCORE_EXIT_ATTACH_SIGNALED;
+
+	return reason;
+}
+STACK_FRAME_NON_STANDARD(kvm_caretaker_vcpu_run);
+
+#define KVM_CARETAKER_ATTACH_TIMEOUT_US		2000000
+#define KVM_CARETAKER_ATTACH_STEP_US		10
+#define KVM_CARETAKER_ATTACH_KICK_STEPS		100
+
+static bool kvm_caretaker_try_stop(struct kvm_caretaker_cb_ser *cb)
+{
+	cpu_preserved_inval(cb);
+
+	if (READ_ONCE(cb->state) == KVM_CARETAKER_STOPPED)
+		return true;
+
+	if (cmpxchg(&cb->state, KVM_CARETAKER_PAUSED,
+		    KVM_CARETAKER_STOPPED) == KVM_CARETAKER_PAUSED) {
+		cpu_preserved_clean(cb);
+		return true;
+	}
+
+	return false;
+}
+
+/**
+ * kvm_caretaker_wait_for_attach - Stop a Caretaker vCPU and wait for state serialization
+ * @cb:   KHO-preserved Caretaker control block.
+ * @pcpu: Logical ID of the preserved physical CPU running the vCPU.
+ *
+ * Synchronizes with the preserved physical CPU executing @cb so that the vCPU
+ * exits guest mode, serializes its final architectural state into KHO memory,
+ * and reaches %KVM_CARETAKER_STOPPED before the host kernel reads back the
+ * serialized state.
+ *
+ * Return: 0 on success, or -ETIMEDOUT if the preserved CPU failed to stop.
+ */
+int kvm_caretaker_wait_for_attach(struct kvm_caretaker_cb_ser *cb, int pcpu)
+{
+	int i;
+
+	if (!cb || kvm_caretaker_try_stop(cb))
+		return 0;
+
+	if (!cpu_is_preserved(pcpu)) {
+		WRITE_ONCE(cb->state, KVM_CARETAKER_STOPPED);
+		cpu_preserved_clean(cb);
+		/* Ensure state update is visible before returning to caller */
+		smp_wmb();
+		return 0;
+	}
+
+	/*
+	 * Slow path: the vCPU is actively executing a quantum on the preserved
+	 * physical CPU (%KVM_CARETAKER_RUNNING).  Request a stop by moving it
+	 * to %KVM_CARETAKER_STOPPING, send an IPI kick to force a VM exit, and
+	 * spin until the preserved CPU finishes detach_serialize() and publishes
+	 * %KVM_CARETAKER_STOPPED.
+	 */
+	cmpxchg(&cb->state, KVM_CARETAKER_RUNNING, KVM_CARETAKER_STOPPING);
+	cpu_preserved_clean(cb);
+	/* Order state update before kicking and polling the preserved CPU */
+	smp_mb();
+
+	for (i = 0; i < KVM_CARETAKER_ATTACH_TIMEOUT_US / KVM_CARETAKER_ATTACH_STEP_US; i++) {
+		if (i % KVM_CARETAKER_ATTACH_KICK_STEPS == 0)
+			arch_cpu_preserved_kick(pcpu);
+		if (kvm_caretaker_try_stop(cb))
+			return 0;
+		udelay(KVM_CARETAKER_ATTACH_STEP_US);
+	}
+
+	pr_warn("kvm: caretaker attach handshake timed out for pCPU %d\n", pcpu);
+	return -ETIMEDOUT;
+}
+STACK_FRAME_NON_STANDARD(kvm_caretaker_wait_for_attach);
+
+/**
+ * kvm_caretaker_post_attach_vcpu - Finalize host vCPU state after Caretaker attachment
+ * @vcpu: KVM vCPU that has just re-attached from Caretaker.
+ *
+ * Resets @vcpu->mode and @vcpu->cpu, reports Caretaker execution telemetry to
+ * the kernel log and vCPU debugfs snapshot, marks the control block stopped,
+ * and clears @vcpu->caretaker.cb.
+ */
+void kvm_caretaker_post_attach_vcpu(struct kvm_vcpu *vcpu)
+{
+	/* Ensure vCPU mode update is globally visible before clearing cpu */
+	smp_store_mb(vcpu->mode, EXITING_GUEST_MODE);
+	vcpu->cpu = -1;
+
+	if (vcpu->caretaker.cb) {
+		kvm_caretaker_telemetry_report(vcpu, vcpu->caretaker.cb);
+		kvm_caretaker_stop(vcpu->caretaker.cb);
+		vcpu->caretaker.cb = NULL;
+	}
+}
+
-- 
2.55.0.1082.g2b9226bbc0-goog


