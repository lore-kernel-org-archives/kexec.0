Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10E8CD6E60
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 14:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=biqYrfJscB5g9NzTV4auZGkEkHa4h9oyCn+/+L+t5Js=; b=pIl13dpi+ZX3GA3v8WmGlnyG+D
	atopX+0eVDxBffClGVhRBb24N/EFsE45myBZFVRe18/oIeuWvusgJqZQtFxg7fNhYhjo+t9ecqnjG
	lHbFC58PkEmP1tkfd1BgOP2Fe8ZLjTLm40ik/xNNWt8E8/wEQDiQ43j4IiLioiEBsZxHA8RjxUCXq
	KUnHlk/im6GKOjFtBzAxTZdvyN6ptIGJul25H6vWWMWeiQj9+IGcOF8eFAKlPoSIQllntq4ApmAZr
	eT2KXZRX3eKXUo53tILJ0FHLCeCdG3LjaeIM0IZa+N9GcfrEaw2vq0u/eXcOdKa7oCCIzQFtyu8oE
	zpYXDqSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUmiA-0000000FGNf-06dv;
	Wed, 03 Jun 2026 14:36:50 +0000
Received: from fhigh-a3-smtp.messagingengine.com ([103.168.172.154])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUmi4-0000000FGJr-1h6l;
	Wed, 03 Jun 2026 14:36:45 +0000
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A602B14000FB;
	Wed,  3 Jun 2026 10:36:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 03 Jun 2026 10:36:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1780497403; x=1780583803; bh=biqYrfJscB5g9NzTV4auZGkEkHa4h9oy
	Cn+/+L+t5Js=; b=NK3FEEubhWpauXNobBEhTtb3qMwXqUX+0mAETH6kF731TMji
	mCbN7Ue0/qslsppv3tEzzHqn62sp3MkZJZw3yl8KgJSHhLqkpur5dy/fnxqHcCWj
	3Zc0HiWwFWTe2fz+EuDCScmMiTCp66eKAl6lWhGV/+D7DNb3KKZq2Jc86jywNI0p
	98CaOG8wQ+Gct3oDlt3sm2JxE0x6INmEDWFvueaagIVpwGHi4SnoBynJAwGwQM4z
	3fv94IAhYoblhXqfH5LBwqs4EWPUQ/tyTnF+5+PVqjZ7AS7TkbE0Cpr42YO/nro/
	gJAGqOIAXfQatBs2Dvbfp1emrKiH49c8PAZDCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780497403; x=
	1780583803; bh=biqYrfJscB5g9NzTV4auZGkEkHa4h9oyCn+/+L+t5Js=; b=Z
	IGAX+k9pSb5XFSchtlpg+dSsGjzVwP9a+yXMa/aZenHbu91twODdmJe4j3/Pm8ZS
	w6/uJ1fztNfuzUaM7mZ4gUV1wJZhrih9aj9eoAapt2ZCrmbXSFf4/InADpYHIst4
	/YmRtgKFdhK6A6Be/ZVfoWqzIJ85g52oatdrRHq6u+bU/Y0DsCPZpzaIrcsoG4gp
	yAlqRRCBT9XAS3IQYjW19baoctLHasae8KtQJuh4VQ9oY8TIlaTQzgSPZ+H5lkBl
	36pyLycMehp0UKPUoajQr9d9g8Wt68GY3xe8WoEq6IODRzT2vDdBIRM9PHkTrbqs
	VwjzxfJZL0CQ+1AxWqFpg==
X-ME-Sender: <xms:-zsganI8owvprzhafH4yXacoJPW-FAZV6r6pjhfwWcLBadK_--OjRQ>
    <xme:-zsgaiO_QvK4vi-ssSdXpvIEJy64weOK3r1WrRg_gK6wbTSn3O1JPvcwI7MTDct96
    Y5YzQ36iR29gaNiZMfuEKzRXuWXUNb7aWLUt6JkW2kKSrf1E1j6XS_N>
X-ME-Received: <xmr:-zsganb1MrZFNWODuRxAVXpRt-Xc950vhYzypFxPF9XGcHIhmT8ByTvPdyPM9Q>
X-ME-Proxy-Cause: dmFkZTE6HayDcdGWnkL4kPkzox9d7h+l5JKpT8C/zk/uXy5IaZ2k34BZhDRPhNaK8R4gHi
    c1o1TBpIAmucE3LUnneJuPTN4jY6fAEs51Nqpm/EItTh83BNLc0QdZE5bAw0jJdJbfLj6z
    yRyUZGxqcJ/rblH05D7CKqXZFBPh312F24iA+QNLKYvOlpCwj3MJmy+3/gvT0sO9oQIpAY
    U8TbLu1hHeuFqDiI01StU/vswbo53ZBTzHxl+/ld1PG277j5WMhmkfPya0dcHnqQO3Bggq
    UzviA4R9lZrZ2QqxjFuWAubY0PVYviQOk7JnAhtt21lwiTlgc6163UNEMeTO4n4eqHdVjK
    9kkKYmFd6cl5z1fGkS5UZOq9icIoWevtqf3BzGkvKEkEhvw0r6GfHOdQGqCJ3y5bMTUa24
    iC3Ct5qQqiq3IUi+b+8xzq8sj9Nf7WP3jR2gta7+04EjIaZlvxPJYHK8eEta1SkTwArqB2
    UKpBWY+Hexos67Wh+BLGor9MRqN515bEkkUkBneYT0q+31EDEloL0CSNWqsR73FzcFOfuV
    qLXZxJlXSjNvnj9P6BJv6OqYbLHhxvw1JUWBTkAeScMZ3mei+x4Wgf2uihc0ZwAoq975Gz
    qOGStTbziLVXv06MhnewbbXn8H9SRYo673fKLevo89cS+ZSTART+HbGnqjDQ
X-ME-Proxy: <xmx:-zsgamw7EcP8VZ6KD8NCiQtlf-SML1EOqZdWROjGI6A7puJJiQ33gQ>
    <xmx:-zsgarFiA3icCJZJFZXrcMq9Lo93iTaX8cm9pzdJ6usYEGeyz5UCdg>
    <xmx:-zsgapq8GTtP78HwGnr78O8bBUAGuEQGZLRSlbWJeLkDpIipeykRew>
    <xmx:-zsgahyujk62bESEHCVm0zNZdJvLRRILxLw0Oq5kTJq9Ppjfd6DXNw>
    <xmx:-zsgarfTDCnbd-G1-HbAKh5OVDsBnpyIDijI12EVKRoIswFi_cn3QyuG>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 10:36:42 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Petr Mladek <pmladek@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Usama Arif <usama.arif@linux.dev>,
	Breno Leitao <leitao@debian.org>,
	Julien Thierry <julien.thierry.kdev@gmail.com>,
	Lecopzer Chen <lecopzer.chen@mediatek.com>,
	Sumit Garg <sumit.garg@kernel.org>,
	kernel-team@meta.com,
	kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [PATCH 2/4] drivers/firmware: add SDEI cross-CPU NMI service for arm64
Date: Wed,  3 Jun 2026 15:36:33 +0100
Message-ID: <145b9e98b12a7d314fc4a203075f65c3a0c3a913.1780496779.git.kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1780496779.git.kas@kernel.org>
References: <cover.1780496779.git.kas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_073644_577083_727B779D 
X-CRM114-Status: GOOD (  31.83  )
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

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

Deliver an NMI-like event to an interrupt-masked arm64 CPU via the
standard SDEI software-signalled event (event 0), without the pseudo-NMI
hot-path cost: register a handler for event 0 and poke a target with
sdei_event_signal(0, mpidr).

First user is arch_trigger_cpumask_backtrace() (sysrq-l, RCU stalls,
hung-task/soft-lockup dumps), which otherwise rides an IPI that can't
reach a masked CPU. Falls back to the IPI path when SDEI is absent; no
watchdog backend yet, so the stock detector is untouched.

Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 arch/arm64/include/asm/nmi.h |  24 ++++++
 arch/arm64/kernel/smp.c      |   9 +++
 drivers/firmware/Kconfig     |  19 +++++
 drivers/firmware/Makefile    |   1 +
 drivers/firmware/sdei_nmi.c  | 147 +++++++++++++++++++++++++++++++++++
 5 files changed, 200 insertions(+)
 create mode 100644 arch/arm64/include/asm/nmi.h
 create mode 100644 drivers/firmware/sdei_nmi.c

diff --git a/arch/arm64/include/asm/nmi.h b/arch/arm64/include/asm/nmi.h
new file mode 100644
index 000000000000..ccdb75692e9d
--- /dev/null
+++ b/arch/arm64/include/asm/nmi.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_NMI_H
+#define __ASM_NMI_H
+
+#include <linux/cpumask.h>
+
+/*
+ * Cross-CPU NMI provider hooks, consulted by the arm64 arch code before
+ * its regular-IRQ / pseudo-NMI IPI paths. The SDEI provider in
+ * drivers/firmware/sdei_nmi.c implements them when active; a future
+ * FEAT_NMI provider could slot in here too. The stubs let callers stay
+ * unconditional when ARM_SDEI_NMI is off.
+ */
+#ifdef CONFIG_ARM_SDEI_NMI
+bool sdei_nmi_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu);
+#else
+static inline bool sdei_nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
+						      int exclude_cpu)
+{
+	return false;
+}
+#endif
+
+#endif /* __ASM_NMI_H */
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 1aa324104afb..656b8417af72 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -45,6 +45,7 @@
 #include <asm/daifflags.h>
 #include <asm/kvm_mmu.h>
 #include <asm/mmu_context.h>
+#include <asm/nmi.h>
 #include <asm/numa.h>
 #include <asm/processor.h>
 #include <asm/smp_plat.h>
@@ -928,11 +929,19 @@ static void arm64_backtrace_ipi(cpumask_t *mask)
 void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
 {
 	/*
+	 * Prefer the SDEI cross-CPU NMI provider when active: firmware
+	 * dispatches the event out of EL3 and reaches CPUs that have
+	 * interrupts locally masked, without the per-IRQ-mask cost that
+	 * pseudo-NMI pays for the same reach. The plain IPI path below
+	 * can't reach such a CPU unless pseudo-NMI is enabled.
+	 *
 	 * NOTE: though nmi_trigger_cpumask_backtrace() has "nmi_" in the name,
 	 * nothing about it truly needs to be implemented using an NMI, it's
 	 * just that it's _allowed_ to work with NMIs. If ipi_should_be_nmi()
 	 * returned false our backtrace attempt will just use a regular IPI.
 	 */
+	if (sdei_nmi_trigger_cpumask_backtrace(mask, exclude_cpu))
+		return;
 	nmi_trigger_cpumask_backtrace(mask, exclude_cpu, arm64_backtrace_ipi);
 }
 
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index bbd2155d8483..6501087ff90d 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -36,6 +36,25 @@ config ARM_SDE_INTERFACE
 	  standard for registering callbacks from the platform firmware
 	  into the OS. This is typically used to implement RAS notifications.
 
+config ARM_SDEI_NMI
+	bool "SDEI-based cross-CPU NMI service (arm64)"
+	depends on ARM64 && ARM_SDE_INTERFACE
+	help
+	  Provides SDEI-based cross-CPU NMI delivery for hooks that need
+	  to reach interrupt-masked CPUs on silicon that lacks FEAT_NMI:
+
+	    - arch_trigger_cpumask_backtrace()  (sysrq-l, RCU stalls,
+	      hardlockup_all_cpu_backtrace, soft-lockup secondary dumps,
+	      hung-task auxiliary dumps)
+
+	  The driver registers a handler for the SDEI software-signalled
+	  event (event 0) and reaches a target CPU by signalling it with
+	  SDEI_EVENT_SIGNAL. Firmware delivers the event out of EL3
+	  regardless of the target's PSTATE.DAIF -- forced delivery into a
+	  CPU wedged with interrupts locally masked.
+
+	  If unsure, say N.
+
 config EDD
 	tristate "BIOS Enhanced Disk Drive calls determine boot disk"
 	depends on X86
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 4ddec2820c96..48221fb8b385 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -4,6 +4,7 @@
 #
 obj-$(CONFIG_ARM_SCPI_PROTOCOL)	+= arm_scpi.o
 obj-$(CONFIG_ARM_SDE_INTERFACE)	+= arm_sdei.o
+obj-$(CONFIG_ARM_SDEI_NMI)	+= sdei_nmi.o
 obj-$(CONFIG_DMI)		+= dmi_scan.o
 obj-$(CONFIG_DMI_SYSFS)		+= dmi-sysfs.o
 obj-$(CONFIG_EDD)		+= edd.o
diff --git a/drivers/firmware/sdei_nmi.c b/drivers/firmware/sdei_nmi.c
new file mode 100644
index 000000000000..e5c3f28b3991
--- /dev/null
+++ b/drivers/firmware/sdei_nmi.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * arm64 SDEI-based cross-CPU NMI service.
+ *
+ * Delivering an "NMI-shaped" event to an EL1 context that has locally
+ * masked interrupts, on silicon without FEAT_NMI, can be done two ways:
+ *
+ *   - pseudo-NMI: mask "interrupts" via the GIC priority register
+ *     (ICC_PMR_EL1) instead of PSTATE.DAIF, leaving a high-priority band
+ *     deliverable. Functionally this works -- but it reimplements every
+ *     local_irq_disable()/enable() and exception entry/exit as a PMR
+ *     write plus synchronisation, a cost paid on that hot path forever,
+ *     whether or not an NMI is ever delivered.
+ *
+ *   - SDEI: leave interrupt masking as the cheap PSTATE.DAIF operation
+ *     and have the firmware bounce an EL3-routed Group-0 SGI back to
+ *     NS-EL1 as an event callback. The cost is a firmware round-trip,
+ *     but only at the rare moment delivery is actually needed.
+ *
+ * This driver takes the second path: it keeps the IRQ-mask hot path
+ * free and pays only when it fires, which is what makes cross-CPU NMI
+ * affordable on hardware where the pseudo-NMI tax isn't, until FEAT_NMI
+ * makes NMI masking cheap in the architecture itself.
+ *
+ * Capabilities provided:
+ *
+ *   - sdei_nmi_trigger_cpumask_backtrace() — override for arm64's
+ *     arch_trigger_cpumask_backtrace(), so sysrq-l, RCU stall dumps,
+ *     hardlockup_all_cpu_backtrace, soft-lockup/hung-task secondary
+ *     dumps all reach interrupt-masked CPUs.
+ *
+ * Delivery uses the standard SDEI software-signalled event (event 0) and
+ * SDEI_EVENT_SIGNAL. We register a handler for event 0, enable it, and
+ * poke a target CPU with sdei_event_signal(0, mpidr): firmware makes
+ * event 0 pending on that PE and dispatches the handler NMI-like,
+ * regardless of the target's DAIF.
+ * Availability is simply whether event 0 registers and enables -- if SDEI
+ * and its software-signalled event are present we use it, otherwise the
+ * driver stays inert.
+ */
+
+#define pr_fmt(fmt) "sdei_nmi: " fmt
+
+#include <linux/arm_sdei.h>
+#include <linux/cpumask.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/nmi.h>
+#include <linux/printk.h>
+#include <linux/ptrace.h>
+#include <linux/smp.h>
+#include <linux/types.h>
+
+#include <asm/nmi.h>
+#include <asm/smp_plat.h>
+
+static bool sdei_nmi_available;
+
+#define SDEI_NMI_EVENT			0
+
+static int sdei_nmi_handler(u32 event, struct pt_regs *regs, void *arg)
+{
+	/*
+	 * nmi_cpu_backtrace() no-ops unless this CPU's bit is set in the
+	 * global backtrace mask (driven by nmi_trigger_cpumask_backtrace()),
+	 * so a fire that reaches a CPU not being backtraced is harmless.
+	 */
+	nmi_cpu_backtrace(regs);
+	return SDEI_EV_HANDLED;
+}
+
+static void sdei_nmi_fire(unsigned int target_cpu)
+{
+	int err = sdei_event_signal(SDEI_NMI_EVENT, cpu_logical_map(target_cpu));
+
+	if (err)
+		pr_warn("SDEI_EVENT_SIGNAL to CPU %u failed: %d\n",
+			target_cpu, err);
+}
+
+/*
+ * Raise callback for nmi_trigger_cpumask_backtrace(): signal event 0
+ * at every CPU still pending in @mask. The framework excludes the local
+ * CPU from @mask before calling us.
+ */
+static void sdei_nmi_raise_backtrace(cpumask_t *mask)
+{
+	unsigned int cpu;
+
+	for_each_cpu(cpu, mask)
+		sdei_nmi_fire(cpu);
+}
+
+/*
+ * Override hook for arch_trigger_cpumask_backtrace() (see
+ * arch/arm64/kernel/smp.c). Returns true when SDEI handled the request,
+ * which is the case whenever SDEI is active; on a false return the arch
+ * falls back to its regular-IRQ (or pseudo-NMI, if enabled) IPI.
+ *
+ * On a kernel built without paying the pseudo-NMI hot-path cost (the
+ * usual case for this driver's target), the IPI can't reach a CPU that
+ * has interrupts masked -- so the backtrace of the one CPU you care
+ * about comes back empty. SDEI is dispatched out of EL3 and lands
+ * regardless of the target's DAIF, without taxing the IRQ-mask path.
+ */
+bool sdei_nmi_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
+{
+	if (!sdei_nmi_available)
+		return false;
+
+	nmi_trigger_cpumask_backtrace(mask, exclude_cpu,
+				      sdei_nmi_raise_backtrace);
+	return true;
+}
+
+/*
+ * device_initcall (after arch_initcall(sdei_init), so the SDEI subsystem
+ * is up): probe the firmware, register the event, and turn on the
+ * cross-CPU service. If the probe fails the driver stays inert and the
+ * override hooks decline, leaving the arch's own paths in place.
+ */
+static int __init sdei_nmi_init(void)
+{
+	int err;
+
+	err = sdei_event_register(SDEI_NMI_EVENT, sdei_nmi_handler, NULL);
+	if (err) {
+		pr_err("sdei_event_register(%u) failed: %d\n",
+		       SDEI_NMI_EVENT, err);
+		return 0;
+	}
+
+	err = sdei_event_enable(SDEI_NMI_EVENT);
+	if (err) {
+		pr_err("sdei_event_enable(%u) failed: %d\n",
+		       SDEI_NMI_EVENT, err);
+		sdei_event_unregister(SDEI_NMI_EVENT);
+		return 0;
+	}
+
+	sdei_nmi_available = true;
+	pr_info("using SDEI cross-CPU NMI (SDEI_EVENT_SIGNAL, event %u)\n",
+		SDEI_NMI_EVENT);
+
+	return 0;
+}
+device_initcall(sdei_nmi_init);
-- 
2.54.0


