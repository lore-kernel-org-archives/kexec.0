Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6D4C982FB
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K5j5l9GIwIcGWU8WT7f8DcBXaOCqBMTT8VcXmZE9caw=; b=kT+HjpGtmWbZlSC5tnMFPrQFAk
	X+aZdluxn2eF8JptKbRlbFWXqQOzmaeuU53L0j37FtDl0XaFvOBRVe36AhlnKObFlQmF8QygytOVp
	/GaNJ/gIEmkeNSa1rBj3fokbdAj1ifACi7Yrtu0dr9Pj0zUHQdI4TTe9lSg0sm4wNFC8DNd0R8GOd
	K1E3I8vU78+RPvLxgVG8JD0FOGPNxlhDgU8K+y1hUOk/ppmeoRA9Gw3AzlLhVM6CMEWntawWSSlhG
	qv4v9yNieklaEMdyT/tsd5tlhWDyu/Xz5NgrZLAWl5+1JrNYQe8SkL6bxkzx+aH8FcjTqbadTApmk
	ldOm3oZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4N-00000000MIA-1WWg;
	Sun, 20 Sep 2026 20:23:27 +0000
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8NMo-00000000ImI-0T3Y
	for kexec@lists.infradead.org;
	Sun, 20 Sep 2026 19:38:27 +0000
Received: by mail-yx2-x11.google.com with SMTP id 00721157ae682-85d43f9b120so19440807b3.3
        for <kexec@lists.infradead.org>; Sun, 20 Sep 2026 12:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789933105; x=1790537905; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=K5j5l9GIwIcGWU8WT7f8DcBXaOCqBMTT8VcXmZE9caw=;
        b=ffIBgC2o23v+z355CIdVJIYYrUO6gQHa4ooP9VPZ0qHXNUroP6kfLIkl7Y+Dd1nVi+
         V4oCOOb2FJCmQ5rMgsdFpeEUkgBV/RFMATiwteLJL/tn1qRHUe6x19ydqZWufk77lera
         XJAiVC7Em/LkWrL7LPByYLXpBNe9vBcV+gNUVG+2ZvAv0TFFl4UEds51/5DyXvPIc/1+
         cRPWopdfMYldGNIJJPBfsoko+fCK12xv0WcbqufkHIHN+4P4YB9UpQTrM25lJp+OTSA+
         muZsLw0ZvTEILBEf1YH53/E7ESBKbNG3zDgnCcCzasb9eAn6TAEBd9dezHlMfNs1Z9BG
         P5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933105; x=1790537905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=K5j5l9GIwIcGWU8WT7f8DcBXaOCqBMTT8VcXmZE9caw=;
        b=rOfluWRplHJVkVa+eMJQd0rBd3SC1QMSaDGU3YaiUseAtYOArHirBw00BGf5nEQf+q
         kRNPXl1nzAIQJheDuu4UK9y6bR/++fB+lSnyTR0poWEr4TKjn7s8sfjEc8hsQv8ifEBU
         s2D7f+OTmzbS8YYGu7UcGu40PWv3BwF7hTWSS1QVtM/DwdMAiLvB/gDw+dehrSVr3iN/
         W7dCJWrYs7klwkKMLgIK9bHIRRGgHmSD82N613eMYTZ+nPuNKEMat03jY8SNj1xHrLN6
         MGzt4X77GRUUlnN1yfF05Uxjs9mYno/5xjzZyXzPfVt9Q/IbWHYOIHeYRAg3flL1Qg51
         YchQ==
X-Forwarded-Encrypted: i=1; AKwUvBxoYJvUsGW76a5cOo8oryFXyUMxlDIt95KGv22qfWrugJD2qNgam7TYS1KMv3QmYQBv/yxbtQ==@lists.infradead.org
X-Gm-Message-State: AFuF++nOCDCxRzNrpplzyUQBZXI0GVWYzGjbeQKtv138aygmjjSuYWDt
	iOYWrWaly0N9azFRWAUHBR94ndQCwqjROpIath5lV8Szgre8jvYbxkJ0mBVqyTSwPGc=
X-Gm-Gg: AYBFou2VA1a7gxNnha3BJVR5evg7JdFaPPxZjuTlG4J3x6EHCNgD64NPCuL3zpAWJk5
	5SxKnh1sBP+NisVGD25dP3UmksSMVTPu8vGjVo4vdWkOP9VwcK9bpa4/46DfPwJZ4qOt4k6Rn1A
	3lGS5UbRssixMVs4adO0j/Y7QxAMBlZA0iIiiYadRLci99Zl1oEF0e5CLTPamBUEs9SwJYMLloc
	QLHOX/zFBri23xofvtz5mRD8Z/wAi913b4cXGA3A9Fu+fzgC0fBlBvYOiIr3KerFF80ea7nBB+3
	jFXpPNHdxkUsjmTcdVg9Kf4utIZ4QSQxzqfZLUu40KF9rzdTEGXLH8R9HafTdzb/Hb5IUiDrJUh
	3eQy/bKSWkTiJhsswWyf4215K20e5xFYgzc+d8VqSqYShjDt/sUWBYHOUGRZGYT/M5rjpVtchrn
	KrZ7rZljUmY5CmP5Af4Tg88ndi1vXnlgu9jqq5Ewpz0Zc8FoiPRllqenJnSatTQO/1+CaVOXvBn
	wtjRRFGkQ4SOoJcN7HYjYZdZb4XDYBuXkLbHPipG21jtUjvjDQ/jjwrLwfFo+8aFmg4E1gBtWhR
	qoUEBegUU1jgGJ0Rxjc=
X-Received: by 2002:a05:690c:a695:b0:873:5ddf:d85a with SMTP id 00721157ae682-897346e4bd2mr18960687b3.37.1789933105074;
        Sun, 20 Sep 2026 12:38:25 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a47af7bfbsm18835137b3.33.2026.09.20.12.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:38:24 -0700 (PDT)
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
Subject: [RFC PATCH 15/46] cpu_preserve: Add physical CPU preservation lifecycle and build rules
Date: Sun, 20 Sep 2026 15:36:19 -0400
Message-ID: <20260920193650.3373435-16-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
References: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_123826_245002_9A25CD7F 
X-CRM114-Status: GOOD (  21.49  )
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

Implement physical CPU preservation lifecycle management, stack allocation,
and build rules with -mbranch-protection=none and -fno-stack-protector.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/cpu.c                     |   2 +
 kernel/liveupdate/Kconfig        |  35 +++
 kernel/liveupdate/Makefile       |   3 +
 kernel/liveupdate/cpu_preserve.c | 359 +++++++++++++++++++++++++++++++
 4 files changed, 399 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index b3c8553d7bd6..8637b5e7f2de 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -14,6 +14,7 @@
 #include <linux/sched/smt.h>
 #include <linux/unistd.h>
 #include <linux/cpu.h>
+#include <linux/cpu_preserve.h>
 #include <linux/oom.h>
 #include <linux/rcupdate.h>
 #include <linux/delay.h>
@@ -349,6 +350,7 @@ static inline void cpuhp_ap_update_sync_state(enum cpuhp_sync_state state) { }
 void cpuhp_ap_report_dead(void)
 {
 	cpuhp_ap_update_sync_state(SYNC_STATE_DEAD);
+	cpu_preserved_report_dead();
 }
 
 void __weak arch_cpuhp_cleanup_dead_cpu(unsigned int cpu) { }
diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
index 2490f9a9b838..52c5fd7a620b 100644
--- a/kernel/liveupdate/Kconfig
+++ b/kernel/liveupdate/Kconfig
@@ -101,4 +101,39 @@ config LIVEUPDATE_GUEST_MEMFD
 
 	  If unsure, say N.
 
+config ARCH_SUPPORTS_LIVEUPDATE_CPU
+	bool
+
+config LIVEUPDATE_CPU
+	bool "Live update support for preserved CPUs"
+	depends on LIVEUPDATE
+	depends on ARCH_SUPPORTS_LIVEUPDATE_CPU
+	depends on HOTPLUG_CPU
+	default LIVEUPDATE
+	help
+	  Enable live update support for physical CPU preservation.
+
+	  This feature allows physical CPU cores to be preserved across
+	  kexec-based live updates without undergoing a hardware reset or
+	  full kernel offline/online cycle.
+
+	  When a core is preserved, it is isolated from host scheduling and
+	  parked in a dedicated execution loop within preserved memory pages.
+	  Its execution context, state, and necessary page tables are handed
+	  over across the kexec transition using the KHO
+	  framework. The incoming kernel detects preserved cores during early
+	  boot and avoids bringing them up during smp_init(), keeping them
+	  isolated and running their assigned workloads.
+
+	  This capability is a core building block for live-updating virtual
+	  machine hosts (e.g. Caretaker/OrphanVM) without pausing or
+	  disrupting running guest workloads, and can also speed up kernel
+	  live updates by skipping CPU re-initialization.
+
+	  Preservation lifecycle is managed from userspace via LUO sessions
+	  associated with /sys/devices/system/cpu/cpu<N>/preserve file
+	  descriptors, and monitored via sysfs.
+
+	  If unsure, say N.
+
 endmenu
diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
index d9f469462556..486f7854bb75 100644
--- a/kernel/liveupdate/Makefile
+++ b/kernel/liveupdate/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
+CFLAGS_cpu_preserve.o += $(call cc-option,-mbranch-protection=none) -fno-stack-protector $(call cc-option,-ftrivial-auto-var-init=uninitialized) $(call cc-option,-fno-jump-tables)
+
 luo-y :=								\
 		kho_block.o						\
 		luo_core.o						\
@@ -11,3 +13,4 @@ obj-$(CONFIG_KEXEC_HANDOVER)		+= kexec_handover.o
 obj-$(CONFIG_KEXEC_HANDOVER_DEBUGFS)	+= kexec_handover_debugfs.o
 
 obj-$(CONFIG_LIVEUPDATE)		+= luo.o
+obj-$(CONFIG_LIVEUPDATE_CPU)		+= cpu_preserve.o
diff --git a/kernel/liveupdate/cpu_preserve.c b/kernel/liveupdate/cpu_preserve.c
index e19208670c3e..c5fd3a07ccb5 100644
--- a/kernel/liveupdate/cpu_preserve.c
+++ b/kernel/liveupdate/cpu_preserve.c
@@ -247,3 +247,362 @@ static phys_addr_t cpu_preserved_get_data_pa(void)
 	return cpu_preserved_data_pages ? page_to_phys(cpu_preserved_data_pages) : 0;
 }
 
+static void cpu_preserved_sync_global_ser(void)
+{
+	struct cpu_preserved_global_ser *ser = cpu_preserved_global_ser;
+
+	if (!ser)
+		return;
+
+	bitmap_to_arr64(ser->cpu_preserved_bitmap,
+			cpumask_bits(&cpu_preserved_mask), nr_cpu_ids);
+	if (cpu_preserved_text_pages) {
+		ser->text_runtime_pa = page_to_phys(cpu_preserved_text_pages);
+		ser->text_runtime_size =
+			(1UL << cpu_preserved_text_order) * PAGE_SIZE;
+	}
+	if (cpu_preserved_data_pages) {
+		ser->data_runtime_pa = page_to_phys(cpu_preserved_data_pages);
+		ser->data_runtime_size =
+			(1UL << cpu_preserved_data_order) * PAGE_SIZE;
+	}
+	KHOSER_STORE_PTR(ser->pcpus_runtime, cpu_preserved_outgoing.pcpus_ser);
+	cpu_preserved_clean_sz(ser,
+			       struct_size(ser, cpu_preserved_bitmap, ser->nr_cpu_words));
+}
+
+static void cpu_preserved_free_kho(void *va, bool is_incoming)
+{
+	if (!va)
+		return;
+
+	if (is_incoming)
+		kho_restore_free(va);
+	else
+		kho_unpreserve_free(va);
+}
+
+static void cpu_preserved_free_stack(phys_addr_t stack_pa, bool is_incoming)
+{
+	if (stack_pa)
+		cpu_preserved_free_kho(phys_to_virt(stack_pa), is_incoming);
+}
+
+static void cpu_preserved_state_cleanup(struct cpu_preserved_state *st,
+					bool is_incoming)
+{
+	if (!cpumask_empty(&st->mask))
+		return;
+
+	cpu_preserved_free_kho(st->pcpus_ser, is_incoming);
+	st->pcpus_ser = NULL;
+	kfree(st->pcpus);
+	st->pcpus = NULL;
+}
+
+/*
+ * Drop @cpu out of the preserved state, free its preserved stack, and
+ * republish the globals a parked core may still be reading.  The caller holds
+ * cpu_preserved_lock and has already made the core leave the park loop.
+ */
+static void __cpu_unpreserve_locked(unsigned int cpu)
+{
+	struct cpu_preserved_state *incoming = &cpu_preserved_incoming;
+	struct cpu_preserved_state *outgoing = &cpu_preserved_outgoing;
+	struct cpu_preserved_pcpu_ser *ser = cpu_preserved_get_pcpu_ser(cpu);
+	struct cpu_preserved_pcpu *pcpu = cpu_preserved_get_pcpu(cpu);
+	bool is_incoming = cpu_preserved_is_incoming(cpu);
+	phys_addr_t stack_pa = 0;
+
+	lockdep_assert_held(&cpu_preserved_lock);
+
+	cpumask_clear_cpu(cpu, &outgoing->mask);
+	cpumask_clear_cpu(cpu, &incoming->mask);
+	cpumask_clear_cpu(cpu, &cpu_preserved_mask);
+	cpu_preserved_clean(&cpu_preserved_mask);
+	set_cpu_present(cpu, true);
+
+	if (ser)
+		WRITE_ONCE(ser->workload, 0);
+
+	if (pcpu) {
+		stack_pa = pcpu->stack_pa;
+		memset(pcpu, 0, sizeof(*pcpu));
+	}
+
+	cpu_preserved_free_stack(stack_pa, is_incoming);
+
+	/* @pcpu and @ser point into these arrays: do not touch past this point. */
+	cpu_preserved_state_cleanup(outgoing, false);
+	cpu_preserved_state_cleanup(incoming, true);
+
+	if (cpumask_empty(&cpu_preserved_mask)) {
+		WRITE_ONCE(cpu_preserved_pcpus_va, NULL);
+		WRITE_ONCE(cpu_preserved_host_pcpus_va, NULL);
+		cpu_preserved_clean(&cpu_preserved_pcpus_va);
+		cpu_preserved_clean(&cpu_preserved_host_pcpus_va);
+	}
+
+	cpu_preserved_sync_global_ser();
+}
+
+/**
+ * cpu_unpreserve - Unpreserve a physical CPU and restore it to online state
+ * @cpu: Logical CPU identifier.
+ *
+ * Signals the CPU to exit the parking loop, cleans up preserved stack memory,
+ * and restores the core to host scheduling via standard add_cpu().
+ */
+static void cpu_unpreserve(unsigned int cpu)
+{
+	int ret;
+
+	scoped_guard(mutex, &cpu_preserved_lock) {
+		if (!cpu_is_preserved(cpu))
+			return;
+
+		cpu_signal_exit(cpu);
+		arch_cpu_preserved_kick(cpu);
+	}
+
+	/*
+	 * cpu_wait_dead() busy-polls for up to 20 seconds.  Do not hold
+	 * cpu_preserved_lock across it: the poll only reads pcpu->state, which
+	 * stays valid for as long as the CPU is preserved, and holding the lock
+	 * here would stall every other preservation operation and every sysfs
+	 * reader for the entire window.
+	 */
+	if (cpu_wait_dead(cpu))
+		return;
+
+	scoped_guard(mutex, &cpu_preserved_lock) {
+		if (!cpu_is_preserved(cpu))
+			return;
+
+		__cpu_unpreserve_locked(cpu);
+	}
+
+	ret = add_cpu(cpu);
+	if (ret < 0)
+		pr_err("Failed to bring unpreserved cpu %u back online: %d\n",
+		       cpu, ret);
+}
+
+/*
+ * FLB Ops for Preserved CPUs
+ */
+static int cpu_preserved_flb_preserve(struct liveupdate_flb_op_args *argp)
+{
+	unsigned int nr_words = BITS_TO_U64(nr_cpu_ids);
+	struct cpu_preserved_global_ser *ser;
+	size_t ser_sz;
+	int ret;
+
+	ret = cpu_preserved_init_runtime_buffer();
+	if (ret)
+		return ret;
+
+	ser_sz = struct_size(ser, cpu_preserved_bitmap, nr_words);
+
+	mutex_lock(&cpu_preserved_lock);
+	ser = kho_alloc_preserve(ser_sz);
+	if (IS_ERR(ser)) {
+		mutex_unlock(&cpu_preserved_lock);
+		return PTR_ERR(ser);
+	}
+
+	memset(ser, 0, ser_sz);
+	ser->nr_cpu_words = nr_words;
+	cpu_preserved_global_ser = ser;
+	cpu_preserved_sync_global_ser();
+	mutex_unlock(&cpu_preserved_lock);
+
+	argp->data = virt_to_phys(ser);
+	argp->obj = ser;
+	return 0;
+}
+
+static void cpu_preserved_flb_unpreserve(struct liveupdate_flb_op_args *argp)
+{
+	struct cpu_preserved_global_ser *ser;
+
+	if (!argp->data)
+		return;
+
+	ser = phys_to_virt(argp->data);
+	mutex_lock(&cpu_preserved_lock);
+	cpu_preserved_global_ser = NULL;
+	mutex_unlock(&cpu_preserved_lock);
+
+	cpu_preserved_unpreserve_runtime_buffer();
+	kho_unpreserve_free(ser);
+}
+
+static int cpu_preserved_flb_retrieve(struct liveupdate_flb_op_args *argp)
+{
+	struct cpu_preserved_global_ser *ser;
+	struct cpu_preserved_pcpu_ser *pcpus;
+	u64 nr_bits;
+	int cpu;
+
+	if (!argp->data)
+		return -EINVAL;
+
+	ser = phys_to_virt(argp->data);
+	arch_cpu_preserved_early_init();
+
+	/*
+	 * The outgoing kernel may have been built with a larger NR_CPUS.  Any
+	 * preserved CPU we cannot represent would be silently forgotten and
+	 * left spinning in its park loop forever, so refuse the handover
+	 * instead.
+	 */
+	nr_bits = (u64)ser->nr_cpu_words * BITS_PER_TYPE(u64);
+	if (nr_bits > nr_cpu_ids &&
+	    find_next_bit((const unsigned long *)ser->cpu_preserved_bitmap,
+			  nr_bits, nr_cpu_ids) < nr_bits) {
+		pr_err("preserved CPU above nr_cpu_ids=%u in handover data\n",
+		       nr_cpu_ids);
+		return -ERANGE;
+	}
+
+	mutex_lock(&cpu_preserved_lock);
+	bitmap_from_arr64(cpumask_bits(&cpu_preserved_mask),
+			  ser->cpu_preserved_bitmap, min_t(u64, nr_bits, nr_cpu_ids));
+	cpumask_copy(&cpu_preserved_incoming.mask, &cpu_preserved_mask);
+	pcpus = KHOSER_LOAD_PTR(ser->pcpus_runtime);
+
+	if (pcpus) {
+		cpu_preserved_incoming.pcpus_ser = pcpus;
+		WRITE_ONCE(cpu_preserved_pcpus_va, pcpus);
+		cpu_preserved_clean(&cpu_preserved_pcpus_va);
+	}
+	cpu_preserved_clean(&cpu_preserved_mask);
+	for_each_cpu(cpu, &cpu_preserved_mask)
+		set_cpu_present(cpu, false);
+	mutex_unlock(&cpu_preserved_lock);
+
+	argp->obj = ser;
+	return 0;
+}
+
+static void cpu_preserved_flb_finish(struct liveupdate_flb_op_args *argp)
+{
+	struct cpu_preserved_global_ser *ser;
+
+	if (!argp->obj)
+		return;
+
+	ser = argp->obj;
+
+	scoped_guard(mutex, &cpu_preserved_lock) {
+		if (cpu_preserved_incoming.pcpus_ser) {
+			kho_restore_free(cpu_preserved_incoming.pcpus_ser);
+			cpu_preserved_incoming.pcpus_ser = NULL;
+		}
+		kfree(cpu_preserved_incoming.pcpus);
+		cpu_preserved_incoming.pcpus = NULL;
+	}
+
+	if (ser->text_runtime_pa && ser->text_runtime_size) {
+		unsigned long nr_pages = ser->text_runtime_size >> PAGE_SHIFT;
+		struct page *page = kho_restore_pages(ser->text_runtime_pa, nr_pages);
+
+		if (page) {
+			for (unsigned long i = 0; i < nr_pages; i++)
+				__free_page(page + i);
+		}
+	}
+
+	if (ser->data_runtime_pa && ser->data_runtime_size) {
+		unsigned long nr_pages = ser->data_runtime_size >> PAGE_SHIFT;
+		struct page *page = kho_restore_pages(ser->data_runtime_pa, nr_pages);
+
+		if (page) {
+			for (unsigned long i = 0; i < nr_pages; i++)
+				__free_page(page + i);
+		}
+	}
+
+	kho_restore_free(ser);
+}
+
+static const struct liveupdate_flb_ops cpu_preserved_flb_ops = {
+	.preserve   = cpu_preserved_flb_preserve,
+	.unpreserve = cpu_preserved_flb_unpreserve,
+	.retrieve   = cpu_preserved_flb_retrieve,
+	.finish     = cpu_preserved_flb_finish,
+	.owner      = THIS_MODULE,
+};
+
+static struct liveupdate_flb cpu_preserved_flb = {
+	.ops        = &cpu_preserved_flb_ops,
+	.compatible = CPU_PRESERVED_LUO_FLB_COMPATIBLE,
+};
+
+static int cpu_preserve_reboot_notify(struct notifier_block *nb,
+				      unsigned long action, void *data)
+{
+	int cpu;
+
+	scoped_guard(mutex, &cpu_preserved_lock) {
+		for_each_cpu(cpu, &cpu_preserved_mask) {
+			/*
+			 * If this CPU is not being preserved across an outgoing
+			 * live update, signal it to exit the park loop and
+			 * offline it.
+			 */
+			if (kexec_in_progress && liveupdate_enabled() &&
+			    !cpu_preserved_is_incoming(cpu))
+				continue;
+
+			cpu_signal_exit(cpu);
+			arch_cpu_preserved_kick(cpu);
+			if (cpu_wait_dead(cpu))
+				continue;
+
+			__cpu_unpreserve_locked(cpu);
+		}
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block cpu_preserve_reboot_nb = {
+	.notifier_call = cpu_preserve_reboot_notify,
+	.priority = 0,
+};
+
+/**
+ * cpu_preserve_early_init - Early boot registration & retrieval of CPUs
+ *
+ * Registers the preserved CPU file handler and FLB with LUO, retrieves incoming
+ * preserved CPU state prior to secondary SMP bringup, and registers the reboot
+ * notifier.
+ *
+ * Return: 0 on success, or negative error code on failure.
+ */
+static int __init cpu_preserve_early_init(void)
+{
+	void *obj;
+	int err;
+
+	if (!liveupdate_enabled())
+		cpumask_clear(&cpu_preserved_mask);
+	cpumask_clear(&cpu_preserved_outgoing.mask);
+	cpumask_clear(&cpu_preserved_incoming.mask);
+	cpu_preserved_outgoing.pcpus = NULL;
+	cpu_preserved_outgoing.pcpus_ser = NULL;
+	cpu_preserved_incoming.pcpus = NULL;
+	cpu_preserved_incoming.pcpus_ser = NULL;
+	cpu_preserved_global_ser = NULL;
+
+	/* Retrieve incoming preserved CPUs before secondary CPU bringup */
+	if (liveupdate_enabled())
+		liveupdate_flb_get_incoming(&cpu_preserved_flb, &obj);
+
+	register_reboot_notifier(&cpu_preserve_reboot_nb);
+
+	return 0;
+}
+early_initcall(cpu_preserve_early_init);
-- 
2.55.0.1082.g2b9226bbc0-goog


