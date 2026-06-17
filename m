Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414ACCD98E2
	for <kexec@archiver.kernel.org>; Wed, 17 Jun 2026 19:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gLZx3HaullBvnvWkQhxEqVHCdwkvAU77s/W3t2gOuew=; b=kBs+LAQqUmsq4ztktXv5XVRrSX
	U0tjZKfSe48SgO5/sFQrrmHuJgtBz/mtcf3qFUb3QGvac6P8zO61WoD4FAu9ibYMJZ4+8i/Oe4k7+
	lGdJbKOQOBiraOhCapCls52/mRKtX1hlF8G43OJgfiKxbSUjMkQPDqrmRVQJfd+UghQaLiJBIIqxe
	htH5Rt+HTVLiVt3QccxICGBnjpTfUy6em+I6FSQMaHVMSeKDLZqcBGjMDkxO8L0XUqXxt3Oqy4pge
	YspT9H3apuBIbqNarYVMGCNIH9xR44cfMiBqpsC9L2j6dcqr+WDOfYbi+Som7h0JchUm3i7ob76HV
	hf/F5FfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZvoJ-00000000Fao-0eeG;
	Wed, 17 Jun 2026 19:20:27 +0000
Received: from fhigh-b7-smtp.messagingengine.com ([202.12.124.158])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZvoG-00000000FXi-1byd;
	Wed, 17 Jun 2026 19:20:25 +0000
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4FFBF7A0163;
	Wed, 17 Jun 2026 15:20:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 17 Jun 2026 15:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1781724023; x=1781810423; bh=gLZx3HaullBvnvWkQhxEqVHCdwkvAU77
	s/W3t2gOuew=; b=cS5xIlgsgsN7UIdf6j7B0Q9GV32AH/mnOKODpsgaMGyGnXRW
	rCE0PKOnRCOw6Md28yDXIE5KigPH6NUWz8CHywz64NTOZm9nGTQXIWs+D80M9lTB
	Ao0RH6QYSELLGXnnWHP+bv5ZCujc1tTrRjIXEH7RZnIDI05Zh2UclS2H4jnW+DQD
	1ut/4gyYSB+iYGjFex8Qj6x/0b5mC2Ot+uEIjIxTrVZq89VxvbD3C+py2uCUS4xW
	+YGrRZZ0suB7w6tXbK6JFP511SdA/8HhlQNaa2CJ44Ki5cam8Yw2hrzcV8IzczQ+
	5EV9AlyivjxsjgE9t9A5/2EqLNN5EBCSYm5dUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781724023; x=
	1781810423; bh=gLZx3HaullBvnvWkQhxEqVHCdwkvAU77s/W3t2gOuew=; b=U
	EZGmBi1zcUy9EpRiCZwAu+s28aApVNeMUpV8/taLfSLfVMqTTcN76Alym9+JYxMv
	z9DC/TKLYMru1D7zQxUg7MdvF40aWEjQjm+vcl6d3y4+C6i2JgndkFxvTcPam1ss
	q3ytBv4M37yWngMtJvaqk3fI+ab7IFNW46J727s4dNGibaq5xDYGKuLA4QOdvkXZ
	fL9OWNCtJ8E/0EABZGRg1798pPE0RLshnQcQCnY44wmC/EgaP7zKMDcH1Saef68l
	NqXedPIdooWXUOcid7EnmZL1/Kfapll6DbFiJF16Zo0NIRuQnhRxPz3gu6zgEhXG
	WmIbpNHP2LX2f3Cgoy42w==
X-ME-Sender: <xms:dvMyanbTHChOVsVnqLf6lZ0FBzE_tqize7URoNosjebpfgDYDB3mfw>
    <xme:dvMyatejZf9Sens00hwyj6Hq8YVrNJ7MVvzHFSwbJOx26T0jKAilWQziu45n93GqX
    aN0WkZQEkIR_36hado6ZroGQWi4qaSTwE5_xDQs8l4a7p-Q3VKCpg>
X-ME-Received: <xmr:dvMyahoOeJUcarn4PHmPuFPdIwX4tt9jHzYq3aHzTNHqj_EJEzQIds-nbtgD5Q>
X-ME-Proxy-Cause: dmFkZTFsPFgKyXzv/v25r54hbk8/83/7RPJPQuFXGYgaxJPSyZ9FsTdZnBucijlFiTQe3w
    ViMDjPN0jC5nQJG2pww4GLpAdl1QFV3uTqpESNhtBWBMz/Jqt+W48GMm21ryvs5z3IrMTn
    2XLNXV6lgZEkvypoPSIXbxm+VlQs2BUioaI2baI9LCqQE0ayhkP+GV1iQtfHKRgcaqaRqV
    h4KsLqIrVqes0jC1n9oObM8PQ+GqFG2xgVRisO7GtP7SfKt3BIy8J4TbB1Aty855YcQAiT
    7e+T2JTw6+qQycUtMKLGbm/Iqs3hzqMCLbIF16iuOpeVK17h0T895evcMcrHmiWC8b36A3
    lFtBacueNWO4GKc50KYbjvQ17Z+3j+U4/BLX9zp0bc4GuFimwPSzAEl90SFe71c+CTcMYN
    21CjrD2pwWAAvJNKVgTCQg0XX1h7Dfh/6Lg7L6qyj14g3gKKlK2VJHGl8uOu4KlK0yT0cS
    F5Dy1/kiid/+FAUwJy9jit41uzfrf/XR5dmIFUypCRJGlx56Od+OwnlDnM+wttKBa5PKfD
    hiVba+80CqxXrczKYhPl8gc95XZN0oysathHNprnDIMSu5HmEoMUsQ+lvT9c9LV8muzsaZ
    xR2jchKZoEVYE5gpm9Pzaqczu7N9vRSQH0Mk94fIb2jvFXoFrF4MVEncV5GA
X-ME-Proxy: <xmx:dvMyakAR0NbjtMxmU49PoLK5e38kdy-57qrTZaPz7fPqoF3hv9XhBA>
    <xmx:dvMyavXl0Esfhd5iOys8eqnlCGmH5U4S1JUoM2ttKIfHmsEtRrv_tQ>
    <xmx:dvMyao64OQgM4O2ObaBmXWQH1TqEOzA7YMnbVakV3-9SOY1RxQzeng>
    <xmx:dvMyagAtej6RPeWhyphZVmeKhbesGQ8h1GzDylwDhwES_LzS9RLS2A>
    <xmx:d_MyalGku-PBXWqzYw7L5JuHi3X5ux2wt_gAlp30jn9FH3xJZxX7Pw8A>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 15:20:22 -0400 (EDT)
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
Subject: [PATCH v4 4/4] arm64: escalate smp_send_stop() to an SDEI NMI as a last resort
Date: Wed, 17 Jun 2026 20:20:05 +0100
Message-ID: <97a870d0670b7e1c2fb9f5142f6e36c594282017.1781709543.git.kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1781709543.git.kas@kernel.org>
References: <cover.1781709543.git.kas@kernel.org> <cover.1781709543.git.kas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260617_122024_548327_69E084D3 
X-CRM114-Status: GOOD (  28.12  )
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

A CPU wedged with interrupts masked ignores the stop IPI, and without
pseudo-NMI there is no NMI IPI to escalate to: a reboot proceeds with
the CPU still running, and a kdump misses its registers.

Add a third rung to smp_send_stop(): once the IPI (and pseudo-NMI IPI,
if enabled) rungs have run, signal SDEI event 0 at whatever stayed
online. Firmware delivers it regardless of the target's DAIF, so it
reaches a CPU a plain IPI cannot; the target acks by going offline,
which the caller already polls for.

Fold the stop bookkeeping into one arm64_nmi_cpu_stop(regs,
die_on_crash), shared by the stop IPI handlers, panic_smp_self_stop()
and the SDEI handler, replacing the near-duplicate local_cpu_stop() and
ipi_cpu_crash_stop(). @die_on_crash is the only difference: the IPI
handlers pass true and PSCI CPU_OFF the CPU on a crash stop so a capture
kernel can reclaim it; the SDEI handler and self-stop pass false and
park. The SDEI park is required, not conservative -- its handler runs
inside an SDEI event that is never completed (completing it resumes the
wedged context), and a CPU_OFF from that unfinished-event context wedges
EL3 on some firmware (left as a follow-up). The dump is unaffected; only
re-onlining the CPU in an SMP capture kernel is lost.

Suggested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 arch/arm64/include/asm/nmi.h    |  24 +++++++
 arch/arm64/kernel/smp.c         | 113 +++++++++++++++++++++-----------
 drivers/firmware/Kconfig        |   2 +
 drivers/firmware/arm_sdei_nmi.c |  86 ++++++++++++++++++++++++
 4 files changed, 187 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/include/asm/nmi.h b/arch/arm64/include/asm/nmi.h
index 9366be419d18..2e8974ff8d63 100644
--- a/arch/arm64/include/asm/nmi.h
+++ b/arch/arm64/include/asm/nmi.h
@@ -4,21 +4,45 @@
 
 #include <linux/cpumask.h>
 
+struct pt_regs;
+
 /*
  * Cross-CPU NMI provider hooks, consulted by the arm64 arch code before
  * its regular-IRQ / pseudo-NMI IPI paths. The SDEI provider in
  * drivers/firmware/arm_sdei_nmi.c implements them when active; a future
  * FEAT_NMI provider could slot in here too. The stubs let callers stay
  * unconditional when ARM_SDEI_NMI is off.
+ *
+ * sdei_nmi_active() lets a caller test for the service before committing
+ * to (and waiting on) the SDEI stop rung; sdei_nmi_stop_cpus() then signals
+ * the targets, which ack by going offline.
  */
 #ifdef CONFIG_ARM_SDEI_NMI
 bool sdei_nmi_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu);
+bool sdei_nmi_active(void);
+void sdei_nmi_stop_cpus(const cpumask_t *mask);
 #else
 static inline bool sdei_nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
 						      int exclude_cpu)
 {
 	return false;
 }
+
+static inline bool sdei_nmi_active(void)
+{
+	return false;
+}
+
+static inline void sdei_nmi_stop_cpus(const cpumask_t *mask) { }
 #endif
 
+/*
+ * The common "stop this CPU" entry every arm64 stop path funnels through:
+ * the regular/pseudo-NMI stop IPI handlers, panic_smp_self_stop(), and the
+ * SDEI cross-CPU NMI handler. @die_on_crash powers the CPU off on the kdump
+ * crash path (IPI handlers) instead of parking it (SDEI / self-stop).
+ * Defined in arch/arm64/kernel/smp.c.
+ */
+void __noreturn arm64_nmi_cpu_stop(struct pt_regs *regs, bool die_on_crash);
+
 #endif /* __ASM_NMI_H */
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index a670434a8cae..05c7007a1f4a 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -33,6 +33,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/kexec.h>
 #include <linux/kgdb.h>
+#include <linux/kprobes.h>
 #include <linux/kvm_host.h>
 #include <linux/nmi.h>
 
@@ -862,14 +863,62 @@ void arch_irq_work_raise(void)
 }
 #endif
 
-static void __noreturn local_cpu_stop(unsigned int cpu)
+/**
+ * arm64_nmi_cpu_stop() - stop the local CPU after it is told to stop.
+ * @regs: register state to record in the vmcore on a crash stop, or NULL for
+ *        panic_smp_self_stop(), which has no interrupted context to save.
+ * @die_on_crash: on the kdump crash path, power the CPU off via PSCI CPU_OFF
+ *                (so a capture kernel can reclaim it) rather than parking it.
+ *
+ * The single point every arm64 stop path funnels through, keeping the
+ * bookkeeping (mask interrupts, save the crash context, mark offline, mask
+ * SDEI, optionally power off) in one place:
+ *
+ *   - the regular IPI_CPU_STOP and pseudo-NMI IPI_CPU_STOP_NMI handlers;
+ *   - panic_smp_self_stop(), a CPU parking itself on a parallel panic();
+ *   - the SDEI cross-CPU NMI handler (drivers/firmware/arm_sdei_nmi.c),
+ *     which reaches CPUs the stop IPIs could not.
+ *
+ * The IPI stop handlers pass @die_on_crash true. The SDEI handler and
+ * panic_smp_self_stop() pass false and only park. For SDEI that is required,
+ * not just conservative: it runs inside an SDEI event that is deliberately
+ * never completed (completing it has firmware resume the wedged context), and
+ * a CPU_OFF from that not-yet-completed context wedges EL3 on some firmware --
+ * a documented follow-up. Parking also matches this path's own fallback when
+ * CPU_OFF is unavailable.
+ */
+void __noreturn arm64_nmi_cpu_stop(struct pt_regs *regs, bool die_on_crash)
 {
+	unsigned int cpu = smp_processor_id();
+	bool crash = IS_ENABLED(CONFIG_KEXEC_CORE) && crash_stop;
+
+	/*
+	 * Use local_daif_mask() instead of local_irq_disable() to make sure
+	 * that pseudo-NMIs are disabled. The "stop" code starts with an IRQ
+	 * and falls back to NMI (which might be pseudo). If the IRQ finally
+	 * goes through right as we're timing out then the NMI could interrupt
+	 * us. It's better to prevent the NMI and let the IRQ finish since the
+	 * pt_regs will be better.
+	 */
+	local_daif_mask();
+
+#ifdef CONFIG_KEXEC_CORE
+	if (crash && regs)
+		crash_save_cpu(regs, cpu);
+#endif
+
+	/* the ack a stop requester (e.g. smp_send_stop()) polls for */
 	set_cpu_online(cpu, false);
 
-	local_daif_mask();
 	sdei_mask_local_cpu();
+
+	if (crash && die_on_crash)
+		__cpu_try_die(cpu);
+
+	/* just in case */
 	cpu_park_loop();
 }
+NOKPROBE_SYMBOL(arm64_nmi_cpu_stop);
 
 /*
  * We need to implement panic_smp_self_stop() for parallel panic() calls, so
@@ -878,36 +927,7 @@ static void __noreturn local_cpu_stop(unsigned int cpu)
  */
 void __noreturn panic_smp_self_stop(void)
 {
-	local_cpu_stop(smp_processor_id());
-}
-
-static void __noreturn ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
-{
-#ifdef CONFIG_KEXEC_CORE
-	/*
-	 * Use local_daif_mask() instead of local_irq_disable() to make sure
-	 * that pseudo-NMIs are disabled. The "crash stop" code starts with
-	 * an IRQ and falls back to NMI (which might be pseudo). If the IRQ
-	 * finally goes through right as we're timing out then the NMI could
-	 * interrupt us. It's better to prevent the NMI and let the IRQ
-	 * finish since the pt_regs will be better.
-	 */
-	local_daif_mask();
-
-	crash_save_cpu(regs, cpu);
-
-	set_cpu_online(cpu, false);
-
-	sdei_mask_local_cpu();
-
-	if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
-		__cpu_try_die(cpu);
-
-	/* just in case */
-	cpu_park_loop();
-#else
-	BUG();
-#endif
+	arm64_nmi_cpu_stop(NULL, false);
 }
 
 static void arm64_send_ipi(const cpumask_t *mask, unsigned int nr)
@@ -984,12 +1004,7 @@ static void do_handle_IPI(int ipinr)
 
 	case IPI_CPU_STOP:
 	case IPI_CPU_STOP_NMI:
-		if (IS_ENABLED(CONFIG_KEXEC_CORE) && crash_stop) {
-			ipi_cpu_crash_stop(cpu, get_irq_regs());
-			unreachable();
-		} else {
-			local_cpu_stop(cpu);
-		}
+		arm64_nmi_cpu_stop(get_irq_regs(), true);
 		break;
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
@@ -1263,6 +1278,28 @@ void smp_send_stop(void)
 			udelay(1);
 	}
 
+	/*
+	 * If CPUs are *still* online, try the SDEI cross-CPU NMI. Firmware
+	 * delivers it regardless of the target's DAIF state, so it reaches
+	 * a CPU spinning with interrupts masked, which neither rung above
+	 * could (without pseudo-NMI there is no NMI rung at all). Allow
+	 * 100ms: a firmware round-trip per CPU, with headroom.
+	 */
+	if (num_other_online_cpus() && sdei_nmi_active()) {
+		/* re-snapshot after the rungs above took CPUs offline */
+		smp_rmb();
+		cpumask_copy(&mask, cpu_online_mask);
+		cpumask_clear_cpu(smp_processor_id(), &mask);
+
+		pr_info("SMP: retry stop with SDEI NMI for CPUs %*pbl\n",
+			cpumask_pr_args(&mask));
+
+		sdei_nmi_stop_cpus(&mask);
+		timeout = USEC_PER_MSEC * 100;
+		while (num_other_online_cpus() && timeout--)
+			udelay(1);
+	}
+
 	if (num_other_online_cpus()) {
 		smp_rmb();
 		cpumask_copy(&mask, cpu_online_mask);
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 6501087ff90d..ab0ee36d46e7 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -46,6 +46,8 @@ config ARM_SDEI_NMI
 	    - arch_trigger_cpumask_backtrace()  (sysrq-l, RCU stalls,
 	      hardlockup_all_cpu_backtrace, soft-lockup secondary dumps,
 	      hung-task auxiliary dumps)
+	    - smp_send_stop() escalation         (reboot/halt and the
+	      panic / kdump crash stop)
 
 	  The driver registers a handler for the SDEI software-signalled
 	  event (event 0) and reaches a target CPU by signalling it with
diff --git a/drivers/firmware/arm_sdei_nmi.c b/drivers/firmware/arm_sdei_nmi.c
index 2a78cee203fb..68bbf981fdd7 100644
--- a/drivers/firmware/arm_sdei_nmi.c
+++ b/drivers/firmware/arm_sdei_nmi.c
@@ -29,6 +29,11 @@
  *     hardlockup_all_cpu_backtrace, soft-lockup/hung-task secondary
  *     dumps all reach interrupt-masked CPUs.
  *
+ *   - sdei_nmi_stop_cpus() — the last rung of smp_send_stop()'s
+ *     escalation (reboot/halt and the panic/kdump crash stop alike),
+ *     reaching CPUs that ignored the stop IPIs; on the kdump path the
+ *     wedged context is captured into the vmcore before the CPU parks.
+ *
  * Delivery uses the standard SDEI software-signalled event (event 0) and
  * SDEI_EVENT_SIGNAL. We register a handler for event 0, enable it, and
  * poke a target CPU with sdei_event_signal(0, mpidr): firmware makes
@@ -59,8 +64,57 @@ static bool sdei_nmi_available;
 
 #define SDEI_NMI_EVENT			0
 
+/*
+ * Backtrace and stop both ride SDEI event 0. That is not a chosen economy:
+ * event 0 is the only architecturally software-signalled event -- the sole
+ * event SDEI_EVENT_SIGNAL can target at an arbitrary PE. Every other event
+ * number is a firmware/platform interrupt-bound event, not something the
+ * kernel can raise cross-CPU, so a dedicated "stop" event would need
+ * firmware to define and bind it -- exactly the firmware dependency this
+ * driver sets out to avoid.
+ *
+ * Sharing one event means the handler must tell a stop apart from a
+ * backtrace. A stop is terminal and system-wide -- sdei_nmi_stop_cpus() is
+ * only reached from smp_send_stop() (reboot/halt/panic/kdump), which never
+ * returns -- so once a stop is requested, every later event-0 fire is a
+ * stop too. A single write-once flag therefore carries as much as a
+ * per-CPU mask would: sdei_nmi_stop_cpus() sets it before signalling, and
+ * the handler reads a set flag as "stop this CPU" and a clear flag as
+ * "backtrace" (handled by nmi_cpu_backtrace(), which self-gates on the
+ * framework's backtrace mask). A backtrace fire that races in after a stop
+ * has begun just stops that CPU instead -- harmless, it is going down.
+ */
+static bool sdei_nmi_stopping;
+
 static int sdei_nmi_handler(u32 event, struct pt_regs *regs, void *arg)
 {
+	/*
+	 * No smp_rmb() pairing sdei_nmi_stop_cpus()'s smp_wmb(): the flag is
+	 * the only shared value, and this handler runs only because firmware
+	 * delivered the event -- a round-trip past that store -- so the read
+	 * cannot be stale and there is no second load for a barrier to order.
+	 */
+	if (READ_ONCE(sdei_nmi_stopping)) {
+		/*
+		 * Never returns, and deliberately never completes the SDEI
+		 * event: SDEI_EVENT_COMPLETE has firmware restore the
+		 * interrupted context, which would land the CPU back in
+		 * the wedged loop (or in do_idle, which BUGs at
+		 * cpuhp_report_idle_dead once it sees itself offline).
+		 * Returning a modified pt_regs doesn't help --
+		 * arch/arm64/kernel/sdei.c::do_sdei_event only honours a PC
+		 * override via its IRQ-state heuristic and otherwise hands
+		 * EL3 its own saved-context slot back.
+		 *
+		 * Trade-off: EL3 retains ~one saved-context slot per parked
+		 * CPU until the next hardware reset (~hundreds of bytes per
+		 * CPU). Recoverability is unchanged versus an IPI-stopped
+		 * CPU: neither comes back without a reset.
+		 */
+		arm64_nmi_cpu_stop(regs, false);
+		/* unreachable */
+	}
+
 	/*
 	 * nmi_cpu_backtrace() no-ops unless this CPU's bit is set in the
 	 * global backtrace mask (driven by nmi_trigger_cpumask_backtrace()),
@@ -115,6 +169,38 @@ bool sdei_nmi_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
 	return true;
 }
 
+bool sdei_nmi_active(void)
+{
+	return sdei_nmi_available;
+}
+
+/*
+ * Last rung of the stop escalation in smp_send_stop() (see
+ * arch/arm64/kernel/smp.c). The caller runs the regular stop IPI (and
+ * the pseudo-NMI stop IPI, where available) first; @mask holds whatever
+ * stayed online through those -- typically CPUs wedged with interrupts
+ * masked, unreachable by an IPI. Mark the stop in progress and signal
+ * event 0 at each target; a target acks by marking itself offline, which
+ * the caller polls for. The caller has already confirmed sdei_nmi_active().
+ */
+void sdei_nmi_stop_cpus(const cpumask_t *mask)
+{
+	unsigned int cpu;
+
+	WRITE_ONCE(sdei_nmi_stopping, true);
+
+	/*
+	 * Publish the flag before signalling. The SMC is a context-sync
+	 * event, not a barrier, so WRITE_ONCE() alone could let the store be
+	 * observed after the event it triggers. The barrier is cumulative: a
+	 * target that sees the event is guaranteed to see the flag.
+	 */
+	smp_wmb();
+
+	for_each_cpu(cpu, mask)
+		sdei_nmi_fire(cpu);
+}
+
 /*
  * device_initcall (after arch_initcall(sdei_init), so the SDEI subsystem
  * is up): probe the firmware, register the event, and turn on the
-- 
2.54.0


