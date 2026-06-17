Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9534ACD98F2
	for <kexec@archiver.kernel.org>; Wed, 17 Jun 2026 19:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OlVIi7ddH8QmGDJ7z3+8Jw4XgpohGlr2j30gMpXn7Kc=; b=PqaB04jOzIq/4/5vsaVdWuUy6m
	8rRrQ3cDScSBKEZH89AH0xzUUId1tpyEiSNG7lXcffVh9++zTkKNg4ScAISeInVj8CghfMtPtn2e5
	k0X3czaQwOJZrUYb4N1tsRUaQILQTJ/hJEnMHDd56CEX8YrvcnTS+q+W0PPCs6k/nFLL1M9r0yMzZ
	DnJLzjCI6GYVcCRMKfd6y8jmnWpiADrzlth/7v5okeOlpqoxFn106T/BTkcY/Pj7ww9065taW+dA3
	EIEhwpgGH5V0iQbaTKjiaOepu9PPGiyGFxBNN1Y2Kvc8p730TC9AAmTKku14b5BUlxw4+DLUEc58p
	bgHkaZ2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZvo9-00000000FRf-0I5e;
	Wed, 17 Jun 2026 19:20:17 +0000
Received: from fout-b6-smtp.messagingengine.com ([202.12.124.149])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZvo5-00000000FQu-2G36;
	Wed, 17 Jun 2026 19:20:15 +0000
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 840791D00107;
	Wed, 17 Jun 2026 15:20:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 17 Jun 2026 15:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1781724011; x=1781810411; bh=OlVIi7ddH8
	QmGDJ7z3+8Jw4XgpohGlr2j30gMpXn7Kc=; b=kRiyaJmsczny1Y/iinnTFjHI7u
	PPvoUa5jV4RFXOrcwDN+GuGT7VgI9z4qkVjSByjNSXuh6HEwNLYaN3m0eooFEY1N
	DNfeFe8v6mJzGzUAufORVjlUdoZm9mhMLcKhvornUNW0g+Er2y62hzO8q2H2gHHL
	MyF6eZUfKmV2pyJZjpu3Wx2tj1d4Tr+Y6MRnCC6JXU3io5S3f2o3GiC17z1MzGXy
	T2j4Az8DNMNdvIDb1zy6SIC4u9FkP8CbDt2pIcKqVBkSDHO4RpAl3Zx8OAv1Qmzz
	sVq4N3qKvuW7t6n4KSi20itHBuNjPXHu4h3X2H7h3jtk+WQPcJtsK78lw4Xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781724011; x=1781810411; bh=OlVIi7ddH8QmGDJ7z3+8Jw4XgpohGlr2j30
	gMpXn7Kc=; b=i//1JeLD/zGsDOkeP77+1Pl6nsV5pb53Pwd7YP+z38qXm/5FDkL
	AElupERhSyKIrh66nLLdw6I2TUQ15EhuOftuLi4YZJvo8/s1Nj3kVkUnE1X7xYfL
	VOo6UUriU3PYmpFMUBIqAr2PA6Pq6WLLrN5rqdXt3CJlBPyWlZrUw2QHyP0vOLGm
	lHF2kc7bNU3/hEHgg2FdzRR4oDI7PiJYkJWe4Rp/BijIAohW4P2tgl3yjNcjFgrP
	WOaBpPbHvJ6pSSO7vb+cs7aCXN12eMlapjOQvqte/zuh5TZ/wCuxcbhgWv/LPb0w
	MDkDGb8JCkTMkqBkIB+W+XasnqXQPc14fww==
X-ME-Sender: <xms:avMyavXv-anNbjY7Bf2z-sT_KKLzdkJzLL6wScIBMijblBd9ZOs9Zg>
    <xme:avMyaurfOFnLyrOASpd118_11RFyqtutdWr2DlWWFUfJHf14TdSm709kmMNIAG2KT
    Tt9oI5plhIBK2cEMNk5BC3hlbyZcCSw1IGpWoDh-4MazV9l4Y2Oxnw>
X-ME-Received: <xmr:avMyajG05XcjCjJjxALWIahumpLqiItr4N4uMURUUDZfgYvHyBWv8axK8TjofQ>
X-ME-Proxy-Cause: dmFkZTGVV4tyl5QYmKynoq66eUcolKtdXYw45zU/PuYRtNdbxjtzboFNQTiJmiIHfSx2MI
    DALptJg5Omhwt1mdglHePEvKRZjA2GxPppYpvijUsLJm5TihW5/Y8q/v7UVJoiZxPVKW7M
    h3rgvb81JvX6Hfo/pOo9HOC0hNJFyAB0yBfxSoqakxS4QP2GODw0yPyxIqT6zknTaUI2N0
    x/0F3TAMGMoDgJlGDv11FultSe1CZksLHABxFhGV/upC+GEHM4A7Q+oFDc5h07dlfuQhRI
    JdTUrTZ7xyK4Oh2LhQ9riwaOWzZJ9JvNN8t8G7pHIxqrtBlxUfOMOf+h7gzep0Mb16ojiN
    /J85ahvIb5wqm7KSg4EyfB2+R1yX/TLj1VH9FQlmFv9AYJgq9zAUymqY6+kch6POWdNs7l
    FdYGS2QNpVKL4ZEMhAKcqMmbnEzfjv5AHcyCOXjFUNNxIUqHxMRfKq0vtvwMRLDpBbTZGD
    MWH4LRrwzewx1S4grxvm1SPcmlr5D5l79Ci8wN2Z58whI/As6BRo4Hc8DvUGBR5uQsjj0k
    fg3XSgH7tW87q5YLFJDkZxYNLck2t14qxEL2rMs8XLTnueI9MKtR7s5NLlLmr1K8PzlkHE
    FjYN6aAU3jql/Ak3l8MC3JgTers+MBCRfg3iQrSHI0M+tL0fUSQzKhKuRzZQ
X-ME-Proxy: <xmx:avMyagtz7NEWkwrHoDOO3ir_Q0ASyu0rYsYI48tLiJ8wKQUZHGkz7A>
    <xmx:avMyamTr5ufKqsl1GGkZTivfh_akhEPaCJrf-0-UWnCOElmpzfYvPg>
    <xmx:avMyatHCz4qxnUw2-V_akx3g6P4ISMQOWFKa3nHBAkBtig4RZKrSdA>
    <xmx:avMyaoe9WDWHtlBZrYjMOxdPjKqgdPj9emvMtMKczSUl2zUrsbdUrA>
    <xmx:a_Myatwahiy3s9qQ23td3DuLK7Rwrob89H0Zp4S1Ls8cyfb-7J7MG2Y4>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 15:20:10 -0400 (EDT)
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
Subject: [PATCH v4 0/4] arm64: cross-CPU NMI via SDEI
Date: Wed, 17 Jun 2026 20:20:01 +0100
Message-ID: <cover.1781709543.git.kas@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260617_122013_846362_43CF3D23 
X-CRM114-Status: GOOD (  25.69  )
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
its interrupts locally masked: the all-CPU backtrace behind sysrq-l /
RCU-stall / hung-task / hard-lockup dumps, and crash_smp_send_stop()
capturing a stuck CPU's state into the vmcore. On arm64 these need a
mechanism that reaches a CPU spinning with DAIF masked, which a normal IPI
cannot.

arm64 has two such mechanisms today:

  - GICv3 pseudo-NMI (interrupt priority masking). Its cost is on the
    interrupt mask/unmask hot path: local_irq_enable() becomes an
    ICC_PMR_EL1 write plus a synchronising barrier, and exception
    entry/exit save and restore the PMR, paid on every CPU whether or not
    an NMI is ever delivered. In our measurements, enabling pseudo-NMI
    costs up to ~5% on real workloads, and ~66% on a syscall-in-a-loop
    microbenchmark. A fleet-wide ~5% regression is not acceptable, so
    these systems run with pseudo-NMI disabled.

  - FEAT_NMI (Armv8.8) -- the architectural fix, but absent from deployed
    silicon and from most of the fleet for years to come.

For deployments that do not run pseudo-NMI, the backtrace and crash paths
are degraded: a plain IPI can't reach the masked CPU, so the backtrace of
the CPU you care about comes back empty and the kdump is missing the
culprit's registers. The hard-lockup detector on these systems is the
software buddy detector (HARDLOCKUP_DETECTOR_BUDDY): it detects a stall
from a neighbour CPU, but it cannot itself interrupt the wedged CPU, so
its report has no stack for the culprit and (with hardlockup_panic) the
panic runs on the bystander.

This series adds a third delivery backend that costs nothing on the hot
path: SDEI. Firmware delivers an SDEI event into a CPU regardless of its
DAIF state, so interrupt masking stays the cheap PSTATE.DAIF operation and
the firmware round-trip is paid only at the rare moment a CPU must be
interrupted.

It does not add a hard-lockup detector. Detection stays with the buddy
detector (CONFIG_HARDLOCKUP_DETECTOR_PREFER_BUDDY); this series gives the
backtrace and crash-stop paths -- including the buddy detector's
backtrace of the stalled CPU -- a way to actually reach a masked CPU.

Mechanism
=========

It uses the standard SDEI software-signalled event (event 0) and the
SDEI_EVENT_SIGNAL call (DEN0054) -- a spec-defined cross-PE signal, not a
vendor extension. The driver registers a handler for event 0 and pokes a
target CPU with sdei_event_signal(0, target_mpidr); firmware makes event 0
pending on that PE and dispatches the handler NMI-like.

No firmware change is required beyond SDEI being enabled, which
firmware-first RAS (APEI/GHES) deployments already have; the only
SDEI-core addition is a thin sdei_event_signal() wrapper over the standard
call.

Prior SDEI watchdog work
========================

Out-of-tree SDEI hard-lockup watchdogs exist (e.g. in the openEuler and
Anolis kernels). They bind the secure physical timer as an SDEI event, so
firmware delivers a periodic self-CPU tick that drives a detector. That
requires a new SDEI interrupt-binding API, pushes the watchdog period into
firmware, and adds secure-timer EOI handling on the kexec path. This
series instead uses only the standard software-signalled event 0, keeps
all timing in the kernel (the buddy detector), and the same delivery
primitive serves the backtrace and crash-stop users, not just lockup
reporting.

Not included / follow-ups
=========================

  - No SDEI hard-lockup-detector backend. v1 had one; it is dropped here.
    The buddy detector plus this series' backtrace already cover the
    no-pseudo-NMI case, and a dedicated SDEI backend duplicated the
    perf-NMI detector it had to compile-exclude. Run PREFER_BUDDY.

  - A CPU stopped by the SDEI rung is parked, not powered off via PSCI
    CPU_OFF. Reaching and dumping the wedged CPU -- the point of the
    series -- works, and it matches the shared stop path's own park
    fallback when CPU_OFF is unavailable. The consequence is that an SMP
    crash-capture kernel cannot re-online such a CPU (it stays "already
    on"); the capture kernel boots and runs on the remaining CPUs.
    Powering the stopped CPU off so a capture kernel can reclaim it
    requires completing the SDEI event and then CPU_OFF, which hit a
    firmware-specific issue still under investigation; it is left as a
    follow-up and does not affect the dump's contents.

Testing
=======

Developed on QEMU 'virt' (Trusted Firmware-A with SDEI enabled) and
validated on NVIDIA Grace (Neoverse V2) hardware, under
irqchip.gicv3_pseudo_nmi=0 with HARDLOCKUP_DETECTOR_PREFER_BUDDY=y:

  - sysrq-l backtrace of an interrupt-masked CPU returns its real stack,
    pstate showing DAIF set -- proof SDEI delivered into the masked CPU;
  - buddy detector catches a hard lockup (LKDTM) and the wedged CPU's
    stack is fetched via the SDEI backtrace;
  - reboot/halt and the panic/kdump crash stop reach a wedged CPU via the
    SDEI rung ("SMP: retry stop with SDEI NMI for CPUs N"), and the kdump
    captures the wedged CPU's registers in the vmcore;
  - with SDEI absent (plain QEMU 'virt', no firmware support) the driver
    stays inert: no event registration and no boot-time warning.

Changes since v3
================

  - New sdei_is_present() patch; the NMI initcall now skips registration
    (and its boot warning) on non-SDEI systems (Puranjay Mohan).
  - Fixed a NULL deref on a parallel-panic crash stop and the
    CONFIG_KEXEC_CORE=n build (Puranjay Mohan).
  - kernel-doc + barrier comments on the stop path; reordered the two
    arm_sdei core patches (Doug Anderson).

Changes since v2
================

  - Unified the CPU-stop paths into one arm64_nmi_cpu_stop(regs,
    die_on_crash), dropping local_cpu_stop()/ipi_cpu_crash_stop().
  - SDEI rung tests sdei_nmi_active() first; sdei_nmi_stop_cpus() is void.
  - Replaced the per-CPU stop cpumask with a write-once flag.
  - Commented the SDEI-park / no-CPU_OFF rationale.

Changes since v1
================

  - Dropped the SDEI hard-lockup-detector patch; use the buddy detector.
  - Reworked crash-stop into a third rung of smp_send_stop().
  - Renamed the driver to arm_sdei_nmi.c; widened the MAINTAINERS glob.

v3: https://lore.kernel.org/all/cover.1781490440.git.kas@kernel.org
v2: https://lore.kernel.org/all/cover.1781082212.git.kas@kernel.org
v1: https://lore.kernel.org/all/cover.1780496779.git.kas@kernel.org

Also available at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git sdei-nmi/v4

Kiryl Shutsemau (Meta) (4):
  firmware: arm_sdei: add sdei_is_present()
  firmware: arm_sdei: add SDEI_EVENT_SIGNAL support
  drivers/firmware: add SDEI cross-CPU NMI service for arm64
  arm64: escalate smp_send_stop() to an SDEI NMI as a last resort

 MAINTAINERS                     |   2 +-
 arch/arm64/include/asm/nmi.h    |  48 +++++++
 arch/arm64/kernel/smp.c         | 124 ++++++++++++-----
 drivers/firmware/Kconfig        |  21 +++
 drivers/firmware/Makefile       |   1 +
 drivers/firmware/arm_sdei.c     |  22 +++
 drivers/firmware/arm_sdei_nmi.c | 238 ++++++++++++++++++++++++++++++++
 include/linux/arm_sdei.h        |   9 ++
 include/uapi/linux/arm_sdei.h   |   1 +
 9 files changed, 427 insertions(+), 39 deletions(-)
 create mode 100644 arch/arm64/include/asm/nmi.h
 create mode 100644 drivers/firmware/arm_sdei_nmi.c


base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
--
2.54.0

