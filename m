Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A236CD8CA4
	for <kexec@archiver.kernel.org>; Tue,  9 Jun 2026 13:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=932CHg0JlRPr8pHThcm7pMsppUWkOrUH+PNyex/JXkE=; b=xoYzElmzhpCCdIVhphVfnZayct
	PkOeSUI07wttA4Wjwgl2auDO8FQxi7VTQ0BzAgvyI4UmfEmwTfJNjdnevbJ4MfPd6LGsXGkWD+iW8
	b5tkj87kPv+oVbZYw8KfyMoMO4unfKYFyYVbyklwLTcht0yKYNz6/v/jaWp4NfxL4QgzC/BopC//o
	gfc4rN4fZ8jbQrkpUF4giyZS1Z6OVCT3HXK1MSccThgarixxEbqNYizHalfKhlk4d9yfefrMgq7kn
	PBPQBl5XwCZyWpymPk8/hU6sgpVmYlngzs2ttzv9+UqguZwxNQmCyOJYNAA8gs0eiLYOeQ2blt9Tw
	pT201Paw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWwyq-00000005iuR-1Is5;
	Tue, 09 Jun 2026 13:59:00 +0000
Received: from fhigh-b5-smtp.messagingengine.com ([202.12.124.156])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWwye-00000005ipt-2YBE;
	Tue, 09 Jun 2026 13:58:50 +0000
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 78E0C7A0113;
	Tue,  9 Jun 2026 09:58:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 09 Jun 2026 09:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1781013527; x=1781099927; bh=932CHg0JlRPr8pHThcm7pMsppUWkOrUH
	+PNyex/JXkE=; b=jJAyQI4NkxK+oMAfwlyJ+06sXkNTPH0GBWuA8MvyAXyUb/LL
	nrqourpxNe4w2TeHtF6lhZvN3DNbyfGZuTTt0gibE6yb3Rc0Corehy3izYIYs4+8
	cR0jBfOBLV+w54m6bejctyl3YS/LHeuxKQlj8cdfb6nXh8vGpcai9FWUyCpYseRx
	9UiGj7sC5MAMhn+K/UK1HZPqLXW+vYQfcdgTfQohd+OkA1UqwatIIin3e0BUDoAs
	Om+1hsxtflV8fbWGGe5YckQL6cUe77R2ShRQ9IbcISFcGrnlIIjJ5zEJt69KUkLL
	SVuyoKjLY6RGp2BbB2hFeVAdkdaWYGt0xEkUMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781013527; x=
	1781099927; bh=932CHg0JlRPr8pHThcm7pMsppUWkOrUH+PNyex/JXkE=; b=X
	V1mSzclkc6ypP8XYYcoDGQct//SJOJF6rEMeeBmc2q/Clrw8VKMrlDvEI7U9A3zF
	hGYvYKXMgRRFf4DEcNhn83xh49HNNPstz+KMekV9mqpAlVzwF7YhLblLDmDwgk1h
	S9hgrCI2treR5SOcos9IafqR0W2eFvERS9zkyl2K7EigVWu126bWBTjRX03O12Oy
	zI1WLx+d/QOzf3uUx3oTVjVh4OHD1H0ZDIPS3Eajhpj+vOaGDI6x8qCemJt5WhOg
	ucfiDl4C7jrwRmKmIjLS3Eivm7PmEou6v9xjQUQ40Kcj+X7hkrT2jdqj0a6xkGT0
	O5mSUamtzSxu6VV/+OJGw==
X-ME-Sender: <xms:FhwoauFxiJDLQxFg7H6KlbD94O3M_ZgCnbcu2O_K3Sghs48hN3wwjw>
    <xme:FhwoamY5MPqj30ztLxZz6zqi6lPFOSNYwEOPHm3PGOS3oNYiO6G2MdGcreZ0LbUTv
    AwjD7fsy8ZgR6ukQzt7THYau6hsmLjtfj5nr4dROcQiOWZNKw0adoc>
X-ME-Received: <xmr:Fhwoav017EFWkpBbNVwoqxD_6fUfxFsZw7ynu2s-tYkrN5KqnghXR27mP4GaMQ>
X-ME-Proxy-Cause: dmFkZTEpGzrJ89AXC6S2iHGKv09ECFVNPV6Be7gwUsMOQmv22ONfc0ba/6wvaBeFwA/cxg
    MJ67lnxv/jrDU0sLpitFDCswUAl1U6wOOtidtXMRQHoHY7wZmqKkjtnA0V3SV3TpELWtpW
    u4MmJ433Oi+Pmm8ElBYItZHtF5JCw1QOZygVilvC13wwtiDpB5a7YaBFS9/25iGnDOSLk4
    O4fYFpEoy7p8jbSwcaXfg27PnAIYOxqtnu5GqN8DQt+ox7CgkGDY2Wy1e3Q8SU171xKLTp
    MBkPN0M6Owd8rXHdDnN2AhkEBWjeOvcJmylqEUtHdQZqCRYUETtagrYVi+jiNBgo0hVZV6
    GTulzbI20Hsr6f2MhccNNFQn0A+WcEs8L5f2AtG6QJwlkVaz3LjVE6/mo5oZhXAnezKjUg
    4TqKDrkMwGsG7AS5vZOlFSCIwl3NGtaozi5S+CQ/F65t9qIm/Q+DiuJT7pORBpJOQ6qBfX
    v7DwT2Xd5bQG5LtvBpg41dFz/csOxX8MeRHxShSXxq3SXrAO0JrhFzAXuMEtv2Z3VRoYAG
    Fu1gHoRo4jrGaDHZBeJILn4LvGic0O9m3MgDBzJXRMsDEq2jPtqOoD4hPNvUfJjAR+6Vna
    Xyc+JorQ+tbwJSuI0jOyrQIqPwlIrgGUYYAqglho1z7SxfnbuxU87J5VxYoA
X-ME-Proxy: <xmx:Fhwoauf-Xj9brVa8LpvuNhowNeA2Ze6qlj5dkGTm3izj0-IKXqGdhQ>
    <xmx:FhwoahAgJCIHYsSMAh7F0fFQBxZys-rAfVncDG9aspIT36IcRTi0Jg>
    <xmx:Fhwoag24wQo1Q7pJbzj3X0k-iyUw0AUPpNlbN14Zua02WR5dMHuMfg>
    <xmx:FhwoahMQAi3PIp8vKIXt1iVodTrlmC7OxMVWFOVwpgbiRBSIviAPEA>
    <xmx:FxwoarhFvEw0HOiV3AxHm1m4rmtmlHBeJhvsoIPdLPlb-oT_7oW8JnQd>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 09:58:46 -0400 (EDT)
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
Subject: [PATCH v2 3/3] arm64: escalate smp_send_stop() to an SDEI NMI as a last resort
Date: Tue,  9 Jun 2026 14:58:35 +0100
Message-ID: <a7ed093b78e6966c049bacc7644a8a00a9a52720.1781013134.git.kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1781013134.git.kas@kernel.org>
References: <cover.1780496779.git.kas@kernel.org> <cover.1781013134.git.kas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260609_065848_836434_00A6C8A3 
X-CRM114-Status: GOOD (  24.45  )
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

Add a third rung to smp_send_stop()'s escalation: signal SDEI event 0
at whatever is still online after the IPI (and pseudo-NMI IPI, if
enabled) rungs. The handler routes like the IPI handlers do --
crash_stop distinguishes a kdump crash stop (crash_save_cpu() on the
wedged context) from a plain stop -- and the CPU acks by marking
itself offline, which the caller already polls.

arm64_nmi_cpu_stop() lives in smp.c rather than the SDEI provider
because it needs the crash_stop discriminator and shares its shape with
ipi_cpu_crash_stop(); it is exported only so the provider's event-0
handler, which owns the trigger, can route into it.

Two differences against an IPI-stopped CPU: the SDEI event is never
completed, since completing it would resume the wedged context, so EL3
retains the event's dispatch slot until reset; and the CPU parks
instead of trying PSCI CPU_OFF, which must not be called from inside
an unfinished SDEI event.

Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 arch/arm64/include/asm/nmi.h    | 14 +++++++
 arch/arm64/kernel/smp.c         | 53 ++++++++++++++++++++++++
 drivers/firmware/Kconfig        |  2 +
 drivers/firmware/arm_sdei_nmi.c | 71 +++++++++++++++++++++++++++++++++
 4 files changed, 140 insertions(+)

diff --git a/arch/arm64/include/asm/nmi.h b/arch/arm64/include/asm/nmi.h
index 9366be419d18..2a9e6065f7af 100644
--- a/arch/arm64/include/asm/nmi.h
+++ b/arch/arm64/include/asm/nmi.h
@@ -4,21 +4,35 @@
 
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
+ * arm64_nmi_cpu_stop() is the reverse direction: the arch entry point
+ * (arch/arm64/kernel/smp.c) that the provider's NMI handler routes a
+ * stop request into.
  */
 #ifdef CONFIG_ARM_SDEI_NMI
 bool sdei_nmi_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu);
+bool sdei_nmi_stop_cpus(const cpumask_t *mask);
+
+void __noreturn arm64_nmi_cpu_stop(struct pt_regs *regs);
 #else
 static inline bool sdei_nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
 						      int exclude_cpu)
 {
 	return false;
 }
+
+static inline bool sdei_nmi_stop_cpus(const cpumask_t *mask)
+{
+	return false;
+}
 #endif
 
 #endif /* __ASM_NMI_H */
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index a670434a8cae..1af7fdae48db 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -33,6 +33,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/kexec.h>
 #include <linux/kgdb.h>
+#include <linux/kprobes.h>
 #include <linux/kvm_host.h>
 #include <linux/nmi.h>
 
@@ -910,6 +911,35 @@ static void __noreturn ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs
 #endif
 }
 
+#ifdef CONFIG_ARM_SDEI_NMI
+/*
+ * Stop entry for the SDEI cross-CPU NMI service: its event-0 handler
+ * lands here when this CPU was asked to stop. The bookkeeping mirrors
+ * the IPI_CPU_STOP{,_NMI} handling; the park happens inside the SDEI
+ * event, which is never completed -- completing it would have firmware
+ * resume the interrupted (typically wedged) context. No PSCI CPU_OFF
+ * either: powering off a PE that EL3 still considers mid-event invites
+ * firmware trouble.
+ */
+void __noreturn arm64_nmi_cpu_stop(struct pt_regs *regs)
+{
+	unsigned int cpu = smp_processor_id();
+
+	local_daif_mask();
+
+	if (IS_ENABLED(CONFIG_KEXEC_CORE) && crash_stop)
+		crash_save_cpu(regs, cpu);
+
+	/* the ack the stop requester polls for */
+	set_cpu_online(cpu, false);
+
+	sdei_mask_local_cpu();
+
+	cpu_park_loop();
+}
+NOKPROBE_SYMBOL(arm64_nmi_cpu_stop);
+#endif
+
 static void arm64_send_ipi(const cpumask_t *mask, unsigned int nr)
 {
 	unsigned int cpu;
@@ -1263,6 +1293,29 @@ void smp_send_stop(void)
 			udelay(1);
 	}
 
+	/*
+	 * If CPUs are *still* online, try the SDEI cross-CPU NMI. Firmware
+	 * delivers it regardless of the target's DAIF state, so it reaches
+	 * a CPU spinning with interrupts masked, which neither rung above
+	 * could (without pseudo-NMI there is no NMI rung at all). Allow
+	 * 100ms: a firmware round-trip per CPU, with headroom.
+	 */
+	if (num_other_online_cpus()) {
+		/* re-snapshot after the rungs above took CPUs offline */
+		smp_rmb();
+		cpumask_copy(&mask, cpu_online_mask);
+		cpumask_clear_cpu(smp_processor_id(), &mask);
+
+		if (sdei_nmi_stop_cpus(&mask)) {
+			pr_info("SMP: retry stop with SDEI NMI for CPUs %*pbl\n",
+				cpumask_pr_args(&mask));
+
+			timeout = USEC_PER_MSEC * 100;
+			while (num_other_online_cpus() && timeout--)
+				udelay(1);
+		}
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
index a82776e7b55a..b34ea42cfe5c 100644
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
@@ -59,8 +64,45 @@ static bool sdei_nmi_available;
 
 #define SDEI_NMI_EVENT			0
 
+/*
+ * Stop-request dispatch lives on the same SDEI event 0 as everything
+ * else. The requesting CPU sets each target's bit in sdei_nmi_stop_mask
+ * before signalling event 0; the target's handler test-and-clears its
+ * bit and hands the CPU to arm64_nmi_cpu_stop(), which saves crash
+ * state when the stop is a kdump crash-stop, marks the CPU offline
+ * (which is what the requester polls for) and parks it.
+ *
+ * This mirrors the cpumask the framework's nmi_cpu_backtrace() consults
+ * just below, and a shared mask rather than a separate SDEI event avoids
+ * extra registrations from firmware.
+ */
+static cpumask_t sdei_nmi_stop_mask;
+
 static int sdei_nmi_handler(u32 event, struct pt_regs *regs, void *arg)
 {
+	int cpu = smp_processor_id();
+
+	if (cpumask_test_and_clear_cpu(cpu, &sdei_nmi_stop_mask)) {
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
+		arm64_nmi_cpu_stop(regs);
+		/* unreachable */
+	}
+
 	/*
 	 * nmi_cpu_backtrace() no-ops unless this CPU's bit is set in the
 	 * global backtrace mask (driven by nmi_trigger_cpumask_backtrace()),
@@ -115,6 +157,35 @@ bool sdei_nmi_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
 	return true;
 }
 
+/*
+ * Last rung of the stop escalation in smp_send_stop() (see
+ * arch/arm64/kernel/smp.c). The caller runs the regular stop IPI (and
+ * the pseudo-NMI stop IPI, where available) first; @mask holds whatever
+ * stayed online through those -- typically CPUs wedged with interrupts
+ * masked, unreachable by an IPI. Set each target's stop-request flag and
+ * signal event 0 at it; a target acks by marking itself offline, which
+ * the caller polls for.
+ *
+ * Returns false when SDEI isn't active, so the caller can skip the wait.
+ */
+bool sdei_nmi_stop_cpus(const cpumask_t *mask)
+{
+	unsigned int cpu;
+
+	if (!sdei_nmi_available)
+		return false;
+
+	cpumask_or(&sdei_nmi_stop_mask, &sdei_nmi_stop_mask, mask);
+
+	/* Publish the mask before the SMCs read it on the target side. */
+	smp_wmb();
+
+	for_each_cpu(cpu, mask)
+		sdei_nmi_fire(cpu);
+
+	return true;
+}
+
 /*
  * device_initcall (after arch_initcall(sdei_init), so the SDEI subsystem
  * is up): probe the firmware, register the event, and turn on the
-- 
2.54.0


