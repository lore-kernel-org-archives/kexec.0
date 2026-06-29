Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A861C44500
	for <kexec@archiver.kernel.org>; Mon, 29 Jun 2026 15:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D9vWrOwyrFFvwyka/mR4Hi35HfDY4GEBo/Z52H2B2f0=; b=BQ1MiR5cLE4I4HgZ4EcnrcJJPq
	5DLGaH269LZRVlfPtoCMy3ht9NR3dSDJjJws//E3OLsaJym+wmpsx93wP+NiEetD44JigkOOXlDOL
	Ng5fv0qfVNDov8F1lSHCUZZwosNFSd8EAnqJ+wOYLI/r7BPGceMPqkxmmiit+d/DQOSLlZpUE/B1J
	B7TzDdXEPPBghDR1v4Ap28CLDDEKnB/w/pNMfOU5mQPNcTDlP4ihFNrx6GaRWM1Skt6/lTJfQrSMA
	hYkCLbkphWr5A39DPN+oddDtMPfeEfcjQjPBeIXHISzl49rkE3V9O37M6SJi5pQAALoD4hv8qiu2F
	EZj5OdCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weDa9-0000000F14E-1vAQ;
	Mon, 29 Jun 2026 15:07:33 +0000
Received: from fhigh-a8-smtp.messagingengine.com ([103.168.172.159])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weDa5-0000000F10k-3TxI;
	Mon, 29 Jun 2026 15:07:31 +0000
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0A5B514000DE;
	Mon, 29 Jun 2026 11:07:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 29 Jun 2026 11:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1782745649; x=1782832049; bh=D9vWrOwyrFFvwyka/mR4Hi35HfDY4GEB
	o/Z52H2B2f0=; b=wdkZzXYhM9xF3NVoN5VamSW1OYhvlLamLafxqkQKXXbSZ5WT
	9+085Tlwk72HlW/kDI5zVOlWjVJtw5sTZ09bRMXWG6x7W2ZKRtMtBY3arD9K1cgX
	ezgnm4PY7PjnfpIUFmlGtArXH2BW61+avixCkXDmTz3KmPRvUJUmlzCkJdEJ2Nqx
	VX8yB8trSs6J2Dec0/ENaEK70ea3/0pfYphmYW4Nel9XYIF74lpEtNcDSiKhuNWf
	1ZIOnuiJ1fFinRr5DSN0K9qUpcK1EdK+agp4MyiZheG2N6kaSALH8GQaQmIS3cwE
	Oe9kFJ+SH9GO5umjrVLcV3YN3fFvtMhtwQSS/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782745649; x=
	1782832049; bh=D9vWrOwyrFFvwyka/mR4Hi35HfDY4GEBo/Z52H2B2f0=; b=P
	rwLVcpF8HFvNa0lr5HchmOWjg9nMgd8wLA1eyDZRoNTxi3hyrtKahPsE7PZdxQk+
	zrZ7DyA+J1QXJfgxHotPEvZoX+LZjuQRpEdt+0B1iZMDvpXYjGOvAzGCt4OJY03g
	gaXArCdDf8MPWv52FBdbvOPo74Ld1NrkCWAxb/It3/e+td8MneL86ktMhI6edMBb
	7dalOGVZXhPM0Gn/s0S7i6LYkjtDt0qWCP5n/FRgZWRnb6VECwbXA3N28oqSRnwM
	eL/VJA3wdYcgBLvnLZvrjgLD7TaIjegxsFzPmBqAZhQnXt5ahalfgvorUHXPYyVy
	yCdai1wdscHSyTmCW546w==
X-ME-Sender: <xms:MIpCamBW5ONUfJmNA0_c414GEUwk9gp2gamj3BQQMO_pRpdIImzAcg>
    <xme:MIpCanmdrs6hBJ5MQfYeB5_TGnXOJQixGxHddntDCZAxkeciHUXNAD3byg_wuge0x
    aErjKb8vdtuvgJxpAZ2SKQ-_cCg643eLeclUNXhZaJXlWbpoVAFVyXf>
X-ME-Received: <xmr:MIpCahTkKQVGbR1mGRaMLzJx5A-G22u4Te1ecWETyqYLG-dJ0Kc-lLGxGQCuAA>
X-ME-Proxy-Cause: dmFkZTFF+jFibih6sYjCtDN29pN8hG7vyXduvq7D7INahhXTuqHrMfZmGUjw23i7buKHQ/
    kag6o6kJbgtJ5K4cESZouj/B2IYhij6/5AVUOGV+oq/avmnQ4nqXCSjwQfgMRsG/ToXMio
    mPXvFDC8qoqEhQAJB3PIQGpBXpCxX9HdKCUVfzpEZmFKfqTNNb0onLoOay49uJL57C2w/d
    7mszIUhnfMOnB1RnV/T8sQTz9J86gK2CkjSgPcEuy37O39r/49EEo28gxF0vB0zk79Qc5X
    YpxTmZk7XGu1Ulr/JZolHiRcm4oCL2pOjX/G1YUKb/Ovn+SXhXOclxy9Axs8svxUQi6Wrl
    xxzjBwWdOjLU19mbjiYK6dBmWpV4Mqnj6A4hmSghw3NP5PyF1cBSvMY0ERtDtNeiL1DVHQ
    zAS3+2Z9JuURcuTww95gkkOxunbSRbDztErxB14ESD6tfAgxg3MiLAYR0CHqYNnjbdZnpN
    MXXVWlmlYwtYupVj9wiaHd/CCyVkjcfGjODwVePx5DPLf1ORv0FMw2ZzSnRCiqZxDRRW+B
    N5Z3uIX3o0knIPuoTnmiWmzFycdNtZsqWGN8ARmc0wrSwRopaJ+X/eiS+0SfQbv+S+/qnH
    ZtsVHuC0c36AazVLqZ5H+VCyeZZC+kkCayAYrSC8yPiflhQJkBFAbYRVEwWQ
X-ME-Proxy: <xmx:MIpCarLIPjqbYUxLW_zU5nt9m7gWFShNQYr5F5tmazICohvRByq4Qg>
    <xmx:MIpCan9t3ROqX0BFtPX49rMWEiG9apxvUbaWYfxJ46VAwi3igJJFbw>
    <xmx:MIpCalBqjRYpHFG3JwBG-1ch1U3w2VDFhZJXVBwFqmfm_CBoD9g_AA>
    <xmx:MIpCapooqaROGn-rI6ZQRg1vCPpfMwBZEtygfRoED0Q3pVeNNu3G7A>
    <xmx:MYpCakMklNsS4TZqgr-wA9IILh4Gf1W3d5-yPqfKSxH4F_XWR-4BRYYb>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 11:07:28 -0400 (EDT)
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
Subject: [PATCH v5 4/4] arm64: escalate smp_send_stop() to an SDEI NMI as a last resort
Date: Mon, 29 Jun 2026 16:07:18 +0100
Message-ID: <3032112bb2ab2d5149f2d38b97f85caf3a8bb757.1782744912.git.kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1782744912.git.kas@kernel.org>
References: <cover.1782744912.git.kas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260629_080730_019022_6B5ADC7F 
X-CRM114-Status: GOOD (  28.49  )
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
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 arch/arm64/include/asm/nmi.h    |  24 +++++++
 arch/arm64/kernel/smp.c         | 113 +++++++++++++++++++++-----------
 drivers/firmware/Kconfig        |   2 +
 drivers/firmware/arm_sdei_nmi.c |  87 ++++++++++++++++++++++++
 4 files changed, 188 insertions(+), 38 deletions(-)

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
index dd47584d3b57..b5f502bd2da3 100644
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
index 4047fcda0bc3..038eb79e28ac 100644
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
+	 * No smp_rmb() pairing sdei_nmi_stop_cpus()'s dsb(ishst): the flag is
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
@@ -122,6 +176,39 @@ bool sdei_nmi_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
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
+	 * Publish the flag before signalling. The signal goes out via an SMC
+	 * to firmware, not a memory store, so smp_wmb() ordering is not
+	 * enough: use dsb(ishst) to make the store globally visible before the
+	 * SMC executes, as gic_ipi_send_mask() does for its SGI. The SDEI spec
+	 * does not require the dispatch to order the caller's prior stores.
+	 */
+	dsb(ishst);
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


