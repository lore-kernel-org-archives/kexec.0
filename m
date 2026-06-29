Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9A8C43602
	for <kexec@archiver.kernel.org>; Mon, 29 Jun 2026 15:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=42GRF8BTsv7+nYlGh2BR/oQLqLQxifxT9bHK+0Y0b6k=; b=MtXRXlext0hArkWc4yKmFvzely
	R926KUAGpopGP2LryqHLRIUcIwgU3sLwJcdmoC5DPrreG/x5pwEJQv5QFg271BX1IDXg4qdkZJaLr
	HYsPymdrAWO0ArRt3zuPziT2B2IV1y+2JBoEVdfqkYIP85jRYUuiN2PBCiqzc3Kck/FdTi/ESJuGr
	Wbjguk4N6fGUsK/wBBkzN84JYBmJteCa0wE6Pp+i+8aLoKiHV7qx9gZYiSI/+xh+4OINI9LEmYGpM
	WqvU4wMWTHO4QpC0C8/gRS9A72ugK7cEWtpHZfUOGfbyUvD1xdD2YWHKOlibKYb7uynv7bFUkuwjW
	cHnyWdTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weDa9-0000000F13c-0qMt;
	Mon, 29 Jun 2026 15:07:33 +0000
Received: from fhigh-a8-smtp.messagingengine.com ([103.168.172.159])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weDa4-0000000F0zG-1Ijg;
	Mon, 29 Jun 2026 15:07:29 +0000
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7756B14000EE;
	Mon, 29 Jun 2026 11:07:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 29 Jun 2026 11:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1782745647; x=1782832047; bh=42GRF8BTsv7+nYlGh2BR/oQLqLQxifxT
	9bHK+0Y0b6k=; b=jJDgmEtuk22qAgyh3SHRepNyfILnWdLxxp+nE/KxiMYibj9T
	x1qedpiXJs9QS3YTh1wfD/Sob/P3qing54sDCp+ggz8V9fvr9vDaCjC/uorKTue3
	uFnze6+z5tv3iux2keFOQ4m4Mn5sky+HYo4Z6hUKmxmQs2GHblz67RJEhEUGYqkN
	oX0pUyP4jtvz5uqejvRejG8ZaygteYUhRk6vbQjlg/enUUkxiKwE5hAv+MGAkMlQ
	7wa8uwSApIOML648SYm8YjDDoUMBU7E0bdUVPNWgad34N+3dQSmvUqQ1BKH+it6B
	/EeUNt+tgUwZr9e4S3bq/PFGqWfGTD+p21U4mQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782745647; x=
	1782832047; bh=42GRF8BTsv7+nYlGh2BR/oQLqLQxifxT9bHK+0Y0b6k=; b=S
	tvR6jAJYkNI3y0m0pxygRazPqFdVn1d2en8jPK92acLhT2os75LAbuhp1cyuP5Sb
	d+Q2pUooWJc2soHttY7F/xZCFK3ih8HjbNOFxxIkUwZftXFu5fBqht5/mUtzV1Yz
	1yCfw7CHpv9qkG5sEF8A///7JU9R78+T6xguvmg2c4HmxXFl0G9+SQeq0Jh44mFC
	7DeSrUyTN0UIEqapNp7hgEO6wW9JvOUdkG/YfLoDDu8WjD5yef3te/dFhYOs/7KR
	4fYFafl3NgyededtnVc+TxXlyy/MFTbTBnOtDIYmR6IV61PD/sTvZc3l8vg8kn2d
	Lj//01agYow2u10qpF3aA==
X-ME-Sender: <xms:L4pCanxtj3vlxIk0NB2w9WrXnomMKtx-OzqYEwlv3VyzZSda0w5I0g>
    <xme:L4pCamWcGq93Yi2PK7R8jzzdjGTdI38ChXtLbtEzkdiZshy8m-XcKljuMj0X9aKnQ
    uAnCXp6iA2ijWZSiuJYyTFq1CMIyuhQKOnQQ2PL2e5c55vSZI6IYRY>
X-ME-Received: <xmr:L4pCapB2vUOEvXmZGdsHjNfuXZo4I1jY81ZaySbpwbA-14-iBtNlzLSSIHxWKA>
X-ME-Proxy-Cause: dmFkZTGypgNcsMgEXbITZM2THTbgsfd6lrerEjaZ87J/EZZcLZfONkucGUF/z4/vwpLGz8
    CkkF+sfXEzFd6hSdGyzmzXzn/ngN0PUN0bXzpnG8YLBz+9fx/zqz4uoGj4qG6eK0Ojd4GL
    WSNSkOkW2rVBya2ul1ui3ekOSjx7pwWM2QkK5bO5sCxJJN8sgXC6ILZTgDDDuprZKePefE
    vC0aMPe9rG+VQ+YHUCtJ5qw9YnqrYHPe3s3yynGQcQWywEC03lqOsmAxPrFQA2poA8uJzk
    FO6IQvYHNGNAIfJ/bxcPiKvjFhk6k/gSM80ZUoT+nlyd/aBkjuySEOySRKCpnWQtSP+Idy
    ry+4T5bjbaL77zQxuGQxK+9SpFzhHSFIeRNLjEynLC9Rl8UCoZS9A4ZOeA96YYKlu2o6EG
    L9V9tIV3pzG1q4I5LEZnZIAXsiTcIU3PSJDYLiASv3Zwx2Mz0gO4GW8Por4FkICML1VRhW
    ITyZmfzTbp6qW8KMyG/MyOj1AaGl69dUSZnIJOpiqd3yPfyQQK0XthYwRqP8dW1WZZdk1C
    V9lflgwg8ehxxciOtKmWJJpOFa+41R+pviXJYp3KTpnA+nTop8GLO4vbch8/W+aZUVP1pt
    iOtZOt+pNlY82RfEKS9RzUfGWsQ0uCKPsi0zyafBUkEfd4dKtT+W9Zx7t53Q
X-ME-Proxy: <xmx:L4pCan6P_wYe1v-sgQ6bXtARgt043309Tiq4ZQPvRUzH6R6BRcbpqQ>
    <xmx:L4pCaltanaCKX-iqXxeeJZnjzHUyFDMi-TLbMM-4hBPs94iVeKzR_A>
    <xmx:L4pCavzr4pUQH5BhJpTb243EDqIXLwPhH3N2mwQELtZbvVmvYkme1w>
    <xmx:L4pCatbmIWEGAzU0ws8CzpqbtQnjQ92QoKW2PNukwlhwxaHADy-zAQ>
    <xmx:L4pCag_mnlQC_DdmF922AZyOE0IgTlksiD4F9ttxu9yVaS8zN0vC7Jh6>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 11:07:26 -0400 (EDT)
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
	Lecopzer Chen <lecopzer@gmail.com>,
	Sumit Garg <sumit.garg@kernel.org>,
	kernel-team@meta.com,
	kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [PATCH v5 3/4] drivers/firmware: add SDEI cross-CPU NMI service for arm64
Date: Mon, 29 Jun 2026 16:07:17 +0100
Message-ID: <1729f32fe1092dbf3514f24f6f53ee45dedf6007.1782744912.git.kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1782744912.git.kas@kernel.org>
References: <cover.1782744912.git.kas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260629_080728_508883_AEBA5C8B 
X-CRM114-Status: GOOD (  32.54  )
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
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 MAINTAINERS                     |   2 +-
 arch/arm64/include/asm/nmi.h    |  24 +++++
 arch/arm64/kernel/smp.c         |  11 +++
 drivers/firmware/Kconfig        |  19 ++++
 drivers/firmware/Makefile       |   1 +
 drivers/firmware/arm_sdei_nmi.c | 159 ++++++++++++++++++++++++++++++++
 6 files changed, 215 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/nmi.h
 create mode 100644 drivers/firmware/arm_sdei_nmi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c8d4b913f26c..b5ddfb85dce9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24797,7 +24797,7 @@ M:	James Morse <james.morse@arm.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/firmware/sdei.txt
-F:	drivers/firmware/arm_sdei.c
+F:	drivers/firmware/arm_sdei*
 F:	include/linux/arm_sdei.h
 F:	include/uapi/linux/arm_sdei.h
 
diff --git a/arch/arm64/include/asm/nmi.h b/arch/arm64/include/asm/nmi.h
new file mode 100644
index 000000000000..9366be419d18
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
+ * drivers/firmware/arm_sdei_nmi.c implements them when active; a future
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
index 1aa324104afb..a670434a8cae 100644
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
@@ -927,6 +928,16 @@ static void arm64_backtrace_ipi(cpumask_t *mask)
 
 void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
 {
+	/*
+	 * Prefer the SDEI cross-CPU NMI provider when active: firmware
+	 * dispatches the event out of EL3 and reaches CPUs that have
+	 * interrupts locally masked, without the per-IRQ-mask cost that
+	 * pseudo-NMI pays for the same reach. The plain IPI path below
+	 * can't reach such a CPU unless pseudo-NMI is enabled.
+	 */
+	if (sdei_nmi_trigger_cpumask_backtrace(mask, exclude_cpu))
+		return;
+
 	/*
 	 * NOTE: though nmi_trigger_cpumask_backtrace() has "nmi_" in the name,
 	 * nothing about it truly needs to be implemented using an NMI, it's
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index bbd2155d8483..dd47584d3b57 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -36,6 +36,25 @@ config ARM_SDE_INTERFACE
 	  standard for registering callbacks from the platform firmware
 	  into the OS. This is typically used to implement RAS notifications.
 
+config ARM_SDEI_NMI
+	bool "SDEI-based cross-CPU NMI service (arm64)"
+	depends on ARM_SDE_INTERFACE
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
index 4ddec2820c96..be46f1e1dc77 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -4,6 +4,7 @@
 #
 obj-$(CONFIG_ARM_SCPI_PROTOCOL)	+= arm_scpi.o
 obj-$(CONFIG_ARM_SDE_INTERFACE)	+= arm_sdei.o
+obj-$(CONFIG_ARM_SDEI_NMI)	+= arm_sdei_nmi.o
 obj-$(CONFIG_DMI)		+= dmi_scan.o
 obj-$(CONFIG_DMI_SYSFS)		+= dmi-sysfs.o
 obj-$(CONFIG_EDD)		+= edd.o
diff --git a/drivers/firmware/arm_sdei_nmi.c b/drivers/firmware/arm_sdei_nmi.c
new file mode 100644
index 000000000000..4047fcda0bc3
--- /dev/null
+++ b/drivers/firmware/arm_sdei_nmi.c
@@ -0,0 +1,159 @@
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
+#include <linux/kprobes.h>
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
+NOKPROBE_SYMBOL(sdei_nmi_handler);
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
+	/*
+	 * Publish backtrace_mask (set by nmi_trigger_cpumask_backtrace())
+	 * before signalling. As in the stop path, the SMC is not a memory
+	 * store, so dsb(ishst) is needed for the target to observe the mask.
+	 */
+	dsb(ishst);
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
+	if (!sdei_is_present())
+		return 0;
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


