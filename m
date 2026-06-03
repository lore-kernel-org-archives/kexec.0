Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD47CD6E57
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 14:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XCV5K5AE1D/xtX/ICyFniLi7OwpOIgg9Vn7KdXSOWLQ=; b=QoT+QpLjLtEoJrFq2gqo6t9igN
	mg7PqSBOb9bSM8ZHFYK33D+Sy7TJAhxb9sSBHOMm0cSQ5eRbDMyBcbGCKHO3dIyCzUORGUjioSO44
	cCSfxuRN2teU4Fn5REpMzw63RdXfvtu6D9rScbrzYkOXrQe0e8AnUP625Zy6GvR/bK63XzqOWDf8W
	NAzQPonk0SeHTQsCOWBezgbNUAE28brwQEop2g4GEkv9Ej+N732uoSSElAaklslfZfkCCVrQlG+aQ
	G4uDq4c+dGF7PIO5+Z14Pn0Y0/396rUVINtZTGOqvDPtOPlMI5CPYjY4Vb+CdPlNOwqLLPLo3OByv
	HJenPr7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUmiA-0000000FGOY-2cRW;
	Wed, 03 Jun 2026 14:36:50 +0000
Received: from fhigh-a3-smtp.messagingengine.com ([103.168.172.154])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUmi6-0000000FGLH-2nLy;
	Wed, 03 Jun 2026 14:36:48 +0000
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E529314000B3;
	Wed,  3 Jun 2026 10:36:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 03 Jun 2026 10:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1780497405; x=
	1780583805; bh=XCV5K5AE1D/xtX/ICyFniLi7OwpOIgg9Vn7KdXSOWLQ=; b=3
	0iMiOLBOgUB++6hSV06glqkCWV6vwaKnvjCeG7dFV7F1HLjb1su1YFQUmWRbq7oi
	vIoEGiQw4BYQeZH037dpK6JSVEoflkeg7wcNAFL1MeP9qXrnGgg2/sFfWJnaOdRP
	OTdbZzzQK5mVRM7EufYeTfCDygX68WroRcGpgaMOlgKOTMBiumfZEQRDzpvZHTVY
	WUVXod5L+6WeLZY9mQ6rtKcQJBz4pjUolM6dxX2wtfP0uvuJMMrl8kyIz+AWVg4v
	3+6Zc3GuYWfEkUBx8A1y/mJGsYkk8XcM2fz/BNxnmppMe6C+uAq3F3EKmeZ0cwQB
	+H0sra9hoE5PqqPcrsf2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780497405; x=1780583805; bh=X
	CV5K5AE1D/xtX/ICyFniLi7OwpOIgg9Vn7KdXSOWLQ=; b=L9UDcVtkFgv95JBUc
	WtVLA7H+LHkvG5ZTuhWdWhWj0z7y1s3nxNuW9xnnFcQtBYNbvlvbFjIvxRnsQiGv
	wy2O6MDQu3v11buW7NDOcwOli1lwdQSBiEUZcbl/hQkLcQwOtjswKS6/bvBVke+y
	3oGX+c4/deYvqGEx7xBmTpwdGhtXpdCOTWhUsInZvN1mJZhSfYKMJuZN9AC0PSjs
	6AvklhCGz63+5upqtCqSaS5aV+n9Mkw4TnynRj8sh/gDOGNAQq3XfWSFA3cO0toH
	AlNLLnqaKLNKbiBLuHUp0KGQ6WJakq1vPzA9l6AFMrstvS9gVSW4SOFRR7Op82el
	mhADg==
X-ME-Sender: <xms:_TsgalPSpXKxnNDUyzpyo6L-dD0AI3VY_potkKIm2Z4F99WLyVjb8Q>
    <xme:_TsgavC1cGqNInNtXZzvbHRx_0eQjDKN9wxHTBx6kmh51o7bpRj_BxL6csenJL3l0
    eTt-DeVjZ4mnLuNX799e1Fbn1rRFC0hsqDJOUYQEw_HIhnfg64j7FA8>
X-ME-Received: <xmr:_Tsgar84fXgH2tCSahELFTM7ETLXu8wDJ5lENTK_UEKCs-Y9R1qTVEOlAzkhaQ>
X-ME-Proxy-Cause: dmFkZTFVMaZNPrRvSfF6lMDYeRZ1GT+YvZmW7/XK/DI4veA79wFWZ3OTazeQfPnYwN97CC
    Cs7iG9lFDm4VwxgpNn+szFkMQ6p+sawghQpLMos458rKa6kqCjeLITn+xOFJRuLH44jdjC
    bYnKt60OIxUI0HzEiKQ/d/999Ki3O4KAWblGhTDaHqAwTlFtGQQ5XMSyzboPUJHYsMRxyM
    j/zwJItMy9TSzKSj2Y695qlb0/SVGvKOj9QbiUnxexRfYyaiNrFZ52yLjpFN+pCrTPE1BV
    zfeSjTVtTl0AdNVaDzT7MlIgVuikoL9aGaZH0Ygsy1IGcYaK7xBN9rEeaPK3HRSnq6UCV0
    bi4yvq68tSBz1+F3a39DPkxR6qH3Jy6G4T6+PiuDBS1jd+/Q5rEde1P7KXzLnPOz5PZhL1
    cC2CAd1fP+itU6/Zjh0Dxyu6AoOy2Hs3jx8vI4XoMmL+92mVS3Yef9XzLp/j/rVlW3uS4X
    zZPVXa8lteoKCiLxySJ9WiVaPHnGK7u0UAKQZfbhaKq90y7iTT52Iwvu8cPLiKbXsnC0db
    lnqLVSa5gzW0Tt4HZ35BD9llWl98oqW+HAKZqNZrbF2YwgpuYJvRP4TJPjnDlaIfYBMc9x
    /VyHbyYcdlvBewuqsB0ph70JtzJkmq5rrklNxZ6bopQGpCsUP63N5qkCwgcQ
X-ME-Proxy: <xmx:_TsgaoF3b4pI_9mYhHmb88nCmNyPLGQQIf85M42XbjBxu7LZzROoBA>
    <xmx:_TsgaqLVeZ5T75irBDbk2N0UUzlOaZkTsF6Zt3BLn-zJzoylzrE1kw>
    <xmx:_Tsgajcz-fo4O2K366aC-4WQosb6ZLDO5GqYhldXhPOc3NXFD_dDww>
    <xmx:_TsgavU8AUSM2MqOKJZZ5TDbUwEKfKO3sQPvy0FCC8nNY4h7jZuxXg>
    <xmx:_TsgatJQnCOiPRBzfXo0cTIRaVwoqSnyU7GN_ImsRUm2ZhAwVn42QeTe>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 10:36:45 -0400 (EDT)
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
Subject: [PATCH 3/4] arm64: wire SDEI NMI into the hardlockup watchdog
Date: Wed,  3 Jun 2026 15:36:34 +0100
Message-ID: <6172eafcb9de6e626c0f1c36426d67e1e562ed32.1780496779.git.kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1780496779.git.kas@kernel.org>
References: <cover.1780496779.git.kas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_073646_909434_2BCE0455 
X-CRM114-Status: GOOD (  28.25  )
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

Select HAVE_HARDLOCKUP_DETECTOR_ARCH so the framework takes its backend
from this driver. A per-CPU hrtimer checks its buddy's heartbeat and
signals event 0 at a stalled CPU, which runs watchdog_hardlockup_check()
NMI-like.

The source is chosen at boot: SDEI if firmware provides it, otherwise a
perf-NMI counter (pseudo-NMI) fallback -- one image covers both.

Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 arch/arm64/Kconfig          |   1 +
 drivers/firmware/Kconfig    |   3 +
 drivers/firmware/sdei_nmi.c | 247 +++++++++++++++++++++++++++++++++++-
 3 files changed, 248 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fe60738e5943..ebefe1e20806 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -205,6 +205,7 @@ config ARM64
 	select HAVE_FUNCTION_GRAPH_FREGS
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_GCC_PLUGINS
+	select HAVE_HARDLOCKUP_DETECTOR_ARCH if ARM_SDEI_NMI
 	select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS && \
 		HW_PERF_EVENTS && HAVE_PERF_EVENTS_NMI
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 6501087ff90d..552eff7b9bc3 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -39,6 +39,7 @@ config ARM_SDE_INTERFACE
 config ARM_SDEI_NMI
 	bool "SDEI-based cross-CPU NMI service (arm64)"
 	depends on ARM64 && ARM_SDE_INTERFACE
+	select HARDLOCKUP_DETECTOR_COUNTS_HRTIMER if HARDLOCKUP_DETECTOR
 	help
 	  Provides SDEI-based cross-CPU NMI delivery for hooks that need
 	  to reach interrupt-masked CPUs on silicon that lacks FEAT_NMI:
@@ -46,6 +47,8 @@ config ARM_SDEI_NMI
 	    - arch_trigger_cpumask_backtrace()  (sysrq-l, RCU stalls,
 	      hardlockup_all_cpu_backtrace, soft-lockup secondary dumps,
 	      hung-task auxiliary dumps)
+	    - the hardlockup watchdog backend, when HARDLOCKUP_DETECTOR is
+	      also enabled
 
 	  The driver registers a handler for the SDEI software-signalled
 	  event (event 0) and reaches a target CPU by signalling it with
diff --git a/drivers/firmware/sdei_nmi.c b/drivers/firmware/sdei_nmi.c
index e5c3f28b3991..51e220d4083d 100644
--- a/drivers/firmware/sdei_nmi.c
+++ b/drivers/firmware/sdei_nmi.c
@@ -29,6 +29,14 @@
  *     hardlockup_all_cpu_backtrace, soft-lockup/hung-task secondary
  *     dumps all reach interrupt-masked CPUs.
  *
+ *   - the hardlockup-detector backend (watchdog_hardlockup_enable/
+ *     disable/probe()), when CONFIG_HARDLOCKUP_DETECTOR is also on.
+ *     ARM_SDEI_NMI selects HAVE_HARDLOCKUP_DETECTOR_ARCH, so the
+ *     framework picks this backend. The detection source is chosen at
+ *     boot: SDEI when the firmware has it, otherwise a perf-PMU NMI
+ *     counter if one is available (pseudo-NMI enabled). One kernel image
+ *     thus serves SDEI and non-SDEI hosts.
+ *
  * Delivery uses the standard SDEI software-signalled event (event 0) and
  * SDEI_EVENT_SIGNAL. We register a handler for event 0, enable it, and
  * poke a target CPU with sdei_event_signal(0, mpidr): firmware makes
@@ -42,12 +50,18 @@
 #define pr_fmt(fmt) "sdei_nmi: " fmt
 
 #include <linux/arm_sdei.h>
+#include <linux/cpufreq.h>
 #include <linux/cpumask.h>
+#include <linux/hrtimer.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/nmi.h>
+#include <linux/percpu-defs.h>
+#include <linux/perf_event.h>
+#include <linux/perf/arm_pmu.h>
 #include <linux/printk.h>
 #include <linux/ptrace.h>
+#include <linux/sched/clock.h>
 #include <linux/smp.h>
 #include <linux/types.h>
 
@@ -61,11 +75,17 @@ static bool sdei_nmi_available;
 static int sdei_nmi_handler(u32 event, struct pt_regs *regs, void *arg)
 {
 	/*
-	 * nmi_cpu_backtrace() no-ops unless this CPU's bit is set in the
-	 * global backtrace mask (driven by nmi_trigger_cpumask_backtrace()),
-	 * so a fire that reaches a CPU not being backtraced is harmless.
+	 * Both consumers no-op on a CPU that wasn't actually requested:
+	 * nmi_cpu_backtrace() unless this CPU's bit is set in the global
+	 * backtrace mask, and watchdog_hardlockup_check() unless this CPU's
+	 * hrtimer_interrupts counter has stalled. The latter is only
+	 * declared when the watchdog backend is built in (COUNTS_HRTIMER,
+	 * pulled by ARM_SDEI_NMI when HARDLOCKUP_DETECTOR is enabled).
 	 */
 	nmi_cpu_backtrace(regs);
+#ifdef CONFIG_HARDLOCKUP_DETECTOR_COUNTS_HRTIMER
+	watchdog_hardlockup_check(smp_processor_id(), regs);
+#endif
 	return SDEI_EV_HANDLED;
 }
 
@@ -113,6 +133,220 @@ bool sdei_nmi_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
 	return true;
 }
 
+#ifdef CONFIG_HARDLOCKUP_DETECTOR_COUNTS_HRTIMER
+
+/*
+ * SDEI watchdog source: a per-CPU hrtimer pets its own heartbeat and
+ * checks its buddy's; on a stall it signals event 0 at the buddy,
+ * whose SDEI handler then runs watchdog_hardlockup_check().
+ */
+#define SDEI_NMI_WATCHDOG_TICK_MS	1000
+
+static cpumask_t __read_mostly sdei_nmi_watchdog_cpus;
+static DEFINE_PER_CPU(struct hrtimer, sdei_nmi_watchdog_hrtimer);
+static DEFINE_PER_CPU(u64, sdei_nmi_watchdog_heartbeat_ns);
+
+static unsigned int sdei_nmi_watchdog_next_cpu(unsigned int cpu)
+{
+	unsigned int next = cpumask_next_wrap(cpu, &sdei_nmi_watchdog_cpus);
+
+	if (next == cpu)
+		return nr_cpu_ids;
+	return next;
+}
+
+static enum hrtimer_restart sdei_nmi_watchdog_hrtimer_fn(struct hrtimer *t)
+{
+	unsigned int this_cpu = smp_processor_id();
+	unsigned int buddy;
+	u64 now = local_clock();
+	u64 buddy_hb, thresh_ns;
+
+	this_cpu_write(sdei_nmi_watchdog_heartbeat_ns, now);
+
+	buddy = sdei_nmi_watchdog_next_cpu(this_cpu);
+	if (buddy >= nr_cpu_ids)
+		goto restart;
+
+	/* pair with smp_wmb() in start_watchdog/stop_watchdog */
+	smp_rmb();
+
+	buddy_hb = per_cpu(sdei_nmi_watchdog_heartbeat_ns, buddy);
+	thresh_ns = (u64)watchdog_thresh * NSEC_PER_SEC;
+
+	if (now > buddy_hb + thresh_ns) {
+		/*
+		 * Fire every tick while the buddy looks stale: the framework's
+		 * watchdog_hardlockup_check() needs two consecutive calls
+		 * before it'll declare a lockup (first call updates
+		 * hrtimer_interrupts_saved; second confirms the counter
+		 * hasn't moved). One-shot firing wedges the detection at
+		 * step 1. The cost of an extra SMC per second on a truly
+		 * wedged CPU is negligible; the alternative is silent
+		 * non-detection.
+		 */
+		pr_warn_ratelimited("watchdog: CPU %u no heartbeat for %llu ms (thresh %us), firing NMI from CPU %u\n",
+				    buddy,
+				    (now - buddy_hb) / NSEC_PER_MSEC,
+				    watchdog_thresh, this_cpu);
+		sdei_nmi_fire(buddy);
+	}
+
+restart:
+	hrtimer_forward_now(t, ms_to_ktime(SDEI_NMI_WATCHDOG_TICK_MS));
+	return HRTIMER_RESTART;
+}
+
+static void sdei_nmi_watchdog_enable(unsigned int cpu)
+{
+	struct hrtimer *t = this_cpu_ptr(&sdei_nmi_watchdog_hrtimer);
+
+	if (cpumask_test_cpu(cpu, &sdei_nmi_watchdog_cpus))
+		return;
+
+	this_cpu_write(sdei_nmi_watchdog_heartbeat_ns, local_clock());
+
+	hrtimer_setup(t, sdei_nmi_watchdog_hrtimer_fn, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL_PINNED);
+
+	/* pair with smp_rmb() in the hrtimer callback */
+	smp_wmb();
+	cpumask_set_cpu(cpu, &sdei_nmi_watchdog_cpus);
+
+	hrtimer_start(t, ms_to_ktime(SDEI_NMI_WATCHDOG_TICK_MS),
+		      HRTIMER_MODE_REL_PINNED);
+}
+
+static void sdei_nmi_watchdog_disable(unsigned int cpu)
+{
+	if (!cpumask_test_cpu(cpu, &sdei_nmi_watchdog_cpus))
+		return;
+
+	cpumask_clear_cpu(cpu, &sdei_nmi_watchdog_cpus);
+	/* pair with smp_rmb() in the hrtimer callback */
+	smp_wmb();
+
+	hrtimer_cancel(this_cpu_ptr(&sdei_nmi_watchdog_hrtimer));
+}
+
+/*
+ * Perf-NMI fallback source, used when SDEI is absent but the PMU IRQ is
+ * a (pseudo-)NMI. A per-CPU cycle counter overflows into the same
+ * watchdog_hardlockup_check(). This is the stock arm64 perf hardlockup
+ * detector, minimal-copied here because the framework's
+ * HARDLOCKUP_DETECTOR_PERF is compile-excluded once we select
+ * HAVE_HARDLOCKUP_DETECTOR_ARCH (it would otherwise provide a second
+ * definition of these same hooks).
+ */
+static struct perf_event_attr perf_wd_attr = {
+	.type		= PERF_TYPE_HARDWARE,
+	.config		= PERF_COUNT_HW_CPU_CYCLES,
+	.size		= sizeof(struct perf_event_attr),
+	.pinned		= 1,
+	.disabled	= 1,
+};
+
+static DEFINE_PER_CPU(struct perf_event *, perf_wd_event);
+
+static u64 perf_wd_period(int cpu)
+{
+	/* 5 GHz safe max when cpufreq is unavailable, as in watchdog_hld.c. */
+	u64 hz = cpufreq_get_hw_max_freq(cpu) * 1000UL;
+
+	return (hz ? hz : 5000000000UL) * watchdog_thresh;
+}
+
+static void perf_wd_overflow(struct perf_event *event,
+			     struct perf_sample_data *data,
+			     struct pt_regs *regs)
+{
+	watchdog_hardlockup_check(smp_processor_id(), regs);
+}
+
+static void perf_wd_enable(unsigned int cpu)
+{
+	struct perf_event *evt;
+
+	if (this_cpu_read(perf_wd_event))
+		return;
+
+	perf_wd_attr.sample_period = perf_wd_period(cpu);
+	evt = perf_event_create_kernel_counter(&perf_wd_attr, cpu, NULL,
+					       perf_wd_overflow, NULL);
+	if (IS_ERR(evt)) {
+		pr_warn_once("perf event create on CPU %u failed: %ld\n",
+			     cpu, PTR_ERR(evt));
+		return;
+	}
+
+	this_cpu_write(perf_wd_event, evt);
+	perf_event_enable(evt);
+}
+
+static void perf_wd_disable(unsigned int cpu)
+{
+	struct perf_event *evt = this_cpu_read(perf_wd_event);
+
+	if (!evt)
+		return;
+
+	perf_event_disable(evt);
+	perf_event_release_kernel(evt);
+	this_cpu_write(perf_wd_event, NULL);
+}
+
+/* Set by the late_initcall below once the perf fallback is chosen. */
+static bool perf_wd_active;
+
+void watchdog_hardlockup_enable(unsigned int cpu)
+{
+	WARN_ON_ONCE(cpu != smp_processor_id());
+
+	if (sdei_nmi_available)
+		sdei_nmi_watchdog_enable(cpu);
+	else if (perf_wd_active)
+		perf_wd_enable(cpu);
+}
+
+void watchdog_hardlockup_disable(unsigned int cpu)
+{
+	WARN_ON_ONCE(cpu != smp_processor_id());
+
+	if (sdei_nmi_available)
+		sdei_nmi_watchdog_disable(cpu);
+	else if (perf_wd_active)
+		perf_wd_disable(cpu);
+}
+
+int __init watchdog_hardlockup_probe(void)
+{
+	return (sdei_nmi_available || perf_wd_active) ? 0 : -ENODEV;
+}
+
+/*
+ * Phase 2 of init, at late_initcall so it runs after both our own
+ * device_initcall (SDEI decision) and armv8_pmuv3's (which is what makes
+ * arm_pmu_irq_is_nmi() read true). If SDEI didn't claim the watchdog and
+ * the PMU IRQ is a (pseudo-)NMI, take the perf fallback. Deciding here,
+ * after both device_initcalls, keeps the choice deterministic -- no race
+ * over which initcall ran first, and no flip from perf to SDEI.
+ */
+static int __init perf_wd_init(void)
+{
+	if (sdei_nmi_available)
+		return 0;	/* SDEI already owns the watchdog */
+
+	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && arm_pmu_irq_is_nmi()) {
+		perf_wd_active = true;
+		pr_info("no SDEI firmware; using perf-NMI watchdog fallback\n");
+		lockup_detector_retry_init();
+	}
+	return 0;
+}
+late_initcall(perf_wd_init);
+
+#endif /* CONFIG_HARDLOCKUP_DETECTOR_COUNTS_HRTIMER */
+
 /*
  * device_initcall (after arch_initcall(sdei_init), so the SDEI subsystem
  * is up): probe the firmware, register the event, and turn on the
@@ -142,6 +376,13 @@ static int __init sdei_nmi_init(void)
 	pr_info("using SDEI cross-CPU NMI (SDEI_EVENT_SIGNAL, event %u)\n",
 		SDEI_NMI_EVENT);
 
+	/*
+	 * lockup_detector_init() ran in early init and found no hardlockup
+	 * backend yet; re-probe now that SDEI owns the watchdog.
+	 */
+	if (IS_ENABLED(CONFIG_HARDLOCKUP_DETECTOR_COUNTS_HRTIMER))
+		lockup_detector_retry_init();
+
 	return 0;
 }
 device_initcall(sdei_nmi_init);
-- 
2.54.0


