Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ABD5C982F8
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WJieeIgM+cp8bkpFe8Ny3KapR5wdIQZOgEecLTuA7iY=; b=3X4uuRZHAEC4z8dvC4nrqygiBh
	16ZzuFxdDFWG8JO+zpPvCv8tRTXPdYQ4qEhARgRiJqzEzalr6JJ+pQMFCBhy08PK+8hnPMwY0HnQO
	FBjyKoHslHPYy4jp5B6PXD+bUfc3to1LV1E1+I89nDrvK2hb6AW8eaFhxmbBEgUPakg0kBUvp6Uy1
	hVKCcuQQugp4/lelde24x+IKKnEIlXIoyqBO+DyC2ZNSFcX0T5UuWTjLXM6NJCI6DvAqkR63vWGAP
	D06GGbOm0jZsYJrxx3tNU/8Sv3+qzs2ZRwiw7XdUST2tCGnFfe12eUC/Mbeqy5CmaiVgBwmnLkWJt
	2cpQsxkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4N-00000000MHs-18LI;
	Sun, 20 Sep 2026 20:23:27 +0000
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8NMi-00000000Ijn-093P
	for kexec@lists.infradead.org;
	Sun, 20 Sep 2026 19:38:22 +0000
Received: by mail-yx2-x10.google.com with SMTP id 00721157ae682-85d43db0c17so19945367b3.3
        for <kexec@lists.infradead.org>; Sun, 20 Sep 2026 12:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789933099; x=1790537899; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WJieeIgM+cp8bkpFe8Ny3KapR5wdIQZOgEecLTuA7iY=;
        b=bB/NdU8pc1meXQf5c623ayDVmzCj3SIgLXno6C85jN6jb2Wwj1OOCnkUQ1BxgMPH2H
         jEJkyf5/1N9IOjr+s3CJ/kzhxrkX7IIhOrexMmx298R6n7IfY8oi0JYRuGoph53BdUNT
         6JisXgvJkst3m0aKqtMkLgd3HRRVgZea7YagRIv1iFUaEsTHQf2MpgGHpxq5f9Y/KNtB
         Aupi+RNkjn2t8u15UtqEGtFF43709vfkh0MOdwPjLDNpPZ+1gTCVMUQmTJ8P6BvzBt6O
         54KwpYH4IfKjOLwg/4W5189K90XprfuA/5/oNJ/Q/+ukzXUSSeTZv/YVSW1eHvcEgQ3c
         wM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933099; x=1790537899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WJieeIgM+cp8bkpFe8Ny3KapR5wdIQZOgEecLTuA7iY=;
        b=rFr76BNkkXjssXyK7ola2W/H33qoEqzCw24AKTTJthjNPiTIs5fhOTDqKzQgXmYEZN
         JehUZKye+PV85x8hSVIPsLmllbE21XdQSwD7ci1CkqYJJNG/vTfQWZu/1o5D4fub+TMv
         C6a62BDZQBJpGpYcYlIHMkDuCsKqr2nZwHvq2/kQuWKSRhMs+mV0UOxIwobtBBz3/9na
         Vd85kSO+Xx687+HG0h14yT99sJPF7yWhIciE2AOn8s7qCQEDvkbyTI5J/PGL1NrvvP4m
         jhXTjSUXSzelaUcufgXCArY0HroRgcoUohwsEyiyBPO/nW9w1KHkn3+SwvuOyEjzEhQM
         1RkQ==
X-Forwarded-Encrypted: i=1; AKwUvBx2pbBeSk/iBsnx9gwiXYRfm1xUOhkKDFfyExn+yN9w6IG3XmgyNhrHpZLVqctClAttk9PwxA==@lists.infradead.org
X-Gm-Message-State: AFuF++mMAt2O+Ig09S0g5D1EmPqav0SzioYamlDVDbgzhD9WGw7lviIc
	5tI/Ubxvs8OROEJCiCVGOn5pDSwGubdT9oMH4fFt0j30v0Qmrax7oCpyjhRI8X69vKY=
X-Gm-Gg: AYBFou1cfm8p0ZoyKXW7qGOXMZ8VXpJ9xjDprXTyefYpIWTG38S88RqHrN14dyJ1hcF
	PlTO825q4PadUUnOPwQWA75nQ87/yC0uPfwaWsbKYiI1LYNHqabpAkLQqYNcBTaMmZrSHk3FGnR
	ZMzFEK4T7Aj+xrIpFKrcnB13JX1wvkgSdiWHe4qUEesvvqM5EtKBkT9QxkMAPsAubghIzXxTShc
	USfhpIyV68ZIjc4wRWY38v9TflDIlsAknMwk8HbR/eca6JwlEEPyxbAnETWpX1ZXGJee7gDplZe
	2So9kd1IW5sW40HiFi8HjuOzhkMkf5yjrToGYxGyEa1bKYCzGeWNlazRln/VEVy8JhedC+aH0NF
	KuGvHOOO9fhjfjH3794oXuZ28/ys3IpnGK+YwyOFe8xszoRU3v97biLnXYk/TMpMipIjTaJWgoy
	igpqpZpffZHUB2HD3ESSrtmn0SHySTrfWTdNRAFTa71NmWhtQVlzAR4CWUFp0ZnYhuZ+0yWZsxi
	UuqlyjY8wPhn1upD/q51w7YA/R4pFaQIJsRdPHW0jxkv3ljIy4Y48V+WF/D3WfwYWn+qRK0ib1A
	/i6iU677Engq1ES0VrTQ6qM/OCn4ug==
X-Received: by 2002:a05:690c:ec4:b0:873:5c6b:a2fb with SMTP id 00721157ae682-897363672acmr24218447b3.41.1789933098791;
        Sun, 20 Sep 2026 12:38:18 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a415208bfsm19238877b3.3.2026.09.20.12.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:38:18 -0700 (PDT)
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
Subject: [RFC PATCH 14/46] cpu_preserve: Add core physical CPU preservation state and park loop
Date: Sun, 20 Sep 2026 15:36:18 -0400
Message-ID: <20260920193650.3373435-15-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
References: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_123820_303875_AC2685BC 
X-CRM114-Status: GOOD (  23.77  )
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

Introduce the physical CPU preservation state tracking, cache maintenance
wrappers, and standalone park execution loop in
kernel/liveupdate/cpu_preserve.c.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/cpu_preserve.c | 249 +++++++++++++++++++++++++++++++
 1 file changed, 249 insertions(+)
 create mode 100644 kernel/liveupdate/cpu_preserve.c

diff --git a/kernel/liveupdate/cpu_preserve.c b/kernel/liveupdate/cpu_preserve.c
new file mode 100644
index 000000000000..e19208670c3e
--- /dev/null
+++ b/kernel/liveupdate/cpu_preserve.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+/**
+ * DOC: Preserved CPU Subsystem
+ *
+ * Live Update allows updating the host kernel while preserving the state of
+ * hardware resources across the transition. While memfd-based memory
+ * preservation is supported via LUO and PCI device preservation is handled
+ * by VFIO and IOMMU, physical CPU cores represent another fundamental class
+ * of hardware resource that requires preservation.
+ *
+ * A primary motivation is preserving virtual machine (VM) workloads across
+ * host kernel updates without pausing the guest. By separating a physical
+ * core from standard host scheduling and keeping it active across the kexec
+ * reboot, guest vCPUs or dedicated bare-metal tasks can continue
+ * uninterrupted execution on-core.
+ *
+ * This subsystem provides the generic, hypervisor-agnostic foundation for
+ * physical CPU preservation.
+ *
+ * Lifecycle
+ * =========
+ *
+ * CPU lifecycle state progression::
+ *
+ *     +-------------------------------------------------------------+
+ *     |                          ONLINE                             |
+ *     |               (Normal host task scheduling)                 |
+ *     +-------------------------------------------------------------+
+ *                                    |
+ *                                    | preserve (via LUO fd)
+ *                                    v
+ *     +-------------------------------------------------------------+
+ *     |                     PRESERVED_PARKED                        |
+ *     |          (Removed from scheduler, loops in park)            |
+ *     +-------------------------------------------------------------+
+ *                                    |
+ *                                    | [Live Update: kexec]
+ *                                    v
+ *     +-------------------------------------------------------------+
+ *     |                     INCOMING PRESERVED                      |
+ *     |         (Parked on-core, skipped in secondary boot)         |
+ *     |       (State restored upon session retrieve; stays running) |
+ *     +-------------------------------------------------------------+
+ *                                    |
+ *                                    | unpreserve / finish (via LUO session)
+ *                                    v
+ *     +-------------------------------------------------------------+
+ *     |                          OFFLINE                            |
+ *     |            (Park loop exited, architecturally idle)         |
+ *     +-------------------------------------------------------------+
+ *                                    |
+ *                                    | automatic add_cpu()
+ *                                    v
+ *     +-------------------------------------------------------------+
+ *     |                          ONLINE                             |
+ *     |                (Rejoined host scheduling)                   |
+ *     +-------------------------------------------------------------+
+ *
+ * File Descriptor Binding
+ * =======================
+ *
+ * 1. **Sysfs control file:** Each hotpluggable CPU exports a read-only sysfs
+ *    attribute at ``/sys/devices/system/cpu/cpu<N>/preserve``. The file
+ *    descriptor of this file handles the lifecycle of the preserved CPU.
+ *
+ * 2. **Preservation via LUO:** Userspace opens this file and registers the fd
+ *    with LUO. Preserving the file offlines the core from host scheduling,
+ *    migrates its interrupts and tasks, and transitions the CPU from online
+ *    into the parked state (cpu_preserved_park()). Preservation integrates with
+ *    the On-Core framework (oncore_session_add_cpu()).
+ *
+ * 3. **KHO and memory preservation:** The parking loop, dedicated preserved
+ *    CPU stacks, runtime execution buffers outside Scratch memory, and
+ *    preserved CPU state reside in memory preserved across kexec via KHO.
+ *
+ * 4. **Incoming boot:** During early boot, the incoming kernel restores the
+ *    preserved CPU mask from the KHO FLB before secondary SMP bringup and
+ *    skips bringing preserved cores online, maintaining isolation.
+ *
+ * 5. **Retrieval and unpreservation:** When userspace retrieves the session in
+ *    the incoming kernel, it receives the open ``preserve`` file descriptor.
+ *    Retrieving the session reconnects the descriptors and restores on-core session
+ *    state while keeping the core running. Finalizing the session (``finish``)
+ *    or closing the fd unpreserves the CPU, signaling the core to exit the
+ *    parking loop and automatically restoring it online via add_cpu().
+ *
+ * Architecture Requirements
+ * =========================
+ *
+ * In addition to CPU hotplug (``CONFIG_HOTPLUG_CPU``), an architecture
+ * selecting ``ARCH_SUPPORTS_LIVEUPDATE_CPU`` must provide:
+ *
+ * - **Linker script:** Include ``CPU_PRESERVED_TEXT`` in
+ *   ``arch/<arch>/kernel/vmlinux.lds.S`` within the executable text section.
+ *
+ * - **Preserved text section:** Functions executed by a parked core or during
+ *   live update transitions must be annotated with ``__cpu_preserved_text`` so
+ *   their instructions reside in the KHO-preserved ``.text.cpu_preserved``
+ *   section. These are the ``arch_cpu_preserved_*()`` hooks documented in
+ *   ``include/linux/cpu_preserve.h``.
+ *
+ * - **Address-space mapping hooks:** arch_cpu_preserved_as_map(),
+ *   arch_cpu_preserved_as_flush_tlb(), and
+ *   arch_cpu_preserved_set_transition_as() populate and manage isolated page
+ *   tables built by the core layer using cpu_preserved_as_alloc_page().
+ *
+ * - **Buffer relocation hook:** arch_cpu_preserved_setup_buffer() relocates
+ *   preserved text and data sections outside KHO Scratch memory so the
+ *   incoming kernel can unpack safely.
+ *
+ * - **CPU hotplug and stop-IPI isolation:** Exclude preserved CPUs from stop
+ *   signals (NMI or stop IPIs in the machine reboot and crash paths), and
+ *   avoid tearing down local interrupt controllers (LAPIC, GIC CPU interface)
+ *   during CPU disable when the core is being preserved.
+ *
+ * Isolated Address Space
+ * ======================
+ *
+ * A preserved core does not run on the kernel's own page tables. Before it is
+ * handed over, the core layer builds a transition page table
+ * (cpu_preserved_as_create()) containing only what on-core execution needs,
+ * so that a core still running a workload cannot touch memory the new kernel
+ * has taken ownership of:
+ *
+ * - Preserved text and read-only data, ``PAGE_KERNEL_ROX``
+ *   (``__cpu_preserved_text``) -- park loops, world-switch routines, ops
+ *   vector tables, and exception stubs;
+ * - Preserved writable globals, ``PAGE_KERNEL`` NX
+ *   (``__cpu_preserved_data``) -- state machines, session descriptors,
+ *   per-CPU control blocks, and the preserved-CPU masks;
+ * - The per-CPU dedicated preserved stack, ``PAGE_KERNEL`` NX;
+ * - The KHO-preserved workload state pages, ``PAGE_KERNEL`` NX;
+ * - Hardware control MMIO, ``PAGE_KERNEL_IO``, only where the interrupt
+ *   controller still requires it (e.g., GICv3 in system-register mode needs
+ *   none).
+ *
+ * Deliberately absent: the linear direct map, all user address ranges, the
+ * kernel heap, vmalloc, modules, and BPF JIT. Guest memory is not mapped
+ * either -- it is reached through stage-2 translation.
+ *
+ * On arm64 these mappings are built with trans_pgd_map_range(), on x86 with
+ * the identity-map helpers in ``arch/x86/mm/ident_map.c``. Custom workload
+ * address spaces can also be created and adopted across kexec via
+ * cpu_preserved_as_adopt().
+ *
+ * Workload Integration
+ * ====================
+ *
+ * Physical cores preserved across live update execute payloads managed by the
+ * On-Core execution framework. CPU preservation integrates directly with On-Core
+ * session lifecycle:
+ *
+ * - On-Core assigns jobs to preserved cores via cpu_preserved_attach_workload().
+ * - When a CPU file is preserved or unpreserved, oncore_session_add_cpu() and
+ *   oncore_session_remove_cpu() update the session CPU bitmap.
+ * - At kexec handover, oncore_session_get_ser() serializes the session state into
+ *   the preserved CPU file descriptor, and oncore_session_restore() reconstructs
+ *   the session in the incoming kernel.
+ */
+
+#define pr_fmt(fmt) "cpu_preserve: " fmt
+
+#include <linux/cpu.h>
+#include <linux/cpu_preserve.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/device/bus.h>
+#include <linux/kexec.h>
+#include <linux/kexec_handover.h>
+#include <linux/kho/abi/cpu.h>
+#include <linux/kho_block.h>
+#include <linux/liveupdate.h>
+#include <linux/mm.h>
+#include <linux/objtool.h>
+#include <linux/reboot.h>
+
+#include <asm/sections.h>
+
+/**
+ * struct cpu_preserved_pcpu - Per-CPU host runtime state for CPU preservation
+ * @stack_pa: Physical address of the preserved stack for this CPU.
+ * @pgd_pa: Page table root PA for the preserved CPU context.
+ * @entry_fn: Workload callback function executed repeatedly on the physical
+ *            core while parked in cpu_preserved_park().
+ * @entry_data: Opaque argument passed to @entry_fn.
+ *
+ * Tracks host runtime state for a preserved physical core. Allocated locally
+ * in host memory; not preserved across kexec handover.
+ */
+struct cpu_preserved_pcpu {
+	phys_addr_t stack_pa;
+	phys_addr_t pgd_pa;
+	void (*entry_fn)(void *data) ____cacheline_aligned;
+	void *entry_data;
+};
+
+/*
+ * struct cpu_preserved_state - Host-side preserved CPU state (incoming or outgoing)
+ * @mask: Mask of preserved CPUs.
+ * @pcpus: Host runtime state array.
+ * @pcpus_ser: Per-CPU mailbox array in preserved memory.
+ */
+struct cpu_preserved_state {
+	cpumask_t mask;
+	struct cpu_preserved_pcpu *pcpus;
+	struct cpu_preserved_pcpu_ser *pcpus_ser;
+};
+
+static DEFINE_MUTEX(cpu_preserved_lock);
+static struct cpu_preserved_state cpu_preserved_incoming;
+static struct cpu_preserved_state cpu_preserved_outgoing;
+static cpumask_t cpu_preserved_mask __cpu_preserved_data;
+static struct cpu_preserved_pcpu_ser *cpu_preserved_pcpus_va __cpu_preserved_data;
+static struct cpu_preserved_pcpu *cpu_preserved_host_pcpus_va __cpu_preserved_data;
+static struct cpu_preserved_global_ser *cpu_preserved_global_ser;
+
+static struct page *cpu_preserved_text_pages;
+static unsigned int cpu_preserved_text_order;
+static struct page *cpu_preserved_data_pages;
+static unsigned int cpu_preserved_data_order;
+static bool cpu_preserved_runtime_preserved;
+
+/*
+ * Address spaces are mapped into under @cpu_preserved_as_map_lock and
+ * enumerated under @cpu_preserved_as_list_lock.  cpu_preserved_map_range()
+ * holds the list lock across the map lock; nothing takes them the other way
+ * round.
+ */
+static DEFINE_MUTEX(cpu_preserved_as_list_lock);
+static DEFINE_MUTEX(cpu_preserved_as_map_lock);
+static LIST_HEAD(cpu_preserved_as_list);
+static struct cpu_preserved_as *cpu_preserved_transition_as;
+
+static phys_addr_t cpu_preserved_get_text_pa(void)
+{
+	return cpu_preserved_text_pages ? page_to_phys(cpu_preserved_text_pages) : 0;
+}
+
+static phys_addr_t cpu_preserved_get_data_pa(void)
+{
+	return cpu_preserved_data_pages ? page_to_phys(cpu_preserved_data_pages) : 0;
+}
+
-- 
2.55.0.1082.g2b9226bbc0-goog


