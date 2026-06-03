Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F63ACD6E57
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 14:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OheaLw7H7tyd+BHT4gfjavgl+y762p06dYjTVkjAzDY=; b=k239r+heUu7FosirlqDuCJjqE0
	kgE8ZiMVy5MNYZAUDhVG1PmA4JshA1iz3QEQfJ63r9hcwgKmVNlRpvA461HcR5imvpwTvUQBRTUOA
	VF7yh3dawnnncTZ0ZBEErsNBDV13Hr4gfccLg4WsiXqnreQE2GkpcB8MFWK/PKOwAEWzJiUHhdMNW
	9yJeAHe3pVk482d3zUErr3dudk7Vo856UZe0+aEHuF5YD1gcAY5q7SkS3wQL0ZVrIDTWuCfljIPGX
	u01gGE/AazFvYVFYNSvunTFdlKaI9lmPKE+Ts0DTU/wQtMrvvSmUn+esAZgzFVZPPXQ8iYWb/CBz7
	AZmNMRlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUmi5-0000000FGKp-3cYX;
	Wed, 03 Jun 2026 14:36:45 +0000
Received: from fhigh-a3-smtp.messagingengine.com ([103.168.172.154])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUmi2-0000000FGJP-41EO;
	Wed, 03 Jun 2026 14:36:44 +0000
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 93D551400039;
	Wed,  3 Jun 2026 10:36:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 03 Jun 2026 10:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm2; t=1780497399; x=
	1780583799; bh=OheaLw7H7tyd+BHT4gfjavgl+y762p06dYjTVkjAzDY=; b=y
	4AAeLcIAosGZmFRwqCK+BBjoPCvgFztoAa/REVbkrNMIfAuLkEH78EnsBht8m31l
	but5YiHjaglwPi1vgIuCfsnCgwyN83xzn0ST0GPVuxIElFwKPCtnGQEQ/qlf1qlL
	jN/f0oWxLRHQKw2LQD1TkxRrXNcGj0oL96eGn8S4aBUgce4mQt98scVt2xfUyUZk
	PCUa1ij2/h/7JrNTlwPtJBCkXbCpm1+XIOG61k1g5zCR4DuTgnqVDWmD3NHjozok
	BrFP43Xh3jAu2n6EOMn7DRO7meKjxdtCglRnvL8JUSZeYG/tWtqdBBfnIj1SEbc6
	9+Ahir13QS7wObe7VaCeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1780497399; x=1780583799; bh=OheaLw7H7tyd+BHT4gfjavgl+y76
	2p06dYjTVkjAzDY=; b=bgq+9lWMzUqeoV/StyV5EF5K6IyJwPSS5iGHpLfM8jqY
	jjtDRJmSLqQ5fjB01J5AeC6TqouJVZ2VmS0W5oTs8k+HhLEx+G/28Nez143z700x
	rwa3eP/K3Knsjqm+nh9Ptgu88v0LvoagGatf8zRAHR4X/UraWtSGz7znJ2FgIcoP
	UiZkPNT04+YiX9Bs/qrVxZ/6KqwJIsyfZgaTqJOdmVjImnlAnuTBiVs5WvGlU7VV
	sV1p3NqSe3s8MOdjWkt6KtwntkUEpbMd3cTBWlw52Dr31AaxgnlxmHsgQMoH3KYU
	qlR4jE+WtbcUdSZyWVFgGb4UgKUvrClAF0pm/QK7iw==
X-ME-Sender: <xms:9jsgamsqxGc_zLR6x0jRwP5oUG1YCP1Xez1dLVg0IWm5wrdY0uHw-Q>
    <xme:9jsgaijIoREFdnJZ1z0UYLdRI_JF3BPuPPM1QpAmFIdUCNVLSa36LD2ZSWqUuEZZX
    kYLcSMTeDsI_JdQ1dlXzBPc6mC3juXy4bvBobj7RpidYH2iM9vJTeo>
X-ME-Received: <xmr:9jsgapdKYBrNhCAjTXgWejnYgtEr4mKzTb3cyeGIgvMZWDLNHMEnRhx7_N2eog>
X-ME-Proxy-Cause: dmFkZTEjTgKslv0txJe9JDV9s5+yYqMAlo5cbXDWY1lTzUDzhnWvj/qU7G7UOxyg05j+Lb
    i0XxANFqB6x9qiV8FthQDLuRhwNlS7tpzFo/9gUxilOqsEQfe2s6n1VYSLEJQ0/UE4NP43
    YO4HedeJYcbiNjEiUos07Q3L1EjJVZpKdtHupDxJYaxDbua5v5ltbPBfYN60b8y4dxsJLj
    jwWlAojK/8B+Jn6BciuPxDe+sSwkZd7BEjx0wZUMl9j26woj3+DEEMt9dy8F9Wg+zIPI55
    fT2kz8qpH3In3aqhKZI6vvVOXnromy3aY/9CEtJpAv8PjvowGt2dmmjhhpjS+yBpotwBlC
    JADGuVciFInm69iYjA3vk/0A1/28cQsqC4M/+kz1NSvd7JjT4VkNkh3cedDzzJnxWnQK8u
    +zQ6Q06RarEzXdQzQG8KoUhN683EvAx72MV0U9uFeLIU2jEaAZJbxhOeLLeaOKM7fLrkeo
    km0hyOtFQk82XA6R62eKq5CH9n5je3rQTgB8f+DCZF/qxuLOrBVNfkCpWNsnGsZFNQ0xnf
    KLaXv1BNIqf7Jg8nE2d2dTtcbfqCMH85Fvy/Fbzyv72HCRKivBJ41pOrJT+K9Z+mcpBd7h
    3ok+PGvUnIvZer1ls0a+gjFfPQrqIyexxYQ8Nk196IkvMssErrCgSF1AoDZQ
X-ME-Proxy: <xmx:9jsgankgRj0e2d5pDQPkvCnUpP-aTV70M4IXcI5r0g9ziKHN0bCmow>
    <xmx:9jsgajqXTnSeYHjPIst4y5HQOMK5vmCl11NBaZZzfba1YysZPoBVDw>
    <xmx:9jsgau8wnnQTxhpzBLljjzpbOjZFe_EfDjnwt3sJDRo7maCSXrNmtQ>
    <xmx:9jsgak2U1MBgkXhPIJElb69UYUrSHiT0odanaTcULteS-yhCoytYGQ>
    <xmx:9zsganQoyPODWFw1_A4CbIwtTZgkh0rXCbm0YP4uOeNKlh6PkSIc3HeV>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 10:36:38 -0400 (EDT)
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
Subject: [PATCH 0/4] arm64: cross-CPU NMI via SDEI
Date: Wed,  3 Jun 2026 15:36:31 +0100
Message-ID: <cover.1780496779.git.kas@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_073643_237087_9060D850 
X-CRM114-Status: GOOD (  18.65  )
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

A class of debug/observability features needs to interrupt a CPU that has
its interrupts locally masked: hard-lockup detection, the all-CPU
backtrace behind sysrq-l / RCU-stall / hung-task dumps, and
crash_smp_send_stop() capturing a stuck CPU's state into the vmcore. On
arm64 these need a mechanism that reaches a CPU spinning with DAIF masked,
which a normal IPI cannot.

arm64 has two such mechanisms today:

  - GICv3 pseudo-NMI (interrupt priority masking). This is the preferred
    path and what the perf-based hard-lockup detector
    (HAVE_HARDLOCKUP_DETECTOR_PERF) is built on. Its cost, however, is on
    the interrupt mask/unmask hot path: local_irq_enable() becomes an
    ICC_PMR_EL1 write plus a synchronising barrier, and exception
    entry/exit save and restore the PMR, paid on every CPU whether or not
    an NMI is ever delivered.

    In our measurements, enabling pseudo-NMI costs up to ~5% on real
    workloads, and ~66% on a syscall-in-a-loop microbenchmark that
    maximises exception entry/exit (where pseudo-NMI adds the PMR
    save/restore). A fleet-wide ~5% regression is not acceptable, so these
    systems run with pseudo-NMI disabled — and therefore have no
    hard-lockup detector and degraded backtrace/crash-stop today.

  - FEAT_NMI (Armv8.8) — the architectural fix, but absent from deployed
    silicon and from most of the fleet for years to come.

For deployments that do not run pseudo-NMI (to avoid that standing
hot-path cost), the hard-lockup detector and the backtrace/crash paths
are degraded: a plain IPI can't reach the masked CPU, so the lockup goes
undetected, the backtrace of the CPU you care about comes back empty, and
the kdump is missing the culprit's registers.

This series adds a third delivery backend that costs nothing on the hot
path: SDEI. Firmware delivers an SDEI event into a CPU regardless of its
DAIF state, so interrupt masking stays the cheap PSTATE.DAIF operation and
the firmware round-trip is paid only at the rare moment a CPU must be
interrupted.

Mechanism
=========

It uses the standard SDEI software-signalled event (event 0) and the
SDEI_EVENT_SIGNAL call (DEN0054) — a spec-defined cross-PE signal, not a
vendor extension. The driver registers a handler for event 0 and pokes a
target CPU with sdei_event_signal(0, target_mpidr); firmware makes event 0
pending on that PE and dispatches the handler NMI-like.

No firmware change is required beyond SDEI being enabled, which
firmware-first RAS (APEI/GHES) deployments already have; the only
SDEI-core addition is a thin sdei_event_signal() wrapper over the standard
call.

Clean kdump when a CPU panics from inside the SDEI handler (the
hard-lockup case) is handled by the already-merged sdei_handler_abort(),
which crash_smp_send_stop() calls: it issues SDEI_EVENT_COMPLETE_AND_RESUME
so the firmware-side priority is dropped before the capture kernel boots.

Prior SDEI watchdog work
========================

Out-of-tree SDEI hard-lockup watchdogs exist (e.g. in the openEuler and
Anolis kernels). They take a different mechanism: they bind the secure
physical timer as an SDEI event, so firmware delivers a periodic self-CPU
tick that drives the detector. That requires a new SDEI interrupt-binding
API, pushes the watchdog period (watchdog_thresh) into firmware, and adds
secure-timer EOI handling on the kexec path.

This series instead uses only the standard software-signalled event 0:
the kernel keeps the timing (a per-CPU hrtimer with a buddy heartbeat
check) and firmware does nothing but deliver the cross-CPU poke when a
buddy looks stalled. The result is a smaller, far less firmware-coupled
change — no secure-timer dependency, no new SDEI API, no period in
firmware — and the same delivery primitive serves the backtrace and
crash-stop users, not just the watchdog.

Testing
=======

Developed on QEMU (Trusted Firmware-A with SDEI enabled) and
validated on NVIDIA Grace (Neoverse V2) hardware, under
irqchip.gicv3_pseudo_nmi=0:

  - hard lockup (LKDTM) caught by the SDEI watchdog and panicked, with the
    stack pointing at the wedged code;
  - sysrq-l backtrace of an interrupt-masked CPU returning its real stack;
  - kdump via crash_smp_send_stop() with a wedged CPU, and via a watchdog
    panic from inside the event-0 handler — sdei_handler_abort() fires and
    the capture kernel boots to userspace on the formerly-wedged CPU, with
    its registers present in the vmcore.

Series
======

  [1/4] firmware: arm_sdei: add SDEI_EVENT_SIGNAL support
        Thin sdei_event_signal() wrapper over the standard call; NMI/crash
        safe (no locks).
  [2/4] drivers/firmware: add SDEI cross-CPU NMI service for arm64
        Register event 0; first user, arch_trigger_cpumask_backtrace().
  [3/4] arm64: wire SDEI NMI into the hardlockup watchdog
        HAVE_HARDLOCKUP_DETECTOR_ARCH backend; boot-time source selection
        with perf-NMI fallback.
  [4/4] arm64: route crash_smp_send_stop() last resort through SDEI
        SDEI as the final escalation rung for CPUs that ignored the normal
        and pseudo-NMI stop IPIs.

Also available at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git sdei-nmi

 arch/arm64/Kconfig            |   1 +
 arch/arm64/include/asm/nmi.h  |  30 ++
 arch/arm64/kernel/smp.c       |  33 +++
 drivers/firmware/Kconfig      |  23 ++
 drivers/firmware/Makefile     |   1 +
 drivers/firmware/arm_sdei.c   |  12 +
 drivers/firmware/sdei_nmi.c   | 523 ++++++++++++++++++++++++++++++++++
 include/linux/arm_sdei.h      |   6 +
 include/uapi/linux/arm_sdei.h |   1 +
 9 files changed, 630 insertions(+)
 create mode 100644 arch/arm64/include/asm/nmi.h
 create mode 100644 drivers/firmware/sdei_nmi.c


base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
-- 
2.54.0


