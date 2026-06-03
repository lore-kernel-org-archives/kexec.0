Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75F8CD6E6C
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 14:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RG8jqXBdRfEKAkAHn5r6i1tcWHmdRvrx/Kzh7Lp2eIw=; b=ryHQwUdztvB6CgPYNKQqAMEujO
	Tj1ZjDLKlBfTzY7JwM2yE93rVu1PhWZHWBuUZ7cZrvAU6DkZ5rsODjKnaUh6XJzLdBpWRTf65H73N
	6ZBv350qxDGiVzqbKJ3OXGYUdZg3OsHDy+kw6q0KKb5/13LhZbxdEhyzjCmeH7HICZ4+AHXdlXckf
	LnkcWsTsfVlKNPa2PvRVOuTcN2sPYOtF3MLNuXQigsf0GosYcGNFE+jdU0PY2a3m/hNDpXpE1+pek
	A0jgoOU/6pz8pd+DAeKEdE+0mhy4orUEBHu9MFdton5xRuE3K/wURNXKWUMz+6cbPo+9Qv4NteA4X
	iqxzcUTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUmiC-0000000FGRk-4Awk;
	Wed, 03 Jun 2026 14:36:53 +0000
Received: from fhigh-a3-smtp.messagingengine.com ([103.168.172.154])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUmi8-0000000FGMe-35bl;
	Wed, 03 Jun 2026 14:36:51 +0000
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F17C0140012E;
	Wed,  3 Jun 2026 10:36:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 03 Jun 2026 10:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1780497407; x=1780583807; bh=RG8jqXBdRfEKAkAHn5r6i1tcWHmdRvrx
	/Kzh7Lp2eIw=; b=usCunmvSR8lMRWON2wB4lIpw7zbk8zEvTzpA/jQlijFUWwGd
	uf/6GzIuJ2phMJK9/EwBKwdYcP1AdQHXeY0EjxhE3betO4A4u6luOfvk9Zn5znXg
	WLmaH5qeyQtj4x5HE/s5YgpxdKvAa0LFl2l+fS2407MOZbBlH6uSFimRyfRa8rZ5
	GV+2revOTHvrHWMigdtcC2dJAACbBMljvUVxu6ZCOcHTrhrturwoaxAPI/IJFLfb
	o1px53fQO6xx7zP76S/xrNo9HEde65EcX22/fxZl8eFhDI3zOGP2GqyaCn43XbDH
	7hqd13v0alpV81r1+lU1bV9+Kzb3xdIfeUbxyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780497407; x=
	1780583807; bh=RG8jqXBdRfEKAkAHn5r6i1tcWHmdRvrx/Kzh7Lp2eIw=; b=B
	pXyWH0ELyKOCY3s8k5isd80yIooFDmOYru1hdXg6h4s05+SG0KJvinhBqMky4lG5
	px6oxh+sXW8Wfcro3IU3PCEzNF5GtT+NQRSOfzuZ1FjHhjwg5h5WacX9ACgmmCUH
	NfZVoXJR+V+0gW6WqZhzLwrXvubr4a0oRuH14VmlNEvWOsVyRMeiHm5c+/+7Qb5S
	uXRxmzBjOnYudsMYwRkeH5C8F3hTlgRDuvBSRm4vbvMNRUKjQH695dVxGFe12H3P
	ru9jZzAxZE9ivwkjemqyaqe53v8aX4ZIJxeviSbl4yM2QYc7bnMd5FNH/5yxCi5x
	GoCpFtDFLvpy9TXeIbUWw==
X-ME-Sender: <xms:_zsgaqaH2Rs12yKJNYpzz7r3fl6bY2nRcBPayXbxAWHkUzE4496JPA>
    <xme:_zsgakd84QwV3G1HodpL4QzvV1rP0sAt1X78ZfKYkb1ifMqKQyu-BI5OyzQ5Q7Am8
    EnHpMhQHJ7-Wi39vkjg5Ezb26XSkmEgBBaBfjlf3KJVWX2yHHks8zY>
X-ME-Received: <xmr:_zsgasrV5z56M9T-MKLk4f5-JIiP9lY3BrgwxvxmoRKp-7bs11SdQUPX7oX9JA>
X-ME-Proxy-Cause: dmFkZTGHB8EMWtr59MJZK1eNDuMpHMU/i/QNtWRl41L5ZiJmSN5sQ2Pi7u82zINHN90Hv7
    B1uNh09bZL9egg9fi5IHmMX7VQaCOEx92CjS/BMlMAJPcHI+T7ieJCU1O5ARkDEfpRMtwv
    SmcGGZLmWvkAiVM55xuKZy0iDBq5pzDdIeRIO1iZzDQi8eDHOQT4LT4/8QB4TYeGi2YTFo
    Z05QavvHvdcY3qYZk6Hn7LlfuD0m4BrUyknKQOHRmoytNrWNlWPh6OYm+1JYSWbvIt7GlG
    zOFvNOO4/0rHF7c1Hi8UuVkwQovwa8pr1FPSCyIt64QmipKP9Md0dZNKW0YvCKCVvTYvEg
    /YpqzJ3wB7KrTYIREOFPFRWuGK1kqRgYm0PCL1G/dTcur+uuC8eJZ0YpDM/EJNsel82phi
    SSU50nvmII33zUuLrHc5+ztYfxNUmfAckMQE0Opsq9ruRa3Pf+AuUfHcaIp3Aa2d77tieq
    GSrBGVhF+J58J3m8lknGomVaWgT0hhfPc9ANWlAQ45EBSQm46PivrpNjhHv4C8mi7Z/aU5
    ycRasPxoC+a3BNqYxHswxh2gcv6oba3qEKIH1L2ubUtM/5B/f9VNCqr7zZhU8AjPcMSJnR
    hcQFORf/VPP/olQjW4eLfzgfVueVRv/vZWTLZ/AM/S9TF22WaMvSJuNDdXDg
X-ME-Proxy: <xmx:_zsgajA3EB9QrxwXW-_TevHyFbXPbTOAzhzj3pGHk5Hg9gsYGx0bKA>
    <xmx:_zsgaiWtdsqMxdQXEEftGIEkv_3dB7lAxdaHx2Nyqi2jscrhI_nH2w>
    <xmx:_zsgav6nBCak7ikeiEGZkkbGq8dFxYE4GXNouQCfrMLuJVsn9-g6OQ>
    <xmx:_zsgarC_QBzKr7PreSY2uKxJOwHGTgXrD4z5RpnwKl4kcmN7fnzzNA>
    <xmx:_zsgajv9q2yfAapdg1nQtobxx8uAV6ZOZZT5SJ1XIXuzUmFbzD3KK4JE>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 10:36:47 -0400 (EDT)
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
Subject: [PATCH 4/4] arm64: route crash_smp_send_stop() last resort through SDEI
Date: Wed,  3 Jun 2026 15:36:35 +0100
Message-ID: <54cb99db3c981dc39eb3031aff5caeaadb09e8b9.1780496779.git.kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1780496779.git.kas@kernel.org>
References: <cover.1780496779.git.kas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_073649_954276_41BD3B9F 
X-CRM114-Status: GOOD (  29.87  )
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

Add SDEI as the final rung after the normal stop IPI (and the pseudo-NMI
IPI, if enabled): signal event 0 at the CPUs still online, whose handler
runs crash_save_cpu() on the wedged context and parks them. It only ever
touches CPUs the normal path couldn't reach.

SDEI is last because a CPU parked in the handler never completes the
event, so it is less recoverable -- a cost paid only when nothing else
worked.

Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 arch/arm64/include/asm/nmi.h |   6 ++
 arch/arm64/kernel/smp.c      |  24 ++++++
 drivers/firmware/Kconfig     |   1 +
 drivers/firmware/sdei_nmi.c  | 137 ++++++++++++++++++++++++++++++++++-
 4 files changed, 167 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/nmi.h b/arch/arm64/include/asm/nmi.h
index ccdb75692e9d..e3edfb24fc08 100644
--- a/arch/arm64/include/asm/nmi.h
+++ b/arch/arm64/include/asm/nmi.h
@@ -13,12 +13,18 @@
  */
 #ifdef CONFIG_ARM_SDEI_NMI
 bool sdei_nmi_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu);
+bool sdei_nmi_crash_smp_send_stop(void);
 #else
 static inline bool sdei_nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
 						      int exclude_cpu)
 {
 	return false;
 }
+
+static inline bool sdei_nmi_crash_smp_send_stop(void)
+{
+	return false;
+}
 #endif
 
 #endif /* __ASM_NMI_H */
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 656b8417af72..386ddd526b48 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -1288,8 +1288,32 @@ void crash_smp_send_stop(void)
 		return;
 	crash_stop = 1;
 
+	/*
+	 * Stop the normal way first: IPI_CPU_STOP escalating to a pseudo-NMI
+	 * IPI. Every CPU that responds saves its state via crash_save_cpu()
+	 * and parks in cpu_park_loop() with its online bit cleared -- the
+	 * standard kdump stop, identical to a kernel without SDEI. Crucially
+	 * those CPUs stay in a clean, potentially-reusable state.
+	 */
 	smp_send_stop();
 
+	/*
+	 * Whatever is still online didn't respond -- typically a CPU wedged
+	 * with interrupts masked. The plain IPI can't reach it, and a fleet
+	 * that declines the pseudo-NMI hot-path cost has no NMI IPI to
+	 * escalate to. Hit only the survivors with the SDEI cross-CPU NMI
+	 * (no-op if SDEI isn't active, or if everything already stopped):
+	 * firmware delivers out of EL3 regardless of PSTATE.DAIF, and the
+	 * handler captures crash_save_cpu() state from the wedged context
+	 * before parking the CPU.
+	 *
+	 * SDEI is deliberately last: an SDEI-stopped CPU never completes its
+	 * event (it parks inside the handler, so EL3 retains its dispatch
+	 * slot until reset), which is strictly less recoverable than a normal
+	 * stop. We pay that only for CPUs that left no other way to reach them.
+	 */
+	sdei_nmi_crash_smp_send_stop();
+
 	sdei_handler_abort();
 }
 
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 552eff7b9bc3..84aead609406 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -49,6 +49,7 @@ config ARM_SDEI_NMI
 	      hung-task auxiliary dumps)
 	    - the hardlockup watchdog backend, when HARDLOCKUP_DETECTOR is
 	      also enabled
+	    - crash_smp_send_stop()              (panic / kdump path)
 
 	  The driver registers a handler for the SDEI software-signalled
 	  event (event 0) and reaches a target CPU by signalling it with
diff --git a/drivers/firmware/sdei_nmi.c b/drivers/firmware/sdei_nmi.c
index 51e220d4083d..ad8fbb1c90a6 100644
--- a/drivers/firmware/sdei_nmi.c
+++ b/drivers/firmware/sdei_nmi.c
@@ -29,6 +29,11 @@
  *     hardlockup_all_cpu_backtrace, soft-lockup/hung-task secondary
  *     dumps all reach interrupt-masked CPUs.
  *
+ *   - sdei_nmi_crash_smp_send_stop() — override for arm64's
+ *     crash_smp_send_stop(); the panic/kdump last resort for CPUs that
+ *     didn't answer the normal stop IPI, capturing the wedged context
+ *     into the vmcore before parking the CPU.
+ *
  *   - the hardlockup-detector backend (watchdog_hardlockup_enable/
  *     disable/probe()), when CONFIG_HARDLOCKUP_DETECTOR is also on.
  *     ARM_SDEI_NMI selects HAVE_HARDLOCKUP_DETECTOR_ARCH, so the
@@ -50,11 +55,15 @@
 #define pr_fmt(fmt) "sdei_nmi: " fmt
 
 #include <linux/arm_sdei.h>
+#include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
+#include <linux/delay.h>
+#include <linux/err.h>
 #include <linux/hrtimer.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/kexec.h>
 #include <linux/nmi.h>
 #include <linux/percpu-defs.h>
 #include <linux/perf_event.h>
@@ -72,8 +81,66 @@ static bool sdei_nmi_available;
 
 #define SDEI_NMI_EVENT			0
 
+/*
+ * Crash-stop dispatch lives on the same SDEI event 0 as everything else.
+ * The requesting CPU sets sdei_nmi_crash_stop_requested for each target
+ * before signalling event 0; the target's handler clears it, saves crash
+ * state, parks, and sets sdei_nmi_crash_stop_acked so the requester knows
+ * the target is down.
+ *
+ * Using a per-CPU flag rather than a separate SDEI event avoids needing
+ * extra registrations from firmware. The SDEI_EVENT_SIGNAL SMC is itself
+ * a write barrier, so a WRITE_ONCE() before the signal is sufficient
+ * ordering against the handler's READ_ONCE() on the target.
+ */
+static DEFINE_PER_CPU(unsigned long, sdei_nmi_crash_stop_requested);
+static DEFINE_PER_CPU(unsigned long, sdei_nmi_crash_stop_acked);
+
 static int sdei_nmi_handler(u32 event, struct pt_regs *regs, void *arg)
 {
+	int cpu = smp_processor_id();
+
+	if (READ_ONCE(*this_cpu_ptr(&sdei_nmi_crash_stop_requested))) {
+		WRITE_ONCE(*this_cpu_ptr(&sdei_nmi_crash_stop_requested), 0);
+
+		/*
+		 * Capture the wedged context for kdump while pt_regs still
+		 * points at the interrupted PC. This is the main motivation
+		 * for using SDEI here: the plain IPI stop path can't reach an
+		 * interrupt-masked CPU (and the fleet declines pseudo-NMI to
+		 * keep the IRQ-mask hot path cheap), so crash_save_cpu() for
+		 * that CPU would otherwise record nothing useful.
+		 */
+		crash_save_cpu(regs, cpu);
+		set_cpu_online(cpu, false);
+
+		/* publish the crash state/offline before the requester sees the ack */
+		smp_wmb();
+		WRITE_ONCE(*this_cpu_ptr(&sdei_nmi_crash_stop_acked), 1);
+
+		/*
+		 * Park forever from within the SDEI handler. We deliberately
+		 * do NOT issue SDEI_EVENT_COMPLETE: the framework's return
+		 * path restores firmware's saved interrupted context, which
+		 * would land the CPU back wherever it was running (often
+		 * do_idle, which then notices cpu_is_offline=true and BUGs
+		 * at cpuhp_report_idle_dead). Returning the modified pt_regs
+		 * doesn't help -- arch/arm64/kernel/sdei.c::do_sdei_event
+		 * only honours a PC override via its IRQ-state heuristic
+		 * and otherwise hands EL3 its own saved-context slot back.
+		 *
+		 * Trade-off: EL3 firmware retains ~one saved-context slot
+		 * per parked CPU until the next hardware reset (~hundreds of
+		 * bytes per CPU). The CPU itself is parked in cpu_park_loop
+		 * exactly as if IPI_CPU_STOP had stopped it; recoverability
+		 * is unchanged versus the existing path (neither is
+		 * recoverable without hardware reset, since PSCI sees the
+		 * CPU as ALREADY_ON in both cases).
+		 */
+		cpu_park_loop();
+		/* unreachable */
+	}
+
 	/*
 	 * Both consumers no-op on a CPU that wasn't actually requested:
 	 * nmi_cpu_backtrace() unless this CPU's bit is set in the global
@@ -84,7 +151,7 @@ static int sdei_nmi_handler(u32 event, struct pt_regs *regs, void *arg)
 	 */
 	nmi_cpu_backtrace(regs);
 #ifdef CONFIG_HARDLOCKUP_DETECTOR_COUNTS_HRTIMER
-	watchdog_hardlockup_check(smp_processor_id(), regs);
+	watchdog_hardlockup_check(cpu, regs);
 #endif
 	return SDEI_EV_HANDLED;
 }
@@ -133,6 +200,74 @@ bool sdei_nmi_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
 	return true;
 }
 
+/*
+ * Last-resort half of arm64's crash_smp_send_stop() (see
+ * arch/arm64/kernel/smp.c). The caller runs the normal IPI / pseudo-NMI
+ * stop first; whatever is left in cpu_online_mask by the time we're
+ * called are the CPUs that didn't respond -- wedged with interrupts
+ * masked, unreachable by those paths. We snapshot that residual mask,
+ * set each survivor's per-CPU crash-stop request flag, signal event 0
+ * at it, and poll for acks. The handler captures crash_save_cpu() state
+ * and parks the CPU (without completing the SDEI event, see
+ * sdei_nmi_handler()).
+ *
+ * Because SDEI-stopped CPUs are less recoverable than normally-stopped
+ * ones, this is intentionally the fallback, not the first choice -- it
+ * only ever runs against CPUs the normal path already gave up on.
+ *
+ * Returns true when SDEI was active and this path ran (even if some CPU
+ * failed to ack within the timeout, or there were no survivors to stop);
+ * false when SDEI isn't active, leaving the caller's normal-path result
+ * as the final word.
+ */
+bool sdei_nmi_crash_smp_send_stop(void)
+{
+	unsigned int this_cpu, cpu, remaining;
+	unsigned long timeout;
+	cpumask_t mask;
+
+	if (!sdei_nmi_available)
+		return false;
+
+	this_cpu = smp_processor_id();
+	cpumask_copy(&mask, cpu_online_mask);
+	cpumask_clear_cpu(this_cpu, &mask);
+	if (cpumask_empty(&mask))
+		return true;
+
+	for_each_cpu(cpu, &mask) {
+		WRITE_ONCE(per_cpu(sdei_nmi_crash_stop_acked, cpu), 0);
+		WRITE_ONCE(per_cpu(sdei_nmi_crash_stop_requested, cpu), 1);
+	}
+	/* Publish flags before the SMCs read them on the target side. */
+	smp_wmb();
+
+	for_each_cpu(cpu, &mask)
+		sdei_nmi_fire(cpu);
+
+	/*
+	 * Poll up to 100ms -- same order as the kernel's existing pseudo-NMI
+	 * stop wait (10ms) plus headroom for the SDEI round-trip on slow
+	 * firmware.
+	 */
+	timeout = USEC_PER_MSEC * 100;
+	while (timeout--) {
+		remaining = 0;
+		for_each_cpu(cpu, &mask)
+			if (!READ_ONCE(per_cpu(sdei_nmi_crash_stop_acked, cpu)))
+				remaining++;
+		if (!remaining)
+			break;
+		udelay(1);
+	}
+
+	if (remaining)
+		pr_warn("crash_stop: %u CPU(s) did not ack within 100ms\n",
+			remaining);
+
+	return true;
+}
+
 #ifdef CONFIG_HARDLOCKUP_DETECTOR_COUNTS_HRTIMER
 
 /*
-- 
2.54.0


