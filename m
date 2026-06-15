Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB197CD8CA8
	for <kexec@archiver.kernel.org>; Mon, 15 Jun 2026 02:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NMBzibPuJbC+34VWd5B5SSUJSzSvju7SCOBane7O9mE=; b=jxiASJ7CwJGUxlXF4FM70oHRVX
	fPQa6pga1W9JTNOcTLNOGJEZrNa5XaYJy7sgjoBPYRCayOMdRH8+Ocd49EzIEijc2Va7lzFhJdmzm
	t0qFl5BoG+vv4aFSztx0fBCSiEAmSWaffXprJEuj7Ha5AA63oAxqW6yXdGJkmt7TnlcCj4jvTgIa2
	wr6OZEG1eCEnvgp+NAebUN6i+CBmJA8oFVDYSHr31M6iyDjeBgQdXxa2+WfM5LNLgJVuJq0IJadmJ
	EhGAR+oz2EkS6WYm+bcvErcEuuYIP+I+NApc7ddSWrTUA2r2PNzeWGSuoQsYPkvcqYnTTKG6WL3nv
	9bkqFjAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYxB8-0000000DTW0-3nDp;
	Mon, 15 Jun 2026 02:35:58 +0000
Received: from fout-a5-smtp.messagingengine.com ([103.168.172.148])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYxB6-0000000DTUG-1vLW;
	Mon, 15 Jun 2026 02:35:57 +0000
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 9E5C6EC00C7;
	Sun, 14 Jun 2026 22:35:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 14 Jun 2026 22:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1781490955; x=1781577355; bh=NMBzibPuJbC+34VWd5B5SSUJSzSvju7S
	COBane7O9mE=; b=VbVaBIRpdbHWFnqp9i7KZhEs8gZMI/zxns/aC+zQ0wQXwVKa
	LY+HEX7hL7idmG6EZeq45RWzNM/v4jiKHUu+xh5mp+jHsM6akFh9j6x0Z3w+mwbi
	z5ig45E066/o8KdIKGirQj4dtjJuNj0LJ1HZeegvRZ0adbOaH6Cw9LZQ+/TPgZ14
	vmhFr+intlnzjjJ2JrWmzOJ639C8cPxrXgobIG76Mz52lkR+NYWhXc5pqCDlXQV+
	kCvSd9eKtOiY2UczSYnCC2TbL53u6bKkkssfTwSbE6F9is1KP3e57MDch0W+yW0z
	8mjxW/MukwwLz2ISDaZb97huJHkqX1F7WgjRBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781490955; x=
	1781577355; bh=NMBzibPuJbC+34VWd5B5SSUJSzSvju7SCOBane7O9mE=; b=E
	BfhpBcWcTmiq8lYBHGaRIyJl6ABCmu6YzIG0GHzY2VcmUBA+376JxIZNxOTDGiyO
	I6LO7wEiWbajajKQDNXKn6yu68WGxFjliR2FeVyi9Gl88jJneW9lq8VZNWWKOrHZ
	DzkAKCcIT/z9lZ05l7tvSyUVeaJGAl+4g+PS3+Aagbg8hf6MaF5Ozgo2xlD212d9
	wQe7QtMiQb1jltNyE5fN7IttZU+V+u+xCMMT4K6fPXTdCuXtLEayw+8s2KD+WV7h
	vSl+wOZZuEU4C5w3y0cmm+CXqaPryh0q77okLHRdhjxMe4jLFnBdTNzYIKKEx2kS
	FCOanJWNB7hkrt3ADprrg==
X-ME-Sender: <xms:C2Uvan4DkXKsdJeVmMBTqLFlS6gVerisdZtjNEPAvOuxRq2V7kQg6Q>
    <xme:C2Uvaj9HZU3aSNf4GM_tcbkEaqM8OmESMwMfBa8aV-3XkIxvdoNx4cAvXX5HQQGnl
    b5_23QHhENVhtHwcXeVoLt8-KRMbuNHSResWMS9AJmvagjTUKjsAQ>
X-ME-Received: <xmr:C2UvamIRAEwgBgaJ0tLHnpVCjGaK1DF4ebG6ETJB8lI_c7Ta25sRC74F0Gb5yw>
X-ME-Proxy-Cause: dmFkZTFakJqX0EOuDMhZfCH7WSEwTMnsqNGnwQDjjjW2TI+uF+w+jzLt4M5tOrMnTFCubU
    aSsldToimsQ1Uzl+3t7p1g7o3H01tM45nA1ZyvbOrHPGBs9RoiZzAUdDFXUQOgY/8YXDrj
    myBlLXbuufbWxCUfdmhhstfPtQRf3l0ZGpGGabSWUdnr5xwO5JNYHoXCFwGAXc5JWGumJ6
    I7YxEywnHJy1BmwAXu+ZOr2DLYqldJKJIMfx3vK2+GwYHezQVQJ0aD8P+Pr6AdjUHWiBzc
    ey0WHTyP3nf1X82eonkP7QRUKcwoJPRDAco5hgxfbys8YxbaEC+WZMSrU6bAYd7//V5jmt
    7a8Nz1PO3j/GEqMrForO/Etv7LEl8GcenKrFVoj1Vh3tDEHOMe9BbYrmMVzEpeacnLrSsV
    ps8AaWL5KGBKy9xA/PwY9jHDs6b5ZizJENthuz/+XxYiUbnA/tB9+Ptos+8t6QJzwonXVK
    FsqDSyOlN6hpR1JN8XFwPkmJhRVP2Ds8FEoAyur3wznPrjPUnZCwwDAgkkhp3xFbnk3G2O
    UzYmjIzml+r2xRCnUkJexvFqJPVLmukVltxVJ/7z7+64bdfE8doTMZuN0bEOqPL9xe5X7h
    uvqzMuBVupnEz5fUFdLra5mLFHUfGMz1B38ZNcdToKYf+OMFC5lJV+JkJNSA
X-ME-Proxy: <xmx:C2UvaugmDDho-bGCcTrFUHs0w_m8cz2ye16fY2SlUFvcIIrHwRmyZA>
    <xmx:C2Uvan0Ou1QHKFx4nX9caRIX4_KQtXZX7KkqS25IzyQvRve1p_452A>
    <xmx:C2UvanYqt4Ge5mrE6wgA6D-cXaDsJhtEwQarYIZDCqQuiY_24k__DQ>
    <xmx:C2UvasgcGt9uEla7l8OnbNIwUrBDcV4cyJRmP2fQK8231R1APX_YYg>
    <xmx:C2UvavkTqCDBwXAbnOXb-jaSFw-C42-wjkQg1xfK9J-NbDSWncNITEIK>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Jun 2026 22:35:53 -0400 (EDT)
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
Subject: [PATCH v3 2/3] drivers/firmware: add SDEI cross-CPU NMI service for arm64
Date: Mon, 15 Jun 2026 03:35:33 +0100
Message-ID: <704b467d5b320da9cf49fc9bb4a6814063986f3b.1781490440.git.kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1781490440.git.kas@kernel.org>
References: <cover.1781490440.git.kas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260614_193556_647391_9F4FB97F 
X-CRM114-Status: GOOD (  31.90  )
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
 drivers/firmware/arm_sdei_nmi.c | 149 ++++++++++++++++++++++++++++++++
 6 files changed, 205 insertions(+), 1 deletion(-)
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
index 000000000000..a82776e7b55a
--- /dev/null
+++ b/drivers/firmware/arm_sdei_nmi.c
@@ -0,0 +1,149 @@
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


